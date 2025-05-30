Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9A23645F
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617732; cv=none; b=HJYOBVrFlbzQlhAMw7NzG3nD0Cp1yosGlrZdgAqN4DF+gP4Xn4gRG76G4AAgGidYg/84f0ufwb3yIC4EQ6fiS0odF7dCC3MuM4+bKii1JB2PJu2DcnhIWEXqS5oEzKCGqJ09apLIUJLuLFNscKxdW6cXlnIYj5e4h9liBBSSKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617732; c=relaxed/simple;
	bh=klIvlUozUNR4EKyfWBwcr71R+EAmJtfdpe6Y1THxnyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yqa3GXHi9vBvTvIPVHtHRMmjBd4f7/w3aA6XGY6HHnCRH+8wZ4NXZrN4m0m7AfV6NBC5QCLD+0z+KPKvyV/yciIX4jPe/pCxA1aTwVQn8ow33JxGrjObaOqac552yfjRkpbbHHHQy/f1Tus69I1/4jQo2KjPROGZTqgGrQ2QYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I7bS0TP9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSK6FZPQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I7bS0TP9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSK6FZPQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D29EB1140124;
	Fri, 30 May 2025 11:08:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 11:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617729;
	 x=1748704129; bh=Rd3Ifuitvexhes+1KD4PXkyaG3HgpNcmy+nDXqPW7L8=; b=
	I7bS0TP9+z0s0/LYXup2fViZsPT3NHmE8w1KjxKAtR8Llnoh+uGJzr2mXQlQkr/a
	EKOyokWhSW+l417+AscjvlMr1iab2UpNP2xNg9+n+WwepSEIAh1olJIVSYcfZimm
	NuQIKboXmnpBxQueeofxcfBRuoKDpnq4VAdn4yLox7bOCev/39tFHxYCSPgHYuYx
	4u/5yyvh7JjPsRKXOtguDAtWarvM9wx8PVtp7e7fneupE+/ki4lyFiVXNZmPX9t9
	pxZbmpBcUNDIrqtQggMc5aq6IxUhDcaIoOGAOf1ok8J/nqibKTg5nkvWvQZ37AK2
	kQqiseiwb3Cc3qLXBy6dZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617729; x=
	1748704129; bh=Rd3Ifuitvexhes+1KD4PXkyaG3HgpNcmy+nDXqPW7L8=; b=b
	SK6FZPQdUfG+6TdBHmv9gK7/k2SkiaOdSoo+fi89kb3Sa7zC990dbVpK518gwDVN
	FUy34RqcSfK1nzOMdhYhBNZnc939vfXOkPzJFF/OE6GF+5n4GR9LMltVdpb1n3LI
	Q+OE24+UZgodhwxANz/4cruTC9py6jq4O6Tmu8AjAi3AOOHw1B+lE9iPQzHQu/7J
	v0oBW5ZbRjFd3z/17iAEIzd3o9YY9bwbbaZm2SgjOkqC4qSuijzZQgMesfTYye0f
	Y87j58xuSo6t3NJWKOjCepU5CdkvrcBwWPKHAmarKJu+/7I6IQO7yH+ffd/I4+rq
	2oCxm6hSGKp41WayeQAEA==
X-ME-Sender: <xms:Aco5aGYCKzp2N_Dc4a4qyYdTbTY8jMqpCt8_LO4PT2w8kS2pljmWWw>
    <xme:Aco5aJbFdVrvDSG5T3VPp1QU-FFpgehn11WbcyXgjSxo3QrYQJWrcA6Tmhmtr4Fgf
    4vbd_IetFwnFLwMEQ>
