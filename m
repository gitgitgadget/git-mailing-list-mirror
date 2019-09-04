Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5561F4B9
	for <e@80x24.org>; Wed,  4 Sep 2019 22:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfIDWcs (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 18:32:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37305 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfIDWcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 18:32:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so227932pgp.4
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 15:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+KTSIGsneAAJqNjXTuGIjIpv9yN9XVK+naaMAoqa74=;
        b=VaxP69oXO1PhUcldO/JABXpOtcKXtDoo3mWS/CzRtdEnU+FxsBjm+pKUKWTj/cZNdC
         bLa1mZykeWYGvT7UxhGDP5lmQG8qELxzjfYXbwut2uO3Tdrk5EnwdSknteF6HedFZ7iO
         y9/mRzx2hT750inW+fJCdJeUrMakMX5wbw/DAMMiYzTfgqkUuYaCEOvwwDGWxsVyYRiO
         0DZh9PcyW+wByeqje+RxBQnRYRcrCoSt2bA47vH+F/SpfYDcbrJWQyf2mkVqBrZ41ngL
         z8cDWmZrA8wG5BsFSUNI3AdmHWdFgTzxVqjM/O3qTlsoimS0z2EoA2G5h6p1Fn/aZknk
         aUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+KTSIGsneAAJqNjXTuGIjIpv9yN9XVK+naaMAoqa74=;
        b=Nhs3g0YTXfU0LFnaPxrEbPS+Tru0DxyzmGRGlS/P5WrzMemWPcTjKpvEgEBP+38HAp
         vsN7vL0YaMtOW88uliFBwiTFAaUrNi7BXuGP24AsxetiQzle5vIhWzcW6urTBvcGUMb2
         5UTcQWq2z9ib08TEGCXNa29eQvqbdVr/Giu+8QZdeb1TJ4G3Gy5c5TKBSw4KirxDXQgR
         ao30REJhMq196myZ8DJhlcs9MWtztqSevOUalS8iHS0tylU1UlufWIKXzeBDwGuXOgTK
         sWN82udO8CWyDSczi9lhLh/gz5ZrXRe/91+YN+wd0EOx42X7kiMNbEyaPUVc0pQefODq
         kv1Q==
X-Gm-Message-State: APjAAAWryYz/CtszQ6BGCVveIyuV5zEtj5Uq8mkHHXv/YW55tFmNY7Sp
        CVQRFdkhZXv9b4H03lg315IJxVRA
X-Google-Smtp-Source: APXvYqxNw2I10zxmxr6OHIOFINPZoVzmzRbXTYY5Pd9EW0SeIAGfnP4KX3tfvrRzEr+JB/XRKwJimw==
X-Received: by 2002:a63:561c:: with SMTP id k28mr375599pgb.143.1567636366985;
        Wed, 04 Sep 2019 15:32:46 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v12sm135898pgr.86.2019.09.04.15.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Sep 2019 15:32:45 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v6 0/3] Warn about git-filter-branch usage and avoid it
Date:   Wed,  4 Sep 2019 15:32:36 -0700
Message-Id: <20190904223239.571-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g19edb94ec2
In-Reply-To: <20190903185524.13467-1-newren@gmail.com>
References: <20190903185524.13467-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v5 (full range-diff below):
  * Dropped patch 3 (which was rebased on top of js/rebase-r-strategy and
    submitted separately)[1]
  * Updated t6006 to include both an empty commit message and a commit
    message with just a line feed
  * Made the two small tweaks Junio suggested to git-filter-branch.sh

[1] https://public-inbox.org/git/20190904214048.29331-1-newren@gmail.com/

