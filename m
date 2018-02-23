Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6681F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeBWXkE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:04 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33946 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbeBWXkE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:04 -0500
Received: by mail-wr0-f170.google.com with SMTP id m5so15690141wrg.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/rUTCOwtYIu/pn/iYM8aAALF21p7zXtSuNtC+Px5a4=;
        b=b9M1BxhjUR8L+TBHBT9OCnih8TFvnkU9I27YbqlE0r9Prphkz5D5YciRFn/ovbsI4a
         b+ctJeKjxQEZYC2Hpkh76+RWy+TyUDvw8ufT9XwpRRDBieaUTcCMPYTdtuLEC6RL2h5y
         oXblozVFps6LCUAUVz8jdHE8exajmNCF6+irf24ot3DfwG826rdH7AxXwSYHmEiIVmzz
         xg2PmlFh96c1YjAWBxzKhzUrPMu+UcxDLnexSD1m7KtmLPyQjJd7GIN7OWq1ZkuKIDtI
         84URe1lFS5BYTOw0D1NBTA5CCPRowbcDWxWJ5J153IHsMENFyZiueI1rKJBtGiRnKo6v
         at3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/rUTCOwtYIu/pn/iYM8aAALF21p7zXtSuNtC+Px5a4=;
        b=pAMdh0LZKT2lfGcQj5Uuvw3fSqMOubx52AggUdk5Mj4vyhBEYx0xluXilzyD059igm
         +t1NucqkPPi69nKysC22ZcDSNt5D+YW6LOQujMcGxMMJv3AbDu2gkmZb1PiI6xb1TLNJ
         jjNHEK2dum2+LJZNG9IwoCbtx3Zc9hnjpDw7AIX7gSC7D8lqf57piTyDhm9w4KdaEQve
         p2NgotHAYDZu6PqG43EyPVG6YLwMHwxkLW9TrGMJFILYU3xxfnjNeGI+dr0wRnMMx/hV
         YIqvW2GbPi9DhT3k3LLW05yho/hbB1dZxkjy57BB1LLUza93x5eA9Gwo4OMpiNfeZyq7
         pv3g==
X-Gm-Message-State: APf1xPD4e6tTePxvz5lwxlhuKbMTLlH29WPkphX23pqI6/RFWS551rfI
        xojPKgV8XISTa595eEuQ5DHSpA==
X-Google-Smtp-Source: AH8x226cO5+R0LlsCgCkxFPCW49VO0jiD0+zX+OpgtHm5uViy/58qPm00IphA6usUxvtlQs8X/tiyw==
X-Received: by 10.223.145.67 with SMTP id j61mr3247697wrj.152.1519429202671;
        Fri, 23 Feb 2018 15:40:02 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:02 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 00/11] Make the test suite pass with '-x' and /bin/sh
Date:   Sat, 24 Feb 2018 00:39:40 +0100
Message-Id: <20180223233951.11154-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series makes '-x' tracing of tests work reliably even when
running them with /bin/sh, and setting TEST_SHELL_PATH=bash will be
unnecessary.

  make GIT_TEST_OPTS='-x --verbose-log' test

passes on my setup and on all Travis CI build jobs (though neither me
nor Travis CI run all tests, e.g. CVS).


The first patch is the most important: with a couple of well-placed file
descriptor redirections it ensures that the stderr of the test helper
functions running git commands only contain the stderr of the tested
command, thereby resolving over 90% of the failures resulting from
running the test suite with '-x' and /bin/sh.

Most of the following patches resolve the remaining failures, one test
script at a time, in most cases by limiting the scope of stderr
redirections from functions and subshells to the tested git commands.
Except the second and ninth patches, which, arguably, could be
considered as cheating...  I admit, my enthusiasm suddenly run out when
I saw t1510 :)

The last two patches are just finishing touches with a bit of
documentation updates and enabling '-x' tracing in Travis CI build jobs.


There is currently nothing in 'pu' that would require additional fixes
to make this patch series work.


SZEDER Gábor (11):
  t: prevent '-x' tracing from interfering with test helpers' stderr
  t: add means to disable '-x' tracing for individual test scripts
  t1507-rev-parse-upstream: don't check the stderr of a shell function
  t3030-merge-recursive: don't check the stderr of a subshell
  t5500-fetch-pack: don't check the stderr of a subshell
  t5526: use $TRASH_DIRECTORY to specify the path of GIT_TRACE log file
  t5570-git-daemon: don't check the stderr of a subshell
  t9903-bash-prompt: don't check the stderr of __git_ps1()
  t1510-repo-setup: mark as untraceable with '-x'
  t/README: add a note about don't saving stderr of compound commands
  travis-ci: run tests with '-x' tracing

 ci/lib-travisci.sh            |  2 +-
 t/README                      | 23 +++++++++++++++++++---
 t/lib-terminal.sh             |  4 ++--
 t/t1507-rev-parse-upstream.sh | 14 +++++++-------
 t/t1510-repo-setup.sh         |  4 ++++
 t/t3030-merge-recursive.sh    | 36 +++++++++++++++++++----------------
 t/t5500-fetch-pack.sh         | 12 ++++++------
 t/t5526-fetch-submodules.sh   |  2 +-
 t/t5570-git-daemon.sh         |  2 +-
 t/t9903-bash-prompt.sh        | 14 ++------------
 t/test-lib-functions.sh       | 24 +++++++++++------------
 t/test-lib.sh                 | 19 +++++++++++++++++-
 12 files changed, 94 insertions(+), 62 deletions(-)

-- 
2.16.2.400.g911b7cc0da

