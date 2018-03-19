Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B5A1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 02:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754895AbeCSCuw (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 22:50:52 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:38934 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754523AbeCSCuv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 22:50:51 -0400
Received: by mail-qt0-f172.google.com with SMTP id v11so8627422qtj.6
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSGo8XzeHxOPfM9eCIsHJGsEDi2AF7bVBJMhxqsfzYM=;
        b=rl+Ct3bhEXAMeKwTR1XP1wPwS7p+ycOAFdwSVDQaHURpvpjFQPuqExnenMCtyUTviS
         FUkFEid+uKQAhXpaoDAN9o3Y6SR+BTfHCZzG4dEiqBr+/XQgvVCap4dEZgI4Q2/H+0ZM
         vramkZdEk0k5MdY+dqqS0/prllAsI1ZKTjJBZVMZV17lzKB+eFgd54J7O1CsahVvVDu/
         T+Fsg1i4p3RtgPeb5DETBjSqb7OIHYyJN+nYjp9OabD59Li4+g2JCq11lLKXfrlcKeMI
         6HHjEVF9d0mNv1L5QonqN+gHCDuVwZvvJuXIqBxeQEoZKtAj3OpOkoOTB83VahvMpPSK
         jUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSGo8XzeHxOPfM9eCIsHJGsEDi2AF7bVBJMhxqsfzYM=;
        b=k4hO8Niuzj2V79FNZSFCrMoHAOaxcQYmOpkkBVAiTG++g71g0zbYridf/Ef9WSXJRB
         dAB70W22Kbhv0QvG+/Wolf56NA127u9rNTt3uKkz0Fr9BCNARDsUyQ6/bdqNjKcau/Uw
         ur5n/ZIG3bTCR9Pxbqdfx2+8kwf+CJHufDH561x8gOv2YD2qP/ixN11cIahXBIP7oHBs
         TghHpR7maNxtC+Y/TcERMTEp8cuGJ9Fo9q0E1eWm7mas83qRO77oCzRkevvNk0hb3Egl
         5DreGr2pE12VZ1xt0VPpUmXyfSaRCE1joqEkCPN07RBimKxFllv59ariCUQf8xS4crgj
         ECtA==
X-Gm-Message-State: AElRT7HYDVi4wdach2zNq5iGp5nbRhIM97Yy23k1RctltF+owmSY0oZf
        USkxl5nWpDO0fV42e6CYZCu4+reYkss=
X-Google-Smtp-Source: AG47ELtfN2PAy0ea9FHEmX65UUg/twWUl9maN2FcinoMCtnlZpLD7ACvpwItYcoCTcXL8GgkKo/WtA==
X-Received: by 10.200.24.177 with SMTP id s46mr15517652qtj.239.1521427849761;
        Sun, 18 Mar 2018 19:50:49 -0700 (PDT)
Received: from localhost.localdomain (pool-74-109-218-108.pitbpa.fios.verizon.net. [74.109.218.108])
        by smtp.gmail.com with ESMTPSA id x8sm9877902qta.64.2018.03.18.19.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 19:50:48 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v6 0/3] RUNTIME_PREFIX relocatable Git
Date:   Sun, 18 Mar 2018 22:50:43 -0400
Message-Id: <20180319025046.58052-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set expands support for the RUNTIME_PREFIX configuration flag,
currently only used on Windows builds, to include Linux, Darwin, and
FreeBSD. When Git is built with RUNTIME_PREFIX enabled, it resolves its
ancillary paths relative to the runtime location of its executable
rather than hard-coding them at compile-time, allowing a Git
installation to be deployed to a path other than the one in which it
was built/installed.

Note that RUNTIME_PREFIX is not currently used outside of Windows.
This patch set should not have an impact on default Git builds.

I'm dusting this back off now that avarab@'s Perl Makefile simplification
patch set has landed. It's been a few months, so I'm a bit rusty, but I think
that I've incorporated all of the feedback. Please take a look and let me know
what you think!

Previous threads:
v1: https://public-inbox.org/git/20171116170523.28696-1-dnj@google.com/
v2: https://public-inbox.org/git/20171119173141.4896-1-dnj@google.com/
v3: https://public-inbox.org/git/20171127164055.93283-1-dnj@google.com/
v4: https://public-inbox.org/git/20171129223807.91343-1-dnj@google.com/
v5: https://public-inbox.org/git/20180108030239.92036-1-dnj@google.com/

Changes in v6 from v5:

