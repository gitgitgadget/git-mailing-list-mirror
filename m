Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB051DF24F
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417867; cv=none; b=X7mSa30J9IgSFsZg0Deuy7XBpp3p33ZsVqtmuOakyIojCMGC1Xlf+fnWyRZn0exQ/w4hww166u+cA9NrNjdExeE6POrz7to2DEvzhJ/TrbmOTGzzBAwMI5Sne/6BQXGJzpjAkJ1EOoxqXfFLVJidjLfWzQY16bFv/tYjsBb5jV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417867; c=relaxed/simple;
	bh=xvLYu9nxPkx4Kvhmg4SSzRH6ZZRagjS6mfydcZRumU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QeULxcBpvjECOwlL01ZZmoPaAsTXMx0GnfiqyZXWAs7qGjUWWJI8+qqrj9mhLut+7eQKziVMSR5QIOWXo2SqaveShVrSJw+Y6E1LVABluMh06K1TLEuSvoJHBQ/ZDq0I/Yd/YW2ztJvdwO6ggqCBQkAu0AlHUL4ZsA/Pv2IDphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AobvKg76; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2IDukCpK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AobvKg76";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2IDukCpK"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E6671140251
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 17 Dec 2024 01:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417865;
	 x=1734504265; bh=Ptkmd86d6JpMeifnKR4R9v+wBdl1wXLctfWyqf598eI=; b=
	AobvKg76ZJxgkjKt4vBTJe2QHjtW6cm+SpbNyGDNsl4pGCwzDCr3hXcHNRFoINdl
	R+UTwSHsQn9T75UTvGmYT+cdCOaHNfwUvPhvGcqhKWf/jehrCF+dtkIH8YqQOM53
	av6AygyAQQTLLx1bl5cyq7u4+IlUEwW5gmmc2Rt4hGA68xcz079dP0LpI4XZVSY8
	FSmkOArCAGt10dOGcFBTIIebDPpB5V13rG31hz+Zr3Vb3GMZv2pZ90DaAExHwsck
	suLe4jGVbGdcKFzPvTL6y2rrFmqUAaF9j0ssAO1LEHvHa5/64EiglhCTpo833CLh
	mliXYIqnE1uWVKzJVm3cZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417865; x=
	1734504265; bh=Ptkmd86d6JpMeifnKR4R9v+wBdl1wXLctfWyqf598eI=; b=2
	IDukCpKplKfH2eph7z9m2zK2QFgokauNKkHudWFMHWBKY2bRJVxfSuKG2/79NDSd
	GcxWvZEB4Yzeg4AIUtEVs9hhebZ0IQcmKLzEvoLq8QVNyOMDIiw3d/tQ35dzOa0t
	d1mY9vx+41+CgmP5ehB+qw/DCr53QxJg+4vQipZU7oM55kdpg/yHDufcfZRTFJpd
	UZVV1VlQy5lKLcRIIw4G0Ha7g5LgA5TtxC9/iwZ+pL4/Wj7+XHU8LQxLSBHhFo8h
	NjQqa5K6nXJ0QyP49lxEZ4pJRdRrNkpycRbFnS++Sxw7bkimzxCVJF9P/W90l47c
	bkhNwm1zih1KNwJ4WiyVA==
X-ME-Sender: <xms:yB1hZ_HQNqt85eoTDPAHrlHQizndKf3RLNpJhTT_Le3A_7p1bZuI9w>
    <xme:yB1hZ8WYMQqCYfF_2oumw7CY0MZ5ieKS1BzFmBny1n4kdgKLJPwolDCzxF4RjyupW
    vgFAYul74lVzsvqoA>
X-ME-Received: <xmr:yB1hZxJiW4naEF8ykvodEqYO62gbo7M_97BFDmC0aiVUSrM0tdXXRC5CcgJAS1z8pSEWA6syxebMm1WdlejNdFAeO08S8rGi_DbZkmd_1p7sNFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yB1hZ9FZgN-6w6uubdYYslcE0cX7Ra2ki8G_p199S5m_WE0dMg1zDQ>
    <xmx:yB1hZ1XIR8F7wB-f8bv69xIKTFY-xdX1aeUAok6d9AfX4GuCHKuq7w>
    <xmx:yB1hZ4NGz65BrIjAth6Ke_myFcReFCG4IFpypHA1kCZkWbhDr6AxBA>
    <xmx:yB1hZ01J_LR3yZkSTNHcp5rR61GcwPwHNEuHNE0qpV-bb6fgzYejvQ>
    <xmx:yR1hZ0du4GxCw8KWiIUr2b8xXhuuvlTmN5vaHXI6wIFiUarXgMXcamzN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 480bd788 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:59 +0100
Subject: [PATCH 12/14] add-interactive: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-12-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "add-interactive" subsystem by
reusing the repository we already have available via parameters or in
the `add_i_state` structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index d0f8c10e6fd460c67c564a1040d12780dfafbc69..97ff35b6f12a32e4154fbe4d195d444c0f71c347 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -72,14 +71,14 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 		s->use_color ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
 
 	FREE_AND_NULL(s->interactive_diff_filter);
-	git_config_get_string("interactive.difffilter",
-			      &s->interactive_diff_filter);
+	repo_config_get_string(r, "interactive.difffilter",
+			       &s->interactive_diff_filter);
 
 	FREE_AND_NULL(s->interactive_diff_algorithm);
-	git_config_get_string("diff.algorithm",
-			      &s->interactive_diff_algorithm);
+	repo_config_get_string(r, "diff.algorithm",
+			       &s->interactive_diff_algorithm);
 
-	git_config_get_bool("interactive.singlekey", &s->use_single_key);
+	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
 	if (s->use_single_key)
 		setbuf(stdin, NULL);
 }
@@ -535,7 +534,7 @@ static int get_modified_files(struct repository *r,
 			      size_t *binary_count)
 {
 	struct object_id head_oid;
-	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(r),
 						  "HEAD", RESOLVE_REF_READING,
 						  &head_oid, NULL);
 	struct collection_status s = { 0 };
@@ -560,7 +559,7 @@ static int get_modified_files(struct repository *r,
 		s.skip_unseen = filter && i;
 
 		opt.def = is_initial ?
-			empty_tree_oid_hex(the_repository->hash_algo) : oid_to_hex(&head_oid);
+			empty_tree_oid_hex(r->hash_algo) : oid_to_hex(&head_oid);
 
 		repo_init_revisions(r, &rev, NULL);
 		setup_revisions(0, NULL, &rev, &opt);
@@ -765,7 +764,7 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 	size_t count, i, j;
 
 	struct object_id oid;
-	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(s->r),
 						  "HEAD", RESOLVE_REF_READING,
 						  &oid,
 						  NULL);
@@ -996,7 +995,7 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 	ssize_t count, i;
 
 	struct object_id oid;
-	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(s->r),
 						  "HEAD", RESOLVE_REF_READING,
 						  &oid,
 						  NULL);

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

