Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7736C2FB
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730601761; cv=none; b=WUaJkiJHatWKebvloQOG+Oa2Jb7LK8Ku7mt7kX/FCga817STlkVDOxaRLyNPrznr7sAAx1TAJ5qeXGJ6DXClttCjh0emmdmkKQd0cb4eWudjwOci77R9VJFykL56nMM4VhglkgQIt+2JdzJtXhI327hcQRVDv1ZvIQmXkzkeVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730601761; c=relaxed/simple;
	bh=jxKPq9dJsPdmvKq/KsL6bVo00bEFu4UTLA2ypHIYz4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0J0ILndNF27emCil+iCHL7ozjYTpV9C//i/gx53bre4lWvqloMKOhOJgsVMx4UZWTzFDcMH5rfdg45yEZ8MtJe6BeFPfmV7IE6bhcJd1paZCfOYAw7Z0wBCZp+gRQRWsS7xCHPk1/brjc9B6R+ijRV/zdENe9CeLkVHxZq4lyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ET+m5Bsp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ME8fmCmT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ET+m5Bsp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ME8fmCmT"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1F7911400B4;
	Sat,  2 Nov 2024 22:42:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 02 Nov 2024 22:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730601757;
	 x=1730688157; bh=7aQjkeEfZNTabB3dswHOiBr7My56p+3plKEvzliDkoI=; b=
	ET+m5BspAIz/TeBO2giJmoaAOjvHJ4LG1weEn6reoIHGYM/bF27ql4GW9Octkf1r
	48U5PXeHb5X9WICeEWhphNJx3ju8hY/3LZAULnRzJvwxEWQjxEYUqjDP/XaPn/Hu
	Tpgd8GFWAiyQT++uEeVyhKik0DRj7pTdJDLCUVeKWbnRRTSp3EohRBt/kycXt6hv
	psGRjkog5Qt6GK02f4vAndt+q7qOM+wzeniRwQ/oJiMF57o4QPsHSVLTg+eSfrC6
	OnL3YAjxiC0KFzxU+fxmETJG4l7dq6UwdABNQAId4gVszCWgzs+4baXfga4M4Jm1
	KWaQWQiezTmlJOUOdd5NHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730601757; x=
	1730688157; bh=7aQjkeEfZNTabB3dswHOiBr7My56p+3plKEvzliDkoI=; b=M
	E8fmCmTOMXK1IcGxyP1JKqy0+Lw+KjFDmLHUJBdnzY6USO+P82lGVs/P4qY5a6M7
	t1LGmztdptIPoKM1L2lIkFvr/1naF8Z4WbkpasRfWBluGBZQWTu8pnq/3yC7pYUu
	k+l7q60EGmHXKbEHEZNRfwCQPDeTOU5dLUwfynMwdt6sIOKxz5rffEc1v4Gu2/qi
	38CP2uuGwcQiwKeaLT61RsF4gv+LqkBweNNxJOEmWCtLxtMZRbfngTqW07e8mydX
	kWCtvj+IjWhkZw5bm8q8qcfzkqpjLmae+ZJRETnJ17JDWRhjJ5EReagabzrgKIPH
	pEDlgE7RgZtHiLTtktI+A==
X-ME-Sender: <xms:HeMmZx44BmvV25OjRxQzXERReogPVfeDqF7BVffDZn-TtMjoG969qg>
    <xme:HeMmZ-70ri_CAmkzM9hsaaG1pZOoEsi8xUeOrRkUKi4fpggKXyM5aI9oQ4y40bC1z
    9BJT0G_g6EonMqWiA>
X-ME-Received: <xmr:HeMmZ4d1VKS19EdGECMXGzMv38TPCilaQwsuk2BbvqxhmuD6El19pGWGjhkNXiPSmyIEHs0iB-uSMIxtgUmALW6gXUGS1XAs3vQR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelvddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegrlhhg
    ohhnvghllhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HeMmZ6LA5IgP1V9gecQkSmMC9S2SNaJ135sbJsWR9g10fTC2YwB5ig>
    <xmx:HeMmZ1JVExwhWSPCUSF_jmVONagrYRaM14u7QEyMIDcbYOhDRNEQvA>
    <xmx:HeMmZzycYZc6xUN1vOTElYChSb9KvDM-5TtOShxmfbEsmAjWyYNAAQ>
    <xmx:HeMmZxL_2qgLBxnbc8g8M-8pi5Hn7kUR9KznFyF-z2R0yN2JLKwZug>
    <xmx:HeMmZyGeMiliHF0mCO-Z4u8YyjVPRJtFcT8HZvCqpye537cMDwH6xkNY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Nov 2024 22:42:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Andrew Kreimer" <algonell@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t1016: clean up style
In-Reply-To: <2a385fcd-7cb2-4d6c-8372-2139f11c85a8@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 02 Nov 2024 20:11:02 +0100")
References: <20241102165534.17112-1-algonell@gmail.com>
	<2a385fcd-7cb2-4d6c-8372-2139f11c85a8@app.fastmail.com>
Date: Sat, 02 Nov 2024 19:42:35 -0700
Message-ID: <xmqqikt5xckk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Hi
>
> This looks correct according to CodingGuidelines, part “For shell
> scripts”.
>
> • Whitespace and redirect operator
> • Case arms indentation
> • Tabs for indentation.  It might look like some of the lines in the
>   preimage (term?) use two nesting levels set to four columns, but that
>   is because the first line is indented by four spaces and the next line
>   is indented with one tab (eight columns).  The postimage changes them
>   to use one tab per level.

Thanks for an easy-to-follow-concise-and-to-the-point review
summary.  Very much appreciated.

>
> On Sat, Nov 2, 2024, at 17:53, Andrew Kreimer wrote:
>> Remove whitespace after redirect operator.
>>
>> Align mixed space/tab usages.
>>
>> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
>> ...
>> +		test_cmp ${name}_content5 ${name}_content6
>> +	'
>
> Everything up to here looks like whitespace changes.  Indeed.



>> +	test_expect_success $PREREQ "Verify ${name}'s sha256 content" '
>> +		git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_oid}
>> >${name}_content7 &&
>> +		git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_sha256_oid}
>> >${name}_content8 &&
>> +		test_cmp ${name}_content7 ${name}_content8
>> +	'
>>  }
>
> But this is diffed as an addition.  Seems like either a mistake or the
> commit message and/or patch comment (`---`) didn’t mention this kind of
> change.

Good eyes.  I suspect that it is from a separate topic, and this
patch is supposed to be preliminary clean-up for this change, or
something?

