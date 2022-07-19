Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF50C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbiGSSc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbiGSScX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:32:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C85A16D
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a11so3347314wmq.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yEtHhVCIrZpEIOt+KxyhRfN9vJ6zK1xLKVAOv4WTj+A=;
        b=B0JnRAiTwOlf+4wYDg6nxxct8WCyFFhJTb4z2jGo9mgX3bxVrkYfIRba1oIGaMggyc
         ioMB6Eg+MnTOvw93bIXcfbw6sBJlQe240vfDjiYTqMgrRJ+aodOyICm6NBdwSZzN87oC
         bdYJkOsfpUafhO2+Z11Im68irqssSbWb2ynsDvadinX/IXLbayw5XWNpGC1uUJf5o4jr
         5KCHqWQeeSHy7/8jCYx+6utKahcWkOYuKXp1Jyj2X0xOBbtvJvTris8q+4uf6Klob6G9
         K8gbPd89T4Ba85xuJmZf2b0frZuLGzf4iYyYKYGdUmdqSQZcQazCIePfZ3B7HmFkKygF
         crWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yEtHhVCIrZpEIOt+KxyhRfN9vJ6zK1xLKVAOv4WTj+A=;
        b=JcwUJ7vA9ci0UbAI4B6A1RJ3ctZ219S+b3Ot+2kaiBXY1DmdTU7VQvW5R3zmCtRz2K
         rwDRHryFMO6abMk1uWogY9GNoZXmYhBd7SNgQgENqdbECFBfXd8pEmztjoUQW4o8IuNK
         fZxN2F5uAbKA73tyRIjt0dr6Mtdz/jc9+HbhYfdn5KMuJCASUHO+lweP6UceaJlUzjO0
         DyObOKw6rN/eNyAz0BVXnBBi7xYUurgOl8rUw98KcA+EWukWzeea5SjEjM1omAQrkp7c
         i04EmRRTYUywopWxIn2IEw2zmT0Rn2dL4AJPAO9UFWdPdS6PNoCUWnSXLmbdqxY+dUpf
         S/IQ==
X-Gm-Message-State: AJIora/XyxtyBs9gPphDnZSqMkPylhqVkfMvSyb2QYp2HV+K8fsjQHiS
        nUjUg3BWBqP9K2/Vc5WtrGO1ZXmLFq0=
X-Google-Smtp-Source: AGRyM1uumF6EmILigpSfrfzEaXualLvyLhePWAYXJ86Cj8EFzS9nFZaOfgZ0RmvXOIIk9szQrjttDw==
X-Received: by 2002:a7b:c8da:0:b0:3a3:19e:4a3a with SMTP id f26-20020a7bc8da000000b003a3019e4a3amr540011wml.201.1658255540145;
        Tue, 19 Jul 2022 11:32:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12-20020adfe28c000000b0021e2e1b17d9sm2836044wri.51.2022.07.19.11.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:32:19 -0700 (PDT)
Message-Id: <d5ca7bffac0679823c78228e6d06ea9545dc4325.1658255537.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
References: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
        <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:32:13 +0000
Subject: [PATCH v3 1/5] daemon: clarify directory arguments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The undecorated arguments to the 'git-daemon' command provide a list of
directories. When at least one directory is specified, then 'git-daemon'
only serves requests that are within that directory list. The boolean
'--strict-paths' option makes the list more explicit in that
subdirectories are no longer included.

The existing documentation and error messages around this directory list
refer to it and its behavior as a "whitelist". The word "whitelist" has
cultural implications that are not inclusive.  Thankfully, it is not
difficult to reword and avoid its use. In the process, we can define the
purpose of this directory list directly.

In Documentation/git-daemon.txt, rewrite the OPTIONS section around the
'<directory>' option. Add additional clarity to the other options that
refer to these directories.