Elijah Newren (3):
  t6006: simplify, fix, and optimize empty message test
  Recommend git-filter-repo instead of git-filter-branch
  t9902: use a non-deprecated command for testing

 Documentation/git-fast-export.txt   |   6 +-
 Documentation/git-filter-branch.txt | 273 +++++++++++++++++++++++++---
 Documentation/git-gc.txt            |  17 +-
 Documentation/git-rebase.txt        |   3 +-
 Documentation/git-replace.txt       |  10 +-
 Documentation/git-svn.txt           |  10 +-
 Documentation/githooks.txt          |  10 +-
 contrib/svn-fe/svn-fe.txt           |   4 +-
 git-filter-branch.sh                |  14 ++
 t/t6006-rev-list-format.sh          |   5 +-
 t/t9902-completion.sh               |  12 +-
 11 files changed, 296 insertions(+), 68 deletions(-)

Range-diff:
1:  ccea0e5846 ! 1:  d5370568a4 t6006: simplify and optimize empty message test
    @@ Metadata
     Author: Elijah Newren <newren@gmail.com>
     
      ## Commit message ##
    -    t6006: simplify and optimize empty message test
    +    t6006: simplify, fix, and optimize empty message test
     
         Test t6006.71 ("oneline with empty message") was creating two commits
         with simple commit messages, and then running filter-branch to rewrite
    -    the commit messages to be empty.  This test was written this way because
    -    the --allow-empty-message option to git commit did not exist at the
    -    time.  Simplify this test and avoid the need to invoke filter-branch by
    -    just using --allow-empty-message when creating the commit.
    +    the commit messages to be "empty".  This test was introduced in commit
    +    1fb5fdd25f0 ("rev-list: fix --pretty=oneline with empty message",
    +    2010-03-21) and written this way because the --allow-empty-message
    +    option to git commit did not exist at the time.
    +
    +    However, the filter-branch invocation used differed slightly from
    +    --allow-empty-message in that it would have a commit message consisting
    +    solely of a single newline, and as such was not testing what the
    +    original commit intended to test.  Since both a truly empty commit
    +    message and a commit message with a single linefeed could trigger the
    +    original bug, modify the test slightly to include an example of each.
     
         Despite only being one piece of the 71st test and there being 73 tests
         overall, this small change to just this one test speeds up the overall
    @@ t/t6006-rev-list-format.sh: test_expect_success 'reflog identity' '
     -	git commit -m "dummy" --allow-empty &&
     -	git commit -m "dummy" --allow-empty &&
     -	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
    -+	git commit --allow-empty --allow-empty-message &&
    ++	git commit --allow-empty --cleanup=verbatim -m "$LF" &&
     +	git commit --allow-empty --allow-empty-message &&
      	git rev-list --oneline HEAD >test.txt &&
      	test_line_count = 5 test.txt &&
2:  6d73135006 < -:  ---------- t3427: accelerate this test by using fast-export and fast-import
3:  2f225c8697 ! 2:  8635410b88 Recommend git-filter-repo instead of git-filter-branch
    @@ git-filter-branch.sh: set_ident () {
      	finish_ident COMMITTER
      }
      
    -+if [ -z "$FILTER_BRANCH_SQUELCH_WARNING" -a \
    -+     -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" ]; then
    ++if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
    ++then
     +	cat <<EOF
     +WARNING: git-filter-branch has a glut of gotchas generating mangled history
    -+         rewrites.  Please use an alternative filtering tool such as 'git
    -+         filter-repo' (https://github.com/newren/git-filter-repo/) instead.
    -+         See the filter-branch manual page for more details; to squelch
    -+         this warning, set FILTER_BRANCH_SQUELCH_WARNING=1.
    -+
    ++	 rewrites.  Hit Ctrl-C before proceeding to abort, then use an
    ++	 alternative filtering tool such as 'git filter-repo'
    ++	 (https://github.com/newren/git-filter-repo/) instead.  See the
    ++	 filter-branch manual page for more details; to squelch this warning,
    ++	 set FILTER_BRANCH_SQUELCH_WARNING=1.
     +EOF
    -+	sleep 5
    ++	sleep 10
    ++	printf "Proceeding with filter-branch...\n\n"
     +fi
     +
      USAGE="[--setup <command>] [--subdirectory-filter <directory>] [--env-filter <command>]
4:  048eba375b = 3:  19edb94ec2 t9902: use a non-deprecated command for testing
-- 
2.23.0.3.g19edb94ec2

