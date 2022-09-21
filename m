Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C57ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 13:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIUNC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiIUNC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 09:02:56 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8738C45C
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 06:02:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c7so5853590pgt.11
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7YjedklGD6Sh9BAO6exDZ621WSHaIwPO2vr/GeLK2Ks=;
        b=BMZe2UfJfLW9muMCMC2yI88FK0GZDiKGmiJmnD/Yd/qiTlbO9wwHGKVBead+BgvZVT
         x/7n0d5dyCsid4YgPWZoS6gilcGRUCWvaHz0Ku7Xt5OFfSY5Ivl1EHSwsfT3lprg8iJA
         A0647Xp0m5kQx6aANAQCD6XWrmxGaG5Y4nLyXk3jq+p4TvELEiA3z4BNyTsZ4lcQDEcu
         j72XxXDbiuGeTGZYuw+kdu7z3gCcQir17JlMoM6ByQ3P46ME1ZPrScauWAY/IzXZD0Ez
         PJtbQvpxfzAUcZ49tpvgLN+Nx+fOoqBGZF4Yv8sGZN2YZ8lGsT4qEPnwd4pb3iezCeZ8
         wimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7YjedklGD6Sh9BAO6exDZ621WSHaIwPO2vr/GeLK2Ks=;
        b=1sJ4W8JCoVHINxYXlgTrMBWBNT4L/569BFUCO1UUc8EFTF8xA22nn01ME/AUCRfRdD
         pE73eTUvMfBfRExDsc8tBcE5E/d2GcTGAZKM+oskqhaVUIvPwlWKTlClu6QrDY0qcGSP
         jd0uTZH5VT5L3z6BcSCWf5AzNetYSlcCJx3lPxVELRot3eitAfOKJCsKJSaovFsBV99p
         et57yLyA76xxpIossxH9Bi+EzwpQ01iZyYL7b8BV7jQbVaAHy8inKphpx2+Sr3pHUDYt
         7q1YRpGDHMxdi9UpauImYx9We01GWMovmdaVF4Vclz/o8eBmVtoWoYArq5oPHzl5IjT3
         w0mw==
X-Gm-Message-State: ACrzQf3Z1isS4Q+1lyyQl2ZRGPXiKFe1MhIJByRWE79YcSq/kPS87Ln7
        o2tZsHVkNSZXkuG6LKVqaald5bs6hQE=
X-Google-Smtp-Source: AMsMyM6Ccg6lgddFBaLseV5goqAB6jPqZwASKllY/VzhOT3P0ZEaL1TyojmhMZWs5xSO1TZ5pc7x8A==
X-Received: by 2002:a63:7b09:0:b0:43b:ed4a:d71a with SMTP id w9-20020a637b09000000b0043bed4ad71amr1699519pgc.257.1663765374008;
        Wed, 21 Sep 2022 06:02:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:5008:db00:84c8:158c:9494:ee57])
        by smtp.gmail.com with ESMTPSA id i64-20020a625443000000b0053e5daf1a25sm2084332pfb.45.2022.09.21.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 06:02:52 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] allow "grep -E", remove {e,f}grep usage
Date:   Wed, 21 Sep 2022 20:02:28 +0700
Message-Id: <cover.1663765176.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our CodingGuidelines says that we should avoid "grep -E" and/or 
"grep \{m,n\}". However they're still in use and noone has
complained, yet.

In addition, GNU grep 3.8 started to warn about the continuation
of deprecation process for egrep and fgrep.

This series aim to allow "grep -E" and replace {e,f}grep usage with
"grep -{E,F}"

While there're idea to lift the restriction for \{m,n\}, too.
Their usage are limited and could be replaced with other alternatives.
Let's skip them for now.

Change from v1:
- Change wording in 2/4
- Change regex in 2/4 to be more readable
- Remove '-F' from some regex in 4/4 when the regex doesn't have any special
  characters

