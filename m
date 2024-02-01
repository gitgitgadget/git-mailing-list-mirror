Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15EA15D5CD
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788711; cv=none; b=gBLACtOoNxqLZPDD6SBTI/xE1NBSij5mo3/5scME/E1BeyMNk5c8f6qm4Yc3+pG9+8kztKUgOicMmOCTxTXQ7+lHIct/4iOuP3hO0YblZhXip29Uts+dVoEv642+ReJkPqAdvwdEkgcV7qFmouqjo1H13YItn9XIupjVNhxpBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788711; c=relaxed/simple;
	bh=XbSHRVumd1AvdUhxJ9qt2B3cOH/Vtfuigu3+PHXbnrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+T8O9WTsx5Nv7SzX+7wRnJZp7G0mOiIg8gD3KoR8YYvga0YZgkX0QifvTZzC1n+P50ENrmE3D2pnGs0P6kVOOF1LCTPo/Cu/1ckHCPTZpRqF/UPZV7Q4xXxVVy1OdZ0F5kqd6TKrmjvgUWxOcifWD4SiqU+YlyYU3MQtZOed78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iocIu9Av; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iocIu9Av"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso1873025e9.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706788708; x=1707393508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcKsU9JqpXSJelpyzTEGSLw5a1rboJTYABh7FieK0jA=;
        b=iocIu9AvgTvh5Wa0X8/Hd0Y7/cXOg1l73yrOtueXIDX5gp9CB/xUxXL6z5lR27FaBw
         XRypXfMD0j5KiJFzfj9OhCGTcTMBPoqksGDnQSfozuJ11MgVKuIgw/+OqNlVn7iudCbO
         k8rZj+86qoGCbm/qJ0OL+FX67GgN6mZViFHbVkHWTzfD8Ej3LvSZY3I6hh+JJEG5fl/u
         gw4W/A9mNFPmp+dT01Mcgahwy08ldFCpktrqOBSsA5Vs8R0VuGzr63dIsiYqdxKatHvN
         q4l75/tkh7MyTEiOaMdlbOKyYnqZA0S4sycfoQ8AJddjL6SrWOi6+YOgVGoMLr7nLr/B
         VIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706788708; x=1707393508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcKsU9JqpXSJelpyzTEGSLw5a1rboJTYABh7FieK0jA=;
        b=p/iXpoxJ+hW4DFTyBezVlxOjGMs34u8weTZJgqsTrel9gQF2tl9ru8nLFN4BQJCx3D
         sMfKExwUJEazcpp5daEQORGSWPD76PfQ+JL4h94urKdWrECdY2A/vGkrj3JJ/Y1DaRIg
         G6sOLStdmXQlk/rSTI1XDFZHMwNn5VjExCTmRUaDFGY3hlXADYRpXnnFXFcfK9LMB7D0
         EU4m/zP0R5+hoYtJn9yRVg4zXzARIh1yCNJy3qEqQ3CC6V982AHPnZtHQn5OQWyIRcK5
         gLl27edEWM85gLlxG25Gul8oUDMRJPvW2mISR7EZ1sfIVB6wL1mnyDv1o51eWaRC3pgP
         iN+g==
X-Gm-Message-State: AOJu0YwndZF1u7f1VqMg5acEHB8Iep28OYSZVVJEmDZoN2E2rWWSQOQM
	kFRRS38EnAa+wCSz7WI0P4tfCXLUUR3ItBH1shCAjAqT27vuw8MM6NgHQ8DY
X-Google-Smtp-Source: AGHT+IFH6YzcJVuozzjOx40AGklJfKBzEeRfkKeTV3M3dW3d1RZoH9qdd+sDqnDKm8t8YQPuMhbMWw==
X-Received: by 2002:a05:600c:1907:b0:40e:fc39:716c with SMTP id j7-20020a05600c190700b0040efc39716cmr3600724wmq.4.1706788707712;
        Thu, 01 Feb 2024 03:58:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJ0yS0IPaCah4S1ZCkj7FMIhR4uD6F+E9pTvEUC4zyqp3HbThnUwtrHzKREoUiT1o/E9blyopU0pFIZN8iZOB60OIP64bnfFNlP/4fY/FnQWhGjtAN7TtYhPb9cr5pwBJA1qJwWN3d9gDFD4PcdjQJ8LnlaWwDCckbVZyeiUU0MSsVWw==
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e1e0:bb55:1733:6146])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c044600b0040faf410320sm4113495wmb.20.2024.02.01.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:58:27 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
Date: Thu,  1 Feb 2024 12:58:09 +0100
Message-ID: <20240201115809.1177064-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.496.g8be34ce359
In-Reply-To: <20240201115809.1177064-1-christian.couder@gmail.com>
References: <20240201115809.1177064-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 9830926c7d (rev-list: add commit object support in `--missing`
option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
so that it now works with commits too.

Unfortunately, such a command would still fail with a "fatal: bad
object <oid>" if it is passed a missing commit, blob or tree as an
argument.

When such a command is used to find the dependencies of some objects,
for example the dependencies of quarantined objects, it would be
better if the command would instead consider such missing objects,
especially commits, in the same way as other missing objects.

If, for example `--missing=print` is used, it would be nice for some
use cases if the missing tips passed as arguments were reported in
the same way as other missing objects instead of the command just
failing.

Let's introduce a new `--allow-missing-tips` option to make it work
like this.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/rev-list.c          | 24 ++++++++++++++++-
 revision.c                  |  9 ++++---
 revision.h                  |  8 ++++++
 t/t6022-rev-list-missing.sh | 51 +++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b3f4783858..ae7bb15478 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -562,6 +562,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 				break;
 		}
 	}
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--allow-missing-tips")) {
+			if (arg_missing_action == MA_ERROR)
+				die(_("option '%s' only makes sense with '%s' set to '%s' or '%s'"),
+				      "--allow-missing-tips", "--missing=", "allow-*", "print");
+			revs.do_not_die_on_missing_tips = 1;
+			break;
+		}
+	}
 
 	if (arg_missing_action)
 		revs.do_not_die_on_missing_objects = 1;
