Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272AA37E2EA
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155200; cv=none; b=nRWqzzEPuSRVElRm8gInZFZXgO4r1/v9BrzMSVDQCKpOF3IaywbiVlcRt3oAldxb+c9LLeTIzAecrjau+n6IvekPB5qen2spXp0P3StOukmolknWhLeO40vImgPXwuvEuI7u9n35Stvubdg65366LOWzMCr2ubIraIxegcw1Hoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155200; c=relaxed/simple;
	bh=tPQwX0wogr2t46W2wyg0+d/9ulWsoTyO5UyrQ2qGkAc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XmvLzDbX47n7HZRHERw/zy2r6zE2N9Xbu61lIq4gYloQTq44O9Jb0vJP0ZVt2QR0Rshzox/HH4WzNK250VBV3cKc8Wg3r5d48lUHZ0AJ443AgB2hINEv/7DvO//b8ngnY+Rc3+kkSaT2dYvA9ghfL5MDNd/dWcMPCdKjMmmRTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ElpkCQOy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v8JcAv9I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ElpkCQOy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v8JcAv9I"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 583871D000A4;
	Tue,  3 Feb 2026 16:46:38 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 16:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770155198;
	 x=1770241598; bh=Demvq7mUMGXXdHF9z+BLlmpIAS2DUQqcrSIuRz8/OrA=; b=
	ElpkCQOytBkwOysDOeaZquSO0dRM/cKtOmd+7kaFe0hCEeteFads63r3jtylc0nS
	LDK6UL4EA3d91hZhRTf6a5CY1BE5GZwB1YvoeYkkdWFdQINF2AfpLOtGKQgHu3We
	yfzU4h8ACeHzMrI0PbhtO3z/HJDR+pL8M/PlupsC6Dxs3ONv6Te6z6tKLm4vbGvZ
	cXE9Dk8KuOzIXT5sclJ1XmmwiQUQtkLWCYZGEc+Wm+KCkpVoqV/PRiMGhZTfZmdR
	grNm9/8hrnGVkr1ExdrWWyhIuIlJ0CZYzkIRS9ag/iCdBouKBO6GNJaJf7OP+YtN
	2N2/RiLNSX3ZTSjvjB4H4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770155198; x=
	1770241598; bh=Demvq7mUMGXXdHF9z+BLlmpIAS2DUQqcrSIuRz8/OrA=; b=v
	8JcAv9I9pxjpmeuzPLPc3m7PcpTt4dE+9298d4PjA31n7VG1ISkBIYHPVdxPQsBa
	jCnDolAsJHJqfdmF2Emte9f5VMi/5nXF1tH0cOoYwCGfF22XaDyYwYMYYwmVx9Fl
	1zKcfSzxnJpvaPrWsiPBf0jtrGI0WfhAKzj8TCNDZOjR8MXyscuAJuIgJS7IIMxX
	TQXJZDvL/6T+/LHeJPlZvmMlP4MNv4CO54xZ5G5WdDwp/Yij+AI8BEHUKELslVZb
	nBTs13vrt2NgoQ8zLGtv7tAvq54w+ybTx82hJ1VzsjUPw0AzA5jOasn+8bymXY9c
	OPGjUnGNvml+Bcgssdz2A==
X-ME-Sender: <xms:vmyCaa4iBgagZmEgC0bw9XqXwkS-_rLBPsRIzJ3eBdDE3NLOnhL39bI>
    <xme:vmyCaevru8skerZ294N2BZajjL6AZptGM00b3HT58WYr_yaXknuX6vYM8Fd8vT0eN
    ulI-Sl5rWgC1LQlWBftBuKVhSPI9nrsnKMrjaAecQ4pLobGkZkAWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepleejjeefuddv
    hffhueffveffffdvgeffteettefhleehveduudfffeevkeefheetnecuffhomhgrihhnpe
    gtohhnfhdrihhnpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vmyCaRV2eyMSXyGSaOww4iWXcwGB7QaWHKG28fty0JPyCnlNSDImDA>
    <xmx:vmyCaZWozgGIg2K4X4Rb4bIrJnOpjIpVUEUs97cwOYhDbrqqJ2zcVg>
    <xmx:vmyCaQchMXpWX4DDRq32w1SEpGx41mnBMtG9XtrEtn2PBUaok6rjYA>
    <xmx:vmyCaSXbnLmASAg2hQmLxeGmYeO-77_crDdZPEvhXDT2mUG3FkhZHw>
    <xmx:vmyCacwbkyKnatXJAzO_tMLjlPgDIelWRn_eO40Wlr0DiLOyhZyxK4Kh>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 17F441EA006B; Tue,  3 Feb 2026 16:46:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AC2L5HFm1BQs
Date: Tue, 03 Feb 2026 22:44:50 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <ed120bce-384d-4c2a-b334-024acd2dd5f8@app.fastmail.com>
In-Reply-To: 
 <d179137d8122d152d96c7f5cd91255093c535821.1770138215.git.gitgitgadget@gmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
 <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
 <d179137d8122d152d96c7f5cd91255093c535821.1770138215.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 4/4] doc: convert git-show to synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 18:03, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
>  * add synopsis block definition in asciidoc.conf.in
>  * convert commands to synopsis style
>  * use _<placeholder>_ for arguments
>  * minor formatting fixes

For others: my comments were addressed here:

https://lore.kernel.org/git/pull.2036.git.1769202903.gitgitgadget@gmail.=
com/T/#m6011e94cd382640ec2cd21ab138d36956bb4c024

So I=E2=80=99m happy with version.

>[snip]
