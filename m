Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930628469A
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741275; cv=none; b=cLMLFT5g8d4GUtm2w8iqYrWTncKHjaFC34msG09K1Vm250NPM+SKUTZeSwxoaYFdUuTNGdyc1744eTeK16LZuzVXDgE9FK/sgXzq69e9zPszmZ+KRCTYhtFgN+5ntYRh4j6XmQH2ScbdNHPaGpYY8GAIOV8YKOTAluEggeBwnxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741275; c=relaxed/simple;
	bh=8eWWKxxpLPFmK+QNTlM21yQ8eFBbgUvvDxppG5+lGh4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bOkvB539FEli2/YMB1LU2N+5/Sue9oPU9hMCC+Q1in1w95wdAJNMrydLIuJYYuBmFWv39uVJNbUfcXt25MhjRrnW3sNqe8woXFeFdi3+a4pYWvCAr2uldTPS2Xb2NYw9ZnP73y2qE6LJ+lhRzUepJStjagNwFcc9l1kEbrWySdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeJFau7o; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeJFau7o"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cfd44fa075so96113785a.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741273; x=1776346073; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP+ojuKtizSbHJeP1fJK0w8aVZ3X3PAIJUPTv5wJUE8=;
        b=EeJFau7omOBXwsRs+UD0Dg/gpwzfNQCh2q0To5fjl67lL1J5CaH311RoR8HhTcVdA6
         3IO1NuFRb7PzcxBbK6HJS6dqPG61SArZTu0OM3wbAUgjUt1dB2tYB2/UPGwbJzdndrGQ
         3aJ/NVKCoHLhomLPBBcooPVTg8fJsIsgLaxcnmuSu4nbNYNgS5daW8iZTLRlOEfAmNcn
         7+QG68YMqQTxOK/tftyzs4jgecNqY2WIbQ6SMBhh4+TTjlbx4/TAtTLui5vJUuJo38V4
         vDIuQcoZYrCtgdqzertnA1g1Y6RYKuJ4Gwhhnm3Ks6FRVeL3SazqCmxZf+Si71PXOb0/
         iBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741273; x=1776346073;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BP+ojuKtizSbHJeP1fJK0w8aVZ3X3PAIJUPTv5wJUE8=;
        b=d0ZDC8J5K1fVFwWLY6GVk5olMvAf51/V3MqaGPuS4Bp6wqWTkqAXO1eVgbV06hdnT6
         PnI2zlD66Ygq+Nms8tKlCOg+RryVSZL8+/B54XeTDDBa9Y5FSFtizieAw+vz8tR7Nsku
         BeVKhUNnbFvQxcANgrKBvulVu12SaMEEk3MtlCDDr5cvc39WRJO8t4WP6gYab5RyUcp5
         0cwFcfGIgb/NcwjbmoQtgS3eIC7596uvMIK09juCK/CcxKvzhZsVE+tS/8AEssSgn6un
         N4K7USXQAu0Tq6ypy4nFzG9xtuBX+FuxhOmoIsu5FHjTRZwms6JPZJvvuzBSy0CPAT3d
         XyCw==
X-Gm-Message-State: AOJu0YxcI3YcVk3c5lXlPaKpBSm8tgDOlzPzbZ3wgO9wUYZKnLnQt/vJ
	vCyjHhk9iQyqGZAw5JX85Zlq04PBHYMHt/coLtbaBiUNX60k78MndePhjf54ZQ==
X-Gm-Gg: AeBDieviFeJWFXiSvLVxT+hypjikJmEvMc256wy9rmFeH/D+BR91G9j/auKyu8+dPvy
	1lUgodv1PJKPxVHWb4fCEnTjWqU8GYNAyzG9qeuaMZHyA7hzjbeoo1su3/Gg8Oe9YOdBtr41cID
	hKbvNZ8wb0BBJyZeA0EVprE+FcB4etLJ6ciUNhp5P2fK0NmoS+p2+sCVBNYehsxuBaTTIDQymkq
	fcBxEE8Lpj1mM92x0K8pVxRgXV27uIX+DRoYKJiHz1CscZhlmCz7DxqQOrq4xE+jbcwYlILb9/i
	o9EnMAbYOP6DKLTl76OEG1wdTD71Ff28U2VMxZKbx0r21u+BhYDFAmmKJa/AuV54bLR6P1eh1XW
	1xVww0FB+2AsLjCk4H+u7QgaIsh5/k9kEpo5iBlT25FqZF0on8qzouGC1CvAQ5pf188q8CKJCCX
	4RFsp2arYwvJyciARqlL6LR0zt2dw=
X-Received: by 2002:a05:620a:710b:b0:8cd:b70b:fd00 with SMTP id af79cd13be357-8d41c3b5d36mr3401249885a.16.1775741272778;
        Thu, 09 Apr 2026 06:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5d5a096sm1784950385a.19.2026.04.09.06.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:27:52 -0700 (PDT)
Message-Id: <c0d6b4b4c0a53af2fd76d23e04c540418ddd086d.1775741265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
References: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
	<pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 13:27:44 +0000
Subject: [PATCH v7 3/4] sequencer: teach autostash apply to take optional
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
    Harald Nordgren <haraldnordgren@gmail.com>,
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
index e500a94a59..79dceab579 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4729,7 +4729,9 @@ void create_autostash_ref_silent(struct repository *r, const char *refname)
 	create_autostash_internal(r, NULL, refname, 1);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4740,6 +4742,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
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
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
@@ -4823,7 +4834,8 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 		return error(_("autostash reference is a symref"));
 
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
+				       label1, label2, label_ancestor);
 
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
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
+{
+	return apply_save_autostash_ref(r, refname, 1,
+					label1, label2, label_ancestor);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 570f804457..1aefd25646 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -236,6 +236,9 @@ int save_autostash_ref(struct repository *r, const char *refname);
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

