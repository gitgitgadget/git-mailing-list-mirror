Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC581F957
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972555; cv=none; b=BROnw1g4OwXnjCfK6wTE133fGyVauWpFwZZdcVQ1hbFSfbfGwdpe6q3cwyFn9WoJvN8ukCd3FfyYinf/OTLaoyvEUaimUxCEhyC4kqREUgnT0MASLYC4Z+GSWljC+WOjVSwTZkyp4v2LYZ6tmQHfNAXRm2bUjeCArVhmG1/VVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972555; c=relaxed/simple;
	bh=yT1GKJj5zqupAiBzDfTXtWRCaRSkiN4o0R6Dubc7PRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m2A6gIW7NWuAg8CWbupM/gvOe05SfnSEI99AzSS2/KrTVDqm34eeZgJXN1YVkh4IbyLoi1d8LZliTn8fW02bdVSlInfjWSAMcScq7RaoeqahULp/scl0rkAJBBLCz/4cCJi61HzSIo7nNIn4DJSiRmQPODFMR0Hd8iXgeI/8Cbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kS9MSnU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gfhMPL7D; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kS9MSnU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gfhMPL7D"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5F4A1140154;
	Fri, 14 Mar 2025 13:15:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 14 Mar 2025 13:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741972552; x=1742058952; bh=Cp3YgbqJM/
	02TUagPje8eeU802L6oX/IM8ZaI69Xn9U=; b=kS9MSnU+erWoNYrdzzQ5CynEey
	/eOa+wU6a7wd14Q4Y7jfDsp1s7asGWnV+pquq0si+xBbg+/EyPLdJc8Q3kpHsq6k
	Z/OuPUlfIC1GcrbA+TbV8cuMjNoJaCQL28AQxk+uqFNaNlwjZ3e1gIb7HGrBsVKx
	VpixvwI9pDs70EROe3feYNoaWFlLBEvW9cCsUckXHN+b6shwAfyBjV2gt11mZUhL
	vZGvLBWKVOHzWb5jBj+nvwzjgs66vS6Fk5ge0K/GpO6iAj9sgoLPGcHz2eEpJ+Pt
	FdGfM22Thca8IMzbGwm/iLYgvASLWDw4DKGH0jkwOeqiDAtoiV7uWnXMR2rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741972552; x=1742058952; bh=Cp3YgbqJM/02TUagPje8eeU802L6oX/IM8Z
	aI69Xn9U=; b=gfhMPL7DKMN20KXtKhRPTGu5wF0r4mqRvIMba4Mf8gGbTFZWCdS
	6Mlr2h2JGAp2HbG+N2lJWOEZBv+qJH5yLKLH+hytydXwkyFPnohb5mPxpNk7nlAH
	w8Dht0PszsYk6LupZel2UOdUNNo9QG5/Y91+gMgkzmFI96P4YvVYOUVs+1VUdsUA
	XeqaP7EoExEhi4MrOHcrSMrUnKGv9GSeT+WVyQGNNws5RCQEwmQD9kEsX5HCXMlt
	vbUrimC7m4wGemtvxNSRT0V9FHdFq8mlvcW7jSKo8h4emquhzfZE2BwFC2UeI4Ds
	EvRLlLnwR52FdGfPAOM2Yi7CJYeBIisGk2g==
X-ME-Sender: <xms:SGTUZ_30pSOUSIUQjxvcDYclwKj-aU1VM0C8nAPUSsXkm43u0l-nOQ>
    <xme:SGTUZ-G59s6zs7AWWktcReF9ARF1dsKRgDqhOf4SPa0MREE_un9qhqIWkWOx-B48Q
    PQAzttOEVPlrsls1Q>
X-ME-Received: <xmr:SGTUZ_6i2ToIV0juhExrwpeQwWN9SKUlcNqy1YBLwtGS_2F8CkxLOn22P6W-PzNRteYT_g1ZAzEbFZ0l7-J4sOxoi2OqY-z2Oe8kO_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfefgvdefudetudekteetveehiefgvddt
    jefftdekfeejffeghffggfeggeeffeetnecuffhomhgrihhnpehmrghkrdguvghvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:SGTUZ00GJmJs8J2aqM7SZXkQTbVnAXhv4xOZg_kx7OPun78NWzY5aw>
    <xmx:SGTUZyGhGcVNq2dLnRXtydfHus5KEmCD1XspDzhwmP7b9xZE9yjqkQ>
    <xmx:SGTUZ1_d_5v3yno1VZOSi13dEY5VKWFEnIpAGItDb1QHNZ8noh88Yw>
    <xmx:SGTUZ_ksBjVNOwwZmSyQWqnhkcJFud1VP8KVpFujwh2BH7oswy6IjQ>
    <xmx:SGTUZ11-dgZWIGI4GodCm86zrZ6NWw7kL9dlrjaQa2T3uopdZiug4NWG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:15:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
In-Reply-To: <20250314161010.GA8522@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 14 Mar 2025 12:10:10 -0400")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
	<20250307195057.GA3675279@coredump.intra.peff.net>
	<xmqq34foefh8.fsf@gitster.g>
	<20250307225444.GA42758@coredump.intra.peff.net>
	<20250308032309.GA584028@coredump.intra.peff.net>
	<xmqqfrjkao75.fsf@gitster.g>
	<20250310160440.GA26189@coredump.intra.peff.net>
	<xmqqsenk7mab.fsf@gitster.g>
	<20250314161010.GA8522@coredump.intra.peff.net>
Date: Fri, 14 Mar 2025 10:15:51 -0700
Message-ID: <xmqqldt7ildk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That would use the flag in more situations (blocking the known-bad case,
> rather than enabling it in a known-good one). It might hit more false
> positives, but I'd rather experiment in that direction and see if
> anybody setting DEVELOPER=1 complains.

Good.

> After all, in either case it is
> still a big question of whether this is the only false positive we'll
> see, or if this is opening up a can of worms. So I consider it all
> kind-of exploratory.

Again, good.

> So that patch could look like this (on top of what you've queued already
> in jk/use-wunreachable-code-for-devs).

> +
> +# There are false positives for unreachable code related to system
> +# functions on macOS.
> +ifneq ($(uname_S),Darwin)
>  DEVELOPER_CFLAGS += -Wunreachable-code
> +endif

One possible downside of this is that we would not know when their
compiler stops giving the "false positive" and becomes as usuable as
other platforms (oh, it came out unintendedly harsh---it could be
that the situation is that their compiler is doing the right thing,
and the right thing is a bit inconvenient for this codebase).

Unless diligent volunteers with macOS step up to do trial builds
with the option when they notice that their toolchain or OS header
files got upgraded, that is.

But other than that, I am fine with this.  Let's have this for some
time to see how much problems (false positives) our newly added code
would get to judge if it is worth our time to deal with them.

Thanks.
