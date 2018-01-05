Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82E71F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeAEU23 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:29 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:43289 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeAEU2V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:21 -0500
Received: by mail-it0-f66.google.com with SMTP id u62so2884000ita.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ortMJYg0tVCZIR2HOzMjIxKnMn7mKtDScC1o8Vdgm0s=;
        b=pyi8o26pRoXAXNlVyfUfl9YnCKSn1VBxmxMQTp9IYVQzJT+PTLgzn4n+jX/fLF6SWc
         rflaMC8gwBdPCFuEw39BJcVLafo17O4TbcL/wPRtRwaMYdWtCBBXXLIL3e16yOV5EzJL
         WhNdElBWxsPhuu4CTXCulJc7hEN7mB3Zm6g9l3o698vtbIZ5FmkL/PyFbgxuwZu2ku16
         fVcPVHJegywhhG1qh8HurF0d+jk2Y3yUFc3L7xPAUuQfHmRcoURhPNYpNNwuzh1u3AZT
         oJ4ojP3JuvNr+xpho/l6iCI2Hzz6p/gdGtfsWuub/K65AsTeSjPZt/YJTG5wSN1QP1mz
         MnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ortMJYg0tVCZIR2HOzMjIxKnMn7mKtDScC1o8Vdgm0s=;
        b=is2+Eed2skjsej7tNhwrg2bkitYhpM2DKwOKoaCCqjrLyAqVWPw3xeMXeOneflh/1T
         hBkqKgzkr8y0sy5JQAta50XXvDPIMzNE0PfzidL4PUhHd3xeVmaTJXEwRDgBuA0+4efh
         jm1aLADL6XUMKY7Ty74WeKzQhKA5Kbc9X3xeCIHdrrEufP+Gtct8w+/Xa6ta/diW2S4j
         /iQlkT3Z3h53ux+eOQxOnm446Pb/qzg2kVqnKixUv95s3UrCizxlEEX4JPphjXfsXnXP
         cyN96j0d/W05Ohj39D3iZCE7fdPxuHXrPAenWdkX9hT7+C8pmCvy3wxazsQ2ZYSpDPAR
         6C4g==
X-Gm-Message-State: AKGB3mK39RRREzN8QNP+YC3ZzEipaOuYnCK/iyQ3V6qS9KHSXk+4PMQt
        sxbVRVz4RK0XftreNE9gAUk4cj4w
X-Google-Smtp-Source: ACJfBotF2XynS6jiVT9WsaXMfkqi3kr2XcH8Awz8H5guNqOUWltHvykF5b8LZopXlz14L6Nf8twoQQ==
X-Received: by 10.36.164.6 with SMTP id z6mr4200318ite.2.1515184099661;
        Fri, 05 Jan 2018 12:28:19 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:19 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 00/31] Add directory rename detection to git
Date:   Fri,  5 Jan 2018 12:26:40 -0800
Message-Id: <20180105202711.24311-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset introduces directory rename detection to merge-recursive.  See
  https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
for the first series (including design considerations, etc.), and follow-up
series can be found at
  https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/
  https://public-inbox.org/git/20171121080059.32304-1-newren@gmail.com/
  https://public-inbox.org/git/20171129014237.32570-1-newren@gmail.com/
  https://public-inbox.org/git/20171228041352.27880-1-newren@gmail.com/
  
Changes since v5 (full tbdiff follows below):
  * Split the first three (independent) patches off into a separate series.[1]
    Semantically, they are separate and could go in either order, but built
    with this one depending on the other series to avoid context region
    conflicts.

    [1] https://public-inbox.org/git/20180105202001.24218-1-newren@gmail.com/
    
  * Testsuite:

    * Replaced plain 'test' with functions that'd provide more
      feedback on failure; e.g. test_line_count, test_path_is_missing,
      test_path_is_file (Thanks to SZEDER Gábor for the suggestions)
      
    * Backslash escaped '^' character when found in middle of string
      being passed to test_i18ngrep (Thanks to Johannes Sixt), and
      avoided some shell globbing that somehow tripped up some old
      windows build

