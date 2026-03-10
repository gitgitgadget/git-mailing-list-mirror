Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3882280CFB
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174836; cv=none; b=caCKd4DmHPDCBx4BUB62Xl49x9Mml2T6YBpQNm42Xz+BlNulVHGnPZxi0hx7krMVgRggCDZxoiK7DOREtxzmwmzhYzoP0me4OJgp/y0Sa+GdaouKnIFAQVcWJjNgjsovtnWUQSeg0Ji49oJk4lAa80UMtqnb0appXrXh8+rsHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174836; c=relaxed/simple;
	bh=89iHXZEPIt/JwDpDEZ6HQXY7XfLJ04ukAOcBh+RK5Eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jiKq9kku4jf5o0gryn4EHu1+OuY20TSAxOaR39La4HoKRiqSWjRPhxvKogRjnhXLc/sNik8Xb114gBTBR45+nr+gVkoBhQ60OxN9zJyMxDlVTK4gAPcTLHtGGmVbFXKRGQ4pdw3N/L0Sbwq4mpBSW52FthkpUvUBBKUbtM7xAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hk2pNdfx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2TEWNYtu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hk2pNdfx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2TEWNYtu"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28D7114001F7;
	Tue, 10 Mar 2026 16:33:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 10 Mar 2026 16:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773174834; x=1773261234; bh=kgtJ7Rfecp
	S1t+Hw/GH4AT5C0oBM3vdBNKFGzzRmgxU=; b=hk2pNdfxCURYjp9cWDRyYlKDy/
	8oPnNGsS2uhYGEN8HKHDeQ2l08OBOx93FCDgxAE7tSJucNXz6JEodyPeVWFXRfxB
	j98Y+3IRA2QTFqyK6AKus78/lEjplVVlMaCOgzBC3bxlFWIGeyhhuhGfE8Pa7Mqy
	9tMaqwMm2Paer7Ss3OEBUq59K31m9N855VGdWGBfiI0v4xYM4ghPELqTIz14lK/V
	RUKkH+OKWRugwBafKVQc5iJNo66Z55PLEbrhfbYelkwNSR5Ouqi2/1qgpeBeKCAE
	Us7TPXbQPndb/Zwp6zOyruvkfwfpwBtx3kidKNImk3hiH5XR+REnK5TEyz4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773174834; x=1773261234; bh=kgtJ7RfecpS1t+Hw/GH4AT5C0oBM3vdBNKF
	GzzRmgxU=; b=2TEWNYtuvl/wiHBR1e7eompiBw7SjY1po8jp55ADiDaO6jX734c
	D6OS9PSJghoPEnngkcNCky3kHV21PnwxQw3AE2h9SEpegf7eDZA4aPTVa5vNKl6F
	v9tR5urh2hWTDx/ezA7SpysKbqFsQl5Y1bFsfaTF1KZyPsEHqDnNrAHkqHQngbWq
	p7HLV4kT7nUpJW3TQtes3qj/d0/UxWvyNMREq4l7BPTbSirwXK/yj9s4d0JsYyli
	hd3MWE1W1NO11oUEE2UIrrzi8P23wBBCjO5Z4GUU+gm3KCUUecesc5dMLQ+RokjD
	jH2iNEcxZORJB23RjsMv/2QHdZvxaLXJ1wg==
X-ME-Sender: <xms:MYCwaWNGWl-y3m-8pgZWVRInjHRcSxtgxMmrjJ3XdLDPVrbLuFG-Iw>
    <xme:MYCwab3QHY0d0zMsVSbYrA5HZd8hoTA86MT-026CP1wFG0dPVCOWU-kZ4ferXsw4Q
    G4YpgQyREBGPM6_91a4HfF9oAukQxw76bmrr-Yhqp8SymW7gFsNBg>
X-ME-Received: <xmr:MYCwaVlBitZKDjhHVy3smLj8J6suzDSaFgUUdT8__8nFR-J6jZjJ5s4ZvBLVYx9fzAJ85kBOQBEAlfS4MuSNFnBjAJg3PfI4RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrd
    hsihguughhrghrthhhrdhshhhrihhmrghlihesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehjohhnrghtrghnsehjohhnthgvshdrphgrghgvpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MYCwaSXzQIE97rLLzr2cCM7Ja0zpuv5Rb96TUczJ0YLmEOoPlQej0Q>
    <xmx:MYCwabuBTNTo4t2WUqGAJyPdzpsN0lmZsnQ6KzajLmDBOUtIbAKthA>
    <xmx:MYCwaVaYgee6nWf3QXapS2DA0hgQ982_oR2At8rViX6N1wjCt0_MVQ>
    <xmx:MYCwaaVojFrujSV_7mB__wP3UTKThTfXcSyGywwkIzHy6PG5TC6qQw>
    <xmx:MoCwadHHh1wfwnZROSk5RhUMfZTJ-1O4RQwP5mjUYmN-jymjN47BBB5c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 16:33:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jonatan@jontes.page
