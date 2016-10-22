Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A94020986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756199AbcJVXcd (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:33 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:34304 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756164AbcJVXcc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:32 -0400
Received: by mail-it0-f52.google.com with SMTP id f129so12182287itc.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwUH25xM18GL25SBYsN9kdM7MmWYR3umsT9WHF7sRAk=;
        b=HJL+HAUKiBNgQ+8C1F1tHYu1GiiPg6C8C8yXSdt9CF30BwvwxOerZtPlOj8h1yFikO
         f330y2h0rwTC9u6he7o8WdPbkbHJjQVSrZQVMpKe4Hf+3ma4Uf+rw09cdbvBxHm+DJ8B
         99FEkzVksFCLmdfBDBXopKG5E7ETjazjdBLfS6fXQYLXPB9EzduhNHWsYsxQl+SRVGrw
         tQ2/Rh77UxspzPxz26992HKctEzbNWQKGucRAeHnnmyXpSSJWpTHe8XlzuMUIf963xZJ
         E1WdZVVjrnERYaxahSAUu4IlYyhf7tQrOGsuJwoe9ihqv6XSzY9A6mPrOWSPKrEXW2kV
         vf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwUH25xM18GL25SBYsN9kdM7MmWYR3umsT9WHF7sRAk=;
        b=NXTMHV/K+1+zXkk2EMu61nGtG4GbB9QBgL5iBMKRdqq2MqQccLmmHU+GabrV/iYxpR
         Kava9hwH/NKYqiwotnYIyHDyRzU2OoS8KzHJuQyMr5kZ0iIsv3OSSK9BgAdijnu3ANQi
         7LBmR9PEXQ6kcK0LrOgjybZD/u6kS1iGEFyab5XmCFCMY0CKJPDMvXHUjJW/aFc02jSG
         JidXFtBElDNc5y4ptDxUrFKVXh8FwyNGStdCSbXC77RnPeSwUCUJUhFYTWR7IAHEXx7B
         xca11jC2L6bdM54w4BgqKwg4fn/W77iezhrf5LqKPQUe2yhNH41nPuMHeyVw6cPS1sua
         nm9Q==
X-Gm-Message-State: ABUngvdtpMRmOp5/Z3jn53WSSQwQEWwq+3CZS0Ta/kb3ZPrnglzPy12BHArUrXQtK7zVdNTJ
X-Received: by 10.36.31.74 with SMTP id d71mr7230463itd.66.1477179151570;
        Sat, 22 Oct 2016 16:32:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id y21sm4552293iod.34.2016.10.22.16.32.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 00/36] Revamping the attr subsystem!
Date:   Sat, 22 Oct 2016 16:31:49 -0700
Message-Id: <20161022233225.8883-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous discussion:
http://public-inbox.org/git/20161012224109.23410-1-sbeller@google.com
http://public-inbox.org/git/20161011002115.23312-1-sbeller@google.com/

This implements the discarded series':
jc/attr
jc/attr-more
sb/pathspec-label
sb/submodule-default-paths

* I rebase to origin master (no merge conflicts)
* I implemented the thread safe attr API in patch 27 (attr: convert to new threadsafe API)
* patch 28 (attr: keep attr stack for each check) makes it actually possible
  to run in a multithreaded environment.
* I added a test for the multithreaded when it is introduced in patch 32
  (pathspec: allow querying for attributes)

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
 Documentation/technical/api-gitattributes.txt | 117 ++++--
 archive.c                                     |  26 +-
 attr.c                                        | 530 ++++++++++++++++++--------
 attr.h                                        |  74 +++-
 builtin/check-attr.c                          |  65 ++--
 builtin/clone.c                               |  36 +-
 builtin/pack-objects.c                        |  27 +-
 commit.c                                      |   3 +-
 contrib/completion/git-completion.bash        |   1 +
 convert.c                                     |  45 +--
 dir.c                                         |  35 ++
 git-submodule.sh                              |  21 +-
 hashmap.h                                     |   2 +
 ll-merge.c                                    |  36 +-
 pathspec.c                                    | 225 +++++++++--
 pathspec.h                                    |  16 +
 t/t0003-attributes.sh                         |  26 ++
 t/t6134-pathspec-with-labels.sh               | 180 +++++++++
 t/t7400-submodule-basic.sh                    | 134 +++++++
 userdiff.c                                    |  21 +-
 ws.c                                          |  26 +-
 26 files changed, 1313 insertions(+), 408 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

-- 
2.10.1.508.g6572022

