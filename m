Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73414883F
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960812; cv=none; b=PUXov9Y3gVAqS5kmz1QisG6sOly3rXiPBvurD1IZqX9vG8wRxSt5yPA+BzL7VEfQBFNITPoxXcGDw3HpIlow4gVvs97tlX+g6w30/l0fIXGsizNeyns5b30kUacLvNj2WYLg1IRXt6rtMUQt6wICvgcbbqixPp2bNEptIzf0VC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960812; c=relaxed/simple;
	bh=HRJOWfAGbk6C1ogHNwhOvel7bD4f05mZ3eP82e6Rm0A=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XifEeVHg9JM9ned8JEV2NdX1THYdJv8DGWm8vOs10HaGSZkv3paL34635dLn9evICAkacen3j/8QWYd+ZukEA8ekZP2zCscPPPWiC/UmVGNZwmLsTJdF5gzNDZ4p/BPdLfptaUYXfZLlMy1oePElufPh56BcSRaGqpuqA45JEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lFAvo11S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ml/VJ4pf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lFAvo11S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ml/VJ4pf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BF0FF1380662;
	Sat, 30 Nov 2024 05:00:08 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 30 Nov 2024 05:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732960808;
	 x=1733047208; bh=HRJOWfAGbk6C1ogHNwhOvel7bD4f05mZ3eP82e6Rm0A=; b=
	lFAvo11SqcATRiILQ/lbY28VZzoSDaVOlJPwQo8vcbCPiuBCKnKJRQbtjM+LofEJ
	RLCMx45WF8ToizltnKyrHIBNdBU+TNpClCW6tRo5RK3GyhiPZ2XY41RbrAiGNjDk
	H31B5aS24D775wqWM1762PqiRufGRwmFZLi7EowFsmM1t+yNH+9ZvJD/E0wlxIsx
	xbkZcRrxgywzMGB3Z/Jo+Dvtmt54jWw/1QotjZK1mCGedRALpKtJH5GmjZvluV59
	kNVMhWHs7MB1fR/JV6OBiG2DjyserF1DGO1usFAov5if3tUuTmHGVqKH/cWBj30F
	yhEGaqnL84JRf1YJax74Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1732960808; x=1733047208; bh=H
	RJOWfAGbk6C1ogHNwhOvel7bD4f05mZ3eP82e6Rm0A=; b=Ml/VJ4pfA2FR8A1C0
	wpzmzxRjfG3f9ovHXjNS1k0mBFPutR5PwxT0/MSrHeLTVsSXwC08w58RwldMQyaU
	KH1BOf1nEdFd9rPTcXh4LjoYWdRKLSUBgHLEWHhX3S4yv4szS5OJG97pcy43P0rk
	G/nSYdkANP/PorggNXY+Jrnwx0LtxO7QSt+MXRsCkkoRho33jILim/AFgj1pBP7K
	l+IL7MjbXSVubkAfOh+KZ9CHqy8EbDw+09XXRiBFGOIcL/ggWj0NTlux3shJlH+z
	xrnD+AIYq1Y8roWzuCwqK/LbtpmD8J3psY4CUfY7CI6np/9DdVJMQsM4QA54pyxx
	/TR0Q==
X-ME-Sender: <xms:KOJKZ-R4cxRglpKmgU7cZgfn57CjZI17K-492k9UqJ3keyGbJL5yNwU>
    <xme:KOJKZzxt7eW7fO8plaq9mVw1b33WctYhA-dPW0yq1MBMPKvpaen1FcLwD3KCNczj0
    M4-Kf7A9stm5rSahg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    fkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeef
    jeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepnhdrohhjvgdrsggrrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KOJKZ73C6-iZLprl6eY62tb_DKcAERa7tPwHDZmrUup5CTnpOQrypQ>
    <xmx:KOJKZ6Akd67PzQAdHCtqBd7FgTb5fzCpB5imv7_FcvKpZrNcG6zpxw>
    <xmx:KOJKZ3gcZhPGidxa30o7p0IPn1w7GmUS7MU9_ntMYmEJm0eT31vRbQ>
    <xmx:KOJKZ2qLlM_Fp3Wrq1GGYMJOoaPIGjad6qLdgUG4A04EAFmTQIZj4A>
    <xmx:KOJKZ_YjkkOUVSLezxzvk8QsC_og5KJFHfa1afElW-59gjqpdGCuUhj2>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7D4E6780068; Sat, 30 Nov 2024 05:00:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 30 Nov 2024 10:59:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Nicol=C3=A1s_Ojeda_B=C3=A4r?= <n.oje.bar@gmail.com>,
 git@vger.kernel.org
Message-Id: <1e423f15-49e7-4f18-b6a7-612f1bdd7d5a@app.fastmail.com>
In-Reply-To: 
 <CAPunWhBQcAifapqxyq7nY+S5WWhZQhBKgeYLL56U1ewRCa7QDA@mail.gmail.com>
References: 
 <CAPunWhBQcAifapqxyq7nY+S5WWhZQhBKgeYLL56U1ewRCa7QDA@mail.gmail.com>
Subject: Re: [BUG] Changing remote URL of "deinited" submodule not taken into account
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nicol=C3=A1s

On Sat, Nov 30, 2024, at 08:48, Nicol=C3=A1s Ojeda B=C3=A4r wrote:
> Recently I came across an issue involving Git submodules which seems
> like a bug to me.
>
> In short (precise reproduction instructions below), if one updates the
> remote URL of a submodule while it is "deinited", the next time one
> calls "git update" the old URL will be used instead of the new one.

What=E2=80=99s your Git version? You can run `git bugreport` to let Git =
record a file
about your Git and system information. Then you can post it inline here.
