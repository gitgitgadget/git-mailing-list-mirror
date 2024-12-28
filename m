Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB435952
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735380467; cv=none; b=kgY9nIgYanpRsUNiCXEmSOvAE5fywinRnEAgyANaUqRyyWa+n7LUpLRNHAE3YaBI3IxXo5ToKRSjGvbWETh4ox5ZOOiXcVc/vTSGcjFODRkjwVp9CwU/E9mUfyeCct8V06G7NPLSoo68oIK0mlcZMSUespcPK61gKRmFfV7RaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735380467; c=relaxed/simple;
	bh=u9Z8y0f6SDWnX4CfExn7RHytw1QwrekbOZi4Nnzj1VA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=aG8Q9/H2KKP+ON+W2VUf00zCgqEpjqIHKQIl//8jWlCWbB1bkGQUO3Krw82m8sODtoK9W5+398wZiA1DUm647ViEsLjn605nOBhp1dn5w+hJUAQpTlmH27aaHad8dHhl5W+FDrxtQaC7iR0aDFOo5CANx+tgz0SzJMg/gkWHlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWnmky93; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWnmky93"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385df53e559so6128186f8f.3
        for <git@vger.kernel.org>; Sat, 28 Dec 2024 02:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735380464; x=1735985264; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFbrw3U+WHrB1oi4DyHs4s2N44TeyAswWHYdRF83lUs=;
        b=MWnmky932Hvq/wKhLVYbt6qvRVaf6k0oam3XvN2FGa09W1BtpIiZSGZr3OdTJbf5TU
         K5bvF4CKg4kXqIKn8QMOkC9w9wKg7L6SoUS91yLFY2z6QVstrRtx7VgrEqaj0HJcYZvk
         oMDixqSPWsO07UPISIBhYyFcgZDaOhQ1yOl2f4/nUaVfOT0DnaQajjcR8n2mkcnMiGfG
         w3477YS3QnRWWUBVwuhZ5MG5qiVv/+rCbLxaTv7t6PIF272XXXgrOocAeYWhmRxaImzj
         xFVt2/Lw7HrKaZINV3/oG20HpU2CGVD9gmPget/q/mLtpYe3skQ9bJyTWr2lw1EHHWnK
         pLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735380464; x=1735985264;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFbrw3U+WHrB1oi4DyHs4s2N44TeyAswWHYdRF83lUs=;
        b=QbHG7bkvrg27TIuUi8Fx0G6Pj8nRONI9MFGqCu5ZRzY6An7syXzWBwd7FvVpY7/9v4
         4+ACb1r1FOGrr8As+J4LMkEs8RnEL96dohCorPUQlfRfkkpSpPHUtAsQklAtrZ1A97K4
         oAhFrBG2Vo4zp8lMPcY4n2+NzLmib8Nqi8LfC7pUB5N6UcofMUlY1MQrqPmanAL4Wsie
         GYerdwGVNTAgZZwFkAx/LAZzEl031E+42hnPwwiwKNbiKsuKW/8DqxNRvI6KCt0RAZpu
         NydU44DNFj7bzX5cx4NJBfxn3qzZKqY38gkAvAWFAvfeBmF+Gt7HJt63J5rmfjER+Ky+
         k7Nw==
X-Gm-Message-State: AOJu0YzsHykhmtMfIJIsnfaWwH8nNZWsEiFRrxUl2LnfMSeXigq+4u6z
	/uhQDcShpX1wvJTFhJeu+GRyH8eY+UwC4Ne4xj3UNnuZryqMt18yAbX/XA==
X-Gm-Gg: ASbGncuTAhLdy6NYbkOnuxdBnN4ayQ5fmA77fRZglAzAZI5yCt3Sb04wmHtZerVETzz
	GP1eAU0jyMG9p17QzwCuuQXH5XyuZ4vOJiFRR1OabLum/dCEKHVcHQPtkdEVNK1//98o8EkMksH
	yzIZHJN1OfkLczyjef0uq2ly1Vbsmxisyik++vKZoQX+iAWe1NMaUvZ30X++nKAjgDP3Em5KHgg
	+thkGCimmMq7gR6zYcipNJJvsBRQ1+ux/NhVaqU3pre2dGn/qW1FJg2Yw==
X-Google-Smtp-Source: AGHT+IFIzB7m1zh7udzp6wQh+C4Z6IOPJDNh2iLz3h2ZfMnqFB/dJgPqYGs47YOWnvnH0s1yBUPAMA==
X-Received: by 2002:adf:a443:0:b0:38a:3732:4462 with SMTP id ffacd0b85a97d-38a37324578mr10683360f8f.48.1735380463399;
        Sat, 28 Dec 2024 02:07:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847263sm24406136f8f.50.2024.12.28.02.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 02:07:42 -0800 (PST)
Message-Id: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
In-Reply-To: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Dec 2024 10:07:41 +0000
Subject: [PATCH v2] maintenance: add prune-remote-refs task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>

