Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B881F875A
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759075324; cv=none; b=GHsCVTNsxbwc0McK1gVyPfWDBqPfcff+Bg9lRYZ0qZF2ILpOrBeflIw1bcTd3mjBDxd+eXvDkvI6y/mS4i9l1Ex9/eMwAlRI0m+m+YUKVck0PQNMuuAeuv5XAUrfTgry+gNShwvBZBGhaKyesBCNoJBxWIC3WHU272p3iSmFkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759075324; c=relaxed/simple;
	bh=91ZlvQouSepdJpUvrfLby3t9Iyk6F4JndARpGlO6Oyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KGVV5Lta01+zZk5OOcxNfwycvyRsZ8nvm6uoRWP61RR1UU53+DOO5omSUrNQH8Oa/4dwhrk/UoaA6znofYURX1fBPjJtSPSSGc4alojNlxUj+cNcfz0aQoBmstT0pYARoikXbCEePnte4jsI38Q1BuA0LO+t4N0ofEpEih9e3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Exl3lrvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=do1vfltA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Exl3lrvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="do1vfltA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B2D927A0054;
	Sun, 28 Sep 2025 12:02:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 28 Sep 2025 12:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759075321; x=1759161721; bh=0WXu6CENnX
	3Y3OXhKFHASXB4VPpqTN3jB+bswH6hDyk=; b=Exl3lrvGyFG8aG0WMnDD0OE0ol
	uqnyVcpIsuEWFI7Af9oMbeCBkYRLxEJL/tPmJeBXtVPafwwlmGYRGukwRy/S+YDt
	e9i9zOqG/jezdBFPmmMaLRVK7JXWjWeRM4Vk7Wb3wE/uj0mXlnqTrxx1DW6n3v1c
	fNYn8sE8BkeNGiJR7pic+kl/yQ+wHRae1ClvRScQoTjpwJqWbmlARGQERxDeLOMT
	iYCxUYN8Bge4OCcnkA5U0oK2SSwifsvSh5d6SyMK+NmKDXja55tVxWa7bL93R62L
	Oz+wQ2vBQv60ImjnipZ3MqsfI1+I42s5vxcxys+rOTx9qdARuQRfB0jupPxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759075321; x=1759161721; bh=0WXu6CENnX3Y3OXhKFHASXB4VPpqTN3jB+b
	swH6hDyk=; b=do1vfltAfPgXfygOjvcuHwoxFi71+Rm5gFSWH2A3JlqeUTKx55y
	9g6j1pzYH4gViCcmvhhY8JENua6Dk9UfMOVWlvThtDk+1Qmp8SY2qVXGheGxinvO
	Fv3IBk/ksQu7VWd+7AW9j+b/qyuzmTj+s8WPcdo7MX26Dim3qHQHWHkJ8gHvNQ9K
	jlHyF+4tFqc1wVZ3TE6yJ5qh6GJZv+4Vs676PBrUoU5BC4BT9Q6vAOsRENFhnu4p
	XikRW1K0uAT4JcI0UzPg5ZiWhOwi7FgdEgWd0j9qgmnfXXw2l3knRfrqDDEJWEot
	5CY152oKddx0bW4LHfcT6yRYv0G4Ulgk2eQ==
X-ME-Sender: <xms:-VvZaMF8V2e3s_A-1pQMyLzRnbSIkVISbubsa8YBElZ6lBWyuMO4Rg>
    <xme:-VvZaMVEcF0b5uyOf6bkqKMNKtwekWLQKc9ltRLh5LppyMgKuCOolrXPqbejTa1e6
    1YhzZ9WPdjC7g3GOfq3AUiDWtSuutA5HUnOg-sTI5sia5G4fKxlNA>
X-ME-Received: <xmr:-VvZaLJTHFBRESy5Two2vtEbCadds4WO_x28Xzy9pJknewZkLYstypwExnCUmJRQtjaYmvIEeKLUOwIX5jxK1QKF5DcXHrxYWA6F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghu
    ghhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:-VvZaM-ceewyrqS7yaVorUcbvUYsyUzZ9RVjkHszPvPnSPD4BvbA8g>
    <xmx:-VvZaOLzvrA0l9DsUz5uV_VTvooc5pUL-Puzz-8SOSflk4wpnRBAuw>
    <xmx:-VvZaBkxWe9cBc_NIPv7IuysgMme7c_7t8S2mzXkQ7xljaBrD_EnQA>
    <xmx:-VvZaCNxDYRTQLXqKtMyWuOgExj7p4Jjml8wHVQ0s2HdhBiPWS1P6w>
    <xmx:-VvZaByJdyIabVy0h9lGbdyUmi6ASy8KszllgVTqgA-FPzo2bIw6vsQH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 12:02:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: patch-id: fix accidental literal blocks
In-Reply-To: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 28 Sep 2025
	16:03:08 +0200")
References: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
Date: Sun, 28 Sep 2025 09:01:59 -0700
Message-ID: <xmqq4ism7eh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The options here are apparently written with the assumption that you
> can continue a block like e.g. a description list by maintaining the
> same indentation level.  This is not the the case; you need to use list
> continuation (+) for the elements following the first paragraph if you
> want to be guaranteed a predictable output
>
> This is kind of subtle since only the last paragraph of each option gets
> rendered in an unintended way, namely as literal blocks.  This is easier
> to see in the HTML output since the man page output just has a slightly
> larger indentation on these paragraphs.

Hmph, I've always thought that the practice breaks every paragraph
except for the first one (which is the same as "only the last",
only when you have exactly 2 paragraphs; when you have more than 2,
it makes a difference).

The changes in the diff part all look reasonable to me.

Thanks.
