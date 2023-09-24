Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABC6CE7A8A
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 10:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjIXK5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 06:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXK5k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 06:57:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB81100
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:57:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so4493328f8f.2
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695553046; x=1696157846; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gAmOcXsIf4o46XwexB7OYp1J+CnxWas+eJ8+SVDKJw=;
        b=PV4vDTuZgUdX3E/7Vytl/6QBzc9MfD2tZGKtYMBBnNKhtmYX+TJT2/EkBx3dCnQCmn
         AyWvFoWjj00x4tAGJGyktBfYw8XLH6lkpyP7migVSOLvkXbqYhQaVLWnvR/FRI3MfZ7F
         IsbOKdh2bPcYP3E57MlHKG1fdB635hSp82ZQLQGw1L6gTlA6uDJjimP+4PC9eHQltIdn
         91Hyy9DPR1Rm4+O32ahPNNlm8tWGKuZ53VZS0D1I1lo69LUg9zMaKJUEizlUvwQnTURu
         BrzWREey3h3Dlg542n2qAgXmpKOAsHN5Mb26yPtaRnazOn5KzWa1NG9+0+tXWiHknfWH
         LoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553046; x=1696157846;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gAmOcXsIf4o46XwexB7OYp1J+CnxWas+eJ8+SVDKJw=;
        b=T+l4jb4fRnQBWP13gB8sdsl+G6pV3utvq3ORsPW7C+qTpMUsCX6RySvKPaNhoPW69X
         iygIcDk+BjHVeC4+RRO3yVTG5YQbGvZ5DZjN4MPDYSELP9k7RGaaEaLXOyoUmF7NPnjc
         vnoBnKmPauc9CfMGWylUPpTenYA3pWB9GWJ+xinzUTPv0UxxIZ7kXcepE1WSchXS5UhA
         irqXT2odnMmbGdfHOUfJLzvCHI4WR15KqzrRhX1zR+a1PxffzentII3RVWF2mDLmcHiF
         yDso8lBfAleSkHbln2qtAfL67JA94P71zWQRH87KqLZczTFrdI7BcUMKg8d0az3jLfbz
         jSAA==
X-Gm-Message-State: AOJu0Yw0pO3oD5sWiZvGAhPqt73G2vIqatto+05AQsrn7yp6c+rOHrJX
        9woglH/lVSN7Uh3nuCf2wzdCTz3ZJBc=
X-Google-Smtp-Source: AGHT+IF/Ip5Q9ho6e5icmwzdy0pjNR25le3xI4eYyuk4dyCHmI5UESVYsjqxCjx0UDV2as7Obl13ig==
X-Received: by 2002:adf:ed0d:0:b0:315:9676:c360 with SMTP id a13-20020adfed0d000000b003159676c360mr3638958wro.25.1695553045498;
        Sun, 24 Sep 2023 03:57:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d46c7000000b0031fbbe347e1sm9045723wrs.65.2023.09.24.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 03:57:25 -0700 (PDT)
Message-ID: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Sep 2023 10:57:17 +0000
Subject: [PATCH v2 0/4] Switch links to https
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a couple of categories of http links

 * links that are required to be http: because they're copied from something
   that mandates it (the apache license, xml namespaces, xsl docbook
   things?)
 * pages which exist at both http: and https: and can be safely switched
 * pages that have jittered a bit but are now available as https:
 * pages that have jittered a bit and are not available over https:
 * pages that are gone and for which the best source is
   https://web.archive.org
 * urls that were imaginary

In order:

 * doc: switch links to https -- the simplest
 * doc: update links to current pages -- I found the current pages for
   these, it should be easy enough to verify these / reject them
 * doc: update links for andre-simon.de -- I've split this out, I don't like
   the idea of having to download binaries over http. If this were my
   project, I'd be tempted to remove the feature or self-host w/ https...
 * doc: refer to internet archive -- the original urls are dead, I've found
   internet archive date links for them. (There are some in git already, so
   this seemed like a very reasonable choice.)

cc: Eric Sunshine sunshine@sunshineco.com cc: Josh Soref jsoref@gmail.com

 * Commit messages have been adjusted since v1
 * files were dropped based on feedback from Junio

