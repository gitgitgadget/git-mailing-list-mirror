Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E79262023D
	for <e@80x24.org>; Mon, 22 May 2017 19:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761708AbdEVTsN (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:48:13 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35067 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756740AbdEVTsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:48:11 -0400
Received: by mail-pf0-f179.google.com with SMTP id n23so91669581pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I4lRXm7lW2Jj7+fRlSH7Ka3F24RuSEKtThUI4KA58Yg=;
        b=XjKdGJwzVdncMEg1a/nA3n5PIqYnx1wNlP+3wiak/xtd0lLxD1lUzh2L/BPllF5quE
         Qwkw9cRAzj/Hi+L7hHZ5Wu6LQVq9TYgIFhId/nsdm9yVpE7vvlt66/z8qZl7IaSDfbkF
         l8jiydSLowVGrQvoThkHAZ6BmKhKQyBNuelOJfy6P5rUxgqjOGup/vTxJD71ygskvqQb
         hCQBF2NsX3fg7OjsotMlKZYfluTeI1Nvm2LgogR4NT6jQB6UUslItHVesmjc0ToXvGHe
         jBzU5eql52UUnWNns5VsX/YSqGrXYmPV9A5CVscli3SYY+fP2VM4XYmXaZoheZ1Guuq4
         f0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I4lRXm7lW2Jj7+fRlSH7Ka3F24RuSEKtThUI4KA58Yg=;
        b=Vddc/5p6/r91FMVKHyj7eIoKOnrs5kH2iFp1/ahihz8XVwmBKuShvRPYCubpkD1/qi
         6xlIVH24BXAWjLTRZttM0miGgSG8DG+Sqwqz83/Wt6nK3xdkL0phiayLd3vZQGkRYhS0
         q9QnBOpf9dfruYbocNMJ2XCXEP2yNPgXcN5MNBDHsJ2Cs176EyvljzFgUQWzZqctlfkE
         KiJMAKEVUcaMMVJf3wtNs/0zINW+IoYyBwH12omCY3Dm68cl/z7qjXu71ymjQZVF3io7
         W00brxZEl7EX+inXt2lyK47K0jV9pY/a4ZRmNJDSt6LMMyP91km3hsKQ8mQdl/mQi8l0
         5f/g==
X-Gm-Message-State: AODbwcDfLy2C0XV/L7Qsw8cSifCh1Sks0pszl587MxttDQDGnrzOV6hL
        lK+CMoaO3T7pdhR/
X-Received: by 10.99.115.17 with SMTP id o17mr27529123pgc.146.1495482489625;
        Mon, 22 May 2017 12:48:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id c196sm33079683pga.23.2017.05.22.12.48.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 12:48:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/6] Add option to recurse into submodules
Date:   Mon, 22 May 2017 12:48:00 -0700
Message-Id: <20170522194806.13568-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* this applies on sb/reset-recurse-submodules
* grep and push are also respecting submodule.recurse now.
* Brandon seemed to disagree with the first patch as it may
  hurt with his 'RFC repo object' series [1], but I explained
  a possible way out in [2] and Brandon seemed to agree that this
  makes sense offlist. 
  That first patch was changed to include loading the gitmodules file
  in the call to loading the config.

[1] https://public-inbox.org/git/20170518232134.163059-1-bmwill@google.com/
[2] https://public-inbox.org/git/CAGZ79kb+31h6f_9fuUpbfeY7xxjP-kbvqz6J5K5sbPEmdPNvpw@mail.gmail.com/

v1:
In a submodule heavy workflow it becomes tedious to pass in
--recurse-submodules all the time, so make an option for it.

Thanks,
Stefan

Stefan Beller (6):
  submodule.c: add has_submodules to check if we have any submodules
  submodule test invocation: only pass additional arguments
  Introduce submodule.recurse option for worktree manipulators
  builtin/fetch.c: respect 'submodule.recurse' option
  builtin/grep.c: respect 'submodule.recurse' option
  builtin/push.c: respect 'submodule.recurse' option

 Documentation/config.txt           |  5 +++
 builtin/checkout.c                 |  9 ++--
 builtin/fetch.c                    |  3 +-
 builtin/grep.c                     |  3 ++
 builtin/push.c                     |  4 ++
 builtin/read-tree.c                |  3 +-
 builtin/reset.c                    |  3 +-
 builtin/submodule--helper.c        | 10 ++---
 submodule.c                        | 85 +++++++++++++++++++++++++++++++-------
 submodule.h                        |  8 +++-
 t/lib-submodule-update.sh          | 18 +++++++-
 t/t1013-read-tree-submodule.sh     |  4 +-
 t/t2013-checkout-submodule.sh      |  4 +-
 t/t5526-fetch-submodules.sh        | 10 +++++
 t/t5531-deep-submodule-push.sh     | 21 ++++++++++
 t/t7112-reset-submodule.sh         |  4 +-
 t/t7814-grep-recurse-submodules.sh | 18 ++++++++
 unpack-trees.c                     |  3 +-
 18 files changed, 169 insertions(+), 46 deletions(-)

-- 
2.13.0.18.g7d86cc8ba0

