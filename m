Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C11A3172
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260445; cv=none; b=r+46NUKcDQKO2W8y9o+HwyyAMBMb3xAq9srs1BNdWb64UbclXmFC1K5N4T5g/lWdaT+Wps0nwcxb4nQ53D3swmbOAUIkMDDFsLXgR/0mxTZPpGJM5Td8uqO9Tr8kQcefEC1sChZIgNs4HD3H/m94RHhTLlLW02brGkQZx5P+y0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260445; c=relaxed/simple;
	bh=7Abg3cYIf+AQ8ycdXqKFJeqj9nW3y5ucFNKiXV9wMu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QcoFTlA/s7/rwioQkdbCv2q1J79GmBOoekRgjncFimlfO+5bg5QFhO+YNP6MVwYp/UWapdN/7me3OnOXU9CbAri0wVfMsy+JB7YHpcn3AQNMUynygKFDj8XNgAv68hE33nrgjxAKAHPUI54ixZ0R6os6+VfJjg9AY+ue9S6q2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QG4a+DOA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fjk2034L; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QG4a+DOA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjk2034L"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B3ACEC00C6;
	Tue, 26 Aug 2025 22:07:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 26 Aug 2025 22:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756260441;
	 x=1756346841; bh=CJuhA9WuvbiYYvVxreKOGBUPLQMO83tQOxn1CbU/+vs=; b=
	QG4a+DOANLnD0bPbw/Lo7P7Hp0+UwfalOLciEgu/6OJxmQskpZ9m62jHDKN7/bN6
	AXYSRT5N40ZwGTdVLtXtSjexfZ3nbeVJQfkkPaon6xMsIXVEtfSmFv4I5szFFThh
	UcuQsJ/jLaacuiAdZiV1WBx6fCnlwwFkv/tZzlzXN0VFP1fPMKFIhmZ8g7x7aeNP
	CkoisLU3CWvS6LI4h4/qjcU4oybdYQXTvx+DV3Bn/+8ydaANP9VmyHj9tss+49jG
	R7NXnnSQ1oB5PrVdrvtO1b4ZdYUUlYz+lSCq5iv7+RzuMi7hbpkBj0qJfnSDTSWE
	kUqOmh2d6uWH5Zygl8wB9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756260441; x=
	1756346841; bh=CJuhA9WuvbiYYvVxreKOGBUPLQMO83tQOxn1CbU/+vs=; b=f
	jk2034Ly4HlhA6ti3GovdhhB2IZp27Ke10zJWG6TeGoEHAdDyJD+0P+9UX0VZZAl
	VXZuBc0o+cggzw8uB3EgWIGD7eMjGI0EPWxsHzLyrh+QhJngRABSSWn3rFT9sF5e
	LP0ewBBvA76Q1bkEnuKfAbjPiKgoR+hp6txI88K7k09V/bLnnAdY+4IBjsfCzrEQ
	WYGv7D21//XcxD/9tdJ5/0b3YOA9DYdjzv2WKshvqKg+DTj54YFH/3QwJw2hKw3P
	cfVF47Vw5KNFv9CTP3mZ+ivdAGXplI5HpVJgagomAe7vGzK1Y0iVX7K+pNtkJEjm
	hYd5ThEHa1kGLHhiViW0A==
X-ME-Sender: <xms:WWiuaKSzDx-5TsKjm8_8BG1bOvtWy1-lBQrW95rbFm5r3_61_OFvbw>
    <xme:WWiuaLRnV8sq6uvCd9HdghCz-SVxuG8v6gYHH3IJ-FER8v888PNRvWEmVxj7qwKwv
    aXA-hbU-C_7PHTrBg>
X-ME-Received: <xmr:WWiuaOQJ9FL-P55guAGNht_J7-rMsG7sZ3tHfJu_ejr_EJjWY-U2A5taGoGYb_HB_lJ_StKuMAX05XBGHBTl9WFNYg6W9f_gB-pHddE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehteeivdeuvdevffdttedvheelgedtudevhfekheffteeuuddutedttdfh
    ueefffenucffohhmrghinheprghllhhotgdrtgifpdhosghjvggtthdrtgifnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnohhurhgrvg
    hllhhmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvrgesohguohhordgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WWiuaA7LEJ4SfIoo8QnRE1PzlSVUkeL0j5CJTYzndQw27yvg_8dp7g>
    <xmx:WWiuaK1iebw8xcGR-ZEYreNdKVq7ql9YpxZIOzksd7MB3zm_y21P2w>
    <xmx:WWiuaLC5C6Iqd10vjHY2Q5U7chJeFFp8yGkF_GjArGeYvMl6-aG6Pw>
    <xmx:WWiuaFNxg00GIrE0zJts0wQt6JR_LmXbaYP1xU6PWGGWQrN3V5YdcQ>
    <xmx:WWiuaIPdnzl1_YoA4W-8jdMjbIps4CrNLFz3zZ5g7cIme9uOs6CWr_AB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 22:07:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9_|_Flare_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?44OO44Km44Op?= | Flare
 <nouraellm@gmail.com>,  =?utf-8?B?44OO44Km44Op?=
 <nea@odoo.com>
