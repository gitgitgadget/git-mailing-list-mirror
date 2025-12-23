Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B51D555
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459801; cv=none; b=IQBbmnXSQgh7DbZr4Gh0vBptcNCnLFZEzA+jM25k2nl8HrnYtmaZ8Gj0yMG0NM45ny+913umlBlRTks8laDxuTq/ksJofnSZlfawv3gdoAUm+/CncisU3k8c+4/lvPPX7IzZwzpSVNbsnpF/pYaI0pR1A9daRYoD0dRjpvSWOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459801; c=relaxed/simple;
	bh=rDejGN0QrPMYeHusrSGA/hvuNMo8iF9ERZcAJWgFLDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JX2H4frMIRppEDjuKBERjQ+9AN7U7BZ3xNxgMm5yBuElvEDSupdQqolO4/6vhpHe5MnpwDepM0jb+hUmtzObg0nzTe3uLPyARyuqER5IEEDOnhM9BBuneD986etNRh527hfd7yKFuaB3gSnyudCr0kVzOPY01QihNH8EzKN1944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DnnczdJR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PI64GLru; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DnnczdJR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PI64GLru"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 026CE1D000FF;
	Mon, 22 Dec 2025 22:16:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 22 Dec 2025 22:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766459797; x=1766546197; bh=rDejGN0QrP
	MYeHusrSGA/hvuNMo8iF9ERZcAJWgFLDM=; b=DnnczdJRd0hmnQw6VioLC3M53u
	+V8uGc4OlWv6w/gjfz1vJYjamjHZG2OPP4wNSqg0Z3sT95NhBSUZtdhbIH2LSSwI
	X5ve2qJJQKL+CZDazXzY8XEoxVg6H3Was3ldnjgo+CRtW7RX8Ia58x/fdPQfaNMV
	Tl2GJA8fIUUhnjBVHq8EwxEo+5JIMDLtyQ8D7hg/1x1/hS3TKTvAVg/tsnFiUc+O
	ZV6iQsimp3xoSaXlOLhlgdckcQ7ISc0vbuwGLeiUA4XOXhkHHCITrGDytwIv6S6q
	Sanw1ngw1aH+Qb6wuN6pqQHavPEYMJBq/lzgDgwAZ3A/jZ4aeF+U4pp55NXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766459797; x=1766546197; bh=rDejGN0QrPMYeHusrSGA/hvuNMo8iF9ERZc
	AJWgFLDM=; b=PI64GLrutrKglsml9/K/P8RYaE/bqPoltps/GGzhihuiRUOf9fa
	aICVMJmjnmSDUQQ5FqyYzRt25Amohx/F2Ff/bCibtzybWiaF1XaU30Cl6hk9lE+n
	rdZwxeIkMe7WMlfIrAzHHk6KDvyylnSYYhD4rk5KB6vls9h2x973msHcks42F5Tv
	etZ/CKhJ3IPf93C7qK7Y9wHlLpaQXn9ZpLnxwv8/rzIxyZmpRP4F5pjdlrQijAxB
	YA0onlKOYVrzK+JOVFiefjGB7k9MLtX4fzHoDM4Fe1jWOS2sQQUQmD24fmh8VWHh
	eMa1Gadn+7z0wgfRkTorQsucy0h3n79gJXg==
X-ME-Sender: <xms:lQlKaQD2UD9B0Sx7JeERgGIlF-4PAK6g77tGu5wQX3_XQ3WKaAK6RA>
    <xme:lQlKaUzCSnm3r-hFN_5RCy14IzIfcd3tlHh9RP-_c_bHhJxLb7GDqfcV1DBxwYrcj
    -KJHfUryEmk9_yELVF7hkh3SU7DKaNlimOlZlBqlFGtN65VmeGVvw>
X-ME-Received: <xmr:lQlKaV3euMAqZw_72ets0wNmh3JHlbbAI6NNakzPqVaiFK-S3rX2YZlLZFH9m78n6kso4AL8gi2EPgQ2WYGYXXKQEflICS5OEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehkeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthh
    grshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:lQlKacyp6VjDRo1hxGTGPyePssq4NgiqrnQXgQiJY79aBQxq-zqRDw>
    <xmx:lQlKaUFoz4F5DGw4PfOHIwKADa9iHlWU18xUuQYJf1tTJKBK6cjBgQ>
    <xmx:lQlKaXYpM2n_g7cN9xtl0pRR6MyjO9Qngtt0nc3otRE4Lf1LxCln9Q>
    <xmx:lQlKaeAGq8JjBWRbF-jfpQUvzdRKpvR64CQIN20uzZ3NgzxpzpwVWA>
    <xmx:lQlKaTkNTpZYxNIVCz6ZsR_6f6oDxuNA7NboqWBYqnxcBksdyg1UeS8V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Dec 2025 22:16:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  christian.couder@gmail.com,  newren@gmail.com,  Siddharth Asthana
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 0/2] replay: die descriptively when invalid commit-ish
In-Reply-To: <CV_replay_die_descr.13f@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 22 Dec 2025
	23:04:41 +0100")
References: <CV_replay_die_descr.13f@msgid.xyz>
Date: Tue, 23 Dec 2025 12:16:36 +0900
Message-ID: <xmqqecolrip7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> Subject: Re: [PATCH 0/2] replay: die descriptively when invalid commit-ish

"... is given" or something?
