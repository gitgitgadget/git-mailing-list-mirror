Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87E4C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D802087E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flh++J5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJRSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33918 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgDJRSW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id l14so1242327pgb.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0CiIRqgTE55Si4nx4O7HI3f+XnTe/G69un0VgvZxxg=;
        b=flh++J5aYbeJncZtTTKdROQWO7WHV7q1vDQK8l/Ij1yBwSOkq6P3Do5DFChJZ68KuQ
         EWF7fOwpW7UPQMvSZjIayyI18Ek92DcgJmWl2p1EeorgHOaeuDq8ErQlHCGDi3Y1GY05
         4Myk0OMI/R44CbBFV2qoY2eUVKrOnG2Pgdjlx1/s6BvSopLeAaij3C2BGFAd4cxpgyQI
         3t5m3F28Z5EIiSt8BrxD9H0YomSWBCyLUNg+63bxgshw4yP7LdlQeEOsyBOvsKuR3S8/
         QEn6l0hzGJfB6kmkl5u8znv19gw81P0iNAFbipAp8h1AveoFC3su2BiF9Vo3qtKIHp67
         uTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0CiIRqgTE55Si4nx4O7HI3f+XnTe/G69un0VgvZxxg=;
        b=CFq0St3W7jq2xpGyWHnuIUBySSHtVN8D12GmVdAJdpWzEmRgt6pdRkon204JUlrqaG
         Ylqt6pgLuLvYCmfgaYm9VjEhP7qeCmfdHeP1EcK9nGps0a69PCr6/oLeEyCyh1zRJQ8A
         kuGYjrgSscTMD3faKjR17Js7bL8NweUf5PVqYWf7NGwonk+ijan4mf1PUra58Cuc7Odl
         pULI5+1FWNCknHAXZc4z/UuxUAi8zTCV+xc5jlB5kNF3EI7HW6Spp7jkYwaBv7QLo370
         XgqcDHi/3A0wsvZgMEPtKL/oleYfqqGaHQmag88AUJWzFA+6szrA02iCW5pa8t91Amb0
         EexQ==
X-Gm-Message-State: AGi0PuaK273F0tlybWYUsQJlprzebLfEeyqmX9ZJ9H14yoBsEgK63gQS
        N1UCBNLz6uGlrVtOYhIZAWCweAGw
X-Google-Smtp-Source: APiQypK3+1d1ygFR8kjyBGlIwE0/r2OFmFPYJtywMF4C2dm71IEQ1j4UH9kqNBdVA8+qj+zgnFklGw==
X-Received: by 2002:a63:ac43:: with SMTP id z3mr5324788pgn.324.1586539101235;
        Fri, 10 Apr 2020 10:18:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:20 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 00/12] ci: replace our Azure Pipeline by GitHub Actions
Date:   Sat, 11 Apr 2020 00:18:02 +0700
Message-Id: <cover.1586538752.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our Azure Pipeline has served us well over the course of the past year or
so, steadily catching issues before the respective patches hit the next
branch.

