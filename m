Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA928750D
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666673; cv=none; b=bWVA15O7nUYYu2RJYKgiiCpYkpbMH6rblM1kqXB/ur5yeGyWUKUA2zA2QrOw2+C5raG9URh4MIQwk3fS0XA9KopUwkXyoIT1sei4bDJl0G7pF+kTzs3g01tWLAVMTutS//a1s24Hz/E3C+IXwCGSuqQCUxbYIePAVbgEM0e/XuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666673; c=relaxed/simple;
	bh=/KOoNZHU5ajlm80pL8ozOE6zi7098kr/3Az6dGdvlIc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dtTR7G0Otn6Pxqsw57FNJVeZBf0kBKXlHUVK16IUpJWzsAz9G5XLKhUG4aqzXhRROcxpDj/FUbbOH/cetsDnayzbwrbrz2hL4Fl+310Bk0hRK7vvVtyeNUJ6nlhVuWTUasEFeanE69QWQ3M7E/c5HqVPaa1/2KlaUd0zB30/8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmQxpZU2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmQxpZU2"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso1650344f8f.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754666669; x=1755271469; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IOVVR0Ur8NdqnjVC+T5juuZZlIOBN9RAbYnoE/z3uA=;
        b=PmQxpZU2ftmVsgtQ2v50+rGQvwly757Bph7E7M8ZsOoCYYXf0zGm5Io2ulcRC1M4EW
         5muj2kc8tmlX3rlTwTOmbwffgF3LKLpJHfnmBPLZ/LQi8/HLGYeZkzAshQE5gOUP6okG
         5ZB60vkuEKzXW4lWbzFl6/k5cuAlbppkJVumZVFEq0sq2RJXChw3YJxPtwnPARbOk+Dd
         ZC2ln2BxrEoOjF7dO1lCJOwIdMo2Jpv0HXINSj4gtUtGcBZ/CIKhXheAWE5X9Is6WgKS
         Cvnbl0AOlkYq3NoH9uuPrNlsQdM8VG/GDJZN16IcOqWaKh4QxPlf1LiXrpMlLTQL2SMr
         VfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666669; x=1755271469;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IOVVR0Ur8NdqnjVC+T5juuZZlIOBN9RAbYnoE/z3uA=;
        b=qo7b9r4fEYNv0IqW8/21fbxdpPYY2Ahd14CrEZ6pC8XjjIt2nOy0coEMJkNjjffpP+
         d3OzoqIeq/IH6ac1lmJV5eUVP0vPBRyRN+vJYFqga87zvb9jsXl4doSRUI84nyoOwN6D
         m9q3bMM2M60h/B0qwibdsews3aCvDk86tzm2mq19bi38Wjz+JlpL660ck1VkE/mecFX5
         un3gmggy/8rbU3WaNQjmI4qEHmDE2CetxMfDlOmw/oBuiTAlHM0wgC0SrywGJJgyQQ6v
         1ehnK6D8tSVyAbUA2Iwo9x73T4Qp64f4SMNNTV1/OvGoGl9bkXLrGENZCRNi4QsFvdL+
         Gldw==
X-Gm-Message-State: AOJu0YxFQ8Crg1imYT5AhiNDG7L4AVagNBOYYMnjF6UclE/1cGiNStGb
	8F8JY5/FUcEwIru2JgrGqN1wnF/vnhsFyugWofb5w+9Ko8zl2eEwXNsfciUhWw==
X-Gm-Gg: ASbGncvIviSGi6K2YRPPq+kPvISfC9GUCv+ZzlMc9119LNUnKo9paKNC8Zs//kNcAkh
	IHkozDW0nOy1W23A21cxRb0WDMYtLGBrocetui1wq4AT+YfonVfSBF69AqXyaQam7Za4IA4tm5B
	K9d7K2Vf2BRYLmLOaytyERSg3KjicE5yLTlt+TcCkRx+LLfxKK6u8phoA5Uya9sUTdbChiwNH+k
	fPJNGkyMK+UGsHP9Wmx4bnOngKsGG+bGlmTvU95EEba4IYJDv0WwhT2u4lmDto1ELnmyIq87DNg
	PmP/8ey5GnHz0tspL4RSHBZAxeEfkkpeNOxRltR6faaCAkI8x3hOvdO9FAEYSW2MTBGro2knbJs
	0CWRNWSCphHLdMqnOrayJXho=
X-Google-Smtp-Source: AGHT+IE9a6L9mjyZSZx8UmmQ8b5UaXM7UCtRfWDFRGRgzxHH+atrBBjjXQ6RNvMvGnMSWBmawKQiEA==
X-Received: by 2002:a05:6000:4028:b0:3b7:8842:8a0c with SMTP id ffacd0b85a97d-3b8f97ec49emr7209989f8f.19.1754666669327;
        Fri, 08 Aug 2025 08:24:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0846777sm20788757f8f.48.2025.08.08.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:24:28 -0700 (PDT)
