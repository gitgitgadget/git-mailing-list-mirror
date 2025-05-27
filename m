Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890D27605C
	for <git@vger.kernel.org>; Tue, 27 May 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359808; cv=none; b=jcGh7iHrY6T47DA81CEl4sYJ0COPbYBUPrtl2+N9cDPLmfAw+fZynygmzoVUHGAtzgEhMuV3qgWC30bhEE9y/sVkgl/U+RNJBYi9ZbXC4zVq8tJPumN2zIMSBi/ylhpSg9MWRzbYif5CldWIJmRSpcymiPXqgtpN+BqUAfJ5644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359808; c=relaxed/simple;
	bh=ytDvuAy1II7PTkBIi0tL7WDLh+OG0uRu2LjOnUcC7jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IFllCV1NApkvCvIBZv4WaGiNqNpufKjKOe/SAlIXfgOv7JN/JEaFNvQ03G1a1gi7fE1pMuRswwa4pX7WTLQx0Lv0C5IbZEgE1LbKnXYQQxSDY1ixAWzWTh1+yNLXuKGEv9HsMcTsmaZ7v4l17l0LB44WSYYKyMTnj3tusTc2XLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b8QkMNXR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbMYoOA0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b8QkMNXR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbMYoOA0"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B5E552540140;
	Tue, 27 May 2025 11:30:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 27 May 2025 11:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748359805; x=1748446205; bh=80Ne3fhU1Q
	6NmVwzkrrmDlyAGbCNQe2pwHMHBNxt3FY=; b=b8QkMNXRYHavJC+sWtxiWWLC21
	PP2A0X6zrWAnX/b9EHgtAWiFS1vujnIoUaLqXiMaofw7/OMlmN2HqAa4MMcHUyjS
	eBmPKkq1mNKgRVAV33lpyh3K+BgZBb5X8GNR/KDz5Jc1D0dYTORlOJjqBNAqPwVf
	CGM322pz8AlU9MAWqkbhUxQvoYXHzVrHBbkkKO03YvPJDba0aLu2G1ClKouLSW0t
	d7YBvnj3wxrzxwMWMbcBB4vDOrWn5z4IMyKaDN1ThKE8P+kMHE8SIevFiN9kdRjr
	6K/pamW9XL7h/Tde7yQmegEP5qwm1GVDlXn0Wu4KKSx4FTSM2C4r4FpopXGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748359805; x=1748446205; bh=80Ne3fhU1Q6NmVwzkrrmDlyAGbCNQe2pwHM
	HBNxt3FY=; b=IbMYoOA0kEydgsoHUXIpD+biZxBovVhmWjOcVCLe5BaVk3xaMw4
	2w5nJf7EB0ZT3Gxk9VaZ46DWFM81MrCYys381U/db5Xo9DTcDVz55BPyznfAgkZ1
	tiqWVg1igCtB/jlj6e4Aju5WJfu0FZRy9V/nNEmsVENUnMVPHmW9i4E41/hRjDmD
	b16cdsAF6g90mmDGXC3jRdS/ebuaoRlF5Nob9gHwfN9V/WANNDRFr4XQWGMrsbsQ
	ObismB+RZHPAieKpxbvhQVjximlVbasf2c7gQZSu9Bv0LpqBBjOjc+LRJfMg+8VJ
	kRSuoGoMPv2H+sOdONb9hIBNVJXn+9QGJdg==
X-ME-Sender: <xms:fdo1aPArpVZK8is5yuWYeEjzVB2e82_A66jAyMzqnJZZBguI8_pO5w>
    <xme:fdo1aFhxAzNhabs0S9vXDR-kt-8yNVuObla3nl9nF-JzoStHB4-QvmguxM2orkNiC
    IG2I1mG01aBejrQkw>
X-ME-Received: <xmr:fdo1aKmqzJTWgTD2cvt_g_cq2_C37aoBKLDXIAWIf2bKEvki7hORec2DBcX03TyFBwsciyPOvqrIX7Gtb4CnyJgYcyL5iNvh6bfEUcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdejgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:fdo1aBzsJ2MiTHMTtm5pQQ1JNhDmIgn1hP1eSKXv_n7nQCyQdMVgbQ>
    <xmx:fdo1aER0NERFTcJeGRJ_q0ky6ijEDZ5J87ZBvkCToYTos__Z33AXiw>
    <xmx:fdo1aEY1YdLbAIiCVpXapgBq5sR0KnDzx1vnfYL3aGfRvNDnQlcozg>
    <xmx:fdo1aFQkZizyamT0SFCbfic9lpIsontr2pu3OVWPD4p7Mj2llfZNKw>
    <xmx:fdo1aLP2om8EyR7POAsxsJdp5FiqTmv5fhNuSSVxJqoMuPg7Y5ZBpfoX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 11:30:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Taylor Blau <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/3] promisor-remote: allow a server to advertise
 more fields
In-Reply-To: <aDVu4JmTU7Wz32Z7@pks.im> (Patrick Steinhardt's message of "Tue,
	27 May 2025 09:50:56 +0200")
References: <20250414160343.2216312-1-christian.couder@gmail.com>
	<20250429145243.992252-1-christian.couder@gmail.com>
	<20250429145243.992252-3-christian.couder@gmail.com>
	<aBsZBytP6TzMYCxl@pks.im>
	<CAP8UFD1+c11JgSKzs=A39-5EP2Senob-NxSXB7orU0usSLT83A@mail.gmail.com>
	<aDVu4JmTU7Wz32Z7@pks.im>
Date: Tue, 27 May 2025 08:30:02 -0700
Message-ID: <xmqqldqiqdfp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In the current form you need to reflow this whole paragraph every time a
> new field is supported, and it's easy to miss the exact supported
> fields. So my idea was to maybe move the supported fields into a
> bulleted list. E.g.:
>
>     promisor.sendFields::
>          A comma or space separated list of additional remote related
>          fields that a server will send while advertising its promisor
>          remotes using the "promisor-remote" capability, see
>          linkgit:gitprotocol-v2[5]. The following fields are supported:
>     +
>     * "partialCloneFilter": contains the partial clone filter used for
>       the remote.
>     * "token": contains the authentication token for the remote.

Excellent.

> I guess this is mostly because the config documentation talks about
> "fields", but that term is used elsewhere to indicate a name-value pair.

... which suggests the use of that word needs to be tightened a bit
to save the next person from getting confused just like you did,
perhaps?

>> Also we can extend this setting to be per promisor remote later if
>> there is a need for it. I don't think it would be difficult to do. And
>> I don't think it's necessary right now, because it's likely that for
>> simplicity most servers will manage all their promisor remotes in the
>> same way (at least until usage of promisor remotes grows a lot).
>
> Yeah, with my fixed understanding I agree that it's not necessary to
> configure this per remote as of now.

As long as we can extend later, starting small is always good.  We
can do "promisor.<name>.sendFields" later, for example.