There is a GitHub-native CI system now, though, called "GitHub Actions"
[https://github.com/features/actions] which is essentially on par with Azure
Pipelines as far as our needs are concerned, and it brings a couple of
advantages:

 * It is substantially easier to set up than Azure Pipelines: all you need
   is to add the YAML-based build definition, push to your fork on GitHub,
   and that's it.
 * The syntax is a bit easier to read than Azure Pipelines'.
 * We get more concurrent jobs (Azure Pipelines is limited to 10 concurrent
   jobs).

With this change, users also no longer need to open a PR at
https://github.com/git/git or at https://github.com/gitgitgadget/git just to
get the benefit of a CI build.

Change in v5 from v4:
- cleanup on dependencies installation.

Change in v4 from v3:
- Use build matrix
- All dependencies are install by scripts
- stop repeating environment variables
- build failure's artifacts will be uploaded

*** BLURB HERE ***

Johannes Schindelin (9):
  ci/lib: if CI type is unknown, show the environment variables
  ci/lib: allow running in GitHub Actions
  ci: fix the `jobname` of the `GETTEXT_POISON` job
  ci: run gem with sudo to install asciidoctor
  README: add a build badge for the GitHub Actions runs
  ci: retire the Azure Pipelines definition
  tests: when run in Bash, annotate test failures with file name/line
    number
  ci: add a problem matcher for GitHub Actions
  ci: let GitHub Actions upload failed tests' directories

Đoàn Trần Công Danh (3):
  ci/lib: set TERM environment variable if not exist
  ci: explicit install all required packages
  ci: configure GitHub Actions for CI/PR

 .github/workflows/main.yml  | 230 +++++++++++++++
 .travis.yml                 |   2 +-
 README.md                   |   2 +-
 azure-pipelines.yml         | 558 ------------------------------------
 ci/git-problem-matcher.json |  16 ++
 ci/install-dependencies.sh  |  16 +-
 ci/lib.sh                   |  31 +-
 ci/print-test-failures.sh   |   7 +
 t/test-lib.sh               |  14 +-
 9 files changed, 309 insertions(+), 567 deletions(-)
 create mode 100644 .github/workflows/main.yml
 delete mode 100644 azure-pipelines.yml
 create mode 100644 ci/git-problem-matcher.json

Range-diff against v4:
 1:  2219bf3db9 =  1:  2219bf3db9 ci/lib: if CI type is unknown, show the environment variables
 2:  2818799a4b =  2:  2818799a4b ci/lib: allow running in GitHub Actions
 3:  b88586c2c5 =  3:  b88586c2c5 ci/lib: set TERM environment variable if not exist
 4:  1df60e677c =  4:  1df60e677c ci: fix the `jobname` of the `GETTEXT_POISON` job
 5:  4f80724641 !  5:  ac7e247bb3 ci: explicit install all required packages
    @@ Commit message
     
         In a later patch, we will support GitHub Action.
     
    -    Explicitly install all of our build dependencies.
    -    Since GitHub Action VM hasn't install our build dependencies, yet.
    +    Explicitly install all of our build dependencies on Linux.
    +    Since GitHub Action's Linux VM hasn't installed our build dependencies.
         And there're no harm to reinstall them (in Travis)
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
    @@ ci/install-dependencies.sh
      P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
      LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
     +UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
    -+ perl-modules liberror-perl tcl tk gettext zlib1g-dev apache2
    -+ libauthen-sasl-perl libemail-valid-perl libio-socket-ssl-perl
    -+ libnet-smtp-ssl-perl"
    ++ tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
    ++ libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
      
      case "$jobname" in
      linux-clang|linux-gcc)
    @@ ci/install-dependencies.sh
      	case "$jobname" in
      	linux-gcc)
      		sudo apt-get -q -y install gcc-8
    -@@ ci/install-dependencies.sh: StaticAnalysis)
    +@@ ci/install-dependencies.sh: osx-clang|osx-gcc)
    + StaticAnalysis)
    + 	sudo apt-get -q update
    + 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
    +-		libexpat-dev gettext
    ++		libexpat-dev gettext make
      	;;
      Documentation)
      	sudo apt-get -q update
     -	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns
    -+	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns \
    -+		libcurl4-openssl-dev
    ++	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
      
      	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
      	gem install --version 1.5.8 asciidoctor
      	;;
    -+GETTEXT_POISON)
    ++linux-gcc-4.8|GETTEXT_POISON)
     +	sudo apt-get -q update
     +	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
     +	;;
 6:  795ec656c6 <  -:  ---------- ci: run gem with sudo to install asciidoctor
 -:  ---------- >  6:  2fb9f2e2f2 ci: run gem with sudo to install asciidoctor
 7:  ec0aa20119 =  7:  40fe4f7e2c ci: configure GitHub Actions for CI/PR
 8:  46f2b6bce6 =  8:  09735fb1de README: add a build badge for the GitHub Actions runs
 9:  92f2623dc7 =  9:  575b3afd3c ci: retire the Azure Pipelines definition
10:  f688fa50d3 = 10:  ce00385987 tests: when run in Bash, annotate test failures with file name/line number
11:  715d1f732f = 11:  3caeb0b7f4 ci: add a problem matcher for GitHub Actions
12:  0908d5ab9b = 12:  8de46ee1c6 ci: let GitHub Actions upload failed tests' directories
-- 
2.26.0.334.g6536db25bb

