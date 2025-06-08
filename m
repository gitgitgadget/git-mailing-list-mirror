Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF6A92E
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749347171; cv=none; b=QxogZQu7sK9AVnbL8oT0TC6ZvMAN7LSj2A/pm+C+z3XTe0G+H8qRr9j+MORicO+f/dQLM41XF0wanU4HQ/ov+cSBrCOJn0v2hJN2QbGtIJPcSi6e69GPcWBMePFiWJtM4w8z71/ZWidKtpuZzTCkoeKo39F93L98tAe2b4JIZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749347171; c=relaxed/simple;
	bh=qYMxnkIvEohOAXef6TPs8yqm20snUPlUwmLoiLsI3DM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j+NziJItyeaBu6jp/HLJB33pUcvU3/jxvt5FKijAU0HawqfyszWRTdiK+2Z4dSk7g3wIsV3vbh9LYuJzzLj9bjT6l+NQg8P+FveOTUiWOXBiIincq65YmVaO58qNn6HhzrUvWLixvQXBhi3KC7Nq9RHdtBueZfDnxwRv1wiII2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S63x73Mg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S63x73Mg"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso2637357b3a.2
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 18:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749347169; x=1749951969; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYzfIXNC1jA3U1oUwkhPYg1mBFBDze04xhhy4Xbj6mU=;
        b=S63x73MgTzgIOdh+2lsTfBfnPfRb/zcz0WmGyvsFw2qMDwpNm/ad/+jxtwCifGFtVL
         Ryzz3b2PAFWz+pGaPPKYssR2ExzU54cPlFthAtpoGC8aJPz4w+Qz+1ZPEzuunGmsmc2+
         5V7b4tTxNxLWNusqsN9TnVhUdd32sJtsO0bN04k+SPsPhlfNFGLT6BZAKp6UaE86vYAN
         RBUSqLQJ5tcHE5YK6Phcta3nNUlVX6v874PLS0WwPMPiiJ55eSJaS96zPVE49GiYMZMA
         wYG5kb61j9fnrC7xMfRkxprVRhSPPMWE4JIZ+HcChrYKfwfZVljpalb/FtUIYnb5Pmgb
         xE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749347169; x=1749951969;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYzfIXNC1jA3U1oUwkhPYg1mBFBDze04xhhy4Xbj6mU=;
        b=HtexRmymoXnpEbam13b5/9eNAm9LCQuz2iR4+X8op+Qf+fCBdIh4GQGPm71PLF2Or/
         +KwBNDQ/aH8IrnQMpX2FMIkvATSJ81VAHNB62KC69WWJGPckLqcWxFhNtQoFrxBLJaOS
         hwsbipDoiqjEl7fgPKTQ0SDkoW4fcwAEl8Lwra7O6mq/7E6XINb90LSS3a/0g8S1I7y1
         36NB14RRIQXNiCtmX77AM2qQFxr/qWQkKrv7gtx+JqyVEt/sbgs93q8dpklxVzRsYL9m
         qegjj5FwoUraeQK8STc1ixhZbXVqEcfRHaNH0haFErbzggkdI0ul+ME2Y9GiRPBIsiCF
         ym0w==
X-Gm-Message-State: AOJu0Yy0miaIOE4Xu0heiyIVZgs4Pr19u+n7I55rrTuliORfqpvO5k3t
	llWnA1KgXihn8T5XF3l9xgdofBfg1zZBQu3iSK7PKKCuSk1m/EiggOoEMnvMOw==
X-Gm-Gg: ASbGncsnMcsfo0fEx5r4aGv+OSy+cUfvran7JJAolQIMaT88aMyH9uPNTAuszhFIqAx
	/GixXJWQQJyWMTxNKTCPfs4iVZ88Ujh6RRVxZ4ahpZCMYzKmBqBUJkcOpEv5ouHaoahiGXdmH0M
	u55tbp6NLpJ1QRBkxlRDJvoCzp5ba5/jmTBIt8TMDyI7RIszjQCAH/a3SxJpoBMpNRYvkbFnGn/
	EijpBqc9rhdmrmNp3Lt4b8II5+5ftnWLgNHy9IQgE4UDpcHr8Hv6ugaRnxfLI77Miy8fS95v7Uz
	d6dVkX2EWlLUFg/YI/b6Gq1UgEK5VKc=
X-Google-Smtp-Source: AGHT+IFMGjGDmC4IhClnnnNzVIYsaDkwSmi+6dx13v1liww7PM2mubTR5iWYxOxf11phaSfPDi+uRQ==
X-Received: by 2002:a05:6a21:200f:b0:21f:53a9:b72c with SMTP id adf61e73a8af0-21f53a9b912mr2171183637.38.1749347168993;
        Sat, 07 Jun 2025 18:46:08 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::f55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0e9d57sm3305795b3a.160.2025.06.07.18.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 18:46:08 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: update settings for Solaris 10 and 11
In-Reply-To: <aETm3O-FE7EpyoE5@humpty.home.comstyle.com>
References: <aETm3O-FE7EpyoE5@humpty.home.comstyle.com>
Date: Sat, 07 Jun 2025 18:46:07 -0700
Message-ID: <87cybfhuow.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brad Smith <brad@comstyle.com> writes:

> Solaris 10 and newer has strtoumax().
>
> Solaris 11 and newer has mkdtemp(), memmem(), and strcasestr().
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  config.mak.uname | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)

These versions look correct based on what we have documented in Gnulib.

Just to be safe I built git with this patch applied on Solaris 10 and
Solaris 11.3 and ran into no issues.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>
Tested-by: Collin Funk <collin.funk1@gmail.com>

Thanks,
Collin