Josh Soref (4):
  doc: switch links to https
  doc: update links to current pages
  doc: update links for andre-simon.de
  doc: refer to internet archive

 Documentation/CodingGuidelines                       |  4 ++--
 Documentation/MyFirstContribution.txt                |  2 +-
 Documentation/RelNotes/1.6.2.txt                     |  2 +-
 Documentation/RelNotes/1.6.3.txt                     |  2 +-
 Documentation/RelNotes/1.6.4.txt                     |  2 +-
 Documentation/RelNotes/1.6.5.txt                     |  2 +-
 Documentation/RelNotes/1.6.6.txt                     |  2 +-
 Documentation/git-cvsimport.txt                      |  4 ++--
 Documentation/git-format-patch.txt                   |  4 ++--
 Documentation/git-imap-send.txt                      |  2 +-
 Documentation/git-send-email.txt                     |  2 +-
 Documentation/git.txt                                |  2 +-
 Documentation/gitcore-tutorial.txt                   |  2 +-
 Documentation/gitprotocol-http.txt                   |  4 ++--
 Documentation/gitweb.conf.txt                        |  4 ++--
 Documentation/gitweb.txt                             |  2 +-
 .../howto/keep-canonical-history-correct.txt         |  2 +-
 Documentation/signoff-option.txt                     |  2 +-
 INSTALL                                              |  2 +-
 Makefile                                             |  4 ++--
 README.md                                            |  2 +-
 git-cvsimport.perl                                   |  2 +-
 git-gui/git-gui.sh                                   |  6 +++---
 git-gui/lib/encoding.tcl                             |  2 +-
 git-gui/po/README                                    |  2 +-
 git-instaweb.sh                                      |  4 ++--
 gitk-git/gitk                                        |  4 ++--
 gitweb/INSTALL                                       |  2 +-
 gitweb/gitweb.perl                                   | 12 ++++++------
 gitweb/static/gitweb.css                             |  2 +-
 gitweb/static/js/lib/common-lib.js                   | 10 +++++-----
 graph.h                                              |  4 ++--
 http.c                                               |  2 +-
 imap-send.c                                          |  4 ++--
 json-writer.h                                        |  4 ++--
 kwset.c                                              |  2 +-
 kwset.h                                              |  2 +-
 list.h                                               |  2 +-
 perl/FromCPAN/Error.pm                               |  2 +-
 perl/Git/SVN.pm                                      |  2 +-
 protocol.h                                           |  2 +-
 sh-i18n--envsubst.c                                  |  4 ++--
 sha1dc/sha1.c                                        |  2 +-
 t/README                                             |  4 ++--
 t/helper/test-regex.c                                |  2 +-
 t/lib-gpg.sh                                         |  2 +-
 t/perf/perf-lib.sh                                   |  2 +-
 t/t9114-git-svn-dcommit-merge.sh                     |  2 +-
 t/t9801-git-p4-branch.sh                             |  2 +-
 t/t9816-git-p4-locked.sh                             |  2 +-
 t/test-lib-functions.sh                              |  2 +-
 t/test-lib-github-workflow-markup.sh                 |  2 +-
 t/test-lib-junit.sh                                  |  2 +-
 t/test-lib.sh                                        |  2 +-
 trace.c                                              |  2 +-
 utf8.c                                               |  2 +-
 utf8.h                                               |  6 +++---
 57 files changed, 83 insertions(+), 83 deletions(-)


base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1589%2Fjsoref%2Fhttps-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1589/jsoref/https-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1589