Subject: Re: [PATCH] reset slab_alloc and state fields in clear_alloc_state()
In-Reply-To: <pull.2040.git.git.1756238268790.gitgitgadget@gmail.com>
 (=?utf-8?B?IuODjuOCpuODqQ==?=
	| Flare via GitGitGadget"'s message of "Tue, 26 Aug 2025 19:57:48
	+0000")
References: <pull.2040.git.git.1756238268790.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 19:07:19 -0700
Message-ID: <xmqq8qj5frfs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"ノウラ | Flare via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9?= <nea@odoo.com>

This name used on the in-body From: line must match who signs off
the patch below on Signed-off-by: line.

> clear_alloc_state() freed all slabs and nulled the slabs pointer but
> left slab_alloc, nr, and p unchanged.  If the alloc_state is reused,
> ALLOC_GROW() can wrongly assume that the slab array is already
> allocated because slab_alloc still holds a stale nonzero capacity.
> In that case s->slabs remains NULL and the next dereference writes
> through a NULL pointer, causing undefined behavior.

Let's not give such a misuse-prone API to consumers, then.  How
about doing something like this  instead?

As Documentation/CodingGuidelines says the API functions for
subsystem S should in general be called S_<something>, let's rename
allocate_alloc_state() to alloc_state_alloc(), get rid of the "just
clear" function and make it alloc_state_free_and_null() to do just
that.

 alloc.c  |  7 +++++--
 alloc.h  |  4 ++--
 object.c | 26 +++++++++++---------------
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git c/alloc.c w/alloc.c
index 377e80f5dd..3a5d0b2bd8 100644
--- c/alloc.c
+++ w/alloc.c
@@ -36,19 +36,22 @@ struct alloc_state {
 	int slab_nr, slab_alloc;
 };
 
-struct alloc_state *allocate_alloc_state(void)
+struct alloc_state *alloc_state_alloc(void)
 {
 	return xcalloc(1, sizeof(struct alloc_state));
 }
 
-void clear_alloc_state(struct alloc_state *s)
+void alloc_state_free_and_null(struct alloc_state **s_)
 {
+	struct alloc_state *s = *s_;
+
 	while (s->slab_nr > 0) {
 		s->slab_nr--;
 		free(s->slabs[s->slab_nr]);
 	}
 
 	FREE_AND_NULL(s->slabs);
+	FREE_AND_NULL(*s_);
 }
 
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
diff --git c/alloc.h w/alloc.h
index 3f4a0ad310..cd6ed16ffb 100644
--- c/alloc.h
+++ w/alloc.h
@@ -14,7 +14,7 @@ void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
 
-struct alloc_state *allocate_alloc_state(void);
-void clear_alloc_state(struct alloc_state *s);
+struct alloc_state *alloc_state_alloc(void);
+void alloc_state_free_and_null(struct alloc_state **s);
 
 #endif
diff --git c/object.c w/object.c
index c1553ee433..4469755ea6 100644
--- c/object.c
+++ w/object.c
@@ -517,11 +517,11 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
 	memset(o, 0, sizeof(*o));
 
 	o->repo = repo;
-	o->blob_state = allocate_alloc_state();
-	o->tree_state = allocate_alloc_state();
-	o->commit_state = allocate_alloc_state();
-	o->tag_state = allocate_alloc_state();
-	o->object_state = allocate_alloc_state();
+	o->blob_state = alloc_state_alloc();
+	o->tree_state = alloc_state_alloc();
+	o->commit_state = alloc_state_alloc();
+	o->tag_state = alloc_state_alloc();
+	o->object_state = alloc_state_alloc();
 
 	o->is_shallow = -1;
 	CALLOC_ARRAY(o->shallow_stat, 1);
@@ -573,16 +573,12 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	o->buffer_slab = NULL;
 
 	parsed_object_pool_reset_commit_grafts(o);
-	clear_alloc_state(o->blob_state);
-	clear_alloc_state(o->tree_state);
-	clear_alloc_state(o->commit_state);
-	clear_alloc_state(o->tag_state);
-	clear_alloc_state(o->object_state);
+	alloc_state_free_and_null(&o->blob_state);
+	alloc_state_free_and_null(&o->tree_state);
+	alloc_state_free_and_null(&o->commit_state);
+	alloc_state_free_and_null(&o->tag_state);
+	alloc_state_free_and_null(&o->object_state);
+
 	stat_validity_clear(o->shallow_stat);
-	FREE_AND_NULL(o->blob_state);
-	FREE_AND_NULL(o->tree_state);
-	FREE_AND_NULL(o->commit_state);
-	FREE_AND_NULL(o->tag_state);
-	FREE_AND_NULL(o->object_state);
 	FREE_AND_NULL(o->shallow_stat);
 }
