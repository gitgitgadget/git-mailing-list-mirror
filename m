Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3660534473
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652731; cv=none; b=kPEel+sNinnJAufUDtCFhgGBV2cgphyvGntD2uydXGeYdgzjzSI0OINPsvEXdyDD/UZMSW/1gUQMNJTgkGq/nhquoCXYUuRSJbfPXavRRG55n0jFFvURMe2OY4az7ve64NQePKfO9hbGT0IKs66NQVyZ4Tiikr238jV76r0/QJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652731; c=relaxed/simple;
	bh=5S9m62rCjpjLhPlOkViYJvjySrh3lyG0WhxILluHf7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mPKcJpywxlzOLGRP1EBxLqNpMm7G3X/0LpclKllXmZFICxl4vqQWy5DM0pJUj335o0a/AUgZtprRyfuAftNhWYYNO/Ia+YCStLWiSQ5V0GcNhvcUN4AF3h+M6ultNJgmQPojKkb8KHe4tcqcf7cNWVQM2lgGzV4R39BegepBbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ptKVORTv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oKbLQrJ/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ptKVORTv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oKbLQrJ/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4E2D77A0132;
	Thu, 17 Sep 2026 09:45:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 17 Sep 2026 09:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789652716; x=1789739116; bh=zhm0gGQo8y
	9Oz3E7EFh/Kb9mAeJkNqdMBwS1SgRdFlI=; b=ptKVORTvktxLpovENEWzEKchkF
	iTRvrFMp3/DCQXhob3h9xk04n6fn5RKJyXbI4lTCRgWvWIkIYjPPsjdRD1+sBCeO
	5ylXPIbHStscQoZbL/sMTwuiaUIcp7KQfQbPg1D5se7crW5W1PxgpHBLNfHhstXa
	L8urWjy/muwV8RrlXkHQcIcL0G/P9PCyavtS2LdESieJyqJhHlCOQ+xLBeya9hfP
	fbEQiOHSgq/UvKe014qYBP43A0HGIZwLZZ3VFkFYvwJ8GaEpTccim/OBuB2yaTb9
	xyEXfgKXySHd3Kc7Klm1+K1vIbdzF3xLwYhzLhlII0lqmo7PY54MJv51/u7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789652716; x=1789739116; bh=zhm0gGQo8y9Oz3E7EFh/Kb9mAeJkNqdMBwS
	1SgRdFlI=; b=oKbLQrJ/nlcS7pmC05wmL4Hlejx4Eh/iwU6Wi5w3uRMmiXON3nI
	kPIKC0+cuhk14hk7tRzlBXQMTd+j8OsA058xLz6UJinYU7yA4CdLiEDfkYlyyhF2
	eeMpGUr3GUROGdQT0CN/z/Q65khT+SNWGCVdpwg9yr/LC1z+0WW7V3LtRUdHZnxF
	SkSNIeLZJ0IfIiamdy+Xk8nvnyGP4RphZtgISvLBc5HC1o92SDUeaUJpCUvnE9gM
	FThXBEHts/jUni6pDNNshLiSG6cDmedaDfWWn/ySmpPgpdrpffFXabaAHobcibMM
	JcSFrS3Crz4Zil5v9GaVIYdO2x9FsuhttjQ==
X-ME-Sender: <xms:7O6ralzFU349MLY4t-7GYUvUMXBrex68QbHq1pQJvssqAUCDdz-jJg>
    <xme:7O6rasunnXc0ND24pUmUrbC1jtVPlLqfh5JRiZhedHhLb507_-zSZGNgt14xjj1fk
    4nJOA0V2IbXHcPqSkMzV3wLR0FUW2CdMPjfTM6lV6ZJkwAJ7_jj1tM>
X-ME-Received: <xmr:7O6rasvbgoCIswvOJ2nj0_PUMCEKVoMQ4hrX9B7KOn1MdVL9GjvA7x3P1Y8lfYllcvt0fXquZiXAviS9_BoMXpBGzpnz0ZMtVylV>
X-ME-Proxy-Cause: dmFkZTF6fbjA+HqfI3OW7pG05fqD9aotDbxJQ5LgapEUPLOeb4tCIc+dT1xDqRJUhLcPAd
    T76m/tpQ7VLsIwIhl8FMFYQHO60b2zwlbbvZ+3D32FsWty7Y803D2g/4m8FO8yc4/gqv4W
    RqO7YtZ15dQ/Mb5dLJRhnK+9Xb6wXfhy8by3pXTq0gyPs1OF8TKq0UrrwiGsYJ425Ningc
    T8vTUE+CURRJ9/QbeLxgBQjdx3a62EvG0wJ3ywbYFCUC2jMI19qrEFWfrI7y+MBq63rr0u
    OGuGxnY+R8L3tjoTJGRJ98V+Dz3d4xxKHf7fsl3HNSR29QQRFs2Tt/T6UADX0SrqgbxJsP
    c4zv4e2Q+/G1MsGgiOcjTEMQql3ipfV0MUYXwgKXWL9vqKJk6SGoK94tg4F7Tr88072MSK
    UuxS6G039q5GZg264BlXIlq0pXHNqDHpCX/31F/AexPflux3oPIj1wc8KYE+UzuaP5cPLT
    fcrgPfZCOCECO9iD12wLCDD2j1lE5umIEeIf+6yrAXBFpCzHxBgmjN7fauqX3NjS6GpeLG
    7i1RfyjEhzE3UdzCcQtNb+dsHcYigWou0rbR4cGaYNC5GAE9FJkSmvoUP3XCqUpSPxsrw6
    ek8rxdaFaSz559BWpKvjCxZdy49HbMtMiFTEfhhhncL4pTtfprdNM9k2L/0A
