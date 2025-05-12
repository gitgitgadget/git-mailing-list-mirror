Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A224EABF
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069420; cv=none; b=EnQPQHNjVxgO9KE+OjEw2jdDkP1LfjcR9YSFu5uQ8sD6V8f2koTDm8Lsldu6KblaVijD3jet7L41RuP5ZaJqc9s4z0Ym5h9Yx3bel4a0rPTv+ebOdC/yo9crpEw7C8eXAjiISy/muGDgjnRqOf31NXtZsV5EJv6l5BvIv9+P7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069420; c=relaxed/simple;
	bh=avA48IeNtMhrTu8KUM4PXXfRTUdtLNVgbSgol6IcSIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KK3KIcYtp9Xi658n3ZsK+csol3/Y8FXcEMXNztMXOq9I5Nnt5VyL1CcjDDXq362T4cNVN7P545Le9xOw962U0JuRYSepZ/A8KLfYN2nnJyEFF0Rj3zZJh4gjNWmcdXKhKjw6mB1HPnEVZVfm8I8bv6/MniDLxC9m0hr4wzL2G/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LehLyjlR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=spdoDacr; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LehLyjlR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="spdoDacr"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BD932114013F;
	Mon, 12 May 2025 13:03:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 12 May 2025 13:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747069417; x=1747155817; bh=aZbQWaecic
	LQQjGpcImow1Tr1R17tv4vzvlREK3NsZU=; b=LehLyjlRmGY4gWzeMHelxiQ2Hp
	cX0vbUFLexG50yL/3P6OIUz89sLg15aO4ni6szhG5tF8NJbWlNt30v66XHXXCkVw
	wg9fZIDfsnETezAX8rham7E8AhgDKXRTZI3p4g/RlkyA1ZFOHLKukPyVfc0XAsw7
	UCOwTq/TE2eoyLRHoyKkPqyTKxF8JnGkFJExreAhW+80Q6j4z8RrmbqpA9lIo5sy
	nUIsaGj1/ovOL8Wk5ISWjnOpNdgjdp6Wbh5C6gPbEdagKS29EchpRlnutaUTXywl
	gVZlKNhwk4PN1UldaQUl3omp+5N6MbfzQTpLR7n79jBP3ivWd3wYqPUfB+2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747069417; x=1747155817; bh=aZbQWaecicLQQjGpcImow1Tr1R17tv4vzvl
	REK3NsZU=; b=spdoDacr897zcqYN5iUEzU/Rxl/H1F5wBwRl67itq5c29jqUrwT
	tD0/KiEGZAQgJVac8bkVB23YtcKsKJTAPqS/j8/E8fmR4C1IztnMJWP7qtDeGiYD
	O/oh5Tt7+lzIPci6pWkLpZHB/vdF+Q3dKTFWRPCH9HuZ3oN5WqwCSiA/AIFNQH0L
	1MX3iPC//hVxe2xiOvGBczH0tccZyLtUExUbXwlEukbPkHDxoGdWHIsNdhIigGIi
	E5jXm98xtsC4vi5vhwjGRdjA0DgGLSona4wrJzSIzJ5pgXEnSH4f3hrPg1pqYW5o
	/2xMWXQENp2OLGrIr3nMdkKrhysQyJXSsPg==
X-ME-Sender: <xms:6CkiaA0i5wHuxdSqrjHrIO2n8rXBftv6b64ViMblJDp7etzXe8Mdiw>
    <xme:6CkiaLFJ82n-cqDCgoyFibJL6g6yRvvpNMA0-Hm2Jzys7ZM6fOlUVZTMVQPyLM8Px
    YodEE2XhUi0SaKvXg>
X-ME-Received: <xmr:6CkiaI6-VxXDJAptmHzQMXgiwNMY2UnrRNBLkDLveldI_GPokkgtRyUezS-DUgtrAMoKhrefwuKa-ogmxu2jN-iv7coNJA1YAKeFJQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddukeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtg
    homhdprhgtphhtthhopehrvghmohessghuvghniihlihdruggvvhdprhgtphhtthhopeht
    hihtshhosehmihhtrdgvughupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehstghothhtsehgihhtsghuthhlvghrrdgtohhmpdhrtghpthhtohepphhhihhlih
    hpmhgvthiighgvrhessghluhgvfihinhdrtghh
X-ME-Proxy: <xmx:6CkiaJ0iW_8PD87Si1m0FMnSnJZJPf8CUWUsRu9ZpQkJEhz7nLa4MQ>
    <xmx:6CkiaDGP5uUnAIKYXy7BwZee_XYu8rIEwl9KayKiJDNUDF63ihhf9g>
    <xmx:6CkiaC-a4wfhEKwk0OTkhrAtQJoQHhStAYinpj5-s33nf9F_8cxCZw>
    <xmx:6CkiaIlxYDCqeo-_9yQdOhTWgSTZBX_weKAxKuiII0CEDjg8RFS6mA>
    <xmx:6SkiaOq6Z1AwNJkcWu1AP7Tu00IrflgnLbb-IGqgGjdY8XyGyRCydc6m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 13:03:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Nico Williams
 <nico@cryptonector.com>,  Remo Senekowitsch <remo@buenzli.dev>,  "Theodore
 Ts'o" <tytso@mit.edu>,  Git Mailing List <git@vger.kernel.org>,  Edwin
 Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
	(Martin von Zweigbergk's message of "Sat, 10 May 2025 13:31:32 -0700")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
	<20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
	<CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
	<D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
	<CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
	<aAgWytQNqtLzg2TU@ubby>
	<CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
	<CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
	<CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
Date: Mon, 12 May 2025 10:03:35 -0700
Message-ID: <xmqqtt5pu5g8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin von Zweigbergk <martinvonz@google.com> writes:

> If we instead had something like Mercurial's Changeset Evolution
> (explicitly recording how commits have evolved), then we could have a
> similar identifier that was based on the original version of a commit.
> To make lookup by this kind of change ID faster, we could have an
> index from commit ID to change ID (i.e. original commit ID). This
> seems to imply a commit can have 0 or 1 predecessors (0 for brand new
> commits, 1 for rewrites), which is different from Mercurial's
> Changeset Evolution, but not necessarily bad. For this kind of change
> ID to be the same across repos, and assuming the predecessor pointer
> is stored in the commit, we need to make sure to transfer all commits
> back to the original commit when we push to a remote. As I think we've
> talked about before here, that can be problematic because the user has
> to be careful to check that the intermediate commits did not have
> anything sensitive in them. It's also often wasteful to share all the
> intermediate commits with other developers. Another option is to
> transfer the predecessor pointer outside of the commit object. That
> has its own problems, like being able to create cycles in the
> predecessor graph.

A few comments (not necessarily strong suggestions).

 - I do not think you need to limit the predecessor pointers to 0 or
   1; when you started from N commits and worked to produce the
   final single commit, the result would naturally have N predecessors.

 - The predecessor pointers do not necessarily have to participate
   in the object transfer, just like filtered/lazy clones can ignore
   the tree pointer in a commit object when making a commit-only
   clone and the contained trees are fetched from the promisor
   on-demand.  It can even be set to be filtered out by default,
   since it would make unnecessary transfer cost people would not
   care most of the time, and only made available when the user
   expresses that they want to know how the change resulted in the
   current shape.

