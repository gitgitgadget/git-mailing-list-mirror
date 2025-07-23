Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C722CBE6
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293383; cv=none; b=k5un8uBTShyBCLzyb9l6qRbe32Q+IHNu3vWS2RrkKziVLkIcKrVUo3hK9BMT9IUQfxBAKnNk3+j97Ug6D/Y+d3+9FgXDOnV3QjvgHxFCZ7OuCqP7NpU5byAyHbyHNCzi/Xso5KI6FBCTr1UXoHqdOwrZP7KnIyqMt/tlFsLE6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293383; c=relaxed/simple;
	bh=qcOZIvTQHY9gXVSKfQ2zgbTN2ad1PRjfkbKchoY8apU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smayqp1oJLTV1rhqtzpQVlB+jr0mkzNTTAvNsqX2RLYa4xXD5h1w0DW2Scl8mdj77m6X0fxQOA0KMLzxqFnZ+WkQUBEh2rnZZTHhIsC8NXB/APLrt0Kzwp4Ett91wkE3tgWw4gkZPNIxiTMJ+xQioIRJVtKNiB2HrUh2xP4klrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EQD3wJzD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mlgi1vBj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EQD3wJzD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlgi1vBj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6DF6B1400108;
	Wed, 23 Jul 2025 13:56:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 13:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753293381; x=1753379781; bh=qcOZIvTQHY
	9gXVSKfQ2zgbTN2ad1PRjfkbKchoY8apU=; b=EQD3wJzD3itGHbXnYxHPTiofsc
	vTyK1n58rlF2jF/69lwob9Ar93YmVYFtB9hRwd5ty1rGaYmg21jsgBkdl6zeSK7f
	71oWw/g2X/OZTqcWLi5jOm1XQ47ddhqBE1RUDJ7xMIxGHsihOAMheUgoK86+TXjY
	+VOK8Ao7+9BHVKqb2Jmgj358+iVL6mfQvxLycsyZZEBDj/LLDMJ1g1D8IqU/mJ+1
	Fmn24HD98Ryiwf7Xjro2HUD/DJqFQJyQ5KVWV7nzSdCu8htpF+YyDJlOicB1pHIC
	MlEHM1yGiFooKwygPYplNOQIAd7obOJCDDJ+iUB8GfP1yiLWB8DROninODhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753293381; x=1753379781; bh=qcOZIvTQHY9gXVSKfQ2zgbTN2ad1PRjfkbK
	choY8apU=; b=mlgi1vBjExHc6g1VxylLmVlmatIwrJ4cW2640G4ZwoJHWp367x0
	Evf44O9ojpJwPwevW/Ka4SzaSiUqzChzu5mxZSNejuUrzv3vIL/LWR37XeYbkw/5
	ZYmm7L278D5XEUgH9ILeRGIzxWrFD4DdCxGiWdxd795X68Pbx6wIVwBk8xzsNqaK
	LtiHSnZle11IxAPpnsxaga65KGkJaWqTFZif44V7pBeo3zdPXxB1UEWQdJUSqBBL
	LKtl4+4UujMAwv+0rr7KNlcxNzENyqRvyawhn3M94giN7hv5Ry5rZ2ECoGLKMeVj
	qlZ6KO1pC5swmiuZhkNS8uRz6hor7C6Ukbg==
X-ME-Sender: <xms:RSKBaKFi9p0_xxNuLGtxLp5qIXaXiXd1AJ_uj86W9kW7AL_KZ52YtQ>
    <xme:RSKBaI6ANBSVN9vudApzwRXlu43zdP7lxg3nqTeUWncvnrmr67vTjuTkNXVifOblI
    DzivZC1a6HHOy-r-w>
X-ME-Received: <xmr:RSKBaKm-cfu0pHFJ_sdp7m9ahEooQddua1NjVDN_sHUCu7rfmsj3WT0-G14O8Yt6rB2hIRzkvsW5zHjsvDfdDwf7e4b5MqomjcFsLVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RSKBaFrYOtom7EEB9GqeFn0IhQPAwG8oMoDqs3jeaJNaksqF6BysZg>
    <xmx:RSKBaBtatJrugZgm2Kza5czohQjzOSswQQq6n4_64vr-9eBw5IE4uw>
    <xmx:RSKBaCH7fNZCULDZcAHywsmeosP8ZYDa0RWUEoNzGAhKLZ7AHRuANw>
    <xmx:RSKBaCaOq0v8QLl8oB90pdQeFfQt3NZpwOI321zvZuKdw0nr99ebaw>
    <xmx:RSKBaMbDTekEQfON3UFYwwUuKzADEpLbfEBX_dqPwGaYCH4ZMvHRXorI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 13:56:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  brian m carlson <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] imap-send: add option to mark sent messages as read or
 unread
In-Reply-To: <PN3PR01MB9597A88A3CFCF9EC84ECCCC3B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 23 Jul 2025 17:35:49 +0000")
References: <7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com>
	<xmqqecu6om3t.fsf@gitster.g>
	<PN3PR01MB95970E44092A27F47AF25CF8B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597A88A3CFCF9EC84ECCCC3B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 23 Jul 2025 10:56:19 -0700
Message-ID: <xmqqpldqn64c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> For send-email integration, maybe add another option over there as well?

No, let's scrap this step, as it requires way too new version of
cURL.
