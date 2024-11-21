Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49E1CB337
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177771; cv=none; b=B0/Mqi2yVzxCQJIAV/GtWttH7j2z9wbrP9bb+jqwu1N67D5Nhx6jun0crNhPuNtP/Sv/BIuvEWQKUJpPAlqF7ARkdlPgwVBuFCGRD7qidnYNLq58+jjzMoYbyX6rPevr6AEPHNdA+w5559bhXwcY4i8ORLpkSc1VhOYuC5tnlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177771; c=relaxed/simple;
	bh=r3fPDxtNPwyc1C9HSWYCQuvl37LktuHzs6T+NcgO1t0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JhMHPtrWvF/1wJsjgjTVLtpXMtVB7CTtYimZeDejvxfGJZTViQwJ5PX0qwxHDfiCUWNUTQ/QpnRJ02+D8bynCkApUJFxoSKiKr/PZ4QBPHR8P+rxQ1s3bjPeyGYMk4GQ0+rTs/szbRr1Vvc10UgEZ3JkOTQmq0kNnK+964kT6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=X3MQB0tQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mnzwZeCc; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="X3MQB0tQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mnzwZeCc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6EC9E1140187;
	Thu, 21 Nov 2024 03:29:27 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 21 Nov 2024 03:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732177767;
	 x=1732264167; bh=bvT1TKYMtedkDbc94NEPgOX7+JuEjgjFZEjVoSnGAxI=; b=
	X3MQB0tQcX4/YEnzQbMR/Xz7n1ii1cDr8N3l1R4MfgOXfLRgQpsfwu4tf8VczoBf
	z4DiUq06XBxzezdtCjPwLigzg+zIbKvJCiWxl1YNNybUcPO16Nu0B5Tp0V504JQC
	RgOb6GnyxT3gHleusC2GBh0diU6uL6WWgQ8roVjjSOfogWfay8CSmFCjSH3eDPht
	LFIde2CmdE7DpXqXw+TfF+bOHzGccIgSPsLW6ki1ig9vkootv9LdY5SrZQgQKWMG
	FqHN29XW8gLCp6vk67K+lrX5OChgqpNh8SjqN8UuMRhyUAyVYruCN1xa8ndDmdsu
	DBqaHPy0Aum2TJBbt21CHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1732177767; x=1732264167; bh=b
	vT1TKYMtedkDbc94NEPgOX7+JuEjgjFZEjVoSnGAxI=; b=mnzwZeCcN1OMPtzk4
	bB1ZKfK4FpfmLdI8g9G4YPrLfa+PSYYwYnKCEX6JM5fU2cU2Xv/MwNjQdoF5juQx
	tm8SgXztOTctHCkMsAsH/17HaV/tDEnTnffF41McBW+euKJ1JYtiopmCYQMQOc/V
	pf0ilzuXOhIGFwdC/fdNKoZlX5pUl4+93EYz51SBdPrO4MhvKGcnHEi0KeGveZMI
	2jjeSi3lUFWwMoaL41TbPJpQaHVK9iE466k1B2UYxEqNb/h14rV6C9C4WQIq0/cI
	0noi331PvYe3q8J5R6SsYyV1H6F0hIDL1TbWoBzvdOLnTcbu0Bk9GJjzhh28Bca2
	g5MvQ==
X-ME-Sender: <xms:Z-8-Z0tlGoYZmV5St1sBtOmwXCcQzw6cHnUii8uwqv1y1mvjFT-0cHA>
    <xme:Z-8-ZxefWIMebMj0vW8V6zqK7IUUY4BfK3uiJ902J02L3gK_kH-sd7WxJIKeC-MgT
    YHmA2V5xOnil1dQgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeifeetgfehkeegieetudejgfev
    hedvveeileefieeitdettdfgudfhjeeigffgnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:Z-8-Z_y-Ph4Onj7GyQT8Yc0x3D4xvJ6Rz3ZgmGd4QkxuBxngDSZ4ZA>
    <xmx:Z-8-Z3MlgR2qgBozDSjB7gTHtNQL0zyLipfL_v1Jgit6_X67g-BdHw>
    <xmx:Z-8-Z08I6hP_TwwovvVjEmx03_4AeLuD4A5sRQYmoGoD-pOGMjxnew>
    <xmx:Z-8-Z_Uf12lIRLCsTBQPHegN9L1ffyqx1r8u3d4spXtKaIFk6BAt7A>
    <xmx:Z-8-ZylM3vVF06p9iJ4PSEUFA0lsocNrMZSg9ADd2aFV6q7umITDyhcj>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1801F780068; Thu, 21 Nov 2024 03:29:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 09:26:53 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <a340dfc9-bc3a-40d2-a8ec-fc47c00d1305@app.fastmail.com>
In-Reply-To: <xmqqo72ai929.fsf@gitster.g>
References: <xmqqo72ai929.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Nov 20, 2024, at 09:49, Junio C Hamano wrote:
> * kh/trailer-in-glossary (2024-11-18) 1 commit
>   (merged to 'next' on 2024-11-20 at fad433e2f4)
>  + Documentation/glossary: describe "trailer"
>
>  Doc updates.
>
>  Will merge to 'master'.
>  source:
> <ba35ba3ec212860a3151cfad582a384a50c55e6a.1731871683.git.code@khaugsba=
kk.name>

I=E2=80=99m just asking for future topics here, not that this needs to b=
e changed. This
topic went into `next` pretty fast. So I didn=E2=80=99t get around to se=
nding a new
version with Christian=E2=80=99s Ack.[1] I just let it sit there for tha=
t week in case
there was any more input. What should be done about what one might call a
trailer topic version for simple topics that might get included in `next=
` soon
after being proposed?

Thanks

=F0=9F=94=97 1: https://lore.kernel.org/git/CAP8UFD3p3ts_7kvk_Zm2efhcPUc=
EFnLcLFPAqzb40d46BTVzyA@mail.gmail.com/
