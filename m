Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D02AD1C
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719595; cv=none; b=I/3pMxjZ9amGyTz8+oU2WLX7fkm157ozbETgw/KeWlEq9hd3uoMHcExdj5CSh3iUJd3duCFZtv/X7g5PGY2A80Li7ft+SwnNFdLuXdQIjaZwaZkqe5A85JrP0uJ3282ENfmJFZWi0esRtsLeBvu3ThKozvG85FcjL3ga5GxY8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719595; c=relaxed/simple;
	bh=xGUaiIBKB68hBFBokz4yrg1y+cAZukxV9znEWEUAyYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QT7c/QpU3pkysQCbwcRrLYWLrF01kAZEmono2A6Vl6nvXTSAyzqN7tU1x8ge27LkWnsOVXpkgc9sO56JDSCqJP0uU8Mh+RO9ntsRvmejErlFjrw/X/WLab9fAQJvLqe8rIDiQ5MzscGMgAl9P5H0DH1MZlrCmk3jjKEpReMwhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IImh382x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2+DU7Fr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IImh382x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2+DU7Fr"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DD1DE13802AA;
	Mon, 30 Sep 2024 14:06:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 30 Sep 2024 14:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727719592; x=1727805992; bh=xGUaiIBKB6
	8hBFBokz4yrg1y+cAZukxV9znEWEUAyYM=; b=IImh382xZeR5EvhFqXK4kb55KO
	kWJ8YJngLQetg9gU3ADdrVkx1W75GQNU1ldDJymRVXoZuKhwGXMatkbL025srWxt
	cwOkMJuaZqxcB08qQbfamxgdqiECI7lwdnEnlxbogpM3YqZzw3akZAbUVxz5k5V/
	TDGEBxgZUL3Ipw5uXX3Zge+iJYLwOlF09ezvddWOqyBWHpTCj2z927Idl13Oafqv
	kRFCVhmZPn7va6vQhkhU8E2JmcL3cmX05XhTYrK2DTD4BnzzzyoR+ik9k7ApibZv
	a1j492fSbk0muiDYDJAJ2LfvaS9ouH1S3uhK4EfP6+ps8hi1OKx/+YO/EG5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727719592; x=1727805992; bh=xGUaiIBKB68hBFBokz4yrg1y+cAZ
	ukxV9znEWEUAyYM=; b=o2+DU7FrREdTCnuutPcRbTJs9X2yuolz1xg6A5P/X4JW
	giwyeM4fx9/YbDfJfW9kbdnILJCAhzTw6oGT1JhFd5uDvp4kF4rtpzAzF2L8w4dT
	bb6NV3SsFq2ixUGUUZfckt3YC0zV0jN7olTVIBYWP49XxHj6al6xVd4Z5fb8ByKy
	A5wOCuCUDkwtZKqUhWe7tU48gIp+G8YrXkf8PrqKpvcUiHzJMWCd5rF32TWtSxE8
	w2vRri3knvhlEoVvGccwcr5FXjrnvM16jvGRvWbMNPJLneQ3joUo/XdQfcMGQ49o
	xwrEiLnLRWeHAUf6O3fToo3wg7705bpPWtKJzg+wgw==
X-ME-Sender: <xms:qOj6ZgDNH9rhHGtNRyz0zg5rQTbgKGJ3D0JVA1ZLBm3XGzbkVViPUQ>
    <xme:qOj6ZihlrrXEkmvfecW2QA6dl-cAeXqT9lYWvzn_bPMZ-fmuxHFrsXBzDRiRpNhby
    xgmzLmQjBC_QQvjAg>
X-ME-Received: <xmr:qOj6ZjlaY_ImgLZHefE6OhtIpFYOz4sn9vhCpBXqzqW2HZlccqd2ibK35DCK0ADbFwRJpqkaLQhqg0mEeRtjwoVf9jowenm7NsCpZYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qOj6ZmwMzFbno-IZbIj1imuFgLbAOKbWxEUSpYl8B3TX9GPFOEIsYw>
    <xmx:qOj6ZlQW3p9rMBhMUz-LJbRi4zT_qdUmEqNKxnCascMPAL_ui8clVQ>
    <xmx:qOj6ZhaW9Yd7iQVgrhlJNdT2Rpw2_TxmYaOBwi5P4GzY9H74B35ycg>
    <xmx:qOj6ZuQ8TmtI4dCxufasET6VCmRSyt-cmUYMEjFYpRn735sUc7JNgg>
    <xmx:qOj6ZuKRXbhsVxq02NzBNsd_3LH5kc4jMXD7Ixj9-UJn5f9AML2qykJ_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 14:06:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] cmake: generalize the handling of the `UNIT_TEST_OBJS`
 list
In-Reply-To: <0121a34f-6a32-aef7-92d6-e11521fab2d8@gmx.de> (Johannes
	Schindelin's message of "Sun, 29 Sep 2024 19:48:32 +0200 (CEST)")
References: <pull.1797.git.1726687769585.gitgitgadget@gmail.com>
	<xmqqsetpx16k.fsf@gitster.g>
	<0121a34f-6a32-aef7-92d6-e11521fab2d8@gmx.de>
Date: Mon, 30 Sep 2024 11:06:30 -0700
Message-ID: <xmqq8qv98195.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The longer-term aspiration is to migrate everything to clar-based
>> unit tests, so the list will hopefully keep getting shorter and then
>> become empty (https://lore.kernel.org/git/Zt_lLsnylKJ9uoqj@pks.im/).
>
> Once it becomes empty, I will have to send another CMake-related patch
> similar to when the `REFTABLE_TEST_OBJS` list went away, as the CMake
> definition cannot handle such empty lists.

It may be ideal if all contributors learned and updated inputs to
all the build process options like cmake, make, and autoconf at the
same time as they futz with the code they build (in other words, a
change that makes such a list to empty includes cmake update), but
different people chipping in with help in their strong areas and
polishing the system as a whole as a collaborative effort is
probably the best practical alternative.

Thanks.
