Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BE288C34
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307467; cv=none; b=tpWUvD2mFN7mU96YJND3utHu/OuyoEqbNOepQ70pojmevCMxqou19PbE19FizD5lFeSrGs7FmMqCC3HHDVVDahx8Dd+eUVNqYIEwysK/sOOpKU4/dfN5E5Qw+9r9dMZXgQQ/Xcl6xt8wwF53yCO8EPkSs4ZNGE/B+hS15gixFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307467; c=relaxed/simple;
	bh=7O6klwbuYdV87MS06TPPxr08jGVwFrbIwRMJEhX81uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rus2mDXe2J3Da2z/s9RoeusMRyrNFh/b6TT+wgZsCQh9elZJA+6JVn0axil8BChyb/GQT7u9QwAqGn/5IIemvFZKMNP0vv08XT8XL8VHc5Js+v3o+50YWeqqSO6yuc4YxklF6G+7V8Bj9pyDInJ5R/BKrMilaojsxOdN8w+67pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9H/eru9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9H/eru9"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79045634f45so27083487b3.1
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 14:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767307465; x=1767912265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irRDgpGnsqRKUl0GKqeYxPiwqF0hQnyLLdS3t0EIdbM=;
        b=b9H/eru95pE7XvZMSnkev7oYir4oo89aEbiT0E0XQhJgl38RK1oHZH6yi1Ef8AJADV
         vXdLRMINlSJpHDFtmcDaWfXf4T1q6VizNrFgqoXqWxfaID4i7/7C9eUW2L2VkMUYXc1k
         mkHAWj1t44+m5WunpSpnuKeMd6RW0uiEufs0eo1Gta5VNo+v+7w2PSelfyW0SdgX5JbT
         lc2ggC+WTrI5RGGoTx6BUQ2oAP7UzSxOELLzZrsNjcway1S+dBLe1ojCia7aG+F3+zDa
         ZoFgTaG2Igitx5H6Ft3xV/vg7pW5zI1cKmApls1g95zSovNTgkCMyHz0dmRSFQ02cw+c
         19xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767307465; x=1767912265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irRDgpGnsqRKUl0GKqeYxPiwqF0hQnyLLdS3t0EIdbM=;
        b=gDe+PDzYNgsjj4PPbpVgcf9i1Fo2L8e3A5wm6Xw9CTJGFy5bSgKr0oycOUQbONp89/
         kNt1N5pyMk/P6sz65RvayYRheDYk6i5ny3ff4v5G6aEIIun12O6es0/tX/fP6xrI/7ol
         DxdeyiZXqExpvSpcuaRBZvXEEJT+RSqYwiC/iH+BFBu9x3+/X7hZioDp6oltuXHbh0Ui
         mEHrgSCDaC52OMDXnRr0GwqYagoUYIRTvrSe/TZFcmFevFe2sr8PxZ0Bk64YuqMpRoRC
         u6+8bLspWhC5oY6rguqeNDS++RcpMxXQ33/IAHUBHk6lPEd0J7kCt1M+eX8rgFo01faO
         gLmQ==
X-Gm-Message-State: AOJu0YwSmniLHKqCjb8L16iYJkCxynwzElPdwwnRwxi+Ui6mRULCfZkI
	71AO4UBIKjhqLsKJRkYOOHPeCiZUPHGyICXKv1d0flfzA9QIYOz0Sr3YGjwDlQ==
X-Gm-Gg: AY/fxX4uuSiM52PIJTm8yQ8km9VbcOYkYvPPhEVhMWnSqsrNKrw4o2JmXuBa42qDJkT
	CmhWLcO4flt+i0kZ6ll+YEaRZukPoDDXu+HyI4EwL//Okr1WTutY70bCPDBQK16QSBgzEVtu2cA
	HrkZtIbYYoFkmaMPJKnru+xzEWOOAmfRST08zU8szvjxbWx/DWDC8AJpF+rSYcv3epyGVjz5Drl
	AaO+ESPIwGMqY/TY3fvLsz2akbQsfKgGOhJXT0V8klYdbUFke636CqjXzWXHFQ1cDG5/IoXUB5l
	2OpCyd2It96uc0XgBIAtj+/WpBasJJ1auDqi9CCIcBmO3EvjDEJqmPZL6R8LhWEPHWGSz8OlyJ2
	TxQUaAD0oJ06CvDQ5Vf3V58IaCzpfDUYBEo5EP0yWU2Fj0UzFcgiGajOxisHDYcRRPIylE/nyqj
	cjzGjFlCj0mHh+teo=
X-Google-Smtp-Source: AGHT+IGxVJmaMXIr4Cku2k1focv0VvD1b2qDfNJdfHZdVSUJv8VQG2+d0w+jIEKLcHBIqqH3o1xrrQ==
X-Received: by 2002:a05:690e:14c1:b0:63f:b082:4d5a with SMTP id 956f58d0204a3-6466a8bf6b9mr33200598d50.57.1767307464726;
        Thu, 01 Jan 2026 14:44:24 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43790dcsm150521117b3.11.2026.01.01.14.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 14:44:24 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 3/4] doc: git-reset: clarify `git reset [mode]`
Date: Thu,  1 Jan 2026 17:43:58 -0500
Message-ID: <89c87c14aabfe91489af4a7afa5246ec20776e0b.1767307382.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.426.g1df11fb20d.dirty
In-Reply-To: <cover.1767307382.git.ben.knoble+github@gmail.com>
References: <cover.1766103827.git.ben.knoble+github@gmail.com> <cover.1767307382.git.ben.knoble+github@gmail.com>
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
2.52.0.rc0.426.g1df11fb20d.dirty

