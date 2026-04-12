Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E437B41F
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775994713; cv=none; b=JYqT0jBkD2Yp64of/Vi0JNZgRrpt6LlKll1u2aPqL0nCmquudAgVQIaolKRhkx2L7DaNyE1tXPLCHhKepJceMcuuBt9tqT1lt0keqeSFlB65HX6ZpiEj7CstB5+eERa7usq/jVy6ZnllFKmUD0v3o0A6Cakwxj6pd9348thrhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775994713; c=relaxed/simple;
	bh=peanzqg3po14Yua69PGEov2w2AAfB6azaIxtlsXqF7c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BbmSIsVZhZlYigyzDQmCLxIVBJAk4+eTS89h06SqafNAeiHYL2NJt9/aq1Mjo+w0KkReLldGYsC7q9LDn5dxnoFtr3OosChNg5NBY3nxyEoNJO3cjSNqioICetFfpv8EZ0Tcd387ZSEEftikQmxsnRIqiR7k4HKcxGwGh8OelSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pg3JWvjg; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pg3JWvjg"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c19d23b19so3458904c88.0
        for <git@vger.kernel.org>; Sun, 12 Apr 2026 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775994711; x=1776599511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ/ml1zRMn65NodJaD/o5ZolwQZNSyaDlFABD9M5TSk=;
        b=pg3JWvjgohZlp4sojDUTdVZ8X6fVoLbPeagxtyHRe28EH5xrZQp3qM760tN36FbpGa
         mmX9He6N7MJW9lcxg8HQUeSbm+PXcL/ZMKmIVdrje8HJHhojg/ID2TaJglk3CVrIglRh
         ZyO2mWP+rRVUuySh7lmdH06Zt01WYZAbdA4Ye01qPfDGm/hbJttryPXhZUr1I3aKvyLr
         NLxGtH9b7kmBieWrE1TY4oKWcV0hUq7l0k4hNVQJ0tXnutahY82ytkeh3HWoa2HpS9EA
         X1Y9lqh4uL0v2fyQOWpvYWUYeGAYk7lbx+ezy65BkY+vVAcDIWX6wfuus7G3xx3Yt9YJ
         cEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775994711; x=1776599511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ/ml1zRMn65NodJaD/o5ZolwQZNSyaDlFABD9M5TSk=;
        b=mhggJX2lOMZcmWnFCufr07YtfKtcPzMkeVTKh98RBY9qFBVlNU4Az+ChrofwgqROY+
         wf2n/O7CcOaa71DX3vyMRK1om99fsWBof8k2oz/8CGqzGOvPiE3QVHLPRQeru41a97Mm
         9UQfYqO9VEtIfnwHcQo4B8anNDF3czrNaZ/amKNpjRTPnllL7D0s0fWdZw6NQYHkh21y
         oKShHoWNbVw3AO5bao3om/TPCrRFcr4W/M2N5jezrdFoJV1ojWYG81jMzVAUoXHakmhd
         dajcwDi/dX4AIw5KFh+rr/w8C647F6kMgE1Qjm/ghYgCbzTO/t/o0dqkNH88lGOy1B/N
         RPvQ==
X-Gm-Message-State: AOJu0YyndFYdkYAePPIQJCTw42fF9qaYrfXYQCJCBws4IXDDzQPzl87e
	CAXnzUPWuA1FzFslMePuXRg/ttQtbQCf+nAT/LDkDgZ38VaZkkV/EIlF/D+6mw==
X-Gm-Gg: AeBDietauACFnxYXLl5bOUA+gbh/coMaLmla3TVQXtE9a9qiz7fFWqfC7NzD3bP+itq
	b+Xo6IJeLiAA5UVdc0hpEg2QRfIASWlRjJPpEl3BnvDd8cu7byZHNcJv8W5VLS+pmV778JNc2yF
	9CsTdE151chbjE8EO2SUDvXyw/9Wz1yULjo3QZCKWkD69Xilrg44EdAdaMbltVTCytX1pBWzs/f
	bmg+reaDReusnF1G5xYR/VNBEt09q+ILC5s/aCudDRFLg9fWU20UgdjI6D+0yNzsBFs5VsWn4RU
	OFQFrnCS4tGd2Q9FO9SsNI9WoSufap1ZEnR48BNWrOv3hnkSM02kpH6na8OrhluegoMJilS0LGS
	s3e+XlNwJDLH4DHmXnxMOZGmInqM8CaKab6zTWvIWM23LLVPTofLeY4cMCqIANI0uXdD/+xrYLj
	B4iyAajonn1WjTbpcyE5uipMJvVfYj8bbr5xCDUx4=
X-Received: by 2002:a05:7022:7f0b:b0:12c:3d3c:ac08 with SMTP id a92af1059eb24-12c3d3cb6a7mr1766862c88.4.1775994711029;
        Sun, 12 Apr 2026 04:51:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.129])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb031sm9948984c88.13.2026.04.12.04.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:51:50 -0700 (PDT)
Message-Id: <f36fedd8c298159f3fee68c74e6640c18490703f.1775994705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
References: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
	<pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 12 Apr 2026 11:51:44 +0000
Subject: [PATCH v10 3/4] sequencer: teach autostash apply to take optional
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
    Jeff King <peff@peff.net>,
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

