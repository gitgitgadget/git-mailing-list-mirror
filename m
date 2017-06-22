Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38E720401
	for <e@80x24.org>; Thu, 22 Jun 2017 02:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbdFVCvq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 22:51:46 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:34200
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752350AbdFVCvp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Jun 2017 22:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1498099903;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=01+cvRz7YCSQhPm724/vzOpocPBhbjIN/9xVVp0u6EU=;
        b=Nc0VHgEpHvYOup51dNAHMFCPGkxp1wnPUBMkyxaAt2gXTjo2Us6+vp7cklqzwUDa
        LRyMCsUSSR3mebma2oQvUxdh34A17n9GdYcnDo2lMAd+ZFZGNuh8g6BvQMYxgawAWjH
        BRpL6tCP5xwAcXGBlwTO4cG2jG06pq3O4prDJmpY=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ccdb6695c-7a8b1188-5bbe-43d1-8a8f-913c006c2474-000000@eu-west-1.amazonses.com>
In-Reply-To: <1498066891.32360.1.camel@gmail.com>
References: <1498066891.32360.1.camel@gmail.com>
Subject: [PATCH/FINAL] Documentation/git-submodule: cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 22 Jun 2017 02:51:42 +0000
X-SES-Outgoing: 2017.06.22-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "add" section for 'git-submodule' is redundant in
its description and the short synopsis line. Fix it.

Remove the redundant mentioning of the 'repository' argument
being mandatory.

The text is hard to read because of back-references, so remove
those.

Replace the word "humanish" by "canonical" as that conveys better
what we do to guess the path.

While at it, quote all occurrences of '.gitmodules' as that is an
important file in the submodule context, also link to it on its
first mention.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/git-submodule.txt | 49 ++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 74bc6200d564c..6e07bade39a7c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -63,14 +63,6 @@ add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--dep
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
 +
-This requires at least one argument: <repository>. The optional
-argument <path> is the relative location for the cloned submodule
-to exist in the superproject. If <path> is not given, the
-"humanish" part of the source repository is used ("repo" for
-"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
-The <path> is also used as the submodule's logical name in its
-configuration entries unless `--name` is used to specify a logical name.
-+
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
 or ../), the location relative to the superproject's default remote
@@ -87,21 +79,22 @@ If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
-<path> is the relative location for the cloned submodule to
-exist in the superproject. If <path> does not exist, then the
-submodule is created by cloning from the named URL. If <path> does
-exist and is already a valid Git repository, then this is added
-to the changeset without cloning. This second form is provided
-to ease creating a new submodule from scratch, and presumes
-the user will later push the submodule to the given URL.
+The optional argument <path> is the relative location for the cloned
+submodule to exist in the superproject. If <path> is not given, the
+canonical part of the source repository is used ("repo" for
+"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
+exists and is already a valid Git repository, then it is staged
+for commit without cloning. The <path> is also used as the submodule's
+logical name in its configuration entries unless `--name` is used
+to specify a logical name.
 +
-In either case, the given URL is recorded into .gitmodules for
-use by subsequent users cloning the superproject. If the URL is
-given relative to the superproject's repository, the presumption
-is the superproject and submodule repositories will be kept
-together in the same relative location, and only the
-superproject's URL needs to be provided: git-submodule will correctly
-locate the submodule using the relative URL in .gitmodules.
+The given URL is recorded into `.gitmodules` for use by subsequent users
+cloning the superproject. If the URL is given relative to the
+superproject's repository, the presumption is the superproject and
+submodule repositories will be kept together in the same relative
+location, and only the superproject's URL needs to be provided.
+git-submodule will correctly locate the submodule using the relative
+URL in `.gitmodules`.
 
 status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
@@ -123,7 +116,7 @@ too (and can also report changes to a submodule's work tree).
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
 	added and committed elsewhere) by setting `submodule.$name.url`
-	in .git/config. It uses the same setting from .gitmodules as
+	in .git/config. It uses the same setting from `.gitmodules` as
 	a template. If the URL is relative, it will be resolved using
 	the default remote. If there is no default remote, the current
 	repository will be assumed to be upstream.
@@ -197,7 +190,7 @@ configuration variable:
 	none;; the submodule is not updated.
 
 If the submodule is not yet initialized, and you just want to use the
-setting as stored in .gitmodules, you can automatically initialize the
+setting as stored in `.gitmodules`, you can automatically initialize the
 submodule with the `--init` option.
 
 If `--recursive` is specified, this command will recurse into the
@@ -220,7 +213,7 @@ foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
 	The command has access to the variables $name, $path, $sha1 and
 	$toplevel:
-	$name is the name of the relevant submodule section in .gitmodules,
+	$name is the name of the relevant submodule section in `.gitmodules`,
 	$path is the name of the submodule directory relative to the
 	superproject, $sha1 is the commit as recorded in the superproject,
 	and $toplevel is the absolute path to the top-level of the superproject.
@@ -242,7 +235,7 @@ git submodule foreach 'echo $path `git rev-parse HEAD`'
 
 sync [--recursive] [--] [<path>...]::
 	Synchronizes submodules' remote URL configuration setting
-	to the value specified in .gitmodules. It will only affect those
+	to the value specified in `.gitmodules`. It will only affect those
 	submodules which already have a URL entry in .git/config (that is the
 	case when they are initialized or freshly added). This is useful when
 	submodule URLs change upstream and you need to update your local
@@ -413,7 +406,7 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 --[no-]recommend-shallow::
 	This option is only valid for the update command.
 	The initial clone of a submodule will use the recommended
-	`submodule.<name>.shallow` as provided by the .gitmodules file
+	`submodule.<name>.shallow` as provided by the `.gitmodules` file
 	by default. To ignore the suggestions use `--no-recommend-shallow`.
 
 -j <n>::
@@ -429,7 +422,7 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 
 FILES
 -----
-When initializing submodules, a .gitmodules file in the top-level directory
+When initializing submodules, a `.gitmodules` file in the top-level directory
 of the containing repository is used to find the url of each submodule.
 This file should be formatted in the same way as `$GIT_DIR/config`. The key
 to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]

--
https://github.com/git/git/pull/377
