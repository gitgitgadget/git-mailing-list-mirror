Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2C28A702
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224652; cv=none; b=GeJWYt6BFz+AknZ3EZSjP/eEazxX7U25Lgmm9/JRXeZdU2X/5SQWvuFqQzlcwF3WzUoUykeqBerL6SqD9hRhaNGgZhlz1SddRtmMTFz+nMoBKJ7HbyV76bm61gg5T77AKXPvMFo5I1UukizWi/WkI1vnBNjLrXP3EoIbP2cpkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224652; c=relaxed/simple;
	bh=t7pctGNhl3hgASOrXN98t5O0MzmUCVvDI3WT4uJznLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R03WZIseU+RmPcPXz7CFSxm7sTkhtKW/4DmORO7YDeIUnb8u8RilkjljZYn/ZoR9IK1hc1pHzi2MMlpIExPk8fkjKaM0NF7WYldncrAhdrbA3dqeQ+x5pH60s1+bxZ3ktTMm1Ewt3Z0LM+qCMSBDpnZz5oG6HJKhd05vCrC0OwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S14vyAYr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxg5NLJw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S14vyAYr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxg5NLJw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E9AE1140128;
	Fri,  6 Jun 2025 11:44:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Jun 2025 11:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749224648; x=1749311048; bh=TQuZOBizWg
	IUZtmjf5tO7HTPqAqRZGvdjTMvF51CUJg=; b=S14vyAYrjVEmK6AqzvzWnmFi+E
	lUP9A/eln2Ua5tb2H/n044OgxisfkgM019CwJv/98AjuhyfTmbP3y02J64T5y7eG
	opIWCwDND3GisUKdxNqlKcUvWvvbBhHydwyW2h9NSCu8fEmWgVpIOUDAtY6OHXrJ
	eDQwlz2hOQNJG/HUmpU13aR3zcvzQI9Dg6HTm/e3oYMO05aLj7yKPA3R+3o1IM1Z
	WEWYlUVtp40g6ajUW+IAfupTMCiijmjsMIyzVoA0UzSqenPKfmkCm9rSRo5NKcc1
	SpqOcHt+Y8lQ3Lws1RUngWMWtvpZuBpkef2/mvSZH4tCK+02Q8Ak8+ardHDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749224648; x=1749311048; bh=TQuZOBizWgIUZtmjf5tO7HTPqAqRZGvdjTM
	vF51CUJg=; b=qxg5NLJwuoFpNxhM5LfACI5uYDBgsR5FnGxC/TwvaplzYsJ6oPX
	F5ErNGRK0LYD7JhpHBprKWxAaiB5fx6UrjLjasnb18BlisB7HExBVWfWTBkvfE+R
	xQj4PaS50S0IJuFjnxAp3qhBOaGUN+9D2rmtJNgP8IQ5Er9tQRwkYsyGHGHdSh0k
	SXscCc7t+kCzYsZU8G7UyymXzeMjFhT/BfQyUJBUVDqKmsE3dXUXr2UKfbC8S+qd
	5eb3L53qK9XmZwfoMm46415hozmcbonS6aPNW+TUDB1Nssgci1soNEAqwV5uQkrQ
	8eAFp+Nswf6sw7nMPL5b8+e6eS5HeGkmBFA==
X-ME-Sender: <xms:yAxDaKtmxyrNV5JlJsr2f1fnH4C86KtB62EaGlmoEQ5320ZqHsKjsw>
    <xme:yAxDaPd0vpQvKwRmL_7KBbLphwkZWRAL0Ek6w-i6IxQ_PZ7oaqz-JcDO_N648GOpi
    t3GYJHNOXKKG_59Aw>
X-ME-Received: <xmr:yAxDaFwPQm8mzU9WWb7bkzrXXVhqTO5QVYRfAsrmLlODu3wcHhEmffjlFjJs9hB7DYL6lIYDRWD0Qs63deF-Q6Skm2z6Dri61LGe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehmrghrthhinhhvohhniiesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtghomhdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehrvghmoh
    essghuvghniihlihdruggvvhdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvkh
    gvmhhpihhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:yAxDaFOeoO5PdiEpeHyuIT_hMHv2Mihl1icf3-BX61Ha98DGlh4W8g>
    <xmx:yAxDaK-_aRM5lRMWMJI2SoAZF5CKsMOSNhNAUyoqhpAZOrPkcHK9xw>
    <xmx:yAxDaNVzeD7TruIS1iO0s0m87Y8KeSpOfp2NEDKCfv9BqfHJZkCIeg>
    <xmx:yAxDaDdBVMIZ5iptZeo8AQpd57DL46bs4rvJO1IFKhzWJFbvqlPcvQ>
    <xmx:yAxDaPDjtSGdPgKNmLYYW8WAtZC-TH6dvJZTkVvTKn7bY9ln9Ufea-RB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 11:44:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Martin von
 Zweigbergk <martinvonz@google.com>,  Nico Williams
 <nico@cryptonector.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Remo
 Senekowitsch <remo@buenzli.dev>,  Theodore Ts'o <tytso@mit.edu>,  Git
 Mailing List <git@vger.kernel.org>,  Edwin Kempin <ekempin@google.com>,
  Scott Chacon <scott@gitbutler.com>,  "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <87tt4t12c0.fsf@iotcl.com> (Toon Claes's message of "Fri, 06 Jun
	2025 14:28:31 +0200")
References: <Z/amMj/eg0RbXdkS@ubby>
	<CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
	<D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
	<CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
	<aAgWytQNqtLzg2TU@ubby>
	<CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
	<CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
	<CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
	<aCJi+4q6DZhnfdy+@ubby>
	<CAESOdVD_Cse6AjwLb-4QKjdo4ESWwF3FzSS5JaHbE6ZrMjFeZw@mail.gmail.com>
	<aCJwgWaNoBVjvImJ@tapette.crustytoothpaste.net>
	<87tt4t12c0.fsf@iotcl.com>
Date: Fri, 06 Jun 2025 08:44:06 -0700
Message-ID: <xmqqmsak50zd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> ... But on second thought, _some_ determinisn *can* be
> useful, for example when different tools try to generate a change-ID for
> the same source commit.

Yup.  And once we have such determinism for the change-ID that is
given to a freshly written commit not derived from anything else, as
long as different tools use the same criteria to decide when to and
not to carry forward the existing change-IDs forward to a commit
they newly create,

