Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2303DE6FE2F
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjIVOOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjIVOOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:14:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD93D100
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c8321c48fso2516113f8f.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695392033; x=1695996833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qN6OkkalDmcMIhfN3mpzCNwQ6VFL5leA18CmOgQLYOE=;
        b=W4oq8dwD0SYi07shpfi9uidT+6KKmFq5wmOUuuhsGf9Rbdq1lu6puJLSxWg+MR8I2u
         fibUref3VF7wsLNyqPuu8EIWKsOOsbAqAY2v9iU4MiiRi8/iL/TQ/TAEuEEq9kwZ47ND
         MGKmLFTWbbEu5nJ6kPhjrHQJgr9KQ1orfNwrs0gwlWR1Lld10bR0s+kdS1oZATI2WC3e
         lGiAdJotIoTreJVmgUtNwwOVFzUGXBqZMeXiioBWPlO15HH7ejUCfDxsFWlcvksBtw0p
         xOSSKChqrli7HQThKPgSnvEhsRo17dFROiue2b6VphnSYYmxBSSMB5B2/aQMUEE8D/Tu
         EaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695392033; x=1695996833;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qN6OkkalDmcMIhfN3mpzCNwQ6VFL5leA18CmOgQLYOE=;
        b=cMig7SymgelYMQQf/OYtL2xS/GJ2A77cykHk2QH2RmByuZn/7vzsn/IChGEumhkU3J
         u3p9zbhSVKpJjGDUEm/wSfZpWk8e4RElAo6Zik5VNu/NnlvpmiFR4MgRckeiFIRchcR6
         s5/G05LPEFzWohpJYoi2etO6eeE5bnJPeffmh+LSzrAQqFwbF7uMeY+ZFY3oD+0kr2k8
         75oH9hoDZxeI6giuqfdJO1cZoDbyqDc6j2bIz70UE70fMonOKBI0NRqRnm23cRy0xLWZ
         UCbjgusK6m0s8fZQrJtsCvIySoJlXTDiVP5NTaTDj3eFRE3mgxXylT3Pn54cgpzN32m9
         zc9Q==
X-Gm-Message-State: AOJu0Yxk6XxcuK79eL70ljsk3pFuABbstLsHzTostNAx07w0V/Yi78SS
        1rIMuzQ2Qkh42EjlVcF2buhxNakbjGY=
X-Google-Smtp-Source: AGHT+IHMOXPv5Dgs6ylX18j4Ozq70GX9vQG86kiZwHBLF2nWR92dJ6Y2X9fVq6mxhsBNx2H57yM4dg==
X-Received: by 2002:a05:6000:255:b0:319:6b56:94d9 with SMTP id m21-20020a056000025500b003196b5694d9mr2006999wrz.2.1695392032241;
        Fri, 22 Sep 2023 07:13:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm4540801wrt.60.2023.09.22.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:13:52 -0700 (PDT)
Message-ID: <f9f3f4af1c8889eb69f777a322348afc53feeca2.1695392028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 14:13:45 +0000
Subject: [PATCH 2/4] doc: update links to current pages
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
 Documentation/CodingGuidelines     | 2 +-
 Documentation/RelNotes/1.6.2.txt   | 2 +-
 Documentation/RelNotes/1.6.3.txt   | 2 +-
 Documentation/RelNotes/1.6.4.txt   | 2 +-
 Documentation/RelNotes/1.6.5.txt   | 2 +-
 Documentation/RelNotes/1.6.6.txt   | 2 +-
 Documentation/git-cvsimport.txt    | 2 +-
 Documentation/git-format-patch.txt | 2 +-
 Documentation/git-ls-remote.txt    | 4 ++--
 Documentation/git.txt              | 2 +-
 Documentation/gitcore-tutorial.txt | 4 ++--
 compat/nedmalloc/malloc.c.h        | 2 +-
 contrib/persistent-https/README    | 2 +-
 git-gui/git-gui.sh                 | 2 +-
 gitk-git/gitk                      | 2 +-
 gitweb/static/js/lib/common-lib.js | 2 +-
 http.c                             | 2 +-
 imap-send.c                        | 2 +-
 json-writer.h                      | 2 +-
 19 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 94d4d869039..81afc0b8df3 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -518,7 +518,7 @@ For Perl programs:
 
 For Python scripts:
 
- - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
+ - We follow PEP-8 (https://peps.python.org/pep-0008/).
 
  - As a minimum, we aim to be compatible with Python 2.7.
 
diff --git a/Documentation/RelNotes/1.6.2.txt b/Documentation/RelNotes/1.6.2.txt
index 980adfb3154..166d73c60fb 100644
--- a/Documentation/RelNotes/1.6.2.txt
+++ b/Documentation/RelNotes/1.6.2.txt
@@ -10,7 +10,7 @@ To ease the transition plan, the receiving repository of such a
 push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
-  http://git.or.cz/gitwiki/GitFaq#non-bare
+  https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
diff --git a/Documentation/RelNotes/1.6.3.txt b/Documentation/RelNotes/1.6.3.txt
index 4bcff945e01..bbf177fc3c5 100644
--- a/Documentation/RelNotes/1.6.3.txt
+++ b/Documentation/RelNotes/1.6.3.txt
@@ -10,7 +10,7 @@ To ease the transition plan, the receiving repository of such a
 push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
-  http://git.or.cz/gitwiki/GitFaq#non-bare
+  https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
diff --git a/Documentation/RelNotes/1.6.4.txt b/Documentation/RelNotes/1.6.4.txt
index a2a34b43a75..0fccfb0bf0b 100644
--- a/Documentation/RelNotes/1.6.4.txt
+++ b/Documentation/RelNotes/1.6.4.txt
@@ -10,7 +10,7 @@ To ease the transition plan, the receiving repository of such a
 push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
-  http://git.or.cz/gitwiki/GitFaq#non-bare
+  https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
diff --git a/Documentation/RelNotes/1.6.5.txt b/Documentation/RelNotes/1.6.5.txt
index 6c7f7da7eb9..79cb1b2b6df 100644
--- a/Documentation/RelNotes/1.6.5.txt
+++ b/Documentation/RelNotes/1.6.5.txt
@@ -21,7 +21,7 @@ To ease the transition plan, the receiving repository of such a
 push running this release will issue a big warning when the
 configuration variable is missing.  Please refer to:
 
-  http://git.or.cz/gitwiki/GitFaq#non-bare
+  https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
 for more details on the reason why this change is needed and the
diff --git a/Documentation/RelNotes/1.6.6.txt b/Documentation/RelNotes/1.6.6.txt
index 3ed1e014337..88b86a827e8 100644
--- a/Documentation/RelNotes/1.6.6.txt
+++ b/Documentation/RelNotes/1.6.6.txt
@@ -63,7 +63,7 @@ users will fare this time.
 
    Please refer to:
 
-   http://git.or.cz/gitwiki/GitFaq#non-bare
+   https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitFaq.html#non-bare
    https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
 
    for more details on the reason why this change is needed and the
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index e107ae930de..90fdc2551a3 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -22,7 +22,7 @@ DESCRIPTION
 deprecated; it does not work with cvsps version 3 and later.  If you are
 performing a one-shot import of a CVS repository consider using
 http://cvs2svn.tigris.org/cvs2git.html[cvs2git] or
-http://www.catb.org/esr/cvs-fast-export/[cvs-fast-export].
+https://gitlab.com/esr/cvs-fast-export[cvs-fast-export].
 
 Imports a CVS repository into Git. It will either create a new
 repository, or incrementally import into an existing one.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 06aa8bf0741..8ccc1973b80 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -610,7 +610,7 @@ Approach #3 (external editor)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The following Thunderbird extensions are needed:
-AboutConfig from http://aboutconfig.mozdev.org/ and
+AboutConfig from https://mjg.github.io/AboutConfig/ and
 External Editor from https://globs.org/articles.php?lng=en&pg=8
 
 1. Prepare the patch as a text file using your method of choice.
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 1c4f696ab57..b9c8478a62a 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -128,7 +128,7 @@ d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
 * List all references matching given patterns:
 +
 ----
-$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc
+$ git ls-remote https://git.kernel.org/pub/scm/git/git.git master seen rc
 5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
 c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
 ----
@@ -136,7 +136,7 @@ c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
 * List only tags matching a given wildcard pattern:
 +
 ----
-$ git ls-remote --tags http://www.kernel.org/pub/scm/git/git.git v\*
+$ git ls-remote --tags https://git.kernel.org/pub/scm/git/git.git v\*
 485a869c64a68cc5795dd99689797c5900f4716d	refs/tags/v2.39.2
 cbf04937d5b9fcf0a76c28f69e6294e9e3ecd7e6	refs/tags/v2.39.2^{}
 d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 11228956cd5..c7292eb25d0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1061,7 +1061,7 @@ Authors
 -------
 Git was started by Linus Torvalds, and is currently maintained by Junio
 C Hamano. Numerous contributions have come from the Git mailing list
-<git@vger.kernel.org>.  http://www.openhub.net/p/git/contributors/summary
+<git@vger.kernel.org>.  https://openhub.net/p/git/contributors/summary
 gives you a more complete list of contributors.
 
 If you have a clone of git.git itself, the
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 2122aeb9769..924a9a97807 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1101,8 +1101,8 @@ Examples.
 
 the above are equivalent to:
 
-. `git pull http://www.kernel.org/pub/scm/git/git.git/ HEAD`
-. `git pull http://www.kernel.org/pub/scm/git/git.git/ tag v0.99.1`
+. `git pull https://git.kernel.org/pub/scm/git/git.git/ HEAD`
+. `git pull https://git.kernel.org/pub/scm/git/git.git/ tag v0.99.1`
 
 
 How does the merge work?
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 5c5357a379f..4b711c6b9ca 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1359,7 +1359,7 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
   /* --[ start GCC compatibility ]----------------------------------------------
    * Compatibility <intrin_x86.h> header for GCC -- GCC equivalents of intrinsic
    * Microsoft Visual C++ functions. Originally developed for the ReactOS
-   * (<http://www.reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)
+   * (<https://reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)
    * projects.
    *
    * Copyright (c) 2006 KJK::Hyperion <hackbunny@reactos.com>
diff --git a/contrib/persistent-https/README b/contrib/persistent-https/README
index 2ad95893c27..2c9bec91066 100644
--- a/contrib/persistent-https/README
+++ b/contrib/persistent-https/README
@@ -60,7 +60,7 @@ https://kernel.googlesource.com/pub/scm/git/git
 
 PREREQUISITES
 
-The code is written in Go (http://golang.org/) and the Go compiler is
+The code is written in Go (https://go.dev/) and the Go compiler is
 required. Currently, the compiler must be built and installed from tip
 of source, in order to include a fix in the reverse http proxy:
 https://code.google.com/p/go/source/detail?r=a615b796570a2cd8591884767a7d67ede74f6648
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 1d6102e0674..4a11d590b68 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2390,7 +2390,7 @@ proc do_quit {{rc {1}}} {
 	set ret_code $rc
 
 	# Briefly enable send again, working around Tk bug
-	# http://sourceforge.net/tracker/?func=detail&atid=112997&aid=1821174&group_id=12997
+	# https://sourceforge.net/p/tktoolkit/bugs/2343/
 	tk appname [appname]
 
 	destroy .
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1db46977df0..7a087f123d7 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12472,7 +12472,7 @@ if {[tk windowingsystem] eq "aqua"} {
 
 catch {
     # follow the XDG base directory specification by default. See
-    # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
+    # https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
     if {[info exists env(XDG_CONFIG_HOME)] && $env(XDG_CONFIG_HOME) ne ""} {
         # XDG_CONFIG_HOME environment variable is set
         set config_file [file join $env(XDG_CONFIG_HOME) git gitk]
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index 17b1796496d..99e3eb8c3d9 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -137,7 +137,7 @@ function addCssRule(selector, style) {
  *   http://www.dustindiaz.com/getelementsbyclass/
  *   https://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
  *
- * See also http://ejohn.org/blog/getelementsbyclassname-speed-comparison/
+ * See also https://johnresig.com/blog/getelementsbyclassname-speed-comparison/
  *
  * @param {String} class: name of _single_ class to find
  * @param {String} [taghint] limit search to given tags
diff --git a/http.c b/http.c
index e138b4b96fb..33c6011e8d8 100644
--- a/http.c
+++ b/http.c
@@ -1877,7 +1877,7 @@ static void write_accept_language(struct strbuf *buf)
 	 * MAX_DECIMAL_PLACES must not be larger than 3. If it is larger than
 	 * that, q-value will be smaller than 0.001, the minimum q-value the
 	 * HTTP specification allows. See
-	 * http://tools.ietf.org/html/rfc7231#section-5.3.1 for q-value.
+	 * https://datatracker.ietf.org/doc/html/rfc7231#section-5.3.1 for q-value.
 	 */
 	const int MAX_DECIMAL_PLACES = 3;
 	const int MAX_LANGUAGE_TAGS = 1000;
diff --git a/imap-send.c b/imap-send.c
index 3b2077e39b2..448ca64c052 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -860,7 +860,7 @@ static void imap_close_store(struct imap_store *ctx)
 
 /*
  * hexchar() and cram() functions are based on the code from the isync
- * project (http://isync.sf.net/).
+ * project (https://isync.sourceforge.io/).
  */
 static char hexchar(unsigned int b)
 {
diff --git a/json-writer.h b/json-writer.h
index de140e54c98..04413bd1afd 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -4,7 +4,7 @@
 /*
  * JSON data structures are defined at:
  * [1] https://www.ietf.org/rfc/rfc7159.txt
- * [2] http://json.org/
+ * [2] https://www.json.org/
  *
  * The JSON-writer API allows one to build JSON data structures using a
  * simple wrapper around a "struct strbuf" buffer.  It is intended as a
-- 
gitgitgadget

