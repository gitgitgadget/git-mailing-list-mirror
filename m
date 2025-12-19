Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF0290F
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103879; cv=none; b=hTcRc+b8RXRIhfuk0AV+OSyJx4dU1BGyFsM3ty2W/HPVcOkWlMtE/LIISMEyrqBbc/iS29LEcP0JWuYf+iJQaHZGtFFeCVC+Q233Ih5CR75dJD9jaOF5ThJfZ34umoj3oPs0wG73igfY8XFAgLn4fxksf98AO29KVwkeKA4Y1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103879; c=relaxed/simple;
	bh=XDnR+yO/nKl/Jfh74cP9biY4PfjY8uR5XYMwfSE6yyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppwmu2jtQB/jXcI1+01b0OHTDbKIIBdeAy3ro6V0DzjDYvwx8/hT33uFFn9G5xwtDAjLXM513QEqo8cPGFYHEHayzAZe2pCfOrhGe3FaMBwEF+n1g4KHW1qaSqydLR6ph2+5BLMsTGdePhORhZg1i2w8OkWIlzO/f5T1LqV9exA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5rBIZo7; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5rBIZo7"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64455a2a096so925286d50.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766103877; x=1766708677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4vZpiMW0RMaR0ea/TQotV2Y2+sIKZlXoW13Hf5dtbw=;
        b=S5rBIZo7C4HiE0NnBh41u+AhlcmLLoPsUSomt5OGlb3VUhDmaVro5lhDecuQUtGaPh
         zxgjqyrH9itf+wpGKlne0PvxKzqn5Rl1A4ETqKVuO9sohY5HrUbSEICQE0P+BY/Z9AAe
         kHF6Vo0hkNbUXpYal9zIyYWV4qfLBvj233cG/AU97u2y3Gjn9JfhHcPGyR8RmGE9WpXX
         h9wfqnDMcHBYxgZy/4G7dGOJ63oKmJMRiYw3GnHHzmIwXMfGuLdICMPjxnYW8SGKa2xC
         wZdDP+IYZ3bVd03k5I+plP1P2HxcQ04zj5u44B2lBN1ucqZ518wo5VEU8Z0MacJbNka/
         84Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766103877; x=1766708677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4vZpiMW0RMaR0ea/TQotV2Y2+sIKZlXoW13Hf5dtbw=;
        b=qs6Mff96mJ17mu9y14XKTKuc3SrxEbVW/D7KW/zUB2yjD/ZQCdd16c7mj0d+3ntEMY
         IrCeR9awvp6MlbS9NBliXNmoRpoNW+MMLSH5IJlOSMtVdmYg3HOoFzaADV4jMgBEUdC2
         TP2A3jJ+SWR3WZ8E9e3Shp+4N43GdDVX2tJfgK9ibJL5OZhO7PDWt5WS2gvpmqhDF1lb
         cAbyiHimDYdKCOfqIUBsV/YO6BAtZGeF8t1tmYdtdPKyHl3os0qljmDeapduQozdj+ur
         8W6dXbLpM6P5oFnpMyoC6sgptjblBb4n6CPdQWnuf35QKJRqXghIsTCiBP3QoSSYf8pi
         WR5Q==
X-Gm-Message-State: AOJu0YwnGGrpVpiUA+8W0xD60Hj8wndlW2irLKDrcp5AQ44mgfcb91MA
	5do01eqHN2no1xvlQZTQ8U4e6uSIVCV5H0TZ8nUTPxsaVuEd5GXttO+yeC0xXQ==
X-Gm-Gg: AY/fxX7R/zxPIUwWXjybPBaZDu8wPuSFR4uya9LDWoCt8XBcCNzwqgsXEQKExbMHjUT
	bvHQlV9ALPTulEKhFmpsCMwik4q3DZTFX+7ozFMBlqlCxxCcca9S47rTH+hJL5enOLlgCvK5ZAt
	lVsCF/Ir2u2tGBWXjjtTRo0iQTLrt0lXnh0+ZQ0hrLGeOYWVOAmWATbu75xXwNf+w0UfYewq7J+
	qGpVgWSJCHXZOuGZistJO+egGuZaVgp9DU1QisTxtcrteWfw33KpXQa3v4R0xNHB4l5bDHJbUD0
	09y0x7ZVayAd0sC0FGkdO3pqRt7S3Pb5Xl/Pj2DwoarTz1Au0iBYK1pv8PC99FqPeWO9iyGFDaG
	b4PKdvX6dAz944GQNQaO1HIHO9YTYh+5hBZvgwMsavLECONQS2f6Fyp/pZSyxlCfKN2iE4b54Hf
	vZ9YXbzYqe0Jk1pjk=
