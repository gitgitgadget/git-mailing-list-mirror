Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D5E6FE32
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjIVOOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjIVOOI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:14:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C793EF7
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401da71b83cso22515225e9.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695392035; x=1695996835; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlA5vWPYI+kB1urtWHOXvdtRsxHW5P72nKBPQK0Ti9E=;
        b=UChzUDdbDW8GnjUYKdDohNBLBbLYLeI7JLrjzOqR/UQ5pqxEGfq/uPvGGszM8Q+cJ1
         JT8cykQ+Yicpi+mQBZCR9rMDLq9jI0a4sBs6g71JBmfhXg06ciAUjq3EvjVg92u5FcfL
         I6DQb7TEXVaMlIChlp1bQq5uVX/ZMYAE38Mo6/Anc8pYLJYHtv7pnau613dpkRqoN+d9
         zkKn9ntO7jp55PYG/TgD4l1qGu974jy4QNxER9ntePLc/YwMTx5yNcaa0gWtMeOtVHlM
         Jv9nTXmH95qhkkpYs3rD4vzei8MMkYl0Xf5VvZxC5W4gelNwIj7aQW7vv8zEMF0TsBUL
         K1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695392035; x=1695996835;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlA5vWPYI+kB1urtWHOXvdtRsxHW5P72nKBPQK0Ti9E=;
        b=gUpzOl8GIryf5F2fpQwQqDpnIR3enN4LcrNtGFnlGmyiyLpBYcIbuB0HxTUsBF5fq9
         rnnyYGkUB2ZvQhNppDlmCKSwG6FMkBVnqhb85K+yATZepxcQfWUmavAT7FihZBSXCzOJ
         nXPNY2upjS5cg4+rUbmslHuTQUdqnonrH6dghVeKtMbACHBIVlRBG++5Whf8D6IE0sMS
         Uxef5etG+G/VjeWuicByl3qS/dVak0IcjEWe/nm0LHs9KxD7BmBK3egIzjbPBl1GSUpl
         HE+dTxtAVUGgfR7kz8gr2Hd0VIpbO8niinaro7PsVdkWAMDYWriQZQOjWii9ZyAb0APQ
         5xVQ==
X-Gm-Message-State: AOJu0YwS3wcveRjYznEo+Kesud421Bayr6gU8ww+eaGKrU58zBY5/V68
        ho2syPa523HFoj/BSXW0WZtFQUUK2JY=
X-Google-Smtp-Source: AGHT+IFPuyGCR7sSgPg4f2GP8GeGJ277MuP3lL4G1+Ny0Lj+RXcZ4VM/evHowzIMFCdMVBzkv3SMYQ==
X-Received: by 2002:a7b:ca4f:0:b0:402:ea6a:c955 with SMTP id m15-20020a7bca4f000000b00402ea6ac955mr8507524wml.8.1695392030866;
        Fri, 22 Sep 2023 07:13:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b003fedcd02e2asm4768329wmj.35.2023.09.22.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:13:50 -0700 (PDT)
