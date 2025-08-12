Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709672EA749
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992485; cv=none; b=LFrX9z2KPR+KnjeS+DDEIS2bvZ/P0Drp/Bgn0LxNVSZCGPis5EsZ9NePwDWgDO4s9/sv9uqREsJfazl5U7LWuPZI6jkS6liQzo6v+Hf4OMkuLHDKc+Yyxx1ulHjYeWhdK/pjWJ3+C06aQVzEqhUJl3xVKmLXwk0DUoLxLc7PfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992485; c=relaxed/simple;
	bh=+wj9Kv78QAu1O9dgoTrQnpd/U1hPAs7GDDUUrrylm7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S11Y5xFHgVuYlxV2c5PZXjWnAYAVfKmdNGWUNv6tAv/2n2j4sfwJDrWxHAL+w7YixdzSsW76ThKzQq7zTtAYDYY62tOEmL0s+zX1NBDTFNOl5yX6tOjuIHeimnSnDCi5oXUGERME+xMPIGL1osa7cOwSGS4q3DHvXO9B5zqiMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BUvQC+WZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GUvgJhq6; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BUvQC+WZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GUvgJhq6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83B3014001E2;
	Tue, 12 Aug 2025 05:54:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 12 Aug 2025 05:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754992482;
	 x=1755078882; bh=YC2bskHz8PzI6/eCJiegSzw7bfrung9TygbhlEJuCjU=; b=
	BUvQC+WZI9DL+625TZkSGognr79pE33GoODV51Q8qMWvG0UlEAlYj/p6tiGkfrN2
	iwhpGt5BF4D9jMIm8F791hSbw2lvs2Q3vtyTTgZmhHV56A9vlNCoz7FLnBYfM0DD
	PU5ILLXloCekV7ALCeHQykNXF0c+e77sClzKHyX/qjYw9lpGxxhQ9J/S8cLTPXzX
	y+V3Uaf/o2g2D8JPEi5pLSHbANxG0TiiYL6X7Rxm/xNFPy4Pf6+A2RviCNUEz8/u
	xSjKCVAgmElnMu7M4w7Vslts7/yd3zZQG9FWs/Xpuy630QF+gW8onI/Kfszxockw
	Irbld0L5sKPFpyywzGSg/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754992482; x=
	1755078882; bh=YC2bskHz8PzI6/eCJiegSzw7bfrung9TygbhlEJuCjU=; b=G
	UvgJhq6Ux235JvrwF6lYkbXD6TcYtJwE2zogjD6dbD5cmyQ/XrR4LY7qtFKRy3BC
	iJVOW3UZHd8MfxPYj9KZ2FbxKybtnS0C8uEKgrp9AF0lDJ/i4dzYqvLfbvlgUAi+
	NPV7F/oXPHCZW30vZ3SQ/HHqW9daQBTvt3VipV642H0pFOl9wyAAUa+tIw178VTp
	Pn7y2EFD9HmBmN3/rQCbvyNhdtblKNPyLJmS0OhqgUyDAnpGFEFTDfs+XGvyRAMl
	LKgyNBGIQUYCgrLzf0NCiWxrsyfOUvBi6+XZ+hzVCkEyHrEYewA8ZXj6z5fMcqCZ
	M2ldkY4H1hc7oOkxBzlog==
X-ME-Sender: <xms:Yg-baD24kgyDIcQumyOsRMdQnMiinHjMq--vU6ckLXasKi3lMO6b8g>
    <xme:Yg-baNnSTY03JMv9JDkHrCfqtVVPIOnQej6jnLJHkVau62YXjNFfBi6QtVPQFZ_M0
    AlYcS91YYq-rheB6w>
