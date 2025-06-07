Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0417BA1
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749285784; cv=none; b=Z9E/yG/emknqd0VXXEissY8c4q/5eeMR/ov5FGJs0N7bZVyzbhbqw2IcYwzVOcpHPo3+AHZq+pILPGGNBHPDkYuzidgYuntMwTQ/OBgf1+Y1kdHYNubv175QnZVqBweinvm2ER7TwZwm1QK3WGaUsNhOW6+RWSdFX45TnRPEtf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749285784; c=relaxed/simple;
	bh=qyqlmL8cYYfYaz/ZSYSEklNC4WhCn8di1Dz+Ftdvang=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2oU/3hE9De///sDrB1nvwxVhLpvIfzAbJ0ZKIUFS04g9xjIN43qXauvyMH/0E+B8JYfiCj1b+kAhom5x1MNJzgFSEFX0VLshw88jSQrVbC9O1j9STk4CupfPgC0QbwDnCK7prUUtscgqsO/xsST+R5Ji7Qv9iKx3FCwJEert0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOws5wtf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOws5wtf"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c384b2945so2082400a12.0
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 01:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749285782; x=1749890582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khj8oz7eZgkGdm7S7teAl5j82wuL6DdUTnFgHFxoXbY=;
        b=SOws5wtfFTdi1XENrL5VRTA9pah4o/b6AHsvqqe0nNstfsEoLr0DrofuiuSm76wsNw
         CaO2fG2pK9cYslpq5i+Gebmt/8rJcE3NF3CgoBLQRW4v6fsIXyktJGLLVsdME/dqJ/3L
         OKP0nYo/ESykDw23nEexqoUf4RVaPBlat57u573OLS69gNGjsmTqS09WgtHaUQCdnsJs
         HpKPpMUAUYWu39rMsg2QnJv7GoubCJHNwd+ioIFNN5qxlB2NUOItUab6ADE7EKDd/qGn
         WFrs0ZKvWnkD5nJ9aPTdO4ZS/CE/UFdW1ypMCPS3KAlzyYMsTS2sI3f4XlZ7teCKbttB
         JdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749285782; x=1749890582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khj8oz7eZgkGdm7S7teAl5j82wuL6DdUTnFgHFxoXbY=;
        b=YT4XNHrwwnIjybZ1tMkqt8Yvo5nNZH3sZShBLolvaJvFugvfvjxfH89UvjHCpIBhlI
         1JAknuSOGskPMnphXagqizFItKjOby3nMuyv9OHnMSkeFGCqDQVwkvKCNAbWNOcrBzHe
         StM4x+VREPIjcy8bON0EOBz5wlokX2pT427Alvt7QAB3Py3osWFDi+6emp820bOuNQFl
         uNgTbk5QH4lWWAjUz/CBcxVp6xIGm3vwxOUWwkwdil1oyFTiXDAG59g+VYBEFlJPmlVw
         miEJhaH7PFyFuOh8B3OjAMMofQzoG/tpmF7qWUEAA3Vuqv8bGkb4BshsV2ZPkYJhxvee
         rkdA==
X-Gm-Message-State: AOJu0YzguxWt5T1J7A+j2nOY6lvlRhXvzLXU3F0hIaUWNFUxkD41RZDb
	MrVG8mX6npHPQsoTFfFYsudGk+6NQErXrz4d/CCTnRCChqYKKGrQf0GdyBfLruTe
X-Gm-Gg: ASbGnctUtFQxrtVBb3QFKz5BDUO4XYpwW8pThQy62U7tqZZAhHY8KtoyphKcOC3wWeq
	VYwrWYoLoJahC0nbHzGqsAyUC7EImHj6QnENZ2qAHCt9VhI+9vhA8VOTeFhst6DtZYX4JBtjImP
	TNO+23un5kc9RNQa2hTbZxJJExCnA4gFhVqU14Ug7jr9dXoDRqpaaVR7FKk1MLKeCeYe853QTIz
	9Dr86UZXxzZHeMxy0PGqQtPehXGpVXtU9fJmGmZf2b98lWx8xJ5ELFcNVCfSxqKEZKrCW81UYPg
	fZRHH/frrvoDVDMydDOm3MhYPL74clMlAe7mKUW7uB0QQnmyFFjDMtV77q6ovKS6wJpsfMw47Es
	MbmE9+lpyJoxsLlziCeepGxFNeg==
