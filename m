Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E57202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 17:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936252AbdKPRGK (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 12:06:10 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:56796 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935619AbdKPRF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 12:05:59 -0500
Received: by mail-yw0-f196.google.com with SMTP id r186so11487820ywe.13
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X/peEBudJ8gICenoAvhfcXdmj69YhZWd/wXNKSahIGE=;
        b=UV0EeEt1Z0JHNscY2BWEu/BoXTHtiY7lEAplTO93FRCOOpC/3+hLf1z6YQCG9GfxXX
         VCD+f0fMaPXUGmmtrbYffnCMf+HbArwPN8jAzVHEZngyouoAEAtaLWQbD9YSJrZJRqTP
         Y0ohlqGNCJPQzdSIM2uDM52NJY06Pkvxv7oI7022OkU0nVcDDEalqfW0//NsBwQ8FT6E
         2204RZeqCiFNVGSWHVZ9iBCEVSLP1jkHmFVpPb/+wPbbeShVWQla6ZdIzv7I3k9y2Bjn
         pducqXfGaMI2PjjnFXEMfMiKUISMdurOSmIZtbXw0yrIZEabGM4X+kNQ76SXc37xguHZ
         Ta5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X/peEBudJ8gICenoAvhfcXdmj69YhZWd/wXNKSahIGE=;
        b=UCqibz4UVZnlbstxSmQwFYkmWr9uH2DCmAXb38fltw3pSzXIWCSBk3ukuq2lWZSDkp
         htqn4yBQCOUFhkK4r7bNIsl5AzlEJGh7WoXgrFIiVRjZc/U/3IgrTScegkfPI7MUJWdC
         6zjmD3ON74eFTDrAAUPlg4ZRdWItGIKGiOwyGdd4ak8vLKRicz9sl6nZyD7dmPT0MBai
         epGwKAT6dlve3Q3zJhmct2onuAs8tJIkbM2iO0/ga66NC1M/QCSqRwlwqbWvj8qGTLJO
         itv9ay7SQKdIYWPEwJR99oyypzrSYiXD2T/RJIsOkWkxTWVJd4E4j1vsjz0YVteNoZzL
         wT+w==
X-Gm-Message-State: AJaThX7VrnQlXLgb32Z0oIEq2vebzu1xNzXX9SX0jLOyl9KZMt9Owo/O
        nWm3rXuZZWJemOsp0LLkQnHnyvqdVpM=
X-Google-Smtp-Source: AGs4zMZ41mGmf7dPlRwa8Y24qgx+yVHhuAa3av0OOzmvOMs1VxAvAK7S6AgvzQ/y/iXxZNuIBrkhZg==
X-Received: by 10.13.234.151 with SMTP id t145mr1442706ywe.422.1510851956996;
        Thu, 16 Nov 2017 09:05:56 -0800 (PST)
Received: from dnj.pit.corp.google.com ([2620:0:1019:0:5840:7173:18ff:ed41])
        by smtp.gmail.com with ESMTPSA id f4sm601077ywa.68.2017.11.16.09.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 09:05:56 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     Dan Jacques <dnj@google.com>
Subject: [PATCH 0/1] RUNTIME_PREFIX on POSIX systems.
Date:   Thu, 16 Nov 2017 12:05:22 -0500
Message-Id: <20171116170523.28696-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.170.g1a936b6eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello! This would be my first contribution to the Git project, so please
accept my apology in advance for any mistakes and let me know what I can
do better.

This patch expands support for the RUNTIME_PREFIX configuration flag,
currently only used on Windows builds, to include Linux, Darwin, and
FreeBSD. When Git is built with RUNTIME_PREFIX enabled, it resolves its
ancillary paths relative to the runtime location of its executable
rather than hard-coding them at compile-time, allowing a Git
installation to be deployed to a path other than the one in which it
was installed.

It was useful to create Git distribution bundles that could unpack
fully-functional Git deployments to arbitrary locations in support of the
Chromium project. Chromium has been using Git bundles built with a patch
similar to this one on its Linux and Mac continuous integration fleet (plus
some developer systems) for almost a year now.

RUNTIME_PREFIX remains an optional configuration flag, so standard Git
builds will not see any changes. However, with this patch applied,
Linux, Darwin, and FreeBSD users can now optionally use "config.mak" to
enable RUNTIME_PREFIX and build relocatable Git distributions. An
example "config.mak" that builds relocatable Git binaries for Linux/Mac
is:

# BEGIN: config.mak
RUNTIME_PREFIX = YesPlease
gitexecdir = libexec/git-core
template_dir = share/git-core/templates
sysconfdir = etc
# END: config.mak

Implementation notes:

It is unfortunately not straightforward to resolve the full absolute path
of the currently-running binary. On some operating systems, notably
Windows, this path is executively supplied as argv[0]. On other
operating systems, however, argv[0] is supplied by the invoker (shell,
script, kernel, etc.), and is not a reliable source of information about
the running Git binary.

The specific method that this patch employs for binary directory resolution
varies depending on the operating system. On Linux and FreeBSD,
Git resolves "/proc/self/exe" and "/proc/curproc/file" respectively. On
Darwin, Git uses the "_NSGetExecutablePath" function. On all operating
systems, notably Windows, Git continues to fall back to resolution
against argv[0] when it is an absolute path.

When RUNTIME_PREFIX is enabled, the resolved runtime path needs to be
passed to ancillary Git tools for their own resolution requirements:

- C-source Git programs will use the EXEC_PATH_ENVIRONMENT environment
  variable that Git already exports, ensuring that any launched tools use
  the same runtime prefix as the entry point.

- PERL tooling needs to know how to locate Git's support libraries. When
  RUNTIME_PREFIX is configured, Git now exports the GITPERLLIB environment
  variable, a mechanism that Git's PERL tooling supports that appears to be
  built for testing. PERL scripts installed using MakeMaker incorporate the
  builder system's PERL version into their installation path, making
  it inconsistent to hard-code; consequently, this patch opts to disable
  MakeMaker for RUNTIME_PREFIX builds in order to deterministically control
  the destination of Git's support libraries.

- Git also exports the GIT_TEXTDOMAINDIR environment variable when
  RUNTIME_PREFIX is set so that its locale configuration can be leveraged
  by Git tooling gettext().

Please note that this patch affects Windows Git builds, since the Windows
Git project uses RUNTIME_PREFIX to support arbitrary installation paths.
Notably, PERL scripts are now always installed without MakeMaker (if they
weren't before), and EXEC_PATH_ENVIRONMENT is preferred by tools instead of
re-resolving argv[0]. Chromium uses the stock redistributable Windows Git
package, so I haven't had an opportunity to test this patch on that
platform.

Please take a look and let me know what you think. Thanks!
-Dan

Dan Jacques (1):
  exec_cmd: RUNTIME_PREFIX on some POSIX systems

 Makefile               |  29 ++++++--
 builtin/receive-pack.c |   2 +-
 cache.h                |   2 +
 common-main.c          |   4 +-
 config.mak.uname       |   4 ++
 exec_cmd.c             | 189 +++++++++++++++++++++++++++++++++++++++++++------
 exec_cmd.h             |   6 +-
 gettext.c              |   7 +-
 git.c                  |   7 +-
 http-backend.c         |   2 +-
 shell.c                |   2 +-
 upload-pack.c          |   2 +-
 12 files changed, 217 insertions(+), 39 deletions(-)

-- 
2.15.0.448.gf294e3d99a-goog

