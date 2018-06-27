Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911CB1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965751AbeF0SbC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:31:02 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:36272 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754654AbeF0SbB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:31:01 -0400
Received: by mail-yw0-f202.google.com with SMTP id 202-v6so2312347ywo.3
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=UrLntyU8vdCiLFrLLBM68qXd7Vvv/9nxWUgw4yP9UmY=;
        b=LDoM9N9R4mdqZaDRB4AOgWXeNGCI3ZW3kI0gyGn6DOczxzAJqt1LHjM2WY7HOC1llt
         cvjJjFvXY9t4yfFiPY0Rt/ZQGC73UX6VlFhdtwU4n6fDt5p/T8OtoS2iyqq6dYBjqeKR
         cJuxF/mn2522NlTz4dv/200phrehHjvRKx/TgNB2siFFfN1mBMfv+Z166ZRaB/pfNxq+
         65pVYKz/KlsYAZ2/qiD9xYT73iDQtdEmINm+0w2qrLpmJ/UAHr8qm7Q6nlXp6pA1sRtz
         B4EW59kUVxjM2sooH/E9HK2wY1eaGb5OaxPkX7eOokzm/Wr6D8k6OY5BoQvfmPsXOt10
         M9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=UrLntyU8vdCiLFrLLBM68qXd7Vvv/9nxWUgw4yP9UmY=;
        b=CCBUDgFOQWXyg96tibbQcGTUavLN5ukmH/aQX/gXS9rMqpuy89zcvgS6dREajFBS/B
         x+B8UIuHgQKMVEeReX6cu3SiL6/Svtp/O+XY53i7GZGQLplItinY8v+y+6d/h4QO8Iu9
         +pL192rMWhihnQC8HUvrLqcN5DoP6+J6UoAPXtM4OzwBjEsTKTM5YOSNsvAtV1kTR8L2
         GtKJuimy2JOwbULhx8QCJSf7o86UKue1R/EfnIjkvDAvCHl6kLOvQvnstRTuGRv0gfsJ
         Aoyn33dUxHoZfrGeC4DJT837BJQ25jH/A4uCPQvGcKDiEKdcYvW7t+TeTGyB2pa7s7cV
         6+tg==
X-Gm-Message-State: APt69E1KckVg2pB90M8Dk/tt8Dp6geSAiqhToRiDXKDHVYxaSHXEQymI
        /zJIFNdQdffNeo4tMeJWKyybBhFiTGOc
X-Google-Smtp-Source: ADUXVKKZNi5QfNBJYQ71OMPpMmvsEgfu70oEM7CwDbj1TF34a30GSTQFEai/KBtFS1g1Bnu6uwcvLouBGKNH
MIME-Version: 1.0
X-Received: by 2002:a25:9848:: with SMTP id k8-v6mr1921821ybo.78.1530124261148;
 Wed, 27 Jun 2018 11:31:01 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:30:57 -0700
In-Reply-To: <20180626073001.6555-14-sunshine@sunshineco.com>
Message-Id: <20180627183057.254467-1-sbeller@google.com>
References: <20180626073001.6555-14-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH] t/lib-submodule-update: fix absorbing test
From:   Stefan Beller <sbeller@google.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        newren@gmail.com, peff@peff.net, sbeller@google.com,
        szeder@ira.uka.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

This test has been dysfunctional since it was added by 259f3ee296
(lib-submodule-update.sh: define tests for recursing into submodules,
2017-03-14), however, problems went unnoticed due to a broken &&-chain
toward the end of the test.

The test wants to verify that replacing a submodule containing a .git
directory would absorb the .git directory into the .git/modules/ of the
superproject, and then replace the working tree content with the liking of
the superproject. The check if submodule content is around is wrong as
the submodule should have been replaced by the content of the superproject.

Delete the submodule content check, which also fixes the && chain in the
test.

While at it, fix broken &&-chains in a couple neighboring tests.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

> The test wants to verify that replacing a submodule containing a .git
> directory must fail. All other "must fail" tests in this script invoke
> the supplied command as 'test_must_fail', however, this test neglects to
> do so.

In an ideal world the commands would not fail, but absorb the git directory
of the submodule. I manually tested that it is absorbed and not data from
a git directory is lost.

I would propose to replace that patch with the patch below; I hope
the wording did not add more confusion than there is already.

Thanks,
Stefan


 t/lib-submodule-update.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 1f38a85371a..e90ec790877 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -755,7 +755,7 @@ test_submodule_recursing_with_args_common() {
 			: >sub1/untrackedfile &&
 			test_must_fail $command replace_sub1_with_file &&
 			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
+			test_submodule_content sub1 origin/add_sub1 &&
 			test -f sub1/untracked_file
 		)
 	'
@@ -842,7 +842,7 @@ test_submodule_switch_recursing_with_args () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			: >sub1 &&
-			echo sub1 >.git/info/exclude
+			echo sub1 >.git/info/exclude &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -969,7 +969,6 @@ test_submodule_forced_switch_recursing_with_args () {
 			rm -rf .git/modules/sub1 &&
 			$command replace_sub1_with_directory &&
 			test_superproject_content origin/replace_sub1_with_directory &&
-			test_submodule_content sub1 origin/modify_sub1
 			test_git_directory_exists sub1
 		)
 	'
-- 
2.18.0.399.gad0ab374a1-goog

