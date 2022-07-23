Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0E4C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiGWBx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiGWBxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC274795
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so6121030wmb.5
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MypplCpsyA0RCBKsYZ9G7TvpGX99JF/cC1HHk0jqvmk=;
        b=iYqXyEY7KxwlqLYbsZ/hvk5IAs1Sc0/be2uM6IW4nmAyaAJmx2Q7eBoSzjNsXSWt79
         n7878oL7h7nFFp16Kkvi/RnV/aeNJBf1rRuU9eRhjwdqtjrYffdfCt4B/SLsixRlNSHG
         q/jlWRq/BLmHnV5Ee6HODua3/eWtOeYnWpzu5njfnkYwNNxVQjRd7YAQQTCpjK3J1JDH
         mhg0cHBhqzDfV+HLi+K411ZdrNG1wWiyp7MpPBRzdl6JuR+UFeXFHGurk3BGpJtyiCj9
         /pNCIpxkYgK8M059VkP8XqCxw1fBNX5i0YFl4IkJXBmi7nm62nGC1E+ePgUgf7LC86Cc
         MOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MypplCpsyA0RCBKsYZ9G7TvpGX99JF/cC1HHk0jqvmk=;
        b=aLzhh3RzcIT1kFApeanUJDQejgoMhH9mJdqWgvZ+D4mC5w1Mk24pP9D2Jn8h+aqxur
         E5IB406IJp8GNXyU+MDQIkdx5Gd9EqQrVgcYl4hp7TOH1D95Xg9TaoTS5N3QubuZDP1S
         cOHyO7A47WxDvRi1vxPo8bOMRSTDKEX9AVKlPbXCwF9CXa4BjleglFvA0oj5YcIlY490
         Z6aSNRojxOwhpcMLM5SFm2wW/jF266EocD4axNXnuQP9zzZp7yGqzdAYT5SEV+2jtcze
         LG9S/DHJaguWWVaZnIrNG0t56tfVCwxLaiHi3TYWfmrIbU9hhstLEg4k/SlAiZT8o2AW
         jIlw==
X-Gm-Message-State: AJIora/UzdKM2Qm+iG2lWva97B5ilgZjxW78AKROzLBTgLULaPel+DHL
        KlXlbo92RvAqPyPxGyVmYcZmNwW3b+0=
X-Google-Smtp-Source: AGRyM1t6OIZ89/VTfztOYGCLhNcIjPddZi+9v0CwzYlXMWREcFs++v9pZTFP5d/w7XIBt+jqoB6SkQ==
X-Received: by 2002:a05:600c:22c1:b0:3a3:170a:7ae1 with SMTP id 1-20020a05600c22c100b003a3170a7ae1mr14198756wmg.192.1658541201894;
        Fri, 22 Jul 2022 18:53:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t21-20020a1c7715000000b003a331c6bffdsm5931876wmi.47.2022.07.22.18.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:21 -0700 (PDT)
Message-Id: <b656756fd37405114eec67d642ab8a02a9b90bbb.1658541198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
        <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 01:53:12 +0000
Subject: [PATCH v5 2/8] merge-resolve: abort if index does not match HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in commit 9822175d2b ("Ensure index matches head before
invoking merge machinery, round N", 2019-08-17), we have had a very
long history of problems with failing to enforce the requirement that
index matches HEAD when starting a merge.  One of the commits
referenced in the long tale of issues arising from lax enforcement of
this requirement was commit 55f39cf755 ("merge: fix misleading
pre-merge check documentation", 2018-06-30), which tried to document
the requirement and noted there were some exceptions.  As mentioned in
that commit message, the `resolve` strategy was the one strategy that
did not have an explicit index matching HEAD check, and the reason it
didn't was that I wasn't able to discover any cases where the
implementation would fail to catch the problem and abort, and didn't
want to introduce unnecessary performance overhead of adding another
check.

Well, today I discovered a testcase where the implementation does not
catch the problem and so an explicit check is needed.  Add a testcase
that previously would have failed, and update git-merge-resolve.sh to
have an explicit check.  Note that the code is copied from 3ec62ad9ff
("merge-octopus: abort if index does not match HEAD", 2016-04-09), so
that we reuse the same message and avoid making translators need to
translate some new message.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-merge-resolve.sh                     | 10 ++++++++++
 t/t6424-merge-unrelated-index-changes.sh | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
index 343fe7bccd0..77e93121bf8 100755
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -5,6 +5,16 @@
 #
 # Resolve two trees, using enhanced multi-base read-tree.
 
+. git-sh-setup
+
+# Abort if index does not match HEAD
+if ! git diff-index --quiet --cached HEAD --
+then
+    gettextln "Error: Your local changes to the following files would be overwritten by merge"
+    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
+    exit 2
+fi
+
 # The first parameters up to -- are merge bases; the rest are heads.
 bases= head= remotes= sep_seen=
 for arg
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index b6e424a427b..eabe6bda832 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -114,6 +114,19 @@ test_expect_success 'resolve, non-trivial' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success 'resolve, non-trivial, related file removed' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git rm a &&
+	test_path_is_missing a &&
+
+	test_must_fail git merge -s resolve D^0 &&
+
+	test_path_is_missing a &&
+	test_path_is_missing .git/MERGE_HEAD
+'
+
 test_expect_success 'recursive' '
 	git reset --hard &&
 	git checkout B^0 &&
-- 
gitgitgadget

