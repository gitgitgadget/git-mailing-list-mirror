Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C318785D
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460709; cv=none; b=XgEYQ/onFufUjmD8n2JT9beNhdYeNxmeeyA7tXej7Qnfc1vXWDVy+3ltoKyRzn7OVFhklBXF43iuY0AHJTxVpz858BsPRyO8GR2PUtExuk6xT+GOkI/Pqt15nKFXT0CVAjgSpn/vsyoyDy6GX1BHLc/NaX+3HL4acrIVFOLA0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460709; c=relaxed/simple;
	bh=gxIAHGM5qqPeR6HQ9auAtcfyzuz2bxbRGIGYEeLLOzo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=sc+PHOWHgJ5ZatIb7PtV/W8QY7a3Y3Hgw6YwJoqAtmWpnddnEpXgpYR2iRmrTYzC2NUFmOXvn2ZcJrdLm22rFRpvR7WwUdnWwGmWP9XSOI2qz4Iknnut+Y0C7wUIdg9exLlicCRpmb/pvdmjSjQsrSvKSqKvdSCo2+LWqDSu37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLBEcx97; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLBEcx97"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso94135231fa.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728460705; x=1729065505; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeS2pvSlRuc7GfnujIl/tRD2Qzg5WU4sxuY0Rb3pfiU=;
        b=SLBEcx97gOcPRGjgNnQpzMwZe9l29Ht25z/0q9ZCVzwuNYEj99gRkiyz/zQIAIcRmN
         7glhGuHjSPvhYpwPtdfEB9ho5ZPRLE4C4RSS/kTj1trRC3itX5oHB9dq2pVIYDCqfLYD
         Vmg70aSyjkRpBFtW5fmmDgxC5o3t4A4V0Ekh/TgAbMgPUkEt1jUuOVdSbNcbkWWDDw/P
         lg358fn7nwJ8KhdeNHeSDqCHhXW6bhGDKs0d5uyWq2qYbU84AOW/JdtOQrpOdmQu0bmq
         bcCBXZrf0afM6nCq5ymWilv6kON8U8QbQuZe0ra9cfZnF9WkAUiaFyhWqPiC1g7Gvklz
         QOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460705; x=1729065505;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeS2pvSlRuc7GfnujIl/tRD2Qzg5WU4sxuY0Rb3pfiU=;
        b=rGqVAyTLy2oRGvX3W1MY0tGbMLBGlTtiIAMMKEDmBNSuO+m56b549crnKD1uwjfPn1
         0p0RDMZAGifjYvjCXSaxW94PC31J+Hg/QSFfWn7clPVoyGS+hiUZDcDmQ0+brx0gnfLY
         fPI4R3f4oY5gj0PRbeY2BdVtrWtzz6DD3Szxa78pcQYvov8C7oC1Gtp8eneY/K+NuutI
         /V5fH4qXOSzAsufznM2/I7iQYoeyjdprC7+zY2e0aDUVwFeXOmxWgyzzksH1eGC2hb+3
         03bqZh7En2CtZUW8JZw0HyjvXq4sBFsJXevJkEfLmpHjT5UK1IxuD3cHwcDPndw1lLi1
         zvwg==
X-Gm-Message-State: AOJu0YzIoxZtl7C1kz3tRWpi63skxO/2wB17jl7rGj80fSFFICUv7Wbp
	IciT3sU7wW6yhkq107qAVBsV6bNTGev+hoGz/hcl67TF0KlRgLJMu29kHQ==
X-Google-Smtp-Source: AGHT+IEEBX/CpgPELfFoyfy8U4XJNEc78MFZbQteuBZjyK1qUxdsWR+PP/6vdlnYzZcmxo20KK5akg==
X-Received: by 2002:a05:6512:4028:b0:539:8d2c:c01a with SMTP id 2adb3069b0e04-539c48e2bc9mr1228731e87.29.1728460704487;
        Wed, 09 Oct 2024 00:58:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9944839974sm500996466b.218.2024.10.09.00.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:58:24 -0700 (PDT)
Message-Id: <19d8253da07624aa14ec78d00b549bba8799c55c.1728460700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
References: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
	<pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Oct 2024 07:58:20 +0000
Subject: [PATCH v3 3/3] rebase-merges: try and use branch names as labels
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Nicolas Guichard <nicolas@guichard.eu>,
    Nicolas Guichard <nicolas@guichard.eu>

From: Nicolas Guichard <nicolas@guichard.eu>

When interactively rebasing merge commits, the commit message is parsed to
extract a probably meaningful label name. For instance if the merge commit
is “Merge branch 'feature0'”, then the rebase script will have thes lines:
```
label feature0

merge -C $sha feature0 # “Merge branch 'feature0'
```

This heuristic fails in the case of octopus merges or when the merge commit
message is actually unrelated to the parent commits.

An example that combines both is:
```
*---.   967bfa4 (HEAD -> integration) Integration
|\ \ \
| | | * 2135be1 (feature2, feat2) Feature 2
| |_|/
|/| |
| | * c88b01a Feature 1
| |/
|/|
| * 75f3139 (feat0) Feature 0
|/
* 25c86d0 (main) Initial commit
```
yields the labels Integration, Integration-2 and Integration-3.

