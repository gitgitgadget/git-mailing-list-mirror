Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084CA23AE95
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959291; cv=none; b=BQ4kTq/M4XuWf+e9OuWY4VIn1Z1HS+uah6a/RasgUkoafAcpl08sVfgMdYweSIdefXN8erPtXRSqkdOgKKFWJMBZ4mC7KnQXINQrUB+c0HNPPE58v6lh7Vo9YsPEHzw6212faoMUj6ZUF90B9nGILwMi/asbV4AhnVK6d3gXatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959291; c=relaxed/simple;
	bh=maMaD2Pf0fTRHwwgCYkzeTNTwJ2MrFip6dalJDi4KAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKCLjW/4vYoH1RSVLa1qKdLYQU7sMNDsnDXTJn5uZtSpNOQQ1n7CRABA6gbfLg5PHWAqWaOGAKiAGiIGK8nb2L3PjJ2oMb4Dixg0n2ipa3kaHyGUTEeygP8TrhcW4hDQT9Qq35ARo+kq1ZAh85rrJDq2lYcOpUJ5TKkWevPekCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iBaFIgQN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iq5USr1I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iBaFIgQN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iq5USr1I"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 07248114011F;
	Tue,  3 Jun 2025 10:01:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 10:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959288;
	 x=1749045688; bh=ZiE2oD1zXDTB5eMMSKvACyyEngn1qpxKfEfKXVvfASw=; b=
	iBaFIgQNNzFaXG6nMcwzA0jEuNXWH7eaKxEDPfRePFaDSi+cL6h1vrASgje60fW9
	Cy2Pea6VdQQ8Fh7lWwXybcHEjhubIVdv2BC6vmeQuHicMn5OMpiHjewRaynNRWq3
	2MjZLUMOLf/vHsL4/eyCFrCU6vZIEaXOpCnvQdHNA2bRp+0rpnviio4HRcmZglac
	z8mBuvj+bhGXNirWwVVGe9iDyIO7t/eqpO9jyERU2RtT6uEuWM1JinxpH1bShP2j
	Y8wWTDGrLdrZJoIoXc89af8W426NJmuase9exRol41ZETt8lUw6l9omfYdWzofJM
	EuapHtH2G0/Ous1VmB9Mmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959288; x=
	1749045688; bh=ZiE2oD1zXDTB5eMMSKvACyyEngn1qpxKfEfKXVvfASw=; b=I
	q5USr1IT1h2m1rDu4Bo31Bh0b0X2SDVCdrn3xy2DOYgMpLi6qkq2memRZprJNuOG
	IXM7ioKENHgeE08PPUx1EcK801BL9TZKMN0VYGs2k79hnT2OUzt7bbicUBUr94by
	gf0aJSNuMB8Nv3EAGz4wEZPcWLbU6iO21QNrHKwXszYGsXwkewaCVwgHkDo1QTVy
	T/atzqN/5E9Zg7a0p4MyFUwEL/rhqFGt0/mR8VxQGxtWAiXF/Bp2ENTIzpUFEKd3
	zplGsAGBnOITzxBbbSyGHEZP+e2ss0THVJFWrnSFf2L6smzHQ4JnUs89R06LG+Up
	d8skzd8JBn++mEvKUnPqw==
X-ME-Sender: <xms:OAA_aM9K1Kft-UF3E1FRCl5VHwP6pXNRlDUGThDXND-gMwdj5me5tg>
    <xme:OAA_aEvwY_ESCVLgriKx2qN2xRHU61sXMk_vK_on-1OgBGTQ72hmJUWWXsJX-KT9x
    Xr4Bd49JeNOz7DRyQ>
X-ME-Received: <xmr:OAA_aCAK9RdOXn2Wrb6B1uMQ8RKYwXduB3ni2zF9noC4wZMH7WtMaTcplH71iYb0-5slR-00VgmndOyR7SipEZl40_I4S_kB0p6KaJ2dVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkh
    hsrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrrghmshgrhi
    esrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepsggvnhdrkhhn
    ohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:OAA_aMd70bSEckCWsSR2het0pRNsz5zdMw58h23KG8PQV1FYK6fDqg>
    <xmx:OAA_aBNCHhy-8JrLYbP3-IF7x7WPlBsLl-ckTm6HOuCb_-gLu9d6SA>
    <xmx:OAA_aGnQqQyVXUznZvyFPNoAmJgiUFj_MtR1otUMvJ68tf8cSMx1xw>
    <xmx:OAA_aDuk9ZZXe5X1RGXGaU2yXS5RlxB7t1dZsDPPsdci6W9GSzH7_w>
    <xmx:OAA_aMOPcysxhwNiPlQEd4MFMi9_3uXfy6Uogo97Imd8UMGT4r0Q8NCj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 13a71ef1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:18 +0200
Subject: [PATCH v4 10/12] usage: allow dying without writing an error
 message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-10-52f5cf7b7e99@pks.im>
References: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Sometimes code wants to die in a situation where it already has written
an error message. To use the same error code as `die()` we have to use
`exit(128)`, which is easy to get wrong and leaves magic numbers all
over our codebase.

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
2.50.0.rc0.629.g846fc57c9e.dirty

