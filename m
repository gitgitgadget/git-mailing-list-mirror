Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115619309E
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715183; cv=none; b=t5Q+2mO4CQItg3y4JcbXw+CtcFyGkw2msoelNTyGMdAsm6LgjykrYiXYKZD8r3TpmvwISb0/h1MycZzk4cIW+mwFL6crNobyhF6AulyI0kVqoApBUpQZ7/LnEaOwBl3QyaQ2tOu6qbPnrOoyMzJTB27YfCqsiSdPcWQJi9jjeb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715183; c=relaxed/simple;
	bh=vdDCUPWypFGR6HKFkj+WjmZgwGJ82fJ54/kWZZy/WbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IrJweAQY8dW0dOEo42OKtaffVXFk3R5HEkw6jaWx8XQvL03PcYKpRDeXSFjDCiMDUI3RyocQWJOgvkMHNpnhlwwWYpTbx27gMLX3CZklWz4Y2x5nkhsTjDkfOe/9MkTvzdK/BQDAoFveT5HSJpP6WcXO9/ILfB9oDceNouQDV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iduSsc+f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOdGjyCw; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iduSsc+f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOdGjyCw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AE02114037E;
	Mon, 30 Sep 2024 12:53:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 30 Sep 2024 12:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727715180; x=1727801580; bh=tDeG33Un4N
	ph1/pBwaAwjeiocsv+BKdKux/oPwKGd8Y=; b=iduSsc+fV7BBi2zQHW8htTc1hK
	VrIqoP9+/mI22FIdgP28LlDglNve5BfZ+ub4pl0Z6NdsNGhAsnfqgMQ3+gqz0DMM
	I4u+r9W5Ixqs2JKkNhm9lv4R9Hc/b3k3JKo2w8yxQQvhKpl214//CElqX/nqWm2E
	3D6tFtknCw2ICciZolRGD8JXF4lfoCZfthji158DAZ53Wn+I+LnJ9rzLK1lMjSRQ
	yMwn/3v22rAseoJOIkvStHwxN/sO6xzq5nQDOgGqp5u4/PMmb2S5WK+xHZLi+kph
	yIbaHnz/4PBIJYk1IFXnmwBSYLWTvmLfyGX5+WieBRZXeOeIxf38Yu34K4yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727715180; x=1727801580; bh=tDeG33Un4Nph1/pBwaAwjeiocsv+
	BKdKux/oPwKGd8Y=; b=gOdGjyCwxOEFrtnqWgh3HYsyqxWWNHWT2Ympus6odCJ9
	Iny5fummQkkpFNo8OrDJo9YPcI4yWCAoTjez3U2vHdocR2iNJSbPSDLCVUAlLenj
	l0M3xpQ/cnq4UL7jKsCZjXXS7wmy9ZxhDN7R2Q01ZwN9MKVbaV+6yqIBOreLpMHM
	YaGF/ef+DspiSU+Wq1mMmxlhiRJsaukFCA+iIH8hGr7FZOdx1fmZ66JhHivORKwh
	AeAVVhE5H9l0PyRws3NSuhpmPBRCtJWlXxtLBiEAj5elG5Q1NK9JvxL1ME7iJ4yT
	j2Rsqr/y0Km+5eWwf8MD/paA9MaH5hYsoBuRFydWJQ==
X-ME-Sender: <xms:bNf6ZjSSGp7qWGDTScUhk3N9fff8EDHaOVUkcQr23RcyspEIfYJ9Sg>
    <xme:bNf6ZkwUkViVCd29e18y4HHA9g3_hYssOWXhkfAPkYClmtm9eakCgq5UX0VNyPi_m
    RovKQy2aKjjc2UoSw>
