Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05FC1F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfEGKy7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:54:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42173 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfEGKyq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:54:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so21686806wrb.9
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67XtIX3V3Prl8LrbAUR2mlJZLyMpJ/l7HPu4GmPgnzY=;
        b=jFKzYqXMlD/7aEJxCpyfmFbmypGAg8+bzMIVXCJ+qXeSaTfWGnYXJwEtcsPLoCLsZB
         /eLfR8cpv3wO07BjlFqVpeQ1QqnxRWpExx5o2Lxl0rmIvD9xF2CQsAuAgrEKXNiQ9M+p
         2qvT6d6EZAhoF27CH41vGd95lf1h1kSmhwBUaHfM3PO0QfNbQKQortT8xNGt6SFF5vRs
         FZVOAVL3iynXGv3qngW1ErArWEadsjlqytbNLg5FV39KaG5/zEt79yGE6f1TdNxxw968
         1WaG9rQKp0gbNuOdJbs6U6Tvu1AzUqGu9Zup34/8XVn4RQJSuD0xmWgAF0TED9UsfRCf
         0wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67XtIX3V3Prl8LrbAUR2mlJZLyMpJ/l7HPu4GmPgnzY=;
        b=OqL0ULrPcHtz1DWsX/TNihfPc21+FOqrZeY8LitdW46kEVyvgEYP6yOeNOdeGjfjDd
         dFipdPQP5qmgSxNhJ0wNMJa5pPywQ4NeGaED3R1+91kHdsMaQPdXlxyr4LUV7qbb/Vga
         hHZJxgAomJDbqosp6FJMNoLJYpbE3GGSDBfwsSXyjFmaRw+tV1tFRGBMUU6SCjQ3Taff
         AnfyK9lQwLo7cWybmx2u31uZhGXgZm9kI/iq3OApqahm/O7x5RyPlee8MpXNzNdzFGxq
         skNLLEjZlutsxo9OY4pq/vndGKbD++QF7j93HncMWFsKtitx13BMbiNcMhnquU3dg48U
         P2ow==
X-Gm-Message-State: APjAAAVeqISh4H1wWNNtwuMpS+nhcqfa5QdIXefisMsx6gOEcB30P3nM
        66TCV5InMFvnAbR02yjuhGTmL7TokZU=
X-Google-Smtp-Source: APXvYqwV+GNxL19Lbn9EZmjrhCO+HHve0IUw9AZ9KnNfIfbBw10TvNcgis561rHpjm8suINRzSi0Ag==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr23211819wrq.186.1557226483245;
        Tue, 07 May 2019 03:54:43 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm11029573wmb.12.2019.05.07.03.54.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 03:54:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/6] perf-lib.sh: fix 0baf78e7bc regression, refactor & fix bugs
Date:   Tue,  7 May 2019 12:54:28 +0200
Message-Id: <20190507105434.9600-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190506232309.28538-1-avarab@gmail.com>
References: <20190506232309.28538-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here as a 6-parter given some of the feedback on v2. Maybe Jeff
still hates it :), but this time around some of the changes are split
up and should be easier to understand in isolation, as well as some
more "noticed while I was at it" things fixed.

This series ends with outright forbidding the user from directly
setting GIT_TEST_INSTALLED. As discussed it makes things easier for
us, and as noted in 1/6 the demand for that in the wild seems
non-existent, since the way we've been documenting how you could do
that with an environment variable has been broken since 2012.

Ævar Arnfjörð Bjarmason (6):
  perf README: correct docs for 3c8f12c96c regression
  perf aggregate: remove GIT_TEST_INSTALLED from --codespeed
  perf-lib.sh: make "./run <revisions>" use the correct gits
  perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh
  perf tests: add "bindir" prefix to git tree test results
  perf-lib.sh: forbid the use of GIT_TEST_INSTALLED

 t/perf/README         |  2 +-
 t/perf/aggregate.perl | 17 +++++++++--------
 t/perf/perf-lib.sh    | 18 ++++++++++--------
 t/perf/run            | 43 +++++++++++++++++++++++++++++++++----------
 4 files changed, 53 insertions(+), 27 deletions(-)

