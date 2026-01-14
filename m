Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01D237A4B7
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376890; cv=none; b=I9rPvDpqifvaf49+cmfQPxJfCUJIAbNf66HTtMg2nM0fX/eweUN7jNpFq7UNgo5WGoSMWQltppOk/NtXl7F5gXalBofXoZRjvSbrXWVFh/OVsrtvYmYH2fg+4kSUSj7YRFNwx3j9jTHW3f4nTOoIipNwVz27uaaTZBxnw6duigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376890; c=relaxed/simple;
	bh=t0Fo1Jyj3okapT9eyzjfdiq0cIsRpbAjfSWNtwY5dUg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CPwpTULVzzvX2lKGssALhp0doE5n3Gpahn+mp10fdBkDkTgDZwn5xkz8mYAw0LZbL4An9ZJhQmRhur4/uc7B1vpxSDMeMfHeXNJDV6noXJcAVFSo6QghEDIuKH2fCkxNw9rBOS/LXVdifM9Pj+aDnW0V4agCurcaHZAXphoMS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy38KCDF; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy38KCDF"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ae57f34e22so9207336eec.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376885; x=1768981685; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odlSCh7aFl0gEM4RIadNKfjO1CskfnuiS68uoU02mT0=;
        b=Cy38KCDFae0TGvXfVU9adtbTa4ZrTGKZiCthwObvHVbpiGdUAjlII1umnPTsERPafC
         BJZcjlKxASbiXQ2wh1ZZ9MwW/xlFkqr1OORpJ+V3DdidjnFM2O557uTusJyRoEUOztA0
         60PSENPiEohv1DhphcDoCVL1wICW+tpuf+2pi4sw/itme7d2fPAa2SeZkuF73RTNtx4G
         mAAve0cPFxD4CN7Lrm2tIDqhye1A+SCej5eJVNn/G1YqLOx6qDief2ymn/7ZXGrIO+ex
         W83xzN075ezAgOAmgSOjxMLIhc8npZrDSYFdQ1GuUtxbd9i78T28c74S5MW+Tu6XW2rb
         9YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376885; x=1768981685;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=odlSCh7aFl0gEM4RIadNKfjO1CskfnuiS68uoU02mT0=;
        b=iKBrQGwHwQb/pEt7K570hMKK9EY3PrjFc4OIoqjiVm5zEolNAPyn9l8LhuELEedB7K
         OpzLKCgfWVMQU6hhnQkqczHcirVHUXXqzcnvg3nzk+KeEHn4AC/hWT75kY98DQw4Ztep
         OeWZJ0Xbp6QybEYxrkskVSCHzX4zofzWXM4vgoOwubC7ZANEIzVjwjcaaJSKyXu2j9ID
         DmtS+BTNmUpYmYHnDsCPmm2tdZIP6kjC22axOH5loG1A1Z9AvwLJ9jsh3gnYVtpqajJo
         zDpMsOBNhqZLn/iy4riAVwqr4d8v9ZuRshVeursQB1A5I7SNmc3dbfarj55i7BgRtGcB
         4MaA==
X-Gm-Message-State: AOJu0YzUuA5429k0PqbHejcfHf3++DacdsOg8YhNTBPAeddEZnMIlAWq
	GwTKfa6yHDjJL8blGHP5+g1tv/JDINrdALzLAqFXnlnKjxMeWJLqhPtOi+7X7Q==
X-Gm-Gg: AY/fxX7nHTWM5gZj8rMbJndPXPjPnEOni7RAygWeWe7UOw43uj1oki/YBy01kJ0bCsF
	PZ7BdFWeXcEOGNAnwlW+aitJaoYuZG4qaNUw1/7W1X1rbwuMhP5bR7u/KclA6Bpfw1EjUsLdvQc
	LvmO8L+e86Wq9bblxjTTFwBd0rEenuldyGBGrrVrE87E4XoEzlirrHVzUIGa+aQFZ4iEcgo/XLu
	ZPIYovExxmwyRZzOjjybynYOkLZhHvGsT+3N0Eizor4GxDLAQAi7RCNYOuZ3pmHRiaOL4Yzq7v8
	0dfzirklhpJFyRll7gvpms2bqF3yeyg70s7MMQGKSOc8GXfVjHUBuz4cuVG7YXMA+3QSpKae52m
	OaYHjO0Hymc4gR86mSN7RvBxNCk5KlLfzkNDZ3ibT5sCRhxfS9vMrmlGpMhWkx+AK17xPmsLLGI
	ZlQxy4exhCEvYQ6HLNPJ1ToVL9
