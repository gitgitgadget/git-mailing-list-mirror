Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64910C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE756103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhI0QgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhI0Qfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A687C061772
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso485361wme.0
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5lP2C1cPbEMfe/VUNzBw0385qhXCQ10cKlGFDXXepgs=;
        b=Y8Qp/MLhw2ZS4iohD5h9LACjWc00Agjf5gK7cqNj5qZkV/qzuyaMlaepAhsCxKm48w
         LPO35XRaUjX53PgARf/8G3cbVr9f9KhcGjqk5/kKnh5c0aMjNFQqVoOiw2WUyLZB5+/S
         Y+WtGpYq507wWf4CiWmKrXILEvMHDdaoyQJFN26to7oqSTs9Zc0X+hhjl7JFmBFS9/Nm
         64W1zy2X49wb+rK09MCVUcJ7I4R6USH3uVsOP5oV+zmXyLcvibYtbknktAqqIRFywf9/
         4XOg5qbST/x6S2hckeVqfEFO3aJd1crd6PabtQNWNhIfraSIkTlIx+P+QgrhSvI7E9iN
         sEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5lP2C1cPbEMfe/VUNzBw0385qhXCQ10cKlGFDXXepgs=;
        b=Jcxg6nom6GMgq3CBz81PbvPqV4m24+ck24jh087T+LQERbW3X8RswH9JGS81GwPk4V
         V7ZzyZeuxJSAP01JL3/LKYn696gVf2rfJBOja8MST4YbnUFzS4XguXeMmyVzDtjxXzOx
         l5BLL569lTuJ/cZlX6BWSNsppKemtRfrD+T5EJ+B0B9KYz71aQfV2NKF8tybOJ/M1Qxi
         jiyrMdQ1TW3X21pFGbkBs+QZV61001aQ/RAZp90xtmRP9c9fH32Oz5MexPo6bSUMnmT1
         lAnIvlF4/1ePN+sutwKb4uzJAswd+SKmv1m9bRkjfs/JDLlBoHwBpD3i8VJ0s8o3SB7m
         3Lyw==
X-Gm-Message-State: AOAM530Zd1nZJLNvnsaRAZR097ul9JVsRx7w5dTMA9lJoUWnfLBSOns2
        DOnPyImptovsRHCSpeIKI8uz+CMzWtk=
X-Google-Smtp-Source: ABdhPJwx87xUVBvjVZhucTxc6BoeR29Y3PxdCTaLcpAU3bxMkqinbhlzsron5v1Oo69vyRhQYN4a1w==
X-Received: by 2002:a1c:d4:: with SMTP id 203mr11706902wma.87.1632760435768;
        Mon, 27 Sep 2021 09:33:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm7644526wro.34.2021.09.27.09.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:55 -0700 (PDT)
Message-Id: <de416f887d7ce24f20ad3ad4cc838394d6523635.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:48 +0000
Subject: [PATCH v3 11/11] Documentation: call out commands that nuke untracked
 files/directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Some commands have traditionally also removed untracked files (or
directories) that were in the way of a tracked file we needed.  Document
these cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-checkout.txt  | 5 +++--
 Documentation/git-read-tree.txt | 5 +++--
 Documentation/git-reset.txt     | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe44997..d473c9bf387 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -118,8 +118,9 @@ OPTIONS
 -f::
 --force::
 	When switching branches, proceed even if the index or the
-	working tree differs from `HEAD`.  This is used to throw away
-	local changes.
+	working tree differs from `HEAD`, and even if there are untracked
+	files in the way.  This is used to throw away local changes and
+	any untracked files or directories that are in the way.
 +
 When checking out paths from the index, do not fail upon unmerged
 entries; instead, unmerged entries are ignored.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 0222a27c5af..8c3aceb8324 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -38,8 +38,9 @@ OPTIONS
 
 --reset::
 	Same as -m, except that unmerged entries are discarded instead
-	of failing. When used with `-u`, updates leading to loss of
-	working tree changes will not abort the operation.
+	of failing.  When used with `-u`, updates leading to loss of
+	working tree changes or untracked files or directories will not
+	abort the operation.
 
 -u::
 	After a successful merge, update the files in the work
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 252e2d4e47d..6f7685f53d5 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -69,7 +69,8 @@ linkgit:git-add[1]).
 
 --hard::
 	Resets the index and working tree. Any changes to tracked files in the
-	working tree since `<commit>` are discarded.
+	working tree since `<commit>` are discarded.  Any untracked files or
+	directories in the way of writing any tracked files are simply deleted.
 
 --merge::
 	Resets the index and updates the files in the working tree that are
-- 
gitgitgadget