Message-ID: <b80c6089653bffc59faaa585e29d8c46a0611e83.1695392028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 14:13:44 +0000
Subject: [PATCH 1/4] doc: switch links to https
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/CodingGuidelines                         |  2 +-
 Documentation/MyFirstContribution.txt                  |  2 +-
 Documentation/git-cvsimport.txt                        |  2 +-
 Documentation/git-format-patch.txt                     |  2 +-
 Documentation/git-imap-send.txt                        |  2 +-
 Documentation/git-send-email.txt                       |  2 +-
 Documentation/gitcore-tutorial.txt                     |  2 +-
 Documentation/gitprotocol-http.txt                     |  4 ++--
 Documentation/gitweb.conf.txt                          |  2 +-
 Documentation/gitweb.txt                               |  2 +-
 Documentation/howto/keep-canonical-history-correct.txt |  2 +-
 Documentation/signoff-option.txt                       |  2 +-
 INSTALL                                                |  2 +-
 Makefile                                               |  4 ++--
 README.md                                              |  2 +-
 compat/nedmalloc/malloc.c.h                            | 10 +++++-----
 compat/obstack.c                                       |  2 +-
 compat/obstack.h                                       |  2 +-
 compat/poll/poll.c                                     |  2 +-
 compat/poll/poll.h                                     |  2 +-
 compat/precompose_utf8.h                               |  2 +-
 compat/regex/regcomp.c                                 |  2 +-
 compat/regex/regex.c                                   |  2 +-
 compat/regex/regex.h                                   |  2 +-
 compat/regex/regex_internal.c                          |  2 +-
 compat/regex/regex_internal.h                          |  2 +-
 compat/regex/regexec.c                                 |  2 +-
 compat/vcbuild/README                                  | 10 +++++-----
 contrib/completion/git-completion.bash                 |  2 +-
 .../credential/libsecret/git-credential-libsecret.c    |  2 +-
 contrib/fast-import/import-directories.perl            |  2 +-
 contrib/hg-to-git/hg-to-git.py                         |  2 +-
 contrib/mw-to-git/t/test-gitmw-lib.sh                  |  4 ++--
 contrib/persistent-https/LICENSE                       |  2 +-
 contrib/persistent-https/README                        |  2 +-
 contrib/thunderbird-patch-inline/appp.sh               |  2 +-
 contrib/update-unicode/update_unicode.sh               |  6 +++---
 convert.c                                              |  2 +-
 ewah/bitmap.c                                          |  2 +-
 ewah/ewah_bitmap.c                                     |  2 +-
 ewah/ewah_io.c                                         |  2 +-
 ewah/ewah_rlw.c                                        |  2 +-
 ewah/ewok.h                                            |  4 ++--
 ewah/ewok_rlw.h                                        |  2 +-
 git-cvsimport.perl                                     |  2 +-
 git-gui/git-gui.sh                                     |  4 ++--
 git-gui/lib/encoding.tcl                               |  2 +-
 git-gui/po/README                                      |  2 +-
 git-instaweb.sh                                        |  4 ++--
 gitk-git/gitk                                          |  2 +-
 gitweb/gitweb.perl                                     |  4 ++--
 gitweb/static/js/lib/common-lib.js                     |  8 ++++----
 graph.h                                                |  4 ++--
 imap-send.c                                            |  2 +-
 json-writer.h                                          |  2 +-
 kwset.c                                                |  2 +-
 kwset.h                                                |  2 +-
 list.h                                                 |  2 +-
 perl/FromCPAN/Error.pm                                 |  2 +-
 perl/Git/SVN.pm                                        |  2 +-
 protocol.h                                             |  2 +-
 sh-i18n--envsubst.c                                    |  4 ++--
 t/README                                               |  4 ++--
 t/helper/test-regex.c                                  |  2 +-
 t/perf/perf-lib.sh                                     |  2 +-
 t/t9114-git-svn-dcommit-merge.sh                       |  2 +-
 t/t9801-git-p4-branch.sh                               |  2 +-
 t/test-lib-functions.sh                                |  2 +-
 t/test-lib-github-workflow-markup.sh                   |  2 +-
 t/test-lib-junit.sh                                    |  2 +-
 t/test-lib.sh                                          |  2 +-
 trace.c                                                |  2 +-
 utf8.c                                                 |  2 +-
 utf8.h                                                 |  6 +++---
 xdiff/xdiff.h                                          |  2 +-
 xdiff/xdiffi.c                                         |  2 +-
 xdiff/xdiffi.h                                         |  2 +-
 xdiff/xemit.c                                          |  2 +-
 xdiff/xemit.h                                          |  2 +-
 xdiff/xinclude.h                                       |  2 +-
 xdiff/xmacros.h                                        |  2 +-
 xdiff/xmerge.c                                         |  2 +-
 xdiff/xpatience.c                                      |  2 +-
 xdiff/xprepare.c                                       |  2 +-
 xdiff/xprepare.h                                       |  2 +-
 xdiff/xtypes.h                                         |  2 +-
 xdiff/xutils.c                                         |  2 +-
 xdiff/xutils.h                                         |  2 +-
 88 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 65af8d82ced..94d4d869039 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -24,7 +24,7 @@ code.  For Git in general, a few rough rules are:
 
    "Once it _is_ in the tree, it's not really worth the patch noise to
    go and fix it up."
-   Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
+   Cf. https://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
 
  - Log messages to explain your changes are as important as the
    changes themselves.  Clearly written code and in-code comments
diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 62d11a5cd7f..710a1f9d915 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -832,7 +832,7 @@ Johannes Schindelin to make life as a Git contributor easier for those used to
 the GitHub PR workflow. It allows contributors to open pull requests against its
 mirror of the Git project, and does some magic to turn the PR into a set of
 emails and send them out for you. It also runs the Git continuous integration
-suite for you. It's documented at http://gitgitgadget.github.io.
+suite for you. It's documented at https://gitgitgadget.github.io/.
 
 [[create-fork]]
 === Forking `git/git` on GitHub
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index b3f27671a0c..e107ae930de 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -221,7 +221,7 @@ Problems related to tags:
 If you suspect that any of these issues may apply to the repository you
 want to import, consider using cvs2git:
 
-* cvs2git (part of cvs2svn), `http://subversion.apache.org/`
+* cvs2git (part of cvs2svn), `https://subversion.apache.org/`
 
 GIT
 ---
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 711823a7f4e..06aa8bf0741 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -611,7 +611,7 @@ Approach #3 (external editor)
 
 The following Thunderbird extensions are needed:
 AboutConfig from http://aboutconfig.mozdev.org/ and
-External Editor from http://globs.org/articles.php?lng=en&pg=8
+External Editor from https://globs.org/articles.php?lng=en&pg=8
 
 1. Prepare the patch as a text file using your method of choice.
 
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index f7b18515141..c8a89d7243b 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -135,7 +135,7 @@ flames ridiculing you if you don't check this.
 
 Thunderbird in particular is known to be problematic.  Thunderbird
 users may wish to visit this web page for more information:
-  http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email
+  https://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email
 
 SEE ALSO
 --------
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 492a82323da..23c75d26f93 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -453,7 +453,7 @@ have been specified, in which case default to 'compose'.
 			998 characters unless a suitable transfer encoding
 			('auto', 'base64', or 'quoted-printable') is used;
 			this is due to SMTP limits as described by
-			http://www.ietf.org/rfc/rfc5322.txt.
+			https://www.ietf.org/rfc/rfc5322.txt.
 --
 +
 Default is the value of `sendemail.validate`; if this is not set,
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index c0b95256cc8..2122aeb9769 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1089,7 +1089,7 @@ the remote repository URL in the local repository's config file
 like this:
 
 ------------------------------------------------
-$ git config remote.linus.url http://www.kernel.org/pub/scm/git/git.git/
+$ git config remote.linus.url https://git.kernel.org/pub/scm/git/git.git/
 ------------------------------------------------
 
 and use the "linus" keyword with 'git pull' instead of the full URL.
