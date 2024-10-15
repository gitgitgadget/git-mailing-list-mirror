Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C621E3D9
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036401; cv=none; b=JKuNumg6TtTlBxgeDrQbCNCBFi8cka2k3QH1V98vsSDmJy+OsaGFZ6ffJoNmg8tnifvcw1K9yCGZN42m+daotAi9xrIA2LZvuur1tdiffGFJWeYx8PmWifDPcNTE2stE8wvrfUgP+CgjWqHLZfql1DRc59XMU5lyQ5SxVpgtGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036401; c=relaxed/simple;
	bh=2jrcxZjYGy8sgjENArLecMS8piik6ZFqMn+CF9yyL6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA4b+FBQ6hVHvUnpeevgEOo30wS9Ze/kmJgAHXZnCZKdHi6Z11sPVSyZEm/CI8vNrq5k9ws+PbWjjvDsX0ZDV46QdXVwqdJNbJxj8sCtM8G7EAEtNJqKDTZ+w/hCPe5EXBG95ZxgIchFxBoP/TWlSjGQyHcDj4PFGln2MpjUrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ff2Oayvm; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ff2Oayvm"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2972abc807so1078429276.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729036399; x=1729641199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZLlmee3ProURbkuHxCp6Sr2YDoQZnLi9Xe9who7888=;
        b=Ff2Oayvmq0UHLyGCJYrp/orsCgV3PFQC//Ai3cz0QuUfRVLv1O7uPn1XcuHVipeiRG
         bKzZcB4mX+rLzjvE5ErlIsjU/GthiZlwDurVqM058PMZljHEN3t6fE3nDlGnugqmpPq2
         lIwSxGqoZ4Kw0oQ2wcHGwpGl6PgtWWa85uzoT3JJf6DmLoF01ULuQ0DAx/6REIu7ay39
         w2Iknv5dSZpdB2iGEoWXG4rnjKRTTY5xX2QcInqvF1/9i1p+OlECslTnh5eWhkvgQyLv
         NcNt16Dq1IXVhWRDNf1oQ3JSnpDueS2ze/Na20/9VWx9gE0Rr39JRKmritLEn+tz0j99
         pa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729036399; x=1729641199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZLlmee3ProURbkuHxCp6Sr2YDoQZnLi9Xe9who7888=;
        b=WeEPLL+oEU/ryhWL+isDjUeztPawy2ioz0lFc4Dpylfuypla+/u+gj+2xVU352h3m5
         +PMsLU0EkUrrN8LMmomBNHSEKccq4gWhIMXvdUM7bNmcs/HgL0JpSBgNc5Qz6GooYJEN
         w+QGMRGFiMioj0FP9E4knvKUX47+EPS5PwIk51Q9XUaQv6bMUlS7y0XHi2qb8ah44Bw5
         d9JJVwhWgLKV/5NxpxONltQusek24QnJHJeG9wYaXeRuLTApRxgtjZEM5PXfa3JnDSbn
         S3/yPz5r2CKBDAVKRVvPgOEd7RTQvMLCcpdpuwvv9xOZqMnnEhN1ABdAFMVpQ/jaKFiu
         mJ/g==
X-Gm-Message-State: AOJu0Ywb8pvl+VI6Bz1Id/PmbSB8sFilrEcLdIJm2+61Y07Zeq4DshO0
	l/eoTmijHi5Y7pJ5eS4hVrSHOa4Fg2MNH0JjUzyJt/RMLf87r+VROAUyYgqiCBM=
X-Google-Smtp-Source: AGHT+IFIRRkhDqwR78Uy+wUzGfgLYsPU42o2TpchjSTgdPMlaUxeuVkERTxwGHFDNbLh87b1e37/kA==
X-Received: by 2002:a05:6902:15c5:b0:e29:41af:e1a with SMTP id 3f1490d57ef6-e29782b77f5mr2346055276.4.1729036399180;
        Tue, 15 Oct 2024 16:53:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfb8c5sm403522276.3.2024.10.15.16.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 16:53:18 -0700 (PDT)
Date: Tue, 15 Oct 2024 19:53:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/10] t/test-lib: wire up NO_ICONV prerequisite
Message-ID: <Zw8AaF4VOaQO+P2M@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <f6a8582c34a7b77aa3e2e45298208050333c384a.1728992306.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6a8582c34a7b77aa3e2e45298208050333c384a.1728992306.git.ps@pks.im>

On Tue, Oct 15, 2024 at 01:45:11PM +0200, Patrick Steinhardt wrote:
> Further note that there are several "!MINGW" conditions in t4201, and
> all of these fail due to iconv-related errors. This is quite likely a
> leftover from times before dce7d29551 (msvc: support building Git using
> MS Visual C++, 2019-06-25), which switched Windows-based builds over
> from "NO_ICONV=YesPlease" to "NEEDS_LIBICONV=YesPlease". Consequently,
> adapt those tests to also use the new ICONV prerequisite.

This appears to break CI on Windows when I merged this into 'jch':

    https://github.com/ttaylorr/git/actions/runs/11355564982/job/31585450667

I'm going to temporarily eject this from 'jch' and 'seen' until we can
properly deal with this.

Thanks,
Taylor
