Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7572505DF
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697846; cv=none; b=uJ0PhBz5yt/qNPFGdjSmSvI324Txh2Qt7sBoPNTo7OIbdTej56OPCHhv7w5ztGUYiBPRUHSEcLTHrVL/GIc9BLvO3k28nSL+A0COX5FgGhYdln+hDRijHKRklq6yC4EOFwckyugIfbcU86apPvfTeMu27MKqwXQLJPyFt9ukcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697846; c=relaxed/simple;
	bh=tRzu3ZuD2ZMuMXpBPgEuFhbqiYRQZva5PWh5lYHCDhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGBxQgPTek/h4l73GLq7r5uutNtCK6mvlEVG8Nu3h02RYkqro9Ui/U+kd1qED5QkTzn6aMl87/qshy7qCh08g5D9KYdZh6T34yprL3febkxmhXehKAoSEYbTUrw/kL1P37tFnbHgfy6QToLnThd5DkEIfzAxeXdrWd18+rKBEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GDJMs65X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zLQZj0Uf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GDJMs65X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zLQZj0Uf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0AE101382D40;
	Tue, 11 Mar 2025 08:57:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 11 Mar 2025 08:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741697843; x=1741784243; bh=H8riB3KHMo
	OgbHOcnRVnITq2zy21L5ztI7Oezyfqpb8=; b=GDJMs65X76wiPiusZHxplpenKJ
	F3qz/9Q5w9nX6qWDbvdkyHpG6HM9pZc6PdixvrTujYEWxsVQPj6FnXTI2Dq3+aOt
	LxpKQdHg2a/IdcXhqj41d0QOuiWbD3O1A4p3aKa9RrOEHsYEXOEwRv5ZNJt53JFL
	ZVj9BIjan42YCEqdQSYxTZREcYP1vRz3sjIMhUG2JM0iy2Mk67xndc8Tys1AAE0+
	gANHrHZFcGp29ht7zUSmpJilBKOyLM3OMaGlq5P/YMCTEwIjrzTNbgHEyOwsNWUj
	8P8+bNcJ7T95jCBe+1W27hj98WDzXnweNWFCMmdDOTLEbiedFiY2NggVFmSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741697843; x=1741784243; bh=H8riB3KHMoOgbHOcnRVnITq2zy21L5ztI7O
	ezyfqpb8=; b=zLQZj0UfydiMhPSKy+k8jfYPZIfETO4wZe8oA6OH4p1TCHl/XSj
	pJeHa3BspWXWcSLfbAaKDg1mlPspL2BIZdpOEu3+GHz9SXveJfgn7zkkxSGEIm0N
	gylHj2dOvMdNCvV7IG7JJ7gz1H/UH8yaYg3xSsiJchbtoe8V1QbZ4LFM0hLSVksB
	MyCDRs0DCdtKG3U0AOjMJJtqAQFF8/sUFhbUniLEn4LcFlnkt6CRGluqZxEXNcCy
	vMK0KnswyXebSRDreOVpwpAOigB2C31GMw85eJJeai9brWi9CxZ9hjgRIkrKaVzL
	t4DohtSsoNaekXcgCWqtcvtpwtOUxEAzU1A==
X-ME-Sender: <xms:MjPQZ8yWKWcB7GNU7ACB-qNdHToyIyFKJnuh4sSo8O4eiq98wbfEUA>
    <xme:MjPQZwSZNn7xdbYr4BQTndvrQo5Omjvds2MW-ZnRJQ9FQSmGMpKH8jJWbfoP1VX6F
    fo59Ski1Eps9H7jrg>
X-ME-Received: <xmr:MjPQZ-UWyUmzBgL06nNl0qEr9TrmTD-2YA6k4JTsgKbiQeMiIHh6K5pTACPawSqrB67Cv39eSTYV7d3ICuVu5dmOuQQ01tgEhBhBkeKuBYepdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:MjPQZ6jpLwtMPdJY_LVuXJah7IYrLsziejjuAWWMwGLccQH7kOZ37w>
    <xmx:MjPQZ-AwdyKx3Nzhkzek3xyQX1MGQS3h7Lfg3UsPHw88Lg7ICu8XJA>
    <xmx:MjPQZ7KrD5KerL943TkWXeEd0O4yTUx1oD_UgOSHrM1r0x458ABSEA>
    <xmx:MjPQZ1CYo1tCJzayocvoWxB5xBnUyd8jz8wTRai3P9wvqIvymUyfQw>
    <xmx:MzPQZxN642V8k04lY0jB7TT_4jXW4A1QmaZ-MiCRQVJouVh-cZmBCmT7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 08:57:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d296040d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Mar 2025 12:57:21 +0000 (UTC)
Date: Tue, 11 Mar 2025 13:57:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 4/4] name-rev: remove "--stdin" support
Message-ID: <Z9AzMaXMGq8BbENb@pks.im>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250310231652.3742490-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310231652.3742490-5-gitster@pobox.com>

On Mon, Mar 10, 2025 at 04:16:52PM -0700, Junio C Hamano wrote:
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index beac166b5c..3f49138551 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -578,11 +578,13 @@ int cmd_name_rev(int argc,
>  				   N_("ignore refs matching <pattern>")),
>  		OPT_GROUP(""),
>  		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
> +#ifndef WITH_BREAKING_CHANGES
>  		OPT_BOOL_F(0,
>  			   "stdin",
>  			   &transform_stdin,
>  			   N_("deprecated: use --annotate-stdin instead"),
>  			   PARSE_OPT_HIDDEN),
> +#endif /* WITH_BREAKING_CHANGES */
>  		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
>  		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
>  		OPT_BOOL(0, "always",     &always,

I was wondering whether we should also #ifdef `transform_stdin` and its
single user to more closely reflect what we would have once the feature
is fully removed.

Patrick