diff --git a/Documentation/gitprotocol-http.txt b/Documentation/gitprotocol-http.txt
index ccc13f0a407..7533f0e61b7 100644
--- a/Documentation/gitprotocol-http.txt
+++ b/Documentation/gitprotocol-http.txt
@@ -529,8 +529,8 @@ TODO: Document this further.
 REFERENCES
 ----------
 
-http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
-http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
+https://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
+https://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
 
 SEE ALSO
 --------
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 34b1d6e2243..1edabdfef36 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -820,7 +820,7 @@ filesystem (i.e. "$projectroot/$project"), `%h` to the current hash
 (\'h' gitweb parameter) and `%b` to the current hash base
 (\'hb' gitweb parameter); `%%` expands to \'%'.
 +
-For example, at the time this page was written, the http://repo.or.cz[]
+For example, at the time this page was written, the https://repo.or.cz[]
 Git hosting site set it to the following to enable graphical log
 (using the third party tool *git-browser*):
 +
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index af6bf3c45ec..434893595a4 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -28,7 +28,7 @@ Gitweb provides a web interface to Git repositories.  Its features include:
   revisions one at a time, viewing the history of the repository.
 * Finding commits which commit messages matches given search term.
 
-See http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
+See https://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
 browsed using gitweb itself.
 
 
diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
index 35d48ef714e..5f800fd85a3 100644
--- a/Documentation/howto/keep-canonical-history-correct.txt
+++ b/Documentation/howto/keep-canonical-history-correct.txt
@@ -213,4 +213,4 @@ The procedure will result in a history that looks like this:
 		 B0--B1---------B2
 ------------
 
-See also http://git-blame.blogspot.com/2013/09/fun-with-first-parent-history.html
+See also https://git-blame.blogspot.com/2013/09/fun-with-first-parent-history.html
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
index 12aa2333e46..d98758f3cb7 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -9,7 +9,7 @@ endif::git-commit[]
 	the committer has the rights to submit the work under the
 	project's license or agrees to some contributor representation,
 	such as a Developer Certificate of Origin.
-	(See http://developercertificate.org for the one used by the
+	(See https://developercertificate.org for the one used by the
 	Linux kernel and Git projects.)  Consult the documentation or
 	leadership of the project to which you're contributing to
 	understand how the signoffs are used in that project.
diff --git a/INSTALL b/INSTALL
index 4b422888828..020eba62afb 100644
--- a/INSTALL
+++ b/INSTALL
@@ -124,7 +124,7 @@ Issues of note:
 	  interacting with svn repositories with "git svn").  If you can
 	  live without these, use NO_PERL.  Note that recent releases of
 	  Redhat/Fedora are reported to ship Perl binary package with some