Range-diff:
-:  ---------- > 1:  6684dca042 perf README: correct docs for 3c8f12c96c regression
-:  ---------- > 2:  c4e903d898 perf aggregate: remove GIT_TEST_INSTALLED from --codespeed
1:  22a132ed64 ! 3:  9d2d162c64 perf-lib.sh: make "./run <revisions>" use the correct gits
    @@ -40,9 +40,13 @@
         this will subtly fail in test-lib.sh. This has always been the case
         even before 0baf78e7bc, and as documented in t/README the
         GIT_TEST_INSTALLED variable should be set to an absolute path (needs
    -    to be set "to the bindir", which is always absolute). Perhaps that
    -    should be dealt with in the future, but I'm leaving that alone for
    -    now.
    +    to be set "to the bindir", which is always absolute), and the "perf"
    +    framework expects to munge it itself.
    +
    +    Perhaps that should be dealt with in the future to allow manually
    +    setting GIT_TEST_INSTALLED, but as a preceding commit showed the user
    +    can just use the "run" script, which'll also pick the right output
    +    directory for the test results as expected by aggregate.perl.
     
         1. https://public-inbox.org/git/20190502222409.GA15631@sigill.intra.peff.net/
     
2:  f43beb6450 ! 4:  58f1dd3f6f perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh
    @@ -26,28 +26,28 @@
         We'll just do the right thing because PERF_RESULTS_PREFIX will be
         empty, and test-lib.sh takes care of finding where our git is.
     
    -    Refactoring this revealed a few bugs, e.g. while a relative git path
    -    was supported via e.g.:
    +    Any refactoring of this code needs to change both the shell code and
    +    the Perl code in aggregate.perl, because when running e.g.:
     
             ./run ../../ -- <test>
     
    -    We'd just print out ".." as the header, since we'd always take the
    -    content after the last slash. Now we'll always resolve the absolute
    -    path to something we detect to be be a manually supplied bindir, and
    -    print the full path in the aggregation.
    +    The "../../" path to a relative bindir needs to be munged to a
    +    filename containing the results, and critically aggregate.perl does
    +    not get passed the path to those aggregations, just "../..".
     
    -    There was also a long-standing bug in the codespeed output where the
    -    "environment" for N number of tests would be whatever our
    -    GIT_TEST_INSTALLED had been set to by the last of those N runs. Let's
    -    instead just fall back to "uname -r", which is a more sensible
    -    "environment" than some random build directory path, even for the N=1
    -    case.
    +    Let's fix cases where aggregate.perl would print e.g. ".." in its
    +    report output for this, and "git" for "/home/avar/g/git", i.e. it
    +    would always pick the last element. Now'll always print the full path
    +    instead.
    +
    +    This also makes the code sturdier, e.g. you can feed "../.."  to
    +    "./run" and then an absolute path to the aggregate.perl script, as
    +    long as the absolute path and "../.." resolved to the same directory
    +    printing the aggregation will work.
     
         Also simplify the "[_*]" on the RHS of "tr -c", we're trimming
         everything to "_", so we don't need that.
     
    -    https://public-inbox.org/git/20190502222409.GA15631@sigill.intra.peff.net/
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
    @@ -80,16 +80,6 @@
      	my $prefix = $dir;
      	$prefix =~ tr/^a-zA-Z0-9/_/c;
      	$prefixes{$dir} = $prefix . '.';
    -@@
    - 		$environment = $reponame;
    - 	} elsif (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
    - 		$environment = $ENV{GIT_PERF_REPO_NAME};
    --	} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
    --		$environment = $ENV{GIT_TEST_INSTALLED};
    --		$environment =~ s|/bin-wrappers$||;
    - 	} else {
    - 		$environment = `uname -r`;
    - 		chomp $environment;
     
      diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
      --- a/t/perf/perf-lib.sh
-:  ---------- > 5:  64df9157a4 perf tests: add "bindir" prefix to git tree test results
-:  ---------- > 6:  21307f1f2d perf-lib.sh: forbid the use of GIT_TEST_INSTALLED
-- 
2.21.0.593.g511ec345e18

