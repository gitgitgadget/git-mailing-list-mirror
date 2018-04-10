Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA991F404
	for <e@80x24.org>; Tue, 10 Apr 2018 15:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeDJPGB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 11:06:01 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:46364 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbeDJPGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 11:06:00 -0400
Received: by mail-qk0-f173.google.com with SMTP id p67so13697999qke.13
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dxoE+JD89fiJg8FMUrfsRiFMcsAv9QUBx5Hsy3YzUMI=;
        b=BBs1WBHkxhff0EV9GfK4VblG1IYyIDg+T0R/4sFdiS/q2zuSnypSLEQZOpBNnsmxme
         YzE8DrES99rQ8k11OAxWfAZ51BhmgL6YRRW0nneg/eLauKTeZdun8I93jExGxz26tv0A
         BcQKVQbV8Gdi+MaioJezd6guh0GT0s/ueweKWgHoGgu5xEpIX4VLGFTuCKgXLnsi6sCi
         b+R8r+dXvyC6w/C3hzntyhLNRrSrCnfTArE+F9c/CKT3sodIyBhqnr7r4HoLf7RjM78y
         kHNimwsV8IrB7j2LHFZIPTag/qzk4OqqsrqI8SolxuDOAmPGL8CnY2NsKWfr8sOOU+SK
         xRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dxoE+JD89fiJg8FMUrfsRiFMcsAv9QUBx5Hsy3YzUMI=;
        b=pKApNx2csPte1XAfXuwO3ucMlqewsmdJjxVBWIoUNSZOmVTLlVr8CMxjSq5uu/M2Vb
         uCloIdY3JPVnx4R090Bn4DTHHTIkbLrnVDc72RpqA2+kGbQ5x4nI5FqPvrdrO0GUqb8k
         YLAXPTJcOslRJAsg8FU3gH6uJnaU2x8fp8KRV0lO96wiRydm0sNXC+qvyOi4QBn9Sfh9
         T1CpNjMgGcV6Z4PFXqA+Cpvbqqo7Hl4TNeUm0ONvH8WgiJY6bXFiCqcg/hd5HcsUdxbA
         AnBst+DDHnY6T/oFPybR8+Z1Tz8EirQ/W4mfPiXdQUD6Of7souSu+v+M3Qp18vPmyTWJ
         0sfQ==
X-Gm-Message-State: ALQs6tA2LJn2AeMMBGp4ryJvScmRnM8vmm+oFp6sF/UZF4R3TJn56k3X
        P1x5TgaG4Eg0u7T+WgK57+5QUcVoBm0=
X-Google-Smtp-Source: AIpwx48NsTEucMwjSG8fIvdL0LN8IFtQ20lPDGQQ/dDWuxeTUNdOZC0U21cRspIYRBeLkzsd7DGFEw==
X-Received: by 10.55.34.129 with SMTP id i123mr1109982qki.119.1523372757177;
        Tue, 10 Apr 2018 08:05:57 -0700 (PDT)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.96])
        by smtp.gmail.com with ESMTPSA id c137sm2333526qkb.2.2018.04.10.08.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 08:05:54 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v8 0/5] RUNTIME_PREFIX relocatable Git
Date:   Tue, 10 Apr 2018 11:05:41 -0400
Message-Id: <20180410150546.38062-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a minor update based on comments from the v6 series.
I'm hoping this set is good to go!

This patch set expands support for the RUNTIME_PREFIX configuration flag,
currently only used on Windows builds, to include Linux, Darwin, and
FreeBSD. When Git is built with RUNTIME_PREFIX enabled, it resolves its
ancillary paths relative to the runtime location of its executable
rather than hard-coding them at compile-time, allowing a Git
installation to be deployed to a path other than the one in which it
was built/installed.

Note that RUNTIME_PREFIX is not currently used outside of Windows.
This patch set should not have an impact on default Git builds.

Previous threads:
v1: https://public-inbox.org/git/20171116170523.28696-1-dnj@google.com/
v2: https://public-inbox.org/git/20171119173141.4896-1-dnj@google.com/
v3: https://public-inbox.org/git/20171127164055.93283-1-dnj@google.com/
v4: https://public-inbox.org/git/20171129223807.91343-1-dnj@google.com/
v5: https://public-inbox.org/git/20180108030239.92036-1-dnj@google.com/
v5: https://public-inbox.org/git/20180108030239.92036-1-dnj@google.com/
v6: https://public-inbox.org/git/20180319025046.58052-1-dnj@google.com/
v7: https://public-inbox.org/git/20180325205120.17730-1-dnj@google.com/

Changes in v8 from v7:

- Add Johannes's Windows patch series to the end (see v7 thread).
- Fix more typos and formatting nits.
- Rebased on top of "master".


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

Changes in v7 from v6:

- Change Perl header based on avarab@'s suggestion.
- Fix typos in commit messages and comments.

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

Johannes Schindelin (2):
  exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
  mingw/msvc: use the new-style RUNTIME_PREFIX helper

 .gitignore                                       |   1 +
 Makefile                                         | 128 +++++++++--
 cache.h                                          |   1 +
 common-main.c                                    |   4 +-
 compat/mingw.c                                   |   5 +-
 config.mak.uname                                 |   9 +
 exec_cmd.c                                       | 258 ++++++++++++++++++++---
 exec_cmd.h                                       |   4 +-
 gettext.c                                        |   8 +-
 git.c                                            |   2 +-
 perl/Git/I18N.pm                                 |   2 +-
 perl/header_templates/fixed_prefix.template.pl   |   1 +
 perl/header_templates/runtime_prefix.template.pl |  42 ++++
 t/t0061-run-command.sh                           |   2 +-
 14 files changed, 412 insertions(+), 55 deletions(-)
 create mode 100644 perl/header_templates/fixed_prefix.template.pl
 create mode 100644 perl/header_templates/runtime_prefix.template.pl

-- 
2.15.0.chromium12

