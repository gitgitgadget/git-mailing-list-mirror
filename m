Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F8C2BB55
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D052051A
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgJCqt7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgDIOyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:54:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38915 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgDIOyY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 10:54:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id a43so26950edf.6
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZEgxQG+yfxgwHcF+UZxAWhYd8JKzsL4olQzfOqSePss=;
        b=AgJCqt7FCHy3oTbvk7H3Y1caUvOblGIqHUDJCO/O6ngw5yFSFiJidn25n0bMcnss6A
         D3mmkvSjxUNF7AiztSZlZee6i6EXhqtLkfP1tHAOQUz2fmkPtzugVYttC6hMmV6XaxfT
         HdszmjUecA23Ed8SurNxcOcatsMuEnlHoaMrIo7C5vCGICA01S07y+fuP4Uo4YQVjUV8
         1v60hlI5PPkuf/OUZkG9pn04Jdx+YwoXqDKqjoiXjyI0mdeN2BmfqdW2MeTZ3C/ZFwA+
         Tv90mhPpQk+YAvc4YHzS0eaecGXzytiEz3REjBw2ICBvlDPPp50IQl9VJfm+CX8EAhH4
         XkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZEgxQG+yfxgwHcF+UZxAWhYd8JKzsL4olQzfOqSePss=;
        b=AwXQ8isYuto8uoseArC8YYtWC5x6oJzFF7fC3avm3eY/3VM39HFB+3dcycv99SqXD/
         HKk/1Ib3oU5GnEcrfjhxLjitoJSj97Hm+TUDaYv0WGL0KwUoqnEbJ+0I/jAxI1D2vfxt
         L7o1f/AD+wCnoJclfVMtN7YL/axYIrfGnPPZ2WOE57QjkVsmJ9ub+AbsN/efhxmD8k2D
         oHgYEeJOYSwf1ilwxtuqFPcwCaD3sjFF7Pf/wq2Zg0UIa7j3beCqAPMnMmcnV6vYrajc
         ICWd5XzwJ9DkadcEMyp1B8o+00i6OqHrSk0/608+rUBcANS9/uiuZkOqxh+4WChfHEOx
         qLDg==
X-Gm-Message-State: AGi0Pua6wBHNtJjWzmz6pdC+dGy7ubjPBOfMsj0qCRvlz+nFGfBjoXwc
        6qMYI40aiqFvg8IIevUqyIkKYEUM
X-Google-Smtp-Source: APiQypKJ14thlC4+p0HRz1mVTak/9cpysaG09qlwo8uE5h0VqmM0KwO0GHuyn3wGJJ76ZtC/dPkDAw==
X-Received: by 2002:a50:9d83:: with SMTP id w3mr376557ede.23.1586444062658;
        Thu, 09 Apr 2020 07:54:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b99sm556319edf.28.2020.04.09.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 07:54:22 -0700 (PDT)
Message-Id: <pull.595.v2.git.1586444061576.gitgitgadget@gmail.com>
In-Reply-To: <pull.595.git.1585588586605.gitgitgadget@gmail.com>
References: <pull.595.git.1585588586605.gitgitgadget@gmail.com>
From:   "Allo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 14:54:21 +0000
Subject: [PATCH v2] t4200-rerere.sh: use test_path_is_* functions in the
 script
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

The original code works fine. However, since the code base has already had help-functions(in test-lib-functions),
the change is able to help people understand the code better, as well as improve debug-friendliness.

* t4200-rerere.sh: replace "test -d" with "test_path_is_dir"
* t4200-rerere.sh: replace "test -f" with "test_path_is_file"

Signed-off-by: Angel Pan <dinoallosaurus1111@gmail.com>
---
    [GSoC/PATCH] t4200-rerere.sh: use test_path_is_* functions in the script
    
    Hello again. I thought I needed to improve my commit message since some
    of community members friendly reminded me last week. So I revised it
    again. Here is my patch with new commit message. If there is still
    something I miss, a reminder will be appreciated.
    
    Signed-off-by: Angel Pan dinoallosaurus1111@gmail.com
    [dinoallosaurus1111@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-595%2Fdinoallo%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-595/dinoallo/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/595

Range-diff vs v1:

 1:  7e0c8749016 ! 1:  c704627a465 t4200-rerere.sh: use test_path_is_* functions in the script
     @@ Metadata
       ## Commit message ##
          t4200-rerere.sh: use test_path_is_* functions in the script
      
     -    This is a microproject for GSoC.
     -    The original code works fine. However, since the code base has already have help-functions(in test-lib-functions),
     +    The original code works fine. However, since the code base has already had help-functions(in test-lib-functions),
          the change is able to help people understand the code better, as well as improve debug-friendliness.
      
     +    * t4200-rerere.sh: replace "test -d" with "test_path_is_dir"
     +    * t4200-rerere.sh: replace "test -f" with "test_path_is_file"
     +
          Signed-off-by: Angel Pan <dinoallosaurus1111@gmail.com>
      
       ## t/t4200-rerere.sh ##


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
