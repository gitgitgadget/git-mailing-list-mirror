Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12DB318BA4
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099649; cv=none; b=YpEs1Z1MVS0w/loplztxg8RKWzRIltxb7aYcbZMtqu6Nns2SG2Bu2cKgNXEAU2mYOCU6xP5zmL8BlpThTINkOcVeFPKGIfJwhaGOKJmecHCESX0/+kpoIR755AyeSusVNwxjPVkHI4NPaKVBx/hk6Co57+ZUTylFD/RQdbQ9Tb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099649; c=relaxed/simple;
	bh=kK1DPsiyAA5p8Qy4iRpwVl4B4Gp6Uj0037RjjKSg0OE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KBMmVxuonVzMELYxu9qfJxJQDcvUU3lDFD0NWaRE/ex3NeTaAZEGLTk1upw6cFFKyMZaWaK2UsfxSLvoVgLKUNRz2twuZBU7/E1bfZW+o5m8k8iowLQ3zaAgg1eTspp0HWROkqVlK5Ih8liTzsOVL+MgKixP/8xFuWLnQoJ2uWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d2rRY8kq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4Egekqe; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2rRY8kq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G4Egekqe"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 207EF14001B4;
	Mon,  9 Mar 2026 19:40:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Mar 2026 19:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773099647; x=1773186047; bh=K5RCsF3lke
	yBO1HAyJN5zFCWmJ8P5yOmhFjUuukEauU=; b=d2rRY8kqClAtGceadod5UQ3o2V
	dJjcwMp//tdFj2RnxRymJX6ypRwrQQZrWM9IbppL5993knnG1sMt53uBGkybC+t0
	qXy6H46Dtcfl5tUNM32e6sQxW4YSlcZMJw1J2THtIreiV14Lj1PJAgJX8J9dwVsu
	zF+kUJg8DwMfdA31G+Bkdmg3Y0IXX1llt/6qxZsEMpWIOFSzY9uo9KuuD5aK3jtK
	IoxznWv6y928uNyTI/d/Nrx6RPQnhRKD6fUILgkPx5d3zJY6y8C35obRKz/2zEgk
	CgyGlGuyc8wnBf3BhRyM48UVDFeqEjIGxmOqr5uALysOFhR9Oq393K9mRpJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773099647; x=1773186047; bh=K5RCsF3lkeyBO1HAyJN5zFCWmJ8P5yOmhFj
	UuukEauU=; b=G4EgekqeyTHeludFAc8kyPlYByc6503TojZrM127vyXvpgqf5Dg
	rkec2npI6qhzwLCxzdb+WO2GJgba9RP46ijmHCO1doJZzN+xycPEOoV2NFFFqR8r
	vyltsf/omSnJAUiD3ojYy0eKb68HuGFrXBnwhMefhBofkKr3KS57NKM5m32NHfXW
	D+GGPv4dKQR7rypHHeWP8eXmdX1972dS3Xw9exKtQpABLdQaZdGBCmkZC0YvF75G
	NVT0mmD0F/sEg3Yi+4a1EIBNVUfABZ29mpc6kRw9kD+LDxuR5t5fwzeijOgBDQDA
	6F5qE9dejv2wx4pJYry0pZrXhMNXPCo8a/Q==
X-ME-Sender: <xms:flqvaQI-ao5hWP3_WXw2ctgEhE7_HtxCJ59yAVHqJAOz5HUbH9UPXA>
    <xme:flqvaZeit-Ci7eNL_typSbftTomnpcNX4iDBWkShSNppndZttX1eWhy9z3fnXvLCR
    8cFHW3igMUy2d904-OrtaSnNK4NXqSGVrRAxf22P2M2Y1T7kMSqWA>
X-ME-Received: <xmr:flqvaX-z7eUukx_EpuchX9SzaXWsvCI_PkM444s4Em6cTMzWsUhmambCGFkg6pixfNeNCW4-2UfxPXzJC78qBDLHJXaXRcaQBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnrghsshgvrhdrghhrrghinhgrfihisehoshhsrdhquhgrlhgtohhmmhdr
    tghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:flqvaeqlvZ-O3WTF-WtdY74-XX-d4W5KMFHb7blfJj59avf9aVXQKg>
    <xmx:flqvaUBXkFTU2CXWYHGp7Mxk1OTVuLSY5WU9waC7fTV8OZasqh4YXA>
    <xmx:flqvaYyqpp3YC_dOq93GC_HVYvCY6ekh0cUPiKfJaPAgB12Up9MEEw>
    <xmx:flqvaZ1BhGljh0dcBDTkmke9hDsi1RYKp9aZAfuptmVRmbXwdS-Gtw>
    <xmx:f1qvabMaAvMLoAlIHZmP0ap4Y05fNA1tyBTkY3KQ9LPj11cQOWq4Lpe6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 19:40:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Jacob Keller
 <jacob.keller@gmail.com>
Subject: Re: [PATCH v6] submodule: fetch missing objects from default remote
In-Reply-To: <20260303234044.105157-1-nasser.grainawi@oss.qualcomm.com>
	(Nasser Grainawi's message of "Tue, 3 Mar 2026 15:40:44 -0800")
References: <20260303200906.4118348-1-nasser.grainawi@oss.qualcomm.com>
	<20260303234044.105157-1-nasser.grainawi@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 16:40:45 -0700
Message-ID: <xmqqzf4gzi4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:

> When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
> added support for fetching a missing submodule object by id, it
> hardcoded the remote name as "origin" and deferred anything more
> complicated for a later patch. Implement the NEEDSWORK item to remove
> the hardcoded assumption by adding and using a submodule helper subcmd
> 'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
> succeed when the fetched commit(s) in the superproject trigger a
> submodule fetch, and that submodule's default remote name is not
> "origin".
>
> Add non-"origin" remote tests to t5526-fetch-submodules.sh and
> t5572-pull-submodule.sh demonstrating this works as expected and add
> dedicated tests for get-default-remote.
>
> Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
> Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Removed the fetch progress output comparison from the tests as the
> ordering is unpredictable.

This has gone quiet.  Shall we declare victory and mark the topic
for 'next'?

Thanks.
