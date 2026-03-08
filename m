Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16233241103
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773013978; cv=none; b=EnFnF9X34YqL6lQr5yKwuChnVN7dF/lIbS+J3HTv45tU/Pkx6gq+318nsptWknYlCiSbkNrLhYkGXmaEBwwLkpEtAacrldNWytZvXDjbQFUYaClOsg0jl9wkotNg9iRnZIXuI6vVtlrxKl8SpW3rG8U9ZV2S9HzD9d3KuHF2ycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773013978; c=relaxed/simple;
	bh=PhMBEqbpRM+wjCIu2YrXKRnFvRM6Lw0eeyzn7FxLkWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OOIFwIeG1c0PbbG75dq2AmjKq8rf3Rewni/lvLIifETgC6pm91pgP750ZKLHspMdfmRtGDpYzCalQItSvGuBEItH0EPWMg2VJ/Onmk6J1ENV3jWOoz67HXWIiZzfs2+ZiIYszqL1ZRo/BsAIKnkkBdBcyT2lZStrWrugm4/gY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EL1jzJD9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uFKBoJW4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EL1jzJD9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uFKBoJW4"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C54A1400161;
	Sun,  8 Mar 2026 19:52:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sun, 08 Mar 2026 19:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773013976; x=1773100376; bh=Uf7N4Odvmn
	7AecjnlGC6sRpl0BZh6ICOVymcdgW4sm4=; b=EL1jzJD9QB4580UBw0CDqUtETw
	bl+euJyHzt6/uWBKOVo2RzII+PcCkvLrhKHLXEQElorwAaBCXTQnlKHlrCvQ9uL6
	ixPSfqWDDrSKZFgJAcrXZb808YUEvrDmf9UwN0MPpRFxRuUScOOfBIz1SaRmVsed
	Myg/XDVm0C36WtVX6qnMbvMto9WscQHBn/kg+kJcs+eFDIebXDiB6NqPrTDyLtpo
	jROZMDllV7HFIsAcyzEas/4SYo1B7koZ9pwOf725fl3JpMOh+ZIVHZ0JW+D8V+bt
	+tBSWfwREUou9zqHoGxFu4qgDlRIt2tmSZE3AT1elBix0/hCLAEdb3hJEhVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773013976; x=1773100376; bh=Uf7N4Odvmn7AecjnlGC6sRpl0BZh6ICOVym
	cdgW4sm4=; b=uFKBoJW4+3/uQuNf+XslQ4wsce35zv2m04u4mXzNCMNvLq7afk8
	vsSFDrHbC+iqJle45JZXGxP1ppICmL/hbfclbuuOyIrLBxGP2HARit5RL2bgzQND
	WSQxS8+ggYMKybMrDDtlz4zkshF1rfu29yj1MDSjEnn7oBaqwC1aKY6dmwYK8Cv9
	t9p2hNsYccwvzhvlHw8oeEIfkiOcq7KRbKAovAuimUaJNp3AHv59MS6RgPgEy2q5
	IqetQWuLtsO9YF5jYbrgXgnMZ9dIYEEvugbFud9HwQ5qGM9TGLx2McudSDII80H7
	iqZFca1/NQqDABcrlQwbtE1jqcvJPrCN8KQ==
X-ME-Sender: <xms:2AuuaYCYQrE_3vQDfWJpT35Sl9-QQi8y9peARHTOIfB16Yc76rPA3g>
    <xme:2AuuaR_mL5b2LXPtzGXeDes5Jj2XrVAgjbAO3r3fYAhEi9Kukn1I01M37CPEHxzzP
    m5YtRYnh3Cp3eY1SsWbfpXer1vZQyL3xbPuGK7XamR961PdKpYYBHU>
