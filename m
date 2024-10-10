Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE81C9EA4
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573167; cv=none; b=AKJ24u3tZ1PuK+ixgfn5d+0dCy7mIa9yO8MB5yUVaVCTZ+6woCvRe4bGW9qx77zp3ZJGxjHt3Pr8DyvYWMtmYOmfKUSs1W9ZWEID8OI3rmJHJPG+qzF/2zYeTIvQ4KmpevXOYr3RQC5BtAi5agZblRLAEwQH18bmkg07Gvl8Mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573167; c=relaxed/simple;
	bh=y4OwVd7K49R1aaQTziG9G2MLVVXft1Q4WtFRiuVFLaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqMZ0+Brkh0TGUjsWm1zB+iAA99F8SRmOFd10J77MoDJR/Hu5V8iDosDBE/bKBe3ullLpNv4/MEZ/FpwEWbDiPjhTNUbulPVR4i177j2BP5HHJ8PRV4WwN0RJDOrxrGdY2lxnQ3Cb9APtt2G1v0KgWDMMsymu1O07Mkz6HOc6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJQQYtul; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJQQYtul"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a993f6916daso179869466b.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728573164; x=1729177964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiVjJjT8NQzB05dJllFpN5qyrmRUojvZlUK8C7LwAWM=;
        b=IJQQYtulEM+/JjaAwbqIEuCNjKLHI5EEfwCsQwLaF6k0d+JrHrg7zypj9IIJCruWao
         Zt5jk06jKWpHqMogW0/oAivkElgnuHR1xznKhSh6DjDErVvjPItEiE7BxdlF/TRGteW6
         SzjUTl8nuQ0MBdO9YpcUCkXbkzbXu/0dNyMgoDtmhU+SoUGxQD5qv0ufEsjB6mqgXD7M
         i5zp/HtRcw9brQSuPA8gvqtAFdiEOFwBwvJFlp2WkUwKr5lY899iNjpmm6kZsd7+0XPt
         CVfsoK9MqJxybroxKgk+TKF3xhJRbSWn2xlT34GwrgQs/YC0t9szx5GsSJwwYDgGCiPQ
         hl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573164; x=1729177964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiVjJjT8NQzB05dJllFpN5qyrmRUojvZlUK8C7LwAWM=;
        b=fGSNd1xEpoKWfzBXL/x+bFl6q8FooSm7f1gzXy48xU+yExsTTgXAsKn/bif7WnfM4V
         6WHeXa0qa2L+P9SVLzpZJzsUKhO0VZUa3rTYTGx3qBjqk1sLzwixvPLiP5qXmnO/48Q0
         Ro/lLlhaodlt1EK8gLWeq+tw30FQ3nokYPpiVTvPQgON8gVM+0Ldhm3pVl4TPYIDY8v7
         JkKkv+M9MesPZjV8m+Uqyn+naxt/2bX/xE260v2KbiEqo4Kj3VI9xUcgeOfTCVQ14le1
         nUONVjQk1WeX3b7iRObW4pyK5qdd/E3AKgmqsITvGHF6PSqwG1dY2LPIWm1lHmwbLGDU
         dTaw==
X-Gm-Message-State: AOJu0YzHdzaeVgbfn9uk7CeuOnowlWKgFQuGn7Bx8Mqq5yNmvNxM/Nm1
	WTU7AJ9tTGG2VFpfRlI2mDFkj0BXPEwUL3GMdZ4XP9GTWTaDnpmtIuhRMlRSOBY=
X-Google-Smtp-Source: AGHT+IE1xgsG2kfHK3qiLdfQMeDm2JTkyDEyIEGXqOsIvMv3cNwumuzBKpQQrXl1kJCpQ+Xr/hNJEQ==
X-Received: by 2002:a17:907:7e95:b0:a99:4aa7:4d77 with SMTP id a640c23a62f3a-a998d120733mr431346466b.3.1728573163640;
        Thu, 10 Oct 2024 08:12:43 -0700 (PDT)
Received: from ip-172-26-2-149.eu-west-1.compute.internal ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ef8c1sm100840266b.195.2024.10.10.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:12:43 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2 2/7] contrib: fix typos
Date: Thu, 10 Oct 2024 18:11:20 +0300
Message-ID: <20241010151223.311719-3-algonell@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010151223.311719-1-algonell@gmail.com>
References: <20241010151223.311719-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 contrib/subtree/git-subtree.sh         | 2 +-
 contrib/subtree/t/t7900-subtree.sh     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 60a22d619a..3d4dff3185 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3296,7 +3296,7 @@ __gitcomp_directories ()
 		#       i.e. which are *already* part of their
 		#       sparse-checkout.  Thus, normal file and directory
 		#       completion is always useless for "git
-		#       sparse-checkout add" and is also probelmatic for
+		#       sparse-checkout add" and is also problematic for
 		#       "git sparse-checkout set" unless using it to
 		#       strictly narrow the checkout.
 		COMPREPLY=( "" )
@@ -3698,7 +3698,7 @@ _git_worktree ()
 		# Here we are not completing an --option, it's either the
 		# path or a ref.
 		case "$prev" in
-		-b|-B)	# Complete refs for branch to be created/reseted.
+		-b|-B)	# Complete refs for branch to be created/reset.
 			__git_complete_refs
 			;;
 		-*)	# The previous word is an -o|--option without an
diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 5dab3f506c..15ae86db1b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -946,7 +946,7 @@ cmd_split () {
 		rev=$(git rev-parse -q --verify "$1^{commit}") ||
 			die "fatal: '$1' does not refer to a commit"
 	else
-		die "fatal: you must provide exactly one revision, and optionnally a repository.  Got: '$*'"
+		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
 	fi
 	repository=""
 	if test "$#" = 2
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index c3bd2a58b9..3c6103f6d2 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -47,7 +47,7 @@ last_commit_subject () {
 # pre-2.32.0 versions of 'git subtree' would write the hash of the tag
 # (sub1 below), instead of the commit (sub1^{commit}) in the
 # "git-subtree-split" trailer.
-# We immitate this behaviour below using a replace ref.
+# We imitate this behaviour below using a replace ref.
 # This function creates 3 repositories:
 # - $1
 # - $1-sub (added as subtree "sub" in $1)
-- 
2.43.0

