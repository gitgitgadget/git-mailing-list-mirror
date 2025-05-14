Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42E1DFDE
	for <git@vger.kernel.org>; Wed, 14 May 2025 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197107; cv=none; b=j4TdHcOi9YZK9UuZI105j8TKNZT1IbMzAX5bzOoEiTtZbKK2uToCebHWWdnfw1qFb3r/E3joLQW1lu+FCLxtg1vtH72QMb5e1BOozgqe0/zQ9k4Gnoly3/fEkieC8BxZMl/OO6jbV4DfuovSTWafbmPGe9NDS9t5k7ULjbljCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197107; c=relaxed/simple;
	bh=83M0XqeniE4r768L0Oa17crn8t5GYIYSmu8i2lVlkCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne7tYKfvLFSl3yaDpZAWfcq5Z7IV5/uHmvOPtcUL6qIFvxJkzvQy43f+qOp6IEVax29bOJpDOIcmbw3n7lT9ldSYTLlRo/yYd9v+/25irczXRZLHmsmx7UOvmS1n9tj66pQZ7kAgivcqJEJdIUBZCOk1cU3fbh6enuOhhktdCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rdwjcEJW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NoFsdtRZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rdwjcEJW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NoFsdtRZ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 929631140115;
	Wed, 14 May 2025 00:31:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 14 May 2025 00:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747197103; x=1747283503; bh=l1qepW74+m
	hWODHHru8s59/5uHWdhxRXRe9a2oZjo8U=; b=rdwjcEJW13VDaDcEitKIVINbXa
	1hO/gIPe7ezLyL7xKwsi5Vpq7z54/wfxh8xMos41K95WzAMzYNv5DxnqD0MMSfeO
	74lNOGLqu0JBVahA/JjYsNshp/IpApt3b42o+5ZdGLY+9R49vvCIledrJQLhFogy
	ZvhM9BU8Fqv90DTqAl4CtriEGmPUoUbiWmOSgyxvdDHc8sxchOxqSM7E4iueBkzj
	bBAzY7mLTKseD161hDKZrPiiIVSQpUo4iT1eZPB4WTCKUuAbOTUhFV4XF05zgJVv
	GBsVZCE+O3J/8e0Gg9CDpcUvbrgj+W2P/R5iei98g56TuBZDhHVouN7uUSFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747197103; x=1747283503; bh=l1qepW74+mhWODHHru8s59/5uHWdhxRXRe9
	a2oZjo8U=; b=NoFsdtRZYRDPjQ/UuJbB3jIbJhzcVkzVRD5vgHCzGHla7aA/Wk7
	fyN8D0IBoLA4ZfESTpBY7wjpOjfchgYp3hToGqxvrVbBwBlrjPGarBAfWyxbTsDl
	qco3vPE/Fgz7oFdO4lZztR3ZylEsS5D6BHIcIW8ZAAThv6U8dAQ20+rXx7zHhJZG
	vZc57tSwLHwASalAIOkvr8FV6LmBkQFqS6K2PPtt95ZggtNOj0B5HslYtrDyfDPk
	mP50s83yzuFEDVkxB7IlNFdjks9ZF6ExOGrwdSDBwAfBS96y2SYR+sgzWR6amO9B
	/QJD772TjJhfBDyRgwzU2tFcyREgV1kjUtg==
X-ME-Sender: <xms:rhwkaKJEmoujLt7sI8GfmdgEAa_BcsBk0vVc1T-dofmP8SeAW4TZnA>
    <xme:rhwkaCLhphPy5qOcCYPnASX2BmmKPvUeh_GWZMDzPYyI5kVJ3eo2J-cMzcFuXks0q
    yfSGx7uSjbUZggrlw>
X-ME-Received: <xmr:rhwkaKu_Ckv82woriRAVfIyCgdR9bPseNVc8AlqmE8Xre9laCrqhjnKO26nOdcB8upCxW9AFekv7mKW8SMbhE32P6MYI6FEYYB9KiyPfWvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeitdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:rhwkaPapTtzWWXPK7tv-HV7zraJYtsYjk_mKhj7S69vxan67utTvEg>
    <xmx:rhwkaBYmPbkfYJGPoAjJvau8mTUp650dQMHzfAEqWyC2fK-REs2HxA>
    <xmx:rhwkaLCXb4Dyll9DKvZ-kQ7UOpRSW2IKZk_6Ep2M88Ll6swtv_S_Wg>
    <xmx:rhwkaHZHqdqPd6IkqVKwCWuq5O952SeHVMUA2ZkVFQ6cFbDXJRugkA>
    <xmx:rxwkaF1LCHiJNINldlaXrNUxZwd3dtaW2rveWiHaTpGRbmNu8Y7HKcik>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 00:31:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3db89078 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 04:31:40 +0000 (UTC)
Date: Wed, 14 May 2025 06:31:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/17] object-store: carve out the object database
 subsystem
Message-ID: <aCQcp7NjRBFcV2Bn@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <5bea19fe-6616-4f01-a78d-9b7da94db899@gmail.com>
 <aB3mMtoxCcaOFn0W@pks.im>
 <87a57gjoo1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a57gjoo1.fsf@iotcl.com>

On Tue, May 13, 2025 at 09:28:30PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > ... I have decided to rename this to `odb_alternate`. I don't think
> > "shard" works well, as shard is an extremely generic term that doesn't
> > really convey much meaning.
> >
> > On the other hand, I think that `odb_alternate` is quite a good fit. We
> > already use it all over the place to mean almost exactly what we are
> > after here. And it doesn't seem far-fetched to have an
> > `odb_packed_alternate`, `odb_loose_alternate` and `odb_redis_alternate`
> > for different backends.
> 
> So a database is a collection of alternates? And the alternates are
> stored as a linked list?

Yes.

> > The only stretch is that the primary object directory is now the primary
> > alternate. I think that this is acceptable though'
> 
> This is a very important nuance, and with that knowledge it starts to
> click with me. I didn't read this in the commit messages though, so I
> think it's worth adding something about that in [PATCH 02/17].

Good point, done now.

Patrick