Đoàn Trần Công Danh (4):
  CodingGuidelines: allow grep -E
  t: remove \{m,n\} from BRE grep usage
  t: convert egrep usage to "grep -E"
  t: convert fgrep usage to "grep -F"

 Documentation/CodingGuidelines       |  2 --
 t/perf/run                           |  4 ++--
 t/t1304-default-acl.sh               |  4 ++--
 t/t3200-branch.sh                    |  4 ++--
 t/t3305-notes-fanout.sh              |  2 +-
 t/t3404-rebase-interactive.sh        |  6 +++---
 t/t3700-add.sh                       |  2 +-
 t/t3702-add-edit.sh                  |  2 +-
 t/t4014-format-patch.sh              |  8 ++++----
 t/t5320-delta-islands.sh             |  2 +-
 t/t5550-http-fetch-dumb.sh           |  2 +-
 t/t5702-protocol-v2.sh               |  2 +-
 t/t7003-filter-branch.sh             |  4 ++--
 t/t7527-builtin-fsmonitor.sh         | 18 +++++++++---------
 t/t7701-repack-unpack-unreachable.sh |  4 ++--
 t/t9001-send-email.sh                |  8 ++++----
 t/t9133-git-svn-nested-git-repo.sh   |  6 +++---
 t/t9134-git-svn-ignore-paths.sh      |  8 ++++----
 t/t9140-git-svn-reset.sh             |  4 ++--
 t/t9147-git-svn-include-paths.sh     |  8 ++++----
 t/t9814-git-p4-rename.sh             |  2 +-
 t/t9815-git-p4-submit-fail.sh        |  4 ++--
 t/test-lib-functions.sh              |  2 +-
 23 files changed, 53 insertions(+), 55 deletions(-)

