Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314E2DCBE6
	for <git@vger.kernel.org>; Fri, 23 May 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036172; cv=none; b=l++VUDIgE3l3a+l0zLYos76ntX2wV+HcyWAL3EZ6CrupVtHEz8TPQtPQ0bhWwAOhM5iuYdUZyeleveyK7IBd46gkBFnoI3z9MOB2Z7A8uVqH5BRKVl6rk0FCYdXumIHXe4LzUz7D5YzNBgmio8sS1vzIJVfItkfVL5HvIGDwQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036172; c=relaxed/simple;
	bh=paOVB9MCxz+l9lgzbufhhhxEieK5ztIvY66Za2ulls4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mXcpbdgwkOwcVALoT22Fyh8O63tQdCe1ipE6rbOtjSJsMR7w5Ldfz0aLf0zJPp/Xw6YRYi+i3q4nNmVniIWcNqNKa1Uoc7QqBTmO5A/L7ndEN3WySj332p+ydZeynLG+cq1s4hAfJgl8k3Lz1KtIbbWBTeCu3G/MNMPISFNJ0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jP+CxErw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OhhPouTH; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jP+CxErw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OhhPouTH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 02C7B11400F8;
	Fri, 23 May 2025 17:36:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 May 2025 17:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748036168; x=1748122568; bh=CQFMKNmlyQ
	1nppy42hOfIVPbvkuvymlv9vqboATYU3w=; b=jP+CxErwQDabbvaQqjv2ZTiGzo
	ysAbdwlVBFsAWxdsei/FqwPbwqUPsTpiN0fwvxhYCZGphxbSQEnit1Dy+VFJm1Dz
	2bG5Lrcd71vJQSAvVA09q5Nn/frGf7C4imWLSYEVQqmB/pzytO4Igg9s2cgy5a0/
	f6flEFq4F/k30gYBk0HoavBzyaTWJn/9fACv6TFY4Pi0Xy13J1RYvq8jy4pefEE4
	1mqRcqwhkcoVcavzV4n4ApYhEJP4nxtVQuXD5NArG4B62MjW15jDgLdva4CKPRzY
	K0j/1mSx1eDotJ78uUw5lyqivog+mIdyX8w7MtUlLhaKHLs5OR0Dcwt5bnPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748036168; x=1748122568; bh=CQFMKNmlyQ1nppy42hOfIVPbvkuvymlv9vq
	boATYU3w=; b=OhhPouTHetcfGEfVZmQVGfWSYBMzDCx7kDfOwX/PHAtrMScCtH4
	Zm+dpr5tPyq3LC1HUlSnt7dkO9T6L5ciRZBjrk73+R6SaJqxoFxiPTkzMJ6y4vfy
	LSyvALGG9tGy77iHVg9KdKN6XybHhSqq6Ni2oo3/rYI7aFOyJXSaCheoeSCnu9FK
	zCXp+9g5+Fdf27rrN/SXO9VLAXJx/aRwvi4d6SRJbTnf7qQdJiYjh/YE3V8c9nC8
	psKiuNddHuO8KA/1ILZx8+rQlENrZTKnwXXkpkNTfYAXoyyG635FWbJQvLNeWf01
	0m7l6JHt3hRUuH/dLwDcm13VRr8CV6GzhDg==
X-ME-Sender: <xms:SOowaJD_zvatQqqRB0UyesJpLB_weEbrBkBOdQ_Byzrm7UJ65P-uqg>
    <xme:SOowaHhMdNB4R_7FtfHsQbK6WaNSRJOe21gvRM-Kji33dks9jK7bq4CR36NhOtWuv
    NLqm-a1sBis-Fuuug>
