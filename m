Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C121F708B
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787485; cv=none; b=OrIoyooF7cHGrfVFSmXYALJ2MC4cqICks7e0TKp1m5KPq7IEsKHD2ialBcHCu3ENANVYVBnKsSqNCJ86ZgqOWsaBL+skftsIk15PVlPbaUYLwB68QFhezYdJ847i4pJY5QnzndxZrWddApiFCNrs0Hf3FJDOLxOa8ughGW/4qVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787485; c=relaxed/simple;
	bh=7ZM2cT7DjWer0j4yBhMpZUzZHNyKdBQ2zKPZMzPoUdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHJuUw9Gh3IzgGflIdQ6RCu+fi4pNk+60/RNC7K3bN3FYmmfY459IcMYLzLRJZbAtdzl3UUZ3ULEHChTqnhvWk/ZUDPspvLlmRm2ZyQc0Ikos1O9KxvTvAjNka1rdDZFkTVaqCOWlULgic2ZxK6MAnR3pYullqWCQy3euiwZBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eJReO3nv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=culqB3Fe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eJReO3nv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="culqB3Fe"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 72810114017D;
	Tue,  5 Nov 2024 01:18:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 01:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787483; x=1730873883; bh=P4f9MjiBqm
	ICtIdXDvdZS/UszsFcWc9lb8qB3huONGU=; b=eJReO3nv7xkzR83ZAYtyHnzHHC
	frP0L51s/ayro+HM8+PSuS74agBXY1Cr/jeVWQ2bSks7MtUgM9mcIDD2LC4xEp1i
	9CMeoVewCanEiZLz7JVuH85teQ/B9JH2fnJEpPPrEVEFoSH/wRTWkBF5msCexAjr
	atset2OZ/Lfd4SlKKBieVVO3ORbLsAa/IlbAIy/Xn1xMF8C23dH/lUZWyL22EY2l
	2ca2wF5XF5OtNMyh7NdWAQ++uKmS3Xo+GMiv9NxhOxDRUAUpWe+BH1yQX4JUS4jD
	OxUbrq1hq3lTvvC4L7ExZVd0Ijo/LJlQlNi4G097h9f/PcfX4LC1Rh482VwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787483; x=1730873883; bh=P4f9MjiBqmICtIdXDvdZS/UszsFcWc9lb8q
	B3huONGU=; b=culqB3Fe7CLBDU4CYVcL4N6POieDMIkbzdt4b8SUl208nflLD2D
	hIDvz77gHXwYoxecDfP3/3UgyOaGWAu9wEIBaF/ByvK3f+IDGBJ7Xj7bRUiKfVQi
	559UmCPUOxfNB2zTgS4damr84pxjJyfc03EGh9Ld/zGB9fGK895RbFiGaLTz9dzK
	K11AGmLQ9s72puIdJ1cw4/2Q27kjITr1KZQ3V3IQgefmmcC5ArL5n7rgVNzKoMzy
	u9FWOiWv30J+CjJlOxPeEnbOWot8KPLqwpRhu2mQeRPdFd4ndseAYCwmGYLwj4JL
	SkqBO1YQht/trievCGOH0MxEXQuR993WmKw==
X-ME-Sender: <xms:m7gpZzbnqHynOzHcC2S22gUXus0ypxAzJfGyE79Y2l-SyU11T9_JQQ>
    <xme:m7gpZyYSYxU0DaR9hF0wUHrN5yeFO_sK-uH1gGGmyKx26AOkN9qtlRMPuUyfIVQad
    CFbUZTmQJxZIEaH0A>
X-ME-Received: <xmr:m7gpZ1825cOVhVQtCsxwji80_h3CFm4YLFXIyo35I751uN1mjQnTMtoSODpXKi7Zi3YBeO6X8OpfFKtUOj0yTgMfG-6vie5z0y-ghDPO8qSRPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhm
X-ME-Proxy: <xmx:m7gpZ5rs6B27hvq9kjTCmHJ_gdZmgpeqOYPn7nqQX4lqtlPQJGA8Og>
    <xmx:m7gpZ-rd-uaSSRlT3r_Grt6TDvxp1TIJcNce_SnXd7CgAXOoXZSHLQ>
    <xmx:m7gpZ_RUz7yuSjkp3ApZ58yd8M1unUs86Y6ljUbmOcmFK2hE8lde8w>
    <xmx:m7gpZ2r1JwYhtdHKikgSQKnWJKeKNoRwkjk6GotSoIPDCZPcYtzrZg>
    <xmx:m7gpZ7DaGWWx20kwISOjEr2awR_tuLSvWWQZTKesdBGktlEbB3uMte8n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:18:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a673ccbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:40 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 22/22] list-objects-filter-options: work around reported
 leak on error