Range-diff vs v1:

 1:  b80c6089653 ! 1:  71ed1286d7f doc: switch links to https
     @@ Metadata
       ## Commit message ##
          doc: switch links to https
      
     +    It's somewhat traditional to respect sites' self-identification.
     +
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
       ## Documentation/CodingGuidelines ##
     @@ README.md: string translations (localization l10) should see [po/README.md][]
       Issues which are security relevant should be disclosed privately to
       the Git Security mailing list <git-security@googlegroups.com>.
      
     - ## compat/nedmalloc/malloc.c.h ##
     -@@
     - /*
     -   This is a version (aka dlmalloc) of malloc/free/realloc written by
     -   Doug Lea and released to the public domain, as explained at
     --  http://creativecommons.org/licenses/publicdomain.  Send questions,
     -+  https://creativecommons.org/licenses/publicdomain.  Send questions,
     -   comments, complaints, performance data, etc to dl@cs.oswego.edu
     - 
     - * Version pre-2.8.4 Mon Nov 27 11:22:37 2006    (dl at gee)
     -@@
     -        like memset.
     - 
     -   Compliance: I believe it is compliant with the Single Unix Specification
     --       (See http://www.unix.org). Also SVID/XPG, ANSI C, and probably
     -+       (See https://www.unix.org). Also SVID/XPG, ANSI C, and probably
     -        others as well.
     - 
     - * Overview of algorithms
     -@@
     -   ignored.
     - 
     -   For a longer but out of date high-level description, see
     --     http://gee.cs.oswego.edu/dl/html/malloc.html
     -+     https://gee.cs.oswego.edu/dl/html/malloc.html
     - 
     - * MSPACES
     -   If MSPACES is defined, then in addition to malloc, free, etc.,
     -@@ compat/nedmalloc/malloc.c.h: typedef struct malloc_segment* msegmentptr;
     -     conservatively use 32 bits per map word, even if on 64bit system.
     -     For a good description of some of the bit-based techniques used
     -     here, see Henry S. Warren Jr's book "Hacker's Delight" (and
     --    supplement at http://hackersdelight.org/). Many of these are
     -+    supplement at https://www.hackersdelight.org/). Many of these are
     -     intended to reduce the branchiness of paths through malloc etc, as
     -     well as to reduce the number of memory locations read or written.
     - 
     -@@ compat/nedmalloc/malloc.c.h: static size_t traverse_and_check(mstate m);
     -   that the mstate controlling malloc/free is intact.  This is a
     -   streamlined version of the approach described by William Robertson
     -   et al in "Run-time Detection of Heap-based Overflows" LISA'03
     --  http://www.usenix.org/events/lisa03/tech/robertson.html The footer
     -+  https://www.usenix.org/events/lisa03/tech/robertson.html The footer
     -   of an inuse chunk holds the xor of its mstate and a random seed,
     -   that is checked upon calls to free() and realloc().  This is
     -   (probablistically) unguessable from outside the program, but can be
     -
     - ## compat/obstack.c ##
     -@@
     - 
     -    You should have received a copy of the GNU Lesser General Public
     -    License along with the GNU C Library; if not, see
     --   <http://www.gnu.org/licenses/>.  */
     -+   <https://www.gnu.org/licenses/>.  */
     - 
     - #include "git-compat-util.h"
     - #include <gettext.h>
     -
     - ## compat/obstack.h ##
     -@@
     - 
     -    You should have received a copy of the GNU Lesser General Public
     -    License along with the GNU C Library; if not, see
     --   <http://www.gnu.org/licenses/>.  */
     -+   <https://www.gnu.org/licenses/>.  */
     - 
     - /* Summary:
     - 
     -
     - ## compat/poll/poll.c ##
     -@@
     -    GNU General Public License for more details.
     - 
     -    You should have received a copy of the GNU General Public License along
     --   with this program; if not, see <http://www.gnu.org/licenses/>.  */
     -+   with this program; if not, see <https://www.gnu.org/licenses/>.  */
     - 
     - /* To bump the minimum Windows version to Windows Vista */
     - #include "git-compat-util.h"
     -
     - ## compat/poll/poll.h ##
     -@@
     -    GNU General Public License for more details.
     - 
     -    You should have received a copy of the GNU General Public License along
     --   with this program; if not, see <http://www.gnu.org/licenses/>.  */
     -+   with this program; if not, see <https://www.gnu.org/licenses/>.  */
     - 
     - #ifndef _GL_POLL_H
     - #define _GL_POLL_H
     -
     - ## compat/precompose_utf8.h ##
     -@@ compat/precompose_utf8.h: typedef struct dirent_prec_psx {
     - 	unsigned char d_type;   /* available on all systems git runs on */
     - 
     - 	/*
     --	 * See http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html
     -+	 * See https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html
     - 	 * NAME_MAX + 1 should be enough, but some systems have
     - 	 * NAME_MAX=255 and strlen(d_name) may return 508 or 510
     - 	 * Solution: allocate more when needed, see precompose_utf8_readdir()
     -
     - ## compat/regex/regcomp.c ##
     -@@
     - 
     -    You should have received a copy of the GNU Lesser General Public
     -    License along with the GNU C Library; if not, see
     --   <http://www.gnu.org/licenses/>.  */
     -+   <https://www.gnu.org/licenses/>.  */
     - 
     - #if defined __TANDEM
     -  /* This is currently duplicated from git-compat-utils.h */
     -
     - ## compat/regex/regex.c ##
     -@@
     - 
     -    You should have received a copy of the GNU Lesser General Public
     -    License along with the GNU C Library; if not, see
     --   <http://www.gnu.org/licenses/>.  */
     -+   <https://www.gnu.org/licenses/>.  */
     - 
     - #ifdef HAVE_CONFIG_H
     - #include "config.h"
     -
     - ## compat/regex/regex.h ##
     -@@
     - 
     -    You should have received a copy of the GNU Lesser General Public
     -    License along with the GNU C Library; if not, see
     --   <http://www.gnu.org/licenses/>.  */
     -+   <https://www.gnu.org/licenses/>.  */
     - 
     - #ifndef _REGEX_H
     - #define _REGEX_H 1
     -
     - ## compat/regex/regex_internal.c ##
     -@@
     - 
     -    You should have received a copy of the GNU Lesser General Public
     -    License along with the GNU C Library; if not, see
     --   <http://www.gnu.org/licenses/>.  */
     -+   <https://www.gnu.org/licenses/>.  */
     - 
     - static void re_string_construct_common (const char *str, int len,
     - 					re_string_t *pstr,
     -
     - ## compat/regex/regex_internal.h ##
     -@@
     - 
     -    You should have received a copy of the GNU Lesser General Public
     -    License along with the GNU C Library; if not, see
     --   <http://www.gnu.org/licenses/>.  */
     -+   <https://www.gnu.org/licenses/>.  */
     - 
     - #ifndef _REGEX_INTERNAL_H
     - #define _REGEX_INTERNAL_H 1
     -
     - ## compat/regex/regexec.c ##
     -@@
     - 
     -    You should have received a copy of the GNU Lesser General Public
     -    License along with the GNU C Library; if not, see
     --   <http://www.gnu.org/licenses/>.  */
     -+   <https://www.gnu.org/licenses/>.  */
     - 
     - static reg_errcode_t match_ctx_init (re_match_context_t *cache, int eflags,
     - 				     int n) internal_function;
     -
     - ## compat/vcbuild/README ##
     -@@ compat/vcbuild/README: The Steps of Build Git with VS2008
     - 
     -    You can either use the binary repository:
     - 
     --       WWW: http://repo.or.cz/w/msvcgit.git
     -+       WWW: https://repo.or.cz/w/msvcgit.git
     -        Git: git clone git://repo.or.cz/msvcgit.git
     --       Zip: http://repo.or.cz/w/msvcgit.git?a=snapshot;h=master;sf=zip
     -+       Zip: https://repo.or.cz/w/msvcgit.git?a=snapshot;h=master;sf=zip
     - 
     -    and call the setup_32bit_env.cmd batch script before compiling Git,
     -    (see repo/package README for details), or the source repository:
     - 
     --       WWW: http://repo.or.cz/w/gitbuild.git
     -+       WWW: https://repo.or.cz/w/gitbuild.git
     -        Git: git clone git://repo.or.cz/gitbuild.git
     -        Zip: (None, as it's a project with submodules)
     - 
     -@@ compat/vcbuild/README: The Steps of Build Git with VS2008
     - 2. Ensure you have the msysgit environment in your path, so you have
     -    GNU Make, bash and perl available.
     - 
     --       WWW: http://repo.or.cz/w/msysgit.git
     -+       WWW: https://repo.or.cz/w/msysgit.git
     -        Git: git clone git://repo.or.cz/msysgit.git
     --       Zip: http://repo.or.cz/w/msysgit.git?a=snapshot;h=master;sf=zip
     -+       Zip: https://repo.or.cz/w/msysgit.git?a=snapshot;h=master;sf=zip
     - 
     -    This environment is also needed when you use the resulting
     -    executables, since Git might need to run scripts which are part of
     -
     - ## contrib/completion/git-completion.bash ##
     -@@ contrib/completion/git-completion.bash: __git_dequote ()
     - #   GNU General Public License for more details.
     - #
     - #   You should have received a copy of the GNU General Public License
     --#   along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+#   along with this program; if not, see <https://www.gnu.org/licenses/>.
     - #
     - #   The latest version of this software can be obtained here:
     - #
     -
     - ## contrib/credential/libsecret/git-credential-libsecret.c ##
     -@@
     -  *  GNU General Public License for more details.
     -  *
     -  *  You should have received a copy of the GNU General Public License
     -- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+ *  along with this program; if not, see <https://www.gnu.org/licenses/>.
     -  */
     - 
     - /*
     -
     - ## contrib/fast-import/import-directories.perl ##
     -@@
     - # GNU General Public License for more details.
     - #
     - # You should have received a copy of the GNU General Public License
     --# along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+# along with this program; if not, see <https://www.gnu.org/licenses/>.
     - #
     - # ------------------------------------------------------------------------
     - 
     -
     - ## contrib/hg-to-git/hg-to-git.py ##
     -@@
     -     GNU General Public License for more details.
     - 
     -     You should have received a copy of the GNU General Public License
     --    along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+    along with this program; if not, see <https://www.gnu.org/licenses/>.
     - """
     - 
     - import os, os.path, sys
     -
     - ## contrib/mw-to-git/t/test-gitmw-lib.sh ##
     -@@ contrib/mw-to-git/t/test-gitmw-lib.sh: wiki_install () {
     - 	if ! test -f $MW_FILENAME
     - 	then
     - 		echo "Downloading $MW_VERSION_MAJOR.$MW_VERSION_MINOR sources ..."
     --		wget "http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/$MW_FILENAME" ||
     -+		wget "https://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/$MW_FILENAME" ||
     - 			error "Unable to download "\
     --			"http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/"\
     -+			"https://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/"\
     - 			"$MW_FILENAME. "\
     - 			"Please fix your connection and launch the script again."
     - 		echo "$MW_FILENAME downloaded in $(pwd)/;" \
     -
     - ## contrib/persistent-https/LICENSE ##
     -@@
     - 
     -                                  Apache License
     -                            Version 2.0, January 2004
     --                        http://www.apache.org/licenses/
     -+                        https://www.apache.org/licenses/
     - 
     -    TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
     - 
     -
     - ## contrib/persistent-https/README ##
     -@@ contrib/persistent-https/README: PREREQUISITES
     - The code is written in Go (http://golang.org/) and the Go compiler is
     - required. Currently, the compiler must be built and installed from tip
     - of source, in order to include a fix in the reverse http proxy:
     --http://code.google.com/p/go/source/detail?r=a615b796570a2cd8591884767a7d67ede74f6648
     -+https://code.google.com/p/go/source/detail?r=a615b796570a2cd8591884767a7d67ede74f6648
     - 
     - 
     - BUILDING
     -
     - ## contrib/thunderbird-patch-inline/appp.sh ##
     -@@
     - # AppendPatch - A script to be used together with ExternalEditor
     - # for Mozilla Thunderbird to properly include patches inline in e-mails.
     - 
     --# ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
     -+# ExternalEditor can be downloaded at https://globs.org/articles.php?lng=en&pg=2
     - 
     - CONFFILE=~/.appprc
     - 
     -
     - ## contrib/update-unicode/update_unicode.sh ##
     -@@
     - #!/bin/sh
     --#See http://www.unicode.org/reports/tr44/
     -+#See https://www.unicode.org/reports/tr44/
     - #
     - #Me Enclosing_Mark  an enclosing combining mark
     - #Mn Nonspacing_Mark a nonspacing combining mark (zero advance width)
     -@@
     - cd "$(dirname "$0")"
     - UNICODEWIDTH_H=$(git rev-parse --show-toplevel)/unicode-width.h
     - 
     --wget -N http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt \
     --	http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
     -+wget -N https://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt \
     -+	https://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
     - if ! test -d uniset; then
     - 	git clone https://github.com/depp/uniset.git &&
     - 	( cd uniset && git checkout 4b186196dd )
     -
     - ## convert.c ##
     -@@ convert.c: static int encode_to_git(const char *path, const char *src, size_t src_len,
     - 	 * generate a faulty round trip without an iconv error. Iconv errors
     - 	 * are already caught above.
     - 	 *
     --	 * [1] http://unicode.org/faq/utf_bom.html#gen2
     -+	 * [1] https://unicode.org/faq/utf_bom.html#gen2
     - 	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
     - 	 */
     - 	if (die_on_error && check_roundtrip(enc)) {
     -
     - ## ewah/bitmap.c ##
     -@@
     -  * GNU General Public License for more details.
     -  *
     -  * You should have received a copy of the GNU General Public License
     -- * along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
     -  */
     - #include "git-compat-util.h"
     - #include "ewok.h"
     -
     - ## ewah/ewah_bitmap.c ##
     -@@
     -  * GNU General Public License for more details.
     -  *
     -  * You should have received a copy of the GNU General Public License
     -- * along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
     -  */
     - #include "git-compat-util.h"
     - #include "ewok.h"
     -
     - ## ewah/ewah_io.c ##
     -@@
     -  * GNU General Public License for more details.
     -  *
     -  * You should have received a copy of the GNU General Public License
     -- * along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
     -  */
     - #include "git-compat-util.h"
     - #include "ewok.h"
     -
     - ## ewah/ewah_rlw.c ##
     -@@
     -  * GNU General Public License for more details.
     -  *
     -  * You should have received a copy of the GNU General Public License
     -- * along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
     -  */
     - #include "git-compat-util.h"
     - #include "ewok.h"
     -
     - ## ewah/ewok.h ##
     -@@
     -  * GNU General Public License for more details.
     -  *
     -  * You should have received a copy of the GNU General Public License
     -- * along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
     -  */
     - #ifndef __EWOK_BITMAP_H__
     - #define __EWOK_BITMAP_H__
     -@@ ewah/ewok.h: typedef uint64_t eword_t;
     -  * Do not use __builtin_popcountll. The GCC implementation
     -  * is notoriously slow on all platforms.
     -  *
     -- * See: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=36041
     -+ * See: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36041
     -  */
     - static inline uint32_t ewah_bit_popcount64(uint64_t x)
     - {
     -
     - ## ewah/ewok_rlw.h ##
     -@@
     -  * GNU General Public License for more details.
     -  *
     -  * You should have received a copy of the GNU General Public License
     -- * along with this program; if not, see <http://www.gnu.org/licenses/>.
     -+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
     -  */
     - #ifndef __EWOK_RLW_H__
     - #define __EWOK_RLW_H__
     -
       ## git-cvsimport.perl ##
      @@ git-cvsimport.perl: sub conn {
       			# Use a HTTP Proxy. Only works for HTTP proxies that
     @@ utf8.h: int has_prohibited_utf_bom(const char *enc, const char *data, size_t len
        *     Section 3.10, D98, page 132
        * [3] https://encoding.spec.whatwg.org/#utf-16le
        */
     -
     - ## xdiff/xdiff.h ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xdiffi.c ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xdiffi.h ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xemit.c ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xemit.h ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xinclude.h ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xmacros.h ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xmerge.c ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xpatience.c ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xprepare.c ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xprepare.h ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xtypes.h ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xutils.c ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
     -
     - ## xdiff/xutils.h ##
     -@@
     -  *
     -  *  You should have received a copy of the GNU Lesser General Public
     -  *  License along with this library; if not, see
     -- *  <http://www.gnu.org/licenses/>.
     -+ *  <https://www.gnu.org/licenses/>.
     -  *
     -  *  Davide Libenzi <davidel@xmailserver.org>
     -  *
 2:  f9f3f4af1c8 ! 2:  80eb5da8ed4 doc: update links to current pages
     @@ Metadata
       ## Commit message ##
          doc: update links to current pages
      
     +    It's somewhat traditional to respect sites' self-identification.
     +
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
       ## Documentation/CodingGuidelines ##
     @@ Documentation/git-format-patch.txt: Approach #3 (external editor)
       
       1. Prepare the patch as a text file using your method of choice.
      
     - ## Documentation/git-ls-remote.txt ##
     -@@ Documentation/git-ls-remote.txt: d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
     - * List all references matching given patterns:
     - +
     - ----
     --$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc
     -+$ git ls-remote https://git.kernel.org/pub/scm/git/git.git master seen rc
     - 5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
     - c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
     - ----
     -@@ Documentation/git-ls-remote.txt: c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
     - * List only tags matching a given wildcard pattern:
     - +
     - ----
     --$ git ls-remote --tags http://www.kernel.org/pub/scm/git/git.git v\*
     -+$ git ls-remote --tags https://git.kernel.org/pub/scm/git/git.git v\*
     - 485a869c64a68cc5795dd99689797c5900f4716d	refs/tags/v2.39.2
     - cbf04937d5b9fcf0a76c28f69e6294e9e3ecd7e6	refs/tags/v2.39.2^{}
     - d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
     -
       ## Documentation/git.txt ##
      @@ Documentation/git.txt: Authors
       -------
     @@ Documentation/git.txt: Authors
       
       If you have a clone of git.git itself, the
      
     - ## Documentation/gitcore-tutorial.txt ##
     -@@ Documentation/gitcore-tutorial.txt: Examples.
     - 
     - the above are equivalent to:
     - 
     --. `git pull http://www.kernel.org/pub/scm/git/git.git/ HEAD`
     --. `git pull http://www.kernel.org/pub/scm/git/git.git/ tag v0.99.1`
     -+. `git pull https://git.kernel.org/pub/scm/git/git.git/ HEAD`
     -+. `git pull https://git.kernel.org/pub/scm/git/git.git/ tag v0.99.1`
     - 
     - 
     - How does the merge work?
     -
     - ## compat/nedmalloc/malloc.c.h ##
     -@@ compat/nedmalloc/malloc.c.h: LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
     -   /* --[ start GCC compatibility ]----------------------------------------------
     -    * Compatibility <intrin_x86.h> header for GCC -- GCC equivalents of intrinsic
     -    * Microsoft Visual C++ functions. Originally developed for the ReactOS
     --   * (<http://www.reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)
     -+   * (<https://reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)
     -    * projects.
     -    *
     -    * Copyright (c) 2006 KJK::Hyperion <hackbunny@reactos.com>
     -
     - ## contrib/persistent-https/README ##
     -@@ contrib/persistent-https/README: https://kernel.googlesource.com/pub/scm/git/git
     - 
     - PREREQUISITES
     - 
     --The code is written in Go (http://golang.org/) and the Go compiler is
     -+The code is written in Go (https://go.dev/) and the Go compiler is
     - required. Currently, the compiler must be built and installed from tip
     - of source, in order to include a fix in the reverse http proxy:
     - https://code.google.com/p/go/source/detail?r=a615b796570a2cd8591884767a7d67ede74f6648
     -
       ## git-gui/git-gui.sh ##
      @@ git-gui/git-gui.sh: proc do_quit {{rc {1}}} {
       	set ret_code $rc
 3:  100ea749b5b ! 3:  7cfd7b244ea doc: update links for andre-simon.de
     @@ Metadata
       ## Commit message ##
          doc: update links for andre-simon.de
      
     +    Beyond the fact that it's somewhat traditional to respect sites'
     +    self-identification, it's helpful for links to point to the things
     +    that people expect them to reference. Here that means linking to
     +    specific pages instead of a domain.
     +
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
       ## Documentation/gitweb.conf.txt ##
 4:  db71330d1ca ! 4:  9f0bba69492 doc: refer to internet archive
     @@ Metadata
       ## Commit message ##
          doc: refer to internet archive
      
     -    Signed-off-by: Josh Soref <jsoref@gmail.com>
     +    These pages are no longer reachable from their original locations,
     +    which makes things difficult for readers. Instead, switch to linking to
     +    the Internet Archive for the content.
      
     - ## compat/nedmalloc/malloc.c.h ##
     -@@ compat/nedmalloc/malloc.c.h: LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
     -   /* --[ start GCC compatibility ]----------------------------------------------
     -    * Compatibility <intrin_x86.h> header for GCC -- GCC equivalents of intrinsic
     -    * Microsoft Visual C++ functions. Originally developed for the ReactOS
     --   * (<https://reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)
     -+   * (<https://reactos.org/>) and TinyKrnl (<https://web.archive.org/web/20060409205924/http://www.tinykrnl.org/>)
     -    * projects.
     -    *
     -    * Copyright (c) 2006 KJK::Hyperion <hackbunny@reactos.com>
     +    Signed-off-by: Josh Soref <jsoref@gmail.com>
      
       ## gitweb/gitweb.perl ##
      @@ gitweb/gitweb.perl: sub git_feed {

-- 
gitgitgadget
