Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC583CCB
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400287; cv=none; b=AfBEVbUgxa2qT23LpwzUldNoTgnEbMTJoJ5P/xfaDkzvC8U7mLCJJcKUeo01MT11FaBoLWw+BSImxAazN7semhUgvoU0V+aIyH6tjqW6rJC6TDWFY7GrSKwuKzsf6APydlva0rRrRHQYfxuMHMzc3e05kTIeGN5oBnwixCzXmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400287; c=relaxed/simple;
	bh=0XguJFMNqmcv8urfJQhpyVVg48IXxLWtFEgDaNdYTuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXCNDBUNG30zWzzc/qDig0LSFYUhQe0Lur6Whd2s+t7h/7DnuDXJmBGKYK8jsCvWKMOpHgDIl2rGaSkYHZIIPgAbtETYkcU7JKTijTHc3Cs5gp7QlmhTM6/8UCOi5hXuNVGxVomEcl94KJOABFLN33iey2NgPcJGmS1k+R2Sjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0DceWRf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0DceWRf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ff28388a6so16693675e9.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 05:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707400282; x=1708005082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99P5cdie6O7ryQzlt91sTZu4Un7JX4h23FdP6SfLDLQ=;
        b=B0DceWRfV+qpIQxAKcqwAh55Vm4eENzWh53Zomf8eTmFd2ZKmJMhw0dXf6cgxxHzwd
         59vFtPFf2CDm6M9LeeLzajVixYUePoJv66vMVO/bvkCcke9D9dK23j6YjGLKJ78U3OCm
         FPgF1ziykY6wvr1RMl5ilu+zRE/mBMOL4Z+3Iq0ZjnSzHGndqQNsF+CP+CrEilCJIMLz
         NQa7SdKAo4vUq9QEeFFvT2CpLP1f9yJ/95DVQdrTpz/NzwN6KBgnVMYxsssETgB+l7VE
         LpYwqaTsoc7p8Cz/mhvPjKTsC2MJBNiZ78aDj1j8xZUv0+YRmqKLJwWhHPFT3e3/Py9K
         uW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400282; x=1708005082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99P5cdie6O7ryQzlt91sTZu4Un7JX4h23FdP6SfLDLQ=;
        b=TpidzHyLNuwNgivUrfhNgAPoxJ9rJo2yjdnDLPhSZHlZSr4d6AZ8CqBVX+8C6hv55P
         cNzpBzEInNScgglxxPrOonmOHzsxJEcmRtmnccd5oCyB4HDvld5MA0CLk+LRr7cdCB8A
         WHCuOJirEfk9VyPbFOLhYk83CuBwbwyKamRs4Uff9+xhIUqfRnwFsBc/AdBICfr45JKw
         aghyoPb8ZXT1+1THVMJWhCWXgCVShh0mqxlD1eQprO+JKmEoRYl73A0yAQ/TvDxEtRhD
         riG3HjCuy3RJFqrUbYBWbADCjW6RF0aL9pYpPQV/W+aThjLMtel7DatRbwvG7MO5LoUU
         tRFA==
X-Gm-Message-State: AOJu0Yy17clcPix6F0c1JFYRlrv/psAwEMNSc2KB5uiTOpDoGUdPivOO
	yF6RStHM5xWnHPzO0JOlD7VNr7wp3ia6yXWaFWoDybvaHDpf6q8U8nIGymJy
X-Google-Smtp-Source: AGHT+IGwF1jf2hNvhdBcbk0bgvEPYXxkn5Aa9VMN0M+buxN1x7qEmu+IlqdjVjA2wnaKN2JMJmNdGg==
X-Received: by 2002:a05:600c:35cf:b0:40f:cd21:40d4 with SMTP id r15-20020a05600c35cf00b0040fcd2140d4mr7249502wmq.25.1707400282024;
        Thu, 08 Feb 2024 05:51:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUweyGtK/6fUM0NlKYfY0XLIzi54t4EdSoeA/VDStpdz7Bt+ZsruQE1XI9sty8XAv9kU0tt53HuSPzHNsb8CoxbKh8Zk6y1vS0zoa6qBcIOSx8SX0G9EjzmGuxdChi6Ovm3Z6taixujGZO1axJB+U8NNorVqO7sjM4VQRT7ZF52Wjt/n+QewdYG5UeTkZ+gZ6MFwYhOHzA=
