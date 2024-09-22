Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754166CDCC
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727039363; cv=none; b=M4cJB5x1f2y08I8HA4kUMWHdaWtNI9qVYfBnMP4AYEKJiUu2k64MSZapaFrkidZUlBZSk+G51B3ZDJnwb7u12jwfVWeAEWMff/t4AU4B182OvZNKzflzrujGDDHELBBKWcLpEJ0aiQX/B1WHTL6rzmBK4Xxcp1elKWmAmpQ0+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727039363; c=relaxed/simple;
	bh=cqlMg3lNExAeY24Gh3fVaw0GrCuUuB3ex3SN37l33Oc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u4xcC6/K4VBVLCTUT7j16YpqUwRuPi2dzgcu02tml2ecTgaKuSNqqFce56Aj2noKaW17mRVOSMihzjEIYoQZY8Yk7i+Ms0t+bUr/oGtIMK4fjsOf6D6KWPbjSvnYB4r7C64f2HMBs1mf/QQwpy6BmPRVO4p0aY9Z13/WWpJOnxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SbAO+ZJe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bqpj1sRR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SbAO+ZJe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bqpj1sRR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9053013801AC;
	Sun, 22 Sep 2024 17:09:20 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 22 Sep 2024 17:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727039360;
	 x=1727125760; bh=cqlMg3lNExAeY24Gh3fVaw0GrCuUuB3ex3SN37l33Oc=; b=
	SbAO+ZJemH1bkgNhh9yc/Ej00S625Lx7hnNam++YS+8b2kzaQPzexgKsBNsn/E+b
	jZ8DkHxiS+q9EaUygyVHCO+pgkPWRr2FLX2GQ+NyG4sdMmRW4G+TnutNs/BpdFg7
	XpoROYgdidKx/uKg0MU4vYLzQmuGZ97jQS05TRdwL6GFzh3nqofIpGhs6uJB5AoD
	kO1lHlOh7LUTdLdiFspyhyzjBgOj7bTDlzFtXnLKIkLIVcCmwGCZ+uJ6ON0w8G1b
	DKLg/FKe2vy9H967xsFXJyHE5ZO9Z5ZpXx+/s85uV3zGj0wDGwlpy84CwKuNNP/m
	YBkt7asvwZfTPz21MJaAbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727039360; x=
	1727125760; bh=cqlMg3lNExAeY24Gh3fVaw0GrCuUuB3ex3SN37l33Oc=; b=B
	qpj1sRRwzcyUFhzHyNV99+63MLNjwuCLxKmQGcWTYRPKiKvlWODo/mRqeyC6aCwl
	fxzd5rn5vyCG83Ry/ZxLZ8jBB+cE8pBZKaQMCnr/4wkql9uUCNTA7T4EkDltK3lu
	KYYpfb4ktRGrhfphRg9zLiD5S/3wfatgFhSNxBXKJwGEkm5pWSf5uoztnKpVbRly
	hXDEftWBDiHqcJbEidENxkK43eicyQJPALPVsikQDhGEiuGkIeXYolG4/I9QwBIH
	JGkRK7/CqItrbgBzHNuNe9OafAoHLAlY0EpBBkWpE56ESQz9S2kYu+IJkjQVhrST
	YN6MRpRAw+VyYkPOHbqrQ==
X-ME-Sender: <xms:gIfwZsq2jYIkkjr-Lc1ELg5KwaZb9HRbGhfvHeOJNTKCEfjsJ3j5aQA>
    <xme:gIfwZipsvt7KONXQOV7C0DFUKEDJ5ibFVRvASB5WsKxffpB-5Hyt5goG26roUQF1m
    yZAo9Q-R1oqbI0HTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeljedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghike
    eisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhm
X-ME-Proxy: <xmx:gIfwZhMiWgYdIdHsjNKcNCQPIlwcebmDRiCv3DfutW1oDMsNFn_csg>
    <xmx:gIfwZj4AZddKdHVPk02iAFAWCM9MynfLve2mW8Zm1Y_WNZ5HjFIKKQ>
    <xmx:gIfwZr6SpK0YOQ12hbqkDM5y1-b_62Kg62H3fljcxMKLfCQhDAtYSg>
    <xmx:gIfwZjjL91YQo2votuzATNNszmNTsMnQYhQ7K2Nalsuj8eflzmRmyw>
    <xmx:gIfwZoGs0vPaE5p3b70X_3ctr_ZRZDeRGlHnnNJ-z6vOMcBVkjBLtW-b>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EFA37780067; Sun, 22 Sep 2024 17:09:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 22 Sep 2024 23:08:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>,
 "Jeff King" <peff@peff.net>, "Patrick Steinhardt" <ps@pks.im>,
 "Taylor Blau" <me@ttaylorr.com>, "John Cai" <johncai86@gmail.com>,
 "Elijah Newren" <newren@gmail.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <81bc5d69-cf50-409d-ac64-5b9b3f722ace@app.fastmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
Subject: Re: [PATCH 00/30] [RFC] Path-walk API and applications
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024, at 04:28, Derrick Stolee via GitGitGadget wrote:
> This RFC is ultimately about introducing a new way to walk objects, ca=
lled
> the "path-walk API" in the new path-walk.[ch] files. Before digging in=
to the
> details of the API, let's discuss the applications which will hint at =
the
> API's design.

This series is superbly well-presented. I=E2=80=99m in=20
awe here from the peanut gallery.

--=20
Kristoffer Haugsbakk

