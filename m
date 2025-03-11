Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95B255E20
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712245; cv=none; b=YvJYG2S6aQ9P6Ab7LaQIns5TQ3GLFz+FfY36F03SM6uFkFDzviQOgiZ3qCeVO8Rt7gcsVovmtBSDGDQlMz6UXN4MQtiD7T2n1Ei2i+r1+OKPukJTV8OyKAh7v98oR0TbHJz/zsebEdB2ChArbiOzjG/Kis8Xu0n/ocYwt9QW7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712245; c=relaxed/simple;
	bh=5Vs7l3c7TQH9Qu9ODO8IuE6+0GRxGTIS0Wi1UPjJock=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jdsWwLR8MRb4H59exmzMfQMe/1zV/NmutJ5cpN68OO+3ce50ooeoJpWlhYUIO/eAVWdUGGWBulqwHmow6/gFc5bQ1x1PB+jc5u4GNLyukz+p3XpOdrzDj6SSGZV5cZo3bRWk1gRJrqCU1ty1oXNsRpkpleyE/ddiTc5c87HK/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yaFZFQW/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCIYeBK2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yaFZFQW/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCIYeBK2"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 887AE2540175;
	Tue, 11 Mar 2025 12:57:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 11 Mar 2025 12:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741712242; x=1741798642; bh=uu3TZD4M+r
	JF5GNCsm/LHT7d20D5Co5rET7dc95n5qE=; b=yaFZFQW/8wnFfZpexf6EOrTJbw
	yzHlqA+fk8ju8tbbL3DGEycJh9SB/DYN74a1t+Ldv6rRYrHBJlk6JBSqDZyKG0yy
	j0J0D70b7HmPXWxE5t54Mah6vRenk/qqXzGXTDpPYlk+RsWlH4ZeCIZotk42jFKy
	Uug49n0sct5I4x4rrwvPTEvsa0u+Imufk4hYK2oHOmOoci23duDQFg/KgGvYtE4J
	Sq8nBUHKw8TBOuyrf7g960E52KC8hirFIC1dAiROZGDtLfgjn/hPLUUr7PMhh9fM
	6VdX94+bMJkoUFV8lRhbHJguPVbqWwIBStV5FWeu5cEv29Nh8etd6Dt0L+QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741712242; x=1741798642; bh=uu3TZD4M+rJF5GNCsm/LHT7d20D5Co5rET7
	dc95n5qE=; b=gCIYeBK2Em87KoPxGLlMFqcIbQ++8E6UNPMiHtn0ITgJhZ6KyoA
	U8fzFKAvLJNW3yikch+nb3MIt6B2pesAsw2JSXbRQeHLbaSEPOGCclAFIUy7bNhv
	q3rSZ3M/52Ex4/YE+NZtP9SRduzXv3e9/3K+vqCLbhQPsdw4jiGzbhBdi4fB8Lhs
	YZ70K7IU6VC7QzZ/rCNEjcGW7e42gXYcfWXz07ozNUGaEZutlAj7IRP4yie/+D5Z
	5NXxNyhYlCn66M5trKwaio8yMjLAlFHhVRG+l6X1EZKEkYPX8gUxuzPh9fOuZizD
	bG3lZQV9R5xKd2fVBCaa3ZdT4DGnXbmmfSg==
X-ME-Sender: <xms:cWvQZ69jzcAwSDzSRTB7Xv6dzJPzoqndln9P7A8b8kkCH3Vhj9T27g>
    <xme:cWvQZ6vHTI4AavFSzvEGA7pIvTNHVq1Vx-RHAEKq2p6qHhBsilOg4r8-lKC7yj3ON
    dspU0TqmawjVAfmhA>
X-ME-Received: <xmr:cWvQZwD-GOUZ0iOnPu_TZcme-RF8j2Q7c0_C7ObfbWfm_LxtcOI3tWXZvyiIV_AwV3xWzF9GNgSfdLFTYGvF80pWWAEFuUPsbB9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghr
    ihgughgvrdgtohhm
X-ME-Proxy: <xmx:cWvQZyeSu2w6sGTngPDQv7_Cg978SUOXQCyQnqcF4aZJxaAcdiP2fQ>
    <xmx:cWvQZ_MIZJvETfj4NT5aXLM8lX3HUfPmeriCp4vnKfGKksQbZPRqKg>
    <xmx:cWvQZ8m9jIQubF76ys53xepE5vYao6bWrLiBMU7Of9w7qb0AQdwvmA>
    <xmx:cWvQZxv2WJgsK1rJw5gj3sDaPXiLZ3bXpdoD2IF7072ZBnVTatpDfA>
    <xmx:cmvQZ8nU4V7YYJ8yPMb3d0suMZXNRvxq91-NqDo7TDFFvYVIDhSoM7RW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 12:57:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] promisor-remote: fix segfault when remote URL is missing
In-Reply-To: <CAP8UFD1ujnSYEnNO4xifwXj397V-=1kJSMGJ3j613+qVAkyg=Q@mail.gmail.com>
	(Christian Couder's message of "Tue, 11 Mar 2025 16:24:40 +0100")
References: <20250310074053.1886097-1-christian.couder@gmail.com>
	<xmqqo6y897cz.fsf@gitster.g>
	<CAP8UFD1ujnSYEnNO4xifwXj397V-=1kJSMGJ3j613+qVAkyg=Q@mail.gmail.com>
Date: Tue, 11 Mar 2025 09:57:19 -0700
Message-ID: <xmqqplin4ia8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Actually strvec_push() uses xstrdup() on the value it is passed and
> xstrdup() crashes if that value is NULL. So another way to avoid
> crashes would be to make xstrdup() BUG when it's passed NULL. Or maybe
> xstrdup() should just return NULL in this case?
>
> Also it looks like strvec_push_nodup() kind of works if it is passed a
> NULL. (It adds the NULL to the array and grows it.) So I wonder if the
> right solution for strvec_push() would be to make it kind of work in
> the same way.

Meaning "xstrdup" -> "xstrdup_or_null"?  

It actually may be a reasonable thing to do, to remain parallel to
the _nodup() variant, but given strvec is about making it easier to
do argc/argv[], allowing NULL in it does not sound like it is in
line with its stated purpose.

I also do not think checking inside xstrdup() is a good idea; it is
at way too low a level.

> Anyway I think these are separate issues that deserve their own
> discussions and can wait for after the 2.49.0 release.

Absolutely.  

> Here I am just
> providing a hotfix for the "promisor-remote" protocol capability.

Ooof, I didn't realize that cc/lop-remote escaped
'seen' with such a bug X-<.

Thanks.
