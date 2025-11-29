Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6618C31
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764395969; cv=none; b=J4jCjblRBK0YXTyf9ppcef/COSQORFYLUR+cgLDWbPvcJnkP51Fhfqjfv7p3+lplYLWWLIAleO7w/Gdk9RBvcXJPF6U+MTRdBRwAaRw0T09OVu/CqFUgGWyhHi5ELx4YAXy43ovO3PpXkBEVq7ZS6jitrfxwdeRujXpVCZPkpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764395969; c=relaxed/simple;
	bh=Cyy0Mnb0QhKFp+vNaVT11dxsUQB/W5mCsStp/O5Q3xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oxd/80JGpDXdjgAImG4zWFTS5GSiKwtQ8Wq05BHPZm5n8Iu2Ds3uIPGKvKiRc2tfpbDMn6AYMe5bdbcpPP8ZXNOTIAmH+cxDYmnasP1O9tDZKxZfEuwPkxBm6Bit1kUTreWrvfPQXvY8S13UOg3PgVsduduf78sWPJnIhkZbLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FMO1bCNs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRqn/shO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FMO1bCNs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRqn/shO"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68DE07A0578;
	Sat, 29 Nov 2025 00:59:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 29 Nov 2025 00:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764395965; x=1764482365; bh=Cyy0Mnb0Qh
	KFp+vNaVT11dxsUQB/W5mCsStp/O5Q3xk=; b=FMO1bCNsvucAVj9kyhHzObgYzv
	EaZpAUgFB6i+TOHfmQ/p4wV1VDGi+IePuAbdOgPO+Qgi57bgDV8pfAlilZ4H/5iC
	mQAlOAJ9JQh2wboJO1o0iZTE2qxk599TaX4UKD+Vlv+kSt9jsmbG9ocwf58v2UYp
	uo0bWOzTrlCFplXAtTwqpv3OP9MnEff2Nu9/qAHIcYDe+LSQPMERwBD7rnY6LZIo
	d209k6TFcqpiUNBHVlNBuH41j7GZYZWbRs3XChHWF3vMmvrG7AAzL09Rrp/04GFm
	NVk6E+pihrvGnRTAXsbpzSaIHkJrpSjc5Qjjn0dkG2pLn/adEC65DXemeWuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764395965; x=1764482365; bh=Cyy0Mnb0QhKFp+vNaVT11dxsUQB/W5mCsSt
	p/O5Q3xk=; b=NRqn/shOeRr8jFgPTDM67nNqySqh2JhDvmSmEWuhG7UGAFW0X7O
	vB2/Dwlh2fvvJ2qM8bHoxX3zSbcNdikozvkyYKYZQh+U0cCtGlHMqIzA5akp3PI9
	nSVOXO47Knc026mo9tWWfvign10R0jmKHvECye2uu6tgfk14a2T24SqPvE9OEKPk
	O6gfgVCZSw4qyTfKQClxZnT3YF2qy6M7B3OwUcXyZ5KxEm/T/4GbtVcz1ZIOUD4D
	supDyNpSThoTl1UJ6hAS4Cl+AYEu5M01pD3yX3Qamw2mod4W4Vp9nLnkQkVEYfvv
	DInRufDL89vENzanT5MEK8rc0aBF1Lw9G8w==
X-ME-Sender: <xms:vIsqaYxzi6CSqBCztiwOKrdJOpSivIii7D5oj1K3lKcm7yKGLmqK8Q>
    <xme:vIsqaWoPdRk3hPoENMVYuZ9KoMbLVLcSgP93QW_Z_SkhOKvwBRyfW_zkaUFZDkncP
    voYjv2RG25DNzy4upkcV-KobTLoNwMjYLXCnABoazn-aIY7koC_LA>
X-ME-Received: <xmr:vIsqaQdsL9EOk0zJ-3pWM9TCdlkRa6ko9Pm6B8kYvXol5Kvok-srY6nCeSrzz5vnGNiBbnsW-mYolL_ZsaQCSDMqO6aOY_76bm7T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:vIsqaRptGnBmUEhzD8Pc67IUCdDl4tzJDdQI2PLc1Yi4G9Kw8PhP_w>
    <xmx:vIsqaSnVaC3dSbzQXlySuf6mrEHXvuVF6i-vhr9kF5oLpYRzihoBTg>
    <xmx:vIsqaaQLnMgtzXxtj6tGtw4tb7NkdLM4ndlFGs25UCWJ3IeYKODf7w>
    <xmx:vIsqaQa9-fBtiV1C7Oi-HHNYUk_3NvyDtSKiirAXOW1VPe5TPYuqLA>
    <xmx:vYsqafviDFuSC7CYW-0edTTtfqLDDy2nuYHeWqOWJ_tn_dh1jBCQy729>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 00:59:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
In-Reply-To: <CABPp-BHbm12gW_LhtfXRCzOHtE3hod4VMTN=cwe-aesVEqyPCQ@mail.gmail.com>
	(Elijah Newren's message of "Fri, 28 Nov 2025 14:03:55 -0800")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
	<27fef9e1-bf26-48af-b3df-35948937c891@gmail.com>
	<xmqqcy54mro6.fsf@gitster.g>
	<fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
	<CABPp-BFsDJVtR6RV8KugCW2vmbD1=rTOKLp2jeawRfuPUEsNEA@mail.gmail.com>
	<c930d6df-5dc4-401f-a9a1-eb2f00b2e837@gmail.com>
	<xmqq7bvajesl.fsf@gitster.g>
	<CABPp-BF48AF9qoP_pUs1X=sUV-_G5BpsxnG6AEhQYkJkE_TBjA@mail.gmail.com>
	<xmqqtsydj2zk.fsf@gitster.g>
	<CABPp-BHbm12gW_LhtfXRCzOHtE3hod4VMTN=cwe-aesVEqyPCQ@mail.gmail.com>
Date: Fri, 28 Nov 2025 21:59:22 -0800
Message-ID: <xmqqo6olgz0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> It's also called out pretty explicitly in the manual:
> ```
> When calling `git replay`, one does not need to specify a range of
> commits to replay using the syntax `A..B`; any range expression will
> do:

When we use the phrase "any range expression" to refer to what
prepare_revision_walk() produces, it by definition means we only
deal with a connected set.

It often is very handy to allow saying "master..topic1 topic2" or
"^master topic1 topic2" or "topic1 topic2 --not master" to mean
"commits on these branches", of course, and there are many such
useful use cases that do not require disjoint set (and that is why
we survived without any disjoint set support on "git log" side,
except for individually specifying commits and say "--no-walk",
which is still technically a "set" but not very useful one when the
number of commits you individually have to specify becomes more than
a handful).

It only means that the documentation needs to be updated if we ever
want to introduce an extended form of the command line syntax that
allows users to specify an unconnected set of commits.