- Rebased on top of "master".
- Updated commit messages.
- Updated runtime prefix Perl header comment and code to clarify when and
  why FindBin is used.
- With Johannes' blessing on Git-for-Windows, folded "RUNTIME_PREFIX_PERL"
  functionality into "RUNTIME_PREFIX".
- Updated "run-command" test to accommodate RUNTIME_PREFIX trace messages.

=== Testing ===

The latest patch set is available for testing on my GitHub fork, including
"travis.ci" testing. The "runtime-prefix" branch includes a "config.mak"
commit that enables runtime prefix for the Travis build; the
"runtime-prefix-no-config" omits this file, testing this patch without
runtime prefix enabled:
- https://github.com/danjacques/git/tree/runtime-prefix
- https://github.com/danjacques/git/tree/runtime-prefix-no-config
- https://travis-ci.org/danjacques/git/branches

Built/tested locally using this "config.mak" w/ autoconf:

=== Example config.mak ===

## (BEGIN config.mak)

RUNTIME_PREFIX = YesPlease
RUNTIME_PREFIX_PERL = YesPlease
gitexecdir = libexec/git-core
template_dir = share/git-core/templates
sysconfdir = etc

## (END config.mak)

=== Revision History ===

Changes in v5 from v4:

- Rebase on top of "next", notably incorporating the
  "ab/simplify-perl-makefile" branch.
- Cleaner Makefile relative path enforcement.
- Update Perl header template path now that the "perl/" directory has
  fewer build-related files in it.
- Update Perl runtime prefix header to use a general system path resolution
  function.
- Implemented the injection of the locale directory into Perl's
  "Git/I18N.pm" module from the runtime prefix Perl script header.
- Updated Perl's "Git/I18N.pm" module to accept injected locale directory.
- Added more content to some comments.


Changes in v4 from v3:

- Incorporated some quoting and Makefile dependency fixes, courtesy of
  <johannes.schindelin@gmx.de>.

Changes in v3 from v2:

- Broken into multiple patches now that Perl is isolated in its own
  RUNTIME_PREFIX_PERL flag.
- Working with avarab@, several changes to Perl script runtime prefix
  support:
  - Moved Perl header body content from Makefile into external template
    file(s).
  - Added generic "perllibdir" variable to override Perl installation
    path.
  - RUNTIME_PREFIX_PERL generated script header is more descriptive and
    consistent with how the C version operates.
  - Fixed Generated Perl header Makefile dependency, should rebuild
    when dependent files and flags change.
- Changed some of the new RUNTIME_PREFIX trace strings to use consistent
  formatting and terminology.

Changes in v2 from v1:

- Added comments and formatting to improve readability of
  platform-sepecific executable path resolution sleds in
  `git_get_exec_path`.
- Consolidated "cached_exec_path" and "argv_exec_path" globals
  into "exec_path_value".
- Use `strbuf_realpath` instead of `realpath` for procfs resolution.
- Removed new environment variable exports. Git with RUNTIME_PREFIX no
  longer exports or consumes any additional environment information.
- Updated Perl script resolution strategy: rather than having Git export
  the relative executable path to the Perl scripts, they now resolve
  it independently when RUNTIME_PREFIX_PERL is enabled.
- Updated resolution strategy for "gettext()": use system_path() instead
  of special environment variable.
- Added `sysctl` executable resolution support for BSDs that don't
  mount "procfs" by default (most of them).

Dan Jacques (3):
  Makefile: generate Perl header from template file
  Makefile: add Perl runtime prefix support
  exec_cmd: RUNTIME_PREFIX on some POSIX systems

 .gitignore                                       |   1 +
 Makefile                                         | 120 +++++++++--
 cache.h                                          |   1 +
 common-main.c                                    |   4 +-
 config.mak.uname                                 |   7 +
 exec_cmd.c                                       | 241 ++++++++++++++++++++---
 exec_cmd.h                                       |   4 +-
 gettext.c                                        |   8 +-
 git.c                                            |   2 +-
 perl/Git/I18N.pm                                 |   2 +-
 perl/header_templates/fixed_prefix.template.pl   |   1 +
 perl/header_templates/runtime_prefix.template.pl |  40 ++++
 t/t0061-run-command.sh                           |   2 +-
 13 files changed, 379 insertions(+), 54 deletions(-)
 create mode 100644 perl/header_templates/fixed_prefix.template.pl
 create mode 100644 perl/header_templates/runtime_prefix.template.pl

-- 
2.15.0.chromium12

