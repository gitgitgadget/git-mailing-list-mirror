Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8B3A960F
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854883; cv=none; b=J9NjlTfZsv5G56gyXdnZT3P7Jvb5VWPIfFRIazcOkRPaGWn8o4JnxhnIJtuk+qUZ3QTYLn04I7SmNUw5Ui7wmGsTJNdRYmZqyAa+IvpRnJ1Pqj2qCxPSE4T64JX3h2tzaef0Po8+/mrp6zuN1jSnpQX51nj7XfqEAWKID4A9vhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854883; c=relaxed/simple;
	bh=peanzqg3po14Yua69PGEov2w2AAfB6azaIxtlsXqF7c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Dp3R/XOMndPQ/t0BIKFcvBWrUi4sT3LvUdaW6EGm00BwnpkoMEvb4smt77h0xILjHxxi4HDkWzLA7bA1NekO0q5o1uawBthtaVX0YfRR2TiUEwJk+RkdXfXf4DWqFZOWbj8t6GKBkd9iUUceFYlG2qceubcVNCiTPdGBaLdS9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No5tsMR1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No5tsMR1"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d00cf835b7so294782485a.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854881; x=1776459681; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ/ml1zRMn65NodJaD/o5ZolwQZNSyaDlFABD9M5TSk=;
        b=No5tsMR1bI8A29s1S5g8iffnYiYPF/NF3eD1SsADQ82OA9Evx8/Eu+1gbdwO0FKDOi
         Hx/PmgTfFx++vqSjMXS/4iTAqR29peBpap6gtacqCBOGzXzJYbJT5anyJQeLhov9klAP
         P1yI3hYSlk4v+efpUgkbz5y0bDE7Lg/Z+dlc9srOj9LOElea0AWxRHnHGpOs57PQLRb5
         jO6caECkaJS93vH6kU882EopApFoYCBEl134JZOuLKLKjQOoDnqucpLTo1iyQRKAOHgS
         2ONQzkiLB09KiMix8fsWS1HCasWkzW4cqmtA1R3fhVtwfG63wBzXaImk4XYbLGD2fVb6
         5hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854881; x=1776459681;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ/ml1zRMn65NodJaD/o5ZolwQZNSyaDlFABD9M5TSk=;
        b=OpzaPVm1jhexndrpKU6o7BuUMobf97Oo3PzP35cNF3aylcTuLOmndjdI5ZkNc5UXlZ
         36GUoGxNNh16JS2NvJf50XbUGFEDeDsPaEKP+6fvr8uANzVgFffwiju6JAL2Y+xiNyQj
         YtfWCX35UB+eRJ/7MYOTLfHxpgvO78sptCpeEnliO6TOZzWevPRT4EPvi23YmQp28a3w
         WOnSfq6q8JT/u8qDSXwqITZDT3DZNZ3EEIUrC7rbY4kcSHeMnbGshWc1hm60bOr5zd0q
         ILDIBBq31B/wVFGo2hboq/qHg1DotF3s0Qxsxjcbec9B61b5z1SZY+SoyPx4dD3BKnT8
         LIzg==
X-Gm-Message-State: AOJu0YwV8frXOrAltM8DdYGp/12QoFnDxFGUK4yh1ZWF4YF/L2Y23+D9
	s0cUwTMsDV6haoCGlKbTy8y7vMT2rwP5JZtcOcg7dyKWeuurgEYgM1iP25Pkxw==
X-Gm-Gg: AeBDietq4dZ7J0byBfP8lrJvaHaXrGN24VlF16PgB3iw+r0U3aNEY4EJCBEGsbCltx6
	TIKtnuaLP8q1POETtX5DnZkdVEbeXxZMHjW3L1MsPeeqk3nsQf/iVZsuU9dwDWpoyX2I8WdgHF3
	er/gz3emz5YUe/Z7wHJzAj28Eu5mUsVB7cJ4Ol/BdE+d3AkTYFSk1rccT1bO2KzqS3R1Fyi+P/4
	GZSIwv3qP0oHqz1qePyPMxweyvqEP4kXArWQ4hu/A+0WudmmRtKs/r01h+Wz7N9/xOJLi1+Da/H
	/5O5P/i3Yb73r7DCkyqsFpQv719VWODgZzuKOZV/hbKst3NY+Qx14CVAx/mfvwPmhknqb44qOyV
	3/fz1I9kdXHhk8iGW45laY67ZehWNWFpzW3SyXtqGc9QdAmwzwY/7uyly6OFqBGTCS70CAuwu5h
	dGlJ8siqO/B4X5ggK7Gfslv83XBg==
X-Received: by 2002:a05:620a:4626:b0:8d0:2609:f515 with SMTP id af79cd13be357-8ddcd50402emr713041485a.25.1775854880703;
        Fri, 10 Apr 2026 14:01:20 -0700 (PDT)
Received: from [127.0.0.1] ([52.150.30.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8def8ff405asm65156285a.47.2026.04.10.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:01:19 -0700 (PDT)
Message-Id: <87216a633b13fb2223858772cd3249ac88452ad4.1775854874.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
References: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
	<pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Apr 2026 21:01:12 +0000
Subject: [PATCH v9 3/4] sequencer: teach autostash apply to take optional
 conflict marker labels
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add label_ours, label_theirs, and label_base parameters to the autostash
apply machinery so callers can pass custom conflict marker labels
through to "git stash apply --label-ours/--label-theirs/--label-base".
Introduce apply_autostash_ref_with_labels() for callers that want
to pass labels.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 34 +++++++++++++++++++++++++++-------
 sequencer.h |  3 +++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1197d7d8a0..913be115f2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4729,7 +4729,9 @@ void create_autostash_ref_silent(struct repository *r, const char *refname)
 	create_autostash_internal(r, NULL, refname, true);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4740,6 +4742,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		child.no_stderr = 1;
 		strvec_push(&child.args, "stash");
 		strvec_push(&child.args, "apply");
+		if (label_ours)
+			strvec_pushf(&child.args, "--label-ours=%s", label_ours);
+		if (label_theirs)
+			strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
+		if (label_base)
+			strvec_pushf(&child.args, "--label-base=%s", label_base);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
@@ -4784,7 +4792,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	}
 	strbuf_trim(&stash_oid);
 
-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
+				      NULL, NULL, NULL);
 
 	unlink(path);
 	strbuf_release(&stash_oid);
@@ -4803,11 +4812,13 @@ int apply_autostash(const char *path)
 
 int apply_autostash_oid(const char *stash_oid)
 {
-	return apply_save_autostash_oid(stash_oid, 1);
+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
 }
 
 static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply)
+				    int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
@@ -4823,7 +4834,8 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 		return error(_("autostash reference is a symref"));
 
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
+				       label_ours, label_theirs, label_base);
 
 	refs_delete_ref(get_main_ref_store(r), "", refname,
 			&stash_oid, REF_NO_DEREF);
@@ -4833,12 +4845,20 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 
 int save_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 0);
+	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
 }
 
 int apply_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 1);
+	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
+}
+
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base)
+{
+	return apply_save_autostash_ref(r, refname, 1,
+					label_ours, label_theirs, label_base);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 570f804457..2c4ff17c4e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -236,6 +236,9 @@ int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
 int apply_autostash_ref(struct repository *r, const char *refname);
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
gitgitgadget

