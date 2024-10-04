Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B41514EE
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084148; cv=none; b=SNRrXe1ldBfQJkrdhhkrYBkoo+Z3ncu+MfIx4lO2EpXEAwVNX5QosHuPLHAs5pJeYrbvoQuN+WadeLMxyfY9TWHus8KXM1Ujx28Yc5MVJLoF14SGzKIFg2rsw+8Zp2WX3nua/6s3VOBSAz4C/FCY00bhFsYcRFBPGIdZuZNDYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084148; c=relaxed/simple;
	bh=gxIAHGM5qqPeR6HQ9auAtcfyzuz2bxbRGIGYEeLLOzo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=MJir3IDGyllxmfcKLaDj94Ubjtuc2S5xVZFuk8yR7UOHEGxYcjsQULK/FlNkWFSUCKaZrDtT7yWDPhdmyqlJh8ynPQDvt7NjAcx1yNRidxJC2Ru9bQJKnKs1HzlkzeIgUvPXIqwVeo83XCbjGS+71iTIpl6P9YGLVC+Pp7wB024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdLeYPjA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdLeYPjA"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so6539444a12.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728084144; x=1728688944; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeS2pvSlRuc7GfnujIl/tRD2Qzg5WU4sxuY0Rb3pfiU=;
        b=DdLeYPjA1/qyGTMpJBscM/uDtHJ4Aq/uoiaLTq/tANK1TJpmXHvs4Ogoj1aOXfHJap
         7IBDvFM7cejPfbBtWtfakjIFCwPMkv30ek//x9mdKqGCld7kmsGvNnhcIEOJe7eA3+Sk
         DST5C4SU0oMRimPvvD1JJIvE+BWHQMoKNXxbTo8iKzd6QGjINmuhOQ7LoueUM4Q5H3UW
         qNj6CrLtIG2CPakxBRw7pKQecbycEvJA/1rHyWhUH8Ro10rl+sSKQTSoWrQNlRK1cimt
         GEInumlS/nt4ROA9prfFlBo3ye3hr/F0qApr2qa5oRozra7/eQj/Xr4u8YoJP6K0jQnQ
         +Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728084144; x=1728688944;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeS2pvSlRuc7GfnujIl/tRD2Qzg5WU4sxuY0Rb3pfiU=;
        b=uIPL/xB5pVMcgZoFAOu8/RfMq2aeTapgff1gqflP+vRGUSkcEzbkq02SGpCPCR/FQr
         RFTtBoX4wX37YgqJLDF5iRdXlgUuH3FM5n80dLsb1Y+NC/tnbeocD4gT4PDFOzajCynk
         0c26lUKNdqgJn3JflAvASNPwfNPxW4znXrKLEzVAirL7FF7xxaiDvWUrzEYvpO2RVaaZ
         jIT4nSv3A4pkocrqsAVFzLv5bmhRdadIRIpUzkkDWRSJpZyhLvoJC7VRh65C9kGCGtvG
         LBas64YcS0oemwRKRv1BLA7SAISvDjh/EyJJk+kLZ1ltmmYDljoiu5qJO4Z9i6h2fg1u
         XzHQ==
X-Gm-Message-State: AOJu0Yy/9lMGXo65V3a4RdpLna1WlbEqqgwQpdYw7+I87cN/l2NAb9PJ
	WlSm07R6zLsxKduejc1cjZcgcXOJPghT2S9x/+OZ16fHFfGjNDSNReSy7A==
X-Google-Smtp-Source: AGHT+IGqQhzTK2YJcMUNM0iZjxaW1kNKtUdoCLM6OH5kOlNxmKr5z+zuwyuz1CHCfA9aA7EmfDN2zA==
X-Received: by 2002:a17:907:360e:b0:a8d:4e69:4030 with SMTP id a640c23a62f3a-a990a0606a4mr910146166b.19.1728084144287;
        Fri, 04 Oct 2024 16:22:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e617da4sm53949566b.48.2024.10.04.16.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 16:22:23 -0700 (PDT)
Message-Id: <dfa1f0a76488e981a0d3e75b49e7fb65c071a285.1728084140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
	<pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Oct 2024 23:22:20 +0000
Subject: [PATCH v2 3/3] rebase-merges: try and use branch names as labels
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
