Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525F346771
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778208; cv=none; b=kWBzW5H/A1falM+oukL9hSTx+4UdCrNx4vvz5iGdsRO8X03JJisHG2B/xTRVQ+MMOwN3yx6m+1LLaHxKABKHxlyaAeH6U1tVijFaBWzzKZ3UAaQcFBgWmuUdqwY8oUnfYXekU9AELKgWV/tb1A/RYWwlVE4IZ+HoV/w5/zm1GeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778208; c=relaxed/simple;
	bh=NVxQ2HvfWCggSZ8RrAFHufoOU9pDh0Rur5tNnVByycc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lBIPKwQWMyrroT8cW4chXjpoCP71zJ/nbk+f7bLQnM7IXuEpi9SHI1W2tnLbpcZJtsI9qxYObL+y2oYp0SlZGGzewl0+xMvC3S6bDjuTxQsTpW7NDslrJR1zZqAUyqAhBNEJbpz+/Tzt3md5F06ysjsdzw7D268ZjfwiRTn5ji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oz1ItfEp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5L5JFzz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oz1ItfEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5L5JFzz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FEA07A01ED;
	Tue, 17 Mar 2026 16:10:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 16:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773778205; x=1773864605; bh=6XPfD6ZrzJ
	KG81p+ldUUHIy+dFG1EvOlhSDIKBZwkTs=; b=Oz1ItfEpf+V/hbOeknBo5OZLfg
	IBMDOvU0SGHXKf/oRDKln55fIR6oxeWauyrbivvtw2+aHyEOTBZ5kloy/LWiE10K
	qvp9046mKJzZYF+pr5JfYFouTwzGiIFXkEjITnxyS66e3HYozwwY6mDAIurQs33h
	XqAVubdHCynENFJUYrayhbZwevM31qO+fMl7qNyTOWx59/Lj0dtoBlw790Jb4Ypw
	rILDVQaLb2n1msbMbJhxUFlsB46xG1zprB10HhDZlPu8rDSmWx8OUFLLORpkJRMx
	5xxzwGPViXBf3eroSQNo/1OiFqAkKKHBOyaOOK1hTYng1BZ8nAkQ0kk7bmIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773778205; x=1773864605; bh=6XPfD6ZrzJKG81p+ldUUHIy+dFG1EvOlhSD
	IKBZwkTs=; b=W5L5JFzzIorf0RogDyY7jo+JHgSlSEZevqp1kylZDGcMA1LCWNS
	Z/EGdW2NfwSYh87Ou7fGG/Yfo9awIRey8eJIN5ryU3iAAGdx6iJm31+Grfl2InYZ
	oL20Y1JY/RWsLVugel4Us174+oJzRhKEWsc8nJjdHHyGDA1SdFKlLIBDSvN/JfmY
	PDHA7wBKqRjNj/mqNSWPtX/RAsxn6siBLwhqQU0lNbRtOG/AGTRR+T9fLwM6NzMw
	M4aLBOqv3e/aNFrflTUtH4rakbxxDFiGVH47cJQy0sySkvXVYYmtApXK28/cbA0x
	X5FMIT8POWC5KMr73Ea9FqOysbud7D+mS7Q==
X-ME-Sender: <xms:HbW5aYb5CWAKWtYlsQWRNr9O-2GWE-FX3kWJ7aePj_RTxjg6EB1wHw>
    <xme:HbW5aa2Zx8d-db0GHSHsB1qgKEiAeTA2lirtGKEkfEqGINPG4ybdZVWF83sejXoCM
    oYerWnTikHrrEc9uD5X_czmY82ugYpIHUDQlElo3RHhaz7mEoaR7g>
X-ME-Received: <xmr:HbW5aQXlB0oySyHqSUwdk5Gfky67tLYI8TDOJPary9NgGURyDMgTPd5DYYCRgl5VhaNwe7kQDrEc56cwepmalpkv_yjYlAD9qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:HbW5acWEhfyoUGKAcP_I3b85H5W7NVIAj-rEig83qTQGv3HJg7Zr0A>
    <xmx:HbW5aXcBICAiRw9vKtTRQhM0UMEKCNIA1L4MoZRTHFhnlbjUpHSlvw>
    <xmx:HbW5adUKNwVLj3M26R-DCcno0sE7fWRSoz6yaBF5WxWI4Tbyj1XHfQ>
    <xmx:HbW5aYcEWswjMecZHaSnb_6GWmVpPfsEtl7cLMnOfjLXih0t32kyhw>
    <xmx:HbW5aS0-CGYixRevJ5ZEKhqW2qGpMwjSlMK96JanSpfvB3V-7olH9MtC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 16:10:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] add-patch: use repository instance from add_i_state
 instead of the_repository
In-Reply-To: <20260317165230.628705-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Tue, 17 Mar 2026 22:21:38 +0530")
References: <xmqqzf46l7x1.fsf@gitster.g>
	<20260317165230.628705-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Tue, 17 Mar 2026 13:10:02 -0700
Message-ID: <xmqqse9yjjz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> > Functions parse_diff(), edit_hunk_manually() and patch_update_file() use
>> > the_repository even though a repository instance is already available via
>> > struct add_i_state s which is defined in struct add_p_state *s.
>> >
>> > Use 's->s.r' instead of the_repository to avoid relying on global state. All
>> > callers pass a valid add_p_state and this does not change any behavior.
>> >
>> > This aligns with the ongoing effort to reduce usage of the_repository global
>> > state.
>>
>> So we can call this "reduce" but cannot say "eliminate" yet, as the
>> files uses comment_line_str?
>>
>> The <environment.h> header lists some global variables inside
>> "#ifndef USE_THE_REPOSITORY_VARIABLE/#endif" block, and the
>> comment-line stuff is among them.
>>
>
> Yes that's right, there is an instance of comment_line_str, should I add this
> in the commit message and send a reroll ?

Having said that, please make sure your patch works well with
patches others are working on.  In this case, s->s.r would no longer
exist after this one:

commit d51b61f5dab9c8e715fa792f31d572bc96fb5687
Author: Patrick Steinhardt <ps@pks.im>
Date:   Mon Mar 2 13:13:07 2026 +0100

    add-patch: remove dependency on "add-interactive" subsystem
    
    With the preceding commit we have split out interactive configuration
    that is used by both "git add -p" and "git add -i". But we still
    initialize that configuration in the "add -p" subsystem by calling
    `init_add_i_state()`, even though we only do so to initialize the
    interactive configuration as well as a repository pointer.
    
    Stop doing so and instead store and initialize the interactive
    configuration in `struct add_p_state` directly.
    
    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

A good way to ensure that you do not send a patch that does not work
well with others is to make a trial merge to 'next' and 'seen' and
ensure that they produce working Git, after making sure your patch
applied directly on top of 'master' works well.

Thanks.
