Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807724322E4
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985278; cv=none; b=i2kSSLFgq7zJ5CkoOYYwbQuRgHpapu0wHO98sbWgGbR9G0HsMVPGGlhXvNeso/3LrgvCGuJE0MjndHV7schJ25MINlIbeA6IVny/gmrVJE/SDLj07M1b1FkqB6qG0n0F1v42a4k0/E26NGr5YkmZ7ICEltFaHcStuI72BRMcKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985278; c=relaxed/simple;
	bh=hOHr36fxj6rwu8zLxHcb8xgrufxvDWuPNrm/uBdxcD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SpFY+k9Ajh2chhrxkvWvdAIXkNKmPh8U/a4lXNPYd/7uPN4hIXHs6q68YrRZnOlOpXkGI7bnXurvco+AxobdCjR04YwOHeEe7QG/VaDIECvHJp8kI9P9yB5EwJZ7YQVBN2OQ4fJIxYICZNkF8BwS5Qgv2Rpmw1yH5vQmKa40VCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FLPlD0aY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GyJLEPDF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FLPlD0aY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GyJLEPDF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D5C214000ED;
	Mon, 17 Aug 2026 12:47:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 17 Aug 2026 12:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786985275; x=1787071675; bh=FhuhxT+oBR
	woWUp4mK/4Y7STgy+ff32SI6921JVH7bU=; b=FLPlD0aYGm9kY5JVN6e1Veaztf
	M9K6OsvfRnyQUqDit0CFlNDPB+bn7bSry994YUkjRAt6AKkj/X7EAvbx+fgVpS8J
	oWJoxRP8YgetFwEBndBKQh3r75PHNCt9FFmJhHghJqhHKy06BZrCYfw1CDRjxzTa
	C5ZUsOUezBHY+xxXC5RAYbFpRTOJl6SrdMdlnsjtiCiuH4iY6g03QfM0oLrzGNMr
	fhfTGnl+COc24+oK3vHdS3FWGSGepM02P83yFrznrmUJnIUG6riOSH+9PvrKJ/o7
	ara4vNRSoAlx3TNDdSkxjQW+8MyJOoXoZJh37gX/fe3CUqv4n1hKEnhHW+ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786985275; x=1787071675; bh=FhuhxT+oBRwoWUp4mK/4Y7STgy+ff32SI69
	21JVH7bU=; b=GyJLEPDFZK1K0JHjILE/rATDAwL8M16Xg5c8okkCvxM9A6vwbCm
	d9gGqyQgKsGlkcblMcMB64ZUK+95Ve1IvPW9p5TKUBCX/elKwReQDyH55DHc6Wfp
	vLAiJzy2nNfB3Tqzxp/gELTL6RLcC2AaF7X2zVMvd3gFOYe4AVmP/PG/BQsZgVpp
	ALiEOkeCSolCJeB0T0XPy+bW3vY6rXqKNyQEDeiGGmuz+vfvwsRpajaLiZ5bdGng
	CjhO3+RCS509BJZJGNUnuah3WOONRAF6HFlXXM+n2gtgPRWtOqAbxCXT5bbZ9C2J
	vHnq+qtZqMQUMTZfHooq6C8gHh8ZHsGgP6A==
X-ME-Sender: <xms:OzuDajb10t-bDfJTucRLEjQyMKa6d3V_o9unM6chbl3h1Z8butvf3Q>
    <xme:OzuDap3jumisYqd9DIEXjURLiWKy806JGDy3GkGOxjsDF7tCS_FwIQ4qK7szaX2xg
    Rjyx0Wur-ogiLgwuI0E4yHcsIqCeuLYUAv2m4dhJD0gC28ZCJyIMw>
