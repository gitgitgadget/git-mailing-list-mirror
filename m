Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CDEC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiGUIQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiGUIQl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479447D79E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so394443wmj.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wOGAeuZYYD1ywCQx5iNnhf8S8m5LJhjzC4NvFsDfZec=;
        b=gB5t0o8ALLbBnzufumDxXNxnc87DscrghDDMXJpMvOniJj35XEDmkdzt+f/GXEc34F
         udh+pMXZcwNYRN7GQvu8DYkHbhIM9cVysKFPeJBzVKYvvVnlzkhoDlAVPlx+ow+M36hp
         2jzT4I4gcjYMV9gz6fr8p6KasApNJb1IO+5BZi/29Mhgd+kLmvnYVnrklfPvHbnT2pLF
         67Q5VMj2hMa4/NjaCNIFuxDP2bi+1xtHx26lEOGNrF0jW/sn/JobA806OdvrHsxOBZmu
         s3IfSvQ/RZCaufb/AT/ANBRdvbsx8OsobMKfSNkB+TRGTYN1rlyhDK2XthUzhatBJ1ae
         RSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wOGAeuZYYD1ywCQx5iNnhf8S8m5LJhjzC4NvFsDfZec=;
        b=Ju4dr/QieLwikAu8ib+iY0qVNz1a8KWr9cmJt/ZSBwMkjFFLDjWoKhAJ1Oj/DcuUgK
         Z2zWs9XDZtTlul5ZFjOBhzfh8M/25e4YtC24XWmYVG4R1vrnvQ9HMdV4+OJUIQduWYkp
         HclziLNEztgW4b/RgSG0RySGWtiftGTbSZuoqhJFqFjEFv1CfFRhf6ZYZ7RJ1fR68hYL
         npY79FTK8S1JPSorgKZhJs2PGWEImr0zDSZcdYjNTLbzn2//eMNiL+BWsvXQ4TM8RiVB
         xjq0H1+cGibW9Bb256+4bgpqrLJczp1xCuRfvnWi5crW+rh2FD6G2g8HYeonadvb5LKF
         YAzw==
X-Gm-Message-State: AJIora9NkdP19o9dPgM0se/2kdggczRLJ2aFswpFe8pEp/ma8AoQBBSB
        qCWSztbRFKHdIszglpVlmFsPKZVMg2o=
X-Google-Smtp-Source: AGRyM1sYeU6O97GoSQsyv5Yz3FV7R07JQKSdSxlu3hzP9prUCQrxnJX1mkpIlOmuGwTrJXUjSTHpQw==
X-Received: by 2002:a05:600c:19d2:b0:3a3:2cdb:cc02 with SMTP id u18-20020a05600c19d200b003a32cdbcc02mr4697298wmq.182.1658391398485;
        Thu, 21 Jul 2022 01:16:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b003a02cbf862esm1037646wmq.13.2022.07.21.01.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:16:37 -0700 (PDT)
Message-Id: <b41853e3f9908ab458bcb28684d817677e32367b.1658391391.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 08:16:27 +0000
Subject: [PATCH v3 3/7] merge: do not abort early if one strategy fails to
 handle the merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

builtin/merge is setup to allow multiple strategies to be specified,
and it will find the "best" result and use it.  This is defeated if
some of the merge strategies abort early when they cannot handle the
merge.  Fix the logic that calls recursive and ort to not do such an
early abort, but instead return "2" or "unhandled" so that the next
strategy can try to handle the merge.

Coming up with a testcase for this is somewhat difficult, since
recursive and ort both handle nearly any two-headed merge (there is
a separate code path that checks for non-two-headed merges and
already returns "2" for them).  So use a somewhat synthetic testcase
of having the index not match HEAD before the merge starts, since all
merge strategies will abort for that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          |  6 ++++--
 t/t6402-merge-rename.sh                  |  2 +-
 t/t6424-merge-unrelated-index-changes.sh | 16 ++++++++++++++++
 t/t6439-merge-co-error-msgs.sh           |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 13884b8e836..dec7375bf2a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -754,8 +754,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		else
 			clean = merge_recursive(&o, head, remoteheads->item,
 						reversed, &result);
-		if (clean < 0)
-			exit(128);
+		if (clean < 0) {
+			rollback_lock_file(&lock);
+			return 2;
+		}
 		if (write_locked_index(&the_index, &lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 3a32b1a45cf..772238e582c 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -210,7 +210,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	echo >>M one line addition &&
 	cat M >M.saved &&
 	git update-index M &&
-	test_expect_code 128 git pull --no-rebase . yellow &&
+	test_expect_code 2 git pull --no-rebase . yellow &&
 	test_cmp M M.saved &&
 	rm -f M.saved
 '
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index f35d3182b86..8b749e19083 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -268,4 +268,20 @@ test_expect_success 'subtree' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success 'resolve && recursive && ort' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	test_seq 0 10 >a &&
+	git add a &&
+
+	sane_unset GIT_TEST_MERGE_ALGORITHM &&
+	test_must_fail git merge -s resolve -s recursive -s ort C^0 >output 2>&1 &&
+
+	grep "Trying merge strategy resolve..." output &&
+	grep "Trying merge strategy recursive..." output &&
+	grep "Trying merge strategy ort..." output &&
+	grep "No merge strategy handled the merge." output
+'
+
 test_done
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 5bfb027099a..52cf0c87690 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -47,6 +47,7 @@ test_expect_success 'untracked files overwritten by merge (fast and non-fast for
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge branch 2>out2
 	) &&
+	echo "Merge with strategy ${GIT_TEST_MERGE_ALGORITHM:-ort} failed." >>expect &&
 	test_cmp out2 expect &&
 	git reset --hard HEAD^
 '
-- 
gitgitgadget

