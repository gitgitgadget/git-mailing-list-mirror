Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5F23F262
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997269; cv=none; b=MNbb45wzpVfoP2AdhyfO3QJdYhWMssJzPSidxanpOdHa9zKOYZTOGEudhMBRBedVPJCBlMPn8BFflnqvPr6clZw7fmueAPvq97UuPzWsWn3U/w37WJlCXBKULqgQaKFsf1WV9nn4JsIRIGbHBfmQ/NOVzHX/r87WytVHnRmUG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997269; c=relaxed/simple;
	bh=kZjVe6dY+Cf5lPZfvjuehZJzBZ+oZA7HK2N5iUIMf2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxVJKdV7Nic32957iDi/rsDOwaeCVeHLpJp1eF00Be3fQTfxAdUoxG94vdBeqD9e7Kz5sDSUSCMDZQExYhCpfqMwAZm8FZQPoRTDswoQt6kVwOQJ0OGazPAqtCH33dy39ADMy/ESaXPVE1E+43ZaHPdiA47Zt8Di9irn6Hs5D/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltPQCdaj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltPQCdaj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c2a87378so2349845ad.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997266; x=1740602066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVsytE9dVt8lgyMho7rtHuedXymLlviG1CHSX3aqwv4=;
        b=ltPQCdajBfUYxkWaEdQwh/9Ma8EBkYaIDrYtDnTDnI876S1sHQqVpBw5laFY+ufcEv
         QN7zDqlG79GbAtQjtTXoXCihPAaEP16GegZ+MxGs6q9R42OWqIlFhsKcNYhxsYwx42rz
         OGdHzkG7RwHCG+tuKS03NP2RyAB4I9ZSp1y5bUq8dRs3WCJKHR/qA3+sLpDcshq8COfH
         daW2FkHygkOSohPUDi0VhZreF+79Z6a8OH9FhvrgxA1kRQQ6uRDX7sj9Od+iRy5pj/2U
         8lH+cLgmwFb3CxQNvuXUQRAXJEXduFdEb55giV6VRAiNmQ2YvWV+0Li2nq4OropTG2mb
         2++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997266; x=1740602066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVsytE9dVt8lgyMho7rtHuedXymLlviG1CHSX3aqwv4=;
        b=ksIzVgxKQSeg3NqRElnjFmDQldCd1sWzsl3V//R0rBlrFS5Rn4pMF1VzYYp9iimeet
         rRx9E0kX0ahauD6YibBoU5ai0tIYV56uqNkO95ywzHpsoZbhkgaAGGn8nexzoQtxPxbM
         Wth4X29v8p+UrQRB0Dr68WddSx5QnW6+9FebUjWcZDuoOQdvVUxZyUSaC5KMKwmFYoZq
         kJrt4/PfVgNOq/l6rF0saf1lplfWuwrxiGeZ88wvzXWQ0dhdgsjGJA+mG0HUKTUGDO6P
         ER3RWpvdR/2brwnd9XBvGAxgVaburh/mCcegMnTbf0TLZ4LTjkiEpOev+tV/irDISvqP
         Errg==
X-Forwarded-Encrypted: i=1; AJvYcCUFCfqqZvH7fdCol/AyWDcGmNVxw35LFTJKscNprR3c07OOXcgljYz4pKP6/i4foujC7XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eUNWZvyF7CXHZ/HGjV87g6OCdyTX6fza245bREvGHRmbQgv7
	IFeM419kHYFTz/oA/9HeM7/ubKcSRXNe8+XCseFN6LDlEffC4uWS
X-Gm-Gg: ASbGncuYA7sJIP9Gcg/BsanoQIJFlvweM+GuuyvAwNX/J2q/APn6pqukohplrgMiBDe
	o1fL/nqZBxMglhMbame9PeJi1nawM6fowhhrWDyQd6a1Zr1FodH4iRy7nRb5lpGxkR5CEjBv8HB
	bSZt+egMG08WEvUTAMMDKCtjA1kzfIxCivC16OXS4DuNAdTbW8K+Zajjblrt5dA+DNcjVBdKqNa
	OV0BMVItNJi9XvITEajv72mHmmjEruYnko4HSvL8seFlpFOC2y2LnNU+v1Pxta59dLQZadhzOvf
	lqbn6x4/M6TVc9l4tWCdBf384m4hq3AbfeTn954i
