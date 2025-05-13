Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691DB2857EB
	for <git@vger.kernel.org>; Tue, 13 May 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141953; cv=none; b=iIrZIefLXinS9mvE7DvxR8dAIjfNX/vKpJJxpcqcFhWvXlot9O3GbafLJvWASmCURplJ4tzFHGwEsav4SlErpTJESfoPmgCjCuapXyEw67p4DCCrkNyTqv9xbAgWCn9W4MH5OoroWLwZraok8i+n6xsg+20YHQUxcm4AnPYTRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141953; c=relaxed/simple;
	bh=k7HaHc5d1mHKmGEL3baK5eUwbntLw6yg3G2rOoSxqfY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KkpqrBPbxirHYsgQuNkUTwp1XFQJu+3uKIwSUDeOWJruGAuxVHW6iBbUoa1UhMG5cVWLWLJHhr2evLGmT7RiOxqQN8byfU54XakVfegcTXZKvC6JGtzD0BQJMmqXep4Yjsyox8Xo1ic4z0N5vZ2dukiYZi+KKB6PEgWxIhYUa4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mgkAmP90; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/gsbt5a; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mgkAmP90";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/gsbt5a"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BCDA254007B;
	Tue, 13 May 2025 09:12:29 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-09.internal (MEProxy); Tue, 13 May 2025 09:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747141949;
	 x=1747228349; bh=LGH2SCPyV+0qyOpvy0nKYhpmF80wDzfbD2k6aN0NVJI=; b=
	mgkAmP90QAy5dPs4sSSAXLJFRu54GOkxt1tkjFHnVeRCDQ44x7ruUz1GBJjjt8Yv
	9v4uWq+upKZsfONYW23dIT9dIqxI2u3nhN5O0+oor69QuoLanP2/ihRcBaj++7FT
	vXWpnB/ZikV8XVriDEasdTGGRvj2ZKIdEdLHIKW7qFV/aCJnN79E/gfHpcMm0nJK
	J0BVOkvLqg5o3x5tSWEqM/j/F8X4i9bfWOM+/UR8rM9vlV8GXUj5HSjeHVF3Fzzk
	LCtTQPEcQChZrhonLrnxCaDQLNICVcO+eXyZ/ZYwVCcUpg19pubbK/SQH3M/oWF3
	UZoh1fPxG6gX+SV2824KNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747141949; x=
	1747228349; bh=LGH2SCPyV+0qyOpvy0nKYhpmF80wDzfbD2k6aN0NVJI=; b=Y
	/gsbt5amqVZNqgDVQaeLaA8JdAglEhErRAWcDzXFgsnnVIcCF0I2OhsumVHk2lIX
	t+u4v1veKSdfY8YPC2DW0jidNjd2tFOalHpNrj2VWSGvo0zb/LR1z9cE13wwy6hw
	UYEjAZ//AHeahkrgtk5SvZhW3RR2fFvAZFfnGSvOeP+mFwmvsy3Ptq0/GPZynogZ
	Qur+VytgYiJC+ruF7fEk0PACn8cyy1ZTR0Z/7b75P8dC604EwqvnulgzMqkul8lF
	oAYGVYUOZLFsMzO54F3jfWYmV6qv5eaDsWrIObjAU3layBZGJrIfpaz7iW5GctRM
	8/2wyYnFb53/H0Lzn2PIQ==
X-ME-Sender: <xms:PEUjaEVg4D3OuU_EBThNg2lmoud3zGokZQzl2UaXjiUwk-jHsTbMfis>
    <xme:PEUjaIkXmcxYIRUXzWWjlkbmi5GiEZ5AjJ-ck-sUqtE5lGBHkgJIX57bj8wuCB7Xv
    cDpooaT_OsdE3mZyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnhepffeuueeiheehffejgedtveefhedthfevvdegudeltdffheejvdfhje
    duffehgeelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishestghhrhhishguohifnhdrnhgrmh
    gvpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PEUjaIZzACAefPbzk0w4-fEfVv763Dsw90vLWUBCXWwOJnzWc63NSA>
    <xmx:PEUjaDUAZwBZ5fc1zoF3Idp_3Y20l0VazSzGRnoOn3MLsCJNwo_Fsw>
    <xmx:PEUjaOl4KhkZdyerDFSVngDhWAWqeuFGrz1k4lVWpwZqHfgiSBOuiQ>
    <xmx:PEUjaIdtaeVtkHOi-YI2gkBNmZaydBLpy3_QhQcg5tCw6iQkACsPPg>
    <xmx:PUUjaKaSihefZjUP7FHOj6oxqNSbQR2JFdXS801uo3fsxpDBb0Tlxr-f>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C043A280008E; Tue, 13 May 2025 09:12:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3bb4c4e6eb8cb01b
Date: Tue, 13 May 2025 15:12:08 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Chris Down" <chris@chrisdown.name>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, kernel-team@fb.com
Message-Id: <1ce39577-13d6-4666-b341-920b17f2089c@app.fastmail.com>
In-Reply-To: <aCM5JY25NVPgyYRP@chrisdown.name>
References: <aCM5JY25NVPgyYRP@chrisdown.name>
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Previous discussion: https://lore.kernel.org/git/ac87b389-2bf8-4c2e-aecd-9e86f65ca8c1@gmail.com/

-- 
Kristoffer Haugsbakk

