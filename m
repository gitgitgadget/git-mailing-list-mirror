Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D131B950
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708898201; cv=none; b=nBwsokmk5NNBI58iihkRNlaOo/GJGtzszayOWo8XqUvn1+jrLIwIfxIKRBvPs/vLb4e3whRqlhH7VOMdB6LBydX6xeLn99IyzEC7vU/Eu3xnED+2akI+v6szGWkGfyOL0Tl4amhsytXju3yp2BJYEWrUK+lrWFu/6K0apFL5Aec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708898201; c=relaxed/simple;
	bh=rXSh5lCW9cMFLJlGcW9p/2rJf3+MKsNiqgac1qDlSgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/xNaNzWzRjDD2JT3NTUUPRv1LSW9N0iLqCMLjKRJ4NVeYdOTJhxXuwDzICueZGnzYlK8bCXxmOnATevghXDIl3BbALhEAtS+RcJscIOw9SrpFRkOptip+dY7n1EiwHS3Q9OjSqz5HM214prpFZdLATZXHtUQ9kr+Uk0X1Hdp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/jQYzdH; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/jQYzdH"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f74fb38a8so11094196d6.3
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 13:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708898198; x=1709502998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVeY0Yy/THv7VUdM9oGcYQ6+BZVdyZ2HrLAOspdJPA0=;
        b=O/jQYzdHvnST/xWq/KiTvUP7yVN5D8IPIUs+IhSlZFk85FMuhiLaECLIHgZN5rq6GX
         s4jtXvQmWRiAtedwbr0UowUrfiVg3jZBuHsFyPqx5IplFwov/ZpVIx8OdcjzcmwzNXHz
         lXesBtyoUiSLXjIhgyJJLW3wQhmZ4qTkdHZRGEJleOUAHVo++gllVKniIawDOYYIYY1G
         61dEhvPxpfHAho9upcG5evOTHZzOoTe/Ym4KP0gcaK7naukqjRlzrZuM0kEUwESM4kf3
         EznLjgfcjeaZghyZNmonc27PmNQJniS4v/+ZsihfwIAFA09HIhpH8P/erttl0Ps68PgT
         FBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708898198; x=1709502998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVeY0Yy/THv7VUdM9oGcYQ6+BZVdyZ2HrLAOspdJPA0=;
        b=HP3SF9ge18dzltRa941b8JpBr7Mgzmmp1Lq3VQCDVcbI6tb/1zwFq3faz+OtqMxEjY
         /P/rqKh7dCpaEl3w6jrTVFE541gCTfaE0DejVLrfkQixgFI5rP1gHsymMd0g7uzMygsV
         M+nGnqWGE4XTsgw6b6Ub6jITS+U1J+5VYCc+Z+iYOtypzkPGgs8YYeWLVwHHCkz6mlsn
         FcAYRAx0gsXoxNhIIPNCtr0XoJf5TqP3KZG+/UVoa8HvHqunX0f5uVo3HHs94/I/ZXM+
         R1bwE0VKX57l2/rpbX1OfMtRvWcdYXW2y1g7EBxgjIxYVNV+eK+ITWXZBC3uEaMIlDlj
         OwRA==
X-Gm-Message-State: AOJu0Yw8ppmiQoA0BaP1QBYJopWFVgYP3NadQubzoiTGNEUFPtBmYiFl
	mYOh/jihPrCdMGT1bCDxpUT9Fd24Lv8Yjl5ZVFihTOFeWosQwQxX
X-Google-Smtp-Source: AGHT+IHjnoHU7qPUs7TOQbPY8AecYSddqKf7hpZLsDyFtwI1XDHKSn3otGloi9Io5Es3Hdfk5DHoiA==
X-Received: by 2002:a0c:e08c:0:b0:68f:2c76:38dc with SMTP id l12-20020a0ce08c000000b0068f2c7638dcmr6544356qvk.57.1708898198478;
        Sun, 25 Feb 2024 13:56:38 -0800 (PST)
Received: from [127.0.0.1] ([2606:6d00:11:ff90:6090:e182:bd61:ebff])
        by smtp.gmail.com with ESMTPSA id qh27-20020a0562144c1b00b0068fb940bc92sm2126129qvb.144.2024.02.25.13.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 13:56:38 -0800 (PST)
