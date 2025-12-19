Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34829D291
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136870; cv=none; b=iZKARhi3feMzM1wkeEli4EJXmdO9rcTxr+WMcVhLNpWLDFZg8qsYRBzkNu94S4RtmnLzDPSkX1JnUtf+Y0u6ppEnXN/o4oUlHvdKkDvDJg3myqq+NC2j3LMfwncWfoBLRSe6vH2u2eA7Pmqr+koz8tYJiAjMFCnqdXEMGmjC9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136870; c=relaxed/simple;
	bh=AsLu+UNyWkBDyP0tXjm02Nhh/0mOiHLbNWWFwzYJuUk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bJUouZ7Ouep/8dyY+6kJfrX8gId7vaqRwUL4qSweNbjxsuR92PJVOb6n1T0+T+WuAwyovHGw0VB5aNEU94Kq13kdXDgqeJoKBsMDL4Od36/R8wUZIFGAGdnOmAeAi3TZFlPKN1FDZVtYra8I4F9SH3mXcXFcqUzaiyBN3lrpp+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dCge9739; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=whamBDo1; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dCge9739";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="whamBDo1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 238B27A005A;
	Fri, 19 Dec 2025 04:34:27 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 19 Dec 2025 04:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766136867;
	 x=1766223267; bh=AsLu+UNyWkBDyP0tXjm02Nhh/0mOiHLbNWWFwzYJuUk=; b=
	dCge9739mXyDjPEL5lOIAAv1Rb7H87PTAGpBFJsD8mwhT1A6dufsa7JJDkIrG+X7
	KlLhb9S+HZ8Ge4Wk6800F6mUqt3toxzeoopy0tnqUZc3SD/FHntK2k/MzuU2u6iy
	AlqMUpSSQQRBqIalbcjOhsw4DFRitq11mGj6BnMkPmS02amGUdH0zg2tTOxEiFkO
	6kWYMEoz+btxd9QiZw6djU+8adPYsagOWBUUlgXJbAvFagsjyxxIbnlYi51r2Awt
	8Fltq7e76e4YlCKo11vhy2QqWLLZTALB04b2TLFFAybtK1kuwkHgWphlBolDeXf4
	qhsaBZkr9Mqs32N2bVIxhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766136867; x=1766223267; bh=A
	sLu+UNyWkBDyP0tXjm02Nhh/0mOiHLbNWWFwzYJuUk=; b=whamBDo1soqrtnn9W
	sHSyjruLSPtztS5YYcqcIgs2hHaDEQ1dcMz6j/2VSUGNnXFiNYDjwRfMzpzf7ub2
	l0UFE3I0YR65+K+YBeizz6G5gDaQYw4myO7BcpZr7hH4lAGbmbY/PeTCR1bIhXyX
	nN3tIe3lh6xMSwmZr3ALmE05CScmift/ZTS4iUXvUxbuyhAlL5liYldpy7pjmUZd
	BwUSKLz8rnecamG4ipVQt0iTc9WEdlEyAq5QxvD7ZYDb+QZemxdgF7gdtXnNFOTE
	p2HgiWbMu00jNWzsJk0oslG4RNkdNOcCxOj6henZe6SRHItVn3uxreFzPzdOzCrv
	OZ3yA==
X-ME-Sender: <xms:IhxFaSnbEsw5rOi2eGV02Xl4YB7lCfxYCvs_6c6yu5_JHNuRjTBFMww>
    <xme:IhxFaUr6SEiAKsmPf6UC8IrmHwCsQk_W9SbUgeaB--3EEzJzyDOafr4M_6I-RINnA
    ayZk8F0Ku8rRRITI2YNAr7MVh68bljTH8EmXlbDo1OxcESDAgLgGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefh
    ffetteeludevheetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehjvggrnhdqnhhovghlrdgrvhhilhgrsehstggrnhhtvggthh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IhxFaXiRJrw8hXTVgoQcUbRbVB__iBLhwa2s7KrOtMhdiA4ovUxYKQ>
    <xmx:IhxFabxDiNZ1um6jBt9DRYAii25BBNUjw6nNswGL8fo9S8uQh5p1aA>
    <xmx:IhxFaaI6kahOqEez89N8SGVF0YSzyA0eb23y8Oke_ul-G-c-JZmg0g>
    <xmx:IhxFaSQEbdTITsfwk0aDOPxUV7iRJtT5S8pYYiDnOTRJe4Vc5LRcRg>
    <xmx:IxxFacV1X8s5KutO-VpejrE1zU9jtg4tEDh0io5ADnVOXL0EKjAOhncz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF86B1EA0066; Fri, 19 Dec 2025 04:34:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7cBr0QabPqZ
Date: Fri, 19 Dec 2025 10:34:05 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jean-noel.avila@scantech.com>,
 "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <9dfb1888-aca9-4ba9-bfca-49dbd1074025@app.fastmail.com>
In-Reply-To: <843711d8-00c5-4747-972e-e705e14d85b4@app.fastmail.com>
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
 <031d7b41-b6d3-450c-925e-cddaf2e7aa85@app.fastmail.com>
 <876ee36d-610b-4df6-9297-96b38f106c6c@scantech.com>
 <843711d8-00c5-4747-972e-e705e14d85b4@app.fastmail.com>
Subject: Re: [PATCH] doc: flock of small fixes to various documentation files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Dec 18, 2025, at 09:05, Kristoffer Haugsbakk wrote:
>>[snip]

This is in `next` now anyway.
