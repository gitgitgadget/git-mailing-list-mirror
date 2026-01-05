Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BA31197A
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649743; cv=none; b=aMUpXLjh56b8fQzyyGdIz1rNKanCGMyzpEFjLQe50G5W0rdorO3LNZ8sCqjJSaIypUuvBuiE9rwIRNaTlqRugfw71QkB4dKG3Jd+BCrO4f67HTtV7I57V6k4HesK+F0ttw/l/d1Y5ODrryKlSfxGhu+j/8J9f3SkXRaztWVyraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649743; c=relaxed/simple;
	bh=+0/UZu0tgZK/TOTIRRsN9QiIgJoKOjblOxJbMVfSofQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCW79axNKZL7jL/255585MczbeQu6wOZdeVJJg1BjLky2AwN+zTRbbAMVUcAFjGGlX6hPsbzzUykvp539dF7qlctwjtMWacM8vkxIeAWjawRGZJuM9vraAIavHaxD2ExgOTz5VtUlb1tKTORnR5Uxr+Pdh9uJFogXIJumD6eBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+r8HmY6; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+r8HmY6"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-644715aad1aso573486d50.0
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649740; x=1768254540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puxukEY5xXhLVo19+cbBr81LnBos7Qc4kcq0GtWiweI=;
        b=Q+r8HmY6/FRYTDs1JSDs9sXfunke12uklZTqKzkaGK2IAuYZ+wxbLXOxSVAXWrOR+r
         K0zrr2FtdSEOZ07XY09xcNxNzBvk54UAVuePBSy5JO8a6MIRMYoHpTCOL+9dnBYHjAWJ
         AJfAYNp6I/pbVTykAVOSi/6pqaDvZf7zByo7YcA64rOYGKrGu5E4448xJL7OJO6yf25n
         GR9MXSGP5N/mGIULgAuWBEhZi2vQjDrHjP+m6PPCNC+2yCjiy78bn0hH3Mp6hJQ55v3y
         WaTGqUScOO90YA1/pMvBsfrl9W/Vvog+7B1BQj9kzhYOPEK9aS2UVwjk1U/dPAxHn98x
         S50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649740; x=1768254540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puxukEY5xXhLVo19+cbBr81LnBos7Qc4kcq0GtWiweI=;
        b=OowA/RDbbN5FNWamVWn9u0abShgqXLaRDFSYUEUllM6jHISWeVZnHnwlSvz+6L5FAo
         NFpKbzmvvN42d70yKGyI+/ZX5KAymPoL8/Xr8idatQQmjdeR+/tfdZaKhjOhsQG2e+rz
         5766tnYHZ6wzk56mCDVRqkKdtLSFE70usQllmYQU8YikYYzLdI/u8tGAquiAjewV7R1Q
         igPgPVE9e0+xfJnGgSRAHSgVnSOKba/HcHb1k5cn5G4P1oWEGdrOBMPMOtyr/p/SuuuV
         kShZTkzJELBRjRg15t+K8dhsRZwRJK9445/qobmkdsmeGxbqA5NF/VQWeryjbzBSVlGN
         GXFg==
X-Gm-Message-State: AOJu0YwwdrQNfmZD5bJiBB0YfltqkhtwBQeElLV0cpaAtczpBTn5ud88
	fclgyuhl88yzlyPXikW0eR3o1hobhoS/VhMDe0lysTkQayqYK73ung39oaScOA==
X-Gm-Gg: AY/fxX7EA1zFpJxw7XuaUnITnq0GWvT1K83F0etR7tu6f7wDKTdAd0TfotbnlMFpp82
	QWGqRVMtaT1gyAlAWsx9mZSyu/Or+uixEigtmEInpGyA7Fj+PUCWwNjEA61ivrloBQsiLsX5yMg
	ydfUbFlgJjJR0wXHZIShY5uZTO6BCgsdWyBElLSCc8st4pMf6q1Q53SQKGVUrIa6yqtIfFdGYzA
	ecDTgWtlMojf8+oMiZSKxbZZk8ND2O/v35IDXqifSghZGbUiczuKGRG7GDMOYpP8307vKttgxj6
	Kwn/7mFicfLs7QhPdjU3ZtSgncOf5PebVeAegrzYHg1/Dv/QIk30lxoN+gB5TYLvXpBNFcClrLg
	2EV3SYyETq+PfUsLatpoSdg+VRCQprMlZ1lKKzFeSnwIvpuYunIybTY3+1rXBhvBl/5p4ATwprz
	075XuVL7xx9cZEG88=
X-Google-Smtp-Source: AGHT+IH/n2obIgkhttpG1UVo1TEXdFjfI9KPBoBH1S95rvbcKY4l2RMHaQUv2F46130v2WBLiFWBQg==
X-Received: by 2002:a53:d005:0:b0:645:5297:3e5d with SMTP id 956f58d0204a3-6470d31648fmr420248d50.46.1767649740251;
        Mon, 05 Jan 2026 13:49:00 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa679385sm706737b3.32.2026.01.05.13.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:48:59 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 3/4] doc: git-reset: clarify `git reset [mode]`
Date: Mon,  5 Jan 2026 16:48:17 -0500
Message-ID: <0ca9fcf943653013ec2e4c6e1b3d625ea37adc26.1767649692.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.426.g1df11fb20d.dirty
In-Reply-To: <cover.1767649692.git.ben.knoble+github@gmail.com>
References: <cover.1767307382.git.ben.knoble+github@gmail.com> <cover.1767649692.git.ben.knoble+github@gmail.com>
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
 Documentation/git-reset.adoc | 50 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 91dc6e6278..37c868ae24 100644
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
+	Leave your working directory unchanged.
+	Update the index to match the new `HEAD`, so nothing will be staged.
 +
-If `-N` is specified, removed paths are marked as intent-to-add (see
+If `-N` is specified, mark removed paths as intent-to-add (see
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
+	Overwrite all files and directories with the version from _<commit>_,
+	and may overwrite untracked files. Tracked files not in _<commit>_ are
+	removed so that the working tree matches _<commit>_.
+	Update the index to match the new `HEAD`, so nothing will be staged.
 
 `--merge`::
-	Resets the index and updates the files in the working tree that are
-	different between _<commit>_ and `HEAD`, but keeps those which are
+	Reset the index and update the files in the working tree that are
+	different between _<commit>_ and `HEAD`, but keep those which are
 	different between the index and working tree (i.e. which have changes
 	which have not been added).
+	Mainly exists to reset unmerged index entries, like those left behind by
+	`git am -3` or `git switch -m` in certain situations.
 	If a file that is different between _<commit>_ and the index has
 	unstaged changes, reset is aborted.
-+
-In other words, `--merge` does something like a `git read-tree -u -m <commit>`,
-but carries forward unmerged index entries.
 
 `--keep`::
 	Resets index entries and updates files in the working tree that are
-- 
2.52.0.rc0.426.g1df11fb20d.dirty

