Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0F15746F
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208129; cv=none; b=IfrXX7T/AQRZ7OnvCC+2sOUt4qoHcOdP+l937ikMrUeb6y/CmSC4jTt87p6mAdtK1EgZ3PXUFcuxWDQILHg6tQWrEsAIBnQa1lP1fq6uZHRPutWWqUmt7U0Fne3THRQzQMf5SPzObtTwjOpo3SV+T2cgmVptaB/6qeLehIbiSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208129; c=relaxed/simple;
	bh=PU72FknR1j4DtEcVv7t/XQauPcol9nWmVQV1wo0gTvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOtxNJI4QyVGkiJMpqUaucvGHdSwvWPaA8Kmz2l4r6CgreSGzyEopHX3+3RnzuPCRHIYd4ZhKx047CWhB/EHXDpXZgav3ObHy8kvvxONFB4rQ2Co+wyzXwWV/gwHNEKC7RsxHUpTM5hWqMteKo/dF5nHNLhewjdLRcgyhZm6RjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6poUTRQ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6poUTRQ"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-615950642d9so3274227eaf.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753208126; x=1753812926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed1xXVj0ictf0p1DNx/2JnmgW5aA4CduAQFcdLN7hZQ=;
        b=H6poUTRQxL+gkY986ct2c1VRZHdhBFEM+5SDq5IM1qIPCgIcX2HINJfKhbdRI7QR1J
         +Uw2qpQh96BJRGh9fXTDlw1Bv+MbvnqWkwN0vSV6g0rRXdFjQyZe+wyLsluDtiingvS3
         ReXjIbXglS7ngeShoZ/Hhw1XEiwt43hyDXNkhL36aJ6G47GbxFf/4bGSMFhv8b9JR4Wu
         0rUv2fOjUJ7C6PHaOzQf2ke8BEiItSGjJSMnDJhYQ7IlmElVKzx3iaL0i1zqPz+y01Q+
         kg9/uSeC1YOkA31kJrvCYFO2Ie80B1AEBpFFlzXeWkaF5U+860AN70G1Swdg8I5FGjJF
         05YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208126; x=1753812926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed1xXVj0ictf0p1DNx/2JnmgW5aA4CduAQFcdLN7hZQ=;
        b=IVQFtFaL4YH6ZMfZHI6FhiXKIciDWWurjm1itRSB81mXRFh7ZIoRcFdURDYS5ggCC5
         Yj4hd4Wgkr/4NzQEymZV2FGpet6Y5WHa8xhq/JX6LGBn8l3jCLyp77FWcbfFKq5vE2Yt
         O9QLIHKQ42NxaN3DmmYKVy8yd0dK0tQQv5twQNoS6ce0pjL2RoVlpCq8vCuXesxQirJ/
         mJYaxavj9IAP7rb9Iyw0XKGEcYJ9vQyAzzznaZSd4TkJDbJ5Yxs+O4qLG76Vm/o4xO0w
         uW6TaBgyvKGoeVKqLG74MaqzcGcc4UWuyq1VRCOB4YUmOpiDeuSg3vzblaFMUDLUoGtq
         6sYQ==
X-Gm-Message-State: AOJu0YxqaRgZOzcprfi4KzVqWxRHsjhgc8nfNoN7zcts9ZgsuVgWYBQG
	ZhA8sak462mbvwThByp7nGexHd4hUZqs+afrfXZ0DqyYaDzkzdrG1krzVZXV8w==
X-Gm-Gg: ASbGncvn46+Qp5j+BCUo9RzrU+lSj8TPCdTBjsBMC0A+/Ve9VWhd+MgevLCgSkgaJZ7
	/KPxBxzCYOeiuJuu+oh2IZO6q5BnzndRkhkvGkamyKWaINrV/mk5qax8A3f3G2nclg24QrN9CvK
	yVw87oTu7sWCJJLWYqVpVjxkE0TSrCMFVF/EXVN4dLeELHop+AYPDhY1/2bk9ZThIHZJ/U4WUQW
	YRrxPomHGXhoPTN2Hi57/aT5in9HhKtDiYIeVfOiMizetvwWfMLD4y7e7kPp0cf0rGd4Sr6ccnC
	iiD4vA5hskXZKWVb3IXQ3DvKZ2aYwS3L9Zwm76YVWeNorZqkjMRMvfNJnvpPEdaQLYbnAhy06xM
	7JibWvlY17ksxLqQpj4CKoVpQmvZqrQ==
