Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB808C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhLQA0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhLQA0d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66AC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so1002514wrg.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FaUzqlfM2pwKfN9VIhcVWFSkkYyKVhty8TVxyiisMCI=;
        b=kggele788/2PhRW6WAKG7F5kKZoNeZXV5jAKQQxqUQhjAFuuXhFMy7ejs7wGMc+hOL
         Wzbh9tn1v6f4K/+Tw1dhO/aE5kSI4EgPbj+hnb8ncC87gXVcvcfVeLD6DpL3nbPzIJp5
         KDG/TgXZFC6BHS4exTBV1a0mHPI/p5qIeq3XQ8QSYH+Hgix6wxCaZWkTNQ024Yqb2ZQO
         +3rcFQL+17i8AY4Ab5hAMEH/B5Ana2fJwkaMYGtY24BNjlnG87lik++nAiebp/RIhKn/
         h8Kg1JnLuO5TOu0qiWixDeaCjv1HoaDL0q5WX+kBoFlk5NpBA3QhfuFaG6sjlEzBkEFC
         V5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FaUzqlfM2pwKfN9VIhcVWFSkkYyKVhty8TVxyiisMCI=;
        b=LOysxDWcv0ARQSnta28iLayrgnAV6u/VMHm2daGpO04nITwitSSCR6YrZGCg2WPEWT
         PsZyu/jdChTSlWa6ZWm6dSGROASwLOvhD0Wjts+DNCgKfi0QzNI/iUot78zpdNG/c+Xo
         IzYynhQWMM7AGBTnt7YxtqWUlLkg2sO3m870qs012ROnXZ7y57q7xF2xlabZFSDfNGR/
         xunfUP3oyvvwgANjgw93sttgcwIn6C8EsNqcDPTIuxDfYz+UDGYAqGsyJdS/VLKPX+ZW
         j2zEOrkgwJoMCyKYzDC0WQGsvkG0n84sMURdsYrugML1Jw2do5GtwqahQ9CXQ896fJbl
         8Evw==
X-Gm-Message-State: AOAM530CK669wVycCC8CnqIpC+Hz4pOVPXLxeQ8Hy3RM9VqQuT5oGE6I
        aE3aIdt5xF6rntku0i2A57WeU6EGpQPSmA==
X-Google-Smtp-Source: ABdhPJxEpnuLMl7O4t7I5WKfiSymVCt9lIys3oqvG3hJEbyHQ1d7tLtxYGubHC14a93w8jtWMl9I1Q==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr368290wrj.84.1639700791136;
        Thu, 16 Dec 2021 16:26:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/11] Makefile: fix "Perl" and "Python" rules, speed up re-builds
Date:   Fri, 17 Dec 2021 01:26:16 +0100
Message-Id: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic is split-up from v4 of ab/make-dependency[1]. Range-diff to
it below. As noted in [2] I opted to split up that series rather than
having it grow too large.

This is miscellanious cleanups related to the "Perl" rules, and some
fixes for bad dependency rules in 08/11. Then in 10/11 we make the
"Python" rules use the new template we created for "Perl",

We are then able to speed up "make" re-builds a bit in 11/11, as we
don't need to inject @@GIT_VERSION@@ into the Perl scripts anymore.

The 09/11 is new. It's a trivial sorting of the PERL_DEFINES list,
which'll help to maintain it in the future.

1. https://lore.kernel.org/git/cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com/
2. https://lore.kernel.org/git/211217.86a6h09km9.gmgdl@evledraar.gmail.com/


Ævar Arnfjörð Bjarmason (11):
  Makefile: clean perl/build/ even with NO_PERL=Y
  Makefile: don't set up "perl/build" rules under NO_PERL=Y
  Makefile: use "=" not ":=" for po/* and perl/*
  Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
  Makefile: guard Perl-only variable assignments
  Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
  Makefile: adjust Perl-related comments & whitespace
  Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
  Makefile: sort PERL_DEFINES list
  Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
  Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts

 .gitignore          |   2 +-
 Makefile            | 160 +++++++++++++++++++++++---------------------
 git-cvsserver.perl  |   6 +-
 git-send-email.perl |   7 +-
 git-svn.perl        |   2 +-
 5 files changed, 90 insertions(+), 87 deletions(-)

Range-diff:
 1:  1621ca72c1d <  -:  ----------- Makefile: don't invoke msgfmt with --statistics
 4:  daead5ec293 =  1:  185f5a9a9cf Makefile: clean perl/build/ even with NO_PERL=Y
 2:  b7c36c9fea0 =  2:  37eeccc5646 Makefile: don't set up "perl/build" rules under NO_PERL=Y
 3:  29b000eb0f1 =  3:  572a82c71a1 Makefile: use "=" not ":=" for po/* and perl/*
 5:  3c987590740 =  4:  5baff22f5af Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
 6:  b57f582ccd3 =  5:  992e325491d Makefile: guard Perl-only variable assignments
 7:  fcdee92f64c =  6:  5e94ef729fe Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
 8:  1e25b532ca2 =  7:  4eeef8571aa Makefile: adjust Perl-related comments & whitespace
 9:  77d9855bfcf =  8:  8aa35537b08 Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
 -:  ----------- >  9:  5ff768a5cec Makefile: sort PERL_DEFINES list
10:  6004cdcd8d9 = 10:  fe79797f45e Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
11:  17b30e96057 = 11:  defbd9b6db2 Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
12:  30ddf7da2c8 <  -:  ----------- Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
13:  f378a7dc35e <  -:  ----------- Makefile: move $(comma), $(empty) and $(space) to shared.mak
14:  13cbb851d32 <  -:  ----------- Makefile: re-add and use the "shellquote" macros
15:  337953e4994 <  -:  ----------- Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
16:  5bb597c1993 <  -:  ----------- Makefile: add "$(QUIET)" boilerplate to shared.mak
17:  3c4d0589667 <  -:  ----------- Makefile: use $(wspfx) for $(QUIET...) in shared.mak
18:  be5882b2c99 <  -:  ----------- Makefiles: add and use wildcard "mkdir -p" template
19:  2710f8af6cd <  -:  ----------- Makefile: correct the dependency graph of hook-list.h
20:  59f22a0269a <  -:  ----------- Makefile: use $(file) I/O instead of "FORCE" when possible
21:  dd569a59c74 <  -:  ----------- Makefile: disable GNU make built-in wildcard rules
22:  4168a7e3b30 <  -:  ----------- Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
23:  48a3927d972 <  -:  ----------- Makefile: move ".SUFFIXES" rule to shared.mak
-- 
2.34.1.1119.g7a3fc8778ee

