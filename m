Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C2230BDB
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199384; cv=none; b=RvIKjBfhzvXimnnp6+WGLzpusJK8TFTkcuoETMV4JqAS7SuddAseK3Lv8ttHTA+tJzOBPPmyO7B71zdAoR+Js/5adpgLh9SNiZQHaC/OgIhrJV5SH7ZwdrsGhYLX9fN1YHUE763xb8cfb+lorKi2BrS9jHL8YpocyXv86uje73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199384; c=relaxed/simple;
	bh=FsIs6iQ+3uu3+jw8P/rMcOtp/ZWt8ryHk29y5qwdNL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr4grNTvBsG2fKeyHpcAwdMyIQplAdMVcaJwvx+l96fiW9vLBO6hn1ckjR29VkNM6770polwupqjovdeYoliBxGuhXd1rVsmqSaLLAY/t7HiqLltDjN6bpugHFiJBx9nnepZZ1agrE80eAAictp23rLncwG8BUBjjLICDrIdQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r17ir1qM; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r17ir1qM"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so1460391eec.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775199382; x=1775804182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbSL0IqOI8oxEPEQIKIXTnvn2QSPxngRFM78BiAmBaQ=;
        b=r17ir1qM4I/RuHmoXbDgXAGkWiZ1tETcvD5sK2BMxveQtFi+g4Lqa9fjfAdlYcUIX3
         p+/BDMuR8Q61x9LjNcX3IKz5DpTFOfd3hhPBMg4XbPoH74eTDFMp0vkB/3yPYpQv3N8M
         ZRd6stJunCzDbzEk6+r1Zn6YJNVTvOKVd6VkvHGUvlCg+fN5ie1m1Hb9VTA31fJwuHJo
         YBaNxiL9ZONDNi5BMbtKHj5oSSNgjEm86ojsxzbddo2ujS+K73r9dT4vCoxPjxpXxLtg
         mseOGCgnoZ+qzIfcVNsSTRhopVjv4CRXtizZe+8uQbzLT89jxipDFxLPVmxLiIaQhPgy
         iNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775199382; x=1775804182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YbSL0IqOI8oxEPEQIKIXTnvn2QSPxngRFM78BiAmBaQ=;
        b=Jr13hqRKJJvF9isRcjRNjJHEjBuzWC7tKn3NsbV5Cf275EPbei2bK/5+QAGUEAQ8zm
         vAJcACgUlWBLK1xevlq6NfKeUogu6TQ/ITgz+T796dx967VvIlt7SEUR7NyadusrWcHP
         KZ985FqD6ytmAHmGDEmDYrw/612NdbkPmAp7qaf5js8zXzYtoyU+e/8rBlrJ8PSLk3gV
         8zV7ONO+CkXrp0MS2E1Qd/5FDrszty6+RFepBiBW7JTB12PwhZFFnfLNcnfcpnbJqwZm
         7VlMOAJQQEDQa3zQ1XYlVuXXyWz3rr/Mh4r6Z/eweH12vtRoKm+kgHIXocar2J5jk1oM
         edkQ==
X-Gm-Message-State: AOJu0YxTryvQbkY48S3WHhArFrE4/6Fek3mKE9GNz4CBES35vFEpk44B
	Pjk35m4e8UQxZCOYX+PssQ3kn2NGqxBZ2KYC34bZhQFMqNtNr8BjlCT9qaQ59g==
X-Gm-Gg: AeBDietYncVU4FMqGGztUKpXe+FwefoP1AuaK96lNA+b2dMYgdTHJrO5y5CXBLM3rt3
	R33y8mlavkfy8MfYUO4tx2VNgjKbTkj43kQwWk+oNskT7okLnBf8Ex+W9EVqNHbLZzX5tsOzPGQ
	DbDHz4h6cl+LbJYNzXPWWcwj8T8T9WUqo4WgR9VZs2hVDQgjkWWc0oQ3jb4gSVcOD4ZPLoM7Z9E
	VRY48xbKdGe2vkAVzwpATIcbwjIH6pmt09TOlbFE0bVkfZyypEIcwbcPuhlipBvh2j7BRbVtN9s
	cq6Kav+A5Ydk7HpsDMqmSeDqO2LpceztYM3/oYYqwBG2v6GMfYr6GAxO5uyJx/HMj5vGhxE91Ia
	YWjTWUk1+ONvOJdKRB3xNUCYe4d1aBZUP8c1NIoKFWsKRjXVno7i2UuJc83JjwCGX0hkn14FEZc
	3ET0PmlVhYjuJbvtnWjFbN0vGLL4YhdDOznmRV1oXeuajhoBd9amHXwnvx7oJ69CVOlYuiROvAf
	m9lauWozFbkx698FbacMSGYZxuSllnrh3gK
X-Received: by 2002:a05:7301:1687:b0:2c7:8e1c:9566 with SMTP id 5a478bee46e88-2cbfc16e121mr1084302eec.16.1775199381599;
        Thu, 02 Apr 2026 23:56:21 -0700 (PDT)
Received: from M-K2012N0113010 ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cba62d7590sm3097188eec.24.2026.04.02.23.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 23:56:21 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
X-Google-Original-From: Paulius Zaleckas <paulius.zaleckas@ui.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v2 1/2] submodule: fix premature failure in recursive submodule fetch
Date: Fri,  3 Apr 2026 09:55:33 +0300
Message-ID: <20260403065534.252799-2-paulius.zaleckas@ui.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403065534.252799-1-paulius.zaleckas@ui.com>
References: <20260403065534.252799-1-paulius.zaleckas@ui.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulius Zaleckas <paulius.zaleckas@gmail.com>

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
   locally, no error is recorded.

This resolves the NEEDSWORK comment added by bd5e567dc7 (submodule:
explain first attempt failure clearly, 2019-03-13).

Extract the common error-recording logic into a helper
record_fetch_error() and use it in fetch_start_failure() as well.

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 submodule.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/submodule.c b/submodule.c
index e20537ba8d..0fda96a436 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1746,13 +1746,20 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 	return 0;
 }
 
+static void record_fetch_error(struct submodule_parallel_fetch *spf,
+			       const char *name)
+{
+	spf->result = 1;
+	strbuf_addf(&spf->submodules_with_errors, "\t%s\n", name);
+}
+
 static int fetch_start_failure(struct strbuf *err UNUSED,
 			       void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
 	struct fetch_task *task = task_cb;
 
-	spf->result = 1;
+	record_fetch_error(spf, task->sub->name);
 
 	fetch_task_free(task);
 	return 0;
@@ -1778,18 +1785,12 @@ static int fetch_finish(int retvalue, struct strbuf *err UNUSED,
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
@@ -1797,9 +1798,17 @@ static int fetch_finish(int retvalue, struct strbuf *err UNUSED,
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
@@ -1808,6 +1817,11 @@ static int fetch_finish(int retvalue, struct strbuf *err UNUSED,
 
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
@@ -1817,6 +1831,12 @@ static int fetch_finish(int retvalue, struct strbuf *err UNUSED,
 		return 0;
 	}
 
+	/*
+	 * All required commits are already present locally (they were either
+	 * fetched by phase 1 or existed beforehand). Even if phase 1 failed
+	 * for other reasons, there is nothing left to fetch.
+	 */
+
 out:
 	fetch_task_free(task);
 	return 0;
-- 
2.53.0

