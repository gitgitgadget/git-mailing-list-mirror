Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF073E4C85
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503257; cv=none; b=ARQh/nQOEjMo5uFqe82aDZAOOE4hEmwZsfxBH0yrEUXt8w540/YWe8vwwZyo1+/lpHDnA8ugV0Y7oLi48zR+j8VRkRWAP3Fzo7654frfFO+/SxSUt1C23kkqjVH2cZsya2jAe05ih34kWbsbWGh1bCC6nntAPLDB73O0m9bJtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503257; c=relaxed/simple;
	bh=jSqjVY/wZSLzpLjjqbbeDBi562gaTPrv7fKBuJJNnE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGSPGOYNunNdgRUqsbh1Zynt2Eh+NS5IMdmOcMDvscaMsByMDjsiZcdtqZKNutVe0H7AUAPr8VRi9BwjHsg/PaxIHKq6Orb4uNa8KMUu36vUZv8LcKV2sXXXL/J7WhRJ+zwZF54J2ytKhfDak1mrmcol5/YVYHxKksY16Pj15ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hpsv+Kuc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQDs0tEW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hpsv+Kuc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQDs0tEW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6606E1D000FA;
	Wed,  3 Jun 2026 12:14:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 12:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780503255;
	 x=1780589655; bh=DUwGiknfQXRmACn5UU1+Q3VFFEWrHp4s/JVzUA64ACk=; b=
	Hpsv+Kuc25wV8saGtOvdHlAF6TzkJEwOUudRTzbzDainl4g0k66EN6rWrDCyRjVA
	UhdZuzKeRHRXAII0UlBCciWmelfDFb7c9hEkZ/PB6/I1P84sR/YpvfaNej57nHW/
	6ULdXnufjfkVDryYME62b7l4NBkLknFf/QFlwpjUFikBijtIyd0gzUIRiMKQogxi
	YvdfKlf8H3q8VSJuCCQpGRWONMA5e8Pqb+iuc9+cwgvRPwLddKXvL8+xfLniVgDP
	nTRNWD4ch1c/SiLipn3JRn6jeG7ATkf8F1JzGVf/ZnB520xaoME8rHMSRgXS0E1Y
	+0+OvqTynNJynMej0Og2eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780503255; x=
	1780589655; bh=DUwGiknfQXRmACn5UU1+Q3VFFEWrHp4s/JVzUA64ACk=; b=A
	QDs0tEWfBKXVDQFJ0jOabZNwTjv53Sr3iotYXEy2fCdgxT5HUCFamWd+vLjihd+M
	DmWrsIgAlh+HijkK8CWPVde7Q8S3eyOYKbDMbkGKR62Xt+6DCwzyunY/3qEr1YHg
	GuQFMAiT+jMGI3PiI7a+zeoHQf6JmiqEE4r+5lp6r38osCAWX4ozsU2az5JB4uPQ
	9TFTahBNTo5lajZdxymkQ5bji4qzUE1rSmmZ7VKNJJsO5o0kjXfZsW6QVlyy6z5Y
	TSWrFjsCR9fmuGAjafuESyctzCoiLE2WBOZ6TyG2If6DUFlaKU2qH5ENtzd4HXym
	6f24KwhJUQ1Q+9TLRM6Iw==
X-ME-Sender: <xms:11IgapVrU8xTE5pShxVax-bbubAqcbc4Tz3Q8xR8zJ6_3njyQWYKJA>
    <xme:11IgahCkWgcXe30UJ1yGzqP0eox2k2yuNtn-qXb8hS-nKovgPqzwI5Am12P-L51oq
    TpGgYtcBEaHbNCcWYg6R1MormmREF1dx70M01fpjoPBiEuXKhHAkw>
X-ME-Received: <xmr:11IgaixDPOTCD1EkEMm4mQEQA-tvE2Y22YF-Wq1HA3I-1S7qv-qaylgmBgUYOIJFdjtpLqm-aLUJ5ZDcRfXg-QLrfTFFCAcNw9l80uaFORTh>
X-ME-Proxy-Cause: dmFkZTGdlIonfplKpFXa/+DN5l0Fb2humCV2KDAOVEKyP+YPvmRBKflqZmkwAq9rePEQEk
    tFWbGVHfEKLtOw94e3kwwUvfEq/biapgD0LFxEGjNoceagFbAdw8S44lP98A4A6KSEBzBI
    FK/Zaf4iM+7r9UuVe4A2HKmR8OR4YocvA/6wxorfK7uRUU2fV0yzyhSTCXmRlDtYfcUpDj
    W3y4seHxmmHClyvMTnpX7w52yD4rY/DK178Gw1HIPAoq8c0YVNdlYew0Ju9pKEwEpdY7jk
    aRnqh9h1yCWlfj/W0CqUM74g6F8iUs+FEHBRjFPLTPipkR6XYgqphPOg5F7L6g8vVu+vCK
    LfzM1Ud0QzT6dUGkQWVHEZrGZvyqT4hCGiM/aHgNck8G7LSV5LWV/kB+38Zct/q3eketOP
    OE6nCIgvAqEMj/tjUkMqo/hEF961HwGfHyO0UFojKwOdgfNkQq4j2T6dC6TT/ZCc+lPpqE
    uQO9hd5ZJX2LD2JG2Tr8rZdqf7n8Ggw0NqKqZvVmFpOrcDYay9vewgYS+4IEV3oNDoGzRT
    +2nhLirDzGBQxfn+BDNuZP+m2PXyYClGQ0v8HrkMObwsO5TMEW86frjWumNgEffupy+7va
    3B6Tlrl7Qu+Nl1MXtYuE59ToY8fYISOwOV9pA2tCae6jJj9N9/XyHSmxskUw
