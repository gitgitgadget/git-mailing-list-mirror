Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39818755C
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729332438; cv=none; b=TYopSawmWynACVyrARVyoUxTNV7jr8GaNyWBS70aHw8pN2g5kwfJdz7xv7N4Y3aJ9oJh2F2QGacLsOGH2EoBonJDIyjoFZYxI8a/V6PprsEqrF5h1MTzuKu/tne7/ADv+Y4r+9Iw7QMtIWyWANaYXoSzjbPuTN3ZvCtE6SUW+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729332438; c=relaxed/simple;
	bh=DrKhb3MMPr7HtXPLSbAFxbNdZcjESevxEDLWCWFLe9o=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PHffjtKuqt6KQk7Mz3NgrmbyK4ye8xeTRbk4JTIqDPYxX/w1NcKm62As8Wt7ZTzIJ14+gw+jrKtunU8EI2rcWuzBLpIcirC0RMNlSFuFMZR+x1Zt320pQkE9wYkVJ27+SSbrcHkbQqdESQvrrdK7f739BrymXjAy0MEHoKOIkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=n4rzLWv9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4gGFwQv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="n4rzLWv9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G4gGFwQv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C19831380192;
	Sat, 19 Oct 2024 06:07:14 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 19 Oct 2024 06:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729332434;
	 x=1729418834; bh=uOsOtw17TZdTbGfRYL12fNhxQsjIBmx53H89LtPtc9M=; b=
	n4rzLWv9EI5PJCVPW82KKgxuHX6SkmpTxAilnUiIzFHJY22CIeuxqrLv+vMSsNGj
	DWj1cETHtxHAq8jsjsm7AX6txN/JdI6Vnp+yANP8SvhUVaicfu0YQYVBzrsjLSMQ
	DMGHSQpZzGpS+OhTeIFXx0Vh6n7drJDiAzX6Yj78tUTCHqBNnGx2NZiTay9RMLpC
	3DELIuwRT69DusJdFGDPBKifICy2IMZyEEcYUob3c438329KBqNCQtzklayIFdG4
	aaQ/ALg1vrh57jPolXzC/MpzJuPtqRApE742z9zAnSmdLThCZUWDxyo5RE2eKaCt
	fnjYfw+GDgW9mCgAnbmphQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729332434; x=
	1729418834; bh=uOsOtw17TZdTbGfRYL12fNhxQsjIBmx53H89LtPtc9M=; b=G
	4gGFwQvrSo0cNR2UkLXwr5OuFUv2R4g40jnBJYfVtor2+LjdvsNT/xtnTy+fsnOY
	7i45NTKOtT/fO4KDYIo6U96LABpREyv1t9RN9lcpbCo6vqSU6a/Skutx5PVXgmE1
	LlBCNNITUOney/3ueJrykAE2JlRkbjUIduAGwDfaovAV2C4qoeFoAl8XELhaIXh+
	Oi7Pb+okI2y7NjQhb6rTbjrxjp3xY/Z91IHKj6eh1IdnFjiP368J8szFefMrYwFe
	71bBOW5ENCaLSTNJnKXrcUPFGPVG72k0GPWcjIliYMI0LvtDFysdfAdfJKlMvB5w
	FNn79h4cfsVUIWG7uV9Qg==
X-ME-Sender: <xms:0oQTZ23_o9tHhzq-Ibp3ORrjlwBokSXHdv6VpZlnqLZjD4kCjGrakqE>
    <xme:0oQTZ5HLwSK4BdMuG0-i1xZ2wLvGScpKxCJ5jTVl1bXAh6Y76CDJNQ4ETPfXF9AQm
    jac9_MX1tdAikqB9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeifeetgfehkeegieetudejgfev
    hedvveeileefieeitdettdfgudfhjeeigffgnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghmrghilhes
    tghsqdifrghrvgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:0oQTZ-5KdEjRYa6By2yRhpIasEtMC6VM5I4victoXYR_cf6Dyl3R_g>
    <xmx:0oQTZ30nIRG_HTNwW4ScblYBxokcN5pxIYK3e2C6tHaNQ4IfMsE6IQ>
    <xmx:0oQTZ5HiFx4sL8L-HBWBioIH_LI_WXm3ejEB-b7TsbvTC7JcgiZB3g>
    <xmx:0oQTZw9aTGI275JG9mhqRTbLPNwQD2Ac35PK_ocVvNbPPIWnbtP_ew>
    <xmx:0oQTZ3PFNEDdMhmPm5_q5yNnzonsbEmfZgKzfTHypERrEiARZ-gT-2W5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88247780068; Sat, 19 Oct 2024 06:07:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Oct 2024 12:06:54 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Sven Strickroth" <email@cs-ware.de>, git@vger.kernel.org
Message-Id: <e1ee980d-d8d2-4c9c-9a73-ba6af9009ba2@app.fastmail.com>
In-Reply-To: <b50f9706-bb45-4bf0-8d32-59149615301b@mrtux-pc.local>
References: <b50f9706-bb45-4bf0-8d32-59149615301b@mrtux-pc.local>
Subject: Re: [PATCH] Fix duplicate word typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

I guess it was an intentional choice to not use an =E2=80=9Carea=E2=80=9D=
 in the commit
message?

I found this similar patch which used `*` as the area: abcb66c614c (*:
fix typos which duplicate a word, 2021-06-11); review here:

https://lore.kernel.org/git/CAPig+cTjjNrU9q8UPm+CRuTKq8_XNc+1z7-3F4bvetB=
i+NjKeQ@mail.gmail.com/

On Sat, Oct 19, 2024, at 12:37, Sven Strickroth wrote:
> Used regex to find these typos: "(?<!struct )(?<=3D\s)([a-z]{1,}) \1(?=
=3D\s)"

This would be more conventional:

    Used regex to find these typos:

        (?<!struct )(?<=3D\s)([a-z]{1,}) \1(?=3D\s)

Either that or code fence (MarkDown style).

>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>

I can confirm that this patch only does that.  Except:

> ---
> [=E2=80=A6]
> -Suppose that that central repository has this history:
> +Suppose that the central repository has this history:

Here the doubled =E2=80=9Cthat=E2=80=9D is replaced with =E2=80=9Cthe=E2=
=80=9D which makes the sentence
correct.  Good.

There are also no grammatically correct =E2=80=9Cthat that=E2=80=9D cons=
tructs that have
been removed.

> Documentation/RelNotes/2.45.0.txt

I was wondering if typo fixes are done for released-released versions
(not going through RC).  But the aforementioned patch abcb66c614c does
fix a release note or two for some old versions.

--=20
Kristoffer Haugsbakk

