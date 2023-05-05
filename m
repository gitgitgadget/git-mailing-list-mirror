Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E62C77B7D
	for <git@archiver.kernel.org>; Fri,  5 May 2023 19:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjEETR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 15:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjEETRz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 15:17:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA330F4
        for <git@vger.kernel.org>; Fri,  5 May 2023 12:17:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3077d134028so754720f8f.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683314272; x=1685906272;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCM29MEe10j9fw6F4qqgm0XSuz1+H81Xo1xEHJZyigo=;
        b=MV9uXgcQlf7ce7n6No3ojtKQ4P9lpatvqvVVwOMiqL06oogrv5fkK6k9cS5LBPe1Ni
         mt0p5v6cNn+ORX88AL8Nv8vlY1Ko7j3J9ZuwVGl/RwX4hfzMTs0wy/8Wv4Tw1MyqLSCZ
         pB6SHtbFXMljg51auQRZMYJAnVkJQPz1l9rxnDbhhgYQT57uCBQaIKp+SgJkPwcyXfVh
         kYhSBhQn3t2OYGx+tV/rYXU5VXtEQplMib2NtBHLPu2Rtr59QzHOkBs0d/5z1h5u7wT6
         bK6UfZDgTATMcv+ZNiU/f9EXx2ESbhkKiagP3YUb2ho3woxMOLpTanwD5Guq0pOvZxbI
         SIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314272; x=1685906272;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCM29MEe10j9fw6F4qqgm0XSuz1+H81Xo1xEHJZyigo=;
        b=PoSSRk93IK0OuyUQMRaffgeb4xPSTCOohnJCendtsYeQ4KHQuNXcefdiBSl8yQid1K
         N76/ANbvcV9EgalqWJbeDcNBXfS0evSku7/cEZswDpfY3njhiYWEJbG61kOLJQca7/oy
         5LosmwJznqr5MRpoEn1Hlxpz1tJBnVMvQXtI3BfRAw6MKVIFJ1gj7LXkyWJCIdGYO6tG
         udrzQI/AMc5UawInsmessmYujOkcbsYJYZsPC6Pw197UyWImrNOChrkZsAzqM9ugeUOh
         ZKI9oQ5feBI+sKmWpFnH2jYmmjkRA9IO1Xsat52mk4K0sO7LkIBGq2C7SY8L8DC2rTN8
         K/XA==
X-Gm-Message-State: AC+VfDxlGhAFO00j4REmtSqjqqUiEx+LsNp5pVF4wn/Y3WMB8KIqACNc
        b3UIQvjWEa8/PkGBhdspCn4HMw0mizU=
X-Google-Smtp-Source: ACHHUZ6EC9E+ib79Rj2PcepwiRZsZ/aVoQBbSlsV3wE8GznN0vIJB0DHCVABQ4+nimRy3BYMuIJCaA==
X-Received: by 2002:a5d:4d4f:0:b0:302:5d34:38a7 with SMTP id a15-20020a5d4d4f000000b003025d3438a7mr2006038wru.36.1683314271983;
        Fri, 05 May 2023 12:17:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d460e000000b003047ae72b14sm3202779wrq.82.2023.05.05.12.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:17:51 -0700 (PDT)
Message-Id: <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com>
In-Reply-To: <pull.1225.git.git.1646774677277.gitgitgadget@gmail.com>
References: <pull.1225.git.git.1646774677277.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 May 2023 19:17:50 +0000
Subject: [PATCH v2] name-rev: make --stdin hidden
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In 34ae3b70 (name-rev: deprecate --stdin in favor of --annotate-stdin),
we renamed --stdin to --annotate-stdin for the sake of a clearer name
for the option, and added text that indicates --stdin is deprecated. The
next step is to hide --stdin completely.

Make the option hidden. Also, update documentation to remove all
mentions of --stdin.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
    name-rev: make --stdin hidden
    
    Now that --stdin has been deprecated for several releases, the next step
    of replacing name-rev --stdin with --annotate-stdin is to make --stdin
    hidden. This patch also updates documentation to get rid of any mention
    of --stdin.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1225%2Fjohn-cai%2Fjc%2Fhide-name-rev-stdin-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1225/john-cai/jc/hide-name-rev-stdin-v2
Pull-Request: https://github.com/git/git/pull/1225

Range-diff vs v1:

 1:  32c8db2f03a ! 1:  904cd2c3572 name-rev: make --stdin hidden
     @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
       				   N_("ignore refs matching <pattern>")),
       		OPT_GROUP(""),
       		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
     --		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use annotate-stdin instead")),
     +-		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use --annotate-stdin instead")),
      +		OPT_BOOL_F(0,
      +			   "stdin",
      +			   &transform_stdin,
     -+			   N_("deprecated: use annotate-stdin instead"),
     ++			   N_("deprecated: use --annotate-stdin instead"),
      +			   PARSE_OPT_HIDDEN),
       		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
       		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),


 Documentation/git-name-rev.txt | 8 ++------
 builtin/name-rev.c             | 6 +++++-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index ec8a27ce8bf..5f196c03708 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git name-rev' [--tags] [--refs=<pattern>]
-	       ( --all | --stdin | <commit-ish>... )
+	       ( --all | --annotate-stdin | <commit-ish>... )
 
 DESCRIPTION
 -----------
@@ -70,10 +70,6 @@ The full name after substitution is master,
 while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
 -----------
 
---stdin::
-	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
-	They are functionally equivalent.
-
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
 	the name.  If given with --tags the usual tag prefix of
@@ -107,7 +103,7 @@ Now you are wiser, because you know that it happened 940 revisions before v0.99.
 Another nice thing you can do is:
 
 ------------
-% git log | git name-rev --stdin
+% git log | git name-rev --annotate-stdin
 ------------
 
 GIT
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 593f0506a10..4d15a23fc4d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -573,7 +573,11 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				   N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
-		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use --annotate-stdin instead")),
+		OPT_BOOL_F(0,
+			   "stdin",
+			   &transform_stdin,
+			   N_("deprecated: use --annotate-stdin instead"),
+			   PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,

base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
-- 
gitgitgadget
