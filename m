Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE12C17A0
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345906; cv=none; b=fzW3S1SRXXL6FddCrOwcjj/u7aOzju7jTbhhVPp9KzBf+A4Hf82GtPk1I84IlwZmD9KSQ2emcLTodr+IpNCQDlHkXFcq7WulFUYS3Rdt5oY9O1Ne2dLYd01MvLtDFgT9rPC2lK5WvRZoDyFc3ieHJOBSL/+epwLbUPAPCJhDueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345906; c=relaxed/simple;
	bh=EqUQg/Bjr6CSXSD9XpDDl8EH8YVSnhmmKPcLqp7mfyc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iP7uIAa5gmawEFS3ig9Nd9TwerCObMVLOmapSlCUPVx+nlBCi1TUCuQr6MITAF0O8S5q3XvrXtIMZyLaIPI1WxHGW0uRmAyDlbsHW5XsZ0wvqVB5/+hlFtvQ5qXjg80Bshxy85A3U/e7/yxUHoF2jhxCUTCeD1m9zreYISwpY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXKrL8WE; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXKrL8WE"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128ef6c4a41so613409c88.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773345903; x=1773950703; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQYc/3f7VjLyQWoYACWYj359iO8g+u5yaZKHdmnPsgA=;
        b=FXKrL8WEEwlSREqm7CV+s3m0hSBc6NPJMmCpsfXY+0GdEvScCuI8A7xIs4C23gkNoL
         6meoukxv0uf5vBhCqQ1EFKK0szctgdrU/ak3o14iG5OL2iSFrqCuJj0s/oAU0GlTxggQ
         Z84ril1RdzUORXkJFNy+84znDG28lQypbnxqacI6cQw6RYwWhKRwIO2OZ7t6UqO8lutZ
         UzrtlBw9Tmu6NbJOgffeFSNi+Hyp+73BFqOb6NOkKaaFEtv4TA8uGurHSMzTxtRnIdoa
         H0Da8tzyXlnLrpL3IA8sdtbC410qsOGOpo/XqjyrDt5X9XWe3dj1u2RPFV5hlMTUNzpU
         0U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345903; x=1773950703;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tQYc/3f7VjLyQWoYACWYj359iO8g+u5yaZKHdmnPsgA=;
        b=WAJ7HoBrWgNEUkbGde2j/+Jn4dq8kMD3vSOUdIK80asBAZ+DOZumYCwF4WBbLOQG+O
         WBXg3wtd75pg6ABlgEWrdr7A+9dy/wYh85bsrQpPJVtQub2doXQqnAB8eia3uleCA+hs
         /Fu5nBMlI/e2t7JOsisw6Khb50FhwC01K2DateiKxiMQnD6UvXvXloJX6Ul+8xTaMXTy
         8lznwBwiEoqt9eZ2D+LQA13gOGQMbz5w/qkrNQ4oiVU1JUZW24v0awyCYdb4t1jjaulK
         8d14vMtwvFbK9hUvK3BhwPTal350uC9VXDd3eCFXjJl80bi6CeYaGyteNVxEh9DJr+JE
         Y8kg==
X-Gm-Message-State: AOJu0YwDXwS+XHShbBdoMBCLJUBCyJNf4sfwQMJ+0SCuEa8XTvN9aju3
	p6gzrod6QvnyV8ries1yQ8ArXUEs/pifpSJ4Htn6UjHAygRngSu7wXVUAJqG1Q==
