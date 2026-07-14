Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB03FFFB9
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019265; cv=none; b=KeFDkspf+xe2hPNKJE9JHbP54+jDmb7Pdr9ItDBjRZUb7MEG4C1XLAM1v17+Ks+ZHoymFLci+3dcI+/VJ5/aQZxIeaPwXrqfCDvfPcN/yngeGXzaUkqiXOTj9Vdsdc543U8qczy8ANdqDpPla+x6ldvTDe4GRL6w1/yKWGo5h0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019265; c=relaxed/simple;
	bh=8QRD8QJgpSd9G6qi1OD0UMGOrGyu4bui9SkZ+m/SW5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di6EwScWVq2vKU+lb5B/JQj/TScxXXDZXEhYcdFi2iNi7r3WumtL59JS2rtwwywEXXXPjEWkNxU9xxRtNdPvnplrYR8Tl43tKQLQpG534k29yOq8e9ocsMmOjS2jA9Ev9eomuyFZQ8PxIeT0ZJPgsvzAnfIF9kEn5OGivGhAL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iHjpxFpr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lbla8a8Z; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iHjpxFpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lbla8a8Z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B2CBFEC0072;
	Tue, 14 Jul 2026 04:54:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 04:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784019262; x=1784105662; bh=Z+NbQxWaWo
	WqbkD0z6IiWIDJ0xBnVD4PDE5Jd/py+XA=; b=iHjpxFprFV+SfiYmPVpE7itLbq
	EOkWG54SdzmQMsK0nJ7/MAvxxTDhUKgP0qNOkiCknWAXuT4N/e72VigS/JxHVAqD
	vq8LvyaQvX2TQ9CyOoQnF6D1CAndZTgIN6swnHX8leCmm70GXrnLUMOV2EUCE9Ic
	QrlU+NIDC/nvRqpB/KjrUXCdeQFAugNtUqqDMI0g/C+ZaWmPPqiphl8AQlMbgRyi
	nV3aSg+kzeMRGVDiSoZGpM154DL8ItKBcR3IKl46pAYEVefo0aXjVp6SYf6oJqRT
	CoHuE70ERwmrTTcJv+k12dmhnBy3qpM5dOOXNYXgieATchQMtUTnuDqE1hog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784019262; x=1784105662; bh=Z+NbQxWaWoWqbkD0z6IiWIDJ0xBnVD4PDE5
	Jd/py+XA=; b=Lbla8a8ZL7FfXRfoCBC46+nuk8JthWMdebb7+qoFcPxLyHYNK1m
	9VTlh2iitXCztO2d+t0N2mHWR1vU8Xo31MMP3DGTNP+1FtjK0hp36JT7YtJhbfZD
	q5j8NwE0/8n9uejDsMMNYIUYGLbyzqxLqUuuR+cZiQHVIBJWRJLrkBvT+94Arlww
	M4tpSFD7jkAPQH/aBQU6449xI4F1HQMZvMu3CmCPmDTtQhRcFp9hmT/UbeIuGhLR
	uDNJo5sYgXBAaTN7RfiDxbE953+Pq9iIadAWlFQ7JKOr/+0kncCk1mCafFS03CM0
	W9ga72qR4ZeaAxxCosa1bWchOS2j+RoXl2A==
X-ME-Sender: <xms:PvlVagB_qzj1eTXUZT19OXxV1t7FKJDNj4KwImzsymZf1PWMkErsnA>
    <xme:PvlValHz0nsgE_A4f6LH9X3_f4jY1j4rw8_d9LtJc_qQvlkY5NuyI8Xj42i3VdgaM
    JbayndBaWNcY-5kqAI6c6X3inW1WL8KcOzhQlb_VqQ1dBf0ae35>
