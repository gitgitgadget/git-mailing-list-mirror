Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696C1BD9CE
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848664; cv=none; b=YmOeHvZkfptil+JHxAcH88RDCYcwOQWGMb5hv9yUIKW98Rtw8aou8L/d5y04xY3o3Yo5TRSZwWQhstp2NtUszm7lT97On41W21UCwvRMb7JmWnak9ctxhgS+Wx47q5SfZWOz1yOjuiNxlRDiUENWLtyo5qES6JR7h2YcZX59V8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848664; c=relaxed/simple;
	bh=Y6gjQW7iNu6ALBOYFOTEpPDAVDtItQnZH9kptsXELx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kf7BMNZsUb4VmCuREhFd2V13fhYX3Qr4tyXKmItIbSRUey7W2EOME0+Wkt/ABJN349kVlz/SqBKrpf7NaclD2eXeodAo6Zmtij5COcUnR3rAtWdJkHL3q8PS+EEd4aUPBn3AKWxZnDLf04caSPQBGRJJh+AEtkTMd53LfHJLRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=boB21kiG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VIkpTvAZ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="boB21kiG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VIkpTvAZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 03FC6114011C;
	Mon,  2 Jun 2025 03:17:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 03:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848661;
	 x=1748935061; bh=kPdZiRHbnKoigdcSfVNzfa8VHc/mK2LhF89DHsz+EDY=; b=
	boB21kiGEV5kQLn4q2+8Da18c987w776FE9CL58fsvoOIXigCv24cB75P4e5rjOA
	bJqpJAxE+s53Ct3hKrc4AGv/DlVngnsLiR7/CtLcON/2Vl1QJNHcRir9oGzhgjIO
	1Xumw76N4mM47/3tUXEUPNWXNkbXJKcl1leo7qS6NgNnff2Q+GHifF1mEL9GfJhV
	WEKjb4AriHXq8xUokw5oGFc2naBbfSaXiVqOSvJF69CVYBu930R2kyv+Ixpfdcnu
	ub+g7y2dl+ZJOc5CPqCgZracT0txXltvlG12p7s6yE1biCwfp/PochRrUFRlizqB
	o++JgrjMNjYfe7ThSGUvIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848661; x=
	1748935061; bh=kPdZiRHbnKoigdcSfVNzfa8VHc/mK2LhF89DHsz+EDY=; b=V
	IkpTvAZpKOZCpxQq+CLL80y32h3r27JKTidhpi0HrZ0+V9yIIEhNHWriAFDaQ0kq
	1JtNFzLTSEoCSS8bLa8JX2BINs5PReuT72XfpLA/RzTUlMvLjgrXgR6hppASBpNW
	4LONk1yAcLWHfT1RHXBwDNMLZqu/XUURzZRbwjqQYox7yTrk5D5FwFORnsiXGuyr
	rtu4+0XD4HfHkgq2mFfAwtVickySJly4rts2gQvfuIDikLG71SpbdjRtUSLUA/T0
	1RQpYfgvrxODW9hw03D0C0PzdQvJqgPk/xaA1F6j66Z087ane5ofjujsirmd6/QA
	E+LI0U8QkflL1Dw2+mA8w==
X-ME-Sender: <xms:FVA9aCya1veOLky9tGvsbMqbXW27Dx1VIaxZEG3NBj8_euk0Y8Iqxg>
    <xme:FVA9aORIaeUPXMxKrJ_dlJY5iGJ2mtjfCPZOFlJawAqfvAFWkaVXgTxuJp1UhHAjx
    vS-jsSNbtitYR_EgQ>
X-ME-Received: <xmr:FVA9aEU54SY1BH8DSTAwRgASuANJG1guqo0UCC_qCaOJeI9BWCdlXcTp1QCBvfMuaHvzdKdFIzePQ_olY8xfU5h5-tKHY0R5PqrDer4FKR_Zmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhs
    rdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomhdprhgtphhtth
    hopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:FVA9aIjM2M3dHSxj6288MiyUfToALey23Nu3-enll8l4C2ogBdG53g>
    <xmx:FVA9aEAKtSaCPxk2sZJynznKoS8m55I-8ashJ5-XdQnXQt6svKilFw>
    <xmx:FVA9aJJ5MZab5a9tCIze1dwHtyA4w0G-dKWjTJs93V-b1GZbGXnJmg>
    <xmx:FVA9aLCAf4crOWNOOHHmo433v3ifR2J06M9ahlYQGP9Mz7069uO-Uw>
    <xmx:FVA9aA5F6rXfoy-HyUGRXj69IDUqTDeDglCYHPy3PxUJFjZwVRQB3rzY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d12af3e3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:36 +0200
Subject: [PATCH v3 10/12] usage: allow dying without writing an error
 message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
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
2.50.0.rc0.629.g846fc57c9e.dirty

