Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B778F34
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596165; cv=none; b=gSN2sfOBETAlryMeHKr64cEKqT1he2MNfq4HoEeiq3vnI9DWQh9h0jOyr7a24T/KHZ3qD0JQovyrSxKa+YBdBLnCwEwr72k34gdSuRHEJY5THoL3LwEFEwVFIjFWAxdkhZHhX05ie3Xhmg+wUR6CgfILHkWpcvIKLe2Vo/Faydk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596165; c=relaxed/simple;
	bh=si2s1xXjwu45cWSFEA6vdyWrnjGwtIh1S6Mhi++sw30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TzB57nLSXxu+bFWeYEmpvvZymGJxK8AgBVc+3VRfkXPjRW+znrCdJf5UYkCLBdKK9WxBDivjFSxXPiznkVvhUZ/RMHM8ewtvD+5yFXDNLjATU/urLRo+8JXWDjq1piE2Xx09iZ52f5YEIv2t4aJiv/b/IYCM59flWyp59PzS1+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c32N/TpA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oHYhHaQm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c32N/TpA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oHYhHaQm"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DEA111400D6;
	Tue, 10 Jun 2025 18:56:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 10 Jun 2025 18:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749596161; x=1749682561; bh=ShkI/HT9Ns
	E1pWFXUOJi3AnKFZ7hz1M9AI8b4WPxL8c=; b=c32N/TpAIfACyMs+h1PZ0zKWRd
	WYP9ANgXQUFcvIYy9crFiST1t/LcoNP+n6aouTZA+LQ12ZUEGSJ1CjYeHPllcVMO
	GiMQSyb2JMwN0jaFLqwAj2kwGPFAg5w84TKy6BSaisa2pOoOyocxjxKqODQSrOR+
	H6laG01mtF7/5SEZ452EedgKSg3+R+nmAxa0cO42Ub6pdi0M9ECBkhO/n+mIzTp7
	ipji2/Rr7/OVRpeXZ/Xy/mDyceOPfC7OnhtpQzglOh4nJ+kC2L7yT74lyhGyMz0w
	dFq21oLx7XNNZjnN8SU2EN4lx/EIqx0HKDIASUH0+6ThuNeXlX4gNG9MZdCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749596161; x=1749682561; bh=ShkI/HT9NsE1pWFXUOJi3AnKFZ7hz1M9AI8
	b4WPxL8c=; b=oHYhHaQmsmILG4qvOiU4p6RAiFFkdSubZhDPYuUaFM9DgifCpmR
	0OZhvPdVzLPnv9yuMq9RH3+w1jtRo7gSu5eXAX95AKWRjhI1UEiGwhVNm+qaf398
	Vt3XlCxMrYHEItUKeqwdwgkvZvUmXymtJH/VQ65Rm2s/SkY7ZcHP/UvSAaYio4SP
	qeXCoh31Gfzo6nZB/YjWpoGYXMAB9zUWsdAZpRNaqNeRpw1uuzNjK5y9m4+OCcEU
	9bmzJ2WJopcbzAdHdGeOG1xJg91z/Y1FYnLkV1oAHbdjC0YLVp+Bthw8zziYBb9N
	fFEDUKYp0JwzFWYX7knqRCADyjmcEc5ZwPg==
X-ME-Sender: <xms:ALhIaIQ838zahlHaGZEiL36PX0hN77-vele4qgB7swOABOeWVCJLJw>
    <xme:ALhIaFx4EVUQndcuPZoIPkTzavtp_6x0qMv_K_YUrrOyzGzkq9lIdDgKxll3vzwC8
    p93nsNXR0WcWVcgIg>
X-ME-Received: <xmr:ALhIaF0_w57S0lj0DNAGLgESOSeqvPNQwYzmBrA0udS6w5YoQB9mSdcxVeRPIRBejORXZG1wR1fTz3QkLBK6r7SmOcpYsBLuv6mC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ALhIaMD0rlgWZsy40UjgX7hKHzw_dW3Gg0jShfP-6RMSFVnzsR9RJQ>
    <xmx:ALhIaBh6pk_A1mGcYrSgitBkA_sgw1zq2NVo3flrV8veiMwQOwipyg>
    <xmx:ALhIaIoomlr1LSeApZrxRec0QdG6TS4QFUyO3G3jq_0VF80HU89kCw>
    <xmx:ALhIaEjQ5JG0DqtLq9fPeQYCWYMEmzxqSOno4mIpU0SrqoI-pPx3gg>
    <xmx:AbhIaNuySRd1cA7UwsCUPlfye2wV9Muibg1sn-W901U3hNans8FlhPTd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 18:56:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
In-Reply-To: <CALnO6CB+ZBChPg0CLXO+i3AUEwiiF7z5euXa4N3Yh4FoEX4A4w@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 10 Jun 2025 17:11:39 -0400")
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
	<66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com>
	<xmqq5xhmvuol.fsf@gitster.g>
	<CALnO6CDgcQCuhxcJLH-XwxB85mxqokxsf04CU4yseTy-=XUWLQ@mail.gmail.com>
	<5ca4e740-d243-490c-ad85-13b330165365@app.fastmail.com>
	<CALnO6CB+ZBChPg0CLXO+i3AUEwiiF7z5euXa4N3Yh4FoEX4A4w@mail.gmail.com>
Date: Tue, 10 Jun 2025 15:55:59 -0700
Message-ID: <xmqqtt4nkxz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Really? When committing a recent patch (editor template attached) with
> -v (for testing this), I saw trailing whitespace on the blank line
> under the added feed.

True.  Unless you use a special configuration, which might break
other people's "patch" implementations (I think "git apply" has
learned to grok this ages ago).

$ git -c diff.suppressBlankEmpty=yes commit -v