Elijah Newren (31):
  directory rename detection: basic testcases
  directory rename detection: directory splitting testcases
  directory rename detection: testcases to avoid taking detection too
    far
  directory rename detection: partially renamed directory
    testcase/discussion
  directory rename detection: files/directories in the way of some
    renames
  directory rename detection: testcases checking which side did the
    rename
  directory rename detection: more involved edge/corner testcases
  directory rename detection: testcases exploring possibly suboptimal
    merges
  directory rename detection: miscellaneous testcases to complete
    coverage
  directory rename detection: tests for handling overwriting untracked
    files
  directory rename detection: tests for handling overwriting dirty files
  merge-recursive: move the get_renames() function
  merge-recursive: introduce new functions to handle rename logic
  merge-recursive: fix leaks of allocated renames and diff_filepairs
  merge-recursive: make !o->detect_rename codepath more obvious
  merge-recursive: split out code for determining diff_filepairs
  merge-recursive: add a new hashmap for storing directory renames
  merge-recursive: make a helper function for cleanup for handle_renames
  merge-recursive: add get_directory_renames()
  merge-recursive: check for directory level conflicts
  merge-recursive: add a new hashmap for storing file collisions
  merge-recursive: add computation of collisions due to dir rename &
    merging
  merge-recursive: check for file level conflicts then get new name
  merge-recursive: when comparing files, don't include trees
  merge-recursive: apply necessary modifications for directory renames
  merge-recursive: avoid clobbering untracked files with directory
    renames
  merge-recursive: fix overwriting dirty files involved in renames
  merge-recursive: fix remaining directory rename + dirty overwrite
    cases
  directory rename detection: new testcases showcasing a pair of bugs
  merge-recursive: avoid spurious rename/rename conflict from dir
    renames
  merge-recursive: ensure we write updates for directory-renamed file

 merge-recursive.c                   | 1212 ++++++++++-
 merge-recursive.h                   |   17 +
 strbuf.c                            |   16 +
 strbuf.h                            |   16 +
 t/t3501-revert-cherry-pick.sh       |    2 +-
 t/t6043-merge-rename-directories.sh | 3966 +++++++++++++++++++++++++++++++++++
 t/t7607-merge-overwrite.sh          |    2 +-
 unpack-trees.c                      |    4 +-
 unpack-trees.h                      |    4 +
 9 files changed, 5124 insertions(+), 115 deletions(-)
 create mode 100755 t/t6043-merge-rename-directories.sh

 1: d95d5fffe < --:  ------- Tighten and correct a few testcases for merging and cherry-picking
 2: b177dccc2 < --:  ------- merge-recursive: fix logic ordering issue
 3: fe3de710e < --:  ------- merge-recursive: add explanation for src_entry and dst_entry
 4: 19b82b795 !  1: 2fd0812b7 directory rename detection: basic testcases
    @@ -88,18 +88,23 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:y/e/f &&
     +		git rev-parse >expect \
     +			O:z/b O:z/c B:z/d B:z/e/f &&
     +		test_cmp expect actual &&
    -+		test "$(git hash-object y/d)" = $(git rev-parse B:z/d) &&
    ++
    ++		git hash-object y/d >actual &&
    ++		git rev-parse B:z/d >expect &&
    ++		test_cmp expect actual &&
    ++
     +		test_must_fail git rev-parse HEAD:z/d &&
     +		test_must_fail git rev-parse HEAD:z/e/f &&
    -+		test ! -d z/d &&
    -+		test ! -d z/e/f
    ++		test_path_is_missing z/d &&
    ++		test_path_is_missing z/e/f
     +	)
     +'
     +
    @@ -150,7 +155,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:y/e &&
    @@ -207,7 +213,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d &&
    @@ -216,7 +223,7 @@
     +		test_cmp expect actual &&
     +		test_must_fail git rev-parse HEAD:x/d &&
     +		test_must_fail git rev-parse HEAD:z/d &&
    -+		test ! -f z/d
    ++		test_path_is_missing z/d
     +	)
     +'
     +
    @@ -276,9 +283,12 @@
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep "CONFLICT (rename/rename)" out &&
     +
    -+		test 8 -eq $(git ls-files -s | wc -l) &&
    -+		test 2 -eq $(git ls-files -u | wc -l) &&
    -+		test 3 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 8 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 2 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			:0:x/b :0:x/c :0:x/d :0:x/e :0:x/m :0:x/n &&
    @@ -293,9 +303,9 @@
     +			A:y/wham B:z/wham &&
     +		test_cmp expect actual &&
     +
    -+		test ! -f x/wham &&
    -+		test -f x/wham~HEAD &&
    -+		test -f x/wham~B^0 &&
    ++		test_path_is_missing x/wham &&
    ++		test_path_is_file x/wham~HEAD &&
    ++		test_path_is_file x/wham~B^0 &&
     +
     +		git hash-object >actual \
     +			x/wham~HEAD x/wham~B^0 &&
    @@ -350,7 +360,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/newb HEAD:y/newc HEAD:y/d &&
    @@ -415,14 +426,15 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 6 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 6 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:x/d HEAD:x/e HEAD:x/f HEAD:x/g &&
     +		git rev-parse >expect \
     +			O:z/b O:z/c O:z/d O:z/e O:z/f A:z/g &&
     +		test_cmp expect actual &&
    -+		test ! -f z/g &&
    ++		test_path_is_missing z/g &&
     +		test_must_fail git rev-parse HEAD:z/g
     +	)
     +'
 5: 831640a89 !  2: 5c697afd4 directory rename detection: directory splitting testcases
    @@ -67,17 +67,20 @@
     +		git checkout A^0 &&
     +
     +		test_must_fail git merge -s recursive B^0 >out &&
    ++		test_i18ngrep "CONFLICT.*directory rename split" out &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:w/c :0:z/d &&
     +		git rev-parse >expect \
     +			O:z/b O:z/c B:z/d &&
    -+		test_cmp expect actual &&
    -+		test_i18ngrep "CONFLICT.*directory rename split" out
    ++		test_cmp expect actual
     +	)
     +'
     +
    @@ -127,9 +130,12 @@
     +
     +		git merge -s recursive B^0 >out &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:w/c :0:x/d &&
 6: bff72c92b !  3: 2b9346df1 directory rename detection: testcases to avoid taking detection too far
    @@ -68,7 +68,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:x/d &&
    @@ -131,10 +132,15 @@
     +		git checkout A^0 &&
     +
     +		test_must_fail git merge -s recursive B^0 >out &&
    ++		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
    ++		test_i18ngrep ! CONFLICT.*rename/rename.*y/d &&
     +
    -+		test 5 -eq $(git ls-files -s | wc -l) &&
    -+		test 3 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 5 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :1:z/d :2:x/d :3:w/d &&
    @@ -142,15 +148,12 @@
     +			O:z/b O:z/c O:z/d O:z/d O:z/d &&
     +		test_cmp expect actual &&
     +
    -+		test ! -f z/d &&
    ++		test_path_is_missing z/d &&
     +		git hash-object >actual \
     +			x/d w/d &&
     +		git rev-parse >expect \
     +			O:z/d O:z/d &&
    -+		test_cmp expect actual &&
    -+
    -+		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
    -+		test_i18ngrep ! CONFLICT.*rename/rename.*y/d
    ++		test_cmp expect actual
     +	)
     +'
     +
 7: 7ee62a9da !  4: 791201822 directory rename detection: partially renamed directory testcase/discussion
    @@ -93,9 +93,12 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 5 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 0 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 5 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/e HEAD:z/f &&
 8: d5d028780 !  5: 6fc6028a7 directory rename detection: files/directories in the way of some renames
    @@ -74,20 +74,20 @@
     +		git checkout A^0 &&
     +
     +		test_must_fail git merge -s recursive B^0 >out &&
    -+
    -+		test 6 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    -+
    -+		git rev-parse >actual \
    -+			:0:y/b :0:y/c :0:y/d :0:y/e :0:z/e &&
    -+		git rev-parse >expect \
    -+			O:z/b O:z/c O:y/d A:y/e A:z/e &&
    -+		test_cmp expect actual &&
    -+
    -+		test $(git rev-parse :0:y/f) = $(git rev-parse A:z/f) &&
    -+
    -+		test_i18ngrep "CONFLICT.*implicit dir rename" out
    ++		test_i18ngrep "CONFLICT.*implicit dir rename" out &&
    ++
    ++		git ls-files -s >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
    ++
    ++		git rev-parse >actual \
    ++			:0:y/b :0:y/c :0:y/d :0:y/e :0:z/e :0:y/f &&
    ++		git rev-parse >expect \
    ++			O:z/b O:z/c O:y/d A:y/e A:z/e A:z/f &&
    ++		test_cmp expect actual
     +	)
     +'
     +
    @@ -150,9 +150,12 @@
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
     +
    -+		test 5 -eq $(git ls-files -s | wc -l) &&
    -+		test 2 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 5 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 2 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :0:y/e :2:y/d :3:y/d &&
    @@ -161,7 +164,7 @@
     +		test_cmp expect actual &&
     +
     +		test_must_fail git rev-parse :1:y/d &&
    -+		test -f y/d
    ++		test_path_is_file y/d
     +	)
     +'
     +
    @@ -228,9 +231,12 @@
     +		test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*z/d" out &&
     +		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
     +
    -+		test 9 -eq $(git ls-files -s | wc -l) &&
    -+		test 6 -eq $(git ls-files -u | wc -l) &&
    -+		test 3 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 9 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :0:y/e &&
    @@ -246,14 +252,13 @@
     +		test_cmp expect actual &&
     +
     +		git hash-object >actual \
    -+			w/d~HEAD w/d~B^0 &&
    -+		git rev-parse >expect \
    -+			O:x/d B:w/d &&
    -+		test_cmp expect actual &&
    -+		test ! -f x/d &&
    -+		test -f y/d &&
    -+		grep -q "<<<<" y/d &&  # conflict markers should be present
    -+		test $(git hash-object z/d) = $(git rev-parse O:x/d)
    ++			w/d~HEAD w/d~B^0 z/d &&
    ++		git rev-parse >expect \
    ++			O:x/d B:w/d O:x/d &&
    ++		test_cmp expect actual &&
    ++		test_path_is_missing x/d &&
    ++		test_path_is_file y/d &&
    ++		grep -q "<<<<" y/d  # conflict markers should be present
     +	)
     +'
     +
    @@ -309,9 +314,12 @@
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep "CONFLICT (file/directory).*y/d" out &&
     +
    -+		test 6 -eq $(git ls-files -s | wc -l) &&
    -+		test 1 -eq $(git ls-files -u | wc -l) &&
    -+		test 2 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 1 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 2 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :0:z/d :0:y/f :2:y/d :0:y/d/e &&
    @@ -319,7 +327,9 @@
     +			O:z/b O:z/c B:z/d B:z/f A:y/d B:y/d/e &&
     +		test_cmp expect actual &&
     +
    -+		test $(git hash-object y/d~HEAD) = $(git rev-parse A:y/d)
    ++		git hash-object y/d~HEAD >actual &&
    ++		git rev-parse A:y/d >expect &&
    ++		test_cmp expect actual
     +	)
     +'
     +
 9: 5b0f4fbdb !  6: 317d54cfc directory rename detection: testcases checking which side did the rename
    @@ -74,9 +74,12 @@
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep "CONFLICT (rename/delete).*z/c.*y/c" out &&
     +
    -+		test 2 -eq $(git ls-files -s | wc -l) &&
    -+		test 1 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 2 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 1 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :3:y/c &&
    @@ -135,9 +138,12 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 0 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:z/d &&
    @@ -194,9 +200,12 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 0 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:z/d &&
    @@ -253,9 +262,12 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 0 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:z/d &&
    @@ -313,9 +325,12 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 0 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/d &&
