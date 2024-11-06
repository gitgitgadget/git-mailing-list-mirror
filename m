Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF8186E59
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854767; cv=none; b=gLcUdDhODAygLDINEXSu9NSZH60AIEqaku2Hj/c7Ga+zxDqy8LkY4rhEOYvuUDATCUOqnhaStXJoc+rn3NqXBdaTP/4dcpix9Vukpm7m0d4LIctBLz/AF2AcOE5umcG7YhUpsAAKY0Hmogaz8LWFHTRqAwkaZBaeLkY6UszTN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854767; c=relaxed/simple;
	bh=/Aj+KQ6Ciq91hzdOymXsU0oQnIh0v1dWjiCjBUDhPWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bM9CSEuORzdX08UmrQ4HklED+4YrXjkuHnlchr1i2D/ioHp9YC3uZ/AH+PwT4MjHCcTedKxIhHJHiamiwDDDJnKX0jRWGjhfIV4GDjhF8Q95d/pbiXBeFkLLo1L6MHt+XRajssfRkDpjvmwfMgIl7XWrhtnq4Hmc1LMhdEX8uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VYYXyeSu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8VyFkT3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VYYXyeSu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8VyFkT3"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A11C0114014A;
	Tue,  5 Nov 2024 19:59:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 05 Nov 2024 19:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730854764;
	 x=1730941164; bh=EedTiT4RJ14PMQkfionmHOKVMl7c+k/ZeaV8LKslXOo=; b=
	VYYXyeSuMdRbz2VEhadkmKRWjHCy1xrBdkjVUlBm/ZTUvxxVNAUGg14w3yfaWEJp
	9YwgBIVVfNLUWxcX9VYMvCHrM+7iGw3P8UFGLgbKkxUJnKC8Yqa68fy3zLL7gJu7
	r08ZTi+p4e4N38fVo21Zd2pfIjPBw8CrNi9TUS5Jy1rr6dv3rTh4/pUUv6M6HtsQ
	JYhpBAyDm3HwqhS1sMYWJk4GO5LNz3r2eE0wbScUMfsMizs5qjYZNPYB110yXDjs
	Yrat3yzTLav15zRME7w/j8VD9+f1zXV1QEZ3gqnOUKfnlBBQ/iYt1I/rPCoEE2wr
	Gpn938/T/aXhO+ROK3XQuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730854764; x=
	1730941164; bh=EedTiT4RJ14PMQkfionmHOKVMl7c+k/ZeaV8LKslXOo=; b=E
	8VyFkT3HaLfbK4+YV4bzJD5+0mNgmR5c+2pEJE/d1/loYKtmaz8+UL0Fd8pvn1h/
	/ZCFnYrI7EajrnoW6YdmEY+2r9Dq8BH1TJOQFLSIPfEMguOKTABSKyhArZHv4zgI
	kRFF0phqqX69GQFJDl4nhNv5OmQZhiQmVFpDKZvlUj2Tb34abglvT1jKxoapgH2G
	VHNNp1ME7AC+B/42m5qNtQJG0PR/Kirj8yiHOcuWLx6D41bzBiEWoBujWSkdccs/
	0pqBQhhIlAhkHJMHcFr+CIiv1CZCS25mp2UB1qVLCHM9no4zHpQwPhYRhEus82Vc
	MQyBfF6ye4kpciP8twd6w==
X-ME-Sender: <xms:bL8qZ0D79knirKAA35A-hbpp6Wqi4GqGf_owZZe7CR8aN9_DHTNtkQ>
    <xme:bL8qZ2iW2sodKTUIshlG7gRbxSlVGnJgyGpMw65NQca6OlZEKtFjJO4IN6Eit8xa6
    SnJ9g8EGWMt77KVbw>
X-ME-Received: <xmr:bL8qZ3nSc5EB3gVg_3shraQepTRVsn9u42_KY6RoQGl8Nh-BPuJ88fntxnXYWozZbPmSsQrc317obt97MmEzrC-RmaUss7nSb1Wj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtff
    dvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopeihiihsleekuddufedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:bL8qZ6y_2Df4vFDpj351x1_5arV5OBSONpmFuNS-dzSf4aZTQwPvmA>
    <xmx:bL8qZ5ToUZpMYddd_KmDj2MILHGk-M30JBOAXHLVCI1xa8-Clzna2w>
    <xmx:bL8qZ1abK42wQ59mKpjeSMyMcZqsfakCHMxqBwRWEDofYaZbj0luAQ>
    <xmx:bL8qZyT5BYNCabP2oaw3iVHrFvxetY3lkDPFTUYAYoTKdMgkGBJAbg>
    <xmx:bL8qZ7fVLwvFJr5dxf8GTXLixNK7AbYoXRxnMpZOldJEd3W5qMMpEJy8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 19:59:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?5Y+25b+X5pmf?= <yzs981130@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Question] How to force relative path output when using `git
 status --porcelain=2 -z`
In-Reply-To: <CAH1CY-=FtMTSisCmcz7ovciPomXYBogjNCmqO1mEjN9H6zEfgQ@mail.gmail.com>
	(=?utf-8?B?IuWPtuW/l+aZnyIncw==?= message of "Wed, 6 Nov 2024 00:59:43
 +0800")
References: <CAH1CY-=FtMTSisCmcz7ovciPomXYBogjNCmqO1mEjN9H6zEfgQ@mail.gmail.com>
Date: Tue, 05 Nov 2024 16:59:22 -0800
Message-ID: <xmqqses5qis5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

叶志晟 <yzs981130@gmail.com> writes:

> I am experiencing a problem when parsing the results of `git status`.
> My primary goal is to parse the output of `git status`
> programmatically, so I am trying to parse the result of `git status
> --porcelain=2 -z`.

Interesting finding.  Here is what I tried in my working tree, where
I have a few cruft files left at the top, and ran these commands
inside the 't/' subdirectory:

    $ git status --porcelain=1
    ?? +ps8-v2-reftable-iterator-reuse
    ?? :runme.sh
    : git t/master; git status --porcelain=2
    ? ../+ps8-v2-reftable-iterator-reuse
    ? ../:runme.sh
    : git t/master; git status --porcelain=1 -z | tr '\0' '\n'
    ?? +ps8-v2-reftable-iterator-reuse
    ?? :runme.sh
    : git t/master; git status --porcelain=2 -z | tr '\0' '\n'
    ? +ps8-v2-reftable-iterator-reuse
    ? :runme.sh

I haven't dug into the history to see if these inconsistencies in
behaviour are deliberate, but I somehow suspect that the output from
"--porcelain=2" without "-z" is mistaken.  As the porcelain output
is designed to be machine parseable with or without "-z" (and the
reader of the output, the implementation of a Porcelain command, is
responsible for turning it into relative if it prefers), it would be
a mistake to turn relative output on based on the lack of "-z".

Not that we can "fix" the output from "--porcelain=2" at this point.
To changge them to uniformly show absolute (or relative for that
matter), we'd need "--porcelain=3" to preserve these inconsistency
output because it is very certain that existing users and scripts
already rely on it.

Thanks.
