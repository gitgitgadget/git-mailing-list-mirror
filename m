Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D59C433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 09:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiDQJii (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiDQJig (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 05:38:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F83A3FBF8
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 02:36:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x18so7657462wrc.0
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRaNvqJJ/NFdANu7RqBB2N8CwoaybBUqe7dRSE9jx70=;
        b=RSCFxr9fsZdIRuGHiH7uPgvoTCp+FIv1FUR64jKTDP2hFBtBPLYctPdNfHz/j8SK/5
         tmxEl9Y4d6ea6U8/qAvVhZ5URRDZmPMJBIKQiQnwTzRXB3MDSM7IiE6b5VSDmnYdh3Xw
         uCgpoOLM6PR8TSwRpOQHQqnZu5utQw+v2ARx0X3gTnj9dBp9VNlkDDol7z43AoiKPq6H
         zOIqpLbvMdO69NkBduTnBHUk6xoNuvWKn1OwIrRlbiloRJVr5yJeWJWkXoWk8OILdpgm
         ahLOWTtCadwvEpxlFHWSqCYxQjswpPc4fo6aH/TO+mqGA5UqGCNk6B6CaUlC8ijSkSW4
         Mu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRaNvqJJ/NFdANu7RqBB2N8CwoaybBUqe7dRSE9jx70=;
        b=go57V//5EcqPOzi89jXKT+oLF5q6ctXmPDTEeRmK7eZZ0LLXbMfsjiF6AWysglDvU+
         s4zbXw+Z+EG11W0us+9TOswLKL5mnZT9O4U+kks+upAAMULKh9u87LxHlHDdqfOnfbJL
         VyKT5QB3eFbYLbdXInGoapgmFgNxBIkqdtaDnIxi7ADBEN9BXn7E4RP/Mb2Vivu1OyNe
         P2QtE/UY621KJu6SrdO9bzKPrP6hbJq32ZPP2tcVIwVVhSk5bp3/1jJY7jpR+r2hPCr0
         zCkfXq9sCwp3JHz9nDoEoFu11tnT9aGOZfCFthdgXE12nx5JCizwJAXOmRkA7TVQLHtc
         rrfQ==
X-Gm-Message-State: AOAM533ZVvDQoSWVUHAn5a5CJGGqSG6U9QBulcibCbOK0eYEW/QK414t
        F1tcZ3lmTRRh02NSQ79mBnM=
X-Google-Smtp-Source: ABdhPJyjhrOVLCPbV2YWzXNiIXmen4Ij8VCaUeGT5om70bEeRbIEVk+d4gLkl7tVdNAqLeggfO5Byw==
X-Received: by 2002:a05:6000:144d:b0:205:8905:4cc1 with SMTP id v13-20020a056000144d00b0020589054cc1mr5064667wrx.508.1650188159156;
        Sun, 17 Apr 2022 02:35:59 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d45cb000000b0020a810f7726sm4470757wrs.5.2022.04.17.02.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 02:35:58 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     Matthieu.Moy@univ-lyon1.fr, cogoni.guillaume@gmail.com,
        derrickstolee@github.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        shaoxuan.yuan02@gmail.com
Subject: [PATCH v2 1/1] Documentation/ToolsForGit.txt: Tools for developing Git
Date:   Sun, 17 Apr 2022 11:35:49 +0200
Message-Id: <20220417093549.101436-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220417093549.101436-1-cogoni.guillaume@gmail.com>
References: <xmqqlew554ye.fsf@gitster.g>
 <20220417093549.101436-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This document aims to gather tools that have a README and/or scripts in
the GIT project in order to simplify the search of information for a
particular tool.

Move the part about Emacs configuration from CodingGuidelines to
ToolsForGit.txt because it's the purpose of the new file centralize the
information about tools.

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 Documentation/CodingGuidelines | 11 -----
 Documentation/Makefile         |  1 +
 Documentation/ToolsForGit.txt  | 79 ++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ToolsForGit.txt

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b20b2f94f1..a7d21d6f6b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -492,17 +492,6 @@ For Perl programs:
 
  - Learn and use Git.pm if you need that functionality.
 
- - For Emacs, it's useful to put the following in
-   GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
-
-    ;; note the first part is useful for C editing, too
-    ((nil . ((indent-tabs-mode . t)
-                  (tab-width . 8)
-                  (fill-column . 80)))
-     (cperl-mode . ((cperl-indent-level . 8)
-                    (cperl-extra-newline-before-brace . nil)
-                    (cperl-merge-trailing-else . t))))
-
 For Python scripts:
 
  - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 44c080e3e5..7058dd2185 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -93,6 +93,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bundle-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
diff --git a/Documentation/ToolsForGit.txt b/Documentation/ToolsForGit.txt
new file mode 100644
index 0000000000..d96cadd09c
--- /dev/null
+++ b/Documentation/ToolsForGit.txt
@@ -0,0 +1,79 @@
+Tools for developing Git
+========================
+:sectanchors:
+
+[[summary]]
+== Summary
+
+This document aims to gather tools that have a README and/or scripts in
+the Git project.
+
+[[author]]
+=== Author
+
+The Git community.
+
+[[table_of_contents]]
+== Table of contents
+
+- <<vscode>>
+- <<emacs>>
+
+[[vscode]]
+=== Visual Studio Code (VS Code)
+
+The contrib/vscode/init.sh script creates configuration files that enable
+several valuable VS Code features. See contrib/vscode/README.md for more
+information on using the script.
+
+In particular, this script enables using the VS Code visual debugger, including
+setting breakpoints, logpoints, conditional breakpoints and more in the editor.
+
+[[emacs]]
+=== Emacs
+
+- To follow rules of the CodingGuideline, it's useful to put the following in
+GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
+----
+;; note the first part is useful for C editing, too
+((nil . ((indent-tabs-mode . t)
+	 (tab-width . 8)
+	 (fill-column . 80)))
+	 (cperl-mode . ((cperl-indent-level . 8)
+			(cperl-extra-newline-before-brace . nil)
+			(cperl-merge-trailing-else . t))))
+----
+
+- The version for C:
+----
+(defun c-lineup-arglist-tabs-only (ignored)
+	"Line up argument lists by tabs, not spaces"
+	(let* ((anchor (c-langelem-pos c-syntactic-element))
+	       (column (c-langelem-2nd-pos c-syntactic-element))
+	       (offset (- (1+ column) anchor))
+	       (steps (floor offset c-basic-offset)))
+	 (* (max steps 1)
+	    c-basic-offset)))
+
+(add-hook 'c-mode-common-hook
+	(lambda ()
+		;; Add kernel style
+		(c-add-style
+		 "linux-tabs-only"
+		 '("linux" (c-offsets-alist
+			    (arglist-cont-nonempty
+			     c-lineup-gcc-asm-reg
+			     c-lineup-arglist-tabs-only))))))
+
+(add-hook 'c-mode-hook
+	(lambda ()
+		(let ((filename (buffer-file-name)))
+		 ;; Enable kernel mode for the appropriate files
+		 (when (and filename
+			(string-match (expand-file-name "~/src/linux-trees")
+				       filename))
+		 (setq indent-tabs-mode t)
+		 (setq show-trailing-whitespace t)
+		 (c-set-style "linux-tabs-only")))))
+----
+
-- 
2.25.1