10: 1c539cfb6 !  7: afb942c5d directory rename detection: more involved edge/corner testcases
    @@ -87,16 +87,17 @@
     +		test_i18ngrep "CONFLICT (rename/rename).*z/b.*y/b.*w/b" out &&
     +		test_i18ngrep "CONFLICT (rename/rename).*z/c.*y/c.*x/c" out &&
     +
    -+		test 7 -eq $(git ls-files -s | wc -l) &&
    -+		test 6 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    -+
    -+		test $(git rev-parse :0:y/d) = $(git rev-parse B:z/d) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 7 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
    -+			:1:z/b :2:y/b :3:w/b :1:z/c :2:y/c :3:x/c &&
    -+		git rev-parse >expect \
    -+			O:z/b O:z/b O:z/b O:z/c O:z/c O:z/c &&
    ++			:1:z/b :2:y/b :3:w/b :1:z/c :2:y/c :3:x/c :0:y/d &&
    ++		git rev-parse >expect \
    ++			O:z/b O:z/b O:z/b O:z/c O:z/c O:z/c B:z/d &&
     +		test_cmp expect actual &&
     +
     +		git hash-object >actual \
    @@ -157,9 +158,12 @@
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep "CONFLICT (rename/rename)" out &&
     +
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    -+		test 2 -eq $(git ls-files -u | wc -l) &&
    -+		test 3 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 2 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :2:y/d :3:y/d &&
    @@ -167,9 +171,9 @@
     +			O:z/b O:z/c O:w/d O:x/d &&
     +		test_cmp expect actual &&
     +
    -+		test ! -f y/d &&
    -+		test -f y/d~HEAD &&
    -+		test -f y/d~B^0 &&
    ++		test_path_is_missing y/d &&
    ++		test_path_is_file y/d~HEAD &&
    ++		test_path_is_file y/d~B^0 &&
     +
     +		git hash-object >actual \
     +			y/d~HEAD y/d~B^0 &&
    @@ -230,9 +234,12 @@
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*y/d" out &&
     +
    -+		test 5 -eq $(git ls-files -s | wc -l) &&
    -+		test 3 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 5 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :1:x/d :2:w/d :3:y/d &&
    @@ -291,9 +298,12 @@
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 1 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 1 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :3:y/d &&
    @@ -378,9 +388,12 @@
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
     +
    -+		test 5 -eq $(git ls-files -s | wc -l) &&
    -+		test 1 -eq $(git ls-files -u | wc -l) &&
    -+		test 2 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 5 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 1 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 2 out &&
     +
     +		git rev-parse >actual \
     +			:0:x/d/f :0:y/d/g :0:y/b :0:y/c :3:y/d &&
    @@ -388,7 +401,9 @@
     +			A:x/d/f A:y/d/g O:z/b O:z/c O:x/d &&
     +		test_cmp expect actual &&
     +
    -+		test $(git hash-object y/d~B^0) = $(git rev-parse O:x/d)
    ++		git hash-object y/d~B^0 >actual &&
    ++		git rev-parse O:x/d >expect &&
    ++		test_cmp expect actual
     +	)
     +'
     +
