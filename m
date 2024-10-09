Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B554192590
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474594; cv=none; b=dh9jdsNxRmxLRoTYDvtsxKVh6zj7iks28xsbEraywtX6FzMlVekvemsNrsM9qNIWthD5dUGeJw8HBH+SeHVVqo8bl0R0a1M5JXzDMdC4BGBbc8LJJ+fYIf0rpC8PmD8B0pxljw0/YzYv0Qv96Ijxwru2on7tCLdN14uP2t6IeQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474594; c=relaxed/simple;
	bh=wjxkVm/CLgTira+o7sqXH/xBx3y9O+HpiHshaA6ypnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCjHYgU+HM+C8sa/5MQo85q3NmfLvXDOMH9Hz/xCKpafVGzqYi3j4cZdH26d5B6/tKIuYAD0Vqk/ETsPBh8u4nnyxApDLWdtruFK5KBdpovfY3CtkLIjVaRMAGET0Vo5/cNa6m/6rrUPZReK/ebWcI0jyf+qn+ZXkQQ/4NVNrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2RmnBBH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2RmnBBH"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso70294301fa.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474590; x=1729079390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w4w3smvcYTy79Meehr4W8kfjb5FoQWIdfgkuDILvcw=;
        b=C2RmnBBHsOg4cYNc0dFliM1s7RtAzH8zKglYOjeS0zHCeykCcVkVMUOwiJA/kHZJRV
         VYqw8EW57iy5zmM4/0ELi2OQAUtnC7pX28y2YRk8Uk+1FWRbEkGAky4rUmnrSAv0tIKx
         IqCC5nr9cdReuCNYK/k91q3fkk0rxBM+F+fEh+GIHw3sbBOqYcX+HLIWkWfoMy/hNUX1
         1tNzELbU8e+NGwJoNVceiVnqWhGuy+GoPDQBPw8oPuENyfN5jEhpss247Zrm69ozrqHr
         AnomCOiIcUWBVVuhiWlEGnkAVzhnJKPj3Vnb5oOjn2GY5JLCnC5SAPfqz2WHNtu59fu+
         IvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474590; x=1729079390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w4w3smvcYTy79Meehr4W8kfjb5FoQWIdfgkuDILvcw=;
        b=sbuaOtk1KNp0Srs9IRCqBAyXpylt1MrakBLmYIW6IMxL6L6q5dNyOtBlq4uEGJuGC7
         QOTTETv1LYtWKodGZNaGC4Ldza48kFv2JdWWqrMXVTjcI/VtsR2CQXL/DndHB30zik6z
         i8sQtg2B3Il/l3MZ1LDQVabecHuf+MachOnulE1B7NgY94WIqmXcHK1KmNHbK6pS9n6v
         SIkSPkG2gdMrGoAHvtauI6yfguTWRfAIOu0Q3G+YnIYhAzEyUWTY2pKKn6z/9cGQLv02
         tAJITXHQuH1l3Sk8vEXsMe/QvB6Rtqn780rcZ1t9n6JH3HGHwk2vWVJN7Nb5DRVdEvpM
         EZBg==
X-Gm-Message-State: AOJu0Yy7fnqVCQfvmGo1uQoPAn35tPR1xC93rjLItWvuq3hXyoC/bXnd
	gtVsD14dzx0IuWS6GZBqI8y9UYGUl9I54EzC+mv0ZAapY7uK8kEU2wVRvp2z
X-Google-Smtp-Source: AGHT+IEEJ1woYiqfY+squcDig8tldXVKZlEycVg/K2m3TFKldIs3kS6dNoNnDAUyOaOOKc6AWhi8Hw==
X-Received: by 2002:a05:6512:3b83:b0:535:6795:301a with SMTP id 2adb3069b0e04-539c4945f49mr1186054e87.47.1728474589815;
        Wed, 09 Oct 2024 04:49:49 -0700 (PDT)
Received: from void.void ([141.226.169.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a4ff9f7sm595800566b.26.2024.10.09.04.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:49:49 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 2/7] contrib: fix typos
Date: Wed,  9 Oct 2024 14:49:35 +0300
Message-Id: <20241009114940.520486-3-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009114940.520486-1-algonell@gmail.com>
References: <20241009114940.520486-1-algonell@gmail.com>
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
2.39.5

