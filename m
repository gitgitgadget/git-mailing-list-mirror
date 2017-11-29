Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6E120A40
	for <e@80x24.org>; Wed, 29 Nov 2017 15:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755379AbdK2P4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 10:56:49 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:37671 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753377AbdK2P4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 10:56:45 -0500
Received: by mail-qt0-f181.google.com with SMTP id d15so4912499qte.4
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 07:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/1gcYjuq8R3D/ScADpyxvp94pYxFi+q3ctPNT2gGfc=;
        b=kHx4HdaHXPrsnL2cjaAtbkJwE/DHV7CgBiwni48kEGBSiXgc/Nw2F5NmIIoPJDn4MZ
         Hj7w650+6+KQPT6LqzycZHdPgRI7hJ5qwB7Q5FwvswV0b6ZZBJ4ihzdH5LmNWrjBjQxp
         reF5XeNMQO/jG3RBvzGzbAJmrjjkv01GMw01jV3VXtGDMTng9Yck7yh/+BpgT/w9hEAK
         wF9XuPB0BOaFCuEJaQeU5u/Fq3MdvCZaiR1n2+gOVBdAKrPG+tgcTiknjwkGf91ebykU
         SzVjZkIfpqjB0r5K1vUpBY6AZOQWEuIiS4wI6q9JDHYTnba+JhsCoo8S2vTQSFkxKJSe
         H2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/1gcYjuq8R3D/ScADpyxvp94pYxFi+q3ctPNT2gGfc=;
        b=hcEHXmJdbVlQJQZN/XhvCXjjZ22Q2rOc7bCZZZezI5WRG5bOWpF8caGUA+7cRNW9AL
         3L//FdBbFub3foKSuk8t3W2+hGg+q3nAz1WmkWzEaRX5a3qDW2RtaTjCcBwEQM+SKyC/
         kpZku8CE8hk94XiB0wlXNGT5rMkNmT4TUkeKAOsoBqVx477/DYxgXUVuY7mMPb/CsmhU
         O/GiW6+HCoRBLzAhr0EADomE0hfTb5enqV3mu6hNnTJMYNNxx6HECSyKeM/yV4mPnwNb
         vYzx+1XmJ7TdYPG0zEw/G9w21K//lrkFcvvmWqmFSIa+1xzqbqc7FqwsER6B0sS66FA2
         Hiwg==
X-Gm-Message-State: AJaThX67BLRHSw2ICsOrMgSfBa/LAdV4z4PZD741Tbj8H2AR8eKHeq0m
        JrCW/j5CsxhREDHxxW4FJL5PueNzQwM=
X-Google-Smtp-Source: AGs4zMY1S/4tPlltkkaHncE1mkPySadeuPbjkvtnetrTY3XP+lPNyJRI36J5rnJQALyxL45MuhOqQw==
X-Received: by 10.200.50.116 with SMTP id y49mr5287535qta.10.1511971003864;
        Wed, 29 Nov 2017 07:56:43 -0800 (PST)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.103])
        by smtp.gmail.com with ESMTPSA id z126sm1390465qka.70.2017.11.29.07.56.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 07:56:43 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v4 0/4] RUNTIME_PREFIX relocatable Git
Date:   Wed, 29 Nov 2017 10:56:33 -0500
Message-Id: <20171129155637.89075-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous threads:
v1: https://public-inbox.org/git/20171116170523.28696-1-dnj@google.com/
v2: https://public-inbox.org/git/20171119173141.4896-1-dnj@google.com/
v3: https://public-inbox.org/git/20171127164055.93283-1-dnj@google.com/

This is a small update to incorporate some Windows fixes from Johannes.
At this point, it passes the full test suite on Linux, Mac, and FreeBSD,
as well as the Travis.ci test suites, with and without
RUNTIME_PREFIX/RUNTIME_PREFIX_PERL flags.

I'm happy with the patch set, and feel that it is ready to move forward.
However, while it's been looked at by several people, and I have
incorporated reviewer feedback, the patch set hasn't received any formal
LGTM-style responses yet. I'm not sure what standard of review is required
to move forward with a patch on this project, so maybe this is totally
fine, but I wanted to make sure to point this out.

I also want to note Ævar Arnfjörð Bjarmason's RFC:
https://public-inbox.org/git/20171129153436.24471-1-avarab@gmail.com/T/

The proposed patch set conflicts with the Perl installation directory
changes in this patch set, as avarab@ notes. The proposed Perl installation
process would simplify patch 0002 in this patch set. I don't think the
landing order is terribly impactful - if this lands first, the patch in the
RFC would delete a few more lines, and if this lands later, patch 0002
would largely not be necessary.

Cheers,
-Dan

Built using this "config.mak" w/ autoconf:

=== BEGIN config.mak ===

RUNTIME_PREFIX = YesPlease
RUNTIME_PREFIX_PERL = YesPlease
gitexecdir = libexec/git-core
template_dir = share/git-core/templates
sysconfdir = etc

=== END config.mak ===

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

Dan Jacques (4):
  Makefile: generate Perl header from template file
  Makefile: add support for "perllibdir"
  Makefile: add Perl runtime prefix support
  exec_cmd: RUNTIME_PREFIX on some POSIX systems

 .gitignore                             |   1 +
 Makefile                               | 111 +++++++++++++--
 cache.h                                |   1 +
 common-main.c                          |   4 +-
 config.mak.uname                       |   7 +
 exec_cmd.c                             | 239 ++++++++++++++++++++++++++++-----
 exec_cmd.h                             |   4 +-
 gettext.c                              |   8 +-
 git.c                                  |   2 +-
 perl/Makefile                          |  52 ++++++-
 perl/header_fixed_prefix.pl.template   |   1 +
 perl/header_runtime_prefix.pl.template |  24 ++++
 12 files changed, 396 insertions(+), 58 deletions(-)
 create mode 100644 perl/header_fixed_prefix.pl.template
 create mode 100644 perl/header_runtime_prefix.pl.template

-- 
2.15.0.chromium12