X-ME-Received: <xmr:bNf6Zo1EcqM0EzW7x94Lt_c2UF3HCqWTY4OQmJOvPWT0ZOo-sZFA6PpEhL1_zNmBB21DajvUCM6gaR5DMGpyLzSDJFWvib0snPlKRH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghp
    thhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bNf6ZjBKHf6GWb8omkcIslPOBmFXXea6i-ZEJXUyIilRslnEj8fQWg>
    <xmx:bNf6Zsh6o8NXXqhuDAHKvMzvZqgf9xA7g6aNTtpJpORnn4Ey1ib2BA>
    <xmx:bNf6ZnqTMU71LXSuQuzKWIeRx-_gdZk28tqvxdGIwuw40fvTUQOJow>
    <xmx:bNf6Znj4sAi51rPhWoG42mrVUyBDMBmWGa7FhUbTrbfZ8IM5VErgqQ>
    <xmx:bNf6ZvNW2XoQiZxko8tRoEJS55hsKEhDHAgrz7SibOWgX2qkIIcyMZ2Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 12:52:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  John Cai
 <johncai86@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Michael Haggerty <mhagger@alum.mit.edu>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
In-Reply-To: <CAP8UFD1yK0vwHYh+jVNUEV0mRnbjyDTOrRjuwjOwSCn-fngVzw@mail.gmail.com>
	(Christian Couder's message of "Mon, 30 Sep 2024 11:17:48 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240910163000.1985723-1-christian.couder@gmail.com>
	<xmqqikuijni0.fsf@gitster.g>
	<CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
	<xmqq34lkg1ck.fsf@gitster.g> <ZvpZv_fed_su4w2-@pks.im>
	<CAP8UFD1yK0vwHYh+jVNUEV0mRnbjyDTOrRjuwjOwSCn-fngVzw@mail.gmail.com>
Date: Mon, 30 Sep 2024 09:52:58 -0700
Message-ID: <xmqqa5fp9j85.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> But there are still a couple of pieces missing in the bigger puzzle:
>>
>>   - How would a client know to omit certain objects? Right now it only
>>     knows that there are promisor remotes, but it doesn't know that it
>>     e.g. should omit every blob larger than X megabytes. The answer
>>     could of course be that the client should just know to do a partial
>>     clone by themselves.
>
> If we add a "filter" field to the "promisor-remote" capability in a
> future patch series, then the server could pass information like a
> filter-spec that the client could use to omit some large blobs.

Yes, but at that point, is the current scheme to mark a promisor
pack with a single bit, the fact that the pack came from a promisor
remote (which one?, and for what filter settings does the remote
used?) becomes insufficient, isn't it?  Chipping away one by one is
fine, but we'd at least need to be aware that it is one of the
things we need to upgrade in the scope of the bigger picture.

It may even be OK to upgrade the on-the-wire protocol side before
the code on the both ends learn to take advantage of the feature
(e.g., to add "promisor-remote" capability itself, or to add the
capability that can also convey the associated filter specification
to that remote), but without even the design (let alone the
implementation) of what runs on both ends of the connection to to
make use of what is communicated via the capability, it is rather
hard to get the details of the protocol design right.

As on-the-wire protocol is harder to upgrade due to compatibility
constraints, it smells like it is a better order to do things if it
is left as the _last_ piece to be designed and implemented, if we
were to chip away one-by-one.  That may, for example, go like this:

 (0) We want to ensure that the projects can specify what kind of
     objects are to be offloaded to other transports.

 (1) We design the client end first.  We may want to be able to
     choose what remote to run a lazy fetch against, based on a
     filter spec, for example.  We realize and make a mental note
     that our new "capability" needs to tell the client enough
     information to make such a decision.

 (2) We design the server end to supply the above pieces of
     information to the client end.  During this process, we may
     realize that some pieces of information cannot be prepared on
     the server end and (1) may need to get adjusted.

 (3) There may be tons of other things that need to be designed and
     implemented before we know what pieces of information our new
     "capability" needs to convey, and what these pieces of
     information mean by iterating (1) and (2).

 (4) Once we nail (3) down, we can add a new protocol capability,
     knowing how it should work, and knowing that the client and the
     server ends would work well once it is implemented.

>> At GitLab, we're thinking
>>     about the ability to use rolling hash functions to chunk such big
>>     objects into smaller parts to also allow for somewhat efficient
>>     deduplication. We're also thinking about how to make the overall ODB
>>     pluggable such that we can eventually make it more scalable in this
>>     context. But that's of course thinking into the future quite a bit.

Reminds me of rsync and bup ;-).

Thanks.