X-ME-Received: <xmr:2AuuaY_dNjZ7vV--GvbOV4oD6H3q4hMOJchwcjqJjZFaeO1R5ySp6oM9S0o7RaIZ5PkkCQuXpbKhEwd1VReYZy4Jv_ehenh-Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeiheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeefleessggr
    rhhrohhithdrshhhpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2AuuaYdTCYtEyR2XmCpnZiti578npOZ92DPh_K-0EOpUn9MWVLQh0Q>
    <xmx:2AuuaRFW2RArFIHtCDAcejLrzuqlLfJAXXzmO3PvssZSGv6GOmARmQ>
    <xmx:2AuuaWdsGpDTeKITFVwAMPhmGzJq9Lns5ePeE6F6zAgHo7P8p5veqg>
    <xmx:2AuuabG7a8e1yikKB66D0d-8YBp8wrUqHe9o-bBRwk7WW9i691Hb3Q>
    <xmx:2AuuaS47TUnu0GlM6kjsPjIJkI4jTn6SfEByatmtUgvJr0XrsG_mQ0Hz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 19:52:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] help: refactor command autocorrection handling
In-Reply-To: <SY0P300MB080180E17B471505A4150C08CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Sun, 8 Mar 2026 21:17:22 +0900")
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB080180E17B471505A4150C08CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Sun, 08 Mar 2026 16:52:54 -0700
Message-ID: <xmqqsea998vd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> Refactor autocorrect config into struct autocorr, with an explicit mode
> enum and a separate delay field. Move config parsing, TTY validation,
> and prompt handling into autocorrect.c.
>
> This simplifies help.c and makes state handling for autocorrect explicit
> and easier to maintain.
>
> Signed-off-by: Jiamu Sun <39@barroit.sh>
> ---
>  Makefile      |   1 +
>  autocorrect.c |  92 +++++++++++++++++++++++++++++++++++++++++++
>  autocorrect.h |  23 +++++++++++
>  help.c        | 106 ++++++++++----------------------------------------
>  4 files changed, 136 insertions(+), 86 deletions(-)
>  create mode 100644 autocorrect.c
>  create mode 100644 autocorrect.h
>
> diff --git a/Makefile b/Makefile
> index f3264d0a37cc..6111631c2caa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1098,6 +1098,7 @@ LIB_OBJS += archive-tar.o
>  LIB_OBJS += archive-zip.o
>  LIB_OBJS += archive.o
>  LIB_OBJS += attr.o
> +LIB_OBJS += autocorrect.o
>  LIB_OBJS += base85.o
>  LIB_OBJS += bisect.o
>  LIB_OBJS += blame.o
> diff --git a/autocorrect.c b/autocorrect.c
> new file mode 100644
> index 000000000000..eaae01645910
> --- /dev/null
> +++ b/autocorrect.c
> @@ -0,0 +1,92 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
> +#include "git-compat-util.h"
> +#include "autocorrect.h"
> +#include "config.h"
> +#include "parse.h"
> +#include "strbuf.h"
> +#include "prompt.h"
> +#include "gettext.h"
> +
> +static enum autocorr_mode parse_autocorr(const char *value)
> +{
> +	switch (git_parse_maybe_bool_text(value)) {
> +		case 1:
> +			return AUTOCORR_IMMEDIATELY;
> +		case 0:
> +			return AUTOCORR_HINTONLY;
> +		default: /* other random text */
> +			break;
> +	}
> +
> +	if (!strcmp(value, "prompt"))
> +		return AUTOCORR_PROMPT;
> +	else if (!strcmp(value, "never"))
> +		return AUTOCORR_NEVER;
> +	else if (!strcmp(value, "immediate"))
> +		return AUTOCORR_IMMEDIATELY;
> +	else if (!strcmp(value, "show"))
> +		return AUTOCORR_HINTONLY;
> +	else
> +		return AUTOCORR_DELAY;
> +}

You snuck in unnecessary "style fixes" to make bunch of "if()return"
into if/else if cascade.  Also what was AUTOCORRECT_SHOW is now
returned as AUTOCORR_HINTONLY.  There is no explanation on the
reason behind these changes in the proposed log message, and hiding
these small changes in a code movement patch makes reviewing the
series harder than necessary.

The patch is doing too many things (namely, (1) code movement that
will make it later reusable as a side effect but has no semantic
changes in the current code, plus (2) change in style (like the one
we see here), semantics (possibly the difference in SHOW and
HINTONLY we see here) and features, possibly including the renaming
of AUTOCORRECT_* into AUTOCORR_*.)  Let's have "restructure with
code movement and nothing else", followed by "other changes

I'll stop here, and expect this step to be split into at least two
patches to make it more readable before we can review it again.

Thanks.
