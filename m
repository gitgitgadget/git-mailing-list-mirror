Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685635B658
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667441; cv=none; b=SdeCBFj+31f58j6Sy9V+de/pXW0P7HDN7PYW4IXOfDnyfb0gGRPDI4T1KPTrOKxazeMIqyHhyM75FLaCvsbNxau40Hsm9pp+mlUyOSM3761Cwstq9LILAUG6D8IzyaKKhfGlgfO6FzVUkufTUbtoJpo8qpNGcqLcPnsywvIfvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667441; c=relaxed/simple;
	bh=ogJKjDMYMzpSj1Oa+501gmFgKCgaPD2tytI3IVjFMUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F44dbdRy+slC7JMDbU7yBjx9gnKNkrU+XBRT1NnFqwkkIa+GoBExjGYhSTzSX7nQdA3jz/E7SPJ+pn4914YSDedmeLrWcwNcFNem3IfgY+qO3QuOThFvluizEiMcD8AZeCFkPSxdsK4OPVgkofYO6FTPAzM6kuW7bM2I8AfcTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=et2qBU79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DeAhLAMd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="et2qBU79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DeAhLAMd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E696EC01AF;
	Wed,  8 Apr 2026 12:57:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 12:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775667439; x=1775753839; bh=fYa/ZveAxn
	DfGmvS342JtGfS5bNld09wBjAd1kvj7AQ=; b=et2qBU79gvVEeN2tlo8OfNc6dl
	OES/SL+zfJOmdMW7XInA59lSzHrFBIXH1Zjm5pC0hqh2sBc+SmqVpK+qvxAJK1Wg
	x/CDXzZB00HreiObM7K9w/UxR4t11yUPKAAtSD4JED+neCrHKcWusScnDv0TUVvs
	z/xsyaX00vn9Fnsp4PGR50AI0jtXZYiBZssIJYB9YUH31bhgGHHf2Eg6VtXUPe5x
	kXfvhNVSlguImyFKZ8qKlPhC/9yf24ovV9Jw3MxAZ6fP5cKeytRvxTMdMCfc57WI
	KdlgYYkSIQy7nafQywLiY4aKv+02h7XZypKI/AZDQHl/Sqj6QTisFOweFR2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775667439; x=1775753839; bh=fYa/ZveAxnDfGmvS342JtGfS5bNld09wBjA
	d1kvj7AQ=; b=DeAhLAMdOpo6JuPXSs9onQONuCa1EOvWDYvKsmjL3s4ASnWYEvb
	tkJ/LWwlxfiei/k7KZm/qAbMenDQ7GBXsroo2Nkij6/LviqzsvplTWJgWUN4Xz7O
	32v3hqw7XDorc9HpB7LChOlXyz4wFGlU45M55mCxiLwhuLVjO9wGBJBtYGWq4eLa
	Q93GFQRwekzWW71ST251bmT3+mAIxtH+FtN/gOuaP9uZ2YsaY8urDlgFCV1rQj+3
	ppuyyokJCiZIZWaOkE7FbZttgMQ3BNfDuqAfXSOp4Z+WjxZ8SjeMEmIkX4ZoH6hU
	Oln1wPbmThvJh6c00sUjSKS9U/EUSf7BX5A==
X-ME-Sender: <xms:74jWaatEQrd_ARP64l6rBQ1QcyX09YLp2F2cYU6nKIltM7VhSt5dBQ>
    <xme:74jWaSC_QFvJOL-y1MvUkz8oB3GzAEiPhphI8Os7KscyDHCXYD1mBUuP43OcPnW3a
    FTslK6F1z5C08M3ClLAJpoJVrYUuFmNJUKHYstxPfAQkwKfMbHx3A>
X-ME-Received: <xmr:74jWaZb15X6xGiAQxorWOiaTtEAnWZBPawsRZx-t-lA9kX01zFdWOZSgETln6D1Fo5UZqkj-lWnbVYqg1-ASlAZwBhHOf19Gwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhr
    rgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvmhhilhihshhhrghf
    fhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:74jWaVUKYyobffGdWncn6ZwUICdjrUFhFn7GbfEIcvoEp0ISuEo5XQ>
    <xmx:74jWaQP0T8WDSqnpjH8OiuMn8LYwtVoozjNYGmCFeTVy57NXQWFilA>
    <xmx:74jWaXZNq3acagRCICJR_WRrPcWinaHzbTQXpUkltJAm4WDAxcpubg>
    <xmx:74jWaX_7VvT7UhEXbgPUD63g2Gs5uv_e6oY8RfU1KNoo6nzgQ3-vVQ>
    <xmx:74jWad7LNP99iGU_w_yEgErTPlb1ycjGrYzeIcscHX92re1WSFhV6kRP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 12:57:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Jeff
 King <peff@peff.net>,  Emily Shaffer <emilyshaffer@google.com>,  Josh
 Steadmon <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v6 00/12] Run hooks in parallel
In-Reply-To: <adYrKgEo24M3MUSd@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Apr 2026 12:17:14 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260404082934.173788-1-adrian.ratiu@collabora.com>
	<adYrKgEo24M3MUSd@pks.im>
Date: Wed, 08 Apr 2026 09:57:17 -0700
Message-ID: <xmqq34151jbm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Apr 04, 2026 at 11:29:22AM +0300, Adrian Ratiu wrote:
>> Hello everyone,
>> 
>> This series enables running hook commands in parallel and is now
>> based on the master branch because all prerequisites have landed.
>> 
>> v6 is just a minor refresh which includes a meson build fix provided
>> by Patrick and fixes a trivial conflict with the master branch for
>> that specific patch.
>> 
>> Branch is pushed to GitHub: [1]
>> Successful CI run: [2]
>> 
>> 1: https://github.com/10ne1/git/tree/dev/aratiu/parallel-hooks-v6
>> 2: https://github.com/10ne1/git/actions/runs/23974475271
>> 
>> Changes in v6:
>> * Included the meson.build patch fix supplied by Patrick and added
>> him as co-author on patch 10 (Patrick)
>> * Fixed a trivial code conflict on the master branch due to build
>> scripts having moved into tools/ for the above patch (Adrian)
>
> Thanks, this looks good to me.
>
> Patrick

Thanks.
