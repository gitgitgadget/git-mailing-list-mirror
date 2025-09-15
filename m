Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B6EAD7
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952156; cv=none; b=nNHNUHnknmPrY1NvFTuqZBHFkNZWsNwVTBEQMnC3j63uKCj0qrDYL5pLhKcxQUocfqDsa02NFbdMjfOqTiHy2sBnRJvI4jYWfbSlY3QXmbz437btJhUis5SO1eGd54pcRHhSgqWC42fKJJ3txh/AOjGlr8L1K9KsyJSG7MMeogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952156; c=relaxed/simple;
	bh=VCoFEHQ3lcyp+XLn/hFaJiSCFHCNHPK3WZzdxlXlLxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o8GERADXcMwufjVoQCQzgEgSSwj2aBkBmHysI9qojYQi5P5vbu3bc2hyb5ZD1xjIDBZ5NFvIzixnLTQdrVIuxy46wcg/uy5eNCbL/UeHuyoINP66xSjWkkCghAciC3gCAcSHj3q/QoO8U4GCuKUfO8Duy/XcFHp9Z1ke4/9+lh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IRSY1j3w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZoqjZmm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IRSY1j3w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZoqjZmm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF2AC14000E4;
	Mon, 15 Sep 2025 12:02:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 12:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757952152; x=1758038552; bh=EqYC3oAClC
	sxX//dJn3RZ6uggXzhT2sihGS+t109NDg=; b=IRSY1j3w284x0bRoI8zH5PivJk
	TpTa6tJ2rQK/tjk9A+sc8jzl2FK3vz2rT/6SKWNmW0E5IoD2g0JhIJ1K8aHv9f/l
	JJ6fxDLKLZdveyEof8COeTy5T+gxFvnsdxfbDWy8CiQZkwWypelWPdc71bjAjOwu
	Eun+YIzlHXuMU3KKJWiKgmzHhK97YLHn6EXXmTp1J8XAlGZGyt12V2eiXI8jA/BK
	rpOT0sU+QVq2JzBzaIkB00BWsM+EGGBHVs8kYXq2wGTul52WoyIli5uhCXLLA3Mh
	5F4EhZ/UzHvHca9+3Mj+X+/of+qsOkx5KzfQ+81HuCF41GD7hWuGFi2oWGRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757952152; x=1758038552; bh=EqYC3oAClCsxX//dJn3RZ6uggXzhT2sihGS
	+t109NDg=; b=BZoqjZmmSivVo46rrw74HyFAXwbZIguCpVzDw+QvWc9e/UXenDy
	HsPGclGfeX7diAY1KUWcjjLEY1OE3t+UfA9DE2wLQ/v98P03hufh80PtaaanNWEw
	vWEPjYwF+KuIBkWDN0xsdLvjQmqQAHOBmgK8qS8PCzC4QIpIB9ikZln1xoAKac09
	ysFUFsrY8Gsgvvj/r6EEytrtaS3GDh0MM2UxMQr3m+97nBpOzcv3xJFW0cAXKfiO
	xzmnF5GIwbblVxebDX9T6qYiD6Uh2URmERaalnxP2fdDTtgclMThhO85aNVLO8CL
	fYqf5eVA6KhY68Svp8jPMiAn3WxbMghbWSA==
X-ME-Sender: <xms:lzjIaDon51JDHBG5LcvrevNDiZ9tFNEZTFpy-OEvcHwGmkkfFt4UVA>
    <xme:lzjIaKikP_bi-DwiISsVwiid3U00890L9hRfAxbm6dq7Mp161PC_h6UG4gbK4CsIc
    miH28qAIrJbttykbQ>
X-ME-Received: <xmr:lzjIaP_AdI9kHmZOWDY7aKMeL5A7PGUN5wOmFOeKz08o0rwL11_zHV3ORxrj7x-VQ4wHMy5QcGDoE0BnXom12OAM2A4Cuol9dwsn1hE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lzjIaGV2r4jLYnZ7bgYJKXSAEy1dKN5DeAD8PyEXvzAOzk_cYLks0w>
    <xmx:lzjIaDDd0aOhI1vgC41iCvAiklimF4OeV1ShXnfmhzx7KNcPoNvC2g>
    <xmx:lzjIaLFJW55TxExCnv8kbSTztS_ebPSODe-V6ydd4fNBCtTqGI7mTQ>
    <xmx:lzjIaE5NC1Zn6f2_BpjU8AyyKvQ_QhbporqfYgUBXPUkgD_GtJuUmA>
    <xmx:mDjIaLmyKFKfRXpC2iPIk7zbKBV7B-Rc33S143H9i1XCSf_0ZadNPBSN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 12:02:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
In-Reply-To: <CAP8UFD2RVZHqb4EwULmmR3hJJKuxajeOOLe5_p3DYcz2dmdzYg@mail.gmail.com>
	(Christian Couder's message of "Mon, 15 Sep 2025 12:29:28 +0200")
References: <20250910080839.2142651-1-christian.couder@gmail.com>
	<20250910080839.2142651-3-christian.couder@gmail.com>
	<xmqqtt1as08f.fsf@gitster.g>
	<CAP8UFD0EAuGdMWY2ff_kjaQnZ3w7VP2ftM6Y4Hr3T4HQTsFB3w@mail.gmail.com>
	<xmqqa52zoizs.fsf@gitster.g>
	<CAP8UFD2RVZHqb4EwULmmR3hJJKuxajeOOLe5_p3DYcz2dmdzYg@mail.gmail.com>
Date: Mon, 15 Sep 2025 09:02:29 -0700
Message-ID: <xmqqecs7iu0a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> So it seems to me that I should change the code back so that its
> behavior is the same as in v1, while trying to avoid what you called
> code ergonomics regression when you reviewed v1. Ok, let's see if I
> find a way to do that.

Sorry, the above reads like (but it is a bit fuzzy and oblique to me
to be certain) I suggested a wrong approach on v1 which we are
seeing in the version under review and I am suggesting to reverse
course?  It is a bit too far apart between versions so I am not sure
if that is what is happening, but if so, sorry for making you polish
itrepeatedly.

