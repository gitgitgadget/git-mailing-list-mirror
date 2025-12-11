Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DED263C9F
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765421844; cv=none; b=hNfGLVPCqKUhFmw+RX+rsUzrHSTGzpmh4xVHBAip4Hqxzv8my8JKkBD8qmSb8NzJA3N4qrgTyvGE+okUPGAvpQ/ltx0xAflziKUSNTDmNvVl81nupqHrS5CzJtz3eIIYFnf/AawntJrYLfCCkW9Bn0Lhg59GMy6DjCgdpvDQeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765421844; c=relaxed/simple;
	bh=AZkUvh9vwyD4vnfqSeRgruhw7P4ozqB8r0jNltC+0Jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SB4SLEzlJ3Lu/EWJfpSKjnTLnZrbX96LDRpRo405dD3I0gI3XbP+XKkQP3CcpTObEQ/wUX4rmFqfHhwBeHgE0iIESlYgJEQ+sunKJnlphHdM8qopjkWO9MhYDOWhbdO50+nGA56kldLRdqT80P3c0M44MSOpO+7vwUQNi+Qfskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D4/7+5kD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZjEJSUd4; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4/7+5kD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZjEJSUd4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 763261D00112;
	Wed, 10 Dec 2025 21:57:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 21:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765421841; x=1765508241; bh=YAedg4UPGC
	e9EP9wNYJGJiOb3LMl9eJY88emiT/3bFo=; b=D4/7+5kDHFm/U5IrrVSiKU/PUP
	Qubl/TBBq6oWcuwEJ/ceX9mR2y3GWBYCBa/Sa7eMRxAD4NUbFPUjWz3ycCRfMXIS
	VM7rlbPKScjixKWeVRDhadMJ3ScgPUV/H/xYiLUfHVWnnvKvhwEd4uWSUO+lRfN0
	Gbj7weQKzlSw/mA7ZTm+24E0eWy5/PJtGz5bWpbPpYNBqvY85x1FMEV2gyOFwo+I
	wBwraMcLivQcgyDmOMQbygWjsP6+7CJbj5r0WWuuGIiPchMCOZv86BLSS60MMnrQ
	jItf9OpKBAwPNa60ociqmWAgCd8KMU4j7251EhnirX2mHx/7EtFu3JOMYgoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765421841; x=1765508241; bh=YAedg4UPGCe9EP9wNYJGJiOb3LMl9eJY88e
	miT/3bFo=; b=ZjEJSUd44oRmny/XFj5Loe3tIwlIx48hlWyRq4T1mXkymKnbHIP
	qqzpBj/cvr/gZ/MAhGStSYkk3NC+o9cCcDq4NDWjlFql4Kv6jE091OkBTXP30Vle
	czF+aWVryz5du8mHddRvCfcBpXXCFwFdof05HNMdrMbK+p+GhGsnLmAmfF9Icbd/
	pHh4AQa/DNA26uhIhk7t+dzCu+lcKp/cDG0IRNRuA/GNxrJnWqGd2Hx0BpaVk8/9
	pooK5y4V4MUY8WCdxRLip/L2mG0BZIWJTop7EZzk5BoMbSVoafTgbCRnp0cJ5Adb
	B16FAC6O4h0AJCSG3D9oAXzjYY/+g+M70Sw==
X-ME-Sender: <xms:ETM6aUGaWlVPUMhlulqouhICQQUrujwgDOtGU4U2dJvcTv7dd8bWDA>
    <xme:ETM6aUXURLMKXd5AWBiokXn_tAN9qkd7jISYTEaN8oYLQ6BY4fbXRkz8DWKGfgLgh
    PoaR7ftu81ApW-t5ZD-fxyWYETpyuT7i3DjMcdcE2_ibKGPw_d8>
X-ME-Received: <xmr:ETM6aTJtih4qoAeBy_XT6hUZ7hm6XkcWxRDMfDLHFgJfYbdv0b6mr_i_rUPrbtZANi5c9h037gXzmmCaR1a7DAX7apObDqaDqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ETM6aU94Qz75wZciwszJbhVbEFxf-3JwRRRiHlrR0SychsNbgtkfhQ>
    <xmx:ETM6aWJp5jhC9CvJx2JjfFAA71wHoBr-AUq6Dw7FS9ZkRe_dnL4AMw>
    <xmx:ETM6aZk4t61akpuuHWme8rqdUTjBYRAL1dmVZFqNICSqgAA-i7E1bQ>
    <xmx:ETM6aaOi0_YhR0y4aAmuZHqEk_1SBUWwreLXso0urN8B_XW7WJZ_cw>
    <xmx:ETM6aepFFVXh6I0SMLWQyqfiXaJGCfGRXSmtvXlaHUoKC0hqnJau-kRo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 21:57:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/repo: humanise count values in structure
 output
In-Reply-To: <kf7vavs5yetooe6u2ygttzfriul4u5ywdnhtyksh2pbar4mpfz@orlg7ppajd7s>
	(Justin Tobler's message of "Wed, 10 Dec 2025 09:10:29 -0600")
References: <20251209225820.2861276-1-jltobler@gmail.com>
	<20251209225820.2861276-3-jltobler@gmail.com>
	<aTkS_kBlNsnbPyP5@pks.im>
	<kf7vavs5yetooe6u2ygttzfriul4u5ywdnhtyksh2pbar4mpfz@orlg7ppajd7s>
Date: Thu, 11 Dec 2025 11:57:19 +0900
Message-ID: <xmqq1pl1hgj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 25/12/10 07:28AM, Patrick Steinhardt wrote:
>> On Tue, Dec 09, 2025 at 04:58:16PM -0600, Justin Tobler wrote:
>> > diff --git a/builtin/repo.c b/builtin/repo.c
>> > index a69699857a..8fb728b3a5 100644
>> > --- a/builtin/repo.c
>> > +++ b/builtin/repo.c
>> > @@ -266,6 +275,10 @@ static void stats_table_addf(struct stats_table *table, const char *format, ...)
>> >  	va_end(ap);
>> >  }
>> >  
>> > +static const char *unit_k = "k";
>> > +static const char *unit_M = "M";
>> > +static const char *unit_G = "G";
>> > +
>> >  static void stats_table_count_addf(struct stats_table *table, size_t value,
>> >  				   const char *format, ...)
>> >  {
>> 
>> I would assume that these units should be translatable.
>
> Ya, you are right. I'll make units translatable in the next version.

Whatever you do, please first consider reusing existing
"human-readable numbers" helpers, like strbuf_humanise_bytes() used
by the progress.c for showing throughput, before rolling your own
variant like the above.

Thanks.

