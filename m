Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090441CAB8
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158747; cv=none; b=YWrE2Jn9PsrDPTHlkTVKAPcAPWvJ+E+vrIMKlUmYT7UWYe26v8ZdeLLKGy5Ns3W/9L3j/pYG2QMFumki1KTlCpUrj4FM7cazmDuMyDFk3Z9fb/k8SpG1rAqI1uQkFClsNVq7e49L2ktKPUMiidbuwnM5qTJNlF4XZk/apo8J2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158747; c=relaxed/simple;
	bh=/Xs7AhFUrNG83ipfAU6MD5fcBjcXtDK5/geS6joz2mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kti56+YwjXM+DJu7bJPLNFvJqG1VFlmUPWmbbbWXBvHQnXhvRovcsUJ4klTPmrnp/UAf6aT3k4DgnyPbXJK+YIn70WfJJaUBLGb8WKIcNHviE/eE3/cUurc1u8KnXR1bORc0uiFFaHmJBX89BV1NnHz5pb/thBAKvNDutm+mxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dAixfCKI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGqp4cIv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dAixfCKI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGqp4cIv"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1EE201151AF2;
	Tue, 20 Aug 2024 08:59:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Aug 2024 08:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724158745; x=1724245145; bh=4glB+gXwEK
	eZf9WcuxcTLXLrLKFRHcROCMXuAHXJsC0=; b=dAixfCKIiCxhFBHT6Pnq4bPjcY
	Izk19kuwzmtYrVyLJok0B1rCpu5dI8Jij0V0eqUdQpIn8yndB3ID0kQSwS9HZXVi
	0vUKSQp8FS04rXwgXBpsddFfuVMhOQPKWHfzVbL8Vvlj6zr0nAwFeP3Pst2qBx1s
	x9aaipH2IB9IPAiijjBpBkSeadCxJAyrPMLCb7bZxdq5CnphmTX4P+MUfXKEboqq
	mL60H5prwfRGZEMaxLTNypJQ2O913M65SxsxzjSNSpHK5lp1hLzdHT4zdI4cOAc/
	Vye7Sca0SNps7eTvrh26v+FeTM4jQ/VW4gKNUmZqaAbDyD1YTldOMhDKNMxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724158745; x=1724245145; bh=4glB+gXwEKeZf9WcuxcTLXLrLKFR
	HcROCMXuAHXJsC0=; b=GGqp4cIvh0Y+T7KLWDnkcNR9PcuBt6DkAUsnDkPfAbMq
	L7ysHoMFfhyh3Iz1bSJK/JRbRKKYwO8DU/DXN/oW0rz2ZOpPInOCdX3h4zoPkH3N
	uoQ75PWUBAwbWWG5DuB4yCR9pwpf5+UTkqdCh5+/zH5Dk+hCI31yW/RkVMvxytWP
	dbDMy72sjkeGP946wafYDv1lJqWoolLQihJ6QglXZZoHR+M0C4zbC8w9IegJ9Dik
	rUlksHTd5rHErbbygUPNVPPXDLAuJ7vh3bPaoEkuRQZEGw2nlMd8w3mYX6pj+sfi
	dsnaAUUe+9949r0IAIwuYtAA2JrULvMElB8HZmvBlg==
X-ME-Sender: <xms:GJPEZkbBINcb_CXU-X-l1ARkf397A43HCJurXNv25Wg1IBozfPk_7g>
    <xme:GJPEZvZKFS-C5jHZuO9T-SxZD8myrE7UTpa64wT-Y8cdu3BcdNCe8rHwuYZQoqulS
    q7_VXpmMsLmYU-7Tg>
X-ME-Received: <xmr:GJPEZu9GkpNhB-MOxC8wweIEHECnMwuDQMJ0hJMs5Kvo3tYm27twjd6c61vZBpcN_JKVf4mH8nRDs4s3UpLMYc0WmxmkM1U5IxQb7GYQv6clebacHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpd
    hrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:GJPEZupZOixZ8-eK6bH-KpY_AxBWyaVdF0YP1G6Wk-A-quFJl7Cdng>
    <xmx:GJPEZvpInE2HqNyv1OI2JO1Au-dAN6p-tIJ-jhjKQTS0rbgKhcX4rg>
    <xmx:GJPEZsRKegjdtAge3sI_FKJIw7m-LJ0KZ4FAN_gb9kiwiWemeonMfw>
    <xmx:GJPEZvp-i9JCDwM0BYF8ca8D2XQvmrbwzu3zWvWVGHzo40_k09k5xQ>
    <xmx:GZPEZi3JoUr-No73mzGc30jVLsX3pOZJ-NZcPWOL_V-CNWfKl6Qw0xHp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 08:59:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9241eab8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 12:58:30 +0000 (UTC)
Date: Tue, 20 Aug 2024 14:59:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v5 8/9] t/unit-tests: convert strvec tests to use clar
Message-ID: <ZsSTDbEB2nIjxvcN@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723791831.git.ps@pks.im>
 <8f56b4d6264b8e5a85ba73bc8ac541efa066c8a6.1723791831.git.ps@pks.im>
 <1a38638e-561b-4e97-a462-f5ff034832e1@gmail.com>
 <xmqq8qwwmoqv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qwwmoqv.fsf@gitster.g>

On Fri, Aug 16, 2024 at 09:11:36AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > Hi Patrick
> >
> > On 16/08/2024 08:04, Patrick Steinhardt wrote:
> >> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> >> index 32a81299e9..82b7635e6a 100644
> >> --- a/t/unit-tests/unit-test.c
> >> +++ b/t/unit-tests/unit-test.c
> >> @@ -6,10 +6,9 @@ int cmd_main(int argc, const char **argv)
> >>   	int ret;
> >>     	/* Append the "-t" flag such that the tests generate TAP
> >> output. */
> >> -	ALLOC_ARRAY(argv_copy, argc + 2);
> >> +	ALLOC_ARRAY(argv_copy, argc + 1);
> >>   	COPY_ARRAY(argv_copy, argv, argc);
> >>   	argv_copy[argc++] = "-t";
> >> -	argv_copy[argc] = NULL;
> >
> > I'm confused by this - it looks like it belongs in the previous patch
> > but why are we deleting the line that adds the terminating NULL to
> > argv in the first place?
> 
> I agree with you that it belongs to the previous step.  clar_test(),
> unlike the usual convention used by main(), works solely with argc
> to tell where the list of argument ends, without requiring argv[] to
> be an NULL terminated array.  I do not know if clar _promises_ that
> as the calling convention to its users, but if it does so, and if we
> want to take advantage of that promise and leave the terminating
> NULL out of argv[], we should do so from the beginning.

Agreed.

> A NULL-terminated argv[], as long as we make sure argc only counts
> the real arguments without counting that terminating NULL, would not
> harm the clar_test(argc, argv) call, so I actually do not mind the
> way this caller was originally written, with terminating NULL.  It
> looks a lot more familiar, even though we may be wasting memory at
> the end of argv[] array.

Okay. It's not necessary, but I don't mind it much, either.

Patrick