11: 4238c6484 !  8: 157559cea directory rename detection: testcases exploring possibly suboptimal merges
    @@ -82,9 +82,12 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 6 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 0 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/a HEAD:y/b HEAD:y/e HEAD:y/f HEAD:z/c HEAD:z/d &&
    @@ -157,9 +160,12 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 6 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 0 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/a HEAD:y/b HEAD:z/a HEAD:z/b HEAD:x/e HEAD:y/e &&
    @@ -222,9 +228,12 @@
     +		test_must_fail git merge -s recursive B^0 >out &&
     +		test_i18ngrep "CONFLICT (rename/delete).* z/d.*y/d" out &&
     +
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    -+		test 1 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 1 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/b :0:y/c :0:y/e :3:y/d &&
    @@ -235,7 +244,7 @@
     +		test_must_fail git rev-parse :1:y/d &&
     +		test_must_fail git rev-parse :2:y/d &&
     +		git ls-files -s y/d | grep ^100755 &&
    -+		test -f y/d
    ++		test_path_is_file y/d
     +	)
     +'
     +
    @@ -305,7 +314,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/e &&
    @@ -378,17 +388,20 @@
     +		git checkout A^0 &&
     +
     +		test_must_fail git merge -s recursive B^0 >out 2>err &&
    -+
    -+		test 7 -eq $(git ls-files -s | wc -l) &&
    -+		test 6 -eq $(git ls-files -u | wc -l) &&
    -+		test 2 -eq $(git ls-files -o | wc -l) &&
    -+
    -+		test $(git rev-parse :0:y/d) = $(git rev-parse B:z/d) &&
    ++		test_i18ngrep CONFLICT.*rename/rename.*z/c.*y/c.*w/c out &&
    ++		test_i18ngrep CONFLICT.*rename/rename.*z/b.*y/b.*w/b out &&
    ++
    ++		git ls-files -s >out &&
    ++		test_line_count = 7 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 2 out &&
     +
     +		git rev-parse >actual \
    -+			:1:z/b :2:y/b :3:w/b :1:z/c :2:y/c :3:w/c &&
    -+		git rev-parse >expect \
    -+			O:z/b O:z/b O:z/b O:z/c O:z/c O:z/c &&
    ++			:1:z/b :2:y/b :3:w/b :1:z/c :2:y/c :3:w/c :0:y/d &&
    ++		git rev-parse >expect \
    ++			O:z/b O:z/b O:z/b O:z/c O:z/c O:z/c B:z/d &&
     +		test_cmp expect actual &&
     +
     +		git hash-object >actual \
    @@ -397,11 +410,8 @@
     +			O:z/b O:z/b O:z/c O:z/c &&
     +		test_cmp expect actual &&
     +
    -+		test ! -f z/b &&
    -+		test ! -f z/c &&
    -+
    -+		test_i18ngrep CONFLICT.*rename/rename.*z/c.*y/c.*w/c out &&
    -+		test_i18ngrep CONFLICT.*rename/rename.*z/b.*y/b.*w/b out
    ++		test_path_is_missing z/b &&
    ++		test_path_is_missing z/c
     +	)
     +'
     +