-	  core modules stripped away (see http://lwn.net/Articles/477234/),
+	  core modules stripped away (see https://lwn.net/Articles/477234/),
 	  so you might need to install additional packages other than Perl
 	  itself, e.g. Digest::MD5, File::Spec, File::Temp, Net::Domain,
 	  Net::SMTP, and Time::HiRes.
diff --git a/Makefile b/Makefile
index 57763093653..de1603a04fe 100644
--- a/Makefile
+++ b/Makefile
@@ -186,7 +186,7 @@ include shared.mak
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
-# as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
+# as the compiler can crash (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this. On
@@ -2720,7 +2720,7 @@ $(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's on-the-fly dependency generation
-# See <http://gcc.gnu.org/gcc-3.0/features.html>.
+# See <https://gcc.gnu.org/gcc-3.0/features.html>.
 dep_files_present := $(wildcard $(dep_files))
 ifneq ($(dep_files_present),)
 include $(dep_files_present)
diff --git a/README.md b/README.md
index 7ce4f05bae8..2c3de2f9c80 100644
--- a/README.md
+++ b/README.md
@@ -42,7 +42,7 @@ string translations (localization l10) should see [po/README.md][]
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org (not the Git list). The mailing
 list archives are available at <https://lore.kernel.org/git/>,
-<http://marc.info/?l=git> and other archival sites.
+<https://marc.info/?l=git> and other archival sites.
 
 Issues which are security relevant should be disclosed privately to
 the Git Security mailing list <git-security@googlegroups.com>.
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 814845d4b33..5c5357a379f 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1,7 +1,7 @@
 /*
   This is a version (aka dlmalloc) of malloc/free/realloc written by
   Doug Lea and released to the public domain, as explained at
-  http://creativecommons.org/licenses/publicdomain.  Send questions,
+  https://creativecommons.org/licenses/publicdomain.  Send questions,
   comments, complaints, performance data, etc to dl@cs.oswego.edu
 
 * Version pre-2.8.4 Mon Nov 27 11:22:37 2006    (dl at gee)
@@ -126,7 +126,7 @@
        like memset.
 
   Compliance: I believe it is compliant with the Single Unix Specification
-       (See http://www.unix.org). Also SVID/XPG, ANSI C, and probably
+       (See https://www.unix.org). Also SVID/XPG, ANSI C, and probably
        others as well.
 
 * Overview of algorithms
@@ -172,7 +172,7 @@
   ignored.
 
   For a longer but out of date high-level description, see
-     http://gee.cs.oswego.edu/dl/html/malloc.html
+     https://gee.cs.oswego.edu/dl/html/malloc.html
 
 * MSPACES
   If MSPACES is defined, then in addition to malloc, free, etc.,
@@ -2460,7 +2460,7 @@ typedef struct malloc_segment* msegmentptr;
     conservatively use 32 bits per map word, even if on 64bit system.
     For a good description of some of the bit-based techniques used
     here, see Henry S. Warren Jr's book "Hacker's Delight" (and
-    supplement at http://hackersdelight.org/). Many of these are
+    supplement at https://www.hackersdelight.org/). Many of these are
     intended to reduce the branchiness of paths through malloc etc, as
     well as to reduce the number of memory locations read or written.
 
@@ -2916,7 +2916,7 @@ static size_t traverse_and_check(mstate m);
   that the mstate controlling malloc/free is intact.  This is a
   streamlined version of the approach described by William Robertson
   et al in "Run-time Detection of Heap-based Overflows" LISA'03
-  http://www.usenix.org/events/lisa03/tech/robertson.html The footer
+  https://www.usenix.org/events/lisa03/tech/robertson.html The footer
   of an inuse chunk holds the xor of its mstate and a random seed,
   that is checked upon calls to free() and realloc().  This is
   (probablistically) unguessable from outside the program, but can be
diff --git a/compat/obstack.c b/compat/obstack.c
index 27cd5c1ea1f..ec23761cda1 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -15,7 +15,7 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
 #include "git-compat-util.h"
 #include <gettext.h>
diff --git a/compat/obstack.h b/compat/obstack.h
index f90a46d9b95..fd6f5f6821a 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -15,7 +15,7 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
 /* Summary:
 
diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index afa6d245846..1ed0fa055b6 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -16,7 +16,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License along
-   with this program; if not, see <http://www.gnu.org/licenses/>.  */
+   with this program; if not, see <https://www.gnu.org/licenses/>.  */
 
 /* To bump the minimum Windows version to Windows Vista */
 #include "git-compat-util.h"
diff --git a/compat/poll/poll.h b/compat/poll/poll.h
index 1e1597360f4..e369436dbe3 100644
--- a/compat/poll/poll.h
+++ b/compat/poll/poll.h
@@ -16,7 +16,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License along
-   with this program; if not, see <http://www.gnu.org/licenses/>.  */
+   with this program; if not, see <https://www.gnu.org/licenses/>.  */
 
 #ifndef _GL_POLL_H
 #define _GL_POLL_H
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index fea06cf28a5..9bae1e921f6 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -13,7 +13,7 @@ typedef struct dirent_prec_psx {
 	unsigned char d_type;   /* available on all systems git runs on */
 
 	/*
-	 * See http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html
+	 * See https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html
 	 * NAME_MAX + 1 should be enough, but some systems have
 	 * NAME_MAX=255 and strlen(d_name) may return 508 or 510
 	 * Solution: allocate more when needed, see precompose_utf8_readdir()
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index d1bc09e49b6..909d4ffac52 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -15,7 +15,7 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
 #if defined __TANDEM
  /* This is currently duplicated from git-compat-utils.h */
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index e6f4a5d177b..c32fd1ce489 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -15,7 +15,7 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index 2d3412860d4..9022bf49d29 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -19,7 +19,7 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
 #ifndef _REGEX_H
 #define _REGEX_H 1
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index ec51cf34461..49cf52d98cc 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -15,7 +15,7 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
 static void re_string_construct_common (const char *str, int len,
 					re_string_t *pstr,
diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
index 0bad8b841ed..61be3978dbd 100644
--- a/compat/regex/regex_internal.h
+++ b/compat/regex/regex_internal.h
@@ -15,7 +15,7 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
 #ifndef _REGEX_INTERNAL_H
 #define _REGEX_INTERNAL_H 1
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 49358ae475c..bc91ebd4432 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -15,7 +15,7 @@
 
    You should have received a copy of the GNU Lesser General Public
    License along with the GNU C Library; if not, see
-   <http://www.gnu.org/licenses/>.  */
+   <https://www.gnu.org/licenses/>.  */
 
 static reg_errcode_t match_ctx_init (re_match_context_t *cache, int eflags,
 				     int n) internal_function;
diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 29ec1d0f104..3823fb56c89 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -67,14 +67,14 @@ The Steps of Build Git with VS2008
 
    You can either use the binary repository:
 
-       WWW: http://repo.or.cz/w/msvcgit.git
+       WWW: https://repo.or.cz/w/msvcgit.git
        Git: git clone git://repo.or.cz/msvcgit.git
-       Zip: http://repo.or.cz/w/msvcgit.git?a=snapshot;h=master;sf=zip
+       Zip: https://repo.or.cz/w/msvcgit.git?a=snapshot;h=master;sf=zip
 
    and call the setup_32bit_env.cmd batch script before compiling Git,
    (see repo/package README for details), or the source repository:
 
-       WWW: http://repo.or.cz/w/gitbuild.git
+       WWW: https://repo.or.cz/w/gitbuild.git
        Git: git clone git://repo.or.cz/gitbuild.git
        Zip: (None, as it's a project with submodules)
 
@@ -83,9 +83,9 @@ The Steps of Build Git with VS2008
 2. Ensure you have the msysgit environment in your path, so you have
    GNU Make, bash and perl available.
 
-       WWW: http://repo.or.cz/w/msysgit.git
+       WWW: https://repo.or.cz/w/msysgit.git
        Git: git clone git://repo.or.cz/msysgit.git
-       Zip: http://repo.or.cz/w/msysgit.git?a=snapshot;h=master;sf=zip
+       Zip: https://repo.or.cz/w/msysgit.git?a=snapshot;h=master;sf=zip
 
    This environment is also needed when you use the resulting
    executables, since Git might need to run scripts which are part of
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 133ec92bfae..8d8eb2c8afa 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -203,7 +203,7 @@ __git_dequote ()
 #   GNU General Public License for more details.
 #
 #   You should have received a copy of the GNU General Public License
-#   along with this program; if not, see <http://www.gnu.org/licenses/>.
+#   along with this program; if not, see <https://www.gnu.org/licenses/>.
 #
 #   The latest version of this software can be obtained here:
 #
diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 215a81d8bae..42c6b2d5e80 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -14,7 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast-import/import-directories.perl
index a16f79cfdc4..8d8dcda98aa 100755
--- a/contrib/fast-import/import-directories.perl
+++ b/contrib/fast-import/import-directories.perl
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
+# along with this program; if not, see <https://www.gnu.org/licenses/>.
 #
 # ------------------------------------------------------------------------
 
diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 7eb1b24cc7a..fcadae46fd9 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -15,7 +15,7 @@
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License
-    along with this program; if not, see <http://www.gnu.org/licenses/>.
+    along with this program; if not, see <https://www.gnu.org/licenses/>.
 """
 
 import os, os.path, sys
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index 64e46c16716..337e3672c02 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -371,9 +371,9 @@ wiki_install () {
 	if ! test -f $MW_FILENAME
 	then
 		echo "Downloading $MW_VERSION_MAJOR.$MW_VERSION_MINOR sources ..."
-		wget "http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/$MW_FILENAME" ||
+		wget "https://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/$MW_FILENAME" ||
 			error "Unable to download "\
-			"http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/"\
+			"https://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/"\
 			"$MW_FILENAME. "\
 			"Please fix your connection and launch the script again."
 		echo "$MW_FILENAME downloaded in $(pwd)/;" \
diff --git a/contrib/persistent-https/LICENSE b/contrib/persistent-https/LICENSE
index d6456956733..c38505788b3 100644
--- a/contrib/persistent-https/LICENSE
+++ b/contrib/persistent-https/LICENSE
@@ -1,7 +1,7 @@
 
                                  Apache License
                            Version 2.0, January 2004
-                        http://www.apache.org/licenses/
+                        https://www.apache.org/licenses/
 
    TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
 
diff --git a/contrib/persistent-https/README b/contrib/persistent-https/README
index 7c4cd8d257d..2ad95893c27 100644
--- a/contrib/persistent-https/README
+++ b/contrib/persistent-https/README
@@ -63,7 +63,7 @@ PREREQUISITES
 The code is written in Go (http://golang.org/) and the Go compiler is
 required. Currently, the compiler must be built and installed from tip
 of source, in order to include a fix in the reverse http proxy:
-http://code.google.com/p/go/source/detail?r=a615b796570a2cd8591884767a7d67ede74f6648
+https://code.google.com/p/go/source/detail?r=a615b796570a2cd8591884767a7d67ede74f6648
 
 
 BUILDING
diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
index 1053872eea9..00a30c40ad9 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -4,7 +4,7 @@
 # AppendPatch - A script to be used together with ExternalEditor
 # for Mozilla Thunderbird to properly include patches inline in e-mails.
 
-# ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
+# ExternalEditor can be downloaded at https://globs.org/articles.php?lng=en&pg=2
 
 CONFFILE=~/.appprc
 
diff --git a/contrib/update-unicode/update_unicode.sh b/contrib/update-unicode/update_unicode.sh
index aa90865befa..2bf1d81cad8 100755
--- a/contrib/update-unicode/update_unicode.sh
+++ b/contrib/update-unicode/update_unicode.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-#See http://www.unicode.org/reports/tr44/
+#See https://www.unicode.org/reports/tr44/
 #
 #Me Enclosing_Mark  an enclosing combining mark
 #Mn Nonspacing_Mark a nonspacing combining mark (zero advance width)
@@ -8,8 +8,8 @@
 cd "$(dirname "$0")"
 UNICODEWIDTH_H=$(git rev-parse --show-toplevel)/unicode-width.h
 
-wget -N http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt \
-	http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
+wget -N https://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt \
+	https://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
 if ! test -d uniset; then
 	git clone https://github.com/depp/uniset.git &&
 	( cd uniset && git checkout 4b186196dd )
diff --git a/convert.c b/convert.c
index a8870baff36..98514882484 100644
--- a/convert.c
+++ b/convert.c
@@ -438,7 +438,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	 * generate a faulty round trip without an iconv error. Iconv errors
 	 * are already caught above.
 	 *
-	 * [1] http://unicode.org/faq/utf_bom.html#gen2
+	 * [1] https://unicode.org/faq/utf_bom.html#gen2
 	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
 	 */
 	if (die_on_error && check_roundtrip(enc)) {
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 7b525b1ecd8..fa455682aa7 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
 #include "ewok.h"
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 8785cbc54a8..595c20aa16a 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
 #include "ewok.h"
diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 9035ee65ea8..e371ec6038d 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
 #include "ewok.h"
diff --git a/ewah/ewah_rlw.c b/ewah/ewah_rlw.c
index 5093d43e2f0..ec4918eefa8 100644
--- a/ewah/ewah_rlw.c
+++ b/ewah/ewah_rlw.c
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
 #include "ewok.h"
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 7eb8b9b6301..2524878f75d 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #ifndef __EWOK_BITMAP_H__
 #define __EWOK_BITMAP_H__
@@ -27,7 +27,7 @@ typedef uint64_t eword_t;
  * Do not use __builtin_popcountll. The GCC implementation
  * is notoriously slow on all platforms.
  *
- * See: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=36041
+ * See: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36041
  */
 static inline uint32_t ewah_bit_popcount64(uint64_t x)
 {
diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
index bafa24f4c3a..7eb8f1166c2 100644
--- a/ewah/ewok_rlw.h
+++ b/ewah/ewok_rlw.h
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #ifndef __EWOK_RLW_H__
 #define __EWOK_RLW_H__
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 7bf3c12d678..da77a1bf157 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -329,7 +329,7 @@ sub conn {
 			# Use a HTTP Proxy. Only works for HTTP proxies that
 			# don't require user authentication
 			#
-			# See: http://www.ietf.org/rfc/rfc2817.txt
+			# See: https://www.ietf.org/rfc/rfc2817.txt
 
 			$s = IO::Socket::INET->new(PeerHost => $proxyhost, PeerPort => $proxyport);
 			die "Socket to $proxyhost: $!\n" unless defined $s;
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 8bc8892c400..1d6102e0674 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -24,7 +24,7 @@ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
-along with this program; if not, see <http://www.gnu.org/licenses/>.}]
+along with this program; if not, see <https://www.gnu.org/licenses/>.}]
 
 ######################################################################
 ##
@@ -3075,7 +3075,7 @@ if {$doc_path ne {}} {
 if {[file isfile $doc_path]} {
 	set doc_url "file:$doc_path"
 } else {
-	set doc_url {http://www.kernel.org/pub/software/scm/git/docs/}
+	set doc_url {https://www.kernel.org/pub/software/scm/git/docs/}
 }
 
 proc start_browser {url} {
diff --git a/git-gui/lib/encoding.tcl b/git-gui/lib/encoding.tcl
index 32668fc9c6d..d2e0fa60c3b 100644
--- a/git-gui/lib/encoding.tcl
+++ b/git-gui/lib/encoding.tcl
@@ -3,7 +3,7 @@
 # (Copied from gitk, commit fd8ccbec4f0161)
 
 # This list of encoding names and aliases is distilled from
-# http://www.iana.org/assignments/character-sets.
+# https://www.iana.org/assignments/character-sets.
 # Not all of them are supported by Tcl.
 set encoding_aliases {
     { ANSI_X3.4-1968 iso-ir-6 ANSI_X3.4-1986 ISO_646.irv:1991 ASCII
diff --git a/git-gui/po/README b/git-gui/po/README
index 2514bc22abf..116233100d7 100644
--- a/git-gui/po/README
+++ b/git-gui/po/README
@@ -39,7 +39,7 @@ in your language?
 If you do not know what your language should be named, you need to find
 it.  This currently follows ISO 639-1 two letter codes:
 
-	http://www.loc.gov/standards/iso639-2/php/code_list.php
+	https://www.loc.gov/standards/iso639-2/php/code_list.php
 
 For example, if you are preparing a translation for Afrikaans, the
 language code is "af".  If there already is a translation for your
diff --git a/git-instaweb.sh b/git-instaweb.sh
index c68f49454cd..994431c8872 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -432,7 +432,7 @@ mongoose_conf() {
 # Mongoose web server configuration file.
 # Lines starting with '#' and empty lines are ignored.
 # For detailed description of every option, visit
-# http://code.google.com/p/mongoose/wiki/MongooseManual
+# https://code.google.com/p/mongoose/wiki/MongooseManual
 
 root		$root
 ports		$port
@@ -458,7 +458,7 @@ plackup_conf () {
 #!$PERL
 
 # gitweb - simple web interface to track changes in git repositories
-#          PSGI wrapper and server starter (see http://plackperl.org)
+#          PSGI wrapper and server starter (see https://plackperl.org)
 
 use strict;
 
diff --git a/gitk-git/gitk b/gitk-git/gitk
index df3ba2ea99b..1db46977df0 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11956,7 +11956,7 @@ proc formatdate {d} {
 }
 
 # This list of encoding names and aliases is distilled from
-# http://www.iana.org/assignments/character-sets.
+# https://www.iana.org/assignments/character-sets.
 # Not all of them are supported by Tcl.
 set encoding_aliases {
     { ANSI_X3.4-1968 iso-ir-6 ANSI_X3.4-1986 ISO_646.irv:1991 ASCII
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9bad..d23468690ed 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -122,9 +122,9 @@ our $favicon = "++GITWEB_FAVICON++";
 our $javascript = "++GITWEB_JS++";
 
 # URI and label (title) of GIT logo link
-#our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
+#our $logo_url = "https://www.kernel.org/pub/software/scm/git/docs/";
 #our $logo_label = "git documentation";
-our $logo_url = "http://git-scm.com/";
+our $logo_url = "https://git-scm.com/";
 our $logo_label = "git homepage";
 
 # source of projects list
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index 018bbb7d4cb..17b1796496d 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -123,8 +123,8 @@ function addCssRule(selector, style) {
  * NOTE that there are limits and differences compared to native
  * getElementsByClassName as defined by e.g.:
  *   https://developer.mozilla.org/en/DOM/document.getElementsByClassName
- *   http://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-getelementsbyclassname
- *   http://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-document-getelementsbyclassname
+ *   https://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-getelementsbyclassname
+ *   https://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-document-getelementsbyclassname
  *
  * Namely, this implementation supports only single class name as
  * argument and not set of space-separated tokens representing classes,
@@ -133,9 +133,9 @@ function addCssRule(selector, style) {
  * (via getElementsByTagName).
  *
  * Based on
- *   http://code.google.com/p/getelementsbyclassname/
+ *   https://code.google.com/p/getelementsbyclassname/
  *   http://www.dustindiaz.com/getelementsbyclass/
- *   http://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
+ *   https://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
  *
  * See also http://ejohn.org/blog/getelementsbyclassname-speed-comparison/
  *
diff --git a/graph.h b/graph.h
index e88632a0140..3fd1dcb2e94 100644
--- a/graph.h
+++ b/graph.h
@@ -130,7 +130,7 @@ void graph_setup_line_prefix(struct diff_options *diffopt);
  * This functions must be called BEFORE graph_init() is called.
  *
  * NOTE: This function isn't used in Git outside graph.c but it is used
- * by CGit (http://git.zx2c4.com/cgit/) to use HTML for colors.
+ * by CGit (https://git.zx2c4.com/cgit/) to use HTML for colors.
  */
 void graph_set_column_colors(const char **colors, unsigned short colors_max);
 
@@ -196,7 +196,7 @@ int graph_is_commit_finished(struct git_graph const *graph);
  * graph_update() is called.
  *
  * NOTE: This function isn't used in Git outside graph.c but it is used
- * by CGit (http://git.zx2c4.com/cgit/) to wrap HTML around graph lines.
+ * by CGit (https://git.zx2c4.com/cgit/) to wrap HTML around graph lines.
  */
 int graph_next_line(struct git_graph *graph, struct strbuf *sb);
 
diff --git a/imap-send.c b/imap-send.c
index 996651e4f80..3b2077e39b2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -18,7 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
 #include "git-compat-util.h"
diff --git a/json-writer.h b/json-writer.h
index 209355e0f12..de140e54c98 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -3,7 +3,7 @@
 
 /*
  * JSON data structures are defined at:
- * [1] http://www.ietf.org/rfc/rfc7159.txt
+ * [1] https://www.ietf.org/rfc/rfc7159.txt
  * [2] http://json.org/
  *
  * The JSON-writer API allows one to build JSON data structures using a
diff --git a/kwset.c b/kwset.c
index bbfcf815a56..695e47b7ccf 100644
--- a/kwset.c
+++ b/kwset.c
@@ -18,7 +18,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, see <http://www.gnu.org/licenses/>. */
+   along with this program; if not, see <https://www.gnu.org/licenses/>. */
 
 /* Written August 1989 by Mike Haertel.
    The author may be reached (Email) at the address mike@ai.mit.edu,
diff --git a/kwset.h b/kwset.h
index d42a793a301..c722664e5a7 100644
--- a/kwset.h
+++ b/kwset.h
@@ -20,7 +20,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, see <http://www.gnu.org/licenses/>. */
+   along with this program; if not, see <https://www.gnu.org/licenses/>. */
 
 /* Written August 1989 by Mike Haertel.
    The author may be reached (Email) at the address mike@ai.mit.edu,
diff --git a/list.h b/list.h
index 362a4cd7f5f..98428010f4d 100644
--- a/list.h
+++ b/list.h
@@ -19,7 +19,7 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see
- * <http://www.gnu.org/licenses/>.
+ * <https://www.gnu.org/licenses/>.
  */
 
 #ifndef LIST_H
diff --git a/perl/FromCPAN/Error.pm b/perl/FromCPAN/Error.pm
index d82b71325c6..5b97e0315d6 100644
--- a/perl/FromCPAN/Error.pm
+++ b/perl/FromCPAN/Error.pm
@@ -1025,7 +1025,7 @@ C<:warndie> handlers added by Paul Evans <leonerd@leonerd.org.uk>
 
 =head1 MAINTAINER
 
-Shlomi Fish, L<http://www.shlomifish.org/> .
+Shlomi Fish, L<https://www.shlomifish.org/> .
 
 =head1 PAST MAINTAINERS
 
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 6ce2e283c8d..7721708ce5d 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1752,7 +1752,7 @@ sub tie_for_persistent_memoization {
 END {
 	# Force cache writeout explicitly instead of waiting for
 	# global destruction to avoid segfault in Storable:
-	# http://rt.cpan.org/Public/Bug/Display.html?id=36087
+	# https://rt.cpan.org/Public/Bug/Display.html?id=36087
 	unmemoize_svn_mergeinfo_functions();
 }
 
diff --git a/protocol.h b/protocol.h
index de66bf80f84..1e574bbd80b 100644
--- a/protocol.h
+++ b/protocol.h
@@ -18,7 +18,7 @@
  * with Linus Torvalds <torvalds@osdl.org> as the point of
  * contact. September 2005.
  *
- * See http://www.iana.org/assignments/port-numbers
+ * See https://www.iana.org/assignments/port-numbers
  */
 #define DEFAULT_GIT_PORT 9418
 
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 133496bd4d9..f69fd166105 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -31,7 +31,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, see <http://www.gnu.org/licenses/>.  */
+   along with this program; if not, see <https://www.gnu.org/licenses/>.  */
 
 /* closeout.c - close standard output and standard error
    Copyright (C) 1998-2007 Free Software Foundation, Inc.
@@ -47,7 +47,7 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, see <http://www.gnu.org/licenses/>.  */
+   along with this program; if not, see <https://www.gnu.org/licenses/>.  */
 
 #include <errno.h>
 #include <stdio.h>
diff --git a/t/README b/t/README
index 61080859899..643c3905d49 100644
--- a/t/README
+++ b/t/README
@@ -32,7 +32,7 @@ the tests.
     ok 2 - plain with GIT_WORK_TREE
     ok 3 - plain bare
 
-Since the tests all output TAP (see http://testanything.org) they can
+Since the tests all output TAP (see https://testanything.org) they can
 be run with any TAP harness. Here's an example of parallel testing
 powered by a recent version of prove(1):
 
@@ -1279,7 +1279,7 @@ Devel::Cover module. To install it do:
    sudo aptitude install libdevel-cover-perl
 
    # From the CPAN with cpanminus
-   curl -L http://cpanmin.us | perl - --sudo --self-upgrade
+   curl -L https://cpanmin.us/ | perl - --sudo --self-upgrade
    cpanm --sudo Devel::Cover
 
 Then, at the top-level:
diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index bd871a735b4..80042eafc20 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -30,7 +30,7 @@ static int test_regex_bug(void)
 	if (regexec(&r, str, 1, m, 0))
 		die("no match of pattern '%s' to string '%s'", pat, str);
 
-	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3957  */
+	/* https://sourceware.org/bugzilla/show_bug.cgi?id=3957 */
 	if (m[0].rm_so == 3) /* matches '\n' when it should not */
 		die("regex bug confirmed: re-build git with NO_REGEX=1");
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index e7786775a90..def22e70aed 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -15,7 +15,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 
 # These variables must be set before the inclusion of test-lib.sh below,
 # because it will change our working directory.
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 32317d6bca5..e06538b1c85 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -27,7 +27,7 @@ cat << EOF
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
+# along with this program; if not, see <https://www.gnu.org/licenses/>.
 #
 EOF
 }
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 759a14fa87c..3b5fea91822 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -466,7 +466,7 @@ test_expect_success 'git p4 clone complex branches with excluded files' '
 	)
 '
 
-# From a report in http://stackoverflow.com/questions/11893688
+# From a report in https://stackoverflow.com/questions/11893688
 # where --use-client-spec caused branch prefixes not to be removed;
 # every file in git appeared into a subdirectory of the branch name.
 test_expect_success 'use-client-spec detect-branches setup' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f8868caa17..0b7ddcc5858 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 
 # The semantics of the editor variables are that of invoking
 # sh -c "$EDITOR \"$@\"" files ...
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 9c5339c577a..970c6538cba 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 #
 # The idea is for `test-lib.sh` to source this file when run in GitHub
 # workflows; these functions will then override (empty) functions
diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
index 79c31c788b9..76cbbd3299d 100644
--- a/t/test-lib-junit.sh
+++ b/t/test-lib-junit.sh
@@ -15,7 +15,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 #
 # The idea is for `test-lib.sh` to source this file when the user asks
 # for JUnit XML; these functions will then override (empty) functions
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5ea5d1d62a0..9e4216a8e0b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -13,7 +13,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program.  If not, see http://www.gnu.org/licenses/ .
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
diff --git a/trace.c b/trace.c
index 971a68abe84..8669ddfca25 100644
--- a/trace.c
+++ b/trace.c
@@ -18,7 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
 #include "git-compat-util.h"
diff --git a/utf8.c b/utf8.c
index 6a0dd25b0fe..6bfaefa28eb 100644
--- a/utf8.c
+++ b/utf8.c
@@ -2,7 +2,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 
-/* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
+/* This code is originally from https://www.cl.cam.ac.uk/~mgk25/ucs/ */
 
 static const char utf16_be_bom[] = {'\xFE', '\xFF'};
 static const char utf16_le_bom[] = {'\xFF', '\xFE'};
diff --git a/utf8.h b/utf8.h
index b68efef6f43..35df76086a6 100644
--- a/utf8.h
+++ b/utf8.h
@@ -83,7 +83,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
  * BOM must not be used [1]. The same applies for the UTF-32 equivalents.
  * The function returns true if this rule is violated.
  *
- * [1] http://unicode.org/faq/utf_bom.html#bom10
+ * [1] https://unicode.org/faq/utf_bom.html#bom10
  */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
 
@@ -99,8 +99,8 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
  * Therefore, strictly requiring a BOM seems to be the safest option for
  * content in Git.
  *
- * [1] http://unicode.org/faq/utf_bom.html#gen6
- * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
+ * [1] https://unicode.org/faq/utf_bom.html#gen6
+ * [2] https://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
  *     Section 3.10, D98, page 132
  * [3] https://encoding.spec.whatwg.org/#utf-16le
  */
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index bb56b23f34c..73a39fc1b76 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 344c2dfc3eb..cc48de7aa26 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 126c9d8ff4e..2740c0f99bd 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 75f0fe49866..acaaa5c21f5 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xemit.h b/xdiff/xemit.h
index 1b9887e670d..162b83e8fcd 100644
--- a/xdiff/xemit.h
+++ b/xdiff/xemit.h
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index a4285ac0eb2..81f17f76a7f 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 8487bb396fa..eb42f7ec478 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index af40c88a5b3..478ad8faf0a 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index a2d8955537f..fcf22829dc8 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c84549f6c50..fb3e0feb096 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xprepare.h b/xdiff/xprepare.h
index 947d9fc1bb8..c75b32d06e9 100644
--- a/xdiff/xprepare.h
+++ b/xdiff/xprepare.h
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8442bd436ef..da01e6b4378 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9e36f24875d..bd904e656ee 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index fd0bba94e8b..292cdc5eb21 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -14,7 +14,7 @@
  *
  *  You should have received a copy of the GNU Lesser General Public
  *  License along with this library; if not, see
- *  <http://www.gnu.org/licenses/>.
+ *  <https://www.gnu.org/licenses/>.
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
-- 
gitgitgadget

