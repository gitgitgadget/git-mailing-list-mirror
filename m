Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F5AC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiGMNVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiGMNU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:20:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF5A44A
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:20:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so1213139wma.2
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NMFt49jdQBSiJIxaB/Gr3ILjVtOdeH/cbNOqJwr7YR4=;
        b=QodVmbUo4rVH9dHyLvZtmPyAtrLdJ/trL9GrMxpVIPN8j9az2t8KbnFmcoE0J5rVVC
         A4X1oSKEavq8oe44V63kIN9wPMHWGIzWjaR9ygK2/lx/0bCGgztUA1bt/x604XtSrFEX
         Nb7F1CWqZfBfd+DPvYnY0juZYreOreIae5PDbV7RRlyzh8Q3pX+t2RV0oSfuXPpEwxva
         OUkLd8BVAnH8v5kKHD81LSkloMgKRTj5qbQy4aR9UjF2FAHVfUaErpsrA+FFY11a17wb
         26qHdS5XI6KsI7kTd1sXsGG9KosxCKhwdNb9RoibuU5E+pyTm+XTbuqIaVhGXABQaUtD
         GzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NMFt49jdQBSiJIxaB/Gr3ILjVtOdeH/cbNOqJwr7YR4=;
        b=0Bn+d9fd5kMo3SG82DtuqGkE3OzG0PfXEz7d0ljyGlmcjlNrSy0+Erl+Tq3iMvvnpQ
         HD27d7GdqEUnYnd5galJ3kRiiq+tA+KMpslPrH7AZLHj2oxYEBnk5u4/BEEJN9gldlzg
         QCV8lbiWd/PsonSbAaO3v/I/l+2dUV0JdNU2txECJnrTdD7r6H9jXkzb5xQ/SaGxndMf
         hUQQjDSUA6Xn1y3YdaZMmh9J/2jFKqFxc6/MyQg37Mj+t4wjKrQa87tJUjoQsbr575H3
         RjPGphhZ9eRLGt7BAVR6SIaHf2g31DGEK9eXc7DV0i22s9Kp32bxrvg2Plxr/FGbCbHs
         q1Ew==
X-Gm-Message-State: AJIora8h4YM6loIhMbaQOPGq6l0a07TeQuyWttlx2/pv2a9ei5gc45GD
        me1mqln4u20QETd+Xd4awmzG7aMd1X4=
X-Google-Smtp-Source: AGRyM1s+v05wPdciLOWJpEm1f/Pm1XJp28r6NhQMnjxF3hfjfD/ib3CoYWL3bG7uRtd5N0CK03MBGw==
X-Received: by 2002:a05:600c:1d9e:b0:3a2:f365:29ee with SMTP id p30-20020a05600c1d9e00b003a2f36529eemr5014895wms.24.1657718453383;
        Wed, 13 Jul 2022 06:20:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b003a2fb1224d9sm1875852wmb.19.2022.07.13.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:20:52 -0700 (PDT)
Message-Id: <ec81aac05c40318755f5311a20e8f9cc55d289fc.1657718450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 13:20:48 +0000
Subject: [PATCH 1/3] Documentation: use allowlist and denylist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Using "allowlist" and "denylist" is a more precise definition of the
functionality they provide. The previous color-based words assume
cultural interpretation to provide the meaning.

Focus on replacements in the Documentation/ directory since these are
not functional uses.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-cvsserver.txt |  2 +-
 Documentation/git-daemon.txt    | 10 +++++-----
 Documentation/git.txt           |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 4dc57ed2547..40ea1f3af8e 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -313,7 +313,7 @@ circumstances, allowing easier restricted usage through git-shell.
 
 GIT_CVSSERVER_BASE_PATH takes the place of the argument to --base-path.
 
-GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
+GIT_CVSSERVER_ROOT specifies a single-directory allowlist. The
 repository must still be configured to allow access through
 git-cvsserver, as described above.
 
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index fdc28c041c7..ff74a90aead 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -33,7 +33,7 @@ It verifies that the directory has the magic file "git-daemon-export-ok", and
 it will refuse to export any Git directory that hasn't explicitly been marked
 for export this way (unless the `--export-all` parameter is specified). If you
 pass some directory paths as 'git daemon' arguments, you can further restrict
-the offers to a whitelist comprising of those.
+the offers to a allowlist comprising of those.
 
 By default, only `upload-pack` service is enabled, which serves
 'git fetch-pack' and 'git ls-remote' clients, which are invoked
@@ -50,7 +50,7 @@ OPTIONS
 	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
 	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
 	'git daemon' will refuse to start when this option is enabled and no
-	whitelist is specified.
+	allowlist is specified.
 
 --base-path=<path>::
 	Remap all the path requests as relative to the given path.
@@ -73,7 +73,7 @@ OPTIONS
 	%IP for the server's IP address, %P for the port number,
 	and %D for the absolute path of the named repository.
 	After interpolation, the path is validated against the directory
-	whitelist.
+	allowlist.
 
 --export-all::
 	Allow pulling from all directories that look like Git repositories
@@ -218,7 +218,7 @@ standard output to be sent to the requestor as an error message when
 it declines the service.
 
 <directory>::
-	A directory to add to the whitelist of allowed directories. Unless
+	A directory to add to the allowlist of allowed directories. Unless
 	--strict-paths is specified this will also include subdirectories
 	of each named directory.
 
@@ -264,7 +264,7 @@ git		9418/tcp		# Git Version Control System
 
 'git daemon' as inetd server::
 	To set up 'git daemon' as an inetd service that handles any
-	repository under the whitelisted set of directories, /pub/foo
+	repository under the allowlisted set of directories, /pub/foo
 	and /pub/bar, place an entry like the following into
 	/etc/inetd all on one line:
 +
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 302607a4967..384718ee677 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -887,7 +887,7 @@ for full details.
 	protocols has `protocol.<name>.allow` set to `always`
 	(overriding any existing configuration). In other words, any
 	protocol not mentioned will be disallowed (i.e., this is a
-	whitelist, not a blacklist). See the description of
+	allowlist, not a denylist). See the description of
 	`protocol.allow` in linkgit:git-config[1] for more details.
 
 `GIT_PROTOCOL_FROM_USER`::
-- 
gitgitgadget