X-Google-Smtp-Source: AGHT+IGrrUAyS+Nuyub478s+k8rSggHqARhe+GJMcc9gpTelIQqP0NJMghWwna3fFqpQA3dmND56vg==
X-Received: by 2002:a05:690c:660c:b0:786:8331:6a02 with SMTP id 00721157ae682-78fb40e22d9mr21179707b3.69.1766103876770;
        Thu, 18 Dec 2025 16:24:36 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0dcdsm3658427b3.30.2025.12.18.16.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:24:36 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/4] doc: git-reset: clarify `git reset [mode]`
Date: Thu, 18 Dec 2025 19:23:55 -0500
Message-ID: <89c87c14aabfe91489af4a7afa5246ec20776e0b.1766103827.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.365.g9bf09b728d.dirty
In-Reply-To: <cover.1766103827.git.ben.knoble+github@gmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com> <cover.1766103827.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julia Evans <julia@jvns.ca>

From user feedback, there was some confusion about the differences
between the modes, including:

1. Sometimes it says "index" and sometimes "index file".
   Fix by replacing "index file" with "index".
2. Many comments about not being able to understand what `--merge` does.
   Fix by mentioning obscure situations, since that seems to be what
   it's for. Most folks will use `git <cmd> --abort`.
3. Issues telling the difference between --soft and --mixed, as well as
   --keep. Leave --keep alone because I couldn't understand its use case,
   but change `--soft` / `--mixed` / `--hard` as follows:

--mixed is the default, so put it first.

Describe --soft/--mixed/--hard with the following structure:

* Start by saying what happens to the files in the working directory,
  because the thing users want to avoid most is irretrievably losing
  changes to their working directory files.
* Then describe what happens to the staging area. Right now it seems to
  frame leaving the index alone as being a sort of neutral action.
  I think this is part of what's confusing users, because in Git when
  you update HEAD, Git almost always updates the index to match HEAD.
  So leaving the index unchanged while updating HEAD is actually quite
  unusual, and it deserves to be flagged.
* Finally, give an example for --soft to explain a common use case.

Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-reset.adoc | 44 ++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 71e8f52430..6de0d524c3 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -24,42 +24,46 @@ DESCRIPTION
    the staged version of the specified files.
 
 `git reset [<mode>] [<commit>]`::
-	This form resets the current branch head to _<commit>_ and
-	possibly updates the index (resetting it to the tree of _<commit>_) and
-	the working tree depending on _<mode>_. Before the operation, `ORIG_HEAD`
-	is set to the tip of the current branch. If _<mode>_ is omitted,
-	defaults to `--mixed`. The _<mode>_ must be one of the following:
+	Set the current branch head (`HEAD`) to point at _<commit>_.
+	Depending on _<mode>_, also update the working directory and/or index
+	to match the contents of _<commit>_.
+	_<commit>_ defaults to `HEAD`.
+	Before the operation, `ORIG_HEAD` is set to the tip of the current branch.
++
+The _<mode>_ must be one of the following (default `--mixed`):
 +
---
-`--soft`::
-	Does not touch the index file or the working tree at all (but
-	resets the head to _<commit>_, just like all modes do). This leaves
-	all your changed files "Changes to be committed", as `git status`
-	would put it.
 
+--
 `--mixed`::
-	Resets the index but not the working tree (i.e., the changed files
-	are preserved but not marked for commit) and reports what has not
-	been updated. This is the default action.
+	Leaves your working directory unchanged.
+	Updates the index to match the new HEAD, so nothing will be staged.
 +
 If `-N` is specified, removed paths are marked as intent-to-add (see
 linkgit:git-add[1]).
 
+`--soft`::
+	Leave your working tree files and the index unchanged.
+	For example, if you have no staged changes, you can use
+	`git reset --soft HEAD~5; git commit`
+	to combine the last 5 commits into 1 commit. This works even with
+	changes in the working tree, which are left untouched, but such usage
+	can lead to confusion.
+
 `--hard`::
-	Resets the index and working tree. Any changes to tracked files in the
-	working tree since _<commit>_ are discarded.  Any untracked files or
-	directories in the way of writing any tracked files are simply deleted.
+	Overwrites all files and directories with the version from _<commit>_,
+	and may overwrite untracked files. Tracked files not in _<commit>_ are
+	removed so that the working tree matches _<commit>_.
+	Updates the index to match the new HEAD, so nothing will be staged.
 
 `--merge`::
+	Mainly exists to reset unmerged index entries, like those left behind by
+	`git am -3` or `git switch -m` in certain situations.
 	Resets the index and updates the files in the working tree that are
 	different between _<commit>_ and `HEAD`, but keeps those which are
 	different between the index and working tree (i.e. which have changes
 	which have not been added).
 	If a file that is different between _<commit>_ and the index has
 	unstaged changes, reset is aborted.
-+
-In other words, `--merge` does something like a `git read-tree -u -m <commit>`,
-but carries forward unmerged index entries.
 
 `--keep`::
 	Resets index entries and updates files in the working tree that are
-- 
2.52.0.rc0.365.g9bf09b728d.dirty

