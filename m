Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301C3C38
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748769636; cv=none; b=OCOx1yon0eE6UVs4R1M6cUA6JFgg/ZlU/wmZB8uvt8rfuRXFMEQiJhogQWXizolreTBNNVeoghRXV8/vMcSH3e3RY6IC0yVDjmjOGkGay+lRvd+NUmNqLtznXV9Rx3ry4k2kANS6dck3MCNrI/G7MTwJpWv9uDDSS1UH6BWaYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748769636; c=relaxed/simple;
	bh=qfiUP2S1LQxnA0zMsyzecMbTIJLMzl/bhpZpty0gH/I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QjQuofief399vjNRG7GnubecEwLKNJQAFoTmFtKRzzRRwCzELtVmv9T8VZOGN/mrRKxMNIvEsptoMZDtYzdii8QyQVWV5TR0bHRIh2splG9qMzwuPis5v7XAyJ0lzJA0UlPmy9Yf752B7FtZ4/tuOGzzCZP/TTSXc+XuSrFBnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=d0pdOBTM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCzNDA73; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="d0pdOBTM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCzNDA73"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B46E81140106;
	Sun,  1 Jun 2025 05:20:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 01 Jun 2025 05:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748769632;
	 x=1748856032; bh=E1hQIII0VSYbQ7eQ9PJV7aHQIvj1VeYBlbqdjkb13mI=; b=
	d0pdOBTMLNSgYEif7mS1SIgICBdRiFvGJhbC6fqMR93KoPT1TPnBNxMW/g3jR6gN
	74yooP1PQYEUs7f0qVRTZh2oJwvFo9Ay48oecXDumZsawhPVT90aXAKpsUlWqbPA
	r6f7EbFneoSCNmPysltwPQMEFVtIoB0cgDNe5sypbB49czrygfVcLKvTuHeY4ICK
	l8F1PCZP4Q5IJJnnGvfzBBhJFP2tcYYq5yVDXOEKqjRKxw7ecCniNKmu4Y4m5xJ8
	swGtlzrN84WZyVqMiW8hbuvlCfWi3+QXVqkjdnncYQkpa8ikz2J9U/QX5w5NR3of
	o/8MuX6kKvonqjNb7VPgZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748769632; x=
	1748856032; bh=E1hQIII0VSYbQ7eQ9PJV7aHQIvj1VeYBlbqdjkb13mI=; b=m
	CzNDA7332HsS+MhF40UnAvnwKwhVJOISuA7jWqUYft00xpiiRKfE1oMXnA961jLE
	tdZjYrFff+j+pUvkdPKMu9+tanHOt0o5iLl7lnMJrM/xO2UpR2GOO9mu5lEE+K5s
	12ATdnaoZZ9y3zyaEXAMev7Vj9C8Ak08imhWUA5CW0ZeLUNeIyDdtIMpjfM0Q5uY
	/QgVjT3w0CtKKtfu/4wq5e32TbStOD5FEyHT7Hhhef/qLu2HfdL60FJheCf8CQjO
	NAy2hIpyC0CPlFDRm0pSMh8MouaTwQXh0jbSqjLSdNfDct/J3tOPnMw5jS0es8zZ
	gjD+5cveQwBFfPvDe4p2A==
X-ME-Sender: <xms:Xxs8aOTkKi-ENSeqvYUpPcp_J-SiBR2asWWNXVYvBLxc_5MldoM9cLA>
    <xme:Xxs8aDxpDqHLw101a0pnJDNaM00kgf-BFjk7OzRvcmA7r9qYO7YplXWURYDAiDwWy
    e8qx9z6_295l3q9wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefgeegtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelge
    duudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    thhmiiesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjh
    honhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:Xxs8aL0OX4hzQJtr_zsKRTrVdMtN7-HGLpGCzwykAW5CeyDVj7Caag>
    <xmx:Xxs8aKCA1jgIvUuvu0zl2B0z8ivgiD73L04CH0Uk7L6eZnf9HHcnWA>
    <xmx:Xxs8aHhIqHqjYoAzbk99mKo0ZinlOdMjK0E7-mWCTWOs8urK3ow8UA>
    <xmx:Xxs8aGpHScoKDhQEzLUcQudm7D1SEd0J8N9Hz6Zrs4TLAFRNeiygMQ>
    <xmx:YBs8aL3TAdnvl8Ms9tOIQzq6j-ns7lsj_nuaxffAzoOLGVZemRg-pzvk>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5C2241EA0060; Sun,  1 Jun 2025 05:20:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Td22eae76fedfbeaf
Date: Sun, 01 Jun 2025 11:19:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "Eli Schwartz" <eschwartz@gentoo.org>, "Todd Zullinger" <tmz@pobox.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <7583b751-5380-41b8-8353-bba2618a0bad@app.fastmail.com>
In-Reply-To: <20250530-pks-meson-tap-v3-7-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
 <20250530-pks-meson-tap-v3-7-676f5e41f2e4@pks.im>
Subject: Re: [PATCH v3 07/10] t7815: fix unexpectedly passing test on macOS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025, at 15:31, Patrick Steinhardt wrote:
> In t7815, we have the following test:
>
>     test_expect_failure !CYGWIN 'git grep .fi a' '
>         git grep .fi a
>     '
>
> The test passes if '.' matches a NUL byte, which we expect to only
> happen on Cygwin. The upcoming changes to support parsing TAP output in
> Meson surface that this test is also unexpectedly passing on macOS
> though.

This last sentence was difficult for me when I first read it.  It seems
that there are multiple verb tenses and it has many words without any
pauses.  Maybe consider restructuring with some comma breaks or
something.

    The upcoming changes to support parsing TAP output in Meson is
    showing that this test, suprisingly, passes on macOS as well.

> It is unclear how long the test has been passing on macOS already.
> 064eed36c7f (config.mak.uname: only set NO_REGEX on cygwin for v1.7,
> 2025-04-17) mentions that the test started to pass for Cygwin once it
> has imported a newer implementation of

=E2=80=9Cstarted to pass=E2=80=9D followed by =E2=80=9Chas imported=E2=80=
=9D doesn=E2=80=99t sound right.

> regcomp(3p) et all, which was

s/et all,/et al.,/
