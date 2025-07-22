Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61E1754B
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160948; cv=none; b=dg6FzqVrs0DUxEoF59VUZ47+/uhL0T619mBHaJPoZ5dVYgVDTzYEJhPi6h6lEbjV7fKCSiHhXYi+WdbmC+WjgYjvhBAJRC2sXejAv/5iYDBcrGUwAKOgGVwKM2xS1PCyR44UmVe5CMTJtHfyZpwLP1tL5dgzLomWpaENYaZBlMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160948; c=relaxed/simple;
	bh=5Rj5ZT14K+BlKaxeArr/RP49Rf7zY3dxDoDgvlxxohA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rOhlG7vGIcdFYzR405c0qK/B2n4sTs1VL6Ss0gHYFlquEyT393bIuQQwi4ll60Makl3l8R1Ydc3DwVNFNun3lvSunnlNFrl3skHGp4Z3qTL2Oz6uDR1eH2vbICQ59o9Qf+wDXzU7hgzcrYHCQ1hXkVPBjUvlp35jvNV3fU9lAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aq7INQIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bqp1qxXD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aq7INQIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bqp1qxXD"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C5EF1400141;
	Tue, 22 Jul 2025 01:09:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 22 Jul 2025 01:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753160944; x=1753247344; bh=whhjaZgFAo
	yTO0lZnlvQfuQgDklDQlINkEKjCyLPXmI=; b=aq7INQIF8oKcdC5uQdLBAS3BrC
	Iu0ao5VpTbOhNz9gi2dTq5IEFv6aBT2PTLXGq9rAomwa2Ljx8UmX/wjjfj0QdLMo
	2HW4XtVi7CgrVWmnGdDJf14N9uMd4qFQCfm/b0vex2560DukiG43wja5al7vEq2r
	6w+v72m4IEvFBs8/+BI4/W99SY6iemGUIXe8PU4ueEhNwJVlTsvx+meoC5UkOWfJ
	n/s1boDRuqs1cMt1I9/3/Z6wAcnF4tcZh7DIVzeySRyaRpJYTz0IrbnR80zvSevi
	dmWkCnyS0jnDVzwMbDD9BZJSdUajuMUFRScNyH1+3ZfWmYZRRzh3D27ntr7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753160944; x=1753247344; bh=whhjaZgFAoyTO0lZnlvQfuQgDklDQlINkEK
	jCyLPXmI=; b=Bqp1qxXDtrIkFYiBe5HcYf+gvTmIDcs6rEWUadVFLzcA6TmYQSU
	mrDy/1yYZZCOK/cGtjXN1bHOScmbj9o1KhuGC8fpChRZkpmMtIMifcp3yGS3neow
	aZfha6trTuZfi93yzGNUqePJbM7ADltRFlZdhgix7yjg0x5bouSZbpSBL6Q+MLGg
	8JRnDX8GItcEMs9WXMisDg7ml09zAAvxXWo+vyz3dwpt7zFPZrNptHlMziLyoHeM
	31rVVZqIu2pBPhloDySN+vgwGOIWUvg75jkGY//nA5bpUjRxO8V7aGzOE7ZUPKDv
	6ZyqvYOTAEZy4e9wNPdLhuU7hIsOS0me7Yw==
X-ME-Sender: <xms:7xx_aPPfpSNT4Y7j4hbsT7OLTuTcn1zKC_cEFoET412huxp4kXyTqQ>
    <xme:7xx_aHiIHE75uHHXKq2tn65opVzVJEjM3pDXK3Hl49UAXahRiuHXNxygdSHCBjsPC
    W9JxSM0X3LVW8p0og>
X-ME-Received: <xmr:7xx_aEtZEVIcjP3PGEp5UY-Hm_wZbJ6cQhYUW4vtQtmXbgpro8Lqyh-kl5hEHo1GTCTM00d974wO9tC7K13x8JFyVgbeO7IdZFsrHM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7xx_aFQ7dSodr0pycVNJDc1X6h3U2hJbNpPHWFk-J9I03Eb20FDEyA>
    <xmx:7xx_aI0a9UJQGGA-qa3fSnxEor3dV9K3F4rnH46yKsU0os5ZApA6Vw>
    <xmx:7xx_aKtXDexwDrJCvqusiuWrnhLKqdy_2ds2qoGYRB9QVhOm3mBOAQ>
    <xmx:7xx_aOjwfiityCJqFhpgpkSgxXAMU8ApMz-XHbqeD67jH_JDt_a-9g>
    <xmx:8Bx_aFogpI9dwvZ_z8LQYZPQZf4xJg82bUePl4CtwnEgQ5L9w15bnOWB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 01:09:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent
 emails to an IMAP folder
In-Reply-To: <PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 22 Jul 2025 09:07:26 +0530")
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
	<xmqqpldtxsp7.fsf@gitster.g>
	<PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 21 Jul 2025 22:09:01 -0700
Message-ID: <xmqq4iv4x15e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Or maybe you mean, ONLY send via imap and don't use SMTP? Like
> this users can use their email clients to send emails?

Exactly.  You sold this feature as "have send-email send the
message, and keep an extra copy you sent in your Sent imap folder".

I pointed out that "have send-email do everything it would normally
do before it talks to MSA or talk SMTP to send messages out, and
instead drive imap-send to store these messages in a folder like
imap-send users have used the program so far---as the user will send
the messages out of their draft folder as was traditionally done by
any imap-send users, send-email will *not* send anything out itself"
as a possible different way send-email may want to use imap-send.

These are two very different use cases.  We could organize things
this way:

 A1. When imap-folder is specified, that IMAP folder will get an extra
     copy, in addition to what send-email sends out;

 A2. When yet another new option, --send-email-no-send, is
     specified, send-email would not send any messages out.  Even
     when this option is in effect, if --imap-folder is specified,
     that IMAP folder will get an extra copy, in addition to what
     send-email would send out (which is nothing).

Or alternatively, we can have two very different operation modes
that both involve imap-send:

 B1. When --imap-sent-folder is specified, that IMAP folder will get
     an extra copy, in addition to what send-email sent out via its
     usual route (like by invoking MSA or talking SMTP)

 B2. When --imap-outgo-folder is specified, that IMAP folder will
     get the outgo copy, later to be sent by the user (just like a
     user of imap-send would usually use), and send-email would not
     send out anything by its usual route.

I thought the latter would be easier to explain to end-users, which
is why "sent" or "fcc" or something like that should be in the name
of the option when operating in the mode the patch implements.

This brings up a yet another possibility.  Invoking imap-send can be
a new third way send-email uses to send out the messages, in addition
to existing (1) invoking a local "/usr/lib/sendmail" program, or (2)
talking SMTP to smarthost.  That would be very easy to explain the
operating mode B2 to users of send-email or users of imap-send, but
it would be a bit awkward to find where B1 conceptually fits.