Message-ID: <d9e122bb5db965cdc3d86f4ba869cd51a3aca800.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

This one is a little bit more curious. In t6112, we have a test that
exercises the `git rev-list --filter` option with invalid filters. We
execute git-rev-list(1) via `test_must_fail`, which means that we check
for leaks even though Git exits with an error code. This causes the
following leak:

    Direct leak of 27 byte(s) in 1 object(s) allocated from:
        #0 0x5555555e6946 in realloc.part.0 lsan_interceptors.cpp.o
        #1 0x5555558fb4b6 in xrealloc wrapper.c:137:8
        #2 0x5555558b6e06 in strbuf_grow strbuf.c:112:2
        #3 0x5555558b7550 in strbuf_add strbuf.c:311:2
        #4 0x5555557c1a88 in strbuf_addstr strbuf.h:310:2
        #5 0x5555557c1d4c in parse_list_objects_filter list-objects-filter-options.c:261:3
        #6 0x555555885ead in handle_revision_pseudo_opt revision.c:2899:3
        #7 0x555555884e20 in setup_revisions revision.c:3014:11
        #8 0x5555556c4b42 in cmd_rev_list builtin/rev-list.c:588:9
        #9 0x5555555ec5e3 in run_builtin git.c:483:11
        #10 0x5555555eb1e4 in handle_builtin git.c:749:13
        #11 0x5555555ec001 in run_argv git.c:819:4
        #12 0x5555555eaf94 in cmd_main git.c:954:19
        #13 0x5555556fd569 in main common-main.c:64:11
        #14 0x7ffff7ca714d in __libc_start_call_main (.../lib/libc.so.6+0x2a14d)
        #15 0x7ffff7ca7208 in __libc_start_main@GLIBC_2.2.5 (.../libc.so.6+0x2a208)
        #16 0x5555555ad064 in _start (git+0x59064)

This leak is valid, as we call `die()` and do not clean up the memory at
all. But what's curious is that this is the only leak reported, because
we don't clean up any other allocated memory, either, and I have no idea
why the leak sanitizer treats this buffer specially.

In any case, we can work around the leak by shuffling things around a
bit. Instead of calling `gently_parse_list_objects_filter()` and dying
after we have modified the filter spec, we simply do so beforehand. Like
this we don't allocate the buffer in the error case, which makes the
reported leak go away.

It's not pretty, but it manages to make t6112 leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects-filter-options.c       | 17 +++++++----------
 t/t6112-rev-list-filters-objects.sh |  1 +
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 00611107d20..fa72e81e4ad 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -252,16 +252,14 @@ void parse_list_objects_filter(
 	const char *arg)
 {
 	struct strbuf errbuf = STRBUF_INIT;
-	int parse_error;
 
 	if (!filter_options->filter_spec.buf)
 		BUG("filter_options not properly initialized");
 
 	if (!filter_options->choice) {
+		if (gently_parse_list_objects_filter(filter_options, arg, &errbuf))
+			die("%s", errbuf.buf);
 		strbuf_addstr(&filter_options->filter_spec, arg);
-
-		parse_error = gently_parse_list_objects_filter(
-			filter_options, arg, &errbuf);
 	} else {
 		struct list_objects_filter_options *sub;
 
@@ -271,18 +269,17 @@ void parse_list_objects_filter(
 		 */
 		transform_to_combine_type(filter_options);
 
-		strbuf_addch(&filter_options->filter_spec, '+');
-		filter_spec_append_urlencode(filter_options, arg);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
 		sub = &filter_options->sub[filter_options->sub_nr - 1];
 
 		list_objects_filter_init(sub);
-		parse_error = gently_parse_list_objects_filter(sub, arg,
-							       &errbuf);
+		if (gently_parse_list_objects_filter(sub, arg, &errbuf))
+			die("%s", errbuf.buf);
+
+		strbuf_addch(&filter_options->filter_spec, '+');
+		filter_spec_append_urlencode(filter_options, arg);
 	}
-	if (parse_error)
-		die("%s", errbuf.buf);
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 0387f35a326..71e38491fa8 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -5,6 +5,7 @@ test_description='git rev-list using object filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test the blob:none filter.
-- 
2.47.0.229.g8f8d6eee53.dirty