X-Gm-Gg: ATEYQzyx0rrsF8hbkRfFrM84s60QgFP80EfJyg0Gm+qXfFi1DNLkdFgoD/rHzqwV1hO
	Ecisgg2yf4gJxhU17XFT3z3bacXDK6tmLbuDhIDaXr2iB7gCZZFxCbMM/YcMxOg1Yol9OwMmy4u
	343WUs8GJW0BINKypfroaZs90PREeKddz8fRIVNgxXrYD7UF+H73G1zpxdUVEr2GP555De6tM98
	lfJp0EZgTsR9ueY8U8CWjQiIOSWV/1GXISFv/od2rSfj0UPG5Nfq9JEBpGz6/f/0HVB0Qxhibl6
	lVsV9uvMZtCuYaO35rNwoWUKSlsVc8DGaTvpZqo3v+cc8/QSWohay96MrsweiGPzwD9YpnaIHGS
	ZJB8zC3ePuehurAHIdKiooAicS9JubJ7xEMpl9et0ReusQ+EhJaoBa7c2xQkQzLlhKFtjGBm2Lj
	LVV4RHmo0bVKMMKGHScembtn1fV3N++DlbhaPA+g==
X-Received: by 2002:a05:7022:698d:b0:128:dcbd:e27c with SMTP id a92af1059eb24-128f3d5a938mr394410c88.20.1773345903001;
        Thu, 12 Mar 2026 13:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7c0d698sm10454630c88.6.2026.03.12.13.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:05:02 -0700 (PDT)
Message-Id: <pull.2233.v7.git.git.1773345901659.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
References: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Mar 2026 20:05:01 +0000
Subject: [PATCH v7] unpack-trees: suggest using 'git stash' when checkout
 fails
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

When a branch switch fails due to local changes and
new users who are not familiar with the error message often
get confused about how to move ahead and resolve the issue as
the previous error message only suggests to commit or stash the changes
but doesn't explain how to do that or what the next steps are.

This patch enhances the error message with more specific
instructions in a concise manner to help users understand
how to resolve the issue and move their local changes
safely to the other branch using stash.

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
    Advice on checkout dirty files
    
    This is my submission for microproject [GSOC]
    
    This patch extends the current message to help users better understand
    risks and alternatives to stashing their changes.
    
    The alternative consists of
    
    > git checkout -m and its repercussions.
    
    This extended message is tied to the existing advice.commitBeforeMerge
    configuration and can be silenced with:
    
    > git config set advice.commitBeforeMerge false
    
    Changes:
    
    > unpack-trees.c: expanded the already existing message.
    > t/t6439-merge-co-error-msgs.sh: update expected output for merge and
    > checkout tests. t/t7406-submodule-update.sh: update expected output
    > for submodule checkout tests.
    
    Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v7
Pull-Request: https://github.com/git/git/pull/2233

