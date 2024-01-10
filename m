Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4284BA88
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxw435T+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso3907263f8f.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898536; x=1705503336; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72CWCTo6MTluhVFWwyJlaZG+vu3oUnUxiR+BuBDQwS8=;
        b=kxw435T+zVldz7gqFtiwyYgN0CW79ThQGALd6a6uTtTDhpTi0neax7W9FmVaE3A7ao
         NaxR9FQUAPQ36NYyRDcz3i8U6QEgqwnLX8TAJrloisb+jCPlkTuJL8JWFYSWMtL/IQGq
         Wj66qyb6hZ78Nh63pJoJUqLPs/xcmOGF7MD/lasa+Bgx3S1i5qHhWgpAKmGqBkdr8MEK
         IADE4UFvG+YUdOZqCpc3ybsOZBWfT5Ym3ztBMWMQmtGIN97TuVUP44ONEaDM95mWC3ae
         HdA4v+JxVX49pRDBvfH8YpVpcgzVRkhBGkMBTZgE1ZpWScW/+ErL57nZoRZoovmfBTNZ
         Aj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898536; x=1705503336;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=72CWCTo6MTluhVFWwyJlaZG+vu3oUnUxiR+BuBDQwS8=;
        b=FVbwpQgfHM3QAkNCOPzE0AHwPkaJ0iyxSq1SjchELZQfkDF5XGKinGXlbd2IdAiZTD
         KuK5YQpP9/QtHUGfMX6w34+md/08nWfe+6IPl9BMhzNAoCMoN7ssra8Ojv1rEX5p5MIY
         5B6gw2gWgUtRCC5dUQvrERZWW0njgGjz0xaL4gw7o/ms/p7ydAanMHfX4lq0mhykmHgj
         PotEbfPaukl4Nv60S9nxnMK6KLwJ4uQ+tKm50XNFMM1oVTjEV7zuN4+72GApF1Yt0l92
         MKBrfE/us931wzMwRd0CEaZ2ORquc/ZiUfqJX+QcbDqkzxaQBIQywOx3Hi4MMK+OKfbO
         6dTw==
X-Gm-Message-State: AOJu0Yw4CTq34XpoP920jRdNeZTaEU1O5CAR+9+UhT56TpCzirFfDSu5
	w1dgZZOtQguFhjBM01G83zcfUCfFj8c=
X-Google-Smtp-Source: AGHT+IFi//v8IhLyQrNaaQiQa9pRJebiszEQZW1cJ8YnuL5rFuD2kG7KUOjfE36tKsBc2qV35E8zPw==
X-Received: by 2002:a5d:4c8e:0:b0:336:7405:fcae with SMTP id z14-20020a5d4c8e000000b003367405fcaemr594585wrs.142.1704898536457;
        Wed, 10 Jan 2024 06:55:36 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d5943000000b0033775980d26sm4400983wri.2.2024.01.10.06.55.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 06:55:36 -0800 (PST)
Message-ID: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
Date: Wed, 10 Jan 2024 15:55:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] branch: error description when deleting a not fully merged
 branch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The error message we show when the user tries to delete a not fully
merged branch describes the error and gives a hint to the user:

	error: the branch 'foo' is not fully merged.
	If you are sure you want to delete it, run 'git branch -D foo'.

Let's move the hint part so that it takes advantage of the advice
machinery:

	error: the branch 'foo' is not fully merged
	hint: If you are sure you want to delete it, run 'git branch -D foo'
	hint: Disable this message with "git config advice.forceDeleteBranch false"

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

This change is a pending NEEDSWORK from a recent series about adjusting
the error messages in branch.c

Unfortunately the full message now becomes a three line message.

Hopefully we can find a way in the near future to keep it at two.

 Documentation/config/advice.txt | 3 +++
 advice.c                        | 1 +
 advice.h                        | 3 ++-
 builtin/branch.c                | 9 ++++++---
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 4d7e5d8759..5814d659b9 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -142,4 +142,7 @@ advice.*::
 		Advice shown when a user tries to create a worktree from an
 		invalid reference, to instruct how to create a new unborn
 		branch instead.
+	forceDeleteBranch::
+		Advice shown when a user tries to delete a not fully merged
+		branch without the force option set.
 --
diff --git a/advice.c b/advice.c
index 50c79443ba..e91f5d7ab8 100644
--- a/advice.c
+++ b/advice.c
@@ -79,6 +79,7 @@ static struct {
 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
 	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan", 1 },
+	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch", 1 },
 };
 
 static const char turn_off_instructions[] =
diff --git a/advice.h b/advice.h
index 2affbe1426..5bef900142 100644
--- a/advice.h
+++ b/advice.h
@@ -10,7 +10,7 @@ struct string_list;
  * Add the new config variable to Documentation/config/advice.txt.
  * Call advise_if_enabled to print your advice.
  */
- enum advice_type {
+enum advice_type {
 	ADVICE_ADD_EMBEDDED_REPO,
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
@@ -50,6 +50,7 @@ struct string_list;
 	ADVICE_WAITING_FOR_EDITOR,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_WORKTREE_ADD_ORPHAN,
+	ADVICE_FORCE_DELETE_BRANCH,
 };
 
 int git_default_advice_config(const char *var, const char *value);
diff --git a/builtin/branch.c b/builtin/branch.c
index 0a32d1b6c8..2240433bc8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -24,6 +24,7 @@
 #include "ref-filter.h"
 #include "worktree.h"
 #include "help.h"
+#include "advice.h"
 #include "commit-reach.h"
 
 static const char * const builtin_branch_usage[] = {
@@ -190,9 +191,11 @@ static int check_branch_commit(const char *branchname, const char *refname,
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged.\n"
-		      "If you are sure you want to delete it, "
-		      "run 'git branch -D %s'"), branchname, branchname);
+		error(_("the branch '%s' is not fully merged"),
+		      branchname);
+		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+				  _("If you are sure you want to delete it, "
+				  "run 'git branch -D %s'"), branchname);
 		return -1;
 	}
 	return 0;
-- 
2.42.0