X-ME-Received: <xmr:Yg-baKXmPineEHW40kaZ93nwc8E9aKKcPt1nFxdGk6Wm7boUVqcSO2ulTUWn1ZGsCVgDc0COPUjP0D_iW7422Ft2ibCKjV8zACFaM5Oj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtieffuddtudduvddvveehuefffefgkefftdffleffhfffvddtjeffueejudetffen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:Yg-baDsvMv6Hiq8gWLxC0s5ZLjBkLnOIuLSVIwEkr62rQJkMBnhQTg>
    <xmx:Yg-baNZ3LQrOTPgClJTF0KCQt0s77Ug3e6jihIbTOWMO6unVh0GQOw>
    <xmx:Yg-baCWSh5IygKBqimxMuDgNZMNo5SLN0jbpoODY3xeW1S_DjzcCVg>
    <xmx:Yg-baCS5k_ieFIohYIZDNd3ZaSSJZ3BZAMyw36A4ALaZS2-f9TkzpQ>
    <xmx:Yg-baGCgEtQlWm6zLd-qdRycZIdjZQTmypjgh3Z1DRmh2EULtYIHnEGP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:54:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49916c04 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:54:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Aug 2025 11:54:18 +0200
Subject: [PATCH v3 4/8] reftable/stack: fix compiler warning due to missing
 braces
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-pks-reftable-fixes-for-libgit2-v3-4-cf3b2267867e@pks.im>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

While perfectly legal, older compiler toolchains complain when
zero-initializing structs that contain nested structs with `{0}`:

    /home/libgit2/source/deps/reftable/stack.c:862:35: error: suggest braces around initialization of subobject [-Werror,-Wmissing-braces]
            struct reftable_addition empty = REFTABLE_ADDITION_INIT;
                                             ^~~~~~~~~~~~~~~~~~~~~~
    /home/libgit2/source/deps/reftable/stack.c:707:33: note: expanded from macro 'REFTABLE_ADDITION_INIT'
    #define REFTABLE_ADDITION_INIT {0}
                                    ^

We had the discussion around whether or not we want to handle such bogus
compiler errors in the past already [1]. Back then we basically decided
that we do not care about such old-and-buggy compilers, so while we
could fix the issue by using `{{0}}` instead this is not the preferred
way to handle this in the Git codebase.

We have an easier fix though: we can just drop the macro altogether and
handle initialization of the struct in `reftable_stack_addition_init()`.
Callers are expected to call this function already, so this change even
simplifies the calling convention.

[1]: https://lore.kernel.org/git/20220710081135.74964-1-sunshine@sunshineco.com/T/

Suggested-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index ed80710572..9db90cf4ed 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -664,8 +664,6 @@ struct reftable_addition {
 	uint64_t next_update_index;
 };
 
-#define REFTABLE_ADDITION_INIT {0}
-
 static void reftable_addition_close(struct reftable_addition *add)
 {
 	struct reftable_buf nm = REFTABLE_BUF_INIT;
@@ -693,6 +691,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 	struct reftable_buf lock_file_name = REFTABLE_BUF_INIT;
 	int err;
 
+	memset(add, 0, sizeof(*add));
 	add->stack = st;
 
 	err = flock_acquire(&add->tables_list_lock, st->list_file,
@@ -739,8 +738,10 @@ static int stack_try_add(struct reftable_stack *st,
 					    void *arg),
 			 void *arg)
 {
-	struct reftable_addition add = REFTABLE_ADDITION_INIT;
-	int err = reftable_stack_init_addition(&add, st, 0);
+	struct reftable_addition add;
+	int err;
+
+	err = reftable_stack_init_addition(&add, st, 0);
 	if (err < 0)
 		goto done;
 
@@ -866,19 +867,18 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
 				struct reftable_stack *st,
 				unsigned int flags)
 {
-	int err = 0;
-	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
+	int err;
 
 	REFTABLE_CALLOC_ARRAY(*dest, 1);
 	if (!*dest)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
-	**dest = empty;
 	err = reftable_stack_init_addition(*dest, st, flags);
 	if (err) {
 		reftable_free(*dest);
 		*dest = NULL;
 	}
+
 	return err;
 }
 

-- 
2.51.0.rc1.163.g2494970778.dirty

