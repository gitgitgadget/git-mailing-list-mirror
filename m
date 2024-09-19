Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DF1CD15
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778023; cv=none; b=tNmlzDXpvuvhh6G5gPJHFcIBMSOGXUzgaokRSzOBbC/LQhWVC9kqJqSWbch9Yxplkfe8yIaJkzRCJeR/YqDDokZL5UHLb0Hkjytzqe6jL3Zq2l6EM9m/ZD+gwZQy8qkLZl8KDdDE/ULLDIOEKFmba6Tul+ZAYY3RiS+DkXjvihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778023; c=relaxed/simple;
	bh=/f7yAJ1Do1Up4lku3s0wnznONRbDJdoRwW3uc0PUff4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lDFn29izYVqJalm1fZCiwuWfPJXQU/jcsPSncTysrzyIcxOU58WJ5v6zY4jAFhm/K3LcFEzP/OkF/QeevCUYNvWIo2v8mTCzj1ZbvWNpvR0gbafuseuX5Ups3Qzg29i8TmHTTDu3OfW0ZGCjd8hfGX+HC8ddGNct23DOK7Y0q2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZwLcLDeo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLj03w9A; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZwLcLDeo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLj03w9A"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4450713800BE;
	Thu, 19 Sep 2024 16:33:40 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 19 Sep 2024 16:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1726778020;
	 x=1726864420; bh=166igxpN0ZEWjaLNArqArkKr8xUIrcHPpJJm2+voxhY=; b=
	ZwLcLDeoA7khAvE+mf8ylNcT2UtVDmmEZ2kGlgfkSDksWTylNeDtvBCxcB0eZ/YE
	v8aUJHje9HQDlxcLfYjdaTC2HnzOiadXQ25ZAtkR+uC0uHcriJBXJrJeDGW8k1qN
	JZL2VmcSeM11AlldpLd02TU4DBLfVpKZehjFixBnH8f3RoSLZq9EMhqzTwAKMRP8
	kYTKXowmzpswJtvobU+jy+51thZEZtFkYPLQhPYwrO9c+AQXjW/SLR6CkOrxZUJD
	j3SdQPqgCNIkDwTfo4F/x7qinSSmLUA7j4hv+sYQHX685C6zkaXia+CJw15I9yRO
	jxRzZkzqctL9RaBxsJYHlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1726778020; x=
	1726864420; bh=166igxpN0ZEWjaLNArqArkKr8xUIrcHPpJJm2+voxhY=; b=H
	Lj03w9ASmjVQsU2u3sSdgJODhJtLCSgjUoT/01mTasQIVGRc/L8POJMiq2I6TsrQ
	hl8B9yRNEPtxPqnWy2UeT4PNUmaeMTotb3sIft6s7013G3jTienj/89IqT/8lmU4
	AiwKQBUVrwwBqL8dStQOXzStQz7+na4PtS3FUzA+nPjr0N0HjIOdrMfv+hrEF6x1
	rvyGEW5+T2JPzzmIMZ6JK1oVSFkUjrDOEZxXAcN8riLVvWYyW7FjPA7pK1gy5KD5
	tb4aIUtOk+trOeekwykyQM+Ju4Zmjx5tBYDg/OlVIXKYd/HjKiGVu/g1WTfxRYIP
	ptrLCdRyj/TvsPC+BVdMg==
X-ME-Sender: <xms:pIrsZoNFEXmRoEYFW4o_OfREuGKht5n8rGUNBIf9JZWafBtsETVXxNc>
    <xme:pIrsZu9miAfwd7F0qYUQm6qeDuZOo8i7r5TRbPVLileTZXDpdkfbs563uvSPTnrwk
    qWXy9HFI6RFbNovgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeluddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeehudfgvefgfefgffdvhfffvdevveegheehudetvdfgueffjeevjeduge
    evfedvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrlhhgohhnvghllhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pIrsZvTlQt899EjcPw8qDadzZzipvPDQUn8gEywFUnro0LpBZzDeJA>
    <xmx:pIrsZguN6ANUHxrKdwXEGSyGcM-Obfh80Zlrv3Tb8n2eGuxsBAdgDA>
    <xmx:pIrsZge0I2X8ekzMX74SmUljlZVSWcoliu5TiqIUokvo8ysvfS59sA>
    <xmx:pIrsZk2NTK0cvIEho_ev_LEHNU8xTdMCW4JGKsxIWMn-vfXwUSNlFg>
    <xmx:pIrsZo5vagesiNUAP0u11Js2s0mpnUlw3Q-hw22ah_VQIN8h9A6RMVym>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F3D6E780067; Thu, 19 Sep 2024 16:33:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Sep 2024 22:33:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Andrew Kreimer" <algonell@gmail.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <ab9213d5-fb1b-482e-854b-4f5d4e82821a@app.fastmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
Subject: Re: [PATCH 00/20] Fix typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

All of these look correct.

Maybe all of the commits could be combined into one commit with the
message =E2=80=9Ctreewide: fix typos=E2=80=9D.  But that wasn=E2=80=99t =
asked for last time.[1]
So I dunno.

=F0=9F=94=97 1: https://lore.kernel.org/git/xmqq34lzqyi8.fsf@gitster.g/

--=20
Kristoffer Haugsbakk
