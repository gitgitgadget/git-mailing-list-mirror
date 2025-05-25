Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272115530C
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748198987; cv=none; b=G+11vA29AcQ7DUAF10lAQvi0zOdaylovYuKitlwAbvxBD2LC3h5IgmNa/tRyQNKr9RkyKVYwdPYnja6Yiud+JFRhFJJW8BL8j0BQoLZqheZORrGh09m8ac/kfAgiTrmbaK+oNtRdRmGRsswDkT8/Frb2+wXhyQirAuVOIOD/Ph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748198987; c=relaxed/simple;
	bh=d3qozxj40KbSWj7mqeTpv2iyQCMjjy7GRxM0lkOyjSQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FI7b9wkRj54ITsXHYlOUsnwEumIJ2Pfbag8H2ZVEZTw2Qn1vi6f17/4zBkBqy6YsKtLQT1tcriJzeuOYeY36GdNpZ8cLCLRQ7bExNhn+pscNVtmZtDw28njuh6+CyWSFzcKG3li7R9ppi4seS2hEjyn/ZxYKfM34NqstouT7stw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b9r36agA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DLExoO+v; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b9r36agA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLExoO+v"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 255FA11400F6;
	Sun, 25 May 2025 14:49:44 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Sun, 25 May 2025 14:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748198983;
	 x=1748285383; bh=ZcruD5fT5J616HrgqPAvn3vf5CaE7uiOtVVDy256L2o=; b=
	b9r36agA6+lmm7NYLu5IqDLt9i1EQaWlcQ90fiMJW5GueJOjM/BLGrdd8ZrHXZZh
	VJEvvG6d1XBwnh8MCfTWHyFLkPqteV4XpY+YKfFrEtykhG+Fc8Xyb06eklc4PRYz
	XyIBF7UogZx7tTrEag1pS7pOYgVyypS30g/ZO8sVFqEFbrAGPgSokymJig+eXsZE
	38mlirbhKKztYoCZfLVe0zfHv4A2cwdfHWsyIYDY6mecvDIrCJnbo4E1UnZ1v5Jz
	KXvEDQXGuA3IvG9MYS+4o9Nj8vpDwJ5Zu6B2IYjYP/N7zRCEJiT2EqrMl/HUmI+Q
	gkDlJ8wVRIZ1BbQ9hquCmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748198983; x=
	1748285383; bh=ZcruD5fT5J616HrgqPAvn3vf5CaE7uiOtVVDy256L2o=; b=D
	LExoO+vXdTyHajSTQgNOTjTB1wtNDeDEpGzbqMZgOnllpBGuRY0fKuvzy7hue0J5
	55OqSRbf3DTtqnK6crJP9evNxI6MthU/3f5kwz9QxdIl1+FzlPjfOsOPGGQDgCMd
	ZEe0pFWiUYPXzuBK42tEYx4578KKuSI6KTqv3sXV4c+8x0ngHkt4KbsY3B5Wx9lM
	t9Lr01FDZtqvW4uV8bhvkF8jL95XaJQ0KlAP3pI6k2pGbXf1VrVvLZtlhmLi9q9h
	XJSJo1/0Z6VglE0Y1nAfDa5OUgXyEP4+uJsIKFr6gy6vOI8EsOUOEI+dXbx70rDr
	NZABesdiGCaatCuldkmjw==
X-ME-Sender: <xms:RmYzaLGSa6X0Rh-cybo9I9KaO-oBXQOhFU0W_1RwQGLI_hmHuifaDZ0>
    <xme:RmYzaIWXuhXRyuNrhGpHWIfdeytDQ-E3JMER1btT_f4SilJZxWHfzK9YXOCEloC7G
    sDcqUs7me4Kriz_Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduheefjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelge
    duudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehj
    rggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehgrghrgh
    grughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjuhhl
    ihgrnhesshifrghgvghmrghkvghrshdrohhrghdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RmYzaNJZkOAkYg4AZ9GW4nQ8-Ft8qGWLZjOdHKni8rXfD1jGElwj3g>
    <xmx:RmYzaJFWpHwqjXx51Iq6VMgq0YR0quM8uW4osfBvFqd_ot61f3AskQ>
    <xmx:RmYzaBXmrn_8O9KdX5p4v4gqi3WNt_G3XYztTlmEGilcSt_b2knE5w>
    <xmx:RmYzaENxcVKYFKqbGBTUs8jLcuWBVIT-xYXTX8b6JtbMT6alCAVxzw>
    <xmx:R2YzaPg92OE3VJmI2UpSuvzhY6NCCSQjZATofVgMGfuIhKZnbuBC2en5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ACBF13020061; Sun, 25 May 2025 14:49:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2b5ee76eedcd71f6
