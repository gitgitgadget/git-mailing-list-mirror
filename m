Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C2231CA4
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728814070; cv=none; b=tGKY8p7N3LLdVfJWLs48AZFy/9r31gTrxLPIBOuRMxryORzj8d7lrVCbZE94K16phversn8xGzHH9gw/U4pCuo4+bXh1hYq9zwuhZ5SKyILKrYb/eGjeHsZIh0l2Y+j6BV285eOBDuAbwZMZ/gXWJzcYTsaRSHh5qiD3tBzZwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728814070; c=relaxed/simple;
	bh=foJGum7LNVhR4LMAFcuDim11Xa4GUURpypWg5Lp16zs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZDOFWWMGgSuystvWAbFtAOMxU0PRqE+W41PZ7hPHI5n8aYXbHoPmSkTHkfZk5cJTMg52EV5rHS0zK2j9FCguOwKn3o/K30auEi7d4JrlkwGOfXxTGVXbdpp2hXEqqoWBd24qevv3Qel1HBFPYLo3D3VV3H6e0hbCJAt1RDCDpnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=npO8f9Zs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9KfbDCj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="npO8f9Zs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9KfbDCj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 002FD1380271;
	Sun, 13 Oct 2024 06:07:46 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 13 Oct 2024 06:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728814066;
	 x=1728900466; bh=Kk1hKlM/SdY3buBBSRua3jEIRQrgIEVd6pK3/mcwHCU=; b=
	npO8f9ZsN8EerQ6HiL9xRrLpknk2J+D/9c4OPzKHg1fS3PfS0bM2IQfjKZe+yuzg
	ILUZe2HZIo9sFfoB6Po1RQy29hfgZZKMS1rW+nnN4Rsk8M72nPEPoQLGdh8OBWHi
	TMEym2vUiWMw6QMMtxo1YRLd4s4CNTj50vatEha8gT9PVVjiEqAxwSBhxmvkq8XM
	xUuymiUNC15BwMU3Te2XAU8kKAZzyGpONK12RZofsX5vxMF2Tv7fKYVLwZyzDxgB
	Z9nLmTVn0xfZtqsSTNwYNE1S/z1xkd15En/zcqosLnV2W9GrPdKllJo9mjW7B51U
	JV6CxalO8JMzoj7A69b/9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728814066; x=
	1728900466; bh=Kk1hKlM/SdY3buBBSRua3jEIRQrgIEVd6pK3/mcwHCU=; b=F
	9KfbDCjVa/ZngENAEwxxRaS+K9pKlwrZYB/Fmaoe0ZlzZ3Juye9TTt2r1VJmHhKX
	s2wU1jpIR+p40bHYdjsLCMT2laulwKpjb4J2nXCzAIAyTyjy3xI0ZBgQqmlc814w
	N1eUnewCl5QNNFLXJ53Gj4OokxhnFAmvUPQ2XZ1e+9Ne0IBb9KeTCiGpJkPceYA+
	Xo9D6+ecH0k217ll62uevVIECcJpegf2YDyTV7RmeH3SdUym5/2SItipRhFcSr2T
	FLQ+8FE3nCS0eduDxfsk7jRbsObr95Wa1M25dsuf0zvzTdCNoNAQrbPLQruh4/FC
	U24SmjUQhlP+NKU/FCgZg==
X-ME-Sender: <xms:8psLZ6PAfh0x56YVPFRZhpZJYB9OiklljYygDSsSoEdhztf66nq3_cg>
    <xme:8psLZ4-TRKiAx1C0LP5O-7ZIFed-pW5tMGdc6uoshCMc63JzsuanRFoyxArrluP-Y
    8VBDo5RKMi4ld_NOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegfedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghntggvse
    hfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8psLZxSm-UJPYBau37mfkFdtqJarFY8a2CRoHw12agGbWZHde0pCgw>
    <xmx:8psLZ6sa1YZ19vQORJhS3TgDz3iXN5sy4PekJYCBxeXLL-8FmqeV5A>
    <xmx:8psLZyfBmfpU-E0hqWGO2nAjqB3NnnDN2Avk_MFZ-eeq-Bqt4JctDA>
    <xmx:8psLZ-3j2jm3o5tjMfpu3OTk1opQHyLdwF-Y6LmcvmDKkt_SjKynMQ>
    <xmx:8psLZx55GzVdlKJNZxaX7mD0mIe3RytTPU0bLDWBYACsuHpctLB1DOxl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5038A780068; Sun, 13 Oct 2024 06:07:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 13 Oct 2024 12:07:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Bence Ferdinandy" <bence@ferdinandy.com>,
 "Karthik Nayak" <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <16d2d47c-5887-4658-b6db-996dac075828@app.fastmail.com>
In-Reply-To: <f7a7046c-020a-4365-baf4-49184bd2c60b@gmail.com>
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
 <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
 <D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com> <xmqqa5facosb.fsf@gitster.g>
 <f7a7046c-020a-4365-baf4-49184bd2c60b@gmail.com>
Subject: Re: with git update-ref?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024, at 11:34, Phillip Wood wrote:
>> I do not think update-ref is a tool to modify a symbolic-ref.
>
> Didn't we add support for symbolic-refs to update-ref with
> 'kn/update-ref-symref'? Maybe it only works with --stdin? I've Cc'd
> Karthik for clarification on how it is supposed to work.

Yes.  The man page says that you can use the `symref-update` command
with `--stdin`.

So the issue or confusion here seems to be that you have to use specific
commands for symrefs.  git-update-ref(1) won=E2=80=99t try to figure it =
out.

That seems in line with a plumbing command.

--=20
Kristoffer Haugsbakk

