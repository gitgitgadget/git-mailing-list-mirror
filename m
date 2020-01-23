Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C5C32771
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 02:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF96F24125
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 02:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFAS7zk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgAWCQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:16:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39084 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWCQz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 21:16:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so877239wmj.4
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 18:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=prOL1sPudInOJPkRC2BDU+C5wKyhDd6HEI0etWAp6b0=;
        b=PFAS7zk3WhewAWpsd8/eh8EYQMAkoXwtUHVGVuXu923ib2HBe/IhUo9+q1obTCrFLh
         ze8jGdeFZ8Aq+u/5PkZEwhYirzlv0jAF0rfmMxibINgktANKIJgyyrfVPBqrpRRckl5C
         FFUCc+D/i2ZHaobnngzzuUvfJmOyWJv8Eoh2CivrUUL7RQaTu2l9PTH3ikohYAaMKVLi
         cBhreV19BC0NmdvDCcMShgx2l0ohuPwPtXtD5PwhLlFYyYrqWqjWDaqLdJjALQwTuriN
         0DSVugrt7K0gMXTuUsrWDMiN69XFauaG+8IsKbvXO20DQE1YLxjWHcUFsufaglMG7LAS
         pkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=prOL1sPudInOJPkRC2BDU+C5wKyhDd6HEI0etWAp6b0=;
        b=nnLLtlziL71pCidzdPkzUc7W1Sc5WSdvOOhDgYr78/zI/gH54jgdmgBT+nt6i4ut+h
         fK/FzRlIvRYs2IdKwF2bUBGksB6wZxoGIY6DOv7yLPnsIC76e0qpKBf+BZQLWoiCvlWr
         4YuJcelEJzICSvEyH+qzRf8RXikExVZV44Abq1SctJz0e7EZuZsnrALG1HzDvymEiOGJ
         CsVf2reQWZpSIOrsCsZPLV6VU0FLZx2L/RlRzK7TZE0kQjJ7s5IM+CG3aQtADiGjLjJm
         5NzzATeEcDI11h3Fb8EUOaiQZp1Z05GvfYux5gYecvkfhhryp4Grbzo6e3N20SLAuRqD
         WYuQ==
X-Gm-Message-State: APjAAAVw9QCuWsDsFH39OWjxaxk9UDqMzRWOcevgf4s0o7Aq1ZwODzol
        ui5nlpnu/SGmq4xNYRfXhmaff8WW
X-Google-Smtp-Source: APXvYqx5yoPfikEkAi37/b2ibtEBw13t/s+nQOEmDeFl4i+TyYngM5+V0MK0WsK9t8x+xtz+bOw77A==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr1313600wmb.137.1579745812903;
        Wed, 22 Jan 2020 18:16:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm1065342wru.44.2020.01.22.18.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 18:16:52 -0800 (PST)
Message-Id: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 02:16:51 +0000
Subject: [PATCH] git: update documentation for --git-dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

git --git-dir <path> is a bit confusing and sometimes doesn't work as
the user would expect it to.

For example, if the user runs `git --git-dir=<path> status`, git
will not be able to figure out the work tree path on its own and
will assign the work tree to the user's current work directory.
When this assignment is wrong, then the output will not match the
user's expectations.

This patch updates the documentation to make it clearer.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
    [Outreachy] git: update documentation for --git-dir
    
    git --git-dir is a bit confusing and sometimes doesn't work as the user
    would expect it to.
    
    For example, if the user runs git --git-dir=<path> status, git will not
    be able to figure out the work tree path on its own and will assign the
    work tree to the user's current work directory. When this assignment is
    wrong, then the output will not match the user's expectations.
    
    This patch updates the documentation to make it clearer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-537%2FHebaWaly%2Fgit_dir_doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-537/HebaWaly/git_dir_doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/537

 Documentation/git.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b1597ac002..3b9402c742 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -110,10 +110,15 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	Do not pipe Git output into a pager.
 
 --git-dir=<path>::
-	Set the path to the repository. This can also be controlled by
-	setting the `GIT_DIR` environment variable. It can be an absolute
-	path or relative path to current working directory.
-
+	Set the path to the repository (i.e. the .git folder). This can also be
+	controlled by setting the `GIT_DIR` environment variable. It can be
+	an absolute path or relative path to current working directory.
+
+	Note that --git-dir=<path> is not the same as -C=<path>.
+	It's preferrable to set --work-tree=<path> as well when setting
+	--git-dir to make sure Git will run your command across the correct
+	work tree.
+	
 --work-tree=<path>::
 	Set the path to the working tree. It can be an absolute path
 	or a path relative to the current working directory.

base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
-- 
gitgitgadget