12: 48a546a06 !  9: e9f563a34 directory rename detection: miscellaneous testcases to complete coverage
    @@ -95,9 +95,12 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 7 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 0 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 7 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/i &&
    @@ -162,9 +165,11 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
     +
     +		test_seq 0 11 >expected &&
    ++		test_cmp expected y/d &&
     +		git add expected &&
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d &&
    @@ -173,12 +178,11 @@
     +		test_cmp expect actual &&
     +		test_must_fail git rev-parse HEAD:x/d &&
     +		test_must_fail git rev-parse HEAD:z/d &&
    -+		test ! -f z/d &&
    ++		test_path_is_missing z/d &&
     +
     +		test $(git rev-parse HEAD:y/d) != $(git rev-parse O:x/d) &&
     +		test $(git rev-parse HEAD:y/d) != $(git rev-parse A:x/d) &&
    -+		test $(git rev-parse HEAD:y/d) != $(git rev-parse B:z/d) &&
    -+		test_cmp expected y/d
    ++		test $(git rev-parse HEAD:y/d) != $(git rev-parse B:z/d)
     +	)
     +'
     +
    @@ -252,8 +256,10 @@
     +		git merge -s recursive B^0 >out &&
     +		test_i18ngrep "WARNING: Avoiding applying x -> z rename to x/f" out &&
     +
    -+		test 6 -eq $(git ls-files -s | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:y/d HEAD:y/e HEAD:x/f HEAD:x/g &&
    @@ -341,8 +347,10 @@
     +		test_i18ngrep "WARNING: Avoiding applying x -> w rename to x/b" out &&
     +		test_i18ngrep "WARNING: Avoiding applying w -> v rename to w/c" out &&
     +
    -+		test 7 -eq $(git ls-files -s | wc -l) &&
    -+		test 1 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 7 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 1 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:z/t HEAD:y/a HEAD:x/b HEAD:w/c HEAD:u/d HEAD:u/e HEAD:u/f &&
    @@ -418,9 +426,12 @@
     +		grep -q dir3/yo error_line &&
     +		grep -q dirN/yo error_line &&
     +
    -+		test 16 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 2 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 16 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 2 out &&
     +
     +		git rev-parse >actual \
     +			:0:combined/a :0:combined/b :0:combined/c \
    @@ -488,7 +499,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:priority/a/foo HEAD:priority/b/bar HEAD:priority/b/baz HEAD:priority/c &&
    @@ -548,7 +560,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:priority/alpha/foo HEAD:priority/beta/bar HEAD:priority/beta/baz HEAD:priority/c &&
13: bc8a45699 ! 10: 0c6630551 directory rename detection: tests for handling overwriting untracked files
    @@ -68,12 +68,20 @@
     +		test_must_fail git merge -s recursive B^0 >out 2>err &&
     +		test_i18ngrep "The following untracked working tree files would be overwritten by merge" err &&
     +
    -+		test 1 -eq $(git ls-files -s | wc -l) &&
    -+		test 4 -eq $(git ls-files -o | wc -l) &&
    -+
    -+		test "very" = "$(cat z/c)" &&
    -+		test "important" = "$(cat z/d)" &&
    -+		test $(git rev-parse HEAD:z/b) = $(git rev-parse O:z/b)
    ++		git ls-files -s >out &&
    ++		test_line_count = 1 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 4 out &&
    ++
    ++		echo very >expect &&
    ++		test_cmp expect z/c &&
    ++
    ++		echo important >expect &&
    ++		test_cmp expect z/d &&
    ++
    ++		git rev-parse HEAD:z/b >actual &&
    ++		git rev-parse O:z/b >expect &&
    ++		test_cmp expect actual
     +	)
     +'
     +
    @@ -126,23 +134,30 @@
     +		echo contents >y/e &&
     +
     +		test_must_fail git merge -s recursive B^0 >out 2>err &&
    -+		test_i18ngrep "CONFLICT (rename/delete).*Version B^0 of y/d left in tree at y/d~B^0" out &&
    -+		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B^0 instead" out &&
    -+
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 2 -eq $(git ls-files -u | wc -l) &&
    -+		test 5 -eq $(git ls-files -o | wc -l) &&
    -+
    -+		test $(git rev-parse :0:y/b) = $(git rev-parse O:z/b) &&
    -+		test "very" = "$(cat y/c)" &&
    -+
    -+		test "important" = "$(cat y/d)" &&
    -+		test "important" != "$(git rev-parse :3:y/d)" &&
    -+		test $(git rev-parse :3:y/d) = $(git rev-parse O:z/c) &&
    -+
    -+		test "contents" = "$(cat y/e)" &&
    -+		test "contents" != "$(git rev-parse :3:y/e)" &&
    -+		test $(git rev-parse :3:y/e) = $(git rev-parse B:z/e)
    ++		test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree at y/d~B\^0" out &&
    ++		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B\^0 instead" out &&
    ++
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 2 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 5 out &&
    ++
    ++		git rev-parse >actual \
    ++			:0:y/b :3:y/d :3:y/e &&
    ++		git rev-parse >expect \
    ++			O:z/b O:z/c B:z/e &&
    ++		test_cmp expect actual &&
    ++
    ++		echo very >expect &&
    ++		test_cmp expect y/c &&
    ++
    ++		echo important >expect &&
    ++		test_cmp expect y/d &&
    ++
    ++		echo contents >expect &&
    ++		test_cmp expect y/e
     +	)
     +'
     +
    @@ -196,11 +211,14 @@
     +
     +		test_must_fail git merge -s recursive B^0 >out 2>err &&
     +		test_i18ngrep "CONFLICT (rename/rename)" out &&
    -+		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B^0 instead" out &&
    -+
    -+		test 6 -eq $(git ls-files -s | wc -l) &&
    -+		test 3 -eq $(git ls-files -u | wc -l) &&
    -+		test 3 -eq $(git ls-files -o | wc -l) &&
    ++		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B\^0 instead" out &&
    ++
    ++		git ls-files -s >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :3:y/c &&
    @@ -208,9 +226,12 @@
     +			O:z/a O:z/b O:x/d O:x/c O:x/c O:x/c &&
     +		test_cmp expect actual &&
     +
    -+		test "important" = "$(cat y/c)" &&
    -+		test "important" != "$(git rev-parse :3:y/c)" &&
    -+		test $(git hash-object y/c~B^0) = $(git rev-parse O:x/c)
    ++		git hash-object y/c~B^0 >actual &&
    ++		git rev-parse O:x/c >expect &&
    ++		test_cmp expect actual &&
    ++
    ++		echo important >expect &&
    ++		test_cmp expect y/c
     +	)
     +'
     +
    @@ -267,9 +288,12 @@
     +		test_i18ngrep "CONFLICT (rename/rename)" out &&
     +		test_i18ngrep "Refusing to lose untracked file at y/wham" out &&
     +
    -+		test 6 -eq $(git ls-files -s | wc -l) &&
    -+		test 2 -eq $(git ls-files -u | wc -l) &&
    -+		test 4 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 6 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 2 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
    @@ -279,7 +303,9 @@
     +
     +		test_must_fail git rev-parse :1:y/wham &&
     +
    -+		test "important" = "$(cat y/wham)" &&
    ++		echo important >expect &&
    ++		test_cmp expect y/wham &&
    ++
     +		git hash-object >actual \
     +			y/wham~B^0 y/wham~HEAD &&
     +		git rev-parse >expect \
    @@ -334,9 +360,12 @@
     +		git merge -s recursive B^0 >out 2>err &&
     +		test_i18ngrep ! "following untracked working tree files would be overwritten by merge" err &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 3 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :0:y/c &&
    @@ -344,7 +373,8 @@
     +			O:z/a O:z/b B:z/c &&
     +		test_cmp expect actual &&
     +
    -+		test "random" = "$(cat z/c)"
    ++		echo random >expect &&
    ++		test_cmp expect z/c
     +	)
     +'
     +