Range-diff vs v6:

 1:  e0ba5fad82 ! 1:  72cb550621 unpack-trees: suggesting 'git checkout -m' with its repercussions
     @@ Metadata
      Author: Arsh Srivastava <arshsrivastava00@gmail.com>
      
       ## Commit message ##
     -    unpack-trees: suggesting 'git checkout -m' with its repercussions
     +    unpack-trees: suggest using 'git stash' when checkout fails
      
     -    This comment is an extention to the already existing stash comment.
     -    Added updated comment over the already existing function
     -    "setup_unpack_trees_porcelain" with "git checkout -m"
     -    and its repercussions
     -    I have also mentioned the repercussions of using "-m".
     +    When a branch switch fails due to local changes and
     +    new users who are not familiar with the error message often
     +    get confused about how to move ahead and resolve the issue as
     +    the previous error message only suggests to commit or stash the changes
     +    but doesn't explain how to do that or what the next steps are.
      
     -    Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
     +    This patch enhances the error message with more specific
     +    instructions in a concise manner to help users understand
     +    how to resolve the issue and move their local changes
     +    safely to the other branch using stash.
     +
     +    Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
      
       ## t/t6439-merge-co-error-msgs.sh ##
     -@@ t/t6439-merge-co-error-msgs.sh: error: Your local changes to the following files would be overwritten by checkou
     +@@ t/t6439-merge-co-error-msgs.sh: cat >expect <<\EOF
     + error: Your local changes to the following files would be overwritten by checkout:
       	rep/one
       	rep/two
     - Please commit your changes or stash them before you switch branches.
     -+Try using 'git checkout -m <branch>' for a quick fix.
     -+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
     -+Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
     +-Please commit your changes or stash them before you switch branches.
     ++To move you local changes safely to the other branch,
     ++Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge.
       Aborting
       EOF
       
     -@@ t/t6439-merge-co-error-msgs.sh: error: Your local changes to the following files would be overwritten by checkou
     +@@ t/t6439-merge-co-error-msgs.sh: cat >expect <<\EOF
     + error: Your local changes to the following files would be overwritten by checkout:
       	rep/one
       	rep/two
     - Please commit your changes or stash them before you switch branches.
     -+Try using 'git checkout -m <branch>' for a quick fix.
     -+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
     -+Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
     +-Please commit your changes or stash them before you switch branches.
     ++To move you local changes safely to the other branch,
     ++Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge.
       Aborting
       EOF
       
      
       ## t/t7406-submodule-update.sh ##
      @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update should fail due to local changes' '
     + 	sed "s/^> //" >expect <<-\EOF &&
       	> error: Your local changes to the following files would be overwritten by checkout:
       	> 	file
     - 	> Please commit your changes or stash them before you switch branches.
     -+	> Try using '\''git checkout -m <branch>'\'' for a quick fix.
     -+	> Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
     -+	> Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
     +-	> Please commit your changes or stash them before you switch branches.
     ++	> To move you local changes safely to the other branch,
     ++	> Please try '\''git stash'\'' followed by '\''git checkout <branch>'\'' followed by '\''git stash pop'\'' for safe merge.
       	> Aborting
       	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
       	EOF
     @@ unpack-trees.c: void setup_unpack_trees_porcelain(struct unpack_trees_options *o
       		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
      -			  "Please commit your changes or stash them before you switch branches.")
      -		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
     -+			  "Please commit your changes or stash them before you switch branches.\n"
     -+			  "Try using 'git checkout -m <branch>' for a quick fix.\n"
     -+			  "Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.\n"
     -+			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
     ++			  "To move you local changes safely to the other branch,\n"
     ++			  "Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge."
      +			  )
      +		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
      +				"Please commit your changes or stash them before you switch branches.");


 t/t6439-merge-co-error-msgs.sh | 6 ++++--
 t/t7406-submodule-update.sh    | 3 ++-
 unpack-trees.c                 | 7 +++++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 643c9368e0..6ccc1e0416 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -76,7 +76,8 @@ cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
 	rep/one
 	rep/two
-Please commit your changes or stash them before you switch branches.
+To move you local changes safely to the other branch,
+Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge.
 Aborting
 EOF
 
@@ -98,7 +99,8 @@ cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
 	rep/one
 	rep/two
-Please commit your changes or stash them before you switch branches.
+To move you local changes safely to the other branch,
+Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge.
 Aborting
 EOF
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 3adab12091..1ba15918a5 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -211,7 +211,8 @@ test_expect_success 'submodule update should fail due to local changes' '
 	sed "s/^> //" >expect <<-\EOF &&
 	> error: Your local changes to the following files would be overwritten by checkout:
 	> 	file
-	> Please commit your changes or stash them before you switch branches.
+	> To move you local changes safely to the other branch,
+	> Please try '\''git stash'\'' followed by '\''git checkout <branch>'\'' followed by '\''git stash pop'\'' for safe merge.
 	> Aborting
 	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
 	EOF
diff --git a/unpack-trees.c b/unpack-trees.c
index 998a1e6dc7..e817477926 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -128,8 +128,11 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
-			  "Please commit your changes or stash them before you switch branches.")
-		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
+			  "To move you local changes safely to the other branch,\n"
+			  "Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge."
+			  )
+		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
+				"Please commit your changes or stash them before you switch branches.");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"

base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
-- 
gitgitgadget