@@ -627,6 +637,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue; /* already handled above */
 		if (skip_prefix(arg, "--missing=", &arg))
 			continue; /* already handled above */
+		if (!strcmp(arg, "--allow-missing-tips"))
+			continue; /* already handled above */
 
 		if (!strcmp(arg, ("--no-object-names"))) {
 			arg_show_object_names = 0;
@@ -753,9 +765,19 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (arg_print_omitted)
 		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
-	if (arg_missing_action == MA_PRINT)
+	if (arg_missing_action == MA_PRINT) {
+		struct oidset_iter iter;
+		struct object_id *oid;
+
 		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
 
+		/* Already add missing commits */
+		oidset_iter_init(&revs.missing_commits, &iter);
+		while ((oid = oidset_iter_next(&iter)))
+			oidset_insert(&missing_objects, oid);
+		oidset_clear(&revs.missing_commits);
+	}
+
 	traverse_commit_list_filtered(
 		&revs, show_commit, show_object, &info,
 		(arg_print_omitted ? &omitted_objects : NULL));
diff --git a/revision.c b/revision.c
index 4c5cd7c3ce..9f25faa249 100644
--- a/revision.c
+++ b/revision.c
@@ -388,6 +388,10 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 			return NULL;
 		if (revs->exclude_promisor_objects && is_promisor_object(oid))
 			return NULL;
+		if (revs->do_not_die_on_missing_tips) {
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
@@ -2184,7 +2189,7 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, &oid, flags ^ local_flags);
 	if (!object)
-		return revs->ignore_missing ? 0 : -1;
+		return (revs->ignore_missing || revs->do_not_die_on_missing_tips) ? 0 : -1;
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
 	free(oc.path);
@@ -3830,8 +3835,6 @@ int prepare_revision_walk(struct rev_info *revs)
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
-	oidset_init(&revs->missing_commits, 0);
-
 	if (!revs->reflog_info)
 		prepare_to_use_bloom_filter(revs);
 	if (!revs->unsorted_input)
diff --git a/revision.h b/revision.h
index 94c43138bc..67435a5d8a 100644
--- a/revision.h
+++ b/revision.h
@@ -227,6 +227,14 @@ struct rev_info {
 			 */
 			do_not_die_on_missing_objects:1,
 
+			/*
+			 * When the do_not_die_on_missing_objects flag above is set,
+			 * a rev walk could still die with "fatal: bad object <oid>"
+			 * if one of the tips it is passed is missing. With this flag
+			 * such a tip will be reported as missing too.
+			 */
+			 do_not_die_on_missing_tips:1,
+
 			/* for internal use only */
 			exclude_promisor_objects:1;
 
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 527aa94f07..283e8fc2c2 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -77,4 +77,55 @@ do
 	done
 done
 
+for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
+do
+	for tip in "" "HEAD"
+	do
+		for action in "allow-any" "print"
+		do
+			test_expect_success "--missing=$action --allow-missing-tips with tip '$obj' missing and tip '$tip'" '
+				oid="$(git rev-parse $obj)" &&
+				path=".git/objects/$(test_oid_to_path $oid)" &&
+
+				# Before the object is made missing, we use rev-list to
+				# get the expected oids.
+				if [ "$tip" = "HEAD" ]; then
+					git rev-list --objects --no-object-names \
+						HEAD ^$obj >expect.raw
+				else
+					>expect.raw
+				fi &&
+
+				# Blobs are shared by all commits, so even though a commit/tree
+				# might be skipped, its blob must be accounted for.
+				if [ "$tip" = "HEAD" ] && [ $obj != "HEAD:1.t" ]; then
+					echo $(git rev-parse HEAD:1.t) >>expect.raw &&
+					echo $(git rev-parse HEAD:2.t) >>expect.raw
+				fi &&
+
+				mv "$path" "$path.hidden" &&
+				test_when_finished "mv $path.hidden $path" &&
+
+				git rev-list --missing=$action --allow-missing-tips \
+				     --objects --no-object-names $oid $tip >actual.raw &&
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
2.43.0.496.gd667eb0d7d.dirty