From: Shubham Kanodia <shubham.kanodia10@gmail.com>

Remote-tracking refs can accumulate in local repositories even as branches
are deleted on remotes, impacting git performance negatively. Existing
alternatives to keep refs pruned have a few issues — 

1. Running `git fetch` with either `--prune` or `fetch.prune=true` set will
prune stale refs, but requires a manual operation and also pulls in new
refs from remote which can be an undesirable side-effect.

2.`git remote prune` cleans up refs without adding to the existing list
but requires periodic user intervention.

This adds a new maintenance task 'prune-remote-refs' that runs
'git remote prune' for each configured remote daily. This provides an
automated way to clean up stale remote-tracking refs — especially when
users may not do a full fetch.

This task is disabled by default.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
---
    maintenance: add prune-remote-refs task
    
    As discussed previously on:
    https://lore.kernel.org/git/xmqqwmfr112w.fsf@gitster.g/T/#t
    
    Remote-tracking refs can accumulate in local repositories even as
    branches are deleted on remotes, impacting git performance negatively.
    Existing alternatives to keep refs pruned have a few issues — 
    
     1. The fetch.prune config automatically cleans up remote ref on fetch,
        but also pulls in new ref from remote which is an undesirable
        side-effect.
    
    2.git remote prune cleans up refs without adding to the existing list
    but requires periodic user intervention.
    
    This adds a new maintenance task 'prune-remote-refs' that runs 'git
    remote prune' for each configured remote daily. This provides an
    automated way to clean up stale remote-tracking refs — especially when
    users may not do a full fetch.
    
    This task is disabled by default.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1838%2Fpastelsky%2Fsk%2Fadd-remote-prune-maintenance-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1838/pastelsky/sk/add-remote-prune-maintenance-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1838

Range-diff vs v1:

 1:  72e27d3ebe6 ! 1:  4d6c143c970 maintenance: add prune-remote-refs task
     @@ Commit message
          are deleted on remotes, impacting git performance negatively. Existing
          alternatives to keep refs pruned have a few issues — 
      
     -    1. The `fetch.prune` config automatically cleans up remote ref on fetch,
     -    but also pulls in new ref from remote which is an undesirable side-effect.
     +    1. Running `git fetch` with either `--prune` or `fetch.prune=true` set will
     +    prune stale refs, but requires a manual operation and also pulls in new
     +    refs from remote which can be an undesirable side-effect.
      
          2.`git remote prune` cleans up refs without adding to the existing list
          but requires periodic user intervention.
     @@ Documentation/git-maintenance.txt: pack-refs::
      ++
      +--
      +* When using selective fetching (e.g., `git fetch origin +foo:refs/remotes/origin/foo`)
     -+  where `fetch.prune` would not affect refs outside the fetched hierarchy
     ++  where `fetch.prune` would only affect refs that are explicitly fetched.
      +* When third-party tools might perform unexpected full fetches, and you want
     -+  periodic cleanup independently of fetch operations
     ++  periodic cleanup independently of fetch operations.
      +--
      +
       OPTIONS
     @@ builtin/gc.c: static int maintenance_opt_schedule(const struct option *opt, cons
       	return 0;
       }
       
     -+static int collect_remote(struct remote *remote, void *cb_data)
     ++static int prune_remote(struct remote *remote, void *cb_data UNUSED)
      +{
     -+	struct string_list *list = cb_data;
     ++	struct child_process child = CHILD_PROCESS_INIT;
      +
      +	if (!remote->url.nr)
      +		return 0;
      +
     -+	string_list_append(list, remote->name);
     -+	return 0;
     ++	child.git_cmd = 1;
     ++	strvec_pushl(&child.args, "remote", "prune", remote->name, NULL);
     ++
     ++	return !!run_command(&child);
      +}
      +
     -+static int maintenance_task_prune_remote(struct maintenance_run_opts *opts UNUSED,
     ++static int maintenance_task_prune_remote(struct maintenance_run_opts *opts,
      +					 struct gc_config *cfg UNUSED)
      +{
     -+	struct string_list_item *item;
     -+	struct string_list remotes_list = STRING_LIST_INIT_NODUP;
     -+	struct child_process child = CHILD_PROCESS_INIT;
     -+	int result = 0;
     -+
     -+	for_each_remote(collect_remote, &remotes_list);
     -+
     -+	for_each_string_list_item (item, &remotes_list) {
     -+		const char *remote_name = item->string;
     -+		child.git_cmd = 1;
     -+		strvec_pushl(&child.args, "remote", "prune", remote_name, NULL);
     -+
     -+		if (run_command(&child))
     -+			result = error(_("failed to prune '%s'"), remote_name);
     ++	if (for_each_remote(prune_remote, opts)) {
     ++		error(_("failed to prune remotes"));
     ++		return 1;
      +	}
      +
     -+	string_list_clear(&remotes_list, 0);
     -+	return result;
     ++	return 0;
      +}
      +
       /* Remember to update object flag allocation in object.h */


 Documentation/git-maintenance.txt | 20 ++++++++++++++
 builtin/gc.c                      | 32 ++++++++++++++++++++++
 t/t7900-maintenance.sh            | 44 +++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 6e6651309d3..8b3e496c8ef 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -158,6 +158,26 @@ pack-refs::
 	need to iterate across many references. See linkgit:git-pack-refs[1]
 	for more information.
 
+prune-remote-refs::
+	The `prune-remote-refs` task runs `git remote prune` on each remote
+	repository registered in the local repository. This task helps clean
+	up deleted remote branches, improving the performance of operations
+	that iterate through the refs. See linkgit:git-remote[1] for more
+	information. This task is disabled by default.
++
+NOTE: This task is opt-in to prevent unexpected removal of remote refs
+for users of git-maintenance. For most users, configuring `fetch.prune=true`
+is a acceptable solution, as it will automatically clean up stale remote-tracking
+branches during normal fetch operations. However, this task can be useful in
+specific scenarios:
++
+--
+* When using selective fetching (e.g., `git fetch origin +foo:refs/remotes/origin/foo`)
+  where `fetch.prune` would only affect refs that are explicitly fetched.
+* When third-party tools might perform unexpected full fetches, and you want
+  periodic cleanup independently of fetch operations.
+--
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 4ae5196aedf..329c764f300 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -20,6 +20,7 @@
 #include "lockfile.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "remote.h"
 #include "sigchain.h"
 #include "strvec.h"
 #include "commit.h"
@@ -913,6 +914,30 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int prune_remote(struct remote *remote, void *cb_data UNUSED)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	if (!remote->url.nr)
+		return 0;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "remote", "prune", remote->name, NULL);
+
+	return !!run_command(&child);
+}
+
+static int maintenance_task_prune_remote(struct maintenance_run_opts *opts,
+					 struct gc_config *cfg UNUSED)
+{
+	if (for_each_remote(prune_remote, opts)) {
+		error(_("failed to prune remotes"));
+		return 1;
+	}
+
+	return 0;
+}
+
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
 
