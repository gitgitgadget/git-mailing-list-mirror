Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08B67EF1B
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721166; cv=none; b=CeySkPWH4qWLFX01kOXvuG1XSCV6TP3iCDt3zRUPMaTDRK0GsyaK1qPpXWRGBxniJLCOmIBKxSo8fazZAnr7JADrwL0XrwrAybdwnN4p+ZiQpMXYCsaPiLPdKRp8qL0MYpoMiI6cSNMvzxDViHDpEIu1csXttYJS3mEr9RfNzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721166; c=relaxed/simple;
	bh=KOCcFXwDxSmbBYFd9/s4yQwnQuXaioTYQs5i7t50ZQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dy+UgcBJXs31nAFbYNJsJD1WVqLWaK6z5uQeHu8ivWF21SAduoHl1xtsNc+JsD7QwbNeSno2IFlnoE4SCl7I8Pocv/Mo206C+vimrTndmNAA87nRnKwNt8/sYDZIu2EcwhwufvBxVcqRp7EnnKal27p4s7a7Y35oYqmZ+NcstiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gLlW98bO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gLlW98bO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BAAF331CD;
	Wed, 31 Jan 2024 12:12:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KOCcFXwDxSmbBYFd9/s4yQwnQuXaioTYQs5i7t
	50ZQs=; b=gLlW98bOJke/MLcRqTu8HDRirWaTbgedXP1Ajp7sBtgqm3gq0DSPZ4
	veEQFQkKdL+98H/qJOXxt/sCY5fbb3nx9AthsQQTAFevptWZYLFD6AkMk/ECDQuY
	Rp6blwTxvHLZCRHVnCIALR2qbnN083H701bLnAnkFfaUiw0cEAxI4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 038AD331CC;
	Wed, 31 Jan 2024 12:12:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CB85331C9;
	Wed, 31 Jan 2024 12:12:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH] This PR enables a successful git build on z/OS.
In-Reply-To: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com> (Haritha
	via GitGitGadget's message of "Wed, 31 Jan 2024 14:21:01 +0000")
References: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 09:12:37 -0800
Message-ID: <xmqqr0hx77ga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EFCA44E0-C05B-11EE-9D67-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Haritha  via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH] This PR enables a successful git build on z/OS.

Please think with longer term effects in mind when formulating the
title of the commit.  What title will your next patch have if we
break the build for z/OS next time, after this fix goes in?
"enables a successful build again"?  How would one tell which commit
changed what aspect of the build procedure to adjust to z/OS?

Perhaps

    [PATCH] Makefile: adjust for z/OS that lack dynamic library support

or something would be specific enough.

> From: Haritha D <harithamma.d@ibm.com>
>
> Since the z/OS linker does not support searching dynamic libraries,
> and the current setting of CC_LD_DYNPATH results in a directory
> to be supplied to the link step with no option as the suffix,
> it causes a linker error because the z/OS LD linker
> does not accept directories as input.

Hmph, it is not quite clear to me where that "current setting of
CC_LD_DYNPATH" comes from and what exact value it is set to.

Here is my attempt (blind guesses are involved, so please correct
whatever errors you spot):

    The autoconf generated configuration gives an empty string to
    CC_LD_DYNPATH when it cannot find a way to use a shared library
    and gives up with "linker does not support runtime path to
    dynamic libraries" message.  This leaves the directory path that
    is usually appended to -Wl,-rpath, or -R, or whatever alone on
    the command line of the linker, e.g. "-L/usr/lib /usr/lib", which
    breaks the linker.

    Work it around by setting CD_LD_DYNPATH to -L; we will end up
    giving the same directory twice, e.g., "-L/usr/lib -L/usr/lib",
    but it is only ugly without breaking anything.

    While at it, define appropriate settings for z/OS (OS/390) in
    the config.mak.uname file.

> Therefore, we workaround this by adding the -L option.
> And, Introduced z/OS (OS/390) as a platform in config.mak.uname
>
> Signed-off-by: Haritha D <harithamma.d@ibm.com>
> ---
>     This PR enables a successful git build on z/OS.
>     
>     Since the z/OS linker does not support searching dynamic libraries, and
>     the current setting of CC_LD_DYNPATH results in a directory to be
>     supplied to the link step with no option as the suffix, it causes a
>     linker error because the z/OS LD linker does not accept directories as
>     input. Therefore, we workaround this by adding the -L option. And,
>     Introduced z/OS (OS/390) as a platform in config.mak.uname

You do not have to write the same thing twice.  The text under "---"
is meant for extra explanation that does not need to become part of
the final commit log message.

> diff --git a/config.mak.uname b/config.mak.uname
> index dacc95172dc..c8006f854e5 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -638,6 +638,18 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
>  	SHELL_PATH = /usr/coreutils/bin/bash
>  endif
> +ifeq ($(uname_S),OS/390)
> +        NO_SYS_POLL_H = YesPlease
> +        NO_STRCASESTR = YesPlease
> +        NO_REGEX = YesPlease
> +        NO_MMAP = YesPlease
> +        NO_NSEC = YesPlease
> +        NO_STRLCPY = YesPlease
> +        NO_MEMMEM = YesPlease
> +        NO_GECOS_IN_PWENT = YesPlease
> +        HAVE_STRINGS_H = YesPlease
> +        NEEDS_MODE_TRANSLATION = YesPlease
> +endif

I cannot tell if these are reasonable for z/OS myself and I'll take
your word for it ;-)  After all you're the expert.

> diff --git a/configure.ac b/configure.ac
> index d1a96da14eb..64569a80d53 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -463,6 +463,9 @@ else
>              CC_LD_DYNPATH=-Wl,+b,
>            else
>               CC_LD_DYNPATH=
> +	     if test "$(uname -s)" = "OS/390"; then
> +		     CC_LD_DYNPATH=-L
> +	     fi
>               AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
>            fi
>        fi

The use of "uname -s" looks totally out of place.

Wouldn't it be a better approach to set it in config.mak.uname for
OS/390 above and leave this part untouched, I wonder?
