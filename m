Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE135C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760B120781
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNzjCXfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgC3RQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:16:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40843 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgC3RQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 13:16:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id w26so21655662edu.7
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fUWECkDdeFwhmCGm4BQXuN5J5gjD+nIyTDFHxbOPZFQ=;
        b=UNzjCXfQEAbiNDqYXr66bulzjTgiWLVuK9xRl+H22aK7OMrhBh0Jw2W8sfaQymOArU
         PyVoK5PzR3gY1wxCyY6+9BWJLpiV28apNd3YzTvl10F/aP2xBWc4mBvrsIZo71FfKbVR
         ywAae9yh0rIYfeCS/U5XjjuvZFzq70TBGojwFLQYGwJ2kqzK2TLhL7xd+94GOSomNyAS
         twcPTW/lk0OHG0U5ZEV5fFIp1XrqBCaz4z9haTaLtgyHG+j1JVRcGMkqRqDdKXMVR1jr
         lQyvp3snb/SO2gjJv3vF4VamsmSAJJ5342i1zjy0iL3ujA8pSKKca8OYAfqVaSC8PolZ
         YjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fUWECkDdeFwhmCGm4BQXuN5J5gjD+nIyTDFHxbOPZFQ=;
        b=pJgegpw+Jx5Nps99O6LHwJCqkLj/6m/nU1Y6O/npP1fhVdndHix3aUGiTtyCVnA0Qz
         Qynu8uYgZY37ZvDlT1fexPt7dkqSyPwEeoZpK+fzMBznp2H+xNkLIDKKhc/smMV1hpFL
         AwnNnK2XKa045l09LFKk/mBI9yFSQB4WtjfUpZp39UQZsvbwgEKHICbHRwEXfRCFmq4c
         +jJQ2LgNOjILs/aWu84G/jfQ5sDjfyZ31XaKscamxX/WcIGcG1Jg1XSLCXPjSfqyXplh
         Undvy53MfdUPAjdk/tSMvWE7z52RgvtVO5QxlZSbFXstDFLH55z6pocj6idHKFAKGd1x
         mmsg==
X-Gm-Message-State: ANhLgQ0lzeBjslWG+Lsn2h11uOzhbRdf/vWNyeg97bxMrykUnAiAWCDb
        W+qb2EBcsJjn8qKinvjrizT3fLv4
X-Google-Smtp-Source: ADFU+vsRB3Tla1fCELyeg8vDwrexLdFM0mVWZHsPWuGp9191X4YV++GLlCgTTa8YuMepm9wlG3ISpw==
X-Received: by 2002:a50:84a9:: with SMTP id 38mr11465046edq.262.1585588587769;
        Mon, 30 Mar 2020 10:16:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19sm1789658ejh.58.2020.03.30.10.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:16:27 -0700 (PDT)
Message-Id: <pull.595.git.1585588586605.gitgitgadget@gmail.com>
From:   "Allo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 17:16:26 +0000
Subject: [PATCH] t4200-rerere.sh: use test_path_is_* functions in the script
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Allo <dinoallosaurus1111@gmail.com>,
        Angel Pan <dinoallosaurus1111@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Angel Pan <dinoallosaurus1111@gmail.com>

This is a microproject for GSoC.
The original code works fine. However, since the code base has already have help-functions(in test-lib-functions),
the change is able to help people understand the code better, as well as improve debug-friendliness.

Signed-off-by: Angel Pan <dinoallosaurus1111@gmail.com>
---
    [GSoC/PATCH] t4200-rerere.sh: use test_path_is_* functions in the script
    
    Hello again. I have sent a mail here: last mail
    [https://lore.kernel.org/git/CAFk=nY7efz8ZisEuyAcU09J+ja4qE8LorUUPeupGVEjBBc6HDA@mail.gmail.com/T/#u]
    After all, I decided to replace test -(e|f|d) with test_path_is_*
    functions as my microproject for GSoC. I am looking forward to working
    with every contributor here. I also have another question: For a commit
    like this involving 10+ insertions, would it be better if I
    seperate-commited all of them? But this kind of change seems trivial...
    
    Signed-off-by: Angel Pan dinoallosaurus1111@gmail.com
    [dinoallosaurus1111@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-595%2Fdinoallo%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-595/dinoallo/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/595

 t/t4200-rerere.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 831d424c472..da8be1c6254 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -70,7 +70,7 @@ test_expect_success 'nothing recorded without rerere' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled false &&
 	test_must_fail git merge first &&
-	! test -d .git/rr-cache
+	! test_path_is_dir .git/rr-cache
 '
 
 test_expect_success 'activate rerere, old style (conflicting merge)' '
@@ -82,8 +82,8 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
 	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep "^=======\$" $rr/preimage &&
-	! test -f $rr/postimage &&
-	! test -f $rr/thisimage
+	! test_path_is_file $rr/postimage &&
+	! test_path_is_file $rr/thisimage
 '
 
 test_expect_success 'rerere.enabled works, too' '
@@ -108,8 +108,8 @@ test_expect_success 'set up rr-cache' '
 
 test_expect_success 'rr-cache looks sane' '
 	# no postimage or thisimage yet
-	! test -f $rr/postimage &&
-	! test -f $rr/thisimage &&
+	! test_path_is_file $rr/postimage &&
+	! test_path_is_file $rr/thisimage &&
 
 	# preimage has right number of lines
 	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
@@ -165,7 +165,7 @@ test_expect_success 'first postimage wins' '
 	git show first:a1 | sed "s/To die: t/To die! T/" >expect &&
 
 	git commit -q -a -m "prefer first over second" &&
-	test -f $rr/postimage &&
+	test_path_is_file $rr/postimage &&
 
 	oldmtimepost=$(test-tool chmtime --get -60 $rr/postimage) &&
 
@@ -188,14 +188,14 @@ test_expect_success 'rerere clear' '
 	mv $rr/postimage .git/post-saved &&
 	echo "$sha1	a1" | perl -pe "y/\012/\000/" >.git/MERGE_RR &&
 	git rerere clear &&
-	! test -d $rr
+	! test_path_is_dir $rr
 '
 
 test_expect_success 'leftover directory' '
 	git reset --hard &&
 	mkdir -p $rr &&
 	test_must_fail git merge first &&
-	test -f $rr/preimage
+	test_path_is_file $rr/preimage
 '
 
 test_expect_success 'missing preimage' '
@@ -203,7 +203,7 @@ test_expect_success 'missing preimage' '
 	mkdir -p $rr &&
 	cp .git/post-saved $rr/postimage &&
 	test_must_fail git merge first &&
-	test -f $rr/preimage
+	test_path_is_file $rr/preimage
 '
 
 test_expect_success 'set up for garbage collection tests' '
@@ -228,16 +228,16 @@ test_expect_success 'set up for garbage collection tests' '
 
 test_expect_success 'gc preserves young or recently used records' '
 	git rerere gc &&
-	test -f $rr/preimage &&
-	test -f $rr2/preimage
+	test_path_is_file $rr/preimage &&
+	test_path_is_file $rr2/preimage
 '
 
 test_expect_success 'old records rest in peace' '
 	test-tool chmtime =$just_over_60_days_ago $rr/postimage &&
 	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
 	git rerere gc &&
-	! test -f $rr/preimage &&
-	! test -f $rr2/preimage
+	! test_path_is_file $rr/preimage &&
+	! test_path_is_file $rr2/preimage
 '
 
 rerere_gc_custom_expiry_test () {

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
