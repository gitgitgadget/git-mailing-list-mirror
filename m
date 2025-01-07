Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3E190685
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247704; cv=none; b=nFwDdQ2qdKQEf2vZTknblQZ7rH5SyOvqSY5JXzjhYBbgnSH2/8COfW4BNDN/FUNcaxw7u0OdC6lFM8Qt5NUSNir9I/yUpTvKzpFostDT4/ckoZLS3Rav7UgIgmZaHexAPTEztv8XXMnJ+/Y3qMlOyrpo0Az5Mr3uVtuplTJO4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247704; c=relaxed/simple;
	bh=XOl5WQYjeScfT2k5C/NXU5HmT1A04bJTupKY3RWngsU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a6HRIeh2cMX1ieTqklgfi4lVJ1p2keIXltR0MIuLYH+V4y4kEzBVPx8Y7Nz8+6JWqhehmCpCe0dEfw2FPROj8hEyCCaM/1hMiGKlGOmf9iksOF3xfvmlBW+jjiY8XOR1+or1PYLUp4XEnnqE5xGiDE4j4HOuHWIlpd9WxNUl8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZLJgj02H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H3XV3G1j; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZLJgj02H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3XV3G1j"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 87679138021D;
	Tue,  7 Jan 2025 06:01:37 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jan 2025 06:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736247697;
	 x=1736334097; bh=XOl5WQYjeScfT2k5C/NXU5HmT1A04bJTupKY3RWngsU=; b=
	ZLJgj02Hv4DNepyEBwvUnUx7mfG/GlGeIP5tfCk9fCgFEZoPqzJtF4bU81v/3Lsj
	vBepsufhn4zGaVJkEm3sGfaR+Ok61SrfnbXyVXbNa86vQAVy30Wh72Le+z+WDC+D
	ohNgIiQTKSZL4/wP9KKSJsVRHFn5Xwx+vZTrp1ah2X6bDtgtiAdVcKGBj48vdrC+
	JdEkVeklWv9LVT1AmBEOKENiU0/2QZOyD+8zmqq6yRlNePspMvIlCGEGw2FXcOOz
	MyymkzIbdQ8PmTztqSEJ3eE0QEne2CxMJZcE8Kc2niCQzKp+gDfb1E1m/p1zZlSv
	hsr3XarVuPuMfjUj+JJ6xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736247697; x=1736334097; bh=X
	Ol5WQYjeScfT2k5C/NXU5HmT1A04bJTupKY3RWngsU=; b=H3XV3G1j+KV+kRs6y
	e3y2aYLHVmaqAjdhPqio6ZN6R60VrNz1lAEQJraZDryIffm/6gU655xGE9alszxp
	D5Xi/FW1woCvhxCMkEnju+D4yOqKIiliKc7NOyTb5GaqyCkpVYBzAMmJp+sfOeU4
	mEDPWLpn4gRVnqg3RSvu62xf7ziBA6aY4O2X+nWaU9MFfII4HRyvUVIx3BwyNCW6
	LZLehkhft0RM1OZUr7vv51I9t4gZ2+9+gH7hl6RjDd7e9trmS9c6PHSXdNV2qfwC
	tbDmnJh6p6BkXDp1m4FnTcxPb3jxO16LJYa3FWQOpYrkQulfvPeLMhTeOEFtY6LV
	Rg1jw==
X-ME-Sender: <xms:kQl9Z1-iKdZ1zmJLghVIhYNsvzc2aVSB31-oaCcA6wugMjFrFh-bHjs>
    <xme:kQl9Z5uYJfFWdqjskNJgwRC8P2elhK0OD-G00gKUSmrW7auPQA1xLKdgiSWqCDwRk
    JiJY-ZCD63WUsDhwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfeg
    feejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kQl9ZzCUYYSnLoODXUJeF9Pf-zuAD8iNkWwZjLSzCAl54UoTJGAGOQ>
    <xmx:kQl9Z5ek0okIVHdWsEERVAKGst3ZzALOlv7_EpnEb1ITjk3D7KE6Tw>
    <xmx:kQl9Z6OCB9h7_12ppNX6mYXXa7AL7wb2udeoOmeuk3lswpWYAhuXNA>
    <xmx:kQl9Z7mtuwMK3af7xJGE8ViVLPVW5D5CePU3_uGNfUXsuTrJu6egaw>
    <xmx:kQl9Z80Li0bTuo_fr8Y45fs3qe_oLkkY-bqyvsBXLSrBnNY8F-A4kDwj>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3DC87780068; Tue,  7 Jan 2025 06:01:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jan 2025 12:01:14 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>, git@vger.kernel.org
Message-Id: <f3ab08db-5dff-4da3-a075-7e9b3eaf1f78@app.fastmail.com>
In-Reply-To: <20250107071824.GA594237@coredump.intra.peff.net>
References: <20250107071824.GA594237@coredump.intra.peff.net>
Subject: Re: [PATCH] t7407: use test_grep
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025, at 08:18, Jeff King wrote:
> get rid of them.
>
> (It is also curious to grep in the expected file in the first place, b=
ut
> that is because we are auto-generating the expectation from a Git
> command. So this is double-checking it did what we wanted).

Missing =E2=80=9Cthat=E2=80=9D? s/it did/that it did/
