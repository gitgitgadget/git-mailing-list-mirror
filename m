Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874C01F404
	for <e@80x24.org>; Sun, 25 Mar 2018 20:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeCYUv0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 16:51:26 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:38762 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeCYUvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 16:51:25 -0400
Received: by mail-qk0-f172.google.com with SMTP id 132so18143824qkd.5
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 13:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFIvANTQbYkzF/t0YQWNuklUu7irr9nWEEuqtTRVyd4=;
        b=jO3G/wXTXkMMWEdToZKSb87JszeyPq2a3ifAHIWY1PwxI2NoLRGHFsIixtaO+ej/oO
         tQL/tAKkqrD9TAiYKslXp+HeTaKUz7MvASMmtuha+qhdHIchM4bznQkVFoAZQwkVWPot
         QzmK+tIFP29S2Yt8TLBOKpMjRxa3s2+PSQ7eJVz/ZM4TMmBZt5ZjPQrWtAXJ/hIBd8EF
         GO+Ale8BMlZTWIFex5cBb3AjS9HloCyekhVh4ouq9/4XxQDFxYfa94lVLQoBs7ZNQzT4
         w/OomSqyiKZ2yzJisJ/zSiPF2M1bOyTqb9kJ/TECtd09T62PypmVPGWTKiH8yhpwjqIU
         tI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFIvANTQbYkzF/t0YQWNuklUu7irr9nWEEuqtTRVyd4=;
        b=srkYwYG/n/6Mq48AqhOuWfn7WaeJof9uo2o/xBHCVy7raDTloeP6X0R9v/wT7BsJ9T
         v7KfN7UPlyq5RK1j8/RWH5SbU21pwRE+jtbXe8SdmmCeGFXOFsbriR/4vlefV75IKn1g
         EQc/BOlEqEtZd+4D0C0rmZFmHrDVpJC8mT87yK3HZtVwC3TSmVF9b0FDWTb1Rqomlw3f
         Ul6KMtsqQu/xEim39mGZh72Jqea5dAb7p2qfgU4rdYSevBn2k1Q9mk3e1MjCSsDT4QX5
         TTukS14Hed1f+xKEQpvcyO+O0u5ZlLi9oqvRsmCbKB/45lEBRu08wPZCIt3CJiRUXYib
         Cb/g==
X-Gm-Message-State: AElRT7GKi4FwewRNnKrtH55KsIeSZMLW540f0CObP9htMFlE7/eLnWSB
        +ZOD6/xBt0//EXAMddjJtc3QwXYDLso=
X-Google-Smtp-Source: AG47ELs1sqDKYXKHHwwIC9u8xlaZgN0063TQYXBOYu9XBPYK1SCxLcF5ydctDOrSQ0i8yGXfPyNanQ==
X-Received: by 10.55.143.1 with SMTP id r1mr53129403qkd.240.1522011083556;
        Sun, 25 Mar 2018 13:51:23 -0700 (PDT)
Received: from localhost.localdomain (pool-74-109-218-108.pitbpa.fios.verizon.net. [74.109.218.108])
        by smtp.gmail.com with ESMTPSA id 72sm10217537qtf.53.2018.03.25.13.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 13:51:22 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v7 0/3] RUNTIME_PREFIX relocatable Git
Date:   Sun, 25 Mar 2018 16:51:17 -0400
Message-Id: <20180325205120.17730-1-dnj@google.com>
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

This is a minor update based on comments from the v6 series. If all's
well, I'm hoping this set is good to go.

Previous threads:
v1: https://public-inbox.org/git/20171116170523.28696-1-dnj@google.com/
v2: https://public-inbox.org/git/20171119173141.4896-1-dnj@google.com/
v3: https://public-inbox.org/git/20171127164055.93283-1-dnj@google.com/
v4: https://public-inbox.org/git/20171129223807.91343-1-dnj@google.com/
v5: https://public-inbox.org/git/20180108030239.92036-1-dnj@google.com/
v5: https://public-inbox.org/git/20180108030239.92036-1-dnj@google.com/
v6: https://public-inbox.org/git/20180319025046.58052-1-dnj@google.com/

Changes in v7 from v6:

- Change Perl header based on avarab@'s suggestion.
- Rearranged Makefile lines to align with avarab@'s patch in next.
- Fix typos in commit messages and comments.

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

Changes in v6 from v5:

- Rebased on top of "master".
- Updated commit messages.
- Updated runtime prefix Perl header comment and code to clarify when and
  why FindBin is used.
- With Johannes' blessing on Git-for-Windows, folded "RUNTIME_PREFIX_PERL"
  functionality into "RUNTIME_PREFIX".
- Updated "run-command" test to accommodate RUNTIME_PREFIX trace messages.

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
 Makefile                                         | 122 ++++++++++--
 cache.h                                          |   1 +
 common-main.c                                    |   4 +-
 config.mak.uname                                 |   7 +
 exec_cmd.c                                       | 236 ++++++++++++++++++++---
 exec_cmd.h                                       |   4 +-
 gettext.c                                        |   8 +-
 git.c                                            |   2 +-
 perl/Git/I18N.pm                                 |   2 +-
 perl/header_templates/fixed_prefix.template.pl   |   1 +
 perl/header_templates/runtime_prefix.template.pl |  42 ++++
 t/t0061-run-command.sh                           |   2 +-
 13 files changed, 380 insertions(+), 52 deletions(-)
 create mode 100644 perl/header_templates/fixed_prefix.template.pl
 create mode 100644 perl/header_templates/runtime_prefix.template.pl

-- 
2.15.0.chromium12