@@ -1375,6 +1400,7 @@ enum maintenance_task_label {
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 	TASK_PACK_REFS,
+	TASK_PRUNE_REMOTE_REFS,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1411,6 +1437,10 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_pack_refs,
 		pack_refs_condition,
 	},
+	[TASK_PRUNE_REMOTE_REFS] = {
+		"prune-remote-refs",
+		maintenance_task_prune_remote,
+	},
 };
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
@@ -1505,6 +1535,8 @@ static void initialize_maintenance_strategy(void)
 		tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
 		tasks[TASK_PACK_REFS].enabled = 1;
 		tasks[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY;
+		tasks[TASK_PRUNE_REMOTE_REFS].enabled = 0;
+		tasks[TASK_PRUNE_REMOTE_REFS].schedule = SCHEDULE_DAILY;
 	}
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0ce4ba1cbef..60a0c3f8353 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -446,6 +446,50 @@ test_expect_success 'pack-refs task' '
 	test_subcommand git pack-refs --all --prune <pack-refs.txt
 '
 
+test_expect_success 'prune-remote-refs task not enabled by default' '
+	git clone . prune-test &&
+	(
+		cd prune-test &&
+		GIT_TRACE2_EVENT="$(pwd)/prune.txt" git maintenance run 2>err &&
+		test_subcommand ! git remote prune origin <prune.txt
+	)
+'
+
+test_expect_success 'prune-remote-refs task cleans stale remote refs' '
+	test_commit initial &&
+
+	# Create two separate remote repos
+	git clone . remote1 &&
+	git clone . remote2 &&
+
+	git clone . prune-test-clean &&
+	(
+		cd prune-test-clean &&
+		git config maintenance.prune-remote-refs.enabled true &&
+
+		# Add both remotes
+		git remote add remote1 "../remote1" &&
+		git remote add remote2 "../remote2" &&
+
+		# Create and push branches to both remotes
+		git branch -f side2 HEAD &&
+		git push remote1 side2 &&
+		git push remote2 side2 &&
+
+		# Rename branches in each remote to simulate a stale branch
+		git -C ../remote1 branch -m side2 side3 &&
+		git -C ../remote2 branch -m side2 side4 &&
+
+		GIT_TRACE2_EVENT="$(pwd)/prune.txt" git maintenance run --task=prune-remote-refs &&
+
+		# Verify pruning happened for both remotes
+		test_subcommand git remote prune remote1 <prune.txt &&
+		test_subcommand git remote prune remote2 <prune.txt &&
+		test_must_fail git rev-parse refs/remotes/remote1/side2 &&
+		test_must_fail git rev-parse refs/remotes/remote2/side2
+	)
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
