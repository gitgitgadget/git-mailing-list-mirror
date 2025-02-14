Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC616AAD
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569789; cv=none; b=UC6Ax8AOvBVImZ3KpY3jxKWal/bTA/m1yJB+5rbpMV1TrOB7A3OXmYLIyYSqCKUxjFPvGtBA53RneDqYRuvEs6JONtxdA5NVPhuVOykfA+hWma8pwGUAYrdia1mVzC1kLMXltdH+aiGCcbCDXlDUIHgbH728JedoVd/GKjmJlx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569789; c=relaxed/simple;
	bh=qQj35NuaP9hBlo34pM1ogGEBY23Cv8R5y2qdihFvNCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpNkqGWmZnQBowahgmLnZYtV7HHsQngID9CVw2aFBrnvimnw+rbZ7MH+SXFk55DtbLpEZqe4sm0ysG9/9oSk5C/EHbH68CQu6d2UCqD822qJlhN+4NfZaO5OirdjPqIhzQbWJX212yvCCLz6YXkzOBInug9Aqn+Tp8n4WTp6J2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JzY7DeUh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSChm1KC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JzY7DeUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSChm1KC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C901C13801CD;
	Fri, 14 Feb 2025 16:49:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 14 Feb 2025 16:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739569786; x=1739656186; bh=Yv5hBRyQVx
	aztorQMLSkw/lx3s5wv8dtuNTDtdBV+OA=; b=JzY7DeUh39qyWGxSrp4LUubYSC
	AdUljnP0OESAIqZpcQmRgHDMiefKYl2nFyf5bDCrR89goFIRzTRCcFZYGc6DQGgz
	mEoaFQpoiAcI8M1QN+QWSUuu4NvU1ED7G1MbCTF6QySV+CtpKxnaGP7mIhXvby3p
	cg8inqpVbbdYrkhLpw7eXYWoZodb7womVpXeCngR2XZIaaBY2VyX+J0wPYJgoPxg
	R0z2uzBjfzUpGN+24hCznsM0SqU/6rNT1N8Tzg09NGjeJFqSxDXLxSiF+1QZgUGU
	FLIxEIv2iyP6A4YyfJ6z0AJuBYqvgicUJ7bAyLlMem8wUEg9x89eXtQ1/sHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739569786; x=1739656186; bh=Yv5hBRyQVxaztorQMLSkw/lx3s5wv8dtuNT
	DtdBV+OA=; b=SSChm1KCw0hbWi+uNv2a2lILwutXe7enNvrLb0hMDyx+323ol8u
	M6eCpKQz4WCWqHj9MqTNlBT92k8yggkwedB0qPvyDpwDfTXuHYqpLKHLIZtNK7kI
	5VTn2fhn23wmVQEpxPWZThgxt7X+OCuijb2S22YqC6QxsM35g2bFeY8Dcuo+vb0z
	fGShcAjBtcl3WA5yAim9do0Li+XH1ZVrvBnF/Oh8anaEjoahWv256Gn0wXmFfMg7
	mF9KvZ5ikmzfODVTqVLDlI9EkOkjX2xNIXhwhxSrkAs36IRue7FjBiCcM9x1FPZZ
	WA416xur0dZtGKsXbn06d2ruyu9d6Wr4i4w==
X-ME-Sender: <xms:ebqvZ95KixJ4LNA6MOtKBTYKOlcO162vLEldJ_lBRRG0npH98H-lIw>
    <xme:ebqvZ65wMNvKLYZXzSAwfWqbtmiWy5JNIpzddTrWaXHgUYdnxrQOBe9drHxs3Fprr
    Gv4zHS-OyOlKOqr3g>
X-ME-Received: <xmr:ebqvZ0empJR5hl6Kcs_RFl1vhtcmTixPPcyuUJJ5rYIx_BiCgxmsa-peayVgST043Pew6vMDWpiswf6p53HsvblOBPrk86IYPu5A2lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgr
    nhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:ebqvZ2IC1lcUdVOav1K3NH3XqwpcizB5bwtGnx4HAm0_NgYU_FMwpQ>
    <xmx:ebqvZxLU3hYdTzeIadZoCcr7V8iOjK_zoCvTZAEIdnQ7ZwBLWbyZGA>
    <xmx:ebqvZ_wT54wMH4AK_bpj6xXJWKbiLqDRYJc3BMeOIfmRnU_ljAgUfw>
    <xmx:ebqvZ9J7RQGEpvvAQ00kNNIGN9ZXqsUHhOo8w4zpvEguSKOhxkPGkA>
    <xmx:erqvZ7AUcF-i9ntlmdfFAHHw7X7zspHTW3Yi6kQXQyagyQb8b-noWMh->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 16:49:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  Johannes.Schindelin@gmx.de,  johncai86@gmail.com,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 5/6] t5701: add setup test to remove side-effect
 dependency
In-Reply-To: <20250214123734.1403120-6-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 14 Feb 2025 18:06:15 +0530")
References: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
	<20250214123734.1403120-1-usmanakinyemi202@gmail.com>
	<20250214123734.1403120-6-usmanakinyemi202@gmail.com>
Date: Fri, 14 Feb 2025 13:49:43 -0800
Message-ID: <xmqqa5aokxhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Currently, the "test capability advertisement" test creates some files
> with expected content which are used by other tests below it.
>
> To remove that side-effect from this test, let's split up part of
> it into a "setup"-type test which creates the files with expected content
> which gets reused by multiple tests. This will be useful in a following
> commit.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t5701-git-serve.sh | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Up to this step, everything looked very good.

