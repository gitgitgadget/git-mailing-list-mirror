Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BE204840
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068073; cv=none; b=jf0YmNKuTB6pdRf9kVZY2WK3JJvmhGRbxgbFJp6tVIFQ3WXqVcY/Os5A3jSDMCPbXdMBbizYw5tiMvtGfxognZTBj23WE5JWy1hT6jpvdiFxxFDYdAMbXZjaLuSM7ReYTtKg9EUg/kCCjGQFFD6wYAVNC8EDe0SP9Z/kz59lXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068073; c=relaxed/simple;
	bh=mJGVw/xpXYSdRFUQmBQAPq8B0cAO+ZQV3agtl3xCy+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=omWXMlNt2H0bNXfvBNcSgJJ4lAbjmwcn38swv0nT8BoqYL86kr9ApW1LRPQm0RQzoL0yqrGWWYH1eTuSDFPW+F2Cmgoumf5L4Ma50xBoQ/EFiXgLXxxvKr6hFKfeRNwYTSpKXK81SgsoWyqRu9xbN82qtK9MItgEZuXyvd3OvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qRmbkICm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFkQwIF+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qRmbkICm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFkQwIF+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60AE411400EA;
	Thu, 20 Feb 2025 11:14:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 20 Feb 2025 11:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740068070; x=1740154470; bh=mJGVw/xpXY
	SdRFUQmBQAPq8B0cAO+ZQV3agtl3xCy+M=; b=qRmbkICmMXQY9iHcDnqam7VsnI
	OREt5qkcFYYZbrzoCAfpJEOjPyuoUi3bbM3KR/RTDVLLqRiZqz+h5vGa9ZI3wUbC
	2lkuAG6csJhVOzcdlbhZEUdPukuImRGWT3Q99PbhzeRjS6f7q9yZ5TRl6OsoQboF
	uXxvM6A3sKs51H6NnmG9E9H+Q/q2Fp02sm/nQqhjIEn/jNDJcC3n+jyK05TY7+vQ
	1AgDOo+yYtu2IvXkxQV4dxT8JK0gXUEK8HPzNoLBlp/L3wdNfTzmXk0tlGXgf/kc
	q28AxJ0ZvF90HyIeL8bHI4UUV4yMg5lOJrOLUfAx8uBtCcOR9s3z6BLtTc3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740068070; x=1740154470; bh=mJGVw/xpXYSdRFUQmBQAPq8B0cAO+ZQV3ag
	tl3xCy+M=; b=PFkQwIF+uvz9fSy45bOfNXjwae4CSvWktaQmmOX68mD+r/IStt2
	EH222WEmOwZ/gc7DMJInvVyWpq1VVx/mHV6oyqDQZhlDwANbNxw+QBaCxxxkhEaQ
	ymrCEweDNaLCZYR5zKmFFHcUubF9y/W/OqwneNqc7EkMlRVElZ48QT8rBOk75ROX
	Ur0MoxUvnqfGytB2rgJXr21t39Z6ZFpG3Ykt5zy8xBb3scw/7f0sudWhHwCw/55l
	ezlW5Qwp4Gle0WQQwF/8CBBY76darrwbXLPkqe5vsdv442Fp2cdjLLtqPnquxQ19
	aC+QPSvsKyeZyEFFPW3g+AyfOfV7bcFAjxg==
X-ME-Sender: <xms:5lS3Z93QF50Qq9W6ZFbHFH2ZtBcmO-EXGe9ltb8kuhN6iOKpg3D4DA>
    <xme:5lS3Z0GYfMIP9CQsx5mqmr3twcKuv5-iS6bEpl12S5Ht6h9P3XLxGM0sx0NG3L4-V
    ChBVxIhf9kEB15jHw>
X-ME-Received: <xmr:5lS3Z96RI3FrjOOBoFczcJdWganDTqMZLjCJfAqH-hcv5F9FMXu4rHvDY15OQjCShAmU-Y-hqgDFGaepeo1A02F4dT1hjI9bfex1AGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5lS3Z637vWJggkJ6r2UHeFWuCszvNWQ-BpR59_NLP83haCOf-RF3OQ>
    <xmx:5lS3ZwFbwQC9YTooI-6lySK1FP2_kH5jnyWzo7y5t7shZuwlTqsmpQ>
    <xmx:5lS3Z79B6U07ZEHjPLwnGhAZWs0uteM99tPsBAQd9jk_AytzRu2bsw>
    <xmx:5lS3Z9kpFG5-fil5uZweuyvAa1jDZVCb-2gHHHw2LOsujzC-gJKzDg>
    <xmx:5lS3Z8i65d6Jc4INgjmVT9RTRsYU8MULiFpIKsrNNi5PI2G9o1weOEm9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 11:14:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
In-Reply-To: <3bf7llbgpb25bfiuqbsyz4iibacwnfgrumfede4nebz3vw2grs@xarsh4rzohle>
	(Justin Tobler's message of "Thu, 20 Feb 2025 08:56:02 -0600")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20250212041825.2455031-1-jltobler@gmail.com>
	<20250212041825.2455031-3-jltobler@gmail.com>
	<xmqqldubumxf.fsf@gitster.g>
	<5uwp2vdm5tzv6n26fu77g4xys5ntjy2bj4hpgiuwpamxkij4zk@77jn55tynwse>
	<xmqq1pvtfrq0.fsf@gitster.g> <xmqqwmdlebua.fsf@gitster.g>
	<4ch3hdlv23qtwi32mgilym43eqtjefgxi4yi7577xcw6df3lbv@eiemmoap22y7>
	<3bf7llbgpb25bfiuqbsyz4iibacwnfgrumfede4nebz3vw2grs@xarsh4rzohle>
Date: Thu, 20 Feb 2025 08:14:28 -0800
Message-ID: <xmqqr03sd257.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Thinking about this some more, adding support to expand trees in
> diff-pairs would alter patch output behavior. To better enable backwards
> compatible inclusion of this feature in the future, we may just want to
> die() for now if any tree object is present in diff-pairs input.

Sounds sensible.

Thanks.
