Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CC1B3B08
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946431; cv=none; b=aeJowXBQ3mVtTd6jfJrCMv2otiXdjabs5JS1uiaJFpFhw7+BAXSHlcHxpoq+kGPMEmIYYOU4mt8Tl2gvMh6RBHp4rMVo6JGvd9JjdeZC45PZ47+M060QQuRg4xGw2iD212r4eaFzaCrIv2ABEi9WrHWgS2SImMrSqENkACQsCck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946431; c=relaxed/simple;
	bh=ZO31ubHt9mBJ2EULo+Nz9kS39JEuALOkXntyFMZh1gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkSGhsYporJButdPjbkOytLyYmOETmuc4h5dmo9G58ZBlQk8mD/50u9/TJHyNVXZjzaU6UJkhdTCk0BPijJ7GTvwvDS6QhPF4vKbe1tlcVbtbA9k9PRuBqTDxQ6JhVfYqya4g54oCsp32ZURxXNZey7J5fTLHupqq2zyvS5qfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk7parMj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk7parMj"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so541773a12.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724946429; x=1725551229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19pOYqOl3I9870eXelgBzJkHhlo9o66XSetrRQMeIhw=;
        b=Sk7parMjhv87/r0VhmxIczcKcoOjBywahLq7x+zHoah5qEp/l87667I6UyM+gFrK13
         jt9CBU1HUACYndY6bMmz8ySKS6/flZtBzKjEu60XrO7/oum1U4qkPoc6TbLpVL70WyZh
         cmL/tN01eZgsBbUx6PxFp9NgcEeJGtjNtONxbMyb1QVSdBAiCwQf6eo/cSiTTp9T9rig
         xGpY0AdCxQ/gY99kZyA+HfVYkB8IPKIWVItphvNkLOOClwL1tCur4MyCcJskXzfbr3/2
         YJ7yOHdNoP5+RX25A7UI/4pLdpXMVPfnlI40xrLCgqoEeYS8ouMl/0EUEIn0O0HDVrT7
         2xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946429; x=1725551229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19pOYqOl3I9870eXelgBzJkHhlo9o66XSetrRQMeIhw=;
        b=bZ/qVU5xIoQrCuu08swEZ/KJUpl6/+bLgwtBso2e3K/arBcbe7lpoSvz5SB4c+Z6KC
         NAZ5tdem1EAUw5QIsZglLxuHbNdZEHtgy7bWS6O+kEv4qC5Vl7VkMkSmq/HIRZkq3EDz
         rh0vuI5SR5TkFnQPvNvqUoIINopqBEDINg03D+l+MAl2j/LCw6Iku/nDbgCpSgB12VHW
         3BEI1Qqwuzx1DHLwkQwCgoRR3BO3tZ9/wG7IWoxSqx5Qbfb6LRBPt2zG96HYxZf/1zy5
         Ziwd8YeFDA3jL73KiKmSJUTtSNTNLXWA50kLVGc+5X6122XO3wDA+R63hH/552alpBlw
         jlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBhSjblAx7H/EcPK46vHkaZi8diOpW1v1adAQ6Ddxv5w/rIRpI+UqJ1fuXjd7qzlGXfp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySq/w3TN9dPRJXxsLvvU3k1+nGRtkk9r/TcHDUeiFs8MeUGY3/
	JRPqs1y+Y2G/XudJir9fPSJXg7Az23B5x2OzJaSBSipGiLgQbbGc
X-Google-Smtp-Source: AGHT+IFTp1OItMbquVQPUSzIgMds3tzlFE6lvcgiLCboythY/pwWHnhyo7rw/paUKg/R1cWBEmz7Ug==
X-Received: by 2002:a05:6a21:c8c:b0:1c6:b0cc:c448 with SMTP id adf61e73a8af0-1cce10b34e8mr2081267637.43.1724946428982;
        Thu, 29 Aug 2024 08:47:08 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e7821cesm1380779a12.55.2024.08.29.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:47:08 -0700 (PDT)
Date: Thu, 29 Aug 2024 23:48:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] add ref content check for files backend
Message-ID: <ZtCYMiOXVUM7SD3v@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <Zs348uXMBdCuwF-2@ArchLinux>
 <xmqqbk1cz69c.fsf@gitster.g>
 <20240829040215.GA4054823@coredump.intra.peff.net>
 <xmqq5xrjzzxt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xrjzzxt.fsf@gitster.g>

On Wed, Aug 28, 2024 at 09:59:58PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > As an aside, I wonder if we should consider deprecating and eventually
> > dropping support for core.prefersymlinkrefs. I can't think of a reason
> > anybody would want to use it, and of course it makes no sense as we move
> > on to alternate backends like reftables.
> 
> Yup.  Perhaps add an entry or two to BreakingChanges document?
> 
>  Documentation/BreakingChanges.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git c/Documentation/BreakingChanges.txt w/Documentation/BreakingChanges.txt
> index 0532bfcf7f..2a85740f3c 100644
> --- c/Documentation/BreakingChanges.txt
> +++ w/Documentation/BreakingChanges.txt
> @@ -115,6 +115,12 @@ info/grafts as outdated, 2014-03-05) and will be removed.
>  +
>  Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
>  
> +* Support for core.prefersymlinkrefs will be dropped.  Support for
> +  existing repositories that use symbolic links to represent a
> +  symbolic ref may or may not be dropped.
> ++
> +Cf. <20240829040215.GA4054823@coredump.intra.peff.net>
> +
>  == Superseded features that will not be deprecated
>  
>  Some features have gained newer replacements that aim to improve the design in

From my current understanding, I think I need to rebase two patches
provided by your here:

  https://lore.kernel.org/git/xmqqle0gzdyh.fsf_-_@gitster.g/
  https://lore.kernel.org/git/xmqqbk1cz69c.fsf@gitster.g/

I think in this patch, we just info the user that we will drop
"core.prefersymlinkrefs" later, so I should not concern about this
patch and also the [PATCH 8/6].

Thanks,
Jialuo
