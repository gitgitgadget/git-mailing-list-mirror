Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94240EB9B
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211003; cv=none; b=hWB4bLzQ59jH6TDM810NzGdkyOUkadqsqbjyAF4GZ8ohdoJXBpzGa4gSvImmBwMdb5eMk2rwSWdPbu35mjR24a5tZ91Vitk5kkTcE7PHfRtOa2CO8o8KUGhv1xkUFVM1xmYca7Ev+A4F5g9EYqDpMI2g9lZsfgB3M9ycqp/wPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211003; c=relaxed/simple;
	bh=AbWsv4yKfvfJsmFhH3KFq2WFkiR5tcUnf4xKsf5dxWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxWKB8MrO6oU6sLlLzwvQ15cK1VoGP41lDErOzvB1mFb8Ce1s1bveg0r6HuMBYFbupchN31U5CNygd3+BIWpIeGdmXjyoUkvhBUe411W7SrcfYpR0bbeQ5YWtrxkYdkdqV0LGb/+tirPmRTnTN5uxDx6B1NyznZX1fFDKXYHbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXkWzwCp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXkWzwCp"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so10484245a12.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784211000; x=1784815800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYl0yQb65+uEI/WZU3Ll/UHBtY507WtGgOubkMTyZSo=;
        b=WXkWzwCpq4NLy2LkosjCxGs4D06HE/MowZaU67StvBsdZA+vi2qZfsQBkA85ur2zYR
         Phl3waBRarF1VCxoiMbMjnKbRQDDF7dmj42B7t/MOxsdvTp6Nh8qClceT+tECPl+Ostn
         ZG/3oIWXrKUYPrU2prn+dvJJA6zrqhrBKjQB2wlRmzT7wy/KJ/NaL+RdCCktrQ2QpwsU
         EEwAAFtVarKzxmYv2x5mtnPSXcT9hwYOAtoo4oJ2uDAudtKqZSwgtTmh+LVg+5hHtaLC
         gW0uqRBUqFT0o4rgNeeeb5qu5PjJnCbKnqALPaE/ApghoeC8XHr1GVDjvMcNO0CZzycv
         /6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784211000; x=1784815800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nYl0yQb65+uEI/WZU3Ll/UHBtY507WtGgOubkMTyZSo=;
        b=U0MMg3Zc/7jWcMS/6BSAFmhXkYwZWm52jDu1aDBsbAjE/gT12sI3pA16ESdz/6oG4D
         fFZ58wKbrLZEOhxMH8Eev3HphPoHX5aaoaaVrY+kSKb0RGxKzRMufITwrMIlhPqh2+6C
         1I8qh2y3oj1F4wF8ZV37RWfubCkhpgWVtcv9tBYmC8R8dTegvfiXnBjItbclCJPFp8NZ
         bfdJ5B9eK13Nu6HohxnaL6JRFL8eIy4OhBaKkTupSEF0S/K86VAstUd1svXwFL6sIfOC
         ccyAcLYiBgjVCT+gkcwQElypvz6mzfUGzHKp9zZz85V+kjetAOZeziynLna9IoGPgZ0N
         bwjw==
X-Gm-Message-State: AOJu0Ywtdat50+bJ6/UyOSURdh7edC6QhOKx1v852+np+sUjDbdblAOw
	q64E18ikbyfhJWeAMG4iEaoxLeQ9uYebbry91L3PyQos/Grte8pXtnaci/8+on48
X-Gm-Gg: AfdE7ckvxAFnu3DjWr3NATw309K2CITTO2cdQ4uRTNBBi4ixZPRHuy2Rpkh3Vp/x9hC
	IYNV7YwraF212R5U+0GC6q9Cfs8rr2pW42rCw54GFGUMXCOvpECGUDcuYhn9HwWyiyanFpnwpDq
	RPorC5i/6qANIUB0supMCXulYomOkiEDR8JNnZeJOGkl0bW08SEcb6cERenkAzIQy7BNPJtXFcq
	FSoYd1jJQmUEUxwzu5oOPgUBvpYIXW9bVvlmN8TY+xHAGPW+IYcK+nAA7C3JOmiPUV4MdP8GJjj
	AuJXXSQmdb7vcmJ4mMz6NlPPwsZYhjw9fzAmcA/a+Zn+SbSDkNiZLLZbDVe45idK3E7kVkKqU6F
	MReDq17XhiQNpT6EYJp++225uuBGIRyncca4o5yEwvonIFjYObv6DUVtZSmplhcwjGyI9uUVhl7
	FZYLk5JOheb1S0AOevA7PYQ0rrR7zVIdixaVaEl+UdPmwgHvojQr1Gt6gc1sXYhzALj6zO5rFRa
	yfN3iWgGKqCs/wFt7L2L7BT4ocN9Vwgbqn3jHcHMxrEPw==
X-Received: by 2002:a17:907:6093:b0:c15:beaa:7ec0 with SMTP id a640c23a62f3a-c16616641a0mr721842266b.17.1784210999663;
        Thu, 16 Jul 2026 07:09:59 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bff3sm226720966b.46.2026.07.16.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:09:59 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	Glen Choo <glencbz@gmail.com>
Subject: [PATCH v6 1/2] submodule: fix premature failure in recursive submodule fetch
Date: Thu, 16 Jul 2026 17:09:53 +0300
Message-ID: <20260716140956.1023740-2-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716140956.1023740-1-paulius.zaleckas@gmail.com>
References: <20260715103518.526326-1-paulius.zaleckas@gmail.com>
 <20260716140956.1023740-1-paulius.zaleckas@gmail.com>
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

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
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
index 1242ee9185..7ad274ce04 100755
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
+	test_grep "Errors during submodule fetch" err
+'
+
 test_done
-- 
2.54.0