14: a94077d10 ! 11: 16cd375e1 directory rename detection: tests for handling overwriting dirty files
    @@ -75,10 +75,14 @@
     +
     +		test_seq 1 10 >expected &&
     +		echo stuff >>expected &&
    -+
    -+		test 2 -eq $(git ls-files -s | wc -l) &&
    -+		test 1 -eq $(git ls-files -u | wc -l) &&
    -+		test 4 -eq $(git ls-files -o | wc -l) &&
    ++		test_cmp expected z/c &&
    ++
    ++		git ls-files -s >out &&
    ++		test_line_count = 2 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 1 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
     +			:0:z/a :2:z/c &&
    @@ -86,8 +90,9 @@
     +			O:z/a B:z/b &&
     +		test_cmp expect actual &&
     +
    -+		test "$(git hash-object z/c~HEAD)" = $(git rev-parse B:z/b) &&
    -+		test_cmp expected z/c
    ++		git hash-object z/c~HEAD >actual &&
    ++		git rev-parse B:z/b >expect &&
    ++		test_cmp expect actual
     +	)
     +'
     +
    @@ -140,14 +145,19 @@
     +		git merge -s recursive B^0 >out 2>err &&
     +		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
     +
    -+		grep -q stuff */* &&
    ++		grep -q stuff z/c &&
     +		test_seq 1 10 >expected &&
     +		echo stuff >>expected &&
    -+
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 0 -eq $(git ls-files -m | wc -l) &&
    -+		test 4 -eq $(git ls-files -o | wc -l) &&
    ++		test_cmp expected z/c &&
    ++
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -m >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
     +			:0:x/b :0:y/a :0:y/c &&
    @@ -155,8 +165,9 @@
     +			O:x/b O:z/a B:x/c &&
     +		test_cmp expect actual &&
     +
    -+		test "$(git hash-object y/c)" = $(git rev-parse B:x/c) &&
    -+		test_cmp expected z/c
    ++		git hash-object y/c >actual &&
    ++		git rev-parse B:x/c >expect &&
    ++		test_cmp expect actual
     +	)
     +'
     +
    @@ -209,17 +220,19 @@
     +		test_must_fail git merge -s recursive B^0 >out 2>err &&
     +		test_i18ngrep "following files would be overwritten by merge" err &&
     +
    -+		grep -q stuff */* &&
    ++		grep -q stuff y/c &&
     +		test_seq 1 10 >expected &&
     +		echo stuff >>expected &&
    -+
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    -+		test 0 -eq $(git ls-files -u | wc -l) &&
    -+		test 1 -eq $(git ls-files -m | wc -l) &&
    -+		test 3 -eq $(git ls-files -o | wc -l) &&
    -+
    -+		test $(git rev-parse HEAD) = $(git rev-parse A) &&
    -+		test_cmp expected y/c
    ++		test_cmp expected y/c &&
    ++
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 0 out &&
    ++		git ls-files -m >out &&
    ++		test_line_count = 1 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 3 out
     +	)
     +'
     +
    @@ -274,13 +287,17 @@
     +		test_must_fail git merge -s recursive B^0 >out 2>err &&
     +		test_i18ngrep "Refusing to lose dirty file at z/c" out &&
     +
    -+		grep -q stuff */* &&
    ++		grep -q stuff z/c &&
     +		test_seq 1 10 >expected &&
     +		echo stuff >>expected &&
    -+
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    -+		test 1 -eq $(git ls-files -u | wc -l) &&
    -+		test 5 -eq $(git ls-files -o | wc -l) &&
    ++		test_cmp expected z/c
    ++
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 1 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 5 out &&
     +
     +		git rev-parse >actual \
     +			:0:x/b :0:y/a :0:y/c/d :3:y/c &&
    @@ -288,8 +305,9 @@
     +			O:x/b O:z/a B:y/c/d B:x/c &&
     +		test_cmp expect actual &&
     +
    -+		test "$(git hash-object y/c~HEAD)" = $(git rev-parse B:x/c) &&
    -+		test_cmp expected z/c
    ++		git hash-object y/c~HEAD >actual &&
    ++		git rev-parse B:x/c >expect &&
    ++		test_cmp expect actual
     +	)
     +'
     +
    @@ -349,12 +367,16 @@
     +		test_i18ngrep "CONFLICT (rename/rename)" out &&
     +		test_i18ngrep "Refusing to lose dirty file at y/c" out &&
     +
    -+		test 7 -eq $(git ls-files -s | wc -l) &&
    -+		test 4 -eq $(git ls-files -u | wc -l) &&
    -+		test 4 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 7 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 4 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 4 out &&
     +
     +		echo different >expected &&
     +		echo mods >>expected &&
    ++		test_cmp expected y/c &&
     +
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :2:y/c :3:y/c &&
    @@ -366,9 +388,7 @@
     +			y/c~B^0 y/c~HEAD &&
     +		git rev-parse >expect \
     +			O:x/c A:y/c &&
    -+		test_cmp expect actual &&
    -+
    -+		test_cmp expected y/c
    ++		test_cmp expect actual
     +	)
     +'
     +
    @@ -423,26 +443,28 @@
     +		test_i18ngrep "CONFLICT (rename/rename)" out &&
     +		test_i18ngrep "Refusing to lose dirty file at y/wham" out &&
     +
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    -+		test 2 -eq $(git ls-files -u | wc -l) &&
    -+		test 4 -eq $(git ls-files -o | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 2 out &&
    ++		git ls-files -o >out &&
    ++		test_line_count = 4 out &&
     +
     +		test_seq 1 10 >expected &&
     +		echo important >>expected &&
    ++		test_cmp expected y/wham &&
    ++
    ++		test_must_fail git rev-parse :1:y/wham &&
    ++		git hash-object >actual \
    ++			y/wham~B^0 y/wham~HEAD &&
    ++		git rev-parse >expect \
    ++			O:x/d O:x/c &&
    ++		test_cmp expect actual &&
     +
     +		git rev-parse >actual \
     +			:0:y/a :0:y/b :2:y/wham :3:y/wham &&
     +		git rev-parse >expect \
     +			O:z/a O:z/b O:x/c O:x/d &&
    -+		test_cmp expect actual &&
    -+
    -+		test_must_fail git rev-parse :1:y/wham &&
    -+
    -+		test_cmp expected y/wham &&
    -+		git hash-object >actual \
    -+			y/wham~B^0 y/wham~HEAD &&
    -+		git rev-parse >expect \
    -+			O:x/d O:x/c &&
     +		test_cmp expect actual
     +	)
     +'
15: 30aafc85e = 12: b7f4530bc merge-recursive: move the get_renames() function
16: 6b29a765f = 13: 45c39bb87 merge-recursive: introduce new functions to handle rename logic
17: 53c57eff7 = 14: 21b30fe2d merge-recursive: fix leaks of allocated renames and diff_filepairs
18: 5385b6762 = 15: bad89d217 merge-recursive: make !o->detect_rename codepath more obvious
19: 1f913d37d = 16: 67eec195a merge-recursive: split out code for determining diff_filepairs
20: b59f7fbe4 = 17: 288e3987a merge-recursive: add a new hashmap for storing directory renames
21: f7e14522c = 18: c2d58b3a2 merge-recursive: make a helper function for cleanup for handle_renames
22: 35393dfe0 = 19: 1dcf48227 merge-recursive: add get_directory_renames()
23: 5dcb73fe9 = 20: 968effeaf merge-recursive: check for directory level conflicts
24: f61aaf7b5 = 21: 865b98f6b merge-recursive: add a new hashmap for storing file collisions
25: 8fc5e978b = 22: f74e41c56 merge-recursive: add computation of collisions due to dir rename & merging
26: cc0ebb2e0 = 23: 6678bf2ca merge-recursive: check for file level conflicts then get new name
27: 505eeda52 = 24: 8dd2a045c merge-recursive: when comparing files, don't include trees
28: c884f8427 = 25: 30341f655 merge-recursive: apply necessary modifications for directory renames
29: dc11ea741 = 26: 498cb775f merge-recursive: avoid clobbering untracked files with directory renames
30: 0b5d46643 = 27: 81d5073ab merge-recursive: fix overwriting dirty files involved in renames
31: f20983a6a = 28: 3a2e99fe7 merge-recursive: fix remaining directory rename + dirty overwrite cases
32: 12aa1972a ! 29: e93a1b89e directory rename detection: new testcases showcasing a pair of bugs
    @@ -80,7 +80,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 3 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 3 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:y/b HEAD:y/c HEAD:x/d &&
    @@ -151,7 +152,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 6 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 6 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:node1/leaf1 HEAD:node1/leaf2 HEAD:node1/leaf5 HEAD:node1/node2/leaf3 HEAD:node1/node2/leaf4 HEAD:node1/node2/leaf6 &&
    @@ -220,7 +222,8 @@
     +
     +		git merge -s recursive B^0 &&
     +
    -+		test 4 -eq $(git ls-files -s | wc -l) &&
    ++		git ls-files -s >out &&
    ++		test_line_count = 4 out &&
     +
     +		git rev-parse >actual \
     +			HEAD:node1/node2/node1/leaf1 \
    @@ -287,7 +290,8 @@
     +
     +		test_must_fail git merge -s recursive B^0 &&
     +
    -+		test 12 -eq $(git ls-files -u | wc -l) &&
    ++		git ls-files -u >out &&
    ++		test_line_count = 12 out &&
     +
     +		git rev-parse >actual \
     +			:1:node1/node2/node1/leaf1 \
33: 5530b0af9 ! 30: d77d0d85b merge-recursive: avoid spurious rename/rename conflict from dir renames
    @@ -85,11 +85,14 @@
     -		test_i18ngrep "CONFLICT (rename/delete).* z/d.*y/d" out &&
     +		test_i18ngrep "CONFLICT (modify/delete).* z/d" out &&
      
    --		test 4 -eq $(git ls-files -s | wc -l) &&
    --		test 1 -eq $(git ls-files -u | wc -l) &&
    -+		test 5 -eq $(git ls-files -s | wc -l) &&
    -+		test 2 -eq $(git ls-files -u | wc -l) &&
    - 		test 1 -eq $(git ls-files -o | wc -l) &&
    + 		git ls-files -s >out &&
    +-		test_line_count = 4 out &&
    ++		test_line_count = 5 out &&
    + 		git ls-files -u >out &&
    +-		test_line_count = 1 out &&
    ++		test_line_count = 2 out &&
    + 		git ls-files -o >out &&
    + 		test_line_count = 1 out &&
      
      		git rev-parse >actual \
     -			:0:y/b :0:y/c :0:y/e :3:y/d &&
    @@ -102,11 +105,11 @@
     -		test_must_fail git rev-parse :1:y/d &&
     -		test_must_fail git rev-parse :2:y/d &&
     -		git ls-files -s y/d | grep ^100755 &&
    --		test -f y/d
    +-		test_path_is_file y/d
     +		test_must_fail git rev-parse :2:z/d &&
     +		git ls-files -s z/d | grep ^100755 &&
    -+		test -f z/d &&
    -+		! test -f y/d
    ++		test_path_is_file z/d &&
    ++		test_path_is_missing y/d
      	)
      '
      
34: 8e199d483 = 31: c7ed5a213 merge-recursive: ensure we write updates for directory-renamed file

-- 
2.14.2
