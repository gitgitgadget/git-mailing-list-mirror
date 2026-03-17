Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27152371072
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740147; cv=none; b=lRRgyMfr0vM54yaRWaSkDVpWGwDVWoQDD1agK4sRHC9R91tAr1HppXMvO5HQrKOCW8LoVBSbCY37H47iAAzZd+U4lmhFm1wi2YkxRpehr4b5cGp64hgecz3V0LqHq29/dncPfCSAB9Q+yrzbe/oWdbhUJ/L/gmfxZFnkCRt4ulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740147; c=relaxed/simple;
	bh=+hvHk8lZJZMPLekC/cT2BsghDXTU5VeGTIHVLBnsh2o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NOkAlOj6s/D1MwueGC5jx7jSrT6YXIrkIk+w4ZsJJesWbo5OZkN3J+1B4grDN6YwtKAUDnYRON+Dodmp39HwsZAkp7ezdmbmIQ0aUzkkFNpJ/HniWCO/jlPMYiz6w8qN4PfB6qnWZd08ON9kX0oZfLQNRcQZ5Yb5ARwuTd/VJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5mkEvUY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5mkEvUY"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso2676580a91.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740145; x=1774344945; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2PXxXk8VhvWKdh5qbCGPAjYxJFK0r5hKMGsfLg7vY0=;
        b=S5mkEvUYlK0xOsjPfoezan0Sx1juRfrKdnOLtemwyrtKLro3ywAu08nFPQ9Kzp3bay
         x55m1RV334LObIq+HKxMq29f/Cj4uEQelD+A6wsGWSQmItgIAhMl7/2qPL0www3mrTYi
         265Br57ZoquQovgbO9/z6cQhkPCTtXDGBiZgZg7JN/SBXcjsxM/6wSkVh/J3HSfZnuWa
         sVSPKUgGZ3T1W0U4sUrXkrzyzC2fVKo7hhuW1vCaGXbTv3wAS/9fDYTZGvN/Wb/jQbxI
         Bfl5Mx8Ppiq7QmlpRf9ZXXj3SR1JvwuLOuDIAu7jUcX4hed0YgzUl+usa7Mgl2/eXiCK
         AkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740145; x=1774344945;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2PXxXk8VhvWKdh5qbCGPAjYxJFK0r5hKMGsfLg7vY0=;
        b=kaZyd4zJOZ+PhdrICfa+UqZae9rM7t8wtZ+iuMHP6GfZ8jyCEeO0TYZx+EJewztWCE
         z8eh+04POc8pZDRU06D0XBGygFLSzcQqGI8YaMNP887VxJ/Y19780ii407EPFp9aZaer
         uUflu9dqiEDaf0Vj1u2YGy24fwtu4EZX5Vc08gipK2kSeNxBq0t2b6C9AH8C07UWRvNX
         u0TLwqZeCEfqabp4Dv4wzuz84SM0Fq3C/UyuHLbkeJCFp+5NOM05B5AQhDQjd9WnO1Yd
         kFPlyihIvzXlWBXTye2P0lSfvifZoZ8YkQRQoHguBY21dtR/YqP+aJ2iJppnJ93UKBU4
         9Q+A==
X-Gm-Message-State: AOJu0Yw5ElD0zy9lxJUuwb8Y+s7SvOBAvYP7aNl2KzKeACMUK3P1qI5w
	iaAl4p/8hILQOr9iPeVEevLsOvmnCIuSTUjMzoVYjwP1kRruOVo2X7ALNtOaqw==
X-Gm-Gg: ATEYQzw9RXlBlhUCeWug2EeMCVJPQD/pojOEldhDZ+G6Aoo6TZFqK3M5Ep2xcrjQSBG
	C9x9vbIqPKLaRGm6sumWPfU0/d8NUk7uh9KnAGSihzcnpwXJXpvAXUE2U7jCT0gtXtkuytFitfm
	GNvo6YeBGCP/6nEuVauaG5mI3QvRaSdhV1cdZ29QoureEjVj40E6c7ZME9eCtew47vlZTe6xOs1
	vQE4JpLQ2IvJQaLP/vVMfGY85LAiXy/elP083cS8dseurpcy7+9a1TSe9vK1FfkVHZLm82s2nLN
	mdZvsVcatn8taDo6//qDQvx4Fg/xTKqJbWIJ4XAyL4PtTdCX2EHfiqTWY9R4EuyyLFmPGlSjtVc
	JT8uQYmilruwLyP28lwZ5UQZ4n5wpuyBGSkxuFwnKfQ/Y5TrFNGaKllDvs23fyex95OX4Yk40is
	HK3lVHUrDIXnq5/+o110PfOAo=
X-Received: by 2002:a17:90b:3f0d:b0:356:9405:759d with SMTP id 98e67ed59e1d1-35a21e4ee18mr14104282a91.9.1773740144803;
        Tue, 17 Mar 2026 02:35:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.3.221.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada5c76csm2285363a91.6.2026.03.17.02.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:35:44 -0700 (PDT)
Message-Id: <80a98116fc6dc948419d731b07f5287f303c4213.1773740139.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
References: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
	<pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 09:35:38 +0000
Subject: [PATCH v6 3/4] sequencer: teach autostash apply to take optional
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add label1, label2, and label_ancestor parameters to the autostash
apply machinery so callers can pass custom conflict marker labels
through to "git stash apply --ours-label/--theirs-label/--base-label".
Introduce apply_autostash_ref_with_labels() for callers that want
to pass labels.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 34 +++++++++++++++++++++++++++-------
 sequencer.h |  3 +++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index eebefd731b..080a25820a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4704,7 +4704,9 @@ void create_autostash_ref_silent(struct repository *r, const char *refname)
 	create_autostash_internal(r, NULL, refname, 1);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4715,6 +4717,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		child.no_stderr = 1;
 		strvec_push(&child.args, "stash");
 		strvec_push(&child.args, "apply");
+		if (label1)
+			strvec_pushf(&child.args, "--ours-label=%s", label1);
+		if (label2)
+			strvec_pushf(&child.args, "--theirs-label=%s", label2);
+		if (label_ancestor)
+			strvec_pushf(&child.args, "--base-label=%s", label_ancestor);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
@@ -4759,7 +4767,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	}
 	strbuf_trim(&stash_oid);
 
-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
+				      NULL, NULL, NULL);
 
 	unlink(path);
 	strbuf_release(&stash_oid);
@@ -4778,11 +4787,13 @@ int apply_autostash(const char *path)
 
 int apply_autostash_oid(const char *stash_oid)
 {
-	return apply_save_autostash_oid(stash_oid, 1);
+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
 }
 
 static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply)
+				    int attempt_apply,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
@@ -4798,7 +4809,8 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 		return error(_("autostash reference is a symref"));
 
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
+				       label1, label2, label_ancestor);
 
 	refs_delete_ref(get_main_ref_store(r), "", refname,
 			&stash_oid, REF_NO_DEREF);
@@ -4808,12 +4820,20 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 
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
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
+{
+	return apply_save_autostash_ref(r, refname, 1,
+					label1, label2, label_ancestor);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 0b09d6799b..68b94d86e3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -233,6 +233,9 @@ int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
 int apply_autostash_ref(struct repository *r, const char *refname);
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
gitgitgadget

