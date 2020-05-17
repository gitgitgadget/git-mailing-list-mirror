Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285ABC433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F2320671
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgEQCYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 22:24:20 -0400
Received: from smtp-1.his.com ([216.194.195.13]:45455 "EHLO smtp-1.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgEQCYS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 May 2020 22:24:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.his.com (Postfix) with ESMTP id 6A34F609EC
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:17:03 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at smtp-1.his.com
Received: from smtp-1.his.com ([127.0.0.1])
        by localhost (smtp-1.his.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SYU4NW96lccT for <git@vger.kernel.org>;
        Sat, 16 May 2020 22:17:03 -0400 (EDT)
Received: from smtp-nf-201.his.com (smtp-nf-201.his.com [216.194.196.93])
        by smtp-1.his.com (Postfix) with ESMTP id 08482609E7
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:17:03 -0400 (EDT)
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 6DD3D6042B
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:17:02 -0400 (EDT)
X-ASG-Debug-ID: 1589681822-061c41045c25bca0001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id YrCOOGD0SmPXkT86 for <git@vger.kernel.org>; Sat, 16 May 2020 22:17:02 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id E71A060229
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:17:01 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id ACFAC177E99;
        Sat, 16 May 2020 22:17:01 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZbC7gpYjmNZP; Sat, 16 May 2020 22:17:01 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 96D9A177EA3;
        Sat, 16 May 2020 22:17:01 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bXDVmT-lPScH; Sat, 16 May 2020 22:17:01 -0400 (EDT)
Received: from kenilap.lorber.home (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 796B9177E99;
        Sat, 16 May 2020 22:17:01 -0400 (EDT)
Received: (from keni@localhost)
        by kenilap.lorber.home (8.14.5/8.14.1) id 04H2H0P1037024;
        Sat, 16 May 2020 22:17:00 -0400 (EDT)
From:   Kenneth Lorber <keni@hers.com>
To:     git@vger.kernel.org
Cc:     keni@hers.com
Subject: [RFC PATCH 3/6] Add namespace collision avoidance guidelines file
Date:   Sat, 16 May 2020 22:13:41 -0400
X-ASG-Orig-Subj: [RFC PATCH 3/6] Add namespace collision avoidance guidelines file
Message-Id: <1589681624-36969-4-git-send-email-keni@hers.com>
X-Mailer: git-send-email 2.7.1.287.g4943984.dirty
In-Reply-To: <1589681624-36969-1-git-send-email-keni@hers.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589681822
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 4394
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81903
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kenneth Lorber <keni@his.com>

Add a file of guidelines to prevent the namespace collisions
mentioned in git help config without any guidance.

Signed-off-by: Kenneth Lorber <keni@his.com>
---
 Documentation/gitrepository-layout.txt        |  1 +
 .../technical/namespace-collisions.txt        | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/technical/namespace-collisions.txt

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 1a2ef4c150..a84a4df513 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -290,6 +290,7 @@ worktrees/<id>/locked::
 worktrees/<id>/config.worktree::
 	Working directory specific configuration file.
 
+include::technical/namespace-collisions.txt[]
 include::technical/repository-version.txt[]
 
 SEE ALSO
diff --git a/Documentation/technical/namespace-collisions.txt b/Documentation/technical/namespace-collisions.txt
new file mode 100644
index 0000000000..fb79c82a73
--- /dev/null
+++ b/Documentation/technical/namespace-collisions.txt
@@ -0,0 +1,86 @@
+gitattributes
+
+
+NAMESPACE COLLISIONS
+--------------------
+Git uses identifiers in a number of different namespaces:
+
+* environment variables
+* files in $GIT_DIR
+* files in the working trees
+* config sections
+* hooks
+* attributes
+
+In order to reduce the chance of collisions between names Git uses
+and those used by other entities (users, groups, and extension authors),
+the following are recommended best practices.
+
+Names reserved to Git:
+
+* file or directory names ending with `.lock`
+* file or directory names starting with `.git`
+* filenames in $GIT_DIR
+* directory names in $GIT_DIR unless allowed by a rule below
+* environment variables starting with `GIT_`
+* configuration file sections unless allowed by a rule below
+* file or directory names in `$GIT_DIR/hooks` unless allowed by a rule below
+* attributes unless allowed by a rule below
+
+
+Names reserved for individual users:
+
+* The directory `$GIT_DIR/my`
+* Environment variables starting with `GIT_MY_`
+* Configuration section `my`
+* Files or directories in `$GIT_DIR/hooks` starting with `my_`
+* Attributes starting with `my_`
+
+Names reserved for individual repos:
+
+* The directory `$GIT_DIR/this`
+* Environment variables starting with `GIT_THIS_`
+* Configuration section `this`
+* Files or directories in `$GIT_DIR/hooks` starting with `this_`
+* Attributes starting with `this_`
+
+Names reserved for the lowest level group of people:
+
+* The directory `$GIT_DIR/our`
+* Environment variables starting with `GIT_OUR_`
+* Configuration section `our`
+* Files or directories in `$GIT_DIR/hooks` starting with `our_`
+* Attributes starting with `our_`
+
+Names reserved for larger groups of people, for companies,
+or for extensions that are distributed outside of the originating group:
+
+$ID is defined as a reverse DNS-style name, with dots replaced by
+underscores (preferably) or by hyphens (if necessary).  The $ID
+can have as many sections as possible, thus `com.example.sitename.projectid`
+is perfectly reasonable.  Use of a name based on a domain you control is
+highly recommended; if you do not control a domain, constructing the base of $ID
+from your email address is a reasonable alternative, but use double delimiters
+in place of the @ sign; for example: `com.example--root.project`
+
+* The directory $GIT_DIR/$ID
+* Environment variables starting with `GIT__$ID_` (note two underscores)
+* Configuration section `GIT--$ID`
+* Files or directories in `$GIT_DIR/hooks` starting with $ID
+* Attributes starting with `git__` (note two underscores)
+
+Aliases
+~~~~~~~
+Aliases are a special case.  Users need to type them so they should be
+short, but there is no way to prevent such short names from colliding.
+So the documentation or installer should construct something like:
+
+  [alias]
+     test = !git my-test
+     my-test = !echo made it
+
+while detecting collisions for the short name.  Then users or local
+policy can deal with collisions on the short name.
+
+This is not meant to cover every possible use case - a policy that
+detailed would be ignored and thus of no use.  Please play nicely.
-- 
2.17.1

