Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D17C74A44
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 09:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCKJUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 04:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCKJUL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 04:20:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38BF14218
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 01:19:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j2so7131780wrh.9
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 01:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678526356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ierY8RY8k3XyjFDz/iBQZlQjbafpPj6dVnVdq8Ej/AY=;
        b=crhQaDBCfxz1dvufZl+h5E/qcSuQPR0sikAvdjMGVNf32etXm4ccgAID3AZBTdKApa
         c5QJhQ4/BZ/8L/htaO1eAc3L+hhe66Seqc2Pazc4qVXcbZXZ6hlLTUb8K8+JBKBE3qhC
         oKcMr9m5aeChxldw9kMfwnmW8EidhXrflysN3+eXjYXmvSIIKcNkI0yVCM04cZfpANAy
         7QQ09TPcCPWDy2YQqlcnp5zYXX8C2Hf1ei49TH4SUpsiTW1QKMOJoBK8KTVLfo2NjieH
         pRSU6qgy+3X0n6NXaAGnVvuGXKS89K6wYn+z6oBPLesqoieb4Wn6AGmGDePSYovxaJWH
         2g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678526356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ierY8RY8k3XyjFDz/iBQZlQjbafpPj6dVnVdq8Ej/AY=;
        b=LBSZxMAdUFoPtKPXzBqbseO/fxxOyN7LLAW9vw7v5ACioYTUQ8sPdZveNY1upYMYhl
         /LwSO4t6BOI7dFzqSBo3KytZYtI+eG9wTrqf2VLTsRrHjQVxgo3rLeMBbXbbiX+X8i+q
         Hlyfq9gVEq6cBZqntiVRNGgvoyAJ+w90MsqFoP66+yB/1lZlQpF9rOgceocYEUxA5ErS
         vMQxqxry8OrnFCKSX7RlyeHRDlu8zglgKGki9quehQ+wlVBHebVsYA40IZerjgbtJNAz
         JrMn25BsMPij2w2dYotwXaOmAnZbKEj+7PhsuNiQGeloqygnfW0YU1mpeFv65rnrqbZo
         vmJw==
X-Gm-Message-State: AO0yUKW1lXQL7YKZ7i1FB7IJnkrVtnNC1l6jzKY5P6xrohxpXdUn2XE0
        DlbAvmRcPEgqE9S380Je95azoJ99f40=
X-Google-Smtp-Source: AK7set8iIMWyAri9EshtiTDWXBaWL9NSpleWEiPLjzMnEVW2menzF6QSdzHsUFfuexnWl/MJf86Lcg==
X-Received: by 2002:a5d:5042:0:b0:2cd:bc79:5444 with SMTP id h2-20020a5d5042000000b002cdbc795444mr18840549wrt.2.1678526356142;
        Sat, 11 Mar 2023 01:19:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d488f000000b002c559843748sm1982907wrq.10.2023.03.11.01.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 01:19:15 -0800 (PST)
Message-Id: <pull.1466.git.git.1678526355280.gitgitgadget@gmail.com>
From:   "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Mar 2023 09:19:15 +0000
Subject: [PATCH] ls-files: document that pathspecs are supported
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Adam Johnson <me@adamj.eu>,
        Adam Johnson <me@adamj.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Johnson <me@adamj.eu>

The command has taken pathspecs, not just filenames, since f0096c06bcd
(Convert read_tree{,_recursive} to support struct pathspec, 2011-03-25).

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    ls-files: document that pathspecs are supported
    
    The command has taken pathspecs, not just filenames, since f0096c06bcd
    (Convert read_tree{,_recursive} to support struct pathspec, 2011-03-25).
    
    Signed-off-by: Adam Johnson me@adamj.eu

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1466%2Fadamchainz%2Fdoc-ls-files-pathspecs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1466/adamchainz/doc-ls-files-pathspecs-v1
Pull-Request: https://github.com/git/git/pull/1466

 Documentation/git-ls-files.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 1abdd3c21c5..2f62374062c 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -21,7 +21,7 @@ SYNOPSIS
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--recurse-submodules]
-		[--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
+		[--abbrev[=<n>]] [--format=<format>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -127,12 +127,12 @@ OPTIONS
 	in each directory, and the user's global exclusion file.
 
 --error-unmatch::
-	If any <file> does not appear in the index, treat this as an
+	If any <pathspec> does not appear in the index, treat this as an
 	error (return 1).
 
 --with-tree=<tree-ish>::
 	When using --error-unmatch to expand the user supplied
-	<file> (i.e. path pattern) arguments to paths, pretend
+	<pathspec> (i.e. path pattern) arguments to paths, pretend
 	that paths which were removed in the index since the
 	named <tree-ish> are still present.  Using this option
 	with `-s` or `-u` options does not make any sense.
@@ -225,9 +225,12 @@ followed by the  ("attr/<eolattr>").
 \--::
 	Do not interpret any more arguments as options.
 
-<file>::
+<pathspec>::
 	Files to show. If no files are given all files which match the other
 	specified criteria are shown.
++
+For details on the <pathspec> syntax, see the 'pathspec' entry in
+linkgit:gitglossary[7].
 
 OUTPUT
 ------

base-commit: 725f57037d81e24eacfda6e59a19c60c0b4c8062
-- 
gitgitgadget