Subject: Re: [PATCH v2] builtin/help.c: move strbuf out of help loops
In-Reply-To: <20260310160029.44605-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Tue, 10 Mar 2026 21:30:29 +0530")
References: <abARj_VI9n2nB_xT@pks.im>
	<20260310160029.44605-1-r.siddharth.shrimali@gmail.com>
Date: Tue, 10 Mar 2026 13:33:52 -0700
Message-ID: <xmqq1phrtoen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> In list_config_help(), a strbuf was being initialized and released
> inside two separate loops. This caused unnecessary memory allocation
> and deallocation on every iteration.

OK.  strbuf_init() followed by a loop that does strbuf_reset()
followed by use of strbuf, concluded with strbuf_release() after
leaving the loop, is a fairly common pattern to optimize such a use
pattern.

> This also fixes a minor memory leak when the SHOW_CONFIG_HUMAN case
> triggers a continue.

Does it?  You are essentially saying that

	for (int i = 0; i < 10; i++) {
		struct strbuf sb = STRBUF_INIT;
 
		switch (SHOW_CONFIG_HUMAN) {
                case SHOW_CONFIG_HUMAN:
			continue;
		}
	}

leaks, but a strbuf merely initialized can safely be discarded
without leaking any resources, can't it?

> diff --git a/builtin/help.c b/builtin/help.c
> index 86a3d03a9b..467a0763a6 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -134,13 +134,11 @@ static void list_config_help(enum show_config_type type)
>  	struct string_list keys = STRING_LIST_INIT_DUP;
>  	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
>  	struct string_list_item *item;
> +	struct strbuf sb = STRBUF_INIT;
>  
>  	for (p = config_name_list; *p; p++) {
>  		const char *var = *p;
> -		struct strbuf sb = STRBUF_INIT;
> -

A blank between the variable declaration block and the first
statement makes the code easier to follow.  Loss of a blank line
here is of dubious value.

>  		for (e = slot_expansions; e->prefix; e++) {
> -

This removal is good.

>  			strbuf_reset(&sb);

So we first reset, and then start building things in sb.

>  			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
>  			if (!strcasecmp(var, sb.buf)) {
> @@ -149,7 +147,6 @@ static void list_config_help(enum show_config_type type)
>  				break;
>  			}
>  		}
> -		strbuf_release(&sb);
>  		if (!e->prefix)
>  			string_list_append(&keys, var);

We no longer have to release it inside the loop, as we will reset at
the beginning of the next iteration.

>  	}
> @@ -164,7 +161,7 @@ static void list_config_help(enum show_config_type type)
>  		const char *var = keys.items[i].string;
>  		const char *wildcard, *tag, *cut;
>  		const char *dot = NULL;
> -		struct strbuf sb = STRBUF_INIT;
> +		strbuf_reset(&sb);
>  

The arrangement of the blank line is wrong here.  The original was
the last line of a declaration block which should come before the
blank.  Now you are removing it, and then adding a strbuf_reset() as
the first statement, which should come after the blank that delimits
the declarations and statements.

In any case, here we have a second loop that wants to use a scratch
strbuf, so again we reset it at the beginning of the loop before we
use it.

>  		switch (type) {
>  		case SHOW_CONFIG_HUMAN:
> @@ -195,13 +192,13 @@ static void list_config_help(enum show_config_type type)
>  
>  		strbuf_add(&sb, var, cut - var);
>  		string_list_append(&keys_uniq, sb.buf);
> -		strbuf_release(&sb);
>  

And we no longer release it during iteration.  Instead ...


>  	}
>  	string_list_clear(&keys, 0);
>  	string_list_remove_duplicates(&keys_uniq, 0);
>  	for_each_string_list_item(item, &keys_uniq)
>  		puts(item->string);
> +	strbuf_release(&sb);

... we release after we leave the loop.

>  	string_list_clear(&keys_uniq, 0);
>  }


Having looked at this patch, I recall somebody else is revamping
this function already, so this patch would step on their toes.
Please pay attention to what is going on in the project around the
code you are touching, and coordinate with others who are working on
the same code if necessary.

https://lore.kernel.org/git/20260228104654.80831-2-amishhhaaaa@gmail.com/

Thanks.
