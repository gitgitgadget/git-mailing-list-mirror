Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CD2EAE5
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726943886; cv=none; b=macWd4HqoEs4/FgjZi6UWcLFuA18WxUYlXKbEawKLGaQRCLjxb9iA9lMrh54MF4zOgoCpw/CbSDeryyIgjNHaefOipCQBLF9f9M+gCSfqW/V7gR4USQVLOxundkXR7j1vnz9X3kZmhJU+ICakC9nRc/MffaEEkP+qa1xXFYxHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726943886; c=relaxed/simple;
	bh=VGacreGStp+887+1JqzNU3vkRAQ9Sa81o08n1fPxn2Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=K+H9bUgjgZyair4nCy2TwdnRv8zwOhfqQggusmZgjQcTnXxQxYpf+VV5Ap0b6faQKLgLHSq13NJ5JnhB3WxgfdzSOEU4zIHfLUvRg69/QYiY6efBQLUdCGBlVdMXKjxNDY+hC1rjpIULx5JNwh3uFxz7YtMtrvzRuTvpAMYl5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMwuRRu7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMwuRRu7"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso431722566b.1
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726943883; x=1727548683; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ml4JRejmg2SOm7mBzgk9B2si2qXttZ3P4Q4SCW4Ce4=;
        b=BMwuRRu7uZ0EdHzhnTvwBuB2avOfyWPxAqhUGqoXH3gdvRxmFxGEWG2+VN1R6BNd8u
         08Ct6wSoXLgD9P38kNHygwviulyTH/5Wkk/OzLiP98yxQ6JHCpOaPLH0YgQUbAC4Pgkl
         jrjoOmlq9gFgw0Z9fZx0mZPh1rycaTE9KDXMipOVqkoe6HKOuf8OAfbKmo4EYCMe4QOE
         +vtr8d2+aV8HYJ6v81YhH5x9MwI/mkQ3TJCz6m13nwN83zpmxcQREV8v+uKW/FkX5cbm
         2uXSDW1azsR7uk4L5PaopGYaVQdukK+/fdCT5Qvt0ia2kSLcUnJKTPbZhwYoumrCLCMJ
         uBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726943883; x=1727548683;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ml4JRejmg2SOm7mBzgk9B2si2qXttZ3P4Q4SCW4Ce4=;
        b=xMgHFFOd0NffIWEypnT/OFpDcYTlH/7U9cFPSsFoWs02jA/6RUrP1rTiSueZDQ5NOc
         ccW9Zre0LqalHUS0bRMtCz+3MZchTz7d6OEvpLDTyiZb3fEjTOff1bqXLHIignkayxD2
         2NzdVMucetQazHPa4O0uBm9bvk1rFVwKeubX0UVFA2ZfKwiaqTT+1e+J+XBPOfX23ZBh
         6BC4SE+UpRI4Blg17PLz1bH+qFlhsM13HRHixzkg+Qoj/XhTMEXRxslan6sNckNveLo8
         88SGUhQT5x6UdwLGcrV4biy1ncaxK0Iq/XZfgzs23Kly1muFsa6o2tSuPCmOJxQdKTzw
         rOag==
X-Gm-Message-State: AOJu0YwzDd9yZkRxm+Yl+hf1dYxu+LZI6quZeFlNMxBDbXZDjgAi4rhU
	V7LTG4oZdj7XYxOF1PeZQw286FxpeyNpC3Fgngmfyz/Zr5EY06m3Zp56eQ==
X-Google-Smtp-Source: AGHT+IGKt4o0yvu4pfgzlEb2G7M2AUB+4+uSkiHsU85c3OjtIh7S5Gg9+bCgixQD60MpeOyubZyWOg==
X-Received: by 2002:a17:906:d7e4:b0:a8d:4d76:a760 with SMTP id a640c23a62f3a-a90d5005e9cmr574709666b.35.1726943882778;
        Sat, 21 Sep 2024 11:38:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3878sm1001346366b.47.2024.09.21.11.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:38:02 -0700 (PDT)
Message-Id: <9afe428927d71df360929238c50284d4c59beaea.1726943880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Sep 2024 18:38:00 +0000
Subject: [PATCH 2/2] rebase-merges: try and use branch names as labels
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
Cc: Nicolas Guichard <nicolas@guichard.eu>,
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
index e5eb6f8cd76..a092bd05692 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5833,7 +5833,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
 	int skipped_commit = 0;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
-	struct strbuf label = STRBUF_INIT;
+	struct strbuf label_from_message = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
 	struct commit_list *tips = NULL, **tips_tail = &tips;
 	struct commit *commit;
@@ -5856,6 +5856,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	oidmap_init(&state.commit2label, 0);
 	hashmap_init(&state.labels, labels_cmp, NULL, 0);
 	strbuf_init(&state.buf, 32);
+	load_branch_decorations();
 
 	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
 		struct labels_entry *onto_label_entry;
@@ -5916,18 +5917,18 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
@@ -5935,6 +5936,14 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
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
 
@@ -5947,7 +5956,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			tips_tail = &commit_list_insert(to_merge->item,
 							tips_tail)->next;
 
-			strbuf_addstr(&buf, label_oid(oid, label.buf, &state));
+			strbuf_addstr(&buf, label_oid(oid, label, &state));
 		}
 		strbuf_addf(&buf, " # %s", oneline.buf);
 
@@ -6055,7 +6064,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
