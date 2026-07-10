Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7B3C4B9A
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686426; cv=none; b=kk6iTT8t4uA7+umwF86tvSJrgumYeX3pwnNaG33BJz/VvGt7ica+5+EAqjqlSqjcKbDsiTZEFR7srMGM0EHoOOl5xCQaF+74fksCUtenkLa2act+izEmsSczTWLDXj+fwWcCQlZFyEgY1ZVJ6Q8n/ldhn1JicnvVWxYTwfOxr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686426; c=relaxed/simple;
	bh=pHLof1hDxeD4OlU0qpd4dSQMhjfWDiekLgg+VoCyZ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoI8+IOSGaOSJeks5oFVdL6txiF5v56Q3/KEHspL+SW3G8eG9K07qOodBD2HfqDN45u9CXKAXAzeroqjDlAoaW+to9eAB4Gc4TSFVQUQFqGY4Td3zQmAE/iBnQXMcy1eeO4hQ77YF9wu5rOyJNhIw7ZPWFBH/apaFK4nOBq5dLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWQeCVLY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWQeCVLY"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15e3141d02so105747266b.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783686423; x=1784291223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0yyqNxPGiafPUm9MbK7RcUN5wIGZMAldLa74kmWIbE=;
        b=JWQeCVLYlkuER69KxQvd99/zZ6VWTvEexbE7zdZVUnsqo95mVakC5lHMHd+nHUBTgR
         /kpFoPWN9t9JtEeXEHl826DAezVB1ie5ugRNUqh10fvTHFH7lUidPSMU2tJ2SjV/cToh
         sh+Bd2U8mnnqW/a5j0iisiXexsoyGL527+jbxUebAeXhZBC8JTiBQp+65aaRovrvv0Rv
         uWHbHGQIWDaEzcpjynUBElsYhqOSPDK9plzibIUEWWpqAU5pHagBDEf8Y1VI+dPIBVj1
         li8UmSsoTb+FdsFJRbp+gJ50RxG++VlkGbBFRWMRyPtInq9l9tKfHIyo34anz4LCRupH
         xDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783686423; x=1784291223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N0yyqNxPGiafPUm9MbK7RcUN5wIGZMAldLa74kmWIbE=;
        b=Sc1UNWbfQTDLRMToCsyfqIOgOwwHT1oMhW44NC+QXBxLmNg3tScKUjXnRoBT67kTi6
         6A5L+Gsd0y6VKD+JYpb4dPiI+KG9hb05aNJ5Yienh31euyExMfZYDH4cGJopfvs25r4X
         UviMM1qbWr+b9fXQw6vgoUqXVU1LeGg4LaQ8dCxiSo8/n0Noku/Wrr64yAKIwdSv5KQj
         bCosXNmcdILtgBe4FCsURFcwMMOVkehWT50j8JRN2sUuPiWT3CFrjJZAjMGfMH9laC31
         xkD8eVM43zscUVNixbTe8xbCi7WQFFUWe9gYw8TbLf+EWU/JzrQ5seTJgoniKJZ1wTod
         rjbw==
X-Gm-Message-State: AOJu0Yx/MTDJ+ZzSuodjCr7pZAqIT0ZE9GBou0RY1FLWuoOIFGzC+w+K
	VZeroJ4STxEIsXElGPQm3UBwhWwcRfLpA61WGjGmMfCiEWq8bBlLDc9zjRFHfvk5
X-Gm-Gg: AfdE7ckn3AGdDfjuSKQZmnHwbDde9K6YPqezDlqnNYipUsm+jIpALWwiGh08zsUhsqm
	IoinJUH4QxMy6LhZAgq5T5Q7/DirzwoYBJ7vnFFGqBXj4qUPjQXfoN/+9Jm1WLNPJpOMa+HBN2W
	fYyqJ9R02DdRSLM8gmsPTeUkf0neN0JIKTXFY8cQc10YOq8eiyJW33tHvDgWN3pStLoKGyyRQ/X
	mWGd+LDjV0oDQapdamtkUfzyvSQCt7pxyIpxQMAOZ+gXNudyGOc9dar1QCBfvk0GfDiW1Il/RC0
	CSuQSvOB3E0pFiruIhG67bQtSwib1snw9si1NRf6b03NLidGgp7rEGL+G43ROoG5W6xNI3QljKq
	zD5DaN09QwAIxNJXoqjAtzgqQZDzNyq6DszkJ/sTYMvP7A5S3e6PUh4qdl+ziOjbW2AxnIT0oHV
	XwrfJ64CnVx1h2S/xfdVSLR0GJyjvMHI3DJ7+dmFtIA11FeUa3lKjsPxkHyU2tlrwwdjI87Mgkz
	OtnDhncaWOJwF8gkvYIZ0iQPkLtbjmHd+uwSDLazlpP+w==
X-Received: by 2002:a17:907:7254:b0:c15:bc2d:e938 with SMTP id a640c23a62f3a-c15ce1867c1mr530548566b.32.1783686422466;
        Fri, 10 Jul 2026 05:27:02 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ce1b374asm405212966b.60.2026.07.10.05.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:27:02 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Glen Choo <glencbz@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] submodule: fix premature failure in recursive submodule fetch
Date: Fri, 10 Jul 2026 15:26:52 +0300
Message-ID: <20260710122655.3066377-2-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
References: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
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