X-Google-Smtp-Source: AGHT+IEPsWGbG6sUoW3GIWntJeXj9lmwVTOQRgczEoP1RPmS/WQA1G18Jym/fMf5Al+OW36Etlt9QQ==
X-Received: by 2002:a17:902:f54e:b0:220:c63b:d93c with SMTP id d9443c01a7336-221040d75a0mr338219435ad.44.1739997266511;
        Wed, 19 Feb 2025 12:34:26 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:26 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 09/12] builtin/ls-files: stop using `the_repository`
Date: Thu, 20 Feb 2025 02:02:57 +0530
Message-ID: <20250219203349.787173-10-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/ls-files.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_ls_files()` function with `repo` set
to NULL and then early in the function, `show_usage_with_options_if_asked()`
call will give the options help and exit, without having to consult much
of the configuration file.

Pass the repository available in the calling context to both
`expand_objectsize()` and `show_ru_info()` to remove their
dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/ls-files.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a4431429b7..70a377e9c0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -6,7 +6,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -245,12 +244,13 @@ static void show_submodule(struct repository *superproject,
 	repo_clear(&subrepo);
 }
 
-static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
+static void expand_objectsize(struct repository *repo, struct strbuf *line,
+			      const struct object_id *oid,
 			      const enum object_type type, unsigned int padded)
 {
 	if (type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(the_repository, oid, &size) < 0)
+		if (oid_object_info(repo, oid, &size) < 0)
 			die(_("could not get object info about '%s'"),
 			    oid_to_hex(oid));
 		if (padded)
@@ -283,10 +283,10 @@ static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,
 		else if (skip_prefix(format, "(objecttype)", &format))
 			strbuf_addstr(&sb, type_name(object_type(ce->ce_mode)));
 		else if (skip_prefix(format, "(objectsize:padded)", &format))
-			expand_objectsize(&sb, &ce->oid,
+			expand_objectsize(repo, &sb, &ce->oid,
 					  object_type(ce->ce_mode), 1);
 		else if (skip_prefix(format, "(objectsize)", &format))
-			expand_objectsize(&sb, &ce->oid,
+			expand_objectsize(repo, &sb, &ce->oid,
 					  object_type(ce->ce_mode), 0);
 		else if (skip_prefix(format, "(stage)", &format))
 			strbuf_addf(&sb, "%d", ce_stage(ce));
@@ -348,7 +348,7 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 	}
 }
 
-static void show_ru_info(struct index_state *istate)
+static void show_ru_info(struct repository *repo, struct index_state *istate)
 {
 	struct string_list_item *item;
 
@@ -370,7 +370,7 @@ static void show_ru_info(struct index_state *istate)
 			if (!ui->mode[i])
 				continue;
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-			       repo_find_unique_abbrev(the_repository, &ui->oid[i], abbrev),
+			       repo_find_unique_abbrev(repo, &ui->oid[i], abbrev),
 			       i + 1);
 			write_name(path);
 		}
@@ -567,7 +567,7 @@ static int option_parse_exclude_standard(const struct option *opt,
 int cmd_ls_files(int argc,
 		 const char **argv,
 		 const char *cmd_prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	int require_work_tree = 0, show_tag = 0, i;
 	char *max_prefix;
@@ -647,15 +647,15 @@ int cmd_ls_files(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 ls_files_usage, builtin_ls_files_options);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
-	if (repo_read_index(the_repository) < 0)
+	if (repo_read_index(repo) < 0)
 		die("index file corrupt");
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
@@ -724,7 +724,7 @@ int cmd_ls_files(int argc,
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
-	prune_index(the_repository->index, max_prefix, max_prefix_len);
+	prune_index(repo->index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
@@ -748,13 +748,13 @@ int cmd_ls_files(int argc,
 		 */
 		if (show_stage || show_unmerged)
 			die(_("options '%s' and '%s' cannot be used together"), "ls-files --with-tree", "-s/-u");
-		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
+		overlay_tree_on_index(repo->index, with_tree, max_prefix);
 	}
 
-	show_files(the_repository, &dir);
+	show_files(repo, &dir);
 
 	if (show_resolve_undo)
-		show_ru_info(the_repository->index);
+		show_ru_info(repo, repo->index);
 
 	if (ps_matched && report_path_error(ps_matched, &pathspec)) {
 		fprintf(stderr, "Did you forget to 'git add'?\n");
-- 
2.48.1

