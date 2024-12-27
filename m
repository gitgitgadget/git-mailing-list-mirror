Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C11F2C24
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296445; cv=none; b=mGLeO9F/S9EcivEZ7MyJfyYnmPfMJLLLfCo1LTDLukk9gVi+EayNq18X6THPo+alfu2uh4aAZYoyJHq9ALbJfwu5jU8w7z/SzkDE+w5lKaRLrL96doj+qbC5aszPPKSGZd8hFr3VnmrHtRNxDLbtvro04S87UpmDOznE2YudK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296445; c=relaxed/simple;
	bh=vNp+4MRurfxhK7YAcvt2f8nOPyEUWrtmQKhfOFCKJS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmtRdIRMP7lO91U1BD2MB3WwPPKlqHapmG6hErf23p8H5lKyL3bQZI8vheKdnKk3lnR0LdVHSkLCWB8IRJ7Nlxg+Vyo+ChQulZZ+jMVVtZnsRrCJ4sJVzpfXBu1PAWL3nJKnKGY+nEP8akjiRsQ+Uxs087W3Hwswl0YaQfn/NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hRkBG9tV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4+wMrbO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hRkBG9tV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4+wMrbO"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D11D511400AA;
	Fri, 27 Dec 2024 05:47:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 05:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735296442;
	 x=1735382842; bh=UL+LkjC4ScqAXfKqfjLgPTP5V7B0ksBEKjyQ9SR5DE8=; b=
	hRkBG9tVhInGFLOgPZ+6XAQhqVW1qK3lj0GI4GtEla8pNcF/Ry085HFBmgAlbO8A
	UborZNGQ81MrWFYaeNx37Ngv4zNGVnlM16kcyUwAoJkQTFAhC8KgN61KXzJnoPbX
	0L7GRL1zbyx7QLlkDwlJb6t5sSqQGQhMXPvmVgMamlRLQTvCL1uwvFeMWDCO3dp1
	UgLrCYXyXnHMUkfz7k1PHG3NN+RRKwe+8/toULWAjSAmJupiQeMxryGJJueLXez/
	jToeilWwNflFHRrj+veDRC+MwGfeEpd3VpxM+l2NuDa5epb1ewXa1NRPlmTqdxuu
	CWT3SjhCw9czxgvOEL2kjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296442; x=
	1735382842; bh=UL+LkjC4ScqAXfKqfjLgPTP5V7B0ksBEKjyQ9SR5DE8=; b=K
	4+wMrbO+8fU694I0gMJNwtzXAukXjR5nepCEEJZO4+YbuHreogHUQeWfeGY/CGbM
	2/Lyit4ahTkUg9GaFfUHnTOJau6ObChx09qw3ktBXhzTiXnrGO+0N45FJq7rrzY9
	dNISL5K5oJuWVzCW1/+oyDImsXImup8MoZxqz9viVaCE3YKVruPS/ccsHIGQnONp
	7WS8HwXZU4Ai47ZHsdLew3WogQ6eXG9OazSrqN7qbErBTpDjcxLO+a/4OfHZwSlM
	QQJSolni4PzHt8OcQzlaZNZdKEVPob6A+uhY5gaM6SWEng0SDVN6xdAPtVwFjx91
	EkilwX8P0sj4CQbYslW9g==
X-ME-Sender: <xms:uoVuZ6-vzVfI4feA8OqHTudO7q4xlqODfmANnQkHt2x_K29pGM1ohA>
    <xme:uoVuZ6sjtS30mjjwwHwu6sB0eT-fGuuCfgVcFDoZtEWyHfbjTSGE9GV1DiRro3NbI
    gg4WK6seYGwXdscuw>
X-ME-Received: <xmr:uoVuZwAqMFcFTUDuJhfJ7w2D0YmZWqq5DULhh9LUIKiV_r4uFNqeBKXRmhVcZFyb2P277Sgl544qlqIT9Btn0hLRUClnExgXm_c988GLC-tBcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:uoVuZydOIWJwwlcikoXAVF4zewCjjhcSgIpt7MJYer60aUZgnXiWeA>
    <xmx:uoVuZ_MUnc7gGTw_TVrJEQbDQ_aOJ4DN8Q0cIkt1BkYtu2RoGngWgQ>
    <xmx:uoVuZ8nZnqShkUEBvC3AszxHIo_Xlq2w_7u0njelB68nmx54dWQZNQ>
    <xmx:uoVuZxviNlUdGTz-L6IQKUDKtNQzBRlEeyyoCxie1ZqIjiwBMjIcYQ>
    <xmx:uoVuZ4atLOOPmaBz0xmKfQ6TOqw4ti3CAhrxUdL2LchlPRHPVfPKr7TO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46b01dbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 11:46:28 +0100
