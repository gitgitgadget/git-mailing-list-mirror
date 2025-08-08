Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB82701DF
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754693561; cv=none; b=WK4UKned8ulDL7/tW7v63O0BTMJ5EPJBUXMKiWQtT78iFvTvfL98TNDnxhBRU3Z/UVkle6mz3Qs158efK/gTVzHMGH2Lp7Y20Yn5w1IFgdQJBf3KovHNA+piNV9+EOryebgDFwizE0nOix70kQvqULfKWewTgE/bYa7fzDdeN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754693561; c=relaxed/simple;
	bh=rjjGEdK6C57JfHWZAT6jqcC/xfjN4QSZoipQYuBhx68=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jpyETWtGMlWkCIXaSz3xOuhUvcdA3v1T7uaw+C+zxUon9TsFGkmzvo5GljJP+P+rHClnEDB/ghk94t7o01qEIz4+BOv1OkFpOhBIeOfa/C1NloQ3O9gmYgUjQZn/DPwYhFy8g3N1ENh8T5creTlTiPhLyJ4aZ50gApNInUbYCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiKvkN3W; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiKvkN3W"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so1543578f8f.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754693557; x=1755298357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op+6J0CEbbg1MQLl3XWMsPDYhymrMxH1gqtZqtpxllE=;
        b=HiKvkN3WfKbHbzDcwGdyYga3bUGREKY1xtbLgKzBxPHoWxKxuIKJt6STELLs+8bTe+
         n97B8sSftjRDa3Z8MjuG0byrXE0xzFjLMZxKk0ao3TtpAUvUwOy+8ChjwS06ZFEu6k0j
         +TIeG27uGC3VXmmh+9gSnNd58K07JnHhH7l/wlJ42iA66PaXgtNFV4tVYxJ8IzdU7C6V
         fMGw92sOWTGi+G2B17sZt6uSvrewaZa/1PbQhd9DCTXIf01AbMkOL2IuTCVUIkvtMneK
         kBTTqT+x/zA6WXxxG6Utc5wzaAneL92dIbAWoaIIKBIYUQv273Uqi2d/Fk7DRnA9B3xO
         acXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754693557; x=1755298357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op+6J0CEbbg1MQLl3XWMsPDYhymrMxH1gqtZqtpxllE=;
        b=Nhx/UAX8Chw0Sci2ru4q8wfN+0TK4Y5Hxc+49nnQXrJNpYlbSs/5yT/xD68XXZIe8b
         uF3uGWjfF1ZrtvaidH2fHqWxfbIQU7FFUJFjpbF/CRhxDLCXG4/X9V3dX4m8LNloDAUx
         VXSCEdnX4/WzEsnaTPH4iyrEPnE9Uq2Lxn5VckIgbdXhz5z5JWxFCE64Iot4Sv5beegQ
         orr/ZHK05f+D3KB3OfdoFRZ+WwbUVFE0US1FRKjkHk2j058pN0FtbqlLPB/c0IKEY9Iy
         wkkgb1D3dBF3HLLq9LMMwPEE4C4NS5QAHjnp7xiHZYZfOlJeNqAvP42bMBfdoQRB1ApD
         JrYQ==
X-Gm-Message-State: AOJu0YxAq79xhfmXQ/nmkn4bIRHAYF6XZl4NXNIMV2ABjEaXekTTpdzi
	JVBxg7BcbRYdADhkJP0PFl8OU4kDBOOAwPFmPtgiylpag9h6GPPQ+eWEaz9P4A==
X-Gm-Gg: ASbGncuMMvOf2jwhFnV9GOFEWB+BDAZ6MaKxyKv885fBl+becpaeWM5nJVcxUaz1E0Z
	qCRVRW3G9g0KGHfHcifcvxW3r5rdQSsfD7ucQ/4+J+dXtJSU2uoD4fFqv+qKJAJhngYtEToHWC7
	LtfCz7pUCU+C1vLy55ijJgj0lr8AxUe7mlQZ6iGGuYBgSVo2pytEUaGVFN8nqyTyeTgpXZHe2nF
	IMa5ISuPFU+9MWyCeW0tyC3r4bC2oiflhGjbju+U3KkZDyCOAom+O2rcZhN28GMddmjpdwgYnYd
	lZ7HJd0cqh4ardMq1OoW3hEVVuzkskG53FsyyUYUgPmxiwgxy/uEAYZB6rWKkQ0On4qigQaRlqO
	da7Q26pl46Qg6wu3Hfx+MXW4=
X-Google-Smtp-Source: AGHT+IFJcQohwVOzGmVYkJMPvaSs5Nt/tiXCXe+I+19KrBdh+cqr08UYufXYDFHgW0mwLL7TR0U5MA==
X-Received: by 2002:a05:6000:2c01:b0:3b7:9ae0:2e5e with SMTP id ffacd0b85a97d-3b90092f881mr4086011f8f.9.1754693557244;
        Fri, 08 Aug 2025 15:52:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm32004268f8f.64.2025.08.08.15.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 15:52:36 -0700 (PDT)
Message-Id: <c574a27412d343029213ca8688d3794a8176e0eb.1754693552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
References: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
	<pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 22:52:31 +0000
Subject: [PATCH v3 4/5] doc: git-rebase: move --onto explanation down
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
index e700b92e35ac..6a4b3dbd5960 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -111,87 +111,6 @@ will result in:
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
 
@@ -237,6 +156,8 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
+See TRANSPLANTING A TOPIC BRANCH WITH --ONTO below for examples.
+
 --keep-base::
 	Set the starting point at which to create the new commits to the
 	merge base of `<upstream>` and `<branch>`. Running
@@ -1015,6 +936,91 @@ consistent (they compile, pass the testsuite, etc.) you should use
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

