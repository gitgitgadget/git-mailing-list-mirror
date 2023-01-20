Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3548FC677F1
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 05:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjATFKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjATFJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 00:09:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A6DAD0D
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 20:57:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso3545561wmn.5
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 20:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG2fsggN8wDiVnrwGKOdGZ6+7PVulG5ei5eEDDusoRg=;
        b=Qybw8XBdRRgsZrDo+Bxz7YzrJCy4kmvAWEq4RxrBFVd4Ddn9DIbA2EQh6Tjvwx8127
         OyU1+qcrvbz8vOj30qzvHYWtst7+IOBIp+Vq58ozncXQuiV7ULL3ItJMZ9caIJ1BXIEn
         VWl3LC9LePRugrbG1P/DcZgyxO4yvVmWiYKKzG6J+cZnmb8dmWb4C6JryGd4J47IETEr
         PP8JZT3gZHX2ftkhqgSY2K03v80XgW9Y9h7ZYBgwnPlp1S9OnpAwlIdItYeXFIaEHmQ1
         FV6OBEEJVcrSopa3FieqWJo/w7G+eX2ySdpTYN/Y/DbHb1C1yL6QV6EQQ0NaiyBwH2Gm
         pQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG2fsggN8wDiVnrwGKOdGZ6+7PVulG5ei5eEDDusoRg=;
        b=Pqt3Ga9ezHxy7dCNy2nTkd2/Ps3rn/QUpfhf+p80/bcSW43W7cv41lBYkpHzUz/7Q3
         Tak+Xx8F8feuL0mCb1yPJ3zpP20bA65cktv2Skfi4BIgCIKYTjThquJafvhYhdiDgyyO
         1Vf9gs4t8AVH6Q8pu90rOIwPUcB3HEueNeHsYRhMhprYyAKnlk/xlWEVbJ4FI1bl/9dw
         YgYNuehGuTlbtDoPHDJ2CgJiF96GKaOnP0WxrW0aZYFscHD46SRqiKAAAe+8MSzn6Q4V
         G+kwatdjbw1RmAwrClDWnzTz27AxClHakLT/y7dW2b4NUiAmZ7aqT/DsOvM2VL9pCgUP
         Ptzw==
X-Gm-Message-State: AFqh2kp5BQL7rzdMQ/bXsZy+e/mLUXN8Q7rWzM1GA++dD1lDDRgxvTo8
        vZoszDDUm3Y8YFzhBxhjgyCfdKkq4JA=
X-Google-Smtp-Source: AMrXdXv/TAHKRjnt5RMCzHwl9Vf7gx6rjrJjewYWI33DPwcuCEgJZkC8eTv73LdJrFpqaOe+WMmcFQ==
X-Received: by 2002:a05:600c:4687:b0:3db:2e06:4091 with SMTP id p7-20020a05600c468700b003db2e064091mr1983256wmo.37.1674190577273;
        Thu, 19 Jan 2023 20:56:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fm17-20020a05600c0c1100b003db06224953sm1194229wmb.41.2023.01.19.20.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 20:56:16 -0800 (PST)
Message-Id: <2e44d0b7e571cfac2a25d00f3fe3d143c895793b.1674190573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
        <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 04:56:13 +0000
Subject: [PATCH v2 2/2] rebase: mark --update-refs as requiring the merge
 backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--update-refs is built in terms of the sequencer, which requires the
merge backend.  It was already marked as incompatible with the apply
backend in the git-rebase manual, but the code didn't check for this
incompatibility and warn the user.  Check and warn now.

While at it, fix a typo in t3422...and fix some misleading wording (all
useful options other than --whitespace=fix have long since been
implemented in the merge backend).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c                       |  3 +++
 t/t3422-rebase-incompatible-options.sh | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ace8bd4a41c..e8bcdbf9fcd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1507,6 +1507,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (options.update_refs)
+		imply_merge(&options, "--update-refs");
+
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
 			imply_merge(&options, "--merge");
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index ebcbd79ab8a..d72c863b21b 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -25,11 +25,11 @@ test_expect_success 'setup' '
 '
 
 #
-# Rebase has lots of useful options like --whitepsace=fix, which are
-# actually all built in terms of flags to git-am.  Since neither
-# --merge nor --interactive (nor any options that imply those two) use
-# git-am, using them together will result in flags like --whitespace=fix
-# being ignored.  Make sure rebase warns the user and aborts instead.
+# Rebase has a useful option, --whitespace=fix, which is actually
+# built in terms of flags to git-am.  Since neither --merge nor
+# --interactive (nor any options that imply those two) use git-am,
+# using them together will result in --whitespace=fix being ignored.
+# Make sure rebase warns the user and aborts instead.
 #
 
 test_rebase_am_only () {
@@ -60,6 +60,11 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --exec 'true' A
 	"
 
+	test_expect_success "$opt incompatible with --update-refs" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --update-refs A
+	"
+
 }
 
 test_rebase_am_only --whitespace=fix
-- 
gitgitgadget