Message-Id: <28b00d3b32fbb2771048ddf6088e59172983a8aa.1754666665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 15:24:24 +0000
Subject: [PATCH 4/5] doc: git-rebase: move --onto explanation down
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

There's a very clear explanation with examples of using --onto which is
currently buried in the very long DESCRIPTION section. This moves it to
its own section, so that we can reference the explanation from the
`--onto` option by name.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 168 ++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 81 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index ada9f6b2614b..c63d67f340a0 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -113,87 +113,6 @@ will result in:
     D---E---A'---F master
 ------------
 
-Here is how you would transplant a topic branch based on one
-branch to another, to pretend that you forked the topic branch
-from the latter branch, using `rebase --onto`.
-
-First let's assume your 'topic' is based on branch 'next'.
-For example, a feature developed in 'topic' depends on some
-functionality which is found in 'next'.
-
-------------
-    o---o---o---o---o  master
-         \
-          o---o---o---o---o  next
-                           \
-                            o---o---o  topic
-------------
-
-We want to make 'topic' forked from branch 'master'; for example,
-because the functionality on which 'topic' depends was merged into the
-more stable 'master' branch. We want our tree to look like this:
-
-------------
-    o---o---o---o---o  master
-        |            \
-        |             o'--o'--o'  topic
-         \
-          o---o---o---o---o  next
-------------
-
-We can get this using the following command:
-
-    git rebase --onto master next topic
-
-
-Another example of --onto option is to rebase part of a
-branch.  If we have the following situation:
-
-------------
-                            H---I---J topicB
-                           /
-                  E---F---G  topicA
-                 /
-    A---B---C---D  master
-------------
-
-then the command
-
-    git rebase --onto master topicA topicB
-
-would result in:
-
-------------
-                 H'--I'--J'  topicB
-                /
-                | E---F---G  topicA
-                |/
-    A---B---C---D  master
-------------
-
-This is useful when topicB does not depend on topicA.
-
-A range of commits could also be removed with rebase.  If we have
-the following situation:
-
-------------
-    E---F---G---H---I---J  topicA
-------------
-
-then the command
-
-    git rebase --onto topicA~5 topicA~3 topicA
-
-would result in the removal of commits F and G:
-
-------------
-    E---H'---I'---J'  topicA
-------------
-
-This is useful if F and G were flawed in some way, or should not be
-part of topicA.  Note that the argument to `--onto` and the `<upstream>`
-parameter can be any valid commit-ish.
-
 MODE OPTIONS
 ------------
 
@@ -239,6 +158,8 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
+See TRANSPLANTING A TOPIC BRANCH WITH --ONTO below for examples.
+
 --keep-base::
 	Set the starting point at which to create the new commits to the
 	merge base of `<upstream>` and `<branch>`. Running
@@ -1017,6 +938,91 @@ consistent (they compile, pass the testsuite, etc.) you should use
 after each commit, test, and amend the commit if fixes are necessary.
 
 
+TRANSPLANTING A TOPIC BRANCH WITH --ONTO
+----------------------------------------
+
+Here is how you would transplant a topic branch based on one
+branch to another, to pretend that you forked the topic branch
+from the latter branch, using `rebase --onto`.
+
+First let's assume your 'topic' is based on branch 'next'.
+For example, a feature developed in 'topic' depends on some
+functionality which is found in 'next'.
+
+------------
+    o---o---o---o---o  master
+         \
+          o---o---o---o---o  next
+                           \
+                            o---o---o  topic
+------------
+
+We want to make 'topic' forked from branch 'master'; for example,
+because the functionality on which 'topic' depends was merged into the
+more stable 'master' branch. We want our tree to look like this:
+
+------------
+    o---o---o---o---o  master
+        |            \
+        |             o'--o'--o'  topic
+         \
+          o---o---o---o---o  next
+------------
+
+We can get this using the following command:
+
+    git rebase --onto master next topic
+
+
+Another example of --onto option is to rebase part of a
+branch.  If we have the following situation:
+
+------------
+                            H---I---J topicB
+                           /
+                  E---F---G  topicA
+                 /
+    A---B---C---D  master
+------------
+
+then the command
+
+    git rebase --onto master topicA topicB
+
+would result in:
+
+------------
+                 H'--I'--J'  topicB
+                /
+                | E---F---G  topicA
+                |/
+    A---B---C---D  master
+------------
+
+This is useful when topicB does not depend on topicA.
+
+A range of commits could also be removed with rebase.  If we have
+the following situation:
+
+------------
+    E---F---G---H---I---J  topicA
+------------
+
+then the command
+
+    git rebase --onto topicA~5 topicA~3 topicA
+
+would result in the removal of commits F and G:
+
+------------
+    E---H'---I'---J'  topicA
+------------
+
+This is useful if F and G were flawed in some way, or should not be
+part of topicA.  Note that the argument to `--onto` and the `<upstream>`
+parameter can be any valid commit-ish.
+
+
 RECOVERING FROM UPSTREAM REBASE
 -------------------------------
 
-- 
gitgitgadget