Some error messages can also be improved in daemon.c. The
'--strict-paths' option requires '<directory>' arguments, so refer to
that section of the documentation directly. A logerror() call points out
that a requested directory is not in the specified directory list. We
can use "list" here without any loss of information.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-daemon.txt | 21 +++++++++++----------
 daemon.c                     |  8 ++++----
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index fdc28c041c7..236df516c73 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -32,8 +32,8 @@ that service if it is enabled.
 It verifies that the directory has the magic file "git-daemon-export-ok", and
 it will refuse to export any Git directory that hasn't explicitly been marked
 for export this way (unless the `--export-all` parameter is specified). If you
-pass some directory paths as 'git daemon' arguments, you can further restrict
-the offers to a whitelist comprising of those.
+pass some directory paths as 'git daemon' arguments, the offers are limited to
+repositories within those directories.
 
 By default, only `upload-pack` service is enabled, which serves
 'git fetch-pack' and 'git ls-remote' clients, which are invoked
@@ -50,7 +50,7 @@ OPTIONS
 	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
 	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
 	'git daemon' will refuse to start when this option is enabled and no
-	whitelist is specified.
+	directory arguments are provided.
 
 --base-path=<path>::
 	Remap all the path requests as relative to the given path.
@@ -73,7 +73,7 @@ OPTIONS
 	%IP for the server's IP address, %P for the port number,
 	and %D for the absolute path of the named repository.
 	After interpolation, the path is validated against the directory
-	whitelist.
+	list.
 
 --export-all::
 	Allow pulling from all directories that look like Git repositories
@@ -218,9 +218,11 @@ standard output to be sent to the requestor as an error message when
 it declines the service.
 
 <directory>::
-	A directory to add to the whitelist of allowed directories. Unless
-	--strict-paths is specified this will also include subdirectories
-	of each named directory.
+	The remaining arguments provide a list of directories. If any
+	directories are specified, then the `git-daemon` process will
+	serve a requested directory only if it is contained in one of
+	these directories. If `--strict-paths` is specified, then the
+	requested directory must match one of these directories exactly.
 
 SERVICES
 --------
@@ -264,9 +266,8 @@ git		9418/tcp		# Git Version Control System
 
 'git daemon' as inetd server::
 	To set up 'git daemon' as an inetd service that handles any
-	repository under the whitelisted set of directories, /pub/foo
-	and /pub/bar, place an entry like the following into
-	/etc/inetd all on one line:
+	repository within `/pub/foo` or `/pub/bar`, place an entry like
+	the following into `/etc/inetd` all on one line:
 +
 ------------------------------------------------
 	git stream tcp nowait nobody  /usr/bin/git
diff --git a/daemon.c b/daemon.c
index 58f1077885c..0ae7d12b5c1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -279,7 +279,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		/* The validation is done on the paths after enter_repo
 		 * appends optional {.git,.git/.git} and friends, but
 		 * it does not use getcwd().  So if your /pub is
-		 * a symlink to /mnt/pub, you can whitelist /pub and
+		 * a symlink to /mnt/pub, you can include /pub and
 		 * do not have to say /mnt/pub.
 		 * Do not say /pub/.
 		 */
@@ -298,7 +298,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 			return path;
 	}
 
-	logerror("'%s': not in whitelist", path);
+	logerror("'%s': not in directory list", path);
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
@@ -403,7 +403,7 @@ static int run_service(const char *dir, struct daemon_service *service,
 	 * a "git-daemon-export-ok" flag that says that the other side
 	 * is ok with us doing this.
 	 *
-	 * path_ok() uses enter_repo() and does whitelist checking.
+	 * path_ok() uses enter_repo() and checks for included directories.
 	 * We only need to make sure the repository is exported.
 	 */
 
@@ -1444,7 +1444,7 @@ int cmd_main(int argc, const char **argv)
 		cred = prepare_credentials(user_name, group_name);
 
 	if (strict_paths && (!ok_paths || !*ok_paths))
-		die("option --strict-paths requires a whitelist");
+		die("option --strict-paths requires '<directory>' arguments");
 
 	if (base_path && !is_directory(base_path))
 		die("base-path '%s' does not exist or is not a directory",
-- 
gitgitgadget

