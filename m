Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0EF4D8DA
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958049; cv=none; b=CRZl6BtA0KgRWPuaJasJDvsepLuvZvjcUD4nHBFWNMWxBG6QShpoYSScTJw4T0AyXEuKep5GlPP+uOV2uDlwQXf1gHPCRuiRBpRrBbJs2GdpWvZpOrLm8Hrp9hNwAfdO750orXDsOBaNTp2/+cS4mj42+gfSkU4nZIMI/KxwnbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958049; c=relaxed/simple;
	bh=MEuVqp9z7txwQiQsgsa3/qJYmxEg0O+6Of9v/WHUFF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dE5BVYJxBmJKewZpzGKXbnGaqi1kBD8O5m1XpexnVg4mfUKNOAQorVh2xUIKowh36Err7Hkh060DUPP7iE5StQx4kiEyZfMfUb/LxK5Jxa6SHy1ctoYSX71dQ/JBQ8ncbtHOVE7oaG+XRyaZmZT/OwAwgHfmqQ+kWXNEnKm7PpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e2kYsr8a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmyLLs9/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2kYsr8a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmyLLs9/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 315742540209;
	Wed, 15 Jan 2025 11:20:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 15 Jan 2025 11:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736958046; x=1737044446; bh=7S+YJ/M6K5
	FtJ3BTmvkSxaI8jyAyFd2qjzt9Hf3g3qI=; b=e2kYsr8aUbu3Yjtvj9i0iJS6sH
	Ve5uH/SWl/ta+UBrPQOphl/DoZ/df9MFUewTuEuPGqMAqo2LGQoBlxwjzoGxxxcB
	khguyG3eLdHkLnQcUykRdyRj01eMi4HbfsO618D0FuFBpdTQEOhyli1y1/ZAeMjm
	61asJXeMs6z2lHRe52VxPug8QSWKkBMyXNsrLidHR5h2nDi8+bI2OhK88yMlrDD+
	yJNwWpsPT3yEaQ3KmPTSN3VXb/9OMLcxbIfQmKM1oAV46T68xenULcFYXNYuCb8n
	1DR/9QGt6DPFRjjIh4ixsPFDLqCHnRcKzxv+uzC5RbZZkmVc8HgMvBODr17w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736958046; x=1737044446; bh=7S+YJ/M6K5FtJ3BTmvkSxaI8jyAyFd2qjzt
	9Hf3g3qI=; b=QmyLLs9/WHqgAGOPgKxGYjHNWY+UszyW0c9nh/LZFFv1hjehWqR
	1n88oBKiki5M1g0Lo4mx/QLuAIpisYSZ5aGo60k8lF6m0dFIVyoDaqoKhfZrcXa+
	CqmNtmm9TvskmRBaDh89dJvTYQ+LzofIOGKOj5oH4+Zkq3b9KaqfTaFGo0ICaIG1
	tIIdZh0fTv2eUa6AhMQfzsmKSXIUAmszM8XiZqaWtJQdDRq6CUUEmyTRDRt0B1SY
	1lW8Qq9nQelPjxypM3bzEXv/hM++lseCHSiEddR7Dkf+oFV9LvGjZdSxHq5RDGaC
	b4sdD7YhYIKOofinUziE8nibnCSnNaB7Bwg==
X-ME-Sender: <xms:XeCHZ3TDLDrTTT0GIpBDpCsSN1dTmACRKqxrNGU5_Jwi-yH1uc5cNA>
    <xme:XeCHZ4yMjwvwRHgugwVvhygsHOeI-luzYRPguQ8xGDPfQYH3JNhojcj_RmIFENPJI
    -kVubL-aPXwUZTzMQ>
X-ME-Received: <xmr:XeCHZ8331NRPORI0uMHjPRQWwut5obp42HEtcrzu9-inTLwmq9GJdi9GeE6-5Vt1o1mGKSjIWb0vQxCdL7vD51QYQNlD7E04oB4r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhonhhsthgrnhhtih
    hnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:XeCHZ3AcL3GxFWPrRmYbTE99nRwYyHrBQaSc8zwoSB9DLrztcfP_FA>
    <xmx:XeCHZwiAHxiqJ_77shYI1xrfMirjTZpmODf0UuCsqoJC0gwFEh43nA>
    <xmx:XeCHZ7pPtwpqqCo_vcplBVsUmwaQVafb_GRzisRR3dTuTZfa-obTZA>
    <xmx:XeCHZ7ifw38-OfG82CQ416Xqi4UO16H0i-F-yV2qbSJDABnWy7bXhg>
    <xmx:XuCHZ6biNqP3cKO6SN_dKjOEfA1BL-oKxLnwZB5waDojbhSr99A5n9f_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 11:20:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
In-Reply-To: <20250115-eccentric-zebra-of-hail-c22ba0@lemur> (Konstantin
	Ryabitsev's message of "Wed, 15 Jan 2025 10:50:36 -0500")
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
	<20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
	<xmqqjzax2nqw.fsf@gitster.g> <xmqqa5bt2jc8.fsf@gitster.g>
	<Z4dLeyF8N8PhYAZq@pks.im>
	<20250115-eccentric-zebra-of-hail-c22ba0@lemur>
Date: Wed, 15 Jan 2025 08:20:43 -0800
Message-ID: <xmqqsepkyrok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> I'm not sure why --full-index was added there -- I don't think it's needed for
> --binary?

Correct.  For the purpose of that quoted commit, giving "--binary"
should be sufficient.  It would avoid "Binary files differ" that is
useless in the context of format-patch, and when a binary patch is
given, it will automatically get the full length blob object name,
without --full-index.

Thanks.