Date: Sun, 25 May 2025 20:49:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Aditya Garg" <gargaditya08@live.com>
Cc: "Eric Sunshine" <sunshine@sunshineco.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Julian Swagemakers" <julian@swagemakers.org>, "Zi Yao" <ziyao@disroot.org>,
 "Jeff King" <peff@peff.net>, "Jacob Keller" <jacob.e.keller@intel.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <7f5b2891-262f-48e7-9c29-7f3265abd07a@app.fastmail.com>
In-Reply-To: 
 <259e20261e35908d5c7f6c36352f1f03be6da6ff.1748192784.git.gargaditya08@live.com>
References: <cover.1748192784.git.gargaditya08@live.com>
 <259e20261e35908d5c7f6c36352f1f03be6da6ff.1748192784.git.gargaditya08@live.com>
Subject: Re: [PATCH v3 1/2] send-email: fix bug resulting in increased message number
 if a message is edited
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

> send-email: fix bug resulting in increased message number if a message=
 is edited

I don=E2=80=99t understand what the bug is from the title.  =E2=80=9CMes=
sage number=E2=80=9D
sounds harmless.  It breaks the threading?  The summary/subject could
say that instead.  Fix threading bug.

On Sun, May 25, 2025, at 19:12, Aditya Garg wrote:
> In case a message is edited before it is sent, its message number gets
> increased by 1, and so does its order in the message id.

It feels like this part about increasing by one and if-editing gets
repeated at least two times in this paragraph.

> The cause of this bug was that when a person attempts to edit the
> message, the whole sub process_file gets terminated, and the user is
> asked to edit the message.

Here=E2=80=99s the repetition.

Also I am not familiar with the code.  Just testing it I get this `6` he=
re:

    Message-ID: <20250525181003.40129-6-kristofferhaugsbakk@fastmail.com>

Which was incremented every time I did an edit with:

    send-email --suppress-cc=3Dall --to=3D<me> \
        --confirm=3Dalways one two

But that turned out to be benign in my simple case since the next email
used the correct In-Reply-To.

So at this point (reading the paragraph) I don=E2=80=99t know what the b=
ug is.

> After necessary edits are done, the whole sub process_file is executed=
 again.
> The way sub process_file is designed, every time is runs, it increases=
 the
> $message_num variable by 1. The reason for this was that the function =
ran
> again everytime a next message was sent in a thread, and thus we need =
to
> increase the message number for that message. In case a user edits the=
 message,
> there is no check for the same and the new message gets treated as a s=
ubsequent
> message of a thread, therefore increasing its message number by one.

This feels like repetition again.  You say that a variable is
incremented because the message is edited.

> This breaks the shallow thread logic which relies on $message_num
> being 1 for the first message, and it gets changed in case the user
> edits the first message.

If I=E2=80=99m right in my assumption that this number is the `4` here:

    Message-ID: <20250525182426.41076-4-kristofferhaugsbakk@fastmail.com>

This was the first proposed email I got with =E2=80=9Cshallow thread=E2=80=
=9D (all in
reply to first):

    git send-email --suppress-cc=3Dall --to=3D<me> \
        --thread --no-chain-reply-to --confirm=3Dalways one two three

Then I edit all the messages.  They still all manage to refer to the
first message id in the thread.

I still don=E2=80=99t understand what the bug is.

=E2=9D=A6

    $ git diagnose
    Collecting diagnostic info

    git version 2.49.0.780.g892193c3f50
    cpu: x86_64
    built from commit: 892193c3f509fb8a9e4e7a5a19a2e24137befda8
    sizeof-long: 8
    sizeof-size_t: 8
    shell-path: /bin/sh
    libcurl: 7.81.0
    OpenSSL: OpenSSL 3.0.2 15 Mar 2022
    zlib: 1.2.11
    SHA-1: SHA1_DC
    SHA-256: SHA256_BLK
    Repository root: /home/kristoffer/programming/git
    Available space on '/home/kristoffer/programming/git': 200.56 GiB (m=
ount flags 0x1000)