X-ME-Received: <xmr:Aco5aA89UoWzjIXIwE_XnaweUs5_GCW3PJ5qTh2O1oknda2nZ9c3V0i66RXsupcapClNmTNz1Dm-8Nxo13A-HvWpQXHNJwi2x2aA9-jtww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihrohhthhesph
    grlhhorghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhs
    rdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomhdprhgtphhtth
    hopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Aco5aIrlljeJ6N5ljedPK-SGEJX6wKNBydZgbFrutAnWgNRX54U1_w>
    <xmx:Aco5aBp89cCdzUxgA8NHf1bjOLCRFqGxwVlxljebV4mr97qZBhMXLA>
    <xmx:Aco5aGTP4yqbk6JWlf5-yp23VXelD1ACD9ZIbvt5E6iPlxyl1o3sqQ>
    <xmx:Aco5aBq3IEqrQ2-tKu4OLEgiTQpM8BXOGpzhXaRclzRjKZX5nbvG1g>
    <xmx:Aco5aJfZMLdgfuPL0TFjzjQiFU7w9_OcUg7Ifp5BP5zu0TYvw1lYAzAZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 609f52de (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:36 +0200
Subject: [PATCH v2 10/12] usage: allow dying without writing an error
 message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-10-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Sometimes code wants to die in a situation where it already has written
an error message. To use the same error code as `die()` we have to open
code the code with a call to `exit(128)` in such cases, which is easy to
get wrong and leaves magical numbers all over our codebase.

Teach `die_message_builtin()` to not print any error when passed a
`NULL` pointer as error string. Like this, such users can now call
`die(NULL)` to achieve the same result without any hardcoded error
codes.

Adapt a couple of builtins to use this new pattern to demonstrate that
there is a need for such a helper.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/am.c                |  4 ++--
 builtin/checkout.c          |  4 ++--
 builtin/fetch.c             |  2 +-
 builtin/submodule--helper.c | 12 ++++++------
 usage.c                     |  2 ++
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e32a3b4c973..a800003340f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1000,7 +1000,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	if (!patch_format) {
 		fprintf_ln(stderr, _("Patch format detection failed."));
-		exit(128);
+		die(NULL);
 	}
 
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
@@ -1178,7 +1178,7 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 		strbuf_release(&sb);
 	}
 
-	exit(128);
+	die(NULL);
 }
 
 /**
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d185982f3a6..536192d3456 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -838,7 +838,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		init_tree_desc(&trees[0], &tree->object.oid,
 			       tree->buffer, tree->size);
 		if (parse_tree(new_tree) < 0)
-			exit(128);
+			die(NULL);
 		tree = new_tree;
 		init_tree_desc(&trees[1], &tree->object.oid,
 			       tree->buffer, tree->size);
@@ -913,7 +913,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 						     work,
 						     old_tree);
 			if (ret < 0)
-				exit(128);
+				die(NULL);
 			ret = reset_tree(new_tree,
 					 opts, 0,
 					 writeout_error, new_branch_info);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index cda6eaf1fd6..b0800ea5829 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -992,7 +992,7 @@ static int update_local_ref(struct ref *ref,
 		fast_forward = repo_in_merge_bases(the_repository, current,
 						   updated);
 		if (fast_forward < 0)
-			exit(128);
+			die(NULL);
 		forced_updates_ms += (getnanotime() - t_before) / 1000000;
 	} else {
 		fast_forward = 1;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116ddf..4255caca579 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -303,7 +303,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	char *displaypath;
 
 	if (validate_submodule_path(path) < 0)
-		exit(128);
+		die(NULL);
 
 	displaypath = get_submodule_displaypath(path, info->prefix,
 						info->super_prefix);
@@ -643,7 +643,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	};
 
 	if (validate_submodule_path(path) < 0)
-		exit(128);
+		die(NULL);
 
 	if (!submodule_from_path(the_repository, null_oid(the_hash_algo), path))
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -1257,7 +1257,7 @@ static void sync_submodule(const char *path, const char *prefix,
 		return;
 
 	if (validate_submodule_path(path) < 0)
-		exit(128);
+		die(NULL);
 
 	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
@@ -1402,7 +1402,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	char *sub_git_dir = xstrfmt("%s/.git", path);
 
 	if (validate_submodule_path(path) < 0)
-		exit(128);
+		die(NULL);
 
 	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
@@ -1724,7 +1724,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 	char *to_free = NULL;
 
 	if (validate_submodule_path(clone_data_path) < 0)
-		exit(128);
+		die(NULL);
 
 	if (!is_absolute_path(clone_data->path))
 		clone_data_path = to_free = xstrfmt("%s/%s", repo_get_work_tree(the_repository),
@@ -3524,7 +3524,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	strip_dir_trailing_slashes(add_data.sm_path);
 
 	if (validate_submodule_path(add_data.sm_path) < 0)
-		exit(128);
+		die(NULL);
 
 	die_on_index_match(add_data.sm_path, force);
 	die_on_repo_without_commits(add_data.sm_path);
diff --git a/usage.c b/usage.c
index 38b46bbbfe7..cd7b57d6446 100644
--- a/usage.c
+++ b/usage.c
@@ -67,6 +67,8 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 
 static void die_message_builtin(const char *err, va_list params)
 {
+	if (!err)
+		return;
 	trace2_cmd_error_va(err, params);
 	vreportf(_("fatal: "), err, params);
 }

-- 
2.50.0.rc0.604.gd4ff7b7c86.dirty

