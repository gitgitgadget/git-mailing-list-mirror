Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D543ACB
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693328; cv=none; b=Aiz3ejbXaEpILiIx/2GpUfQvAYI8yd7s9mCT73QN2O2ltjbultD75VVeU6mekYv/+IcvIuxPVjDx6kSJE60B1NPh1KR0JLH0/5+6TyGCOBTtqIg1oV0q9ZaQXTYIQSQNEvE7dvYECHI0Kw+TXrNqn914fPVPQejMNN+mCfm8TpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693328; c=relaxed/simple;
	bh=fQbHUTXYVsOPywOr4sH0PAZUBPNv9VWONdBXVUhI1hA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUnoXjBhG2XBbhP5mQV54UjjeEByjkVaRJoYWaR62sjAgTOYCWAyUw2r8wbFItfzcIQB4DkciyaBAJYQu6/WxeverDSJWLs8jt7bpmzkaH8bE6TlaS+k0Gz/hDM98r9cXZ90qiSnZWutOgBafUBJ9MJs8eByCkEgbDM1XuZeo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo5tgnk8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo5tgnk8"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70264bcb631so1032150b3a.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717693326; x=1718298126; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgmJ3KCjPCNAyN6j2h/4LRscpfDdMgVSfG4AaW7qZY4=;
        b=Oo5tgnk81bXdLM4gyUto6PejPa/RjHEOlMl+DvXxFIEB7qlWqf95KwKEe6acXxx3Iw
         1w8ftIZ4qtHT6SjgIzRNPUHwGik4JxestvrecskWNeoqsHUBwfuXQB8OZ1oT0nsbHxtR
         UFMclADrl32ml2ZrN8dpF0kO84y+sd+CakSS4LdVTziZGZ9vaaQ4a27bjmJEX9nSP/38
         n57Ghv4+cipK/ALE+hem33SpyweeaBRwG2fVYK3ZwRR1HQbulNbFr7ZLApZJdhJwGyVq
         YaWotuVOybFJ0Uwar8MS5T3jJMikFENTa8xAA2TSZAXtK4rua8FWogn/Bpiv0lsIYdoV
         D2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717693326; x=1718298126;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SgmJ3KCjPCNAyN6j2h/4LRscpfDdMgVSfG4AaW7qZY4=;
        b=boYGOUKJGCEOEOqjENtpZlTBlWKzsb88vY23FftqCjc+hHYMeTvqrfJ0Q1KZel93Rz
         6ychDCyh62UYgKouAuHrYBxyw78MZ3xXkGhYd9g206yIPe2JAIFawU78qR3m837Y7bbd
         j6UdR1oT/b5kbYC8r0gK2AET03VaPH+uX3Y5nYRxXJjDmBckIC+BmWdmwQ8rTg3PP1+Z
         nork+FnXnFjUkVeYBPkeCF7DQBz4SaSw0EhVONXiGNHvouVuJ0qZ8Z2GPtZYg5ufH1Fj
         xTwUYomBAy341mX5yihHLK6jGq/azjRCXih+BLCia0Jq6IwnNXC1SebIlcmM+EgYJU3Z
         KjMQ==
X-Gm-Message-State: AOJu0Ywb5zb1mC+QJjD4B7863yvLEQ6dD0qWGR1PqPx/Qi4TzXLWa42s
	Do1WG3lMgd+XFL4VE+2ym5kTUV5mIhtmoRyMIUb7lsdmgJZYNyNM
X-Google-Smtp-Source: AGHT+IE++JyQm8BdtVdw6p9MAdi6nRzC551bElS+FWwsXnLSZbrYzzvBJ0FYbhE+6uNACB9TksV2TQ==
X-Received: by 2002:a05:6a20:5611:b0:1b1:f0d4:71b6 with SMTP id adf61e73a8af0-1b2f9e14803mr100894637.54.1717693325789;
        Thu, 06 Jun 2024 10:02:05 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd5336e7sm1304874b3a.219.2024.06.06.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:02:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] ci: compile "linux-gcc-default" job with -Og
In-Reply-To: <bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 6 Jun 2024 11:31:45 +0200")
References: <20240606080552.GA658959@coredump.intra.peff.net>
	<cover.1717662814.git.ps@pks.im>
	<bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
Date: Thu, 06 Jun 2024 10:02:04 -0700
Message-ID: <xmqqplsum2cz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I was a little torn whether we really want to name the variable `O`
> here because it feels so easy to set it by accident. We could rename
> this to `OPTIMIZATION` or `OPTIMIZATION_LEVEL`, but that's quite a
> mouthful.
>
> Alternatively, if we don't want to have this variable in the first
> place, then I'm also happy to adapt the script itself to pass the
> optimization level via an argument.

The latter is much more preferrable.  It is too easy to stomp on
people's established workflow that already uses that variable for
other purposes or expects slightly different syntax.

>  Makefile                  | 3 ++-
>  ci/run-build-and-tests.sh | 9 +++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 59d98ba688..ff57c94fdf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1357,7 +1357,8 @@ endif
>  # tweaked by config.* below as well as the command-line, both of
>  # which'll override these defaults.
>  # Older versions of GCC may require adding "-std=gnu99" at the end.
> -CFLAGS = -g -O2 -Wall
> +O ?= 2
> +CFLAGS = -g -O$(O) -Wall
>  LDFLAGS =
>  CC_LD_DYNPATH = -Wl,-rpath,
>  BASIC_CFLAGS = -I.
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 98dda42045..0f00dbd289 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -13,6 +13,15 @@ esac
>  run_tests=t
>  
>  case "$jobname" in
> +linux-gcc-default)
> +	# Warnings generated by compilers are unfortunately specific to the
> +	# optimization level. With `-O0`, many warnings won't be shown at all,
> +	# whereas the optimizations performed by our default optimization level
> +	# `-O2` will mask others. We thus use `-Og` here just so that we have
> +	# at least one job with a different optimization level so that we can
> +	# overall surface more warnings.
> +	export O=g
> +	;;
>  linux-gcc)
>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  	;;
