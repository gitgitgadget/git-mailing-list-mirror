Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67A368260
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384185; cv=none; b=Vr8e8S6gi3w6X6eIV5NvNZHY8eeZU9BkxsWZb1SQ6qBCPSSmqLvBagQAYkYQBsp3ql8lybNVCmKH1Yt7JzZ4qM9qTMhTv1zic+sGFHzFOH3YDQe6eJNFJ/qmFf0wom5fi6Ia1Oia5bVwpH3uTWSZzpvTU69+83Wq1+p+6x7bh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384185; c=relaxed/simple;
	bh=mXeUwRR+zKhyUYeDKpK2DlYXTh0o+jQGmcb15BDfmt4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=chsaDcsMsU9VmFdtwgjbAbr/yIMS1QNDp0hsHmaFcdd3wU9Cpn0GcTtAh38S6BwSShLoa/MzRGAChK45TDII+kJY1eqVv7Q+xiEsyZKOKfY2yIZIrHktuc+Onq6bm3x+0K3LC8fSmDUloalcLNDjIXRL+ZeowJCHKQKlKxgu41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7jhLyew; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7jhLyew"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3057905eec.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 05:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770384184; x=1770988984; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c4Hi9VeW6Sch7oz86sYAybCT+hK00MonnSVesYMBPM=;
        b=O7jhLyewwe6YzhSdTRQQ0kDuvMiuf3n8BNjIGMV6R66O5TzJzTgOQfeHHmmMS8+Ibz
         2jCAr4g8D/4R18v/Nnm2ZJUXz0mFH2Uh226f5YDUmnO9B4Kmy92TtkHsCBGT8XHe5A24
         UEqPDGEmKaHIwl67h7i5Iy7JOcorZNglCZvGgxyY/idBNh3ElH7LslwYaJCPm+YVqhDN
         mvX+As7qPTZr0xyXEGaidsxL8JcEwIT06jsTDLi/Kaesbf0BOoWdhvFKgS9T5DOFd71Z
         NgXitoOwXfC48DvvmnLmPUAHp2JemmbnENRvE6xbfCDv6obYB3gF6iTj/P/wxvpP8M/v
         LeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384184; x=1770988984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7c4Hi9VeW6Sch7oz86sYAybCT+hK00MonnSVesYMBPM=;
        b=PF7T7MyJ0z2ovTlhWToen5DYVomZUwBXm+HSnQcULO25SA0e8Eq31DoV1z/2mVe0eE
         UiuSZvDSCm48JTI4o7Q+WgnHMXWJ9bPjR8bXj6CX7u5FEpgtoXHv9y1x0uxSHInFJDAD
         +5MToKSoeJPC77TFOg7bIpGurt0x6qINzWFzyj4vivxswcYB+Jfdn4XVnJyak7RgfsXY
         D9bf3jMG1ajV9l8JYBj8iDI57cQ+NO6Z9bIuuQKaZqtZ3MVlpnyR27Kb6uED8MCzWrgy
         4vpbRpwozVyAV4wZqTRNk9pH6D0KAY7YQ4TLjGOLdNqJ2505CYXJMmulAczhO2AySJtd
         DuJQ==
X-Gm-Message-State: AOJu0YzkmGay+3IWKr0KgjV8EsJWjlQCNlQHK1lIXBpjtxZyGNCazvEU
	pMzqcYFHX1faGDUASUoAMK7x9wiUkJAmS2+7tZRXhINzKFv9G6FbHCXBUE4u7A==
X-Gm-Gg: AZuq6aJlVptves2hJZ1Oi91YYTzKfmqJyuT1mafZFi0i7ouXUAl1yLLHsddvLhvxd4y
	ax7m1p56t0ocK8Hl8xhtH9NkvB9faQFlrX6HagHdDCDa6NrCASgkLRfA5JvpYLrXcGCk7Nf3zy4
	PMI9YFlkzpgHxjmDAHufOQdUQMH2w7xff3ivtM/zIkYydQnni7IlW2FwQRkizQKRXqxZ2GLM04X
	TsvJUr0i0jrRN+9Q8FCauEptgc4bTg/1+L0362IvA0P+Ucg7Djdc1Np43FGy87DMHMLciq3yUH0
	hnRC8nvcfSnBHuD6X+EzCx/pYsi5Sdx3fWcVcKe5+I6CLLzZGAbC2r9DKUoqggyVzKwOWJlEswQ
	pcJf/M1WLVQD6s3xmLZGNG3cEFGZpFUy1lAwjB/iJwNsTI7SAIoAOeQXrtEfeiyRFLIH/PB81wh
	UeJ5UGWtTKZegPDglQclr8aXu4
X-Received: by 2002:a05:7301:1293:b0:2b0:4fcc:4c69 with SMTP id 5a478bee46e88-2b85647c805mr1126243eec.16.1770384183860;
        Fri, 06 Feb 2026 05:23:03 -0800 (PST)
Received: from [127.0.0.1] ([57.151.137.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af78f5sm1680390eec.12.2026.02.06.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:23:03 -0800 (PST)
Message-Id: <69e0065b1bfe469c25f023592a5a6600d49348dc.1770384180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
	<pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 13:22:56 +0000
Subject: [PATCH v4 1/5] read-cache: update add_files_to_cache take param
 ignored_too
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

The ignored_too parameter is added to the function
add_files_to_cache for usage of explicit updating the index for the updated
submodule using the explicit patchspec to the submodule.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 builtin/add.c      |  2 +-
 builtin/checkout.c |  2 +-
 builtin/commit.c   |  2 +-
 read-cache-ll.h    |  2 +-
 read-cache.c       | 10 ++++++++--
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 32709794b3..eef4959ee3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -584,7 +584,7 @@ int cmd_add(int argc,
 	else
 		exit_status |= add_files_to_cache(repo, prefix,
 						  &pathspec, ps_matched,
-						  include_sparse, flags);
+						  include_sparse, flags, ignored_too);
 
 	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
 	    report_path_error(ps_matched, &pathspec))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe..88d6a68022 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -899,7 +899,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 
 			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
-					   0);
+					0, 0);
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..1a00642090 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -455,7 +455,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, ps_matched, 0, 0);
+				   &pathspec, ps_matched, 0, 0, 0 );
 		if (!all && report_path_error(ps_matched, &pathspec))
 			exit(128);
 
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 71b49d9af4..2c8b4b21b1 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -481,7 +481,7 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags);
+		       int include_sparse, int flags, int ignored_too );
 
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/read-cache.c b/read-cache.c
index 032480d0c7..0f4981d79f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3881,9 +3881,12 @@ void overlay_tree_on_index(struct index_state *istate,
 
 struct update_callback_data {
 	struct index_state *index;
+	struct repository *repo;
+	struct pathspec *pathspec;
 	int include_sparse;
 	int flags;
 	int add_errors;
+	int ignored_too;
 };
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -3925,7 +3928,7 @@ static void update_callback(struct diff_queue_struct *q,
 		default:
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_TYPE_CHANGED: {
 			if (add_file_to_index(data->index, path, data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
@@ -3946,7 +3949,7 @@ static void update_callback(struct diff_queue_struct *q,
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags)
+		       int include_sparse, int flags, int ignored_too )
 {
 	struct odb_transaction *transaction;
 	struct update_callback_data data;
@@ -3956,6 +3959,9 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	data.index = repo->index;
 	data.include_sparse = include_sparse;
 	data.flags = flags;
+	data.repo = repo;
+	data.ignored_too = ignored_too;
+	data.pathspec = (struct pathspec *)pathspec;
 
 	repo_init_revisions(repo, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-- 
gitgitgadget

