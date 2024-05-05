Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE15374CB
	for <git@vger.kernel.org>; Sun,  5 May 2024 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714951254; cv=none; b=FmUtOwhBroCGYu/GpUM7JK4RveEMNGzYfSFKaVbA2OUl//iI9hC+MkCh2ihYQpLqYSP3LhlL6OAuQhsnzHlTw53Ju4ctTTxoQsE875ClTxq6YXvw6ot9dNMiH4hI01nXBcRs69uZhYNlj+pkzWWwta1Dq9pBFsQxASYiJw3V2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714951254; c=relaxed/simple;
	bh=SZ2N6SsblJaBtizxXkQ2uOyw1J4Yz9UiIxip1ylMe4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=eAZhu5FNy3ioQlmm17wLSgx8WKpXNenOjbIG2/p7zK+NFoeeNYTt5srWJ//IjzcP8rN9wIvvImX9snmQVyktTTujH/s31O4h673z/BTJdW9e4WRmkr9wbEu0H5S453+EOKt/twobbWIAPXafWgaFnTYprkNxch+ilKUqy5oGSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=cdrkQlXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvF7h6jC; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="cdrkQlXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvF7h6jC"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id E11631C00122;
	Sun,  5 May 2024 19:20:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 05 May 2024 19:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1714951251;
	 x=1715037651; bh=6BrVrQOzxfk966cL6Vx68TgMoWXEKhAL9lwDf18kcq4=; b=
	cdrkQlXB/eNWxgq7tsvLo283z16+mXaxy+TyAe4Cy4rdxKv6pNM0AarstilCbKFm
	ELI6DzF0T1DnBuLfVMD27TB0MukqFOwqRLvstAxBvr9lF2BDrKW1GC4Otncuyo9p
	HTLumsJFqk6oj/cWs4VImQDu8DksR73ipawzxdgX9VAFOzmhaNUWLEg2T46fwS/t
	Od/K0Bg80H8OGZFEZcYyur610LOLd+lWOZZFs3WsiCxig73F6PezPAavC9lWxF3H
	5/NwsZnwA5dS0U0b6+Vu1axCwbaugKu+3vaOW9P4LB0Bun+0+4UrGOahkq6aGgUS
	zNam7rVPxeSAVrBe1NlKTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714951251; x=
	1715037651; bh=6BrVrQOzxfk966cL6Vx68TgMoWXEKhAL9lwDf18kcq4=; b=V
	vF7h6jCOEgoZ9MHvmYxrjrnaU+qAmT0gU6A4ZykImtmiRlfrpusd9ELIPvynqPlX
	DoD/11W1BOIw1QJornWQyqvkjI0D7yDTZnOjU6hOCmfrnZZ+1rKewnYVZN0pE2dT
	cXbrIxHlgejBtlpjHc6e8FmCvpXRBP0H7w6BPnDK/4OXeCSMg1FcNQ8fa+g4ehI7
	lSCD84sCzvmTcbD0tyftSap2KUbHgcLBuMo52HOp6LZrqBq32m3JPgNwi+Ex22/a
	HejZvGmwKH20raQOQb133lxqXb2YuWUUS2sR0sWtAzoIcIM8GAxu9Lj3V8gefzlA
	giJrw5F9eST8nMs36+JFw==
X-ME-Sender: <xms:UxQ4ZuAHVnz_ReY_T2cOjUYNwa9R3icRPOyt4WD09gD6r2zNjI-eUA>
    <xme:UxQ4Zoi2Kgb2w4TJMK6lw8ZzBqu4dguipOLpa7dP5bxyPXzbJ9WeqaIunaV5FWmFu
    j2_s9SMUejvwWmPfw>
X-ME-Received: <xmr:UxQ4ZhlA7iz2RzHIvrbJy_7xUQd2fnLGNynOrekBnmlhh_kQu5JXXRENg1g4nVPsknFvgszrVgr-eOABOyPCtRqHIZQLBcrKnSRh1lYH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegggfgtfffkuffhvfevofhfjgesth
    hqredtredtjeenucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghm
    vghslhhiuhdrihhoqeenucggtffrrghtthgvrhhnpeeitdefuefhueefheekhfduveejff
    fffeehgeffgfejtefftdekhefhhedtheefvdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:UxQ4Zsws9zhewuLkFfmONMR6FS9ED0AzJL5YxtYrypnOJc5785XERQ>
    <xmx:UxQ4ZjQf0cOhiGisVVB8yoAWF4MyQhLApG3lFKaoG5eRFq_PaFaTTQ>
    <xmx:UxQ4Znad6Z63jy-GFgmigWenC0BTUloRR1ad88wTcf6GNPqW7l0yKA>
    <xmx:UxQ4ZsSgVXxSt0lAEojS9PC0TxYUA2Qx7VFq1Z8AdVuNi_X2cTfHiQ>
    <xmx:UxQ4ZudepauN0RepCKLDs-oUOyZ_1dOex55OGeIkJ1lyyXxEFtcZi7Hh>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 May 2024 19:20:50 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 May 2024 09:20:48 +1000
Message-Id: <D123HB68ZKO0.3C5RSYGQNO9L3@jamesliu.io>
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
From: "James Liu" <james@jamesliu.io>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io> <xmqqedai959z.fsf@gitster.g>
In-Reply-To: <xmqqedai959z.fsf@gitster.g>

On Sat May 4, 2024 at 3:25 AM AEST, Junio C Hamano wrote:
> > Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hin=
ts
>
> Huh?  Do we have "all" option that disable everything?

Oops, I think I mistakenly copied the subject from the original cover
letter. I don't suppose this warrants a v5, does it?

Cheers,
James
