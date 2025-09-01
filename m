Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45C25A322
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709961; cv=none; b=IiCOsNNpMhu9vf/TiqjN7z8XMWFWno233HiaqCnVFoLvW0S7D8aLPUSbjqc+GvCUytVDT9h4WN+VH+k9bUJbj0ntE3ljfJsF7EZ4Wv7rboA5iNhutWq2qBmAbHf+eHBLMYJfDbs/Pyye42NtnTpJZSldOlDLJtCp0G9ifZoI1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709961; c=relaxed/simple;
	bh=0kFvnj/XJ7I5vLZyirZW0cFWsG4TO8Uq5IPOC2IG5Ug=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YRcEE/3P4SryD431UEYup5YHL0NdK026srTkdR22DfNxOZS50YMqfU9gTtHlFxJw62/K/w8z7ioaJDlM/4Lg1IGvw/vc5P8sZS1pb0W4cNo2nFKOUCEMvQDoZEWhF7qxvXI2MuKzAL5h8A0AZWx1BvLQv6NhZMvayL71Z5Y3yjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b0TRlASs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aGLmj89n; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b0TRlASs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aGLmj89n"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A0E6A1D0018E;
	Mon,  1 Sep 2025 02:59:17 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 01 Sep 2025 02:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756709957;
	 x=1756796357; bh=NaeqljnmVVYAHVNtFt+pyomkzQWVH4dsXKmBdtGeBOc=; b=
	b0TRlASsceRAr5yzvzcRtsQwZFttSs9m2p+8pVY59NWPn2ap7IVv5r5mYK+0/WT0
	IA1pQVgGahxQelWHcRVFu89RZbbkfuCh1OjLiygsclje1/REyBzWuzs/r9/8p8DH
	YWL2M5LJ4FN6fMRelpdZkSkF5QKA2ZKGt8X77nhsSO4UJPBw4yaX9Cay1vGKl353
	yg+UF+b7T5OHDhbgAIqASjT7/r2/ppx0/pRkPU3N5zLQpe2AtwwG4+KcZr3rpWXL
	Te4H2RNz6MEPS05HNntmHdSKQoIcN/DHi6KXXfa13PZHBFUsSq61DomE5kF5zMxg
	/SXIGVAaznmoYCZouRnMDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756709957; x=1756796357; bh=N
	aeqljnmVVYAHVNtFt+pyomkzQWVH4dsXKmBdtGeBOc=; b=aGLmj89nWOV1u3dEj
	lIVurIlZx1DwAlwAoj2jF9YnqgIUv5SRkc80SonCLDTbrkX+UjOtnr+XmKekr38b
	792iRPZaDENoC5qSy5WnTEgv5XwexG7KVUIk0oqYcgU0bU0r1t9+i9OAYEkqktXO
	6nuXsU0iy2sUm1NYBNi3ZQo2a5C9xIRda4H51AbjmqgohwzRVIGkCeBZVcpnQrcq
	E+1+QsEees8JcNTBG4mHSh4I14h3am6tFdLQlrZKSXmMVO+N4oddFjW4phed6s22
	vdfiZiG65NvG/O1pVFCny3p9q7d2rDYGIigmFmDyZ8xqDcbvUY8UgtE6zSsY2Uma
	WKq+w==
X-ME-Sender: <xms:RUS1aI9I_L845s8-DEwm9LnXm8oXfaFxL3z7vIb29FFhG9ZR79OLDCk>
    <xme:RUS1aAt7ZZVyHVwJN_rA2bw-ug-wSy1stuMw5Kc2sInuK9ql7fcX6dCI9IObFHKXM
    IslwwYeRqnXxJh2ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleduhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepffdtfffhfeffjeefffettedvtedtveefteehgedthedtiedufeff
    udelffelleejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfigrfhhkshgvsehprhhothhonhdrmhgvpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RUS1aJDv2OOM4UjsN9eQo1Pn7BGLNZ1c3fYGNGh8tB5KWGsKea21VA>
    <xmx:RUS1aAfeH41VN2qpQ8wjR84gYxf0FhEozagql0D0SQdBzkput_QbYw>
    <xmx:RUS1aGi-FxbGoCFb2jNAByJkZNgSk4yY7wGv7QE1zppK35qIdqlJTg>
    <xmx:RUS1aAo1olAky5D5W6UkqaeuPSB_Ddr43WIp1ImmPggckcrTqj0QMQ>
    <xmx:RUS1aCDU32E85bKi_xjH-xomoEo4mhO7hl6zBQhH8cWVFhwIhVvWntdS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 382AC1EA0066; Mon,  1 Sep 2025 02:59:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aq6Ho9AcbCnZ
Date: Mon, 01 Sep 2025 08:58:56 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: wafkse@proton.me, "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <015b5428-505b-405a-82c0-b0545379692f@app.fastmail.com>
In-Reply-To: 
 <z0DSzYCJ68tvrJA8fIF-14x3u0CvVyuA7lSRrUJy-78qEySmZEUs8frQxRMPvaar4qfTFdtkv0ZLhVNfkpbVyOle8auxRPLIWGfge9AQT7c=@proton.me>
References: 
 <z0DSzYCJ68tvrJA8fIF-14x3u0CvVyuA7lSRrUJy-78qEySmZEUs8frQxRMPvaar4qfTFdtkv0ZLhVNfkpbVyOle8auxRPLIWGfge9AQT7c=@proton.me>
Subject: Re: I still use this!
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 1, 2025, at 00:21, wafkse@proton.me wrote:
> Yes, I still use `git whatchanged`.
>
> In fact, its one of the first or the first git command I run after
> pulling from a remote.
>
> Please do not make it go! My muscle memory is too used to it to
> migrate to `git log`...

Relevant email about allowing aliases to shadow deprecated commands:

https://lore.kernel.org/git/20250830022718.GB567900@coredump.intra.peff.net/

-- 
KH



