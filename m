Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6422172B
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592396; cv=none; b=lRTAqe63g22KzkIpl5EQZQzC+RnrktBlnn981KplXE2wbKEeRRAXOYrIeoI/ey/I8STm/2zTWhP3s1xbe3wKny7kEX8Dw1/f++OQpy5hoPGluhJ8olPJQKrnYUUxYoZ5QZMx3q49i1vV6J2eGzTDkS0M7WuoSiqz0fPRXd8waco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592396; c=relaxed/simple;
	bh=ViEP3phb3X1xKg+dXVDIf/k7g6rmxr9tEPO2z0LD5tw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l0kYJy0z6gG1VgWUP7RhE5fcdCpjIjmEjrlg8Fg/TnoRfJQqf8makHuQqChG8X/KA9lQzM0OLOUPki0SWGedbysxs9BH2fgibeDqUs6cRnIAx1nCFLlygYpeUMCp3odVXXl/ZJlfqvIRzJHHKB/Bm9ZGuDmJFkuErJSFBosPjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=zWkEgn0U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FRd5d1ng; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="zWkEgn0U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRd5d1ng"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A191A2540146;
	Mon, 10 Mar 2025 03:39:53 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-12.internal (MEProxy); Mon, 10 Mar 2025 03:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741592393;
	 x=1741678793; bh=6Jn7JfrMFIyKPXWxXHIMU0RfEXN2t0XRElXX2RgBNis=; b=
	zWkEgn0Uz6R1cEMIiGU58W3Z5Qfs4qAh5d6UOpp4W3XTLHfD9bGiqz+IXFzowFxr
	iMFWdBIENyRgqyiJ5pnd4g6HzAMWxvsIYURSZCfTuLFiuRtBwENyN6l6jsQjx0GD
	g8ELLgc3ZvJtLNFXcYEBjuNDO1P/WtEVlG4b+zp/9xBAFpA6pTo7leFuIsjM4MY/
	SjcPc40DM3DnsQdhiyyJ8QxOlhf7gYCRlEkmDoVXT2nD8agnTHKs3ufpH6tISneT
	m2yYSanpZy5AqYrRM1/vvnOnWp6fDOt1FdbBpXraJxwXWDTIX4y3RoY41icwNvU+
	aEYgjyJioErdJhuqJCh87g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741592393; x=1741678793; bh=6
	Jn7JfrMFIyKPXWxXHIMU0RfEXN2t0XRElXX2RgBNis=; b=FRd5d1ngyxcSsreAY
	FO693KyfMkIYBIHzmiHSqO4hv4EqdESYl7NhdbS/eM1DsX8AY9l+pIyfLliUhbOa
	0jd6t1KP3fEACpYgytA9pU0iDGywgGP6gPhqGRiYt1dsmYjIH1kNUJaSGnfXtL6Q
	4hj1UxJ19VLX6VftI9HucpHm9wVN/rl27+wSoRb5kckc+roMdGRc/K85SFIShDii
	PxpEiRp2Qay2yJe84WIh40SrhGRJO+9YMLLLgnSgGZIXVv1sL/55pGRh5+4FRJMH
	NO+XpxerjSKjaubtPxqpIMLyFFnyVMjNgB55vWp48LQWltDyBLT8BtdZwdCAGtfi
	Mycvw==
X-ME-Sender: <xms:SZfOZw29klEABSvB48GA7XMRttKPAF895EhdwkC-svfNExEoghvCYMU>
    <xme:SZfOZ7FIRmcVcpGoOX6cx0qcG75eHZXQPMqrdVW-vEjA4rcAHbfzab0KJJdzfcJGt
    kVCuuJ3hKPoT_S7OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveeile
    dtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SZfOZ45RyJaJUqEiqnA7OEp1qHjPIlZjpGrg8hXgko2c0VCEpNE29w>
    <xmx:SZfOZ525W8Q_morznlVtqxNPo-nxaJ37w2FMozAdZ3O1F95OqeIR8g>
    <xmx:SZfOZzHa0IL0CKG5nK6qpIlZeS6r6C7xxBZOMPmi4Rwkn7KoLF8YPg>
    <xmx:SZfOZy-JB3trpae6qAkrgUmRNc3OnBoXgty2F27GXs9bMSAcnb_IdQ>
    <xmx:SZfOZ5N7I7qe5F1texpXm25YqBN-9JWFkGP-Qlyo7iLQBdAstOiH4POz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4BE7D780068; Mon, 10 Mar 2025 03:39:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 08:39:31 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, git@vger.kernel.org
Message-Id: <ba1fbb96-ae87-40b5-814c-4fcea106f956@app.fastmail.com>
In-Reply-To: 
 <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
References: 
 <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
Subject: Re: [PATCH 0/2] EDITME: cover title for
 493-add-command-to-purge-reflog-entries
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025, at 12:17, Karthik Nayak wrote:
> This patch series adds a new 'drop' subcommand to git-reflog that allo=
ws
> users to delete the reflog for a specified reference. Additionally, it
> adds an '--all' flag to enable dropping all reflogs in a repository.
> This is a followup to the discussion we had when I sent in a patch to
> add '--no-reflog' option to 'git refs migrate' [1].

I=E2=80=99ve been wanting a command to drop reflogs.  I use `always` and=
 get a
lot of entries that I don=E2=80=99t care about.  But I don=E2=80=99t wan=
t to set it to
`true` because I care about some of them.

So this is great.

--=20
Kristoffer Haugsbakk


