Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22791917E5
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162542; cv=none; b=cnqOH/EwoDXT3gqPTIkKAWVVZ8xd2ixoqIep0uOwrB6o2KpdaDdBSWx3C9Y7Cgqwn6agFKDFuhtgdz7frKrtmOn3kF7vrOB8KcZ5yisNYf5lOprzZ5NbdLSTpuZYBLpxwNu4mfrnkNL/1yCX2K/PWOy45M8R0Bz7Os4ZJD8OyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162542; c=relaxed/simple;
	bh=NemyF0YsuLG8l8sDW+v7Wuc/nWacouC6AhAPZLVoL/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yov8ccqgPTdJ/O45ZOTf21vq6Gjzc50zAF60RwgaxM4BYwTVoFuz28QzwwfkzH4Ggg+ynRt11YqznbLv2FJPqZJt08AhYDnCkOywU60QRu7t+AG+Zn58DP3lYt6MIhHGrfM7EkaC2LlZgFtbx2Ui8pfaa0ZNEoAHa28vtPgE0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A9EsdGo2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YCyCUjHv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A9EsdGo2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YCyCUjHv"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0936A114BEE1;
	Tue, 20 Aug 2024 10:02:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 20 Aug 2024 10:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162540; x=1724248940; bh=ge+jrQ1y6G
	NxSL1hcgTEWJdV7JlEon49hwruwlx1z04=; b=A9EsdGo2zU4DNIyBzoAQ+da6p4
	81Q7iliZAcWImFKzLRYzjyUKJ5/nvw4xyIcLKymyW6Auf+I3sxLU/UamdFSE3sdj
	GfZOn+f9sFndyYw2R8kEF36LIaM50Th6dQvRv7nC11SLbwk9wrRlnmZ3YeRMo/Xt
	nNufvF0/EDepGs2awKDG7gbFM3Tfx8WQW+Ts6nUVQYGH+rCa1M5aOsG1iciRnbvl
	uqXURY2KACT/jrOnZpsMmC4CivFEaTR88UozNCgQz7ze8VaBT6N+Hn2DX01HR+7j
	3OaGD+WeqLd0AzXYQBY+xg4bsQrGA4fYdy+xbT0w6U4g3HYFWoZMRN/9lMKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162540; x=1724248940; bh=ge+jrQ1y6GNxSL1hcgTEWJdV7JlE
	on49hwruwlx1z04=; b=YCyCUjHvUhuw2HmUfOz0iCBEFyD0wOkpmaQxdHAcp858
	nZRlPcggcopxbZYCnzzy+7oojcVlORt7rRu6o10ipf5lo/lds718sPDsSscw8qRm
	/8SMHgBpiEz5mkWZXV9Sj6Oft5bgXMUTDj/l2c2/SVgoIOqDwkOaTAXzAh5RLxJ/
	SNJdVyMxoWc0Xv/vMdQxBuXeXPBdDMKhiwWp5pDmdT2dC6UtMNepHEuGKPP5Z2+J
	U6gtYgaIUHqItaQEclA+eROvk6rLwfyKjHnNP8FUsgYs2q1gbl3EZLiK8BSXs/PJ
	FvkXgCdL1Mqvhy17gOWCz9X3UCgd8LnB9hUW39WrVw==
X-ME-Sender: <xms:66HEZqwcmM2uPqwkq_2m5ghaGp5WPxeCwUaupIMKOiuk997oDTUMbQ>
    <xme:66HEZmTZDBL7bzloGnmeR5_pPL6ueDVPhs_OnbiIlWsWK99kPGnKDQZ36Y48a6NzQ
    e7hfoUOVZqZTzST1g>
X-ME-Received: <xmr:66HEZsW_WFJBpP5S4zmpTDKbqQ7xmihXJdeWT5wv9mEHeBcor0bN2iNfFozF8q8_DsEjXKdljWwodPoIMrVGY2lAlxqZ9hmJKPnNs2JBzz_4sElY0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrsh
    gsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehsthgvrggumhho
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegvthhhohhm
    shhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdr
    tghomh
X-ME-Proxy: <xmx:66HEZggRlLAKyh-vKrOIuqkTy00GGXWvLJ5dYcNUGNwq8vIE1s2H5Q>
    <xmx:66HEZsA0_BWe4aE7MIz4Xs7GwUzjpHr_AZeNaf-KiA-jmIuNDYe2Mw>
    <xmx:66HEZhKSrZVfYNL0gF38zo5N0rGFhE3YFKwOe5FuaY5uPrGeShidDA>
    <xmx:66HEZjDvWGPyKUF00qXu_2SUij1ictYN0RhpU0Pvuxi1GKKFZ8BW5Q>
    <xmx:66HEZsuDb9IN1Lqy7hTIfSj08rHAUJLeVQmpshy2XYZo2OPrfJoDnB61>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be675c7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:01:47 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 03/13] t/clar: fix compatibility with NonStop
Message-ID: <5c21aa87aa2496d9f56768b4ce14a2267c763578.1724159966.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159966.git.ps@pks.im>

The NonStop platform does not have `mkdtemp()` available, which we rely
on in `build_sandbox_path()`. Fix this issue by using `mktemp()` and
`mkdir()` instead on this platform.

This has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/96

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/sandbox.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index 7c177f35258..e25057b7c49 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -120,6 +120,12 @@ static int build_sandbox_path(void)
 	if (_mktemp(_clar_path) == NULL)
 		return -1;
 
+	if (mkdir(_clar_path, 0700) != 0)
+		return -1;
+#elif defined(__TANDEM)
+	if (mktemp(_clar_path) == NULL)
+		return -1;
+
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
 #elif defined(_WIN32)
-- 
2.46.0.164.g477ce5ccd6.dirty