X-ME-Proxy: <xmx:7O6rahN7Htu4CV2KUv2XpCs6aulWSSCWnplJWoOz8L1JXbVZQ7GIHg>
    <xmx:7O6raq30cgjf-5-6txI74Rioc7demYhYqzXJBc9xkHgBJ4cVErllQQ>
    <xmx:7O6ratMc04DIY-Ciy5qtTaCwnl8Dofx-vp6dv647OMBa5aBnxKw3tA>
    <xmx:7O6raq3hH4AnpI1NVLIHGaaJxEJ-851kGyx-YyK1lOFx18PNSAv9Xw>
    <xmx:7O6rajV90tbzbz9pnjROByRnUwRb7frqjmCS_2sRqOTLMFy-h5fA3_JI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 09:45:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] exec_cmd: RUNTIME_PREFIX on OpenBSD systems
In-Reply-To: <aqthQ3u4eW1wHCn7@humpty.home.comstyle.com> (Brad Smith's message
	of "Wed, 16 Sep 2026 23:40:51 -0400")
References: <aqthQ3u4eW1wHCn7@humpty.home.comstyle.com>
Date: Thu, 17 Sep 2026 06:45:14 -0700
Message-ID: <xmqqy0d0t2j9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brad Smith <brad@comstyle.com> writes:

> Enable Git to resolve its own binary location using getexecpath().

That may not be incorrect information per-se, but lacks critical
bits.  Natural initial questions that come to my mind are...

    Why would one want to use getexecpath() over whatever OpenBSD
    ports of Git have been using happily?  Is the old way being
    removed?  Is the new way being more accurate?  In what
    situations does the difference matter?  Is everybody on OpenBSD
    able to use this new function?  Do only certain, and/or
    presumably later, verions of OpenBSD have it?  How widely is it
    available?  How long has it been available?

Your proposed commit log messages do not answer any of these
questions, but it should.  The title can also use a bit of tweak to
identify which versions of OpenBSD this patch is relevant.

> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  Makefile         |  7 +++++++
>  config.mak.uname |  3 +++
>  exec-cmd.c       | 24 ++++++++++++++++++++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index d4b775953d..9e3d37b5b4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -378,6 +378,9 @@ include shared.mak
>  # Perl scripts to use a modified entry point header allowing them to resolve
>  # support files at runtime.
>  #
> +# When using RUNTIME_PREFIX, define HAVE_GETEXECPATH if your platform supports
> +# the getexecpath() function.
> +#
>  # When using RUNTIME_PREFIX, define HAVE_BSD_KERN_PROC_SYSCTL if your platform
>  # supports the KERN_PROC BSD sysctl function.
>  #
> @@ -2356,6 +2359,10 @@ endif
>  
>  ifdef RUNTIME_PREFIX
>  
> +        ifdef HAVE_GETEXECPATH
> +		BASIC_CFLAGS += -DHAVE_GETEXECPATH
> +        endif
> +
>          ifdef HAVE_BSD_KERN_PROC_SYSCTL
>  		BASIC_CFLAGS += -DHAVE_BSD_KERN_PROC_SYSCTL
>          endif
> diff --git a/config.mak.uname b/config.mak.uname
> index e28870434d..270aff1772 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -343,6 +343,9 @@ ifeq ($(uname_S),OpenBSD)
>  	CSPRNG_METHOD = arc4random
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  	FILENO_IS_A_MACRO = UnfortunatelyYes
> +	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 8 && echo 1),1)
> +		HAVE_GETEXECPATH = YesPlease
> +	endif
>  endif
>  ifeq ($(uname_S),MirBSD)
>  	NO_STRCASESTR = YesPlease
> diff --git a/exec-cmd.c b/exec-cmd.c
> index 507e67d528..5251da4229 100644
> --- a/exec-cmd.c
> +++ b/exec-cmd.c
> @@ -129,6 +129,26 @@ static int git_get_exec_path_bsd_sysctl(struct strbuf *buf)
>  }
>  #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
>  
> +#ifdef HAVE_GETEXECPATH
> +/*
> + * Resolves the executable path using getexecpath(3).
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int git_get_exec_path_getexecpath(struct strbuf *buf)
> +{
> +	char path[PATH_MAX];
> +	if (getexecpath(path, sizeof(path)) == 0) {
> +		trace_printf(
> +			"trace: resolved executable path from getexecpath: %s\n",
> +			path);
> +		strbuf_addstr(buf, path);
> +		return 0;
> +	}
> +	return -1;
> +}
> +#endif /* HAVE_GETEXECPATH */
> +
>  #ifdef HAVE_NS_GET_EXECUTABLE_PATH
>  /*
>   * Resolves the executable path by querying Darwin application stack.
> @@ -209,6 +229,10 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
>  	 * after the first successful method.
>  	 */
>  	if (
> +#ifdef HAVE_GETEXECPATH
> +		git_get_exec_path_getexecpath(buf) &&
> +#endif /* HAVE_GETEXECPATH */
> +
>  #ifdef HAVE_BSD_KERN_PROC_SYSCTL
>  		git_get_exec_path_bsd_sysctl(buf) &&
>  #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
