Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F1CE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 10:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjIXK6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjIXK5n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 06:57:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A8103
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:57:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d20548adso3968082f8f.0
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695553048; x=1696157848; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03bcTU8U9msmdNgSqxUmZhVz9tJlwC90Vn9fa21IaDY=;
        b=EDNIXDowb6h8hyullEWWkZeMEmQekZrSRekEzKYZo/0Wo+cWxyt950bScTO9MeCOnf
         X/vJTXJy65TZ1Vj8wgKMJwbYx/5Jff4w2BX9N2nR/0fn79CDT6CGxXOducttVsOyyXjp
         8sI2Ww3eUXIRmK4jl3uJ0f0K8oEckTYzkgaq0EE2hLPPk0Q0uU4GF05P12I40LvP+/v7
         4GlxcsitiAJUmbnWCrhH/ZTdY+SanzuW7EjJimawh46OuOjJrvmSqV1DT1gbD/6ixbOb
         VBXifPEyQpNE8shXsPf3WlI8uA1p2KwRP09/aXweaPkDfRLi+N+edXDssFUPy+oqniW/
         r03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553048; x=1696157848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03bcTU8U9msmdNgSqxUmZhVz9tJlwC90Vn9fa21IaDY=;
        b=XJ9Vd/2ZlQphZLhQ1iHQztr9vfcLb6UnPKkAcUDmSyBiPWa1vxrKB46zOspEQ6qHjG
         vr2nME53OSWrrC7tmpsdiFTjWWX7qCoL2cLqXtIROOc6XvSJcGISWNiLW1aGKSMtA0zU
         P22U3xQe6g7wsnaWkJ7c44Fw/J9P+5syunn/EfzMjfMppz61nrgYSQHsaEbjEDZUIc/m
         1QCcn8czWdmZVjb6ewAxRREv2PasSlbl9TW9pGSdXZ0afmqU+nl+DMGQkM1bC20BbbnZ
         lWHGVI/JvIz0dbVKS8ymY+dsohWdUMwJZgsF/DjE0wN/dlLss6X2udN7RnMapBnQrpf5
         RTQg==
X-Gm-Message-State: AOJu0Yx950mJkS1reHoaCkqvCxJh1XAQdF8CJ+dBLgcZ5du+f71Ku/d8
        e/HdZDAX5D0WwzTNLzt1i0UnMlaFDgc=
X-Google-Smtp-Source: AGHT+IFfDnWvswdXzWxGHsEn9AdmZlTKaFG8Dv4TovCQ0S8vCKg5XezXu9kUe+506wyGgSnhGRbmug==
X-Received: by 2002:adf:fdc4:0:b0:31a:dbd8:95d4 with SMTP id i4-20020adffdc4000000b0031adbd895d4mr3729023wrs.12.1695553047345;
        Sun, 24 Sep 2023 03:57:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d608c000000b0031c6e1ea4c7sm9011367wrt.90.2023.09.24.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 03:57:27 -0700 (PDT)
Message-ID: <80eb5da8ed45af4306e7bb28403e31e285efb3a9.1695553042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
        <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Sep 2023 10:57:19 +0000
Subject: [PATCH v2 2/4] doc: update links to current pages
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

It's somewhat traditional to respect sites' self-identification.

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
 Documentation/git.txt              | 2 +-
 git-gui/git-gui.sh                 | 2 +-
 gitk-git/gitk                      | 2 +-
 gitweb/static/js/lib/common-lib.js | 2 +-
 http.c                             | 2 +-
 imap-send.c                        | 2 +-
 json-writer.h                      | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

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

