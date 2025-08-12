Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98E284B3B
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006578; cv=none; b=b3Td36yMwpy6odrVqKqfCPsgf0Jyu+CbiDcMZOVKx4C+mInxslAPhLBKgREX9IB1D2C8tZrDFVhPtTIrC8PaXSDFPUnlDajTmotkTFpJr7zTWG1NysooBcA/E63Y3UN/SnmDgHWxwcYVP6pFC8kS/sPORp66V9ein3SR1ppNlYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006578; c=relaxed/simple;
	bh=DV0RE0LuOmQ5WZcn2WDmG8Ap0E2kUBX0y6dIYZk8cdU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xu5V/Bnr/jFUhKgf5FhcSUPY43Y219ea4r5sVebVSq+U6E/lav12WSjy3gRq/nayX9y230t/JHqoJsk3eLXqKh2yhVrVfmkP2t/EX/PO1uPfUH9aESy2b0eWzR1m3325aM7ARb1bk4FgEWGjZziJF703uvdoJ6fMoLHyA2HoPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLfxbo2Y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLfxbo2Y"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b783ea502eso3769299f8f.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755006573; x=1755611373; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06mxZlMd6Ld6PBCaiMg0tF5UZv74Pr340bDXqAEbmMI=;
        b=aLfxbo2YCMz1gSREHaJYBqzmNSqwaBmBDkPKzohqtnImVY6Oy+6ZU+crqrV2dzaXR8
         FnC/BJ/AXsr8iYqHrRd+WW8o+rknfFDRTsWaIaDKNVDZXn3WNaKCjsSYkcNkq2m+tfQ1
         M7MbI1jY6qEJEQWXLWd4lOW2GlXWQRQPYskYyY69xq/0yaGZfhsdrPLKQ5KY2UC254zW
         dnm1DUBjlt6LJN12pZd+AwEErmYiKMTZthMm55WEbb0NrNaL0wmHMIm/XGZZaE4eercW
         9NSwYInyC9OO7ikq67CyiZEzrIiCfxL/eLs6Q4d87CxhtW/09H03PDqFRLtk3zkBpoIn
         WBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006573; x=1755611373;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06mxZlMd6Ld6PBCaiMg0tF5UZv74Pr340bDXqAEbmMI=;
        b=sKas3qmWy26bYcLwOpiJTIU5fIF2MpUURR1C7P0SFXF1HboDJZRmpyBqMo5CqHlwFj
         Do2CFCrVtBOEBmtK+GDDLxf8OZSfn5moL0Tt5C68yrt5H8R6pb5AYCTIM8WSXJYQVFXk
         yudesBFHtpi76xjKpSB+KeOmr7AO2n8EaZFf8ViGgvrhLjcq80HZbFEIdODsBMdEN7Lv
         ftTMHCnSt+1tPj3wR0sJZPmJkNoGCZoLmD4gxUja5Y0iTpAc4ibAb3xy19kWgGQPjzJ6
         UpkodU9N33p4aBVyuy5oP/AZOFPbIhMkwh/BXxTCx0H3nC/vwfrkQ/isJxgZlnLRxQ/x
         Fugg==
X-Gm-Message-State: AOJu0YzrPVJWZacTEDmBjk4ggXVoTdNzvjg4KwEo+mTW57PUx61ah3WY
	+uZSuOANkXgK+a3518BBmyYzpsOyX674VuRKOUMYdPw1EpXPdQNDo/Kc78AfYg==
X-Gm-Gg: ASbGnctbAMppK2xgjqMc/W4ka6UE8pq6pvrxCtI4bW/HnDR7d4SgBctmlQWTQhpPsGu
	TCs34MeDhEA9Z4ROe+IJIAjytNxzKBTjRyjZt9F7/mZf3VKES1VnbNUbR1ANbM1jOvhUc9MrwMm
	V/PxgBdf5odWZEYWlLMDohpIQ1Yr0X+bzDHWyumet4bqf7APHuluiqeOehtITBxNsD7ppLio0mK
	8jeWOaivj62EHQLabsVFYW73De89fSNQEmZkZfJDANpFeJ9NobghiWGeXkoHB189tndR2Y1CGMp
	v2oDg8H3sHImujVe5trcTUXKbGjALQ+M0mdc+nI25uzwfNiks8rKAlYR7e0nWUNKDiCv5ij0AII
	TpqIdTl1OdyDWlYgSm7Fnpgw=
X-Google-Smtp-Source: AGHT+IFhWy6ijdaYWukHQjzt9i2IekUtNd4zkfRplejDTRo8MS4CsK6q33sINPc+c8SYT9U0G5nJ0w==
X-Received: by 2002:adf:e58c:0:b0:3b7:908e:e4ac with SMTP id ffacd0b85a97d-3b91113c943mr2221147f8f.2.1755006573256;
        Tue, 12 Aug 2025 06:49:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0e70218sm326563605e9.20.2025.08.12.06.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:49:32 -0700 (PDT)
Message-Id: <4686417b28e4ab386983ad68e4d4d4798a467811.1755006568.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
References: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
	<pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 13:49:27 +0000
Subject: [PATCH v7 4/5] doc: git-rebase: move --onto explanation down
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
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
index 6d02648a9b3c..d041d87f270b 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -114,87 +114,6 @@ will result in:
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
 
@@ -240,6 +159,8 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
+See TRANSPLANTING A TOPIC BRANCH WITH --ONTO below for examples.
+
 --keep-base::
 	Set the starting point at which to create the new commits to the
 	merge base of `<upstream>` and `<branch>`. Running
@@ -1018,6 +939,91 @@ consistent (they compile, pass the testsuite, etc.) you should use
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

