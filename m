Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536F25D21B
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212981; cv=none; b=lq/hOzaZF3JKeBSGuXKSwV7Zuu4Ffi0KzJD6TYKSJvdMvfqvgz5ImCul8si7lWCwV61/IiRKfwfkDy484/fb2pjENa/J/On5kCWBafZXHnjnGOM6JmCjkdLNxYRTxGQPcMewWewpz8pwrkWN+bj0/zP5rjkrCO6KvhANQ3OwMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212981; c=relaxed/simple;
	bh=xgBO0BJXGTdFsIGWV88GwYnpMd3SlkRUTw74V638700=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KPmbrmrzXdB8qAptAvrjKxdiMQ744qhUk3YNpKRp53pb1KlDuktep2CK/GLUOpSQaa10/lCNdyWQtzkmHfKod59ecFfDEy486R1n29XSUmEIXJBnB3ngHSNzL9qR0dxtQ6MRO8Zv+Vf0N7XJ6m4fV+NNApHrDmG/Sx5CPRYJjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RY347HX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=weoEaCh4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RY347HX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="weoEaCh4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2450125401A8;
	Wed,  9 Apr 2025 11:36:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 09 Apr 2025 11:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744212978; x=1744299378; bh=Vop/QI5ypF
	iQghauWi60EQgjKsNRD4pp5qfbKy8Vy5M=; b=RY347HX7DtPFnk1mV36RmImK29
	ZmggYO4LUUseQZFIHhCNqfnDpaRIkzPCZfv4vCzXKnjvHvlvwhz1XwsZMG9ZDB66
	jAmFjSLR/DhiLqnUIktbkUpf4wKmo/T4QiOHfxmZyW+Ch1theSNI+klxS8lRbetk
	S29JA10J13GA5uw90mKX12s0Yqs/NkukoctB0B7YjlZFvjRl6Sk+oRO+07Eis71Q
	BkHicVueKJ+aUA+N+sTcJneYH8w5soUknFO9aiyJE18NwOfmwbtKosE9hBjcdzlq
	0dbvbom18/HmMBrQrqTQPlEn9L0kBODm0QM0JjvEChfiGagtKeNe2cUQA9Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744212978; x=1744299378; bh=Vop/QI5ypFiQghauWi60EQgjKsNRD4pp5qf
	bKy8Vy5M=; b=weoEaCh4eA9ZLj+EpCP3N7njNCozjC7YzrpcLxEbueTa0jIyzOf
	9lfBtDUZ9BOFyU1G+AmnrQJgqv8x1nI5oTQFi8PKW6FJg2fPCDjW6z0ypbD+F6Xv
	dpvDGkjboRsM6PSJbqBu0hDAmSQ6wYl6FCIkULfQGpqLb6iIC4twIy4ufPgF38ff
	5XRu6/H2El0P+cOXEFGPPlu2/+YqRhAi0dWiikMo8cMaqCiGUbnCVS7Dg3uUIR1T
	ZjY22a9N+yg6zTHsMfx8NQYFILU5sS6rOpwaN+0MCi0jIr015Y7nnATlaT6TKe7L
	6H/LcsXFBFE/2IbW5KB4qzDGZOaxsfVeZEg==
X-ME-Sender: <xms:8ZP2Zwl27ISPNAt9OO1e2qW2KSMmp0gZwcKi99Rd21c1XlqAeplMAw>
    <xme:8ZP2Z_1z_PCSmXWnA7JZglkygjM_QQMnuS-D2pFXcfUFEuLcNh6Mv6m48GmeDkGhZ
    xNlN8ii8bKsS3YA8Q>
X-ME-Received: <xmr:8ZP2Z-oIT7bgAivhyTHHYS4hRy6KGaEgW2X89bnZ9yHpxJvhn0MNIXyjZ6Qz-Ht9IufQWIob5EAALkP7Zfn-h8-yPORISUrEz0my>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeifeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughu
    nhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:8ZP2Z8lzRAomKNWcmoKhbf3NyRDSUYmJarJr5zG8O2IJ7YlwFPOvJQ>
    <xmx:8ZP2Z-2muybnOE6aM26kx_T7Mq2tvZmjfAwtuoMUlzxHHiTWTKkPhQ>
    <xmx:8ZP2ZzudQf-9kKKMkSx22lae3ANPu1pSG_ZB6g45Rm7taxsBOicw2Q>
    <xmx:8ZP2Z6WFNDGhnSu0wp8WlqZFr8Haj221N9whxVGKDNldsp6XzizXag>
    <xmx:8ZP2Z6L7VkOJ-KfrRn99djRj8yuJvONxrbAjVPCwY4q4otntk-wzolbs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 11:36:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Phillip Wood via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] [RFC] rebase -m: partial support for copying extra
 commit headers
In-Reply-To: <7f744f34-050c-4d8b-b5fc-aae622c3c5b6@gmail.com> (Phillip Wood's
	message of "Wed, 9 Apr 2025 15:11:19 +0100")
References: <pull.1902.git.1744041163929.gitgitgadget@gmail.com>
	<Z_R6W_yjJEYuWo0A@tapette.crustytoothpaste.net>
	<240d1cab-b564-45ae-945e-cba621aa7562@gmail.com>
	<xmqqr022yaq6.fsf@gitster.g>
	<7f744f34-050c-4d8b-b5fc-aae622c3c5b6@gmail.com>
Date: Wed, 09 Apr 2025 08:36:15 -0700
Message-ID: <xmqq34ehtki8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> That's true and we could have a config key to select which "extra"
> headers are propagated.

No, please don't.  No such config key should ever exist.

If something has a defined semantics, which all projects that use
Git can agree on, that is solid enough to deserve to be in the
header part of the commit object (as opposed to one of the trailers
with user-defined semantics that can vary from project to project),
there should never be a way to give it different semantics by
tweaking whether it is or it is not propagated when rewriting.
