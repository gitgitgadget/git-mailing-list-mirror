Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF23085A0
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270044; cv=none; b=AK1WbsPsbEUnO6WaDkbodgI7qqtSSLQ0kOgo5jxlU9GrCylBXMj/bUV8XgTectdqaYJjog+JjoGxiasWDc7LJwrxSO5wmD9hJd8RPy09vlcTiY2++5/n5tAH5C8Km3qSZSsbXJeTK3CKtGU1ug9vLwtdkroRhfoViiVlTDx6Hvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270044; c=relaxed/simple;
	bh=s3CoS2LqmfpYSZilJmal7LWIEWQSj+0snIE9weeE97Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PW8PdMxt3PAmyVeZCU1crhqtFtFJX7Ov2bqUGrEuT36SP+bOvukSVtj/8osTwxNGjH0BFF6eCCiM159RxUv6M1ulSG4xUHEyXG3Psj/TwSLg6ikYWp+zU8SGhrVEQHZR/PXPlR4y1mW2fG8hjdf4phbR9Xzlx0HtMmbrObw7kjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZAm9l8XF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ehVF1Wre; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZAm9l8XF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ehVF1Wre"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 008A711401FA;
	Wed, 18 Jun 2025 14:07:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 18 Jun 2025 14:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750270041; x=1750356441; bh=7pNS2QaiRz
	pRGO4Wy4wpax3TU8XbNgyiYNC1CbmdmHo=; b=ZAm9l8XF4i+Cg+VUncLU+ReTjb
	9CffHEHusfivxI2A1cGyj7ctbsO62db1Cssec1BGLvKjUkokaVsoIa8tvzEr9Ru3
	xdn6N5rZsuIi+TPcv4q+3PaWp7dZmilJkArzlfpKIMMXC8D1snF3TZblfCAnW6Dq
	wkdsVzC0A5hiw1uunPTMkwGde390Tt+LEBE77FJ22vFSOQiKECRfVq+dAyoDYv6Q
	v6Yzr0kYHNIJrYDh+5mbmdMY+WcNaEgZH84XOiS0tsH517DhSGlNGkQjxApsPr0T
	TJYj6gX8vJdAd1DfWr0Y+/lY5kqnV8H25qkjedAE7EddwR0G+fjYKIJ+rmFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750270041; x=1750356441; bh=7pNS2QaiRzpRGO4Wy4wpax3TU8XbNgyiYNC
	1CbmdmHo=; b=ehVF1WreVSTQDyq5agTyGf5VWhY3CpghD488mNkXt6bcPV2Bgc4
	60DjbJCxOvAUcegLqLs6AL+PfG8shJB+70oD74sFp3n03P3KICCdfTzBv9MyPqj2
	kerOtssqLuu4I0EUPTIYqzM2bcHfXV69KdpJMOcYd/fbWUt8xf+3LJ9VYgbiHdw4
	PbpQ+aLaDQqZdTVzrMSsATp3su7cQmWW/kggyGpEvanShtXVpYenX6x55H15dys7
	4sQql55Bm6GIdWumdey6Kpffplfvvk+kDl66pDMCTueHZ8UX0WmwhblQp3vTadTg
	vPP15KEbuY0COs5I6/WSvqyr+A2P8OvK/qQ==
X-ME-Sender: <xms:WQBTaIbPWztcC7RDChuFodfBAiRJ_xC6NaDTaoAg3eiSTJS74g-qAg>
    <xme:WQBTaDbcB466w6QwoFNNiOWFg4oOzzDykn22jXw6uv2X-D4B7EQm66awhB1GIPlq_
    UUbolaWFG5rdUwHjw>
X-ME-Received: <xmr:WQBTaC-fWVZOyY9R056Tif3c2yVwstA9hBn6iKWQBro8w5gpZJ5iJHxx-dqNYjgi6AKJRmLPhePSOA1j_9fN4p21IspMoqXZ7y4i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeffeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WQBTaCptZA8IcNegyrMugGo2PLK_F79or-AqjteIqVBxr_4J_NEWlQ>
    <xmx:WQBTaDr70RL9806SS4IMzJ6elIFyjhCoPGwcJKZxxGUkI6pmeO67sw>
    <xmx:WQBTaASwfBGDTK1nq2b38tIIU44a1glT7YwMvaIqRsIDkk6Fc7N9SA>
    <xmx:WQBTaDobiKYzlHmLoxb2SPrcmSvR_pIAm5fd3GZE837KJkXp5WXkAw>
    <xmx:WQBTaK0wM6m8_TFMwNu2_X0UeKiRixYGDyH_Igl1t3KXcijKb4srPfS8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 14:07:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] cocci: do not directly access the .d_type member in struct
 dirent
In-Reply-To: <xmqqbjqlexzd.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	18 Jun 2025 10:55:02 -0700")
References: <xmqqbjqlexzd.fsf@gitster.g>
Date: Wed, 18 Jun 2025 11:07:20 -0700
Message-ID: <xmqq4iwcgbzb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In "struct dirent", the presence of the .d_type member should not be
assumed and the code should instead use DTYPE() macro, with possibly
a fallback check to determine the type of the file.

Add a rule to catch direct access to the .d_type member and use
DTYPE() macro instead, except in the emulation code paths that work
on platforms that do have the member.  This is probably not sufficient
to notice the lack of necessary fallback code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/dtype.cocci | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 contrib/coccinelle/dtype.cocci

diff --git a/contrib/coccinelle/dtype.cocci b/contrib/coccinelle/dtype.cocci
new file mode 100644
index 0000000000..8fe66fce95
--- /dev/null
+++ b/contrib/coccinelle/dtype.cocci
@@ -0,0 +1,8 @@
+@@
+identifier f != { finddata2dirent, precompose_utf8_readdir };
+struct dirent *E;
+@@
+  f(...) {<...
+- E->d_type
++ DTYPE(E)
+  ...>}
-- 
2.50.0-228-g6e205fdad9