From: Philippe Blain <levraiphilippeblain@gmail.com>
Date: Sun, 25 Feb 2024 16:56:17 -0500
Subject: [PATCH v5 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-2-af1ef2d9e44d@gmail.com>
References: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
In-Reply-To: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>, 
 Michael Lohmann <mial.lohmann@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Michael Lohmann <mi.al.lohmann@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.14-dev

From: Michael Lohmann <mi.al.lohmann@gmail.com>

'git log' learned in ae3e5e1ef2 (git log -p --merge [[--] paths...],
2006-07-03) to show commits touching conflicted files in the range
HEAD...MERGE_HEAD, an addition documented in d249b45547 (Document
rev-list's option --merge, 2006-08-04).

It can be useful to look at the commit history to understand what lead
to merge conflicts also for other mergy operations besides merges, like
cherry-pick, revert and rebase.

For rebases and cherry-picks, an interesting range to look at is
HEAD...{REBASE_HEAD,CHERRY_PICK_HEAD}, since even if all the commits
included in that range are not directly part of the 3-way merge,
conflicts encountered during these operations can indeed be caused by
changes introduced in preceding commits on both sides of the history.

For revert, as we are (most likely) reversing changes from a previous
commit, an appropriate range is REVERT_HEAD..HEAD, which is equivalent
to REVERT_HEAD...HEAD and to HEAD...REVERT_HEAD, if we keep HEAD and its
parents on the left side of the range.

As such, adjust the code in prepare_show_merge so it constructs the
range HEAD...$OTHER for OTHER={MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD
or REBASE_HEAD}. Note that we try these pseudorefs in order, so keep
REBASE_HEAD last since the three other operations can be performed
during a rebase. Note also that in the uncommon case where $OTHER and
HEAD do not share a common ancestor, this will show the complete
histories of both sides since their root commits, which is the same
behaviour as currently happens in that case for HEAD and MERGE_HEAD.

Adjust the documentation of this option accordingly.

Co-authored-by: Johannes Sixt <j6t@kdbg.org>
Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
[jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/rev-list-options.txt |  7 +++++--
 revision.c                         | 31 +++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2bf239ff03..9ce7a5eedc 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -341,8 +341,11 @@ See also linkgit:git-reflog[1].
 Under `--pretty=reference`, this information will not be shown at all.
 
 --merge::
-	After a failed merge, show refs that touch files having a
-	conflict and don't exist on all heads to merge.
+	Show commits touching conflicted paths in the range `HEAD...<other>`,
+	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
+	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
+	when the index has unmerged entries. This option can be used to show
+	relevant commits when resolving conflicts from a 3-way merge.
 
 --boundary::
 	Output excluded boundary commits. Boundary commits are
diff --git a/revision.c b/revision.c
index ee26988cc6..a90a6f861b 100644
--- a/revision.c
+++ b/revision.c
@@ -1961,11 +1961,31 @@ static void add_pending_commit_list(struct rev_info *revs,
 	}
 }
 
+static const char *lookup_other_head(struct object_id *oid)
+{
+	int i;
+	static const char *const other_head[] = {
+		"MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
+	};
+
+	for (i = 0; i < ARRAY_SIZE(other_head); i++)
+		if (!read_ref_full(other_head[i],
+				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				oid, NULL)) {
+			if (is_null_oid(oid))
+				die(_("%s is a symbolic ref?"), other_head[i]);
+			return other_head[i];
+		}
+
+	die(_("--merge requires one of the pseudorefs MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
+}
+
 static void prepare_show_merge(struct rev_info *revs)
 {
 	struct commit_list *bases;
 	struct commit *head, *other;
 	struct object_id oid;
+	const char *other_name;
 	const char **prune = NULL;
 	int i, prune_num = 1; /* counting terminating NULL */
 	struct index_state *istate = revs->repo->index;
@@ -1973,15 +1993,10 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (read_ref_full("MERGE_HEAD",
-			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-			&oid, NULL))
-		die("--merge without MERGE_HEAD?");
-	if (is_null_oid(&oid))
-		die(_("MERGE_HEAD is a symbolic ref?"));
-	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
+	other_name = lookup_other_head(&oid);
+	other = lookup_commit_or_die(&oid, other_name);
 	add_pending_object(revs, &head->object, "HEAD");
-	add_pending_object(revs, &other->object, "MERGE_HEAD");
+	add_pending_object(revs, &other->object, other_name);
 	bases = repo_get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);

-- 
2.39.1