X-ME-Received: <xmr:SOowaEm3OMTS4SJYqFy9_QZuennJRmH4w6El-eoS7a2o6NIA0HmEC3LkUPXjaHXuVYaqBCIX552Nzuc8oAMCO3LHhW0AakB-TyFmtGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelleehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeu
    ieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    ejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhi
    hrohhnvghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:SOowaDwMAQuhzWDbm1xU4jRn19qYcv893FG_lnYLtfv2EN5tVgdwXg>
    <xmx:SOowaOThAyzskEyRY1E7OzW_hh8KTnV_0vIZz0TR2ZVSyFCWuZnVdw>
    <xmx:SOowaGaisLFyPexoiiD2LPQH7dehaFKUODPe8LSP_c4iRCde8dm2vQ>
    <xmx:SOowaPRawvZRUt49h5DYTvjxCiH6mtG4CC4ocj6eozK18OXGYniLXA>
    <xmx:SOowaLNUdbkf-2uT7ivaSHE0VJGi74PzJS7x_r7Eso6Ggya1ESmaT37b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 17:36:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Teng Long <dyroneteng@gmail.com>,  "D . Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 6/9] doc: notes: clearly state that --stripspace is
 the default
In-Reply-To: <be89c3349d24e47a38f04538d3d1e3730dfc37a9.1748028010.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 23 May 2025
	21:29:52 +0200")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<cover.1748028010.git.code@khaugsbakk.name>
	<be89c3349d24e47a38f04538d3d1e3730dfc37a9.1748028010.git.code@khaugsbakk.name>
Date: Fri, 23 May 2025 14:36:07 -0700
Message-ID: <xmqqiklrvwl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

>       See the review on the patch:
>     
>          https://lore.kernel.org/git/xmqq4jp326oj.fsf@gitster.g/
>     
>       There was concern about the order of options:
>     
>           >     ... One more thing need to note is "the order of
>           >     the options matter", [...]
>     
>           This sounds more like a design/implementation mistake that we may
>           want to fix.

That is a comment on the 8th iteration of the series, which is
different from what you are documenting, which is 11th if I am
reading the thread correctly.

Comparing [v8 6/6] with [v11 6/7],

https://lore.kernel.org/git/f60f743203d78a489b90df81472e71391b45367d.1682429602.git.dyroneteng@gmail.com/
https://lore.kernel.org/git/19865941bb29c28a690ed3e28fc4f6870e352923.1685174012.git.dyroneteng@gmail.com/

I notice that the later version has .stripspace member in note_msg
as well as note_data.  note_data has a collection of multiple
note_msg instances.  Each of note_msg comes from various sources,
like '-m', '-C', etc., and each of these types have hardcoded
default values for note_msg.stripspace (mostly to strip but note_msg
that comes from an existing note blob has stripspace unset).  When
concat_messages() takes note_msg instances in a note_data together,
it _could_ do:

 - if note_data.stripspace is explicitly specified, use that,
   otherwise use note_msg.stripspace, to cleanse the message
   contained in note_msg.

and concatenate the results.  But even at v11 of the series, the
implementation of concat_messages() uses the stripspace determined
to instead cleanse the concatenated result.

Which I think is simply buggy.

What it should do probably is

 - Loop over d->messages[] and:
   - if d->stripspace is set or d->messages[]->stripspace is set,
     cleanse the message (i.e. d->messages[]->buf) and append to d->buf
   - otherwise append d->messages[]->buf as-is to d->buf

 - If d->stripspace is set, cleanse d->buf (may not be necessary, as
   the messages that are concatenated have _all_ lost leading and
   trailing blank lines before concatenation).

and that would truly fix the problem pointed out during the review
of v8.

> +--
> ++
> +`--stripspace` is the default except for
> +`-C`/`--reuse-message`. However, keep in mind that this depends on the
> +order of similar options. For example, for `-C <object> -m<message>`,
> +`--stripspace` will be used because the default for `-m` overrides the
> +previous `-C`.

So, I think this is an accurate description of the current
behaviour, but we might want to phrase the part that comes after
"however" as documenting a known bug, which we would want to fix
later.

Thanks.

