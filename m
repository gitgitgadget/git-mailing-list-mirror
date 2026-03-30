Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFE15A864
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892462; cv=none; b=POZ0Rmyeso7Uoa8dupaOtYdyf5oVjrI7fsH60p9kN1br4MaVDXqy23eZVbsuVIDfP3HgdWsUV/NF1QrmSWBiGiA7IJ2KNFVrlB2eWY3bgMEEgXsyjc1APE788a2RGQ7/XKB8hIIWvob7NMQsqKC7fYCeDKZaJGVxgVMi2B7tu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892462; c=relaxed/simple;
	bh=N0bmOZdDu9pxJcETEJxv/hGaHItAKrmQlwddWKBEVdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6IdFpn7LkBCx2ydYx4K2FC9tuE2pN346Au2jTNLSp69b6XiM7NYOk3CUEMnTpD51bZg9wGNUMBgxuQytjWOgeE2vYro9yX92JTQ4CgzMz78HEen6fudcHzuVlA2HbaXGMJKWxWwNjHhedP0efj3Aaoet45bHWlnp/6cSFeYeFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1SVsO6B; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1SVsO6B"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b982b0889d8so567777266b.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774892459; x=1775497259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHDZCxDLsj7WRz3S8qbFIHzBStUVJ9lJvCMttFGc0kI=;
        b=C1SVsO6BdamHViqtsKscpLYMX5HqYQty3qslGI3a1ATfdEkC721WSKfmtGfMiN2ySM
         goRG3llmFD3dWNR8oitOV0IvP9QETJWl4/AK5S7rMGusvFoOw+iG4dzJw2YhN9OgAFas
         4WfnPuE/Ynjx3jy8LaLzGgDFT2oUUBh+4X/RnD3kAhpL3toSjL68GwyffjaSEG8DB9TV
         sotHrixkq0KYSmJpBbZIuvoiVVBE9VRT/AqM69iDmmbpRE1HvdBYUa7vlnc17jjaOHeV
         wjPnVoMkH12uLtqhgVDBBPQg0AScHZy3LAAIo+5GqdRxFRlhd8Ns7P7WrLjBdhiimMVw
         mrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892459; x=1775497259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHDZCxDLsj7WRz3S8qbFIHzBStUVJ9lJvCMttFGc0kI=;
        b=VQQYKNxEVcVA19dXPwj8SNVnNRMMxoD7qJwFckXObLDkBK1V/2y3qR0r1eN52LUudQ
         iMfQiy8cPCCpz8d2q8m1Z1hS+29BhvUhXlwOEEZOyBtuPwaqkbEYQagYWz7BXRige1Fp
         VlmxXxfKIdIP/rueE+VcejoSzJ73Fql4j/l42LTvVbsYlxDb56c0FT5VFdHGUAy1sCLg
         bajQJoc/8mRtEWslUPoK8zxxzzX0CZF1e2CwKqbnvcpjVPFbgmMg2Oj+EYQXt+yOeubQ
         PdafkGnoT0RxO2c4GHNgPKJ6NDLJVuSN6TugaozPZIPIJvGcQ1f07mjFc/JImE6nkAgd
         +Y+A==
X-Gm-Message-State: AOJu0YyEa3kQ2cktTEKkxCCfLJFzwLPGdxrv/+ahTVjD3ukekwHAvwwg
	AFWNM2izVT1pcocN20ImGbT9UhKQReZUvV6/w9q6cR7TlnKpeYBUjzpug8q1AA==
X-Gm-Gg: ATEYQzzal4UUrb9pWVDpbu1Vp1kHpx98XY18FhcWrw8j5IRunRqKAimTAb6opheUu8B
	CznXO80A3wzIFsIgUfdKIli4AMZQaLPBfE+ZF2VcH9DaiZ+sSutB1xKsNYKIWL4onR0d0mP+cLU
	UEmXw+tLdKp9dTk083wsDDrfGwaw5VOM5XauFC4u62EINk0k2IaGgDGPygL4EvUf6LD1abrbWA9
	Gqm4Toz51E9h/XtkG8QRhuDJ8TFnkpr1qc3HseMy6H3g9bEKwlNVs7Q5EVaHUQkzeEv3pnwVD94
	XSHT4vgpFFtZ62PwKPTiLrYJt6TWoINoZUyXBD5ZYdal2gdopSZdLxU9BiR+Yn0Jhk9h1hXRrlE
	I8B6HR2KvFV5wIJpw8543gWAW++xL19/ZVRYFACu4hJceqtlI638L5tAuHKL+OqvlhTRRAbdvHb
	ov0mtkUb20lAVrn8fR1Qt8JjBN7G0fWN/zQ1OTgHby8XOEyLUlkruu+f9MmB2kC3bIfsSgyMJzv
	QXyojr3AB2OgUm98wfLKgdTf2H88cHJKZOO8qG+B6Gmh81zf2dd+mUP
X-Received: by 2002:a17:906:f5aa:b0:b98:e4:6d1f with SMTP id a640c23a62f3a-b9b50950763mr849083666b.40.1774892458860;
        Mon, 30 Mar 2026 10:40:58 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae520c2sm320769066b.21.2026.03.30.10.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:40:58 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 1/2] submodule: fix premature failure in recursive submodule fetch
Date: Mon, 30 Mar 2026 20:39:37 +0300
Message-ID: <20260330173938.3792358-2-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330173938.3792358-1-paulius.zaleckas@gmail.com>
References: <20260330173938.3792358-1-paulius.zaleckas@gmail.com>
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

