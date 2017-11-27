Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C7420C11
	for <e@80x24.org>; Mon, 27 Nov 2017 16:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbdK0QlH (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 11:41:07 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:37755 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbdK0QlC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 11:41:02 -0500
Received: by mail-qk0-f176.google.com with SMTP id 136so33212179qkd.4
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jcm+gg5KtaC5VJWp/Y0s290FAobx1IvnP4J8iCfJOkQ=;
        b=m/xnizwxoMFGLj/LyguPQXIRL9XpPnNIjYxxuJPNFxr7EdjyO47BD/b2AZREtZ2W1g
         DJ/ElAIa61HU4pg8ofZ/hHx6Re+ziPX8zdgKrl0cD4k/2m4yythlN0QwHVzxS54couNc
         HMfRkYiiHppY9ptjLLT12hnT60XNL4kfH7hrdoroFdtwm/N6JgDb5S9veXj2GNBvNjLF
         sKdMVMmJBy/oca2lmdmATSH7gyRV+8N0OgUcl08nQd3oR7UuzcpWGu3JcA/Apcc5qW3P
         m/TQI97Jeox6uMzDI/BhnZwa7wElz9yf3d+r55CIwRTaQCOIH3o4rT+wW8YIf6OXCLsy
         Bt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jcm+gg5KtaC5VJWp/Y0s290FAobx1IvnP4J8iCfJOkQ=;
        b=L0dt6u4PLIU7kYr8hcbbZmO6uA30cFSAWWjNgOoIFITNK1pWLxmyLNC1QgVtrVTy6+
         0B8EiFQrNKHaRwcyZMcp8I13TMTLlcAYR8U/9x/FwCjMpExRRBOxcDRgBiEFb/yzMJg4
         NXfHpO5pAdS0E8URObTCHI3trntq/mWiN1j5EzPukuzMi40vMscZXRXSQbyCtHVmCcWp
         GGPGFzot9us0RtE535p2/5MVEwQ3P1zAQOi7NQBTkWgv8ps7/CBBix6qZbr9gMm1U0xQ
         WZTjH8bEIN6sdMkYvOUB56+g3HKmq04mB0+PoHjVvyy67k99FzxSXh+4BXpZ1pgLLWXF
         RbhA==
X-Gm-Message-State: AJaThX5NRZlSNflvzEnzAV77Ra2hQMAYbwmhtwlXVAhXhg8ymcdqY7SJ
        7gQTGnlNrCdUxTj8fWbmxdj8AWV8sHA=
X-Google-Smtp-Source: AGs4zMa4zZaZhzTkxLM0pr0PsTb5yYAhkPEp89jM2zeiSvVyki8iqd6eMLy5rP3LdDPHLpO+aXDKFA==
X-Received: by 10.55.12.13 with SMTP id 13mr55115471qkm.341.1511800860902;
        Mon, 27 Nov 2017 08:41:00 -0800 (PST)
Received: from dnj-macbookpro.fios-router.home (pool-108-32-46-175.pitbpa.fios.verizon.net. [108.32.46.175])
        by smtp.gmail.com with ESMTPSA id y9sm9696394qkl.17.2017.11.27.08.40.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 08:41:00 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, dnj@google.com,
        gitster@pobox.com
Subject: [PATCH v3 0/4] RUNTIME_PREFIX relocatable Git
Date:   Mon, 27 Nov 2017 11:40:51 -0500
Message-Id: <20171127164055.93283-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous threads:
v1: https://public-inbox.org/git/20171116170523.28696-1-dnj@google.com/
v2: https://public-inbox.org/git/20171119173141.4896-1-dnj@google.com/

After working with avarab@, I isolated the Perl changes into a separate
set of patches and adapted the code to be more correct and readable. I
opted to prescribe a relative Perl library path instead of letting
MakeMaker or the Config module choose one, since the latter both
incorporate build system parameters and a major purpose of this is to be
portable between ABI-compatible systems.

I've tested this via Travis and run full test suite with and without
RUNTIME_PREFIX/RUNTIME_PREFIX_PERL, and tested locally on Mac, Linux,
and FreeBSD systems. Please take a look!

Built using this "config.mak":

=== BEGIN config.mak ===

RUNTIME_PREFIX = YesPlease
RUNTIME_PREFIX_PERL = YesPlease
gitexecdir = libexec/git-core
template_dir = share/git-core/templates
sysconfdir = etc

=== END config.mak ===

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
 Makefile                               | 110 +++++++++++++--
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
 12 files changed, 395 insertions(+), 58 deletions(-)
 create mode 100644 perl/header_fixed_prefix.pl.template
 create mode 100644 perl/header_runtime_prefix.pl.template

-- 
2.15.0.chromium12

