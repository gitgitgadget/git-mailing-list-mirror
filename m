Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6549D1E877
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785823; cv=none; b=arv9A0LQV9QvKL5Z9hyW2Vvs4VINIAUekDL7isPUIcpYtNppzwzyMjhApUpmg6nvJ7UmtI06KycdSnOekoeCkb4yZu+xYhKctlajOGbQA3Eu5saEAjSbIlA967jAuk7E97Zsa6Sr6cXvIbqMT3OPi81yWJROVkdoJWnxjrl7YWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785823; c=relaxed/simple;
	bh=J+//8n/ic/Y/rvUQ1jIJreMqTkeTfspatBTsK/A8p/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsfC2AfUhjcPmJAxsLAVPn2/c1HZwl5dA3sBJhhKgw4N3jm7lXQr7UeCwkbYylgwkAjjoVoCfMRWRxHox2v8LL9wzhdihflCDYCBam7hVyvgiZ1MyDBIuihK/V08ab3fc8xVggWntw3dYpvuTtCOOtJtn/ilxj73Ca7JL2h4N2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMnkZGcx; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMnkZGcx"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4f608432bso5162308eaf.2
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 14:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712785821; x=1713390621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg71LeUUi2p5g7/Um7CNgdqk3915UpZx/IxuVRUgsVw=;
        b=RMnkZGcxBWPx9+Rw1dhe48cU7S/GTB7nWxaqqVTn0sBUYBIm8S5bX/NfHHOqbD5IHX
         gM47tghzcNS4l3yT7eAxlYk7id3584+RE+XJ/6hnr7h9/Mzq2f0ImdgEllNwJfjz5A/K
         vaYJq4y9Xnl0JC1BcSfltOOtbOL9z9Jhin+xISxNKMQTuAxyUvY+Td5snP+3lpQfWPow
         SoM4wX1O3qyvM78tgMgLurySiVoJaookNnPteZIJWsuhMqsHPVo6PcfZFjUac4hoW2tn
         sFBvKuiYAobPYhNUl0LUaKTL8VMxuKcWRoQkPIfDLgpjqFg8YOIYAQV/n9SUp3DwT5PP
         coqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712785821; x=1713390621;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg71LeUUi2p5g7/Um7CNgdqk3915UpZx/IxuVRUgsVw=;
        b=QCyc2G9X4OrlQ1vJ/qKvDO5a/XXSu/cBYpbcEMIMdVBWDeXR5200Kj+Xvjm6ABiW4L
         YTzo7lQ582jgZkWEZe2nDwzAQfpygGlRX3pWjK9wcncQvzPP6OTObKSoUWTl2kNuTFp7
         q8wqEhhi/B65nuIEmzn3X66Rl4IeOOfRsDtrFgVtMJtte2Ms2n1WD3BmQIb8II/OFKRD
         ZhchSJmUKclcvynJj5oWqTts6oVgcCkt2PoHdXATgG2hEC7X6dx5cqY48BBORmC/18C0
         Nyu3AfyrKCMPbLTmw4Wb+0/AmV1PGgVqh63hOtjPz23zMR65WDVlQJCAi7WcTp1ke7Jq
         ZtKg==
X-Gm-Message-State: AOJu0Yy3aJAis59eQvlJ49SW62DhbGdVTD5otupRumhvExXmcSWABHY2
	juwwBbH8iMoc25W89qXhUdESW4j0snVi07+iAJkBCT9iUq36hgHqjKmCGhAz
X-Google-Smtp-Source: AGHT+IGgsn5tDXVtatUBBr2RWxaRUR9Bpyd01naRp83alk9n4SZBmKcso0FQNsCxeRx3DcAFfi1xkQ==
X-Received: by 2002:a05:6820:1e0e:b0:5a7:c784:bfd0 with SMTP id dh14-20020a0568201e0e00b005a7c784bfd0mr4283740oob.0.1712785821368;
        Wed, 10 Apr 2024 14:50:21 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id e13-20020a4a9b4d000000b005a5521a2c0dsm38285ook.44.2024.04.10.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:50:20 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:49:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] t0610: fix umask tests
Message-ID: <zmr3qstsa3egnt7qi3pvaonltk4aoqr3x3vzch7esqjj7vuyj7@vbxldlnl6h4k>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Luca Milanesio <luca.milanesio@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Junio C Hamano <gitster@pobox.com>
References: <xmqqle5n2sbf.fsf@gitster.g>
 <cover.1712656576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712656576.git.ps@pks.im>

On 24/04/09 11:57AM, Patrick Steinhardt wrote:
> Hi,
> 
> these patches address the issue reported by Junio where running t0610
> with an umask of 0027 breaks some tests. The root cause of this is quite
> simple: we executed git-pack-refs(1) outside of the shell that had the
> modified umask, and thus we ran tests with the umask of the host shell
> by accident.
> 
> The series fixes this issue and extends the tests to exercise more
> umasks than just 002 and 022, which would have caught the issue earlier.
> 
> Patrick
> 
> Patrick Steinhardt (2):
>   t0610: make `--shared=` tests reusable
>   t0610: execute git-pack-refs(1) with specified umask
> 
>  t/t0610-reftable-basics.sh | 67 ++++++++++++++++++++++----------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
> 
> -- 
> 2.44.GIT
> 

Nice fix! I like how the tests were made more extensible too. This looks
good to me :)

-Justin

