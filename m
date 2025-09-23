Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3C3128C9
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646481; cv=none; b=H/BfrxWYeUPBby2qYSX4rmhT3dU2pG97RK9z9je3GTwDqTQ6VEKuzdh/Z/oZfsy3PP+GG1H/haug+Sg+fxjU6qEW1SPe/0lnRg8QxxbuaZOVG9joszgHCNfajG7KPhYvgmYRbS2IOHhxFqobYXEvS2JepQ9EQwoK9R1sR1ptuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646481; c=relaxed/simple;
	bh=AnHwX0v14YgPTFxwZyD8ioZ6ZlIabI8z5oA1czDAzLI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=ug+0UegEt/rtxnDi+bsLWkea0HGy2Fu9cksQtFI/njmxglUKWDo0opi4TbC2H6df7OpeSC/OgJPTgOE6Nlz00f/m4fn0wl63uZDz3IK9yH/Ak8+ECz+vEPpTGOy30aWai+SZDLLu3lE3G2JMYvaEPvdaKELwlS0tuQ8X7fsOX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CuMPV7GC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2zAkuZn; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CuMPV7GC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2zAkuZn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3D59140012B;
	Tue, 23 Sep 2025 12:54:36 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 23 Sep 2025 12:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1758646476; x=1758732876; bh=KH
	nl7MeLQ0VR6gp7vwNmwukh6ogpBwUNA6sDLgg9nGU=; b=CuMPV7GCeU8VpFmFor
	Pqwo1z/esFwaKNTrmgWkrLpG8jaiWDK3d+WMiGYD5hXT+LZMv6T9w05QMIElbvKM
	0NQkyvw4d8xWj6NLZawuBbl9oabVZCoQg+RsfWfa/UYrE4vmB7tEDw/C7GJ7ijUg
	KO0w9SSmGjsaq/l3xnqsWtsWrWK5Q8Q6kI5sO6E/VEv2efkXj6EmWVWpXIL6wJz9
	50wVsQJG8vD36znTdWagP8Qx8O+9Md+Cbjumx0YGO4hBKV///OUw1WjxYnnaiOAi
	ASZWJifJ9mAzA2WxHytV0AV+KHEAxSc0WKo8YFHkwAMn6xXICDIg2OMhWccx2ani
	g/kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758646476; x=1758732876; bh=KHnl7MeLQ0VR6gp7vwNmwukh6ogp
	BwUNA6sDLgg9nGU=; b=D2zAkuZn7YWH2Jixi2bsvVZvblwRFQ65Yv582V4UkxS9
	SJ0F7+MMOAICc9U32jpVDuGENg44CzwvUzd0zrlFcA430zCPzpPdCWVNCl1Q87K2
	144CPy93Ve7yyoi6Url+qRgf/IVMLJtSuEepmkYVjO6a3x7M2nrq2d2iC0Qj1iab
	A+XHl0F3RXoysKvMgcanJeJPTjA7twSp62cykRvsvr1ycMiTjbwlLXXYwUgVAlKd
	DCQP08TPpu4OMd5ibXD1oZrpQPdIwOU+cq+cAsuMp34JqyNOsAcNM8yuf/JBUnNY
	9NPd1rfBxRz9tgSfdApHPGsx1zwg2uagmgJ0Mjk5ag==
X-ME-Sender: <xms:zNDSaAdXG_8ntm_n7qa-KZwu1ZF1pm22VhLQTfrswcX9_wfuXkfYyHc>
    <xme:zNDSaNAr11a3BQESlMAC4CgmmM7t4wLLB3ciddrK7366XVLf0yxfClRdu6WZYwQRd
    bHyDwldKZw2edJ3fD6lglvD0_AAPjs3595RuuSs6UuW-k5La1alLIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiuddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhf
    fhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeduvdehvedtudeuleev
    ffelgfelgeejjeelgeeiieejhefhueeggeeuieegvefftdenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zNDSaPKNFQdCIyyxYFxio37IVSRP_AveAczXrrQ-CqRfjNqXbHnbPQ>
    <xmx:zNDSaBElp0C8l4MuTh_7BFpOwBu_cv7f3CRqUY7TNUIx_K1cbuXb2g>
    <xmx:zNDSaPSL6oUUFUIA-IfcACvNuNJEmyQMNhTkX7fiRtt_PFJJsBI6Nw>
    <xmx:zNDSaFG6IvkK7tOCymYmHsmTmaJpe1Iw0DS3zsSG_cs3w3f11srt1A>
    <xmx:zNDSaCwNRBA90nidFBw7QBkSXqO7FAuDMYOR4cbRGkpAfX_M-7KYfQ11>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7B4321EA0068; Tue, 23 Sep 2025 12:54:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 18:53:04 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <3945bf06-ba04-4ecb-887e-0f3a76e1c2f8@app.fastmail.com>
Subject: format-patch: why are the Range-diff: and Interdiff: headers translated?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

git-format-patch(1) has had translated strings for `Range-diff:` and
`Interdiff:` since they were introduced.[1][2][3]

    // Example
    _("Interdiff against v%d: ...

Is that how translated/l10n Git is supposed to to work?  I get
translating errors and such=E2=80=94that=E2=80=99s for the user.  But a =
Colombian user
might send out patches to an international email list.  Why should their
own translated UI (again, if I=E2=80=99m understanding l10n correctly) a=
ffect
the patch output?

I found no comments on these changes.

=F0=9F=94=97 1: https://lore.kernel.org/git/20180722095717.17912-1-sunsh=
ine@sunshineco.com/#t
=E2=80=A0 2: 688cb1c9 (Merge branch 'es/format-patch-interdiff', 2018-09=
-17)
=E2=80=A0 3: 881c019e (Merge branch 'es/format-patch-rangediff', 2018-09=
-17)

--=20
Kristoffer
