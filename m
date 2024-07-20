Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05A5A4E9
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721515163; cv=none; b=misDfjLOKbD/reebyyyfP4ynTE1MYI3F6wIhCdWNDJ7C6h78KMQWuZFA4FtDWpSF0JlZLRnL431g2eLPJoGnuRPqo98m8LQASZCTjJw1QfmRJ1uDPIYs71BqtKC4yYO50TQ5U9uvGIZa/Fd6CR0EQ6Hx6os9PVCFxvE3nLjUtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721515163; c=relaxed/simple;
	bh=OpDvLVnieJ5LExrJ+9MeNWIacQ2xJ1PnxxT4u0ew8aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzSCIgV50TCyJoPzEeazNNsvJEn4TPZaIyqW5vfNWN9EbFNBy8LWXI7JfV4ifpR97xC/P/PwOrl5m+/cDTX2mu1Wp9eSPxGf6K0jziNZmyRBMUVAorqCL1zWdKP+w+n/ovsO293jWbaNn8Op70WFX6ga1lLqmeob2v79GKI5RaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN022S8L; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN022S8L"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368440b073bso1230267f8f.0
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721515160; x=1722119960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCwI3ecV6Rhq03WfnViPr6dLZM2vbURNnJeesFq36ro=;
        b=AN022S8LC/LogS+N3TT2GMI4z156MsxG+cVkQWRStaNzjRbxouOp8VDG2A+5DVKFX6
         3Nm6fHBbJS34FRpX77KVRLYVysILitaxeNFRGlWWneUjjlqswIpW/GqH1g00KbbNLpr/
         2fhmkIABxx7wlgrzmbkgRIKN4M4VZtAo/kCKgqSX1PSComGWjNB6NU1angdkJG7XazEV
         d44NrEX783skZ/edyf8Qc+sviDS0mt9urc+iqo2vyhEeVYsVN0+vniMrykeLMp/La40V
         DDMdYy92oElUjz4GL8sIR2p+CsKnKNo6D4JH7LXagAy1jbf2n2uBzRBKb4JIV9RGxLoM
         lE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721515160; x=1722119960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCwI3ecV6Rhq03WfnViPr6dLZM2vbURNnJeesFq36ro=;
        b=qT9aEcrY4fHOC7qnV9khCsOX2PsKS/9GcEEzFF7sNUzQwbSZyxlQIsHWxhcwdr7Rlg
         JPSlB/c4IN/ElrE11ANcDCICUCFldv6fmaObvuBQExAYzs7SPy8W++BNEuKy4HqopFVL
         du/SZCZ9aoz0LED9h2PNyf19lBH9zDqXtTtHxfspcM0hX7JNw19gHUkBYMgPEZulFneb
         8frANITlTTJduEEsJBanl/htZ3BXerH5CYy67BaPvKQdHbl8EqVH09C7tKLGTzSI2rIT
         crGknXh+Apzb88x5pEIppMI0AujPRJzpM41dR7t5WxprBm1vMsyX+uzClLVAA2T7YNcX
         wzFA==
X-Gm-Message-State: AOJu0Yxcu3iO0bltnGODIx0EnVcjGsCHH6WRQ65z5k+Nu9+2a+aJBOoy
	xGp85FtM3PqZkwIO2lvGxGKdgv8dNdnVY26wzSX8YCrvU2G2XGZ8
X-Google-Smtp-Source: AGHT+IGksv9udmUPtUDU7hqGfDFKKk7Z+OKt425iKKAU1DfxJ7jCjixFQS4qhp4vGuFPd4hZ5IjGFg==
X-Received: by 2002:adf:e682:0:b0:361:e909:60c3 with SMTP id ffacd0b85a97d-36873ecc9a7mr4483597f8f.9.1721515160463;
        Sat, 20 Jul 2024 15:39:20 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868aa6esm4685465f8f.26.2024.07.20.15.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 15:39:20 -0700 (PDT)
Message-ID: <702a80da-e5b2-428a-b91d-8cd1cd897fd7@gmail.com>
Date: Sun, 21 Jul 2024 00:39:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>, phillip.wood123@gmail.com
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com> <xmqqy15zzror.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqy15zzror.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jul 17, 2024 at 01:31:16PM -0700, Junio C Hamano wrote:

> >> -	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
> >> +	test_write_lines P q |
> >> +	(
> >> +		GIT_PAGER="head -n 1" &&
> >> +		export GIT_PAGER &&
> >> +		test_terminal git add -p >actual
> >> +	)

> I wonder if it still works if ">actual" gets removed.

Yes, it works.  That redirection is just noise from my previous version.
