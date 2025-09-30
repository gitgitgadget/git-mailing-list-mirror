Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FD25C81F
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239109; cv=none; b=H0qOz17p2sOl/pLBGdIgE2vEneP+MT7tJs2f66lamItHuhfK//BVtGdgg5br9A+/EcOndFRP1Ugqm9byLXGV/lOtFm1SW1RbJWhypG2p7XkqfzJ8/is7y9thWu5zPyGsqE5rfT3KlVCIMZlKiahXvhmPhfB3ytTqXryq8Q4NmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239109; c=relaxed/simple;
	bh=C8ICiwrJASBMWkeyaWmwRPwucjyQntaaONAgXONurI8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ttHJN9QctpMFmzCYmKLZILeekEQTDFx3fiIWs96iOkJ3Uz9l0hmjRDz2CDmM1LU3nNzYnXwDrb0YygF+oWUgEEPccZSkq7B2TsZVn9rTum9R7pG5Ca9Fj+elteQTzy/LTdT3HVYPLq3CS8pSfoTwMennlxf9xS6PN2CWubdxDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QIl5mdGd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CT40sXHV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QIl5mdGd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CT40sXHV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 13338EC0136;
	Tue, 30 Sep 2025 09:31:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 09:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759239106;
	 x=1759325506; bh=C8ICiwrJASBMWkeyaWmwRPwucjyQntaaONAgXONurI8=; b=
	QIl5mdGdmgbClztvjxG6gYqatEnJxAv2H/GD+cshio5EPWuxy4+oBe9M2f7haNWJ
	XrjHHU3QKfMUx+gncVyTo06AJXW7HiaaLSEaQTo+ieMEZ6/irV8tFnOP04ZXm49q
	JU7KmMJNW/HN8j7VhDgt9XiKsgmLKcJHIvleMrTOOie6Fpi/70VJXAz9mKTRUvai
	taEwh4TYH7PJ84SKEQXHn3IBC3HFaRre8mBSapz/bK3qodebZQlLgjBLrXkwSYDs
	wENFjgkkuUsWhprhuHRwBZ1SbF58FEwA7umUJh7CvKaQDZ69kl5liB8q0uajLAGw
	u3GIPb3Chi1HvInibI1zXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759239106; x=
	1759325506; bh=C8ICiwrJASBMWkeyaWmwRPwucjyQntaaONAgXONurI8=; b=C
	T40sXHV1k9afNubLnnsm+EupkCivz6jHb+Cg9uy19N9o2ykL+TLpAbNkwfmvXOPn
	pk6GXOog2O4kXYzAAkAjDoKQgjYPjnE4cEXBEINzcLH2XP56TKQl2Xy23UJ+L1Li
	rFPP+TcXJJGz1PSbDUoXKXJuHyBspeiUL1rWwswaqtxO+ekYbR27ulMltIiM3qRC
	ELmWqOdjuBEgPaKjl5W54OKcvpOI0DbalsAF2ePyg4YmRkDuj94SGib286KPkGsL
	gBXJbj/S/XRvgGV+lXa85Wwmmnc3MmZlT7W2EyIwdrcVcL95NB+8dxreoSeGLiRr
	zph4yOlyCWVpK98MfruSw==
X-ME-Sender: <xms:wdvbaEqKk67l5w-LHNRIlEYFwgt0Sii2rW8n7zVZ-IK8itGiU_y0kTI>
    <xme:wdvbaFcx12YFk8KPPZEQ8UKp07VCZnTIahVk0hJHKB8BJ2vzvyP1D8_2DBUnizNk9
    vn9D2uGLjoR7UT_tE4M-qjO1keVvfROwMU8nGWHKHnS5YdvPyIeYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wdvbaMgMd0_vfR41OthAQyMfAclViRwZ7aletiZYGhW3K8tK1EnLrA>
    <xmx:wdvbaFuPO5L66rzS7jUoNmFXu6eJPZ6LnOW6jKOVJs9OOanwpEwVUw>
    <xmx:wdvbaCSgwB9oauy1XJHhv6A6POpvBLIMWncwKoEY2JXuH-T3Iras0g>
    <xmx:wdvbaB3nYcAzU0TliXgID9ZHpBbrk-Gltb3YZ8KsstMSVwB3iA1AMA>
    <xmx:wtvbaCq5XpM7EO5p4Jf4zcIRhEiHlgeJVY5pBx0LUgHKhmQOP0fQSkh0>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 984621EA0068; Tue, 30 Sep 2025 09:31:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APikHCLOdt3g
Date: Tue, 30 Sep 2025 15:31:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Jeff King" <peff@peff.net>,
 "Ezekiel Newren" <ezekielnewren@gmail.com>
Message-Id: <db85429d-2c89-43ec-a92e-96ad8d0049ce@app.fastmail.com>
In-Reply-To: 
 <7d3a7e617c68cba19e6ea1195bd6d753a5795a4d.1758662670.git.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
 <7d3a7e617c68cba19e6ea1195bd6d753a5795a4d.1758662670.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v5 04/13] xdiff: delete superfluous function xdl_get_rec() in xemit
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 23, 2025, at 23:24, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> When xrecord_t was a linked list, and recs didn't exist, I assume this
> function walked the list until it found the right record. Accessing
> a contiguous array is so trival that this function is now superfluous.

s/trival/trivial/

> Delete it.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
