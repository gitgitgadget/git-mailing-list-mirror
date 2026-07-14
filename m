Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BE33B6C9
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035806; cv=none; b=QUV9h+zYuvxRZzg3HlpM/SVACeGpe/X4Ho8crlHUUDPOs2PcoHpYe8hP2XBUoFPYecFl1/4zBAnLoktAl6ULGS5PuvKsEJTTA7vjrgqgUw8Aav19v9G8RmS6dxFAiedrancuvJeMiIL2BkCYsu7Bswd/VD0UIxWkVuf5+npSzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035806; c=relaxed/simple;
	bh=pHLof1hDxeD4OlU0qpd4dSQMhjfWDiekLgg+VoCyZ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtDCETFXg1qMvNop1xx3kwZN3eXirJrF7H0VLiaSCTtcI9lMDSQKI+yFARS0SLkVmukEE7R4V5Yl+ke9AWry8anJviQr7FTctwG64h2To2+VNah7tDL29Qu7uI5pDy1iS/I7A50fCMTDZYpYayK6V3CGO+GgKt2sYwdGDtVEQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3w17IeJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3w17IeJ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso2014122a12.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035803; x=1784640603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0yyqNxPGiafPUm9MbK7RcUN5wIGZMAldLa74kmWIbE=;
        b=J3w17IeJY1TEQaMekrAgCdJuGY/U84FHTXg5at5BiSWI18q0M+Ly3DRYxzi+oSTz/h
         cnyQ7kU24V3XcNRU/bfX5cuh6He4bR/1cxJVw1V1jBzDeloelF/bBWbGuu2rr0VDYnd8
         VZOjvXTQbC+ZFcChibDWFbSUwDsShRB7+Xb6TEOUlO/LgGkJvE2mOz4D1M/Y6CM+g5ZQ
         AvzPuVk0dDk6UhRIfIDEpnR+DibPO2G6jWWzuP3eXPUI5nAuG0ncweStpp3DFVh1R9tR
         j9uBAgQdi468fHdSJ56Gt+LGFSywigClxxxVnPv4YjIPAMtBGkS/IXF3L2x3VFXATyom
         6J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035803; x=1784640603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N0yyqNxPGiafPUm9MbK7RcUN5wIGZMAldLa74kmWIbE=;
        b=ZjLX2vDyEhsHf7oiqEAqeg2zelytco+JbJsWHkt3K8HiUFjsITwYFAMOZjEjXB4nOR
         VH/OdYqMYI5rc13Uh8+MCvsBHGrQ8GG2APNcR83BegfCIoo5MN5jg/OK/ix3IBi+zO20
         ioNcajTdP8FtdxTmktCXg08HNbWEJ5YX/LcoMyQ0edpxuqvP+tlhb06HOdumwoaCCJSG
         k5urnFvt4PZDl4jth+wRw/4fRFreDm9q+dJ+LjRmPQFPRX/NYwk15j7M9wf5sB/J041y
         uEO5qR+u1xN3XXuP0DfgDaLPRPhwHf/fqpl491AZHrVPPyDBF9HTgHPpLQ6I77UySJpv
         TutQ==
X-Gm-Message-State: AOJu0Yyf6ucw95sfT2mxWJOcn+O+iQlDJdGVBx1DSu0FCRwii4FMNolZ
	GOQ/KsrzCzzywRRal9nRBR9p+qAqHT9vKQwF3T9ZGZr0mV7Y6oNgNFeq65W/rLbf
X-Gm-Gg: AfdE7cnQ6rxEXZR3BvTZOUbm6lDZ4isgHv44z/hPNUIIHJWqTfFbT9r9n2W8YNOpTIT
	tMtHfKz2wx3pNrNNr1HhbRigMo6VXsEKrmEBMIs115JIRa1jjETGRBtfLPDY0btRY7OWSZHUYZy
	aveNXJskduQyq3CZlhvmCfW2GgqOjOEOzVu2s+6b0pUZjEtop1m6w6ZcTbytgT8DeoibD1M/vp6
	TKaqcRRl1DecQtnIwVhWrEuQHX3YM+JbY9GI4i96RZWrb1p+6eGzdu+/2x7SeLwSIrKFq0nECDT
	IRJfBkFndRwNfWIVD+24zOIK0r28myYvw/scPZ6l+OQ37FlzFRcja0/SwuZuaHr4WgEJWvh2aW0
	zJd+2s9wJZGaz4TjoIHe1H8fInaTXY6c6oGqW++RWiABRsSWenObNL87wMSQCwaw7HRDQySfLaf
	9eO039Ys5kAE6ptR3+JSHMZrwvi9ztIh+ECQVEYmoPLCH1QKmdH6GvwZhLygYKb9NOnlAQBW9xB
	hCNZ+AOSeLDrT8gJj/T6DdwY5tRCw==
X-Received: by 2002:a05:6402:5186:b0:698:b1bc:ed56 with SMTP id 4fb4d7f45d1cf-69c5edb8938mr5620174a12.0.1784035802436;
        Tue, 14 Jul 2026 06:30:02 -0700 (PDT)