X-Received: by 2002:a05:7300:6901:b0:2ae:5bde:a5c5 with SMTP id 5a478bee46e88-2b4870abc8dmr1777026eec.30.1768376885134;
        Tue, 13 Jan 2026 23:48:05 -0800 (PST)
Received: from [127.0.0.1] ([128.24.160.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170675076sm19755415eec.2.2026.01.13.23.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:48:04 -0800 (PST)
Message-Id: <de72bf0a9135224ed4c4a05ae00deadc28225ac0.1768376879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
References: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
	<pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Jan 2026 07:47:56 +0000
Subject: [PATCH v3 2/5] read-cache: submodule add need --force given
 ignore=all configuration
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
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

Submodules configured with ignore=all are now skipped during add operations
unless overridden by --force and the submodule path is explicitly specified.

A message is printed (like ignored files) guiding the user to use the
--force flag if the user has explicitely want to update the submodule
reference.

The reason for the change is support submodule branch tracking or
similar and git status states nothing and git add should not add either
as a default behaviour. The workflow is more logic and similar to regular
ignored files even the submodule is already tracked.

The change opens up a lot of possibilities for submodules to be used
more freely and simular to the repo tool. A submodule can be added for many
more reason and loosely coupled dependencies to the super repo which often
gives the friction of handle the explicit commits and updates without
the need for tracking the submodule sha1 by sha1.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 read-cache.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 0f4981d79f..cc79b25f43 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -47,6 +47,9 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
+#include "submodule.h"
+#include "submodule-config.h"
+#include "advice.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3910,8 +3913,68 @@ static int fix_unmerged_status(struct diff_filepair *p,
 		return DIFF_STATUS_MODIFIED;
 }
 
+static int skip_submodule(const char *path,
+						struct repository *repo,
+						struct pathspec *pathspec,
+						int ignored_too)
+{
+    struct stat st;
+    const struct submodule *sub;
+    int pathspec_matches = 0;
+    int ps_i;
+    char *norm_pathspec = NULL;
+
+    /* Only consider if path is a directory */
+    if (lstat(path, &st) || !S_ISDIR(st.st_mode))
+		return 0;
+
+    /* Check if it's a submodule with ignore=all */
+    sub = submodule_from_path(repo, null_oid(the_hash_algo), path);
+    if (!sub || !sub->name || !sub->ignore || strcmp(sub->ignore, "all"))
+		return 0;
+
+    trace_printf("ignore=all: %s\n", path);
+    trace_printf("pathspec %s\n", (pathspec && pathspec->nr)
+									? "has pathspec"
+									: "no pathspec");
+
+    /* Check if submodule path is explicitly mentioned in pathspec */
+    if (pathspec) {
+		for (ps_i = 0; ps_i < pathspec->nr; ps_i++) {
+			const char *m = pathspec->items[ps_i].match;
+			if (!m)
+				continue;
+			norm_pathspec = xstrdup(m);
+			strip_dir_trailing_slashes(norm_pathspec);
+			if (!strcmp(path, norm_pathspec)) {
+				pathspec_matches = 1;
+				FREE_AND_NULL(norm_pathspec);
+				break;
+			}
+			FREE_AND_NULL(norm_pathspec);
+		}
+    }
+
+    /* If explicitly matched and forced, allow adding */
+    if (pathspec_matches) {
+		if (ignored_too && ignored_too > 0) {
+			trace_printf("Add submodule due to --force: %s\n", path);
+			return 0;
+		} else {
+			advise_if_enabled(ADVICE_ADD_IGNORED_FILE,
+				_("Skipping submodule due to ignore=all: %s\n"
+					"Use --force if you really want to add the submodule."), path);
+			return 1;
+		}
+    }
+
+    /* No explicit pathspec match -> skip silently */
+    trace_printf("Pathspec to submodule does not match explicitly: %s\n", path);
+    return 1;
+}
+
 static void update_callback(struct diff_queue_struct *q,
-			    struct diff_options *opt UNUSED, void *cbdata)
+							struct diff_options *opt UNUSED, void *cbdata)
 {
 	int i;
 	struct update_callback_data *data = cbdata;
@@ -3921,14 +3984,19 @@ static void update_callback(struct diff_queue_struct *q,
 		const char *path = p->one->path;
 
 		if (!data->include_sparse &&
-		    !path_in_sparse_checkout(path, data->index))
+			!path_in_sparse_checkout(path, data->index))
 			continue;
 
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED: {
+		case DIFF_STATUS_TYPE_CHANGED:
+			if (skip_submodule(path, data->repo,
+								data->pathspec,
+								data->ignored_too))
+				continue;
+
 			if (add_file_to_index(data->index, path, data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
-- 
gitgitgadget

