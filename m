Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC71ACEAC
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380896; cv=none; b=Og6wEfBHv+yUCEHzuowt4B02su/URVmSrpKiDJej9cbKenvMeVfSa07YziMZpn17ueUVvWWpoRnOCgXx13gR/5Yvxs3ueloZAxsvsq9Us+VemAmrp1Dod4xqSxvqioCVa1XIzy8DLntTsmKmIftDKsk6U/cICXWhLZ3VFwbY5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380896; c=relaxed/simple;
	bh=nLr4lzNSmIEdTN77lUWBv1f/JiDOqU3jTJsfX5+mhs0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GwmqgTiHHdjN+0ryjaz14td5keZxn1WXAIYkbUSaNR0guS0bSrJc1i+X5sWVnFhO9Xp9TYyQUGWVT9x8bzliV69paU3MiL4o25Ybb6NOUbcO27c0LPRpGCAF/MduuSaxoRvaTov2rBvaPrBbpBkjn/3eZlvq/K+7dmPEIjq05JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Nardggty; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dGVMshdN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Nardggty";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dGVMshdN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E8D002540141;
	Tue, 27 May 2025 17:21:33 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 27 May 2025 17:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380893;
	 x=1748467293; bh=QJos5xfbdHrlE6qgATwjwqtfnp6Bm0e5/gQ7wGPBvGI=; b=
	Nardggtydv6VupbpJHqItyJd3M28cQbrTm/P/ke+t4gppZBa0eaamctuTwAWwoMv
	FeAUgWKpiYLGWna5B3/fHi7nMy/DOa7AK/MyKaB/MBVSW14MVsraVVa4eSxEyhTE
	nl9jOOJAZl+p12Ph0jIBKlqN6Lt6ap+pf5aSEjC69+B/jAXvywk8grrAhuTCKR+K
	kFVTDIeQhndjSCNqUUohSraUIxKUL5YNlppA2QBLV7wJAuY/ZHGXVl9c4CGhbJ8n
	4nN8VX9jV2WGyN+N53b1YHM7A3zTnxkkl3r8f7x2aVKYLQf06n8ZTji9MAixvxFg
	96Om7z0aYe1ejNjvqqcRzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380893; x=
	1748467293; bh=QJos5xfbdHrlE6qgATwjwqtfnp6Bm0e5/gQ7wGPBvGI=; b=d
	GVMshdNmSlwpB7GWMA0kBAUF0cD58Pesp+wEQ0xtlFFy7a3YGGhEM2qlhVX3ehvp
	1fqITXRiLJ3xNm055/HsxHwhSVXq4T2HmsBqN4Q4JyjcLFq3NS8G8a7kPkCEcDrc
	6xMez9sDvcZ5qBVUpYNdIo8qheX9DRvVQoj2jHgLnLnDFUBvZsOAXSDjlHomS1cI
	jt1ecc8AgnM10nRH5CXmTVHYtQAGESQv9hmVZLKTp3iYD49hnJbQnQK46xT9sc+6
	vgBpJcPKjOmt3D/rsAKHFY/yVtSuuOqIrTuryLUKBBThiPwCSQ0CCEIaefpQDr1l
	060HRsqa0Y4rIfSyuwJ2Q==
X-ME-Sender: <xms:3Sw2aBruCw0fSIKegHYbY8ZhTKXKB7_DjBU1HY2z8GJkv3UBpSF_vVw>
    <xme:3Sw2aDrZ7ZnpYHi-B1dPs_8JirMCjSlbUpSf182wtq0XiUWjPyI4zd_fuFXv4Z2vR
    qfqHCBo7wyCkBssrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudeggeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelge
    duudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:3Sw2aOPxR8CC8PkpU2zXmJACoYWdQdwmK1ISXupLu1fHcu5UX_sLeg>
    <xmx:3Sw2aM5bG57XxsQ3sZqRMYJHb_WZnuXZKcUo6C47SdMAROxDO0kr2Q>
    <xmx:3Sw2aA7vTGihCwW-yF2tTKbflUmkahenJKrD7QoJdBSUY6LnJaCXng>
    <xmx:3Sw2aEj5Vo02FhT1gaf1QSMJQYsqmwpeWOkBYURewJYIHHHTT2IugQ>
    <xmx:3Sw2aP-qjk2cx0mZXyZsLo2Tp_6EjzxyxorGqm96a0q7RdWYNmDccAD1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7F86F1EA005E; Tue, 27 May 2025 17:21:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Taf9fec3ba48f0e1f
Date: Tue, 27 May 2025 23:21:10 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <59e4082a-6cbe-4a3f-b884-1d0cc7294548@app.fastmail.com>
In-Reply-To: <xmqq5xhmvuol.fsf@gitster.g>
References: 
 <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com> <xmqq5xhmvuol.fsf@gitster.g>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025, at 19:18, Junio C Hamano wrote:
> Alternatively, if it bothers users of certain editing environments
> too much, perhaps the indent code in the output phase of "git show"
> should lose the indents for empty lines uniformly, shoudln't it?  It
> probably should be a fairly isolated change, like the way how the
> expand_tabs_in_log bit is handled in pretty.c; give another bit and
> teach pp_handle_indent to return when that bit is set and the
> payload it was asked to show with indentation is empty, or something
> like that.

That sounds scary. I=E2=80=99ll make do without.

--=20
Kristoffer Haugsbakk