Received: from M-K2012N0113010 ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd288757esm1616877a12.9.2026.07.14.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:30:02 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Glen Choo <glencbz@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>
Subject: [PATCH v4 1/2] submodule: fix premature failure in recursive submodule fetch
Date: Tue, 14 Jul 2026 16:29:56 +0300
Message-ID: <20260714132959.3368867-2-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714132959.3368867-1-paulius.zaleckas@gmail.com>
References: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
 <20260714132959.3368867-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git fetch --recurse-submodules encounters a failure fetching a
submodule's refs (phase 1), it immediately marks the overall operation
as failed, even though a subsequent OID-based fetch (phase 2) is about
to be attempted for any missing commits.  If phase 2 succeeds, the
overall result should be success, but the prematurely set failure flag
makes it look like an error.

Restructure fetch_finish() so that a phase-1 failure does not record an
error immediately.  Instead, the decision is deferred:

 - If missing commits trigger a phase-2 (OID-based) retry and that
   retry succeeds, no error is recorded.
 - If the phase-2 retry also fails, the error is recorded then.
 - If the submodule was fetched unconditionally (RECURSE_SUBMODULES_ON)
   and is not in the changed list, a phase-1 failure is recorded right
   away since there is no OID retry to fall back on.
 - If phase 1 fails but all required commits are already present
   locally, there is no retry to defer to; the failure is still
   recorded, since the fetch itself went wrong (e.g. a transport
   error) even though the wanted commits happen to be available.

This resolves the NEEDSWORK comment added by bd5e567dc7 (submodule:
explain first attempt failure clearly, 2019-03-13).

Extract the common error-recording logic into a helper
record_fetch_error() and use it in fetch_start_failure() and for the
"Could not access submodule" error in get_fetch_task_from_index() as
well; the latter now also lists the submodule in the final error
summary.

Add a test ensuring a failed submodule fetch is still reported when
the gitlinked commits happen to be present locally.

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 submodule.c                 | 52 +++++++++++++++++++--------
 t/t5526-fetch-submodules.sh | 72 +++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 14 deletions(-)

diff --git a/submodule.c b/submodule.c
index fd91201a92..8bcef68a42 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1562,6 +1562,13 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 	return NULL;
 }
 
+static void record_fetch_error(struct submodule_parallel_fetch *spf,
+			       const char *name)
+{
+	spf->result = 1;
+	strbuf_addf(&spf->submodules_with_errors, "\t%s\n", name);
+}
+
 static struct fetch_task *
 get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
 			  struct strbuf *err)