X-Google-Smtp-Source: AGHT+IHCev/Bvhp5lr8HnIp+efxzzRvD9OVZ73y8OdpCylKIGYBL+yM5Dn+eh2oMy8CgbYA0C0PKrA==
X-Received: by 2002:a17:90b:3e4b:b0:311:e731:523a with SMTP id 98e67ed59e1d1-313472e628dmr9528073a91.11.1749285781664;
        Sat, 07 Jun 2025 01:43:01 -0700 (PDT)
Received: from google.com (199.174.125.34.bc.googleusercontent.com. [34.125.174.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603504efasm23422215ad.221.2025.06.07.01.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 01:43:01 -0700 (PDT)
Date: Sat, 7 Jun 2025 10:42:58 +0200
From: Jonathan Nieder <jrnieder@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: update settings for Solaris 11
Message-ID: <aEP7kpQIHZx94eg6@google.com>
References: <aEOlc_PV7ZngUdj0@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEOlc_PV7ZngUdj0@humpty.home.comstyle.com>

Brad Smith wrote:

> Solaris 11.0 and newer have mkdtemp(), memmem(), strcasestr()
> and strtoumax().
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  config.mak.uname | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)

Thanks!  That's from more than 10 years ago, so seems very reasonable
to rely on.  I assume this is tested :), so lgtm.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -190,9 +190,6 @@ ifeq ($(uname_S),SunOS)
>  	SHELL_PATH = /bin/bash
>  	SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
>  	HAVE_ALLOCA_H = YesPlease
> -	NO_STRCASESTR = YesPlease
> -	NO_MEMMEM = YesPlease
> -	NO_MKDTEMP = YesPlease
>  	NO_REGEX = YesPlease
>  	NO_MSGFMT_EXTENDED_OPTIONS = YesPlease
>  	HAVE_DEV_TTY = YesPlease
> @@ -202,7 +199,10 @@ ifeq ($(uname_S),SunOS)
>  		NO_IPV6 = YesPlease
>  		NO_SOCKADDR_STORAGE = YesPlease
>  		NO_UNSETENV = YesPlease
> +		NO_MKDTEMP = YesPlease
> +		NO_MEMMEM = YesPlease
>  		NO_SETENV = YesPlease
> +		NO_STRCASESTR = YesPlease
>  		NO_STRLCPY = YesPlease
>  		NO_STRTOUMAX = YesPlease
>  		GIT_TEST_CMP = cmp
> @@ -212,23 +212,45 @@ ifeq ($(uname_S),SunOS)
>  		NO_IPV6 = YesPlease
>  		NO_SOCKADDR_STORAGE = YesPlease
>  		NO_UNSETENV = YesPlease
> +		NO_MKDTEMP = YesPlease
> +		NO_MEMMEM = YesPlease
>  		NO_SETENV = YesPlease
> +		NO_STRCASESTR = YesPlease
>  		NO_STRLCPY = YesPlease
>  		NO_STRTOUMAX = YesPlease
>  		GIT_TEST_CMP = cmp
>          endif
>          ifeq ($(uname_R),5.8)
>  		NO_UNSETENV = YesPlease
> +		NO_MKDTEMP = YesPlease
> +		NO_MEMMEM = YesPlease
>  		NO_SETENV = YesPlease
> +		NO_STRCASESTR = YesPlease
>  		NO_STRTOUMAX = YesPlease
>  		GIT_TEST_CMP = cmp
>          endif
>          ifeq ($(uname_R),5.9)
>  		NO_UNSETENV = YesPlease
> +		NO_MKDTEMP = YesPlease
> +		NO_MEMMEM = YesPlease
>  		NO_SETENV = YesPlease
> +		NO_STRCASESTR = YesPlease
>  		NO_STRTOUMAX = YesPlease
>  		GIT_TEST_CMP = cmp
>          endif
> +        ifeq ($(uname_R),5.10)
> +		NO_UNSETENV = YesPlease
> +		NO_MKDTEMP = YesPlease
> +		NO_MEMMEM = YesPlease
> +		NO_SETENV = YesPlease
> +		NO_STRCASESTR = YesPlease
> +		GIT_TEST_CMP = cmp
> +        endif
> +        ifeq ($(uname_R),5.11)
> +		NO_UNSETENV = YesPlease
> +		NO_SETENV = YesPlease
> +		GIT_TEST_CMP = cmp
> +        endif

Not about this change: do we want to retire some of the cases for old
versions at some point, or to collapse them so they can share more?
Seems nice for maintainability.

Sincerely,
Jonathan
