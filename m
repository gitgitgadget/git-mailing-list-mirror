Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE171F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 03:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbeGKD7W (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 23:59:22 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:47093 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbeGKD7W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 23:59:22 -0400
Received: by mail-yb0-f194.google.com with SMTP id s14-v6so9495480ybp.13
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 20:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=urxcNSRkIjbi0as2tESNo2vdvp0eycOwEyZZ4sfhLIs=;
        b=rgyXL6MjclEIfI/d42A1gAsL26RESirH0FxkmNcWYYk3dsVXCBlHYq9p1IzbZTt64n
         Xvf9XjI+8fTzCZltSZHIInk9CAcEEkzAQ8jUxDgTHvTFf8UZRc7wQBJa9NyHcvtA46tl
         sCPFaIktxNLP25WeMjYSRugH+U0BKkx5IFyV8qY04qjTAUe285oWomq+64fRGfThzsZD
         anXi4CLFJK2w3UelgepnI0vb6VkfV2YDKIRwluWSnAAqXIJ3AzLhZfVbLP/KkZfAILKF
         B9rUwsZw7g7/81qJqIytiKKFDRgfUdCoPWlK2Tjyj+unQDIrvw5++5mN4SgK4EQOd7k7
         WCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=urxcNSRkIjbi0as2tESNo2vdvp0eycOwEyZZ4sfhLIs=;
        b=pHMQArmfqQTau8ifMbafmXNmEB4IIBo7DB4vB3wxSruZRSHi7y2DrEZxToZ7oQjmgo
         nrT90XFqYG0BbsdhFF2lcke2BjXls/A+IzVOHg/ScQSyhK47qvlEq9tyUZQdjmL9eayj
         BarJk5pDjtv3W3PK6pSiW6kd07CeR3Suk+EmuD4KBryAuPsnBmAskZzaGF0JRpAnhWWz
         6ILpuuF2FI72OSlTJGd75qaroJH3voInb1dZHiyhN1fVLtmeUqqRgw2tE3YoFfgtIDoT
         H/Smy6nxL9zJ+UVTB/90a0yccRI0Y7YsYWpUk/5GKSIiyU/GKWFqUFO9PWmmZrDnGc1S
         DXqQ==
X-Gm-Message-State: APt69E1bsRiJ9Rh2sPzPrhCXe985G0JBBWAGcm1xTdEU6KO2lv1NehDP
        CDMHWzopCy90wdqFAozkagk=
X-Google-Smtp-Source: AAOMgpfIw4zgywSlSyqW1LWGeA6TA8EsmS0BaKuCz1eABIIZHqno0RRd3N5t1L0S/riDRg9uuX3XLA==
X-Received: by 2002:a25:11ca:: with SMTP id 193-v6mr14771537ybr.176.1531281426188;
        Tue, 10 Jul 2018 20:57:06 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id a62-v6sm1938699ywf.79.2018.07.10.20.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 20:57:05 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/3] Add testcases showing suboptimal submodule/path conflict handling
Date:   Tue, 10 Jul 2018 20:56:56 -0700
Message-Id: <20180711035659.27352-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.132.g6e63b23f4
In-Reply-To: <20180707204404.7208-1-newren@gmail.com>
References: <20180707204404.7208-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series documents a few problems with submodules and merging,
first mentioned at [1].

Changes since v1 (full range-diff below):
  - Incorporate suggestions from Stefan: use test_commit and git
    submodule add (note that git submodule add means there will also
    be a .gitmodules file, so the count of tracked files goes up by
    1)
  - Explain the tests a little better
  - Test the merge --abort case a little more thoroughly.

[1] https://public-inbox.org/git/CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com/

Elijah Newren (3):
  t7405: add a file/submodule conflict
  t7405: add a directory/submodule conflict
  t7405: verify 'merge --abort' works after submodule/path conflicts

 t/t7405-submodule-merge.sh | 173 +++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

1:  44bc2a05f ! 1:  16f6622ce t7405: add a file/submodule conflict
    @@ -32,20 +32,14 @@
     +		git branch B &&
     +
     +		git checkout B &&
    -+		echo contents >path &&
    ++		echo content >path &&
     +		git add path &&
     +		git commit -m B &&
     +
     +		git checkout A &&
     +		test_create_repo path &&
    -+		(
    -+			cd path &&
    -+
    -+			echo hello >world &&
    -+			git add world &&
    -+			git commit -m "submodule"
    -+		) &&
    -+		git add path &&
    ++		test_commit -C path world &&
    ++		git submodule add ./path &&
     +		git commit -m A
     +	)
     +'
    @@ -56,16 +50,20 @@
     +		cd file-submodule &&
     +
     +		git checkout A^0 &&
    -+		test_must_fail git merge B^0 >out 2>err &&
    ++		test_must_fail git merge B^0 &&
     +
     +		git ls-files -s >out &&
    -+		test_line_count = 2 out &&
    ++		test_line_count = 3 out &&
     +		git ls-files -u >out &&
     +		test_line_count = 2 out &&
     +
     +		# path/ is still a submodule
     +		test_path_is_dir path/.git &&
     +
    ++		# There is a submodule at "path", so B:path cannot be written
    ++		# there.  We expect it to be written somewhere in the same
    ++		# directory, though, so just grep for its content in all
    ++		# files, and ignore "grep: path: Is a directory" message
     +		echo Checking if contents from B:path showed up anywhere &&
     +		grep -q content * 2>/dev/null
     +	)
2:  2fa139d3b ! 2:  31dc3bc4e t7405: add a directory/submodule conflict
    @@ -56,14 +56,8 @@
     +
     +		git checkout A &&
     +		test_create_repo path &&
    -+		(
    -+			cd path &&
    -+
    -+			echo hello >world &&
    -+			git add world &&
    -+			git commit -m "submodule"
    -+		) &&
    -+		git add path &&
    ++		test_commit -C path hello world &&
    ++		git submodule add ./path &&
     +		git commit -m A
     +	)
     +'
    @@ -77,7 +71,7 @@
     +		test_must_fail git merge B1^0 &&
     +
     +		git ls-files -s >out &&
    -+		test_line_count = 2 out &&
    ++		test_line_count = 3 out &&
     +		git ls-files -u >out &&
     +		test_line_count = 1 out &&
     +
    @@ -87,6 +81,9 @@
     +		echo Checking if contents from B1:path/file showed up &&
     +		# Would rather use grep -r, but that is GNU extension...
     +		git ls-files -co | xargs grep -q contents 2>/dev/null &&
    ++
    ++		# However, B1:path/file should NOT have shown up at path/file,
    ++		# because we should not write into the submodule
     +		test_path_is_missing path/file
     +	)
     +'
3:  b2a44bedf ! 3:  49719952b t7405: verify 'merge --abort' works after submodule/path conflicts
    @@ -39,12 +39,17 @@
     +	test_when_finished "git -C directory-submodule reset --hard" &&
     +	(
     +		cd directory-submodule &&
    -+
    -+		git checkout A^0 &&
    -+		test_must_fail git merge B2^0 >out 2>err &&
      
    ++		git checkout A^0 &&
    ++		test_must_fail git merge B2^0 &&
     +		test_path_is_file .git/MERGE_HEAD &&
    -+		git merge --abort
    ++
    ++		# merge --abort should succeed, should clear .git/MERGE_HEAD,
    ++		# and should not leave behind any conflicted files
    ++		git merge --abort &&
    ++		test_path_is_missing .git/MERGE_HEAD &&
    ++		git ls-files -u >conflicts &&
    ++		test_must_be_empty conflicts
      	)
      '
      
-- 
2.18.0.132.g6e63b23f4
