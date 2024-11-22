Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D81DFDBB
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301471; cv=none; b=eIvHsAEewdnWFkV4RBn7ogliJDUtTvaouDdYSxyvOcVozAG3zFFzyU8b6JXdrvWajF0LsQCUI0BqvdJCf9gqyzPJ4LJzj4Vf/xXtMAYWU/6b9cE2hhJKKeSrxysUZtOS4wAd3bAT0lNqPWHKjN7ho2zeOVgWlIE0jxXKNzfTRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301471; c=relaxed/simple;
	bh=w8WvpO+AfJ0gVov5pZvfCiLn/9rr7uZ5W+BZ+Gfq8xY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oc7h4D1iuDR4/ryd3FKfG/EK2odmOgRrZl0s2Iv+W8cxZXPOEEtZCCt8IRRmjDNYV8axQfryq7TenfIpljXN1jcd/VMONSgunQ2rUXGyCo6HQBzZ3bRyW4Jg9ZdsSEnj6+4UUX8qmlsfyqh6aj90hSvKjeMqpaAeItmb1wPNaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=STXMLj/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w2Rp2pbW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="STXMLj/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w2Rp2pbW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8262114012C;
	Fri, 22 Nov 2024 13:51:07 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 22 Nov 2024 13:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732301467;
	 x=1732387867; bh=e9a+o8+yqBDlxhzNmFztMZYHO7NvzcGZKCEFmPleZng=; b=
	STXMLj/OKNObXtelMHslrWbyVSsuWHF5ds3VNVtgEV6XVXaRzdiWWn7mbvMzVSMO
	qiUnzcUGA+xegrK+pmlbh+BXfEooA1Y459OE9wrwyUuPW9Qg2X4HNWfByGiMgEQs
	ZfRrWrB/iKVer50ZQl184z/R6kLY9ytxJQv6R+K2Rj7EEad6XOmGiS21aagOtYmI
	BzyJ03+eASqkopGFKd4st/dNTX9+nWVYJjmR3pZ0gA/Vnv56xt4XoIzmS69TGehm
	im4lP5G7qvjUXsir1+alOR+P9CxaibMIOXfGrtLC46H259NW10QcSZfvAlyNFYN9
	FUIG9iYDddiEhnVevc9AcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732301467; x=
	1732387867; bh=e9a+o8+yqBDlxhzNmFztMZYHO7NvzcGZKCEFmPleZng=; b=w
	2Rp2pbWvEim1mo1vpfvYfJyeS37qJ4Ju9FG9SSmL2y9pWZ+sL0hleRA2EvA886Pq
	93NOQ4LCMdL1sP4AgSoauT0nXCKpFVnO0VeuGVxzW7heP39UL/Cl1cFzcmRwcR+N
	+HIboeTWextxx2X8HeUv8gqNBwSRBnagUCDSm8M5tINl1Rwq0tFyCcuZu4hdd/5v
	v1Bnp3aU/AWfBp0vmxHIFiJ1sA4xc7xLGJL+qpQjnxhSthE4gZivMsBg/eVjdhQm
	FKQfN8thZSKiC83fTYyqWBOt54ZIkZhmfNzmawXMyV8WjsFPOxrjgioo0j/BuOcN
	olEP35QiWA1z6mQC/97UQ==
X-ME-Sender: <xms:m9JAZ8XILWDdNVw4cfnD6TvSbx_d-Dkx6DPkjB8uPpCul33hgmLYztY>
    <xme:m9JAZwmWcUl0nQc6m7Ko1AC8L5vnzvqFWvgF4Lcp9_1pQaqr0I8QRU7nPrxa10P92
    oWQubWyApr_ThQ7dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetff
    ejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghvrghrrggs
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvvhdrmhgsshhtrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehlvghsshhlvgihuggvnhhnihhnghhtohhnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgtshhmvddvgeesghhmrghilhdrtghomhdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehjghhsrghlsehprhhothhonhhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m9JAZwZQ1WeKflJm4NaZv3G740drvR_XU0R65O0K0lH_EgPGC7JDmQ>
    <xmx:m9JAZ7XiIxprzK2DGXCkSoZJ1Cbukjhp944Cgah8RiR3oJA9UqLgNA>
    <xmx:m9JAZ2npFZDLJc29YRU2bJ5SZRjJhcCIscNWho91ks3OnAKUTQ92FA>
    <xmx:m9JAZwdUu8RrN7RPY0BOAFb6VczA8p_6668iicTwmH9X0vR6mGSY0g>
    <xmx:m9JAZw5GMMKaQjTEoMG4q3gwuKXi2mYBtC7s5RhJwan1vCeOTYcsI0Eg>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6B4FE780068; Fri, 22 Nov 2024 13:51:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Nov 2024 19:50:45 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Matthew Bystrin" <dev.mbstr@gmail.com>, git@vger.kernel.org
Cc: "Lessley Dennington" <lessleydennington@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Elijah Newren" <newren@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "idriss fekir" <mcsm224@gmail.com>, "Joey Salazar" <jgsal@protonmail.com>
Message-Id: <1d3aa75d-e816-4544-b10a-ab1a215dcd83@app.fastmail.com>
In-Reply-To: <20241120101741.8225-1-dev.mbstr@gmail.com>
References: <20241120101741.8225-1-dev.mbstr@gmail.com>
Subject: Re: [PATCH] git: fix paginate handling for commands with DELAY_PAGER_CONFIG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was originally not going to nitpick this in case the patch would go through
review (not to disrupt).

On Wed, Nov 20, 2024, at 11:17, Matthew Bystrin wrote:
> Calling commands using editor in terminal with `--paginate` option will
> break things. For example `git --paginate config --edit`. Add extra
> check to ignore paginate flag in case command have DELAY_PAGER_CONFIG
> set.
>
> Relates: cd878a206e8c (t7006: add tests for how git config paginates)

Trailers in this project usually credit/mention people. Related commits tend to
be mentioned in the body (the rest of the body) of the commit message.

> Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>

-- 
Kristoffer Haugsbakk