X-ME-Proxy: <xmx:11IgamClXE8lLF2CpRysmtXXBhiZNchTYnInRuls3hZZSyn9nF3avA>
    <xmx:11IganYl6CVcRVtC-VwBZVcEHALeZddA5UZbpcbNoXCG3pUjCMmTfg>
    <xmx:11Igamh42Zyzn11mFKL7Gfg2IxkDMwGXmt6orOlz_KvNtlyIAVC1qQ>
    <xmx:11Igah6-eMhqYxsBTKrMF-3dj8sev9IDxpYIQWVtV-YXmZZ9XqrNtA>
    <xmx:11IgalACqElX9lxR6zjKPGuP8_27088lg8J-pJWxkJOgcMshAJs4fjcC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:14:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc8e5c54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:14:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 18:14:03 +0200
Subject: [PATCH v2 4/9] reset: introduce dry-run mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-pks-history-drop-v2-4-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
In-Reply-To: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In a subsequent commit we'll add add another caller to `reset_head()`
that wants to perform a dry-run check of whether it would be possible to
udpate the index and working tree when moving to a new commit. Introduce
a new flag that lets the caller perform this operation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 44 +++++++++++++++++++++++++++++++++-----------
 reset.h |  6 ++++++
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/reset.c b/reset.c
index 9ff14f5ed1..a8d7eea4d6 100644
--- a/reset.c
+++ b/reset.c
@@ -92,11 +92,14 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
 	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
 	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
+	unsigned dry_run = opts->flags & RESET_HEAD_DRY_RUN;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
+	struct index_state scratch_index = INDEX_STATE_INIT(r);
+	struct index_state *istate;
 	const char *action;
 	int ret = 0, nr = 0;
 
@@ -109,7 +112,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (opts->branch_msg && !opts->branch)
 		BUG("branch reflog message given without a branch");
 
-	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
 	}
@@ -124,16 +127,36 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (!oid)
 		oid = &head_oid;
 
-	if (refs_only)
-		return update_refs(r, opts, oid, head);
+	if (refs_only) {
+		if (!dry_run)
+			return update_refs(r, opts, oid, head);
+		return 0;
+	}
+
+	if (dry_run) {
+		if (read_index_from(&scratch_index, r->index_file, r->gitdir) < 0 ||
+		    index_state_unmerged_to_stage0(&scratch_index) < 0) {
+			ret = error(_("could not read index"));
+			goto leave_reset_head;
+		}
+
+		istate = &scratch_index;
+	} else {
+		if (repo_read_index_unmerged(r) < 0) {
+			ret = error(_("could not read index"));
+			goto leave_reset_head;
+		}
+		istate = r->index;
+	}
 
 	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = r->index;
-	unpack_tree_opts.dst_index = r->index;
+	unpack_tree_opts.src_index = istate;
+	unpack_tree_opts.dst_index = istate;
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
-	unpack_tree_opts.update = 1;
+	unpack_tree_opts.update = !dry_run;
+	unpack_tree_opts.dry_run = dry_run;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	unpack_tree_opts.skip_cache_tree_update = 1;
@@ -141,11 +164,6 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (reset_hard)
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
 
-	if (repo_read_index_unmerged(r) < 0) {
-		ret = error(_("could not read index"));
-		goto leave_reset_head;
-	}
-
 	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
 			    oid_to_hex(&head_oid));
@@ -162,6 +180,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
+	if (dry_run)
+		goto leave_reset_head;
+
 	tree = repo_parse_tree_indirect(r, oid);
 	if (!tree) {
 		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
@@ -181,6 +202,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 leave_reset_head:
 	rollback_lock_file(&lock);
 	clear_unpack_trees_porcelain(&unpack_tree_opts);
+	release_index(&scratch_index);
 	while (nr)
 		free((void *)desc[--nr].buffer);
 	return ret;
diff --git a/reset.h b/reset.h
index 97ced2601e..9f696382c1 100644
--- a/reset.h
+++ b/reset.h
@@ -21,6 +21,12 @@ enum reset_head_flags {
 
 	/* Update ORIG_HEAD as well as HEAD */
 	RESET_HEAD_ORIG_HEAD = (1 << 4),
+
+	/*
+	 * Perform a dry-run by performing the operation without updating
+	 * any user-visible state.
+	 */
+	RESET_HEAD_DRY_RUN = (1 << 5),
 };
 
 struct reset_head_opts {

-- 
2.54.0.1064.gd145956f57.dirty

