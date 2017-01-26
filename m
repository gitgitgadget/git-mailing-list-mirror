Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E3A1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbdAZOwF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:52:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:58102 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbdAZOwE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:52:04 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MarNa-1clfv60NC6-00KOC2; Thu, 26
 Jan 2017 15:51:54 +0100
Date:   Thu, 26 Jan 2017 15:51:51 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Segev Finer <segev208@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 1/3] connect: handle putty/plink also in GIT_SSH_COMMAND
In-Reply-To: <cover.1485442231.git.johannes.schindelin@gmx.de>
Message-ID: <199723aedcaa8464967a9faf33163c0cd196c941.1485442231.git.johannes.schindelin@gmx.de>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de> <cover.1485442231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Z4N84rqLFI5KgxOHa0c0wpLBmImjS0udYx8MLwVtfm9XekJPS6T
 cuejndZANwaEV9CPIiao4odsT/UhFXS+yf15n3WAJ1vh9d3326Lzu8wx0c3EnjhXWWvOgwm
 0nUv9kmoyVi0MqzLtdT+6EWLBcx50dlZGJACpiH9a6ysdrLXnSlMKA+Yc2bUc+tSS6TRRc2
 w4r3lm+O2XaLTZnZIRkfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hTcxXws31y0=:HE0hjIKjZwxcXrYIQ4BDHf
 8R1M87uq7z2AR/+cI9xmtCVMlM+PKomVn/7zrL4VzUi+Q85VWffHrBi7fJRzm7Y+grOjkxklk
 et6wHrFpZqt1coN+FT0K2wFQD47a1nlEYTUMVWoppuNKkLzS5rJh2Xg+9pVyD/haMFrDV6Ldj
 cDOKW7ezhZlPh3mPXYe+LIY8KQHjF+qYTHpu3V7uaz6rWO7LvNJ8WHY8REeL6d1ElfQImgyGM
 YnqhYO+A7fekq/WT7hEkCap5mka0rDbufBJIapnPX3Xpby1vt58hlDHkSf0aKjCG15lq9wzN1
 LVoaIpB6KwZHMiqLB9cMmnRy4U7RhzuvAnyZc5cm0zqCwoG3QOovA8m4C6MF2cdQrhBB7u5ix
 wkHBc9jOmx76aFMDVtSI7uZyOGiZ9QDcf9Wvw3e6ZpzHVBXyLiwGHDj+4ppOQZ98ti0NsMKwZ
 c4TUHL7nEsK4MKVjyx8sw1AjOJRERGJr9DnlxB8cjQum8USQ2xtqisBLSuELJCiPTLQBoP+KG
 0xDwOBRyQbte/5lft06JfteBGeHP+gnE/0WvaAZUACDlsHumfcGRhu/Tn1IYAa2xjDsVW2jSE
 0Oc4ompW0AFoNdSAZKUlgeH5DTpcSwfS3kxdt1uijF0TLD96IGVBakgI1WQl8zoOpsIoOVoQS
 wKxvjTtfWN2JwoWVXIGSrOTb20YRuQOqlKY+NiY5U9h2bPf+43K9a7d5rWDjqAfP09UPa5x3f
 E9+VYVn70n+TInUpLRkJLPcWBTe+/U6f/vzJqfFmXi41gAXaqhwlhw58h2ZaLqCBpKyKqEQUP
 4upzG/2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Segev Finer <segev208@gmail.com>

Git for Windows has special support for the popular SSH client PuTTY:
when using PuTTY's non-interactive version ("plink.exe"), we use the -P
option to specify the port rather than OpenSSH's -p option. TortoiseGit
ships with its own, forked version of plink.exe, that adds support for
the -batch option, and for good measure we special-case that, too.

However, this special-casing of PuTTY only covers the case where the
user overrides the SSH command via the environment variable GIT_SSH
(which allows specifying the name of the executable), not
GIT_SSH_COMMAND (which allows specifying a full command, including
additional command-line options).

When users want to pass any additional arguments to (Tortoise-)Plink,
such as setting a private key, they are required to either use a shell
script named plink or tortoiseplink or duplicate the logic that is
already in Git for passing the correct style of command line arguments,
which can be difficult, error prone and annoying to get right.

This patch simply reuses the existing logic and expands it to cover
GIT_SSH_COMMAND, too.

Note: it may look a little heavy-handed to duplicate the entire
command-line and then split it, only to extract the name of the
executable. However, this is not a performance-critical code path, and
the code is much more readable this way.

Signed-off-by: Segev Finer <segev208@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 connect.c        | 23 ++++++++++++++++-------
 t/t5601-clone.sh | 15 +++++++++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/connect.c b/connect.c
index 8cb93b0720..c81f77001b 100644
--- a/connect.c
+++ b/connect.c
@@ -772,6 +772,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 			int putty = 0, tortoiseplink = 0;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
+			char *ssh_argv0 = NULL;
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
 
@@ -792,10 +793,15 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			ssh = get_ssh_command();
-			if (!ssh) {
-				const char *base;
-				char *ssh_dup;
-
+			if (ssh) {
+				char *split_ssh = xstrdup(ssh);
+				const char **ssh_argv;
+
+				if (split_cmdline(split_ssh, &ssh_argv))
+					ssh_argv0 = xstrdup(ssh_argv[0]);
+				free(split_ssh);
+				free((void *)ssh_argv);
+			} else {
 				/*
 				 * GIT_SSH is the no-shell version of
 				 * GIT_SSH_COMMAND (and must remain so for
@@ -807,8 +813,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 				if (!ssh)
 					ssh = "ssh";
 
-				ssh_dup = xstrdup(ssh);
-				base = basename(ssh_dup);
+				ssh_argv0 = xstrdup(ssh);
+			}
+
+			if (ssh_argv0) {
+				const char *base = basename(ssh_argv0);
 
 				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
 					!strcasecmp(base, "tortoiseplink.exe");
@@ -816,7 +825,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 					!strcasecmp(base, "plink") ||
 					!strcasecmp(base, "plink.exe");
 
-				free(ssh_dup);
+				free(ssh_argv0);
 			}
 
 			argv_array_push(&conn->args, ssh);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4241ea5b32..9335e10c2a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -386,6 +386,21 @@ test_expect_success 'tortoiseplink is like putty, with extra arguments' '
 	expect_ssh "-batch -P 123" myhost src
 '
 
+test_expect_success 'double quoted plink.exe in GIT_SSH_COMMAND' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
+	GIT_SSH_COMMAND="\"$TRASH_DIRECTORY/plink.exe\" -v" \
+		git clone "[myhost:123]:src" ssh-bracket-clone-plink-3 &&
+	expect_ssh "-v -P 123" myhost src
+'
+
+SQ="'"
+test_expect_success 'single quoted plink.exe in GIT_SSH_COMMAND' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
+	GIT_SSH_COMMAND="$SQ$TRASH_DIRECTORY/plink.exe$SQ -v" \
+		git clone "[myhost:123]:src" ssh-bracket-clone-plink-4 &&
+	expect_ssh "-v -P 123" myhost src
+'
+
 # Reset the GIT_SSH environment variable for clone tests.
 setup_ssh_wrapper
 
-- 
2.11.1.windows.prerelease.2.9.g3014b57