Received: from localhost.localdomain ([2001:861:3f04:7ca0:4c16:5b8b:3341:9836])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b0040ebf603a89sm1698307wmq.11.2024.02.08.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:51:20 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/4] rev-list: allow missing tips with --missing=[print|allow*]
Date: Thu,  8 Feb 2024 14:50:55 +0100
Message-ID: <20240208135055.2705260-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.565.g97b5fd12a3.dirty
In-Reply-To: <20240208135055.2705260-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 9830926c7d (rev-list: add commit object support in `--missing`
option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
so that it works with with missing commits, not just blobs/trees.

Unfortunately, such a command would still fail with a "fatal: bad
object <oid>" if it is passed a missing commit, blob or tree as an
argument (before the rev walking even begins).

When such a command is used to find the dependencies of some objects,
for example the dependencies of quarantined objects (see the
"QUARANTINE ENVIRONMENT" section in the git-receive-pack(1)
documentation), it would be better if the command would instead
consider such missing objects, especially commits, in the same way as
other missing objects.

If, for example `--missing=print` is used, it would be nice for some
use cases if the missing tips passed as arguments were reported in
the same way as other missing objects instead of the command just
failing.

We could introduce a new option to make it work like this, but most
users are likely to prefer the command to have this behavior as the
default one. Introducing a new option would require another dumb loop
to look for that options early, which isn't nice.

Also we made `git rev-list` work with missing commits very recently
and the command is most often passed commits as arguments. So let's
consider this as a bug fix related to these previous change.

While at it let's add a NEEDSWORK comment to say that we should get
rid of the existing ugly dumb loops that parse the
`--exclude-promisor-objects` and `--missing=...` options early.

Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/rev-list-options.txt |  4 +++
 builtin/rev-list.c                 | 15 +++++++-
 revision.c                         | 14 ++++++--
 t/t6022-rev-list-missing.sh        | 56 ++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a583b52c61..bb753b6292 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1019,6 +1019,10 @@ Unexpected missing objects will raise an error.
 +
 The form '--missing=print' is like 'allow-any', but will also print a
 list of the missing objects.  Object IDs are prefixed with a ``?'' character.
++
+If some tips passed to the traversal are missing, they will be
+considered as missing too, and the traversal will ignore them. In case
+we cannot get their Object ID though, an error will be raised.
 
 --exclude-promisor-objects::
 	(For internal use only.)  Prefilter object traversal at
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b3f4783858..ec9556f135 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -545,6 +545,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	 *
 	 * Let "--missing" to conditionally set fetch_if_missing.
 	 */
+	/*
+	 * NEEDSWORK: These dump loops to look for some options early
+	 * are ugly. We really need setup_revisions() to have a
+	 * mechanism to allow and disallow some sets of options for
+	 * different commands (like rev-list, replay, etc). Such
+	 * mechanism should do an early parsing of option and be able
+	 * to manage the `--exclude-promisor-objects` and `--missing=...`
+	 * options below.
+	 */
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
@@ -753,8 +762,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (arg_print_omitted)
 		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
-	if (arg_missing_action == MA_PRINT)
+	if (arg_missing_action == MA_PRINT) {
 		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
+		/* Already add missing tips */
+		oidset_insert_from_set(&missing_objects, &revs.missing_commits);
+		oidset_clear(&revs.missing_commits);
+	}
 
 	traverse_commit_list_filtered(
 		&revs, show_commit, show_object, &info,
diff --git a/revision.c b/revision.c
index 4c5cd7c3ce..80c349d347 100644
--- a/revision.c
+++ b/revision.c
@@ -388,6 +388,10 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 			return NULL;
 		if (revs->exclude_promisor_objects && is_promisor_object(oid))
 			return NULL;
+		if (revs->do_not_die_on_missing_objects) {
+			oidset_insert(&revs->missing_commits, oid);
+			return NULL;
+		}
 		die("bad object %s", name);
 	}
 	object->flags |= flags;
@@ -1947,6 +1951,7 @@ void repo_init_revisions(struct repository *r,
 	init_display_notes(&revs->notes_opt);
 	list_objects_filter_init(&revs->filter);
 	init_ref_exclusions(&revs->ref_excludes);
+	oidset_init(&revs->missing_commits, 0);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
@@ -2178,13 +2183,18 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags |= GET_OID_COMMITTISH;
 
+	/*
+	 * Even if revs->do_not_die_on_missing_objects is set, we
+	 * should error out if we can't even get an oid, as
+	 * `--missing=print` should be able to report missing oids.
+	 */
 	if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, &oid, flags ^ local_flags);
 	if (!object)
-		return revs->ignore_missing ? 0 : -1;
+		return (revs->ignore_missing || revs->do_not_die_on_missing_objects) ? 0 : -1;
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
 	free(oc.path);
@@ -3830,8 +3840,6 @@ int prepare_revision_walk(struct rev_info *revs)
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
-	oidset_init(&revs->missing_commits, 0);
-
 	if (!revs->reflog_info)
 		prepare_to_use_bloom_filter(revs);
 	if (!revs->unsorted_input)
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 5f1be7abb5..78387eebb3 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -78,4 +78,60 @@ do
 	done
 done
 
+for missing_tip in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
+do
+	# We want to check that things work when both
+	#   - all the tips passed are missing (case existing_tip = ""), and
+	#   - there is one missing tip and one existing tip (case existing_tip = "HEAD")
+	for existing_tip in "" "HEAD"
+	do
+		for action in "allow-any" "print"
+		do
+			test_expect_success "--missing=$action with tip '$missing_tip' missing and tip '$existing_tip'" '
+				oid="$(git rev-parse $missing_tip)" &&
+				path=".git/objects/$(test_oid_to_path $oid)" &&
+
+				# Before the object is made missing, we use rev-list to
+				# get the expected oids.
+				if test "$existing_tip" = "HEAD"
+				then
+					git rev-list --objects --no-object-names \
+						HEAD ^$missing_tip >expect.raw
+				else
+					>expect.raw
+				fi &&
+
+				# Blobs are shared by all commits, so even though a commit/tree
+				# might be skipped, its blob must be accounted for.
+				if test "$existing_tip" = "HEAD" && test $missing_tip != "HEAD:1.t"
+				then
+					echo $(git rev-parse HEAD:1.t) >>expect.raw &&
+					echo $(git rev-parse HEAD:2.t) >>expect.raw
+				fi &&
+
+				mv "$path" "$path.hidden" &&
+				test_when_finished "mv $path.hidden $path" &&
+
+				git rev-list --missing=$action --objects --no-object-names \
+				     $oid $existing_tip >actual.raw &&
+
+				# When the action is to print, we should also add the missing
+				# oid to the expect list.
+				case $action in
+				allow-any)
+					;;
+				print)
+					grep ?$oid actual.raw &&
+					echo ?$oid >>expect.raw
+					;;
+				esac &&
+
+				sort actual.raw >actual &&
+				sort expect.raw >expect &&
+				test_cmp expect actual
+			'
+		done
+	done
+done
+
 test_done
-- 
2.43.0.565.g97b5fd12a3.dirty