Range-diff against v1:
1:  a8dadaf2d1 = 1:  4ad1ac9d9b CodingGuidelines: allow grep -E
2:  9d5fcda278 ! 2:  ebaf6cec07 t: remove \{m,n\} from BRE grep usage
    @@ Metadata
      ## Commit message ##
         t: remove \{m,n\} from BRE grep usage
     
    -    \{m,n\} is a GNU extension to BRE, and it's forbidden by our
    -    CodingGuidelines.
    +    The CodingGuidelines says we should avoid \{m,n\} in BRE usage.
    +    And their usages in our code base is limited, and subjectively
    +    hard to read.
     
    -    Change to fixed strings or ERE.
    +    Replace them with ERE.
    +
    +    Except for "0\{40\}" which would be changed to "$ZERO_OID",
    +    which is a better value for testing with:
    +    GIT_TEST_DEFAULT_HASH=sha256
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    @@ t/t3200-branch.sh: test_expect_success 'git branch -M baz bam should succeed whe
      	msg="Branch: renamed refs/heads/baz to refs/heads/bam" &&
     -	grep " 0\{40\}.*$msg$" .git/logs/HEAD &&
     -	grep "^0\{40\}.*$msg$" .git/logs/HEAD
    -+	zero="00000000" &&
    -+	zero="$zero$zero$zero$zero$zero" &&
    -+	grep " $zero.*$msg$" .git/logs/HEAD &&
    -+	grep "^$zero.*$msg$" .git/logs/HEAD
    ++	grep " $ZERO_OID.*$msg$" .git/logs/HEAD &&
    ++	grep "^$ZERO_OID.*$msg$" .git/logs/HEAD
      '
      
      test_expect_success 'git branch -M should leave orphaned HEAD alone' '
    @@ t/t3305-notes-fanout.sh: path_has_fanout() {
      	fanout=$2 &&
      	after_last_slash=$(($(test_oid hexsz) - $fanout * 2)) &&
     -	echo $path | grep -q "^\([0-9a-f]\{2\}/\)\{$fanout\}[0-9a-f]\{$after_last_slash\}$"
    -+	echo $path | grep -q -E "^([0-9a-f][0-9a-f]/){$fanout}[0-9a-f]{$after_last_slash}$"
    ++	echo $path | grep -q -E "^([0-9a-f]{2}/){$fanout}[0-9a-f]{$after_last_slash}$"
      }
      
      touched_one_note_with_fanout() {
3:  a131160033 = 3:  b7c0629603 t: convert egrep usage to "grep -E"
4:  50d009b368 ! 4:  b65a3d7749 t: convert fgrep usage to "grep -F"
    @@ t/t7003-filter-branch.sh: test_expect_success 'result is really identical' '
      	(git config core.bare true && cd .git &&
      	 git filter-branch branch > filter-output 2>&1 &&
     -	! fgrep fatal filter-output)
    -+	! grep -F fatal filter-output)
    ++	! grep fatal filter-output)
      '
      git config core.bare false
      test_expect_success 'result is really identical' '
    @@ t/t7003-filter-branch.sh: test_expect_success 'rewrite repository including refs
      	git reset --hard HEAD &&
      	git filter-branch -f -- --all >filter-output 2>&1 &&
     -	! fgrep fatal filter-output
    -+	! grep -F fatal filter-output
    ++	! grep fatal filter-output
      '
      
      test_expect_success 'filter-branch handles ref deletion' '
    @@ t/t9134-git-svn-ignore-paths.sh: test_expect_success 'init+fetch an SVN reposito
      	(
      	    cd g &&
     -	    git config --get svn-remote.svn.ignore-paths | fgrep "www"
    -+	    git config --get svn-remote.svn.ignore-paths | grep -F "www"
    ++	    git config --get svn-remote.svn.ignore-paths | grep www
      	)
      '
      
    @@ t/t9134-git-svn-ignore-paths.sh: test_expect_success 'SVN-side change outside of
      		svn_cmd commit -m "SVN-side change outside of www" &&
      		svn_cmd up &&
     -		svn_cmd log -v | fgrep "SVN-side change outside of www"
    -+		svn_cmd log -v | grep -F "SVN-side change outside of www"
    ++		svn_cmd log -v | grep "SVN-side change outside of www"
      	)
      '
      
    @@ t/t9134-git-svn-ignore-paths.sh: test_expect_success 'SVN-side change in and out
      		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
      		svn_cmd up &&
     -		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
    -+		svn_cmd log -v | grep -F "SVN-side change in and out of ignored www"
    ++		svn_cmd log -v | grep "SVN-side change in and out of ignored www"
      	)
      '
      
    @@ t/t9140-git-svn-reset.sh: test_expect_success 'fetch fails on modified hidden fi
      	  test_must_fail git svn fetch 2> ../errors &&
      	  git svn find-rev refs/remotes/git-svn > ../expect2 ) &&
     -	fgrep "not found in commit" errors &&
    -+	grep -F "not found in commit" errors &&
    ++	grep "not found in commit" errors &&
      	test_cmp expect expect2
      '
      
    @@ t/t9140-git-svn-reset.sh: test_expect_success 'refetch succeeds not ignoring any
      	  git svn fetch &&
      	  git svn rebase &&
     -	  fgrep "mod hidden" hid/hid.txt
    -+	  grep -F "mod hidden" hid/hid.txt
    ++	  grep "mod hidden" hid/hid.txt
      	)
      '
      
    @@ t/t9147-git-svn-include-paths.sh: test_expect_success 'init+fetch an SVN reposit
      	(
      	    cd g &&
     -	    git config --get svn-remote.svn.include-paths | fgrep "qqq"
    -+	    git config --get svn-remote.svn.include-paths | grep -F "qqq"
    ++	    git config --get svn-remote.svn.include-paths | grep qqq
      	)
      '
      
    @@ t/t9147-git-svn-include-paths.sh: test_expect_success 'SVN-side change outside o
      		svn_cmd commit -m "SVN-side change outside of www" &&
      		svn_cmd up &&
     -		svn_cmd log -v | fgrep "SVN-side change outside of www"
    -+		svn_cmd log -v | grep -F "SVN-side change outside of www"
    ++		svn_cmd log -v | grep "SVN-side change outside of www"
      	)
      '
      
    @@ t/t9147-git-svn-include-paths.sh: test_expect_success 'SVN-side change inside of
      		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
      		svn_cmd up &&
     -		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
    -+		svn_cmd log -v | grep -F "SVN-side change inside of www/test_www.txt"
    ++		svn_cmd log -v | grep "SVN-side change inside of www/test_www.txt"
      	)
      '
      
    @@ t/t9147-git-svn-include-paths.sh: test_expect_success 'SVN-side change in and ou
      		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
      		svn_cmd up &&
     -		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
    -+		svn_cmd log -v | grep -F "SVN-side change in and out of ignored www"
    ++		svn_cmd log -v | grep "SVN-side change in and out of ignored www"
      	)
      '
      
-- 
2.38.0.rc0