@@ -1599,7 +1606,7 @@ get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
 							ce->name);
 			if (S_ISGITLINK(ce->ce_mode) &&
 			    !is_empty_dir(empty_submodule_path.buf)) {
-				spf->result = 1;
+				record_fetch_error(spf, ce->name);
 				strbuf_addf(err,
 					    _("Could not access submodule '%s'\n"),
 					    ce->name);
@@ -1753,7 +1760,7 @@ static int fetch_start_failure(struct strbuf *err UNUSED,
 	struct submodule_parallel_fetch *spf = cb;
 	struct fetch_task *task = task_cb;
 
-	spf->result = 1;
+	record_fetch_error(spf, task->sub->name);
 
 	fetch_task_free(task);
 	return 0;
@@ -1779,18 +1786,12 @@ static int fetch_finish(int retvalue, struct strbuf *err UNUSED,
 	if (!task || !task->sub)
 		BUG("callback cookie bogus");
 
-	if (retvalue) {
+	if (retvalue && task->commits) {
 		/*
-		 * NEEDSWORK: This indicates that the overall fetch
-		 * failed, even though there may be a subsequent fetch
-		 * by commit hash that might work. It may be a good
-		 * idea to not indicate failure in this case, and only
-		 * indicate failure if the subsequent fetch fails.
+		 * This is the second pass (OID-based fetch) and it failed.
+		 * The commits are genuinely unavailable from the remote.
 		 */
-		spf->result = 1;
-
-		strbuf_addf(&spf->submodules_with_errors, "\t%s\n",
-			    task->sub->name);
+		record_fetch_error(spf, task->sub->name);
 	}
 
 	/* Is this the second time we process this submodule? */
@@ -1798,9 +1799,17 @@ static int fetch_finish(int retvalue, struct strbuf *err UNUSED,
 		goto out;
 
 	it = string_list_lookup(&spf->changed_submodule_names, task->sub->name);
-	if (!it)
-		/* Could be an unchanged submodule, not contained in the list */
+	if (!it) {
+		/*
+		 * This submodule is not in the changed list (e.g. it was
+		 * fetched because RECURSE_SUBMODULES_ON fetches all populated
+		 * submodules). A phase 1 failure here has no OID-based retry
+		 * to fall back on, so it is a genuine error.
+		 */
+		if (retvalue)
+			record_fetch_error(spf, task->sub->name);
 		goto out;
+	}
 
 	cs_data = it->util;
 	oid_array_filter(&cs_data->new_commits,
@@ -1809,6 +1818,11 @@ static int fetch_finish(int retvalue, struct strbuf *err UNUSED,
 
 	/* Are there commits we want, but do not exist? */
 	if (cs_data->new_commits.nr) {
+		/*
+		 * Schedule an OID-based phase 2 fetch to retrieve the missing
+		 * commits directly. Defer any error from phase 1: if phase 2
+		 * succeeds, the overall operation should still succeed.
+		 */
 		task->commits = &cs_data->new_commits;
 		ALLOC_GROW(spf->oid_fetch_tasks,
 			   spf->oid_fetch_tasks_nr + 1,
@@ -1818,6 +1832,16 @@ static int fetch_finish(int retvalue, struct strbuf *err UNUSED,
 		return 0;
 	}
 
+	/*
+	 * All required commits are already present locally (they were either
+	 * fetched by phase 1 or existed beforehand), so there is no phase 2
+	 * retry to defer to. If phase 1 failed, the fetch itself went wrong
+	 * (e.g. a transport error) and must still be reported, even though
+	 * the gitlinked commits are available.
+	 */
+	if (retvalue)
+		record_fetch_error(spf, task->sub->name);
+
 out:
 	fetch_task_free(task);
 	return 0;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 1242ee9185..188c674c89 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1262,4 +1262,76 @@ test_expect_success "fetch --all with --no-recurse-submodules only fetches super
 	! grep "Fetching submodule" fetch-log
 '
 
+# Create an isolated environment for submodule fetch error tests.
+#
+# Sets up sub_bare (the submodule upstream), super_bare (the superproject
+# upstream), super_work (a working clone of super_bare with an initialized
+# submodule), and clone (a clone of super_bare with an initialized submodule
+# at a reachable commit). The caller can then create an unreachable commit
+# and push the superproject to put the clone one commit behind a state it
+# cannot fully fetch.
+#
+# Usage: create_err_env <envdir>
+create_err_env () {
+	local envdir="$1" &&
+	mkdir "$envdir" &&
+
+	git init --bare "$envdir/sub_bare" &&
+	git clone "$envdir/sub_bare" "$envdir/sub_work" &&
+	test_commit -C "$envdir/sub_work" "${envdir}_base" &&
+	git -C "$envdir/sub_work" push &&
+
+	git init --bare "$envdir/super_bare" &&
+	git clone "$envdir/super_bare" "$envdir/super_work" &&
+	git -C "$envdir/super_work" submodule add \
+		"$pwd/$envdir/sub_bare" sub &&
+	git -C "$envdir/super_work" commit -m "add submodule" &&
+	git -C "$envdir/super_work" push &&
+
+	git clone "$envdir/super_bare" "$envdir/clone" &&
+	git -C "$envdir/clone" submodule update --init
+}
+
+# Push a commit to <envdir>/super_bare that records a submodule SHA that is
+# present locally in super_work/sub but NOT pushed to sub_bare, making the
+# submodule commit unreachable from clone's sub remote.
+push_unreachable_commit () {
+	local envdir="$1" &&
+	git -C "$envdir/super_work/sub" commit --allow-empty -m "unreachable" &&
+	git -C "$envdir/super_work" add sub &&
+	git -C "$envdir/super_work" commit -m "point sub to unreachable commit" &&
+	git -C "$envdir/super_work" push
+}
+
+test_expect_success 'setup for submodule fetch error tests' '
+	git config --global protocol.file.allow always
+'
+
+test_expect_success 'failed submodule fetch is fatal even when its commits are present locally' '
+	# Create the same commit (unreferenced, via commit-tree with fixed
+	# dates) in both super_work/sub and clone/sub, point the gitlink at
+	# it, and break clone/sub'\''s remote. The commit exists in clone/sub
+	# but is unreachable, so the submodule stays in the changed list; the
+	# fetch failure must still be reported even though there is nothing
+	# left to fetch by commit hash.
+	test_when_finished "rm -fr env_phase1" &&
+	create_err_env env_phase1 &&
+	commit=$(GIT_AUTHOR_DATE="1234567890 +0000" \
+		 GIT_COMMITTER_DATE="1234567890 +0000" \
+		 git -C env_phase1/super_work/sub commit-tree \
+			"HEAD^{tree}" -p HEAD -m present) &&
+	present=$(GIT_AUTHOR_DATE="1234567890 +0000" \
+		  GIT_COMMITTER_DATE="1234567890 +0000" \
+		  git -C env_phase1/clone/sub commit-tree \
+			"HEAD^{tree}" -p HEAD -m present) &&
+	test "$commit" = "$present" &&
+	git -C env_phase1/super_work/sub checkout "$commit" &&
+	git -C env_phase1/super_work add sub &&
+	git -C env_phase1/super_work commit -m "gitlink to locally-present commit" &&
+	git -C env_phase1/super_work push &&
+	git -C env_phase1/clone/sub remote set-url origin "$pwd/env_phase1/missing" &&
+	test_must_fail git -C env_phase1/clone fetch --recurse-submodules 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
 test_done
-- 
2.54.0

