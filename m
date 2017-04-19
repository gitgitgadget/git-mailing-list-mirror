Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513541FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 09:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761448AbdDSJPS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 05:15:18 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:36002
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761374AbdDSJPR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Apr 2017 05:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1492593315;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ic1pGoKeoP1cfaTP56g0wAhsN0qtnlv+t5dhJ+v4Co0=;
        b=XoHL2vRrBUO3Ynnc/eHDkUgDu3bOPq6yWkVvbLUZ1VjgZHZJcUTpG1pcV6MR4eHB
        JLZwM81rq7KE/p3dR0nfArBfkFbfmJoMG8/xBxRxAalz0vZI2GyEL/P28ctLvXc+ZDd
        mfbHQRN1WdXEyv/DVXvcJBBfdqdXmRz8XF/iKFaw=
From:   Sebastian Schuberth <sschuberth@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015b857e8d20-1c33bac0-0e25-4afd-a533-48f37a09a83f-000000@eu-west-1.amazonses.com>
Subject: [PATCH] gitmodules: clarify the ignore option values
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Apr 2017 09:15:15 +0000
X-SES-Outgoing: 2017.04.19-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more structure and describe each possible option in a self-contained
way, not referring to any of the previously described options.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/gitmodules.txt | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 8f7c50f..4700624 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -66,17 +66,26 @@ submodule.<name>.fetchRecurseSubmodules::
 
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
-	a submodule as modified. When set to "all", it will never be considered
-	modified (but will nonetheless show up in the output of status and
-	commit when it has been staged), "dirty" will ignore all changes
-	to the submodules work tree and
-	takes only differences between the HEAD of the submodule and the commit
-	recorded in the superproject into account. "untracked" will additionally
-	let submodules with modified tracked files in their work tree show up.
-	Using "none" (the default when this option is not set) also shows
-	submodules that have untracked files in their work tree as changed.
-	If this option is also present in the submodules entry in .git/config of
-	the superproject, the setting there will override the one found in
+	a submodule as modified. The following values are supported:
+
+	all;; The submodule will never be considered modified (but will
+	    nonetheless show up in the output of status and commit when it has
+	    been staged).
+
+	dirty;; All changes to the submodule's work tree will be ignored, only
+	    committed differences between the HEAD of the submodule and its
+	    recorded state in the superproject are taken into account.
+
+	untracked;; Only untracked files in submodules will be ignored.
+	    Committed differences and modifications to tracked files will show
+	    up.
+
+	none;; No modifiations to submodules are ignored, all of committed
+	    differences, and modifications to tracked and untracked files are
+	    shown. This is the default option.
+
+	If this option is also present in the submodules entry in .git/config
+	of the superproject, the setting there will override the one found in
 	.gitmodules.
 	Both settings can be overridden on the command line by using the
 	"--ignore-submodule" option. The 'git submodule' commands are not

--
https://github.com/git/git/pull/348
