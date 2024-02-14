Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134725821A
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920743; cv=none; b=A9vcK1nY52TCV7dSg1PrinR3FWJ+j7PXiAkMUGCfT+F4N0kFao2cSS9pEzzcKHyGqFBE39OXgo1ti9x314eCPgB5aBhIDGcXclL49559oOHnS4ZwOhJDe4a71M+5YiZ1eqmuUajjM29pz01Gac0z/DHxXoQiY4nq/p3eiUEmNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920743; c=relaxed/simple;
	bh=qYDKnH8XsoxhgXHF1MGxDi82L0SeIB0WPBYwt+1CLjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuZI5pV3l7i176BD7ztnkLaA89QiRn+8M8nkzE2dYeX+RhlznYNaDMyanszCiOme9qFPHRtZRyNMGbBkLhkDI+fHAnt3RhZm7T4B6FUuP3IlOj+iYaAOoX63//PqCEZ83K9L56AhXJ+3piO8TlPNAP+Hwo1W7AhuGQKevhQgKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RptboWYj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RptboWYj"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d10f52e7d8so15749261fa.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707920739; x=1708525539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPCVVzHLuZot1w52tgWkn2blYrDJ9lNOsU33TvSANHE=;
        b=RptboWYj3SjtmsJdFMN/XSRQhXluMovM58+hClwjg6al4BxzWb4cfewxkP8LtLaqfD
         p9OjZNgnFivK7emXS8HYXFxvvD7kOWFitG5AoL5pWk7csgqY2si7IueivrAr0KCzUIdH
         U7XTiFMeC6kWlUnFp/TpPEqJsdx8183kpPtErA11/bc6+BK7gxwMu9KBDAuS69ACJnYK
         Tj3hxK6RRLFv0wD93ap/hNcVc344yyspv/IKgNe5xRvRcpIXWlDzBXsSE/ktJaTB+tnn
         W449VRNPOdlgkV4Znow6hgA0ylth+7oeZ7PUQ4mZNtNDcBYYJPbXGQvZKKPkcShyhOhx
         3WOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920739; x=1708525539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPCVVzHLuZot1w52tgWkn2blYrDJ9lNOsU33TvSANHE=;
        b=oY6Ni6TAD0jIHZ0RRQpnlZy8HZYFlDXekriC2TVlZKIZ4qQuNRnaxNsZWJ/Z5ZPoLT
         SN9/p+bocmrO3rZ4z67nmocg4VwkDV5pLmjVkSip44jpdWhx1X4EHo2v0XwPWp6Jm+h0
         tc6NR/oNlAA0G3A/q+MkyqGjtsPwBG8fZjJYKQJQXKasrWzPHYUBxa05/xCFIPZLRmeV
         pgGLbGIIVSaNtZMV+uuTa53+2WZtUESJYVBmuUFvI9iW9yMQhJn8DjD/2bD2D4rAkW72
         QDcYv754kXhC5vbcETsOA1HhmeBey7Cou+4xho5RIT04qd2SExWscADLfEDfeAmYYtI0
         KPIA==
X-Gm-Message-State: AOJu0YyiSUVlGZyYy6Y7yUTVEiVCspL0vaVa8VX/GltpjSlzdbD6XNYT
	jyuRLHHeAkJf4ZSw9tgcblIMjgdUY5hUMyK2kYbiZXE/osST3lwMdxivmcIO
X-Google-Smtp-Source: AGHT+IH90rRxWSjudovS050qcGKex5CRGeR8GLsazR57TwG0Q338/NCULK8VIoojrC1/a7JyohiZeg==
X-Received: by 2002:a2e:bc21:0:b0:2d0:cb3d:29e4 with SMTP id b33-20020a2ebc21000000b002d0cb3d29e4mr3144930ljf.41.1707920738679;
        Wed, 14 Feb 2024 06:25:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnqRW/ZUz98Bdvol8yxf8vBp+3d0AGqGvgXrZUudDn1mGUpTa4f8djUHlrBjxJNpt0LTq0xeUjI9TESl2IfbgrXsJf+v0ViwpMqj4S9wZHW8UhmVB+oXeFrlNDaBfJIm7C4QB8D399xr0DI2woqPA5RaOVGGgXef2kiZqfADWdJxuFWSgN1Ea783nMqjMlLQy1vWMuRYoPE2gKc7DoObfSHAsTTbnnJI81bf8rLnyr
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:4d2b:b120:8137:3062])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c0a0100b00411ce6def3fsm2146871wmp.38.2024.02.14.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:25:37 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/5] rev-list: allow missing tips with --missing=[print|allow*]
Date: Wed, 14 Feb 2024 15:25:13 +0100
Message-ID: <20240214142513.4002639-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.51.gda36843b44
In-Reply-To: <20240214142513.4002639-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240214142513.4002639-1-christian.couder@gmail.com>
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
to look for that option early, which isn't nice.

Also we made `git rev-list` work with missing commits very recently
and the command is most often passed commits as arguments. So let's
consider this as a bug fix related to these recent changes.

While at it let's add a NEEDSWORK comment to say that we should get
rid of the existing ugly dumb loops that parse the
`--exclude-promisor-objects` and `--missing=...` options early.

Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/rev-list-options.txt |  4 +++
 builtin/rev-list.c                 | 18 +++++++++-
 revision.c                         | 14 ++++++--
 t/t6022-rev-list-missing.sh        | 56 ++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 4 deletions(-)

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
index b3f4783858..ec455aa972 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -545,6 +545,18 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	 *
 	 * Let "--missing" to conditionally set fetch_if_missing.
 	 */
+	/*
+	 * NEEDSWORK: These loops that attempt to find presence of
+	 * options without understanding that the options they are
+	 * skipping are broken (e.g., it would not know "--grep
+	 * --exclude-promisor-objects" is not triggering
+	 * "--exclude-promisor-objects" option).  We really need
+	 * setup_revisions() to have a mechanism to allow and disallow
+	 * some sets of options for different commands (like rev-list,
+	 * replay, etc). Such a mechanism should do an early parsing
+	 * of options and be able to manage the `--missing=...` and
+	 * `--exclude-promisor-objects` options below.
+	 */
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
@@ -753,8 +765,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (arg_print_omitted)
 		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
-	if (arg_missing_action == MA_PRINT)
+	if (arg_missing_action == MA_PRINT) {
 		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
+		/* Add missing tips */
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
2.44.0.rc0.51.gda36843b44

