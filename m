Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB21165F1D
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738364773; cv=none; b=RjEcWIv2GaXkg0wHf9TbFlOIO+N8XAww0sDZyBHKqNPRFrCLOgH8nhITusnAnvu9ePp4ZMHq8Bd+sbmsHKzytSTicIGmys1VKNte/k8voCUFVwlCKn8FswQKrDXYPzFWSruJ2+ePHSnVKmWutizz2Pl8vU7YYYiLfYAJ8RT0QEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738364773; c=relaxed/simple;
	bh=yF9DbE9yUyanl3+bQKORf3X4LRHQfdSAEHGwC87BgcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kxgclrx7a4GE92T7Sh3vH18KEcssUsf208PxT/er2aiPmYMrbem6shReiLm5xuxuxsKKsftSkKD8xc0fNBK9Euf9PgkNGVctrfhz/RysMnaHalI3W2/OogSepr6LkcUMnn36X0Er3aCwoYZd601UJ5y94l0MXHeiJJeNDBS7cmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hluuc1nL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xoCLSmBN; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hluuc1nL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xoCLSmBN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7358625400BD;
	Fri, 31 Jan 2025 18:06:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 31 Jan 2025 18:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738364770; x=1738451170; bh=jPc+ii0x6j
	4RBrHBNDSSHAfZ9I3221iLCD1xroqHlZw=; b=hluuc1nL1vlU1DbVm7syxI2MbC
	l5RvtO1vKcOLUdOjdlnf9cb4TZphtw+c8WpjOyTrCg8EoD9TZvBIPbM7bcux61wj
	tfDDhNYjEF01NKmML1JfHas1FP2EXCn7gg4qKt3vwhJy44fOOZ0sjcgc/rF+PT50
	32596n/plehkAyoNWtQ1OqfIwNjxLUPHOrwtNxtkbamLin337RjnyLrlao+Bve0I
	sOOKt2iuNo+TyVa4NZQPq7lyFMBeP7qqVfic13o+MCuLJ9Ug2dS4nqZZDXYTrc1l
	vvD0GaRM6to7MZ7QgPMVXwAarZwPL8Y2kO7zQGzu+Cg/zIiFlthYecqa8EqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738364770; x=1738451170; bh=jPc+ii0x6j4RBrHBNDSSHAfZ9I3221iLCD1
	xroqHlZw=; b=xoCLSmBNI0UBWdtrB+fcIO6r4ODo2vD1vCglPNgM9k585muIY+C
	WKyFvPE2thBuGBTe8GjNIi6pP7z77mbQqCk8nRUAXh8V7NCoVNI0tyFUTMc2nAFm
	pldFZly0rlqoVwaiaFpXMsxbsXCdQqyvVc7CnzmEVXFnTIeYucRkJJUQEl89WK12
	klxtEZ6k55QyvXoyXkkuge4QolMb8cjcOyNUbjNrGIl7+0cl0xs/8hwaUN6NTfu2
	7Xro8vw5j+MezIJeiGFVy8WKILVRKugKphtHGoS9UM9n+1jlijHWMEgJuZ0HXi6c
	oxtxVJMQKHFNMDFtMLA2Sso3QgUQmqydBgA==
X-ME-Sender: <xms:YledZ5mW3l-HG6pJym2Pkyokyh6tYe8rRyKxdAw-92jwemyizofEvw>
    <xme:YledZ02xFZiEoQplAMqjLw6GZy22iMJkYS0xYbloBIhM4Kg1Ia8yZbVQDgsVRP1ax
    zLpAuJKre6JE8Jp5g>
X-ME-Received: <xmr:YledZ_oD5G4BFIoIC5fajIohmxYl4p45GAdyEPDc5dAE9fgNe4ezYUi3fM8-1AW_hb8e_TTnlgQ5gnbiwTvyQVNmH2cKhdeY0MmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhfohhrihhjih
    elkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YledZ5m5A86NQ-tJxUsv90JT9s7xFL9mkUEeWO4JWlLeXajhaF3ppg>
    <xmx:YledZ31ApRO3Lo09vkYtasABUPopiDfkPqvbFWabex5cYrcXKu8I-w>
    <xmx:YledZ4tfby_ex3kgApkzWTVxe0Zq-7JGEfsmQA1-Lydb8BHjtN6_1w>
    <xmx:YledZ7UhBFNwiYaVEIxuC1tgGfJt2xMGdgTZCw9opR3v8iYW29E7ZA>
    <xmx:YledZ39HkoDWGX3CYg8mSvY2AswH0lHNrIlvV0evaUJkLjt_7-C_tEPf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 18:06:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] t/unit-tests: convert unit-tests to use clar
In-Reply-To: <20250131221420.38161-1-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Fri, 31 Jan 2025 23:14:16 +0100")
References: <20250130091334.39922-1-kuforiji98@gmail.com>
	<20250131221420.38161-1-kuforiji98@gmail.com>
Date: Fri, 31 Jan 2025 15:06:08 -0800
Message-ID: <xmqqbjvm60tb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> Hello,
>
> This small patch series transitions the existing unit test files to the
> Clar testing framework. This change is part of our ongoing effort to
> standardize our testing approach and enhance maintainability.
>
> Changes in v2:
> - small fixes to the commit messages and how they read
> - some small code fix up and refactoring
>
> Thanks
> Seyi
>
> Mentored-by: Patrick Steinhardt ps@pks.im
> Signed-off-by: Seyi Kuforiji kuforiji98@gmail.com
>
> Seyi Kuforiji (4):
>   t/unit-tests: convert hashmap test to use clar test framework
>   t/unit-tests: adapt example decorate test to use clar test framework
>   t/unit-tests: convert strbuf test to use clar test framework
>   t/unit-tests: convert strcmp-offset test to use clar test framework

Overall they looked quite straight-forward rewrite.  Nicely done.

Queued with automated fix-ups, so there is no need to resend only to
fix below.

Thanks.

Applying: t/unit-tests: convert hashmap test to use clar test framework
Applying: t/unit-tests: adapt example decorate test to use clar test framework
.git/rebase-apply/patch:105: indent with spaces.
         * In case the buffer contains anything, `alloc` must alloc must
.git/rebase-apply/patch:106: indent with spaces.
         * be at least one byte larger than `len`.
.git/rebase-apply/patch:107: indent with spaces.
         */
.git/rebase-apply/patch:109: indent with spaces.
            cl_assert(buf->len < buf->alloc);
warning: 4 lines add whitespace errors.
Applying: t/unit-tests: convert strbuf test to use clar test framework
Applying: t/unit-tests: convert strcmp-offset test to use clar test framework

