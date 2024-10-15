Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134EA1F80A0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019332; cv=none; b=Iny+Yzr0ES7jid/ORr2gSAeqttREspsuf71ZZLAsI3L0ePwLLV4l0heien8IP8223d57+BU8FfakRPpnowGEM+1SaDThtUhuB+gS7MFOLGftmTP6czmCufJmP/31BqTEqLpA27g+kHDH4wxqEop9htaMwFtRjqEBWMAsTICQLQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019332; c=relaxed/simple;
	bh=kYrzdaFsaKraBtkcUL52lpexCpndwi2F/gp65tp4HSM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o5UwvhVpPAnK8leRNChmCw3zrCj6u7sM6q1Z5Mx6/CPmHgJGOxBzHZh43s4S6IuQih5ZrkTDqXyumLigaSyZU9eRKnBpRY5R4H+bRJX4lSA6o9fdIHo0DTf+PfDc8keb+tFzpNCx4/hG+pkZwfZ6EHhrzaJCxA3A8zLA0wObU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pIfrbnC7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pbe7bjha; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pIfrbnC7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pbe7bjha"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DAB01140170;
	Tue, 15 Oct 2024 15:08:50 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 15 Oct 2024 15:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729019330;
	 x=1729105730; bh=PRHASYdB/hc6saiYCuCE5o+EBzjl1JP6lrdBqd+jfUI=; b=
	pIfrbnC7NdbWGa5lbm42qO2zvodbUDbOjx8sbnDvkXRgVJSY2377kGFDTkk4AP8s
	QSYKAo4ALHHPdFemR8jwdmmPNs+s1lttAZpIFqtIv1Qw54T7pirR/fwvRCkeZerl
	CQO2fWrSxZqN/9LnCj83Hij674MgrEK9bgbXFhQSSEr7nBOfPOTqMudCHMYb8jHl
	MSTGpQo2+yYYwxJG9m224L3PeWFpiLhTaSXhzbSrhQ1D5veoosYvTiA80hBnAZpN
	o1Aq/tc5Bz15v+DB2BauxNLjGZzP4bB/ECvf4lW2yu57uN71mrO5EnPHI1zjvJeZ
	HzjJMSUZkdpGV2cOYEuGIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729019330; x=
	1729105730; bh=PRHASYdB/hc6saiYCuCE5o+EBzjl1JP6lrdBqd+jfUI=; b=P
	be7bjhauNFax644iRKj+b76eqfo8RzY9HHxX+fwLp7beLcTVrAvqcdhKosu0TAUG
	pdGX+qF44PEZVx0eHROKO8cOrNAU1xUxiXV13TrSIfLXI6Xr6o8rJrwSIHOVEByj
	XMeMpCYbviCjcHZXvPPZb/nItLI3QSeUjyFxvgYePSrTUKL0hdxIF9v8KkA9245g
	QwQuyKHU9z+rk2XwlLtpIAHeTeFjEkvdKpfOKzTOVJpQ8YN2iClwiHJE3UJMU1v1
	0AIWWysbXNxteov9HEDC2zrORUZiNzZUX72AK9CwyfvUwE3qctkAgR0bAxqqjrZY
	/jMezRL2g3PC2nnTM89Dg==
X-ME-Sender: <xms:wb0OZ9VKSVIc8tfQSE056ZTvaG77w-jShqfyX7F2xSOPHtl1I1lmOPw>
    <xme:wb0OZ9lWwtx184v4KCS-4tuhRMyWFPN1Fp1usTe3xTLFOT1zYTY0PNPP724O2mpCS
    mmDFGXLgcj-QTBrbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wb0OZ5ZIMs5cfVCsLCYA4YBYVp5lcZv2V1whHIAO80XZFFswRkXNhg>
    <xmx:wb0OZwUYyztSRklZIDasf-f-U-afygHkcTyI4uzFo8CUvcwpzs9Zyg>
    <xmx:wb0OZ3l87aOfCkEXGKZk4gRcu8dwvC5pUKbT0RnQGm30T1Gz4kDgCw>
    <xmx:wb0OZ9dRZViVHsfkOEOaZejL1H8Y7dccH1QY8QEKwiyvzhAvFYwjcQ>
    <xmx:wr0OZysaE8h1Oa_D1ljs1YLbEQ0Olp1-tL3qDnxHso2u98UQ824lCW9V>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C653E780068; Tue, 15 Oct 2024 15:08:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 21:08:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Bence Ferdinandy" <bence@ferdinandy.com>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <8e644cf2-f903-4089-960c-2fe7eff30834@app.fastmail.com>
In-Reply-To: 
 <3575fb48c932f50b2a3f6fb0e582b3c2a9b087af.1729017728.git.code@khaugsbakk.name>
References: 
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <3575fb48c932f50b2a3f6fb0e582b3c2a9b087af.1729017728.git.code@khaugsbakk.name>
Subject: Re: [PATCH 5/6] doc: update-ref: discuss symbolic links
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024, at 21:03, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Tsk. Subject should have been =E2=80=9Cdiscuss symbolic refs=E2=80=9D.

--=20
  Kristoffer Haugsbakk
  kristofferhaugsbakk@fastmail.com