X-ME-Received: <xmr:PvlVanM0NlMYV8lS0Mdc0XsNmNq62AffGWAJkQYdXbuBxZPAl6jQLahVXPgbL-2138aA0H0jW21aXdvXVqxib-n3nqsAAuAw4Rp2JPCSVQ>
X-ME-Proxy-Cause: dmFkZTFef/62sTZbQO043j2BgGugl09vBxLrSnr1qOE0BOCFNi4adm7l74V1ok5nIbguE9
    I3yHW+m7o7mxiYh0twDO6WUkqRhEnu+2/7djIPlnKD6ycXkJfTutT/IftYQP5OSuJdS59V
    6lJ7QykEu9AArpfUCvz9LN95y94f19yYNL+uR7AhtOEavMXpDlBjHqh351F/AqvT7uWeQs
    pHkjknrADiPFfLtHwUvFJ4qeLb6dAOnBddW83Y7d7MQVM1EJi61jFi0nWc/kxhE9tSOUDQ
    JzY+on77VCE/d30qzpeihrJHZcK39coI27veiFauukM/u8DclW251DAzErINccFMRkk0Ql
    jflFJM0ZPxpIYX3IfkCJmvgpl5G9S7iylfjMyt3UpAl3t8sV9cfsQLAhKGZQ/2RxtGoMpY
    ABT80cXPMfNNO+tDr8I1cHkr/l28S6ktC1Doy3YusjFZ7VwZ1sLNs6oXcnpwVS4Gsf2u8Y
    ivjvONgkLvQ87E0qRwHgLkrw/vJMLjfxxNXHPRthxN1FobX/GWVedoiASQPIXrb4aRJamc
    OnrBkLh3v74FbyEoqfa2jEGKWse1SjUnIyKJsoJ67Gqy9jL2CaJuFMpWpAqEf+slwyZQpn
    SQntShNLygHxo15gzZIg0Vu8hX9u21Yl8HVn+2x3IPlNbtwKLXAnmhlVJJtA
X-ME-Proxy: <xmx:PvlVam5cxEI8qxGnkkcrW0rtxxwuP_EeHLDkZbquhvW5Ptc5FPs3JA>
    <xmx:PvlVaqhejvPXQsd9v7cS8rG3lRfYJ7we5LFc-W2wNO2rRmaY2szI3A>
    <xmx:PvlVarfzKqGAQkuAnnWmrBcupyHdUExqvtLZ4u5UzzzaL_w95D_xbA>
    <xmx:PvlVaiwr-12MkWWxpmRBK0NLhCLEDsx4cZwvIfB9_ykX74enR9x61g>
    <xmx:PvlVapDhuS9XSpxHPoACJ1fa3kUPRtPHun4wCAEJtjLJtHekIWBRYSG4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 04:54:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5cc51ac3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jul 2026 08:54:18 +0000 (UTC)
Date: Tue, 14 Jul 2026 10:54:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-export: standardize usage string and SYNOPSIS
Message-ID: <alX5Nl8uX4ctVqo3@pks.im>
References: <20260713124153.245268-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713124153.245268-1-christian.couder@gmail.com>

On Mon, Jul 13, 2026 at 02:41:53PM +0200, Christian Couder wrote:
> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
> index 297b57bb2e..719aeca244 100644
> --- a/Documentation/git-fast-export.adoc
> +++ b/Documentation/git-fast-export.adoc
> @@ -9,7 +9,7 @@ git-fast-export - Git data exporter
>  SYNOPSIS
>  --------
>  [verse]
> -'git fast-export' [<options>] | 'git fast-import'
> +'git fast-export' [<options>] [<revision-range>] [[--] <path>...]
>  
>  DESCRIPTION
>  -----------

Makes sense, as it is more consistent with all the other commands that
we have. I don't recall any other commands that use "|".

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 0be43104dc..629d7c591a 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -33,7 +33,7 @@
>  #include "gpg-interface.h"
>  
>  static const char *const fast_export_usage[] = {
> -	N_("git fast-export [<rev-list-opts>]"),
> +	N_("git fast-export [<options>] [<revision-range>] [[--] <path>...]"),
>  	NULL
>  };
>  

This is being adapted to match.

> diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
> index e8d6c13ccd..c4a55ff4e3 100644
> --- a/t/t0450/adoc-help-mismatches
> +++ b/t/t0450/adoc-help-mismatches
> @@ -12,7 +12,6 @@ column
>  credential
>  credential-cache
>  credential-store
> -fast-export
>  fast-import
>  fetch-pack
>  fmt-merge-msg

And as both match now we can also update t0450. Nice!

Patrick
