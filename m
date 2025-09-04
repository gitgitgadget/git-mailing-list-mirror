Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBB29D27E
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968933; cv=none; b=Tzc37SvPIp5yq7g1gfOmC8JDPyqriWIBP8XF9FN1JAHO4OJfQfCJnuDqZ0weRsSf90FfumGMC4V2q5V6VWQYgQtUyVZAP886KDjozh+N8h8AzZvy/2AocCHRfognLur+bxy1erUyLrauV6xnGubS39Zw7mf8Y7Ai4eh+vTNqlfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968933; c=relaxed/simple;
	bh=FGqpS//m523NHKt1VNgKzpodfs4HCqVLZ19ch+z9RGs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EaW4ucXGuKB62yEoVXkaApR+u/D1vkLWlwO14O/5H7SwLaHxG4A/f0Hanla62gw0NQCXADHhDbcFIRUDGr5yGITcg49AEwaVpAEg/EZdXD/wIjCv7ic3a/UlOsbma0/SOSuVAGpSbOJJMjfc6XQ81vi01bkJvUfYNIvhZkd02eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=coJ+TxGq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cMnEKu4S; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="coJ+TxGq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cMnEKu4S"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B8FD1D002DF;
	Thu,  4 Sep 2025 02:55:29 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 02:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756968928;
	 x=1757055328; bh=kJWFBTdPgeKzB2mNR4Ehf/STAc3ASu6wlplj02jVeLo=; b=
	coJ+TxGqbrjsciCY2Kf18uCDBd+upG4nhQ+Tk+iOod7Rg7ghIQ2g7sgzi0Negfy4
	Hjbeq6/G+r6UYf7NqQNaH/RstUxVRxVGky85nBBhVim3/4c4C+38el9PdXLQGiKD
	UxCeHvHb8QUbc/jMpOAVrOg5H+ydis2azs7kggzqNevhap+JVGhyzAG8+JMCOfu5
	AQPtL285LnODQgZv5qxGT0/Us52AnEEem0fj1E2+lbYYG2i+L4BmRu5so9XleJZK
	ybAjmG2env3VD+7m3DC4kKMKBZ+P6QvwC0kJFsLtMwV0V9g3gYt5gg1vsQaaSX4f
	cuIUP8oRQvjDaExRft6jmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756968928; x=1757055328; bh=k
	JWFBTdPgeKzB2mNR4Ehf/STAc3ASu6wlplj02jVeLo=; b=cMnEKu4SaYukEYvab
	LsHdQM06XCX93Dqt9f8Nw4K43Ziugfn2CS7MSFD6URqtNRXCyEZwOkqVWT6DVRN4
	6QSZyLzg3TTMzm1IvrHT+FaxzdC2v9fn3hB9pmlyjEIUG0v2/EA2WTfbAqtQDUUH
	y+UHO0vBnNOpsIniBkPj6YIh/WY2J+gBqItnYl6eJiQ6kg3hM619H/ESNkKwkmAR
	kXo9Zv7rzV6N3/6MgMs+7QyBi59qF1RXl7bSh4vpp0jqUeTk5TTWjKPVq5Ks1uk7
	6RbEbtxcBms5jlNFK7fCNjRS1WG+lU39giRGWUz9PqonxXutJaP95hvRPuohKrD+
	7vK0w==
X-ME-Sender: <xms:4De5aGlw25wAoB7LGL9bJeXLOgEfZXEHVsYnM5YMu8bIfqCHHxCpDlk>
    <xme:4De5aN1OL-f-pHrxtxBMoZyDASER9557y3Sn3wB1vc9Z5kadaCQo1YiajzpEu43YY
    XcvcfTzTZ1OxGAqXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertdertd
    ejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepffeifeetgfehkeegieetudejgfevhedvveeileefieeitdettdfgudfh
    jeeigffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4De5aOrBmYUB3C6kKhvp5ZSrTHcF0DNoATFxAK7i1WOYiHTAvsh_sw>
    <xmx:4De5aFlKLqBqYnjtQXRusHU4HRF0GFtMq591loNlH2nugxZJAqSVpw>
    <xmx:4De5aFKJJSDACncGmEN8XHOIDfoOEKOT7oZkvpU2Xl6n7fsG8F4oEg>
    <xmx:4De5aKzWh_gUF7X02CyixZqZL-niu4EgMZ0EvwE9Hj-XpeD5pG_kKw>
    <xmx:4De5aFKASwZrcyOniFtvTfbBVnmEbocxLPV4nsu6mAE_kmzL1ZMiml_n>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B3A3A1EA0068; Thu,  4 Sep 2025 02:55:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AmWmHNzpn78F
Date: Thu, 04 Sep 2025 08:55:08 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <01554a3d-886a-4f0d-b174-1dffab0b924f@app.fastmail.com>
In-Reply-To: <xmqqplc6byai.fsf@gitster.g>
References: <xmqqplc6byai.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Sep 2025, #02; Wed, 3)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025, at 07:07, Junio C Hamano wrote:
> * kh/you-still-use-whatchanged-fix (2025-08-29) 4 commits
>  - BreakingChanges: remove claim about whatchanged reports
>  - whatchanged: remove not-even-shorter clause
>  - whatchanged: tell users the git-log(1) equivalent
>  - you-still-use-that??: help the user help themselves
>
>  Update "do you still use it?" message given by a command that is
>  deeply deprecated and allow us to suggest alternatives.
>
>  Will merge to 'next'?
>  source: <cover.1756480827.git.code@khaugsbakk.name>

Given the alias-hint point[1] I have some thoughts about a potential
next version (v3):

=E2=80=A2 Incorporate Peff=E2=80=99s patch[2] if I=E2=80=99m up to the t=
ask
=E2=80=A2 Then mention on the whatchanged *hint* that they can make an a=
lias to
  shadow it

Alternatively this could also be a follow-up series.

=F0=9F=94=97 1: https://lore.kernel.org/git/CAPig+cSL=3D-gD5+WomF7-hYjVJ=
_PH0m+0i8g3F=3DE_U3k=3DQNHr8Q@mail.gmail.com/
=F0=9F=94=97 2: https://lore.kernel.org/git/20250830022718.GB567900@core=
dump.intra.peff.net/