X-Google-Smtp-Source: AGHT+IF4+spzsjW0Gb4TtH1OaZy7dQ9/RDwtefX99kMoxoTa5bqDduA3ZQQZ9XpfMlPYKpjXOseDGA==
X-Received: by 2002:a05:6808:1b2c:b0:408:fef8:9c9e with SMTP id 5614622812f47-426c5f4e9famr258807b6e.22.1753208126132;
        Tue, 22 Jul 2025 11:15:26 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd498c218sm2914153b6e.29.2025.07.22.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:15:25 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/2] builtin: remove merge short flag for switch and restore
Date: Tue, 22 Jul 2025 13:08:17 -0500
Message-ID: <20250722180818.1043014-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.50.1.214.ga30f80fde9
In-Reply-To: <20250722180818.1043014-1-jltobler@gmail.com>
References: <20250722180818.1043014-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both git-switch(1) and git-restore(1) inherit some common options from
git-checkout(1). One such option is the `--merge` flag and its
accompanying short flag `-m`.

In previous discussion[1] around removing the experimental marker for
git-switch(1), it has been suggested that this short flag could instead
be used for an option similar to `--move` from git-branch(1). Such a
feature is not yet implemented for this command, but reserving a short
flag for an uncommon option is unnecessary and hinders potential future
extension.

While these commands are still marked as experimental, remove the `-m`
flag from both git-switch(1) and git-restore(1) and update the
documentation accordingly. The `--conflict` flag is also now defined
explicitly for each command as to remain alongside its related `--merge`
companion.

[1]: https://lore.kernel.org/git/877dkdwgfe.fsf@evledraar.gmail.com/

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-restore.adoc |  1 -
 Documentation/git-switch.adoc  |  1 -
 builtin/checkout.c             | 24 ++++++++++++++++--------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-restore.adoc b/Documentation/git-restore.adoc
index 877b7772e66..96de9bb5ed7 100644
--- a/Documentation/git-restore.adoc
+++ b/Documentation/git-restore.adoc
@@ -82,7 +82,6 @@ Note that during `git rebase` and `git pull --rebase`, `ours` and
 `theirs` may appear swapped. See the explanation of the same options
 in linkgit:git-checkout[1] for details.
 
-`-m`::
 `--merge`::
 	When restoring files on the working tree from the index,
 	recreate the conflicted merge in the unmerged paths.
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 9f62abf9e2b..7b24450f841 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -123,7 +123,6 @@ variable.
 	submodule content is also restored to match the switching
 	target. This is used to throw away local changes.
 
-`-m`::
 `--merge`::
 	If you have local modifications to one or more files that are
 	different between the current branch and the branch to which
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0a90b86a729..0d5b182166e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1689,13 +1689,9 @@ static struct option *add_common_options(struct checkout_opts *opts,
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
 		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+			       "checkout", "control recursive updating of submodules",
+			       PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
-		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
-		OPT_CALLBACK(0, "conflict", opts, N_("style"),
-			     N_("conflict style (merge, diff3, or zdiff3)"),
-			     parse_opt_conflict),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
@@ -1976,6 +1972,10 @@ int cmd_checkout(int argc,
 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
 			 N_("second guess 'git checkout <no-such-branch>' (default)")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
+		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
+		OPT_CALLBACK(0, "conflict", &opts, N_("style"),
+			     N_("conflict style (merge, diff3, or zdiff3)"),
+			     parse_opt_conflict),
 		OPT_END()
 	};
 
@@ -2026,6 +2026,10 @@ int cmd_switch(int argc,
 			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
 			 N_("throw away local modifications")),
+		OPT_BOOL(0, "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
+		OPT_CALLBACK(0, "conflict", &opts, N_("style"),
+			     N_("conflict style (merge, diff3, or zdiff3)"),
+			     parse_opt_conflict),
 		OPT_END()
 	};
 
@@ -2060,12 +2064,16 @@ int cmd_restore(int argc,
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
 			   N_("which tree-ish to checkout from")),
 		OPT_BOOL('S', "staged", &opts.checkout_index,
-			   N_("restore the index")),
+			 N_("restore the index")),
 		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
-			   N_("restore the working tree (default)")),
+			 N_("restore the working tree (default)")),
 		OPT_BOOL(0, "ignore-unmerged", &opts.ignore_unmerged,
 			 N_("ignore unmerged entries")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
+		OPT_BOOL(0, "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
+		OPT_CALLBACK(0, "conflict", &opts, N_("style"),
+			     N_("conflict style (merge, diff3, or zdiff3)"),
+			     parse_opt_conflict),
 		OPT_END()
 	};
 
-- 
2.50.1.214.ga30f80fde9

