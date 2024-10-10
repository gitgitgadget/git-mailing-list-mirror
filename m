Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306B4207F
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576063; cv=none; b=cHmje/x4wch7b7lESmd+4eznbfmDIyyU9FCw8e3Lw/dN0pLZ1YLKRA52FxMenEtk3fcJ6lY27c1t3g9XtprN7af8U4mrQHsX5eGDQU2QXy/tJrvQnQ9ep11JC83CQN04uwI6zPjXTytNCAVz/rDDKJ6DzaBHaZGdk8/XxXDDx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576063; c=relaxed/simple;
	bh=VEz66V4XGRtRInuFfwnl7hFqMDHbxROrloz/EpMlRaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aua8DcBO0gjbVDGvVc7/6Jzg+I89xIMREt7zPaNhKBgCYOjdPrzNhVo6Yl119vYk8eXDeY+He7Sv5IpwPI3jvMyUI2+qvUt0Np/QiHqCCtjKO1Z7Xo1Uy71xkO2jHk44Xs5XWSRFqI0bbHmBSLVWUDHCqqFFUqjhY5v7Mk1SgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fyBTb06V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YOJ6m8Nn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fyBTb06V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOJ6m8Nn"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C75B1140211;
	Thu, 10 Oct 2024 12:01:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 10 Oct 2024 12:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728576060; x=1728662460; bh=jSrmJOlzKO
	j33N+P38tEXuMDwCV6heMfnPn4uQnok/Y=; b=fyBTb06VcG3uQOV/GNgId9o8uB
	I7at+297TP9YbgzSQPzJd0zPynxJeZ2zILJy7cg3moFrzKiFJdlWqwmoAmPl5/dm
	cFnu+XY1tBejeOwq9PdAPu1OhSWrgAkgsD6/xrz/3PVwlvXqSkEXwq9w30F3hU7R
	0DTjiv0qR4V1Omb59n17BinV6piL9vo8rXjChXJlh8PA+Iu6wP6o59CLtq2jOFsR
	CsncN+eZ9zjOIlmn21ZkC3YiLwu7GmnGWx5g47DvI0PTy19H3iWHkwtLZpfm7KcU
	I7S+A4phGVZisOxp2D+suCDX0BlDmjkecj6a/DJFJIHrT/Uk9HkZ15utcVsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728576060; x=1728662460; bh=jSrmJOlzKOj33N+P38tEXuMDwCV6
	heMfnPn4uQnok/Y=; b=YOJ6m8NnOAa1bxAcGPqkNh0q6Z3SoZoYbhIl/O5xNdon
	BWl34Myc3mYhLlI2BqNRwNOCQ+2wYVUKSNb2hYLt5NJkRWZx2ZHjNpPFQwos1CPB
	zcoh8bqxmy8QXgJ1PJJS38Qp06jQFcuURQ9ThcYTRo4uQ7ml9Hf9kwp3YHHp/tvs
	OtxO1gE6PpaI8Zbx/OB0EYLnvYjYiygOtDyoHQapnT8iOPtjJGW083tKYDCERBqL
	OeaaZ+TB7o8xv+D+5uyL/ED4IyODFP7lRFBaa+9c+E6/ScFMS9fIoxBVhxCTP8YL
	kRfSp0OcyWzk06JbIS6adAFv5dq7HIqEIdbzHeF/qA==
X-ME-Sender: <xms:O_oHZ6-i2dn6sx9M6La3NzgpcV4gqjIG8her_N0655P1UYmXeUl2SQ>
    <xme:O_oHZ6uaHU3gxvFnLMOOlRdx9_Zit5TzZ2xLHQNUWeR2KSktaemT2a6Gvo0EKMMo8
    ObG5IBwA2A6JwbWCA>
X-ME-Received: <xmr:O_oHZwDVlEWTUZfXc05HxdpqzOFBcv9XqUJDSdUkrpj6ArL7sQE8GlvrontoTBUZMtJJHTTNpStRduvBvGxadwxSsm2lB8MdxZx8eyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:O_oHZycdoPjzyVBkIKdtTRKEelo-NJzHqA4wjDoSaV8zuwJ71V9L8w>
    <xmx:O_oHZ_M3laTjIVlY6exy-PJwsvNZ2wHZfjZG42f3UkJmIXZ6Ygyong>
    <xmx:O_oHZ8nAt_IwLfevnWavjAjp3BDsp74XLER5qZjw8MzJUcrzCrYI6Q>
    <xmx:O_oHZxs9W-nXEu9bBQVY0E7Bm2QrPK1hieNoCtgt_Eh3k8qYV7Xguw>
    <xmx:PPoHZ621dJA-ICtCoTTr0UZ_llSmOcQL3Ul-1c1fO5GZaD3EEkapYStP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 12:00:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
In-Reply-To: <Zwd5kiZZME3ygM0K@pks.im> (Patrick Steinhardt's message of "Thu,
	10 Oct 2024 08:52:07 +0200")
References: <Zvj-DgHqtC30KjJe@ArchLinux> <Zvj-osCNDMrUQv83@ArchLinux>
	<CAOLa=ZQ3Gytt4Lsttxws3DWqbjteJS8mXvZSPzDwBJi_ALS03Q@mail.gmail.com>
	<ZwUkZuCtYu7niuFM@ArchLinux> <xmqq5xq232wa.fsf@gitster.g>
	<ZwY5O63OI01LZX1u@pks.im> <ZwZwGAxkbQtnozh9@ArchLinux>
	<Zwd5kiZZME3ygM0K@pks.im>
Date: Thu, 10 Oct 2024 09:00:58 -0700
Message-ID: <xmqqr08olzgl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 09, 2024 at 07:59:20PM +0800, shejialuo wrote:
>> On Wed, Oct 09, 2024 at 10:05:19AM +0200, Patrick Steinhardt wrote:
>> > > The fsck.c:report() function, which is the main function to report
>> > > fsck's findings before fsck_report_ref() was introduced, did not
>> > > have such a problem, as it allowed "const char *fmt, ..." at the
>> > > end.  Is it too late to fix the fsck_report_ref()?
>> > 
>> > I don't think so, I think we should be able to refactor the code rather
>> > easily to do so.
>> > 
>> 
>> It's not hard to refactor the code. But this is not the problem. I am a
>> little confused here. Because we already allowed "fsck_report_ref"
>> having "const char *fmt, ..." at the end.
>
> Ah, I didn't double check, but was operating on what I understood from
> this thread. In that case I think that the current interface is okay.

I didn't, either.  So there is an obvious way out for "why aren't we
telling the errno to users" issue?  That's good.
