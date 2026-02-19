Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AAE2EA468
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524219; cv=none; b=ISpJiXhBo7yBUNE8woEI3sUnyy5M9Oa+SdtRB7Y9P+MRb5JtwNxVO+bH5dXcjcCGuhXKxqVQikapG6Eko1Hy7N74RVrzhniA1tWm81G5xRPLeNAhLsfmV30vZLRcBMVqU2HlAp45joxWRGBo8/Uqtyq9nlkmtPn2afA23NCfVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524219; c=relaxed/simple;
	bh=RBztmY7FL+rgWxlD3vc00g6yCSQUv7X0EKtlV1nIZT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O34KzP0WpC9k1lwR2FZIF/avZVHMpn9Dj/DLCzCl9ac+XVdjNdPcaA+9bCB3NQUiWwFSMrduHqoJzhfazb8/TxhGLH14U1jA3gqgFPIY+ZQsGvwS1gHfGJzvarZXBSay1d4oeQm79D9fHovzkrTCezy9a6U9kgXFXWJ13VXjjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tpjvOaXm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qbWkI+X0; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tpjvOaXm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qbWkI+X0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7490914000F5;
	Thu, 19 Feb 2026 13:03:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 19 Feb 2026 13:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771524217;
	 x=1771610617; bh=KWS2lKiuNPM8KseyvI4cb7UqMfaNMZ2nl3/+ekIyknY=; b=
	tpjvOaXm8gKIO3dPNLPGJvGiCSPQ4lzjSgOBtfFiT/WcOUL93yj2PjdjmD3VWF5p
	IR3VS23hzaMasuSPQDPGfsw2VBO2viDadTR/xjL69d3BKCqMivnYBs6NECVoQNXa
	8wN/MtwGkkFlL103gF3GV6AC3rEcOq8GIRZtMLJSA0ud1PmENK5+Oo/vdXf2zt9d
	Xm1MUHQhdEURIAT0tCdYeaNlpDP9Mf9aEfec7FtrJWkHBhfh+xhxzLA+nEshj3FA
	5gYu/hFDJwZnwy1zNyN9NrXptS7XCVJPny8X7Ha2CfR5kL8EbduF/JN6bOHwT7w5
	mZ3vCZu352O2WIIQ7HOnSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771524217; x=
	1771610617; bh=KWS2lKiuNPM8KseyvI4cb7UqMfaNMZ2nl3/+ekIyknY=; b=q
	bWkI+X0im76zOhYaoruUMWm8QL/PBplVgPbW+LjT68uOh2TKHpmCseoxL8arJmOR
	neY1WJebIYVH7toRRuP+Basv5lgDADGEgLCfjeHu492INhjFJS19AYS/htBSgxcH
	fedZZjhbAuQ3uhIDVkCFXrLTDZUeAnGC5YUTqAvrWI3FEbpXz9/JHRhodTKoctKU
	Unx2Bh87LVJCS2zZG1q0v50vBYDSjVxrydUffRNDwhFVcQ1J0SBRJPSOIqqDNJC7
	lU/rdTKoapOb8iok32V+u5WXYewctagBib0zJ3h2yBHqMAmEZtjNZLqcoHYE5es2
	Z5nB4THoVT3sgBmhJDKaQ==
X-ME-Sender: <xms:eVCXaWy11UJG9JMJCt5BhI_TKgXrgL-Tl8g920YmCcT04eyuTrOQkg>
    <xme:eVCXaZItungbwr-3P0BqUFjzwB-IMMk3mfXxjVyqfWawgRqZRAEfZIYtYhbNxgsyg
    7d7nXwB8FwbghM9KhyevhJh-0S_MbGJ0mLhUPRARbjCNXHRb29IBQ>
