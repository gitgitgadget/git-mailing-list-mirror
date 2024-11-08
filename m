Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6C1C1F18
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103699; cv=none; b=HR5JIhJ7TYh/m0HVevhNCUhzYwfL1IrDy9/qI0th9QWFk0MaH9n5HotTJGJeOvsHKxxDfNfXNRBf1z4j6Ye0TxfZ9SaqDUe4JShu6w0cnKUidrxUoU5sj9tofOL5sC+3CIUM3V6yb4zZeU1N2GkIM6xqLvnZx/kuFZLG9+9qrhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103699; c=relaxed/simple;
	bh=/N15nSmgXZQKZXr210+672N9CiK3rbMHuP+CQ0Gn2to=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BSBo07fpMeTR/ZgBci/Vi3Rzu6csJhe6eHRj5NCXsHt71nlMPTahIu7ZyFMDpPLZ25/YJuCtdXpFtKBeR9D7FZ2FWGTinQ0Dnqxh9huuAcipHEYZe6XK3YetDLYWP0brc/d9yEjf4prJZIIoMe/whi93+CSMNHK1OQQY1neBE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iBUWurMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SskbLYk3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iBUWurMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SskbLYk3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8EEF25400FF;
	Fri,  8 Nov 2024 17:08:15 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 08 Nov 2024 17:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731103695;
	 x=1731190095; bh=0PJFzn498V3qwaKUyzXUZzz8HGJvDlXtZtPDBZSOJN0=; b=
	iBUWurMsY5CG3BhpzMtn+BSQNb4vv/fm9eIwOTBqjt8Zq6cik04Ktmm8MTKiTk73
	bEiiY9STJEXlNE9iflVc147k8KbmNAYcSJ+60yLDDZ66I2M6E8My5z+ghr0M/xuM
	IpX6P1sx4sGenRKYN3b5hsYkRsNT50iGtxVsuhM22a6yn3Ybzcajq6YqnDZl3ieO
	cL26Ads0bck4ipVY4hs+am3urdrC3U7ZsDBlVQG3Yc9ebGLyR3aQouG2wGHZ2ccG
	DgwdoiFjgrKvQUIfd08YMW+C9ldo4S/Wb5QrQ4ealNGJQXOh87VbEFrDalHqzCHU
	s9dxgRCX/xEDRPkfJY5cgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731103695; x=1731190095; bh=0
	PJFzn498V3qwaKUyzXUZzz8HGJvDlXtZtPDBZSOJN0=; b=SskbLYk3rknZq3XyA
	CAXI/K5ja9N466MkYiRILEyY8ngSwoUgcGOffzXWPi50LedBIZJyXb2iIYboyC5f
	bVba4ixI/D27cQjJUiK/Z7MkdkrvLSfrm74U1y9ydJQNh2oqzQvG+35RkO9RkxrM
	J00g8PJ6p9ZjfsWm3GxA1LkHM1dGdBOKaYcVES9vkSKjWOvwNxOHVl5TDLosEi0T
	EDAE/Ly1YM80Ovgu22xOHd9wdQ/CwAKdY/zLw9CMsA2NZAzJ27zaiSNSTcfHVN13
	08u44ecxA7FNgz/rrsqpT3rwBMYKgiI0t1MhSGcfee1OB96rQFEFijgakw5xX+nb
	oUj3A==
X-ME-Sender: <xms:z4suZ7_3nM_GQ9xCVMfL4-57jwR8bo60tNi2J3c2-7cTosK4QYNnLNo>
    <xme:z4suZ3sydbqgMt9n-V2Ktk1s6z5YWImEa-NHER4Qn-TD8vYHaYDK5Qm_KslEucKGf
    ePONFB2pmt9-9PtNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludev
    heetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegtrggthhgvrdhskhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z4suZ5BYBdpKhJ3mNO9rNr9au7tqQnuMVbePS3PlMRbrU5L1OgEugw>
    <xmx:z4suZ3eBe2tocmAFchXCUOv1Gan5ZwrHSLyXL0Z1JHpHgBuBOZRsGA>
    <xmx:z4suZwPO3oF4CUod3eql4YmAtPj-d6lC9JVQ91t2Gc3DEvz2aHXtiA>
    <xmx:z4suZ5kFn37peC2KJGAnv1RPtbhFrW1xGN9J_bkxniKJtgwOvvWMRQ>
    <xmx:z4suZ62k3kpjzncnDWzv2F0UEcHHGyecrK6ZMQ9QIQraxdntIXXEM1lv>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 85DD178006B; Fri,  8 Nov 2024 17:08:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 08 Nov 2024 23:07:55 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Peter Kassak" <cache.sk@gmail.com>, git@vger.kernel.org
Message-Id: <bc028fc5-c0e3-4d31-9790-86bdd3911cc5@app.fastmail.com>
In-Reply-To: 
 <CADYnh+Fudpy9kfg8npUMutMjzYNDy-XxJCCJ_9O4kLoB807_3Q@mail.gmail.com>
References: 
 <CADYnh+Fudpy9kfg8npUMutMjzYNDy-XxJCCJ_9O4kLoB807_3Q@mail.gmail.com>
Subject: Re: Extremely long subtree split duration
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 8, 2024, at 22:40, Peter Kassak wrote:
> Main difference (except OS) is git version. On Ubuntu is latest
> installed via apt 2.43.0, on Windows is 2.47.0.windows.2.

I tried a bit on Ubuntu 22.04, Git 2.47.0.  I gave it 14 minutes and then
it was apparently about 10000/32714 done.

-- 
Kristoffer Haugsbakk