Subject: [PATCH 8/9] shallow: fix -Wsign-compare warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-8-07c59c2aa632@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Fix a couple of -Wsign-compare issues in "shallow.c" and mark the file
as -Wsign-compare-clean. This change prepares the code for a refactoring
of `repo_in_merge_bases_many()`, which will be adapted to accept the
number of commits as `size_t` instead of `int`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 shallow.c | 38 ++++++++++++++++++--------------------
 shallow.h |  6 +++---
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/shallow.c b/shallow.c
index 82a8da3d730b2f4f6bda462c8ac347f0b10da993..b8fcfbef0f9cdbfa895d4d6e1214f67942f88d25 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "hex.h"
@@ -134,7 +133,8 @@ static void free_depth_in_slab(int **ptr)
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		int shallow_flag, int not_shallow_flag)
 {
-	int i = 0, cur_depth = 0;
+	size_t i = 0;
+	int cur_depth = 0;
 	struct commit_list *result = NULL;
 	struct object_array stack = OBJECT_ARRAY_INIT;
 	struct commit *commit = NULL;
@@ -335,16 +335,16 @@ static int write_shallow_commits_1(struct strbuf *out, int use_pack_protocol,
 				   const struct oid_array *extra,
 				   unsigned flags)
 {
-	struct write_shallow_data data;
-	int i;
-	data.out = out;
-	data.use_pack_protocol = use_pack_protocol;
-	data.count = 0;
-	data.flags = flags;
+	struct write_shallow_data data = {
+		.out = out,
+		.use_pack_protocol = use_pack_protocol,
+		.flags = flags,
+	};
+
 	for_each_commit_graft(write_one_shallow, &data);
 	if (!extra)
 		return data.count;
-	for (i = 0; i < extra->nr; i++) {
+	for (size_t i = 0; i < extra->nr; i++) {
 		strbuf_addstr(out, oid_to_hex(extra->oid + i));
 		strbuf_addch(out, '\n');
 		data.count++;
@@ -466,7 +466,6 @@ struct trace_key trace_shallow = TRACE_KEY_INIT(SHALLOW);
  */
 void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 {
-	int i;
 	trace_printf_key(&trace_shallow, "shallow: prepare_shallow_info\n");
 	memset(info, 0, sizeof(*info));
 	info->shallow = sa;
@@ -474,7 +473,7 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 		return;
 	ALLOC_ARRAY(info->ours, sa->nr);
 	ALLOC_ARRAY(info->theirs, sa->nr);
-	for (i = 0; i < sa->nr; i++) {
+	for (size_t i = 0; i < sa->nr; i++) {
 		if (repo_has_object_file(the_repository, sa->oid + i)) {
 			struct commit_graft *graft;
 			graft = lookup_commit_graft(the_repository,
@@ -507,7 +506,7 @@ void clear_shallow_info(struct shallow_info *info)
 void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 {
 	struct object_id *oid = info->shallow->oid;
-	int i, dst;
+	size_t i, dst;
 	trace_printf_key(&trace_shallow, "shallow: remove_nonexistent_theirs_shallow\n");
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
@@ -560,7 +559,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 {
 	unsigned int i, nr;
 	struct commit_list *head = NULL;
-	int bitmap_nr = DIV_ROUND_UP(info->nr_bits, 32);
+	size_t bitmap_nr = DIV_ROUND_UP(info->nr_bits, 32);
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
 	struct commit *c = lookup_commit_reference_gently(the_repository, oid,
 							  1);
@@ -660,7 +659,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	struct object_id *oid = info->shallow->oid;
 	struct oid_array *ref = info->ref;
 	unsigned int i, nr;
-	int *shallow, nr_shallow = 0;
+	size_t *shallow, nr_shallow = 0;
 	struct paint_info pi;
 
 	trace_printf_key(&trace_shallow, "shallow: assign_shallow_commits_to_refs\n");
@@ -735,7 +734,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 
 struct commit_array {
 	struct commit **commits;
-	int nr, alloc;
+	size_t nr, alloc;
 };
 
 static int add_ref(const char *refname UNUSED,
@@ -753,12 +752,11 @@ static int add_ref(const char *refname UNUSED,
 	return 0;
 }
 
-static void update_refstatus(int *ref_status, int nr, uint32_t *bitmap)
+static void update_refstatus(int *ref_status, size_t nr, uint32_t *bitmap)
 {
-	unsigned int i;
 	if (!ref_status)
 		return;
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		if (bitmap[i / 32] & (1U << (i % 32)))
 			ref_status[i]++;
 }
@@ -773,8 +771,8 @@ static void post_assign_shallow(struct shallow_info *info,
 	struct object_id *oid = info->shallow->oid;
 	struct commit *c;
 	uint32_t **bitmap;
-	int dst, i, j;
-	int bitmap_nr = DIV_ROUND_UP(info->ref->nr, 32);
+	size_t dst, i, j;
+	size_t bitmap_nr = DIV_ROUND_UP(info->ref->nr, 32);
 	struct commit_array ca;
 
 	trace_printf_key(&trace_shallow, "shallow: post_assign_shallow\n");
diff --git a/shallow.h b/shallow.h
index e9ca7e4bc80451a74dc10fb6d4e1a0b190dc4dcc..9bfeade93ead7421d7f2991862dde88ba546fc64 100644
--- a/shallow.h
+++ b/shallow.h
@@ -59,8 +59,8 @@ void prune_shallow(unsigned options);
  */
 struct shallow_info {
 	struct oid_array *shallow;
-	int *ours, nr_ours;
-	int *theirs, nr_theirs;
+	size_t *ours, nr_ours;
+	size_t *theirs, nr_theirs;
 	struct oid_array *ref;
 
 	/* for receive-pack */
@@ -69,7 +69,7 @@ struct shallow_info {
 	int *reachable;
 	int *shallow_ref;
 	struct commit **commits;
-	int nr_commits;
+	size_t nr_commits;
 };
 
 void prepare_shallow_info(struct shallow_info *, struct oid_array *);

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