Fix this by using a branch name for each merge commit's parent that is the
tip of at least one branch, and falling back to a label derived from the
merge commit message otherwise.
In the example above, the labels become feat0, Integration and feature2.

Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
---
 sequencer.c                   | 25 +++++++++++++++++--------
 t/t3404-rebase-interactive.sh |  4 ++--
 t/t3430-rebase-merges.sh      | 12 ++++++------
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 97959036b50..353d804999b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5819,7 +5819,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
 	int skipped_commit = 0;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
-	struct strbuf label = STRBUF_INIT;
+	struct strbuf label_from_message = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
 	struct commit_list *tips = NULL, **tips_tail = &tips;
 	struct commit *commit;
@@ -5842,6 +5842,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	oidmap_init(&state.commit2label, 0);
 	hashmap_init(&state.labels, labels_cmp, NULL, 0);
 	strbuf_init(&state.buf, 32);
+	load_branch_decorations();
 
 	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
 		struct labels_entry *onto_label_entry;
@@ -5902,18 +5903,18 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			continue;
 		}
 
-		/* Create a label */
-		strbuf_reset(&label);
+		/* Create a label from the commit message */
+		strbuf_reset(&label_from_message);
 		if (skip_prefix(oneline.buf, "Merge ", &p1) &&
 		    (p1 = strchr(p1, '\'')) &&
 		    (p2 = strchr(++p1, '\'')))
-			strbuf_add(&label, p1, p2 - p1);
+			strbuf_add(&label_from_message, p1, p2 - p1);
 		else if (skip_prefix(oneline.buf, "Merge pull request ",
 				     &p1) &&
 			 (p1 = strstr(p1, " from ")))
-			strbuf_addstr(&label, p1 + strlen(" from "));
+			strbuf_addstr(&label_from_message, p1 + strlen(" from "));
 		else
-			strbuf_addbuf(&label, &oneline);
+			strbuf_addbuf(&label_from_message, &oneline);
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s -C %s",
@@ -5921,6 +5922,14 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 		/* label the tips of merged branches */
 		for (; to_merge; to_merge = to_merge->next) {
+			const char *label = label_from_message.buf;
+			const struct name_decoration *decoration =
+				get_name_decoration(&to_merge->item->object);
+
+			if (decoration)
+				skip_prefix(decoration->name, "refs/heads/",
+					    &label);
+
 			oid = &to_merge->item->object.oid;
 			strbuf_addch(&buf, ' ');
 
@@ -5933,7 +5942,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			tips_tail = &commit_list_insert(to_merge->item,
 							tips_tail)->next;
 
-			strbuf_addstr(&buf, label_oid(oid, label.buf, &state));
+			strbuf_addstr(&buf, label_oid(oid, label, &state));
 		}
 		strbuf_addf(&buf, " # %s", oneline.buf);
 
@@ -6041,7 +6050,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	free_commit_list(commits);
 	free_commit_list(tips);
 
-	strbuf_release(&label);
+	strbuf_release(&label_from_message);
 	strbuf_release(&oneline);
 	strbuf_release(&buf);
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f171af3061d..4896a801ee2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1870,7 +1870,7 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 		pick $(git log -1 --format=%h branch2~1) F
 		pick $(git log -1 --format=%h branch2) I
 		update-ref refs/heads/branch2
-		label merge
+		label branch2
 		reset onto
 		pick $(git log -1 --format=%h refs/heads/second) J
 		update-ref refs/heads/second
@@ -1881,7 +1881,7 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 		update-ref refs/heads/third
 		pick $(git log -1 --format=%h HEAD~2) M
 		update-ref refs/heads/no-conflict-branch
-		merge -C $(git log -1 --format=%h HEAD~1) merge # merge
+		merge -C $(git log -1 --format=%h HEAD~1) branch2 # merge
 		update-ref refs/heads/merge-branch
 		EOF
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 2aa8593f77a..cb891eeb5fd 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -108,19 +108,19 @@ test_expect_success 'generate correct todo list' '
 
 	reset onto
 	pick $b B
-	label E
+	label first
 
 	reset onto
 	pick $c C
 	label branch-point
 	pick $f F
 	pick $g G
-	label H
+	label second
 
 	reset branch-point # C
 	pick $d D
-	merge -C $e E # E
-	merge -C $h H # H
+	merge -C $e first # E
+	merge -C $h second # H
 
 	EOF
 
@@ -462,11 +462,11 @@ test_expect_success 'A root commit can be a cousin, treat it that way' '
 '
 
 test_expect_success 'labels that are object IDs are rewritten' '
-	git checkout -b third B &&
+	git checkout --detach B &&
 	test_commit I &&
 	third=$(git rev-parse HEAD) &&
 	git checkout -b labels main &&
-	git merge --no-commit third &&
+	git merge --no-commit $third &&
 	test_tick &&
 	git commit -m "Merge commit '\''$third'\'' into labels" &&
 	echo noop >script-from-scratch &&
-- 
gitgitgadget
