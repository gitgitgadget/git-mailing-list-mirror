Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F9D202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 09:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756825AbdJQJpU (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 05:45:20 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:47954
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752929AbdJQJpT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Oct 2017 05:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1508233517;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=8vvhbvBddl9ulE/Cu5GMHFT90SDODKChVd7e5m31tJ4=;
        b=EH8DJsxbmaSVtON2SIFeVfzD7MJ4oiovp8O2mXUukNFU/skg9cnaIdpHWVB+9D7E
        sOuTbI871BgkG6v6AHmbLMd4IMXx06eDsZ1bs4nBRhnQ8PARjphqzUn8Y6eR2avuIbx
        Yzpm4zFy9fNO/KW8TqpOiMKhJrFRkLImJwi2eELY=
From:   David Glasser <glasser@meteor.com>
To:     git@vger.kernel.org
Message-ID: <0102015f29b9128b-a8d6e31c-06f5-421c-989a-230a484482d3-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015f277a12fe-c69362e3-b14c-4b5c-abaa-4693fd6632c2-000000@eu-west-1.amazonses.com>
References: <0102015f277a12fe-c69362e3-b14c-4b5c-abaa-4693fd6632c2-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] doc: list filter-branch subdirectory-filter first
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Oct 2017 09:45:15 +0000
X-SES-Outgoing: 2017.10.17-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Glasser <glasser@davidglasser.net>

The docs claim that filters are applied in the listed order, so
subdirectory-filter should come first.

For consistency, apply the same order to the SYNOPSIS and the script's usage, as
well as the switch while parsing arguments.

Add missing --prune-empty to the script's usage.

Signed-off-by: David Glasser <glasser@davidglasser.net>
---
 Documentation/git-filter-branch.txt | 20 ++++++++++----------
 git-filter-branch.sh                | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 9e5169aa64f4f..394f74451a659 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -8,11 +8,11 @@ git-filter-branch - Rewrite branches
 SYNOPSIS
 --------
 [verse]
-'git filter-branch' [--setup <command>] [--env-filter <command>]
-	[--tree-filter <command>] [--index-filter <command>]
-	[--parent-filter <command>] [--msg-filter <command>]
-	[--commit-filter <command>] [--tag-name-filter <command>]
-	[--subdirectory-filter <directory>] [--prune-empty]
+'git filter-branch' [--setup <command>] [--subdirectory-filter <directory>]
+	[--env-filter <command>] [--tree-filter <command>]
+	[--index-filter <command>] [--parent-filter <command>]
+	[--msg-filter <command>] [--commit-filter <command>]
+	[--tag-name-filter <command>] [--prune-empty]
 	[--original <namespace>] [-d <directory>] [-f | --force]
 	[--] [<rev-list options>...]
 
@@ -89,6 +89,11 @@ OPTIONS
 	can be used or modified in the following filter steps except
 	the commit filter, for technical reasons.
 
+--subdirectory-filter <directory>::
+	Only look at the history which touches the given subdirectory.
+	The result will contain that directory (and only that) as its
+	project root. Implies <<Remap_to_ancestor>>.
+
 --env-filter <command>::
 	This filter may be used if you only need to modify the environment
 	in which the commit will be performed.  Specifically, you might
@@ -167,11 +172,6 @@ be removed, buyer beware. There is also no support for changing the
 author or timestamp (or the tag message for that matter). Tags which point
 to other tags will be rewritten to point to the underlying commit.
 
---subdirectory-filter <directory>::
-	Only look at the history which touches the given subdirectory.
-	The result will contain that directory (and only that) as its
-	project root. Implies <<Remap_to_ancestor>>.
-
 --prune-empty::
 	Some filters will generate empty commits that leave the tree untouched.
 	This option instructs git-filter-branch to remove such commits if they
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3a74602ef3771..b7827e745a92a 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -81,12 +81,12 @@ set_ident () {
 	finish_ident COMMITTER
 }
 
-USAGE="[--setup <command>] [--env-filter <command>]
-	[--tree-filter <command>] [--index-filter <command>]
-	[--parent-filter <command>] [--msg-filter <command>]
-	[--commit-filter <command>] [--tag-name-filter <command>]
-	[--subdirectory-filter <directory>] [--original <namespace>]
-	[-d <directory>] [-f | --force]
+USAGE="[--setup <command>] [--subdirectory-filter <directory>]
+	[--env-filter <command>] [--tree-filter <command>]
+	[--index-filter <command>] [--parent-filter <command>]
+	[--msg-filter <command>] [--commit-filter <command>]
+	[--tag-name-filter <command>] [--prune-empty]
+	[--original <namespace>] [-d <directory>] [-f | --force]
 	[--] [<rev-list options>...]"
 
 OPTIONS_SPEC=
@@ -153,6 +153,10 @@ do
 	--setup)
 		filter_setup="$OPTARG"
 		;;
+	--subdirectory-filter)
+		filter_subdir="$OPTARG"
+		remap_to_ancestor=t
+		;;
 	--env-filter)
 		filter_env="$OPTARG"
 		;;
@@ -174,10 +178,6 @@ do
 	--tag-name-filter)
 		filter_tag_name="$OPTARG"
 		;;
-	--subdirectory-filter)
-		filter_subdir="$OPTARG"
-		remap_to_ancestor=t
-		;;
 	--original)
 		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
 		;;

--
https://github.com/git/git/pull/415