X-ME-Received: <xmr:OzuDajUATK9-EnO0EVXuCV01p4hPX4MWUp4nt80RDmfCPfOQLLsV-c3989CMB2GpcWeXnl1-_pv_3tq_XRC6ABBfs6w-b9hf2g>
X-ME-Proxy-Cause: dmFkZTEir9VA5zv8eixXDTjt/yqBkWV61eKXj96gKTbYvG1tMgK93Hhp9TSZk2EwhdO3xA
    x55KEjC/3fd7hl5o2BCzud2U67AeCJ40x0yoayVmd318oxmK4KWcZTTlgOw5l3IrXvk1L5
    dMRkSin9CYThIa/21GLDp9cZ+V8nsbyp3ZNu1tHQW87o0Iuh8vT940bL+J69WWXs/bukmv
    13stjtaXobmjz8rsuzf8aO8mKztQQUlDt8C8/yQW9brMBmhAYsSJsxH5VS2AP2TpLNxtqt
    DwxSOkoBLSqvNFAThmEMBXbrRvxy2TzkDsYHB4gUYmGcAX0Iw3PVPCxRUwd3WwhJi6MnJP
    UqmBcduu5BNo0AxJSupPm8SA0/UJypriJpRubj5wDn/NCMH4NxU7Wd2bF9uqtFmCSVwEBa
    JyHlsfwiADeypViJFU6Th4MrxGxwADJ71PSoMlHJIf+zdWJO81FGcB4GlfUPtJ1HCgXmAh
    aHKS4/mhWrnlUB9lJe7Cuowen1pd7uBkfhSIkRX9G9WgIZD8mNgmGskS+YLPqrhBfoYIyj
    vpqEuoCe1cwZTVl/FonugcK390jxll1h8IeqocelQBGi+Up+PxUfGumtLe4ck7wi7KMGef
    IwURTolQaLlKBKI8TejW5IfJDD+eOqylgT9XexFGW16Jn4mWyyHdUeAO6kIQ
X-ME-Proxy: <xmx:OzuDajU4MvuOd7eG4VMP4mp2x8Gc2ei_wk9XPC3y2FGK7-SvC0zawg>
    <xmx:OzuDaicIH0R0xaOpmBcA8ksAI-APpACIuxBKWauo7Wm5TdIgtF2lcA>
    <xmx:OzuDasUDD0O1uWaue0QU9Q73iAvSswImU_0urfiIQaUOZNEYgEnOdw>
    <xmx:OzuDareiNsj3mqdsbSFaqEhZ-ojR-jnfvepF-rjw9D-kdaye5hnNHQ>
    <xmx:OzuDah9kiZ7l00W_KgEQoJzn6LMDxQ3Gj_6AJZjUByNsxSFhmUCiWwOb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 12:47:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] bundle: get (mostly) rid of `the_repository`
In-Reply-To: <20260817-b4-pks-odb-generate-pack-v2-5-4c8a96ccfdb3@pks.im>
	(Patrick Steinhardt's message of "Mon, 17 Aug 2026 07:39:46 +0200")
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
	<20260817-b4-pks-odb-generate-pack-v2-5-4c8a96ccfdb3@pks.im>
Date: Mon, 17 Aug 2026 09:47:53 -0700
Message-ID: <xmqqik5866di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Refactor "bundle.c" so that we don't depend on `the_repository` anymore.
> This conversion is trivial for most of the part, as we already have a
> repository available in all calling conexts.
>
> The only exception is that we use `get_log_output_encoding()`, which
> implicitly depends on `the_repository`. Add an `extern` declaration for
> this function so that we can drop `USE_THE_REPOSITORY_VARIABLE` and not
> accidentally introduce more uses of `the_repository`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  bundle.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index b64716f252..a9330bf0d3 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"
> @@ -21,6 +20,13 @@
>  #include "connected.h"
>  #include "write-or-die.h"
>  
> +/*
> + * NEEDSWORK: this function implicitly depends on `the_repository` and is not
> + * available because we dropped USE_THE_REPOSITORY_VARIABLE. We can remove the
> + * declaration once it's accessible via `repo_config_values`.
> + */
> +extern const char *get_log_output_encoding(void);
> +

Doesn't this defeat the whole "drop #define USE_THE_REPOSITORY_VARIABLE
as a mark that we are done with this file and no longer need to
worry about it going forward because we won't be able to compile if
somebody adds a new use?" premise?  

We want to omit the above two hunks, even though the rest of the
patch look perfectly good.

Thanks.