X-ME-Received: <xmr:eVCXaQom4e1Q_BhncCen_rLflq3T9Zg6i7xBUeWYCHo0boK84uWnugblPHsyz1N8tmcxLr09dFsNkTU3bY2LLL2XbnjJr1O1AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhephfetvdejheduheegleehfeeive
    dtgeelfedvffdtvedtudffieekieeijedvlefhnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:eVCXaYJY49OyY68hCq54vaZiBAQoGSag3lU-0TKc-IsuXjp7f5V1MQ>
    <xmx:eVCXaVQ4PwJjqYwjO7QWMevaF7vIvBCWm1qdJ1tbyW9h9n-pTohWnQ>
    <xmx:eVCXaXvN8orKVqy_IU4ryRtnq0y3-0Evr7EaqpjYtJ5asd8aKWyk-w>
    <xmx:eVCXaWZHm7sKtZrWFfpje0EQm2BClRW9z7aZkmXafvOI8vyONQyikA>
    <xmx:eVCXaQwBPnQIj-ZQVlfkoquJzWByMQ0F9SYy7oEsPLJKoVd1fG5eagmU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 13:03:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  peff@peff.net
Subject: Re: [PATCH 1/2] format-patch: make format.noprefix a boolean
In-Reply-To: <format.noprefix_boolean.39d@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 18 Feb 2026
	21:26:17 +0100")
References: <CV_format.noprefix_boolean.39c@msgid.xyz>
	<format.noprefix_boolean.39d@msgid.xyz>
Date: Thu, 19 Feb 2026 10:03:35 -0800
Message-ID: <xmqqy0ko626g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The config `format.noprefix` was added in 8d5213de (format-patch: add
> format.noprefix option, 2023-03-09) to support no-prefix on paths.
> That was immediately after making git-format-patch(1) not respect
> `diff.noprefix`.[1]
>
> The intent was to mirror `diff.noprefix`. But this config was
> unintentionally[2] implemented by enabling no-prefix if any kind of
> value is set.
>
> † 1: c169af8f (format-patch: do not respect diff.noprefix, 2023-03-09)
> † 2: https://lore.kernel.org/all/20260211073553.GA1867915@coredump.intra.peff.net/
>
> Let’s indeed mirror `diff.noprefix` by treating it as a boolean.
>
> This is a breaking change. And as far as breaking changes go it is
> pretty benign:
>
> • The documentation claims that this config is equivalent to
>   `diff.noprefix`; this is just a bug fix if the documentation is
>   what defines the application interface
> • Only users with non-boolean values will run into problems when we
>   try to parse it as a boolean. But what would (1) make them suspect
>   they could do that in the first place, and (2) have motivated them to
>   do it?
> • Users who have set this to `false` and expect that to mean *enable
>   format.noprefix* (current behavior) will now have the opposite
>   experience. Which is not a reasonable setup.
>
> Let’s only offer a breaking change fig leaf by hinting about the
> previous behavior before dying.

One case that is often problematic is what happens to those who use
the same set of configuration variables with different versions of
Git, before and after such behaviour change.  But I do not think
this is such a bad thing.  The only reason why they had this
variable set (to any value, or to a value-less true) with existing
versions of Git is because they wanted to omit the prefixes, so when
a new version of Git dies with "Heh, 'nothanks' is not a valid
boolean value", they can edit the configuration variable to "1".

And from that point of view, I think the hint given together with
the "bad boolean" error can and should be phrased a bit more
strongly, i.e.,

> +		format_no_prefix = git_parse_maybe_bool(value);
> +		if (format_no_prefix < 0) {
> +			int status = die_message(
> +				_("bad boolean config value '%s' for '%s'"),
> +				value, var);
> +			fprintf(stderr,
> +				_("hint: '%s' used to accept any value but "
> +				  "now only\n"
> +				  "hint: accepts boolean values, like '%s'\n"),
> +				var, "diff.noprefix");

The target audience of this (hint) is those who have set this
variable to a non-boolean strring from the existing version of Git,
and the only thing they meant to express was "I do not want any
prefix", so "we used to accept any value as true, but now accepts
only valid boolean values", perhaps?  That would nudge those who
wrote "[format] noprefix = NoThanks" to rewrite it correctly to
"true" or "1", and not "no".

This is a related tangent, but shouldn't this use advise() without
configuration?  There is no need to allocate an advice_type and use
advise_if_enabled(), because correcting a malformed configuration is
an action enough to squelch the message.

> +			exit(status);
> +		}
>  		return 0;
>  	}
