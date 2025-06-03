Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F60268C69
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939650; cv=none; b=TLhthqNnlbqCwFuWc/Dv7cP8pcwuUmfLmtKrK1WuWgVVunGZzGErw5xHgtGzWzDPaOUSmmCHCruQ0SqYu4J0usdfAJUirqfS38uMkF+GzvlO4KWqrSPZefkDGfmybhRvjgaNc2/bNfHDlv34z3rah2F+JrncWELlPsQ4hkOKbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939650; c=relaxed/simple;
	bh=kw/3CjboY1I8WlYYlJ42fuh+9H7NVVSV1MlBALzJhS8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=smffPbSmfr7mnqBXCSiHqe+FSRAYtNGr8iZAn/GVOiUfEtHcu6SFUQjZsCrP+MODlassSvjaNiG1tHJkOfFljvifMGCnhwRceDyGx6jhv0aiZB4VSDQ71WD8HW6eqjD/3kqw5GP0AJ7+WWHGEwpykroRZSQ+DBYssKf66SGxgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KT11Cg9O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A6NDN5pT; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KT11Cg9O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6NDN5pT"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E58D82540142;
	Tue,  3 Jun 2025 04:34:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 03 Jun 2025 04:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748939646;
	 x=1749026046; bh=kw/3CjboY1I8WlYYlJ42fuh+9H7NVVSV1MlBALzJhS8=; b=
	KT11Cg9OkUNnESdb7hr6zZ9r/faLdcLb2QmBlB0xG+DLHW/TnW2fgRtPqxOCCa8R
	VyG5kLQ2XmUeZucy5UiRurQI0eA1AOjVj+KJe9rjkxG77KA5QChFZComESYIOK1K
	QHemPkDjsAGmwJGx0nHeIqwhd906g5WKE4r9FqvKjTFUbNkiPMJqwUengPK/H9yq
	uKMEkk4jrbbR9lGf2yQ5GZcv9Rr95SNr1/uHoyR3TbgF1FByeH1rIDl/pB0gDdbt
	PRMXwGHzPf7wbbHzHGb3GpFuj/9QOviNy1CNFB9fawg/Cz2XfHiTQ4MCzRYEeWXb
	SKGCqGJ/rtlxbuslHYin2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748939646; x=
	1749026046; bh=kw/3CjboY1I8WlYYlJ42fuh+9H7NVVSV1MlBALzJhS8=; b=A
	6NDN5pTk3PIqcpZhkRT4NJqryvR5Tay2ldVwuY6kGJE68yqaXvPw1oXQssaSxZH+
	YBmyLJmMCCzfI26snvvmCnGhhLPoQjo1AoAU5y38+V42ETMS6YPFRhj55uYdoUS1
	x8W3LETb7q91i6FxQki+jfGV9Cp1qtlDA/qL+L0d3rP3MP8jgmvng6FylpAJB4wW
	RO9hKuxrbTSvMEMkVIWWytA0GSRervzAcDVrRW7NthJfvmUCR0YyDDHRiaV5kmla
	8vZcbATOjdL6OFn43HvS1s6s1jp2tr3MXT3sneDYQOiJNN5fPp2lgqd8P8jsM7cF
	6rB1ksC4TqaPyi7EgCopw==
X-ME-Sender: <xms:frM-aEftoj3e6D2SyHWxgs7cuawjEb4uAXfAhARXbe4FO2ea9EYmqRo>
    <xme:frM-aGPt9javQj6FEH5RkYR9CLu4hzCV1sWJDACRvPXWf2lSl_zEyq11iRih8dcoW
    J14xuwy1Oq0j7iJyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegtddtjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvge
    etkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epuggrshhrrghfleesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvghtfihorhhk
    shdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:frM-aFhdDun88DbvajBRtmAFzI0pQySv10tmOR4qC1ZMHVh45Z4Wkw>
    <xmx:frM-aJ86_sQUnull1_hAM2Sz0kKcMFGy9OhmCL_kc4R3Jn1rkpUq7Q>
    <xmx:frM-aAuUwXHxB13LL-XJG22iMDc-mG4BnqP0DbsvzMcaTZbWhTs4LQ>
    <xmx:frM-aAGHeN_mkI9vcaKzu1WwnVHsVi1NXjnXV7hbW4kUJcGCmZ8xwA>
    <xmx:frM-aMNv0nhYyaJpi8GlBbzQxM0cz6bs0ipGRqQaHo1t6NQ0IxvocSzP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2BF651EA0060; Tue,  3 Jun 2025 04:34:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tbeb4c5dafec16daa
Date: Tue, 03 Jun 2025 10:33:40 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 git@vger.kernel.org
Cc: "Yonatan Roth" <yroth@paloaltonetworks.com>,
 "david asraf" <dasraf9@gmail.com>, "Emily Shaffer" <nasamuffin@google.com>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <256e9e60-fdea-461b-b43c-8e6024b773a2@app.fastmail.com>
In-Reply-To: 
 <CAOLa=ZTLvL52UpZZbXtMefHPE+s5PWhUR4ZLgB6T_JMFjqfBZg@mail.gmail.com>
References: 
 <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
 <CAOLa=ZTLvL52UpZZbXtMefHPE+s5PWhUR4ZLgB6T_JMFjqfBZg@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] usage: allow dying without writing an error message
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 3, 2025, at 10:31, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>> Sometimes code wants to die in a situation where it already has written
>> an error message. To use the same error code as `die()` we have to open
>> code the code with a call to `exit(128)` in such cases, which is easy to
>
> Nit: This reads a little weird.

Maybe s/to open code the code/to open-code the code/
