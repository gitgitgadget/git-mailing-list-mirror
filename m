Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C282035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966077AbcJ1SzT (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:19 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34275 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965206AbcJ1SzS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:18 -0400
Received: by mail-pf0-f171.google.com with SMTP id n85so41585101pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cK1UfS90sz3ZdMxXtcjsZDCuURuILLCgFWxS+9+B1wY=;
        b=fWkoc2FWOggeV84LyEF3uMvWJg2Wq0eL2+rCyYdLwLMAXlNo9v+67MOpzBYK7yhHkt
         JWsUzqH0h2CGoXn/L7ssbSU2KRMZrYWPs0pt6lUUUb+uIL0oMAlDLeD2V+kiWZubsE9W
         EJcCjM1AvHChZv0hxo1o6mfn5p1qn+jB9tZdg9lnlTbdnfxFi3zCMW6Ba0JW+s+ntnfu
         3vNurYogiTuLrhyA+hE19LozfXU6FRFEZyVEHnSwiC/SlxgeJvHvzPjjaOa1JPN0h2Sd
         RzWNNjr9XJ5Bdg5LY9WivShjR7H3+xXx82gshhyhFF+INZtLtP+8gIMwBD0Mqv05JepO
         oqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cK1UfS90sz3ZdMxXtcjsZDCuURuILLCgFWxS+9+B1wY=;
        b=hlMMUutT6Rp8VVreVc9UK98/UyPEDCdIBh0ndBujigxZO3XOcwHqum4lAHloA6yHJ2
         Zf3pRdSH7b9zo9w15VlNDlaS41eYLaX4h4vBzC1ekq8iF7qhqXKw84T0XZOf+BBjBV25
         +JRAaFVQyCDFkfS69R8fpT6YZ7POuAzLRZXABCl4Gyxw9XIZiPSAkL9NDymimo91S2FO
         wmbHdg4T/Z7j57Hnj26ZRjZjEhD4bR7cKj66p2uF4pChYcpmvxFW4YrbkeXNguXby0ZF
         xeb436VdSGuzDaddjHAOT8J0nu4YlJb7mhqJW2dirrPywb2beft8GPv4ytyNQu74Xv87
         butg==
X-Gm-Message-State: ABUngvdB/I7FqJpvfGUaWM12Ji3GjLD9YUbKPZZxlrp44tf+TxlJOPXYBAWst4a46tgFi+LH
X-Received: by 10.99.254.5 with SMTP id p5mr22649608pgh.124.1477680917234;
        Fri, 28 Oct 2016 11:55:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id yx8sm20603353pac.29.2016.10.28.11.55.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 00/36] Revamp the attr subsystem!
Date:   Fri, 28 Oct 2016 11:54:26 -0700
Message-Id: <20161028185502.8789-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous discussion at https://public-inbox.org/git/20161022233225.8883-1-sbeller@google.com

This implements the discarded series':
jc/attr
jc/attr-more
sb/pathspec-label
sb/submodule-default-paths

This includes
* The fixes for windows
* Junios latest suggestion to use git_attr_check_initv instead of
  alloc/append.

* I implemented the thread safe attr API in patch 27 (attr: convert to new threadsafe API)
* patch 28 (attr: keep attr stack for each check) makes it actually possible
  to run in a multithreaded environment.
* I added a test for the multithreaded when it is introduced in patch 32
  (pathspec: allow querying for attributes) as well as a test to disallow
  multiple "attr"s in a pathspec.

Thanks,
Stefan

Junio C Hamano (24):
  commit.c: use strchrnul() to scan for one line
  attr.c: use strchrnul() to scan for one line
  attr.c: update a stale comment on "struct match_attr"
  attr.c: explain the lack of attr-name syntax check in parse_attr()
  attr.c: complete a sentence in a comment
  attr.c: mark where #if DEBUG ends more clearly
  attr.c: simplify macroexpand_one()
  attr.c: tighten constness around "git_attr" structure
  attr.c: plug small leak in parse_attr_line()
  attr: rename function and struct related to checking attributes
  attr: (re)introduce git_check_attr() and struct git_attr_check
  attr: convert git_all_attrs() to use "struct git_attr_check"
  attr: convert git_check_attrs() callers to use the new API
  attr: retire git_check_attrs() API
  attr: add counted string version of git_check_attr()
  attr: add counted string version of git_attr()
  attr: expose validity check for attribute names
  attr.c: add push_stack() helper
  attr.c: pass struct git_attr_check down the callchain
  attr.c: rename a local variable check
  attr.c: correct ugly hack for git_all_attrs()
  attr.c: introduce empty_attr_check_elems()
  attr.c: always pass check[] to collect_some_attrs()
  attr.c: outline the future plans by heavily commenting

Nguyễn Thái Ngọc Duy (1):
  attr: support quoting pathname patterns in C style

Stefan Beller (11):
  attr: make git_check_attr_counted static
  attr: convert to new threadsafe API
  attr: keep attr stack for each check
  Documentation: fix a typo
  pathspec: move long magic parsing out of prefix_pathspec
  pathspec: move prefix check out of the inner loop
  pathspec: allow querying for attributes
  pathspec: allow escaped query values
  submodule update: add `--init-default-path` switch
  clone: add --init-submodule=<pathspec> switch
  completion: clone can initialize specific submodules

 Documentation/config.txt                      |   5 +
 Documentation/git-clone.txt                   |  23 +-
 Documentation/git-submodule.txt               |  17 +-
 Documentation/gitattributes.txt               |  10 +-
 Documentation/glossary-content.txt            |  20 +
 Documentation/technical/api-gitattributes.txt | 140 ++++---
 archive.c                                     |  25 +-
 attr.c                                        | 525 ++++++++++++++++++--------
 attr.h                                        |  71 ++--
 builtin/check-attr.c                          |  74 ++--
 builtin/clone.c                               |  36 +-
 builtin/pack-objects.c                        |  27 +-
 commit.c                                      |   3 +-
 compat/mingw.c                                |   4 +
 contrib/completion/git-completion.bash        |   1 +
 convert.c                                     |  46 ++-
 dir.c                                         |  35 ++
 git-submodule.sh                              |  21 +-
 hashmap.h                                     |   2 +
 ll-merge.c                                    |  35 +-
 pathspec.c                                    | 227 +++++++++--
 pathspec.h                                    |  15 +
 t/t0003-attributes.sh                         |  26 ++
 t/t6134-pathspec-with-labels.sh               | 185 +++++++++
 t/t7400-submodule-basic.sh                    | 134 +++++++
 userdiff.c                                    |  21 +-
 ws.c                                          |  19 +-
 27 files changed, 1336 insertions(+), 411 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

-- 
2.10.1.714.ge3da0db

