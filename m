Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B5520798
	for <e@80x24.org>; Thu, 12 Jan 2017 06:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750769AbdALGAO (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 01:00:14 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35431 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750701AbdALGAL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 01:00:11 -0500
Received: by mail-io0-f194.google.com with SMTP id m98so1419857iod.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 22:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vx28AB18Jgsns/+NZaWR8pt66kvxJp7jg2IYDWq88fQ=;
        b=Tvw+cYARFhV238AdNzgPY/FbSLIQNqxT9QBD4NQAGqspmft62qiQy1u9lxzcm49QZ3
         3UFo+WQPHB8KA193QF4m/dBVQU+yT0ECNWUXAtFFHgv1BkCSYkg8gO2iV7q3U3fpQSVg
         zewfDrd/Wzue9gMSgOykmnDxD+1HEYNJQW5sBAtiN36IdGk942bSfeeV1epCYPHfvF98
         d/BBO441fOI5wv35gWg6QWhNmdh3eh9t6Ukj2S9dNcho29z5G5LkONompKF+t/XadbbS
         SF/8Ne74QizU0nY+Oxpwe31wS5WQYSBJmC1I+Hc2m0SPItDewXzhDBMggAb4hp6gt5EO
         0Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vx28AB18Jgsns/+NZaWR8pt66kvxJp7jg2IYDWq88fQ=;
        b=srWX2atoBU1ft7KuNYaQqoOwq8HzEctry5zwZ9vtn1mXmIq20nV+V2P4OlrKRzFVjq
         KF8gggf4QE4WnOFFIGqIfpdDduYu7shWK84qNU05DOui/sg5nROZ6qKuCr2cjgz6QIOr
         qh8YaDzmjPDiXylnF4MWjsgvMab+eTpqAn61aBdbCMBySTEPEyOjnkg80w3wNv+JqqCf
         9Vy4DZpSDiDN3OVl66xHxk/NDEhQlFFdo8ASdzgYFDR8cPim9CwJ/s8EHp8NWqx7Jx8I
         7Qkbd+1CMqsZOi2CsJlTC9ycD1q1MdrWJXa+0gyj1gyUXaLTYNMyS8aTPvD/p3zVEDSv
         xUwQ==
X-Gm-Message-State: AIkVDXJqbY3trF17h0jqyazpd8pFWV6pFNwL0R0D4MUrw2Oc8+ZThLsRGtZ+vCcYn31OaA==
X-Received: by 10.107.84.2 with SMTP id i2mr13059582iob.176.1484200386236;
        Wed, 11 Jan 2017 21:53:06 -0800 (PST)
Received: from d-212-11-228.eecs.umich.edu ([141.212.11.228])
        by smtp.gmail.com with ESMTPSA id r20sm4350888ioi.10.2017.01.11.21.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 21:53:05 -0800 (PST)
From:   Pat Pannuto <pat.pannuto@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Pat Pannuto <pat.pannuto@gmail.com>
Subject: [PATCH 1/2] Convert all 'perl -w' to 'perl' + 'use warnings;'
Date:   Thu, 12 Jan 2017 00:51:39 -0500
Message-Id: <20170112055140.29877-2-pat.pannuto@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170112055140.29877-1-pat.pannuto@gmail.com>
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit is in preparation for converting all shebangs to use 'env'
instead of a fixed perl path, which will not allow for arguments to 'perl'.

Signed-off-by: Pat Pannuto <pat.pannuto@gmail.com>
---
 Documentation/cat-texi.perl       | 4 +++-
 Documentation/cmd-list.perl       | 4 +++-
 Documentation/fix-texi.perl       | 4 +++-
 compat/vcbuild/scripts/clink.pl   | 3 ++-
 compat/vcbuild/scripts/lib.pl     | 3 ++-
 contrib/buildsystems/engine.pl    | 3 ++-
 contrib/buildsystems/generate     | 3 ++-
 contrib/buildsystems/parse.pl     | 3 ++-
 contrib/examples/git-remote.perl  | 3 ++-
 contrib/mw-to-git/t/test-gitmw.pl | 5 ++++-
 10 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index 87437f8a9..1cd28b1b5 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -1,4 +1,6 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
+
+use warnings;
 
 my @menu = ();
 my $output = $ARGV[0];
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 5aa73cfe4..ba640a441 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -1,4 +1,6 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
+
+use warnings;
 
 use File::Compare qw(compare);
 
diff --git a/Documentation/fix-texi.perl b/Documentation/fix-texi.perl
index ff7d78f62..c247aece7 100755
--- a/Documentation/fix-texi.perl
+++ b/Documentation/fix-texi.perl
@@ -1,4 +1,6 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
+
+use warnings;
 
 while (<>) {
 	if (/^\@setfilename/) {
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index a87d0da51..46eb61c5c 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 ######################################################################
 # Compiles or links files
 #
@@ -10,6 +10,7 @@
 # Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
 ######################################################################
 use strict;
+use warnings;
 my @args = ();
 my @cflags = ();
 my $is_linking = 0;
diff --git a/compat/vcbuild/scripts/lib.pl b/compat/vcbuild/scripts/lib.pl
index d8054e469..e571b8470 100755
--- a/compat/vcbuild/scripts/lib.pl
+++ b/compat/vcbuild/scripts/lib.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 ######################################################################
 # Libifies files on Windows
 #
@@ -10,6 +10,7 @@
 # Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
 ######################################################################
 use strict;
+use warnings;
 my @args = ();
 while (@ARGV) {
 	my $arg = shift @ARGV;
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 23da787dc..a173669ce 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 ######################################################################
 # Do not call this script directly!
 #
@@ -8,6 +8,7 @@
 # Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
 ######################################################################
 use strict;
+use warnings;
 use File::Basename;
 use File::Spec;
 use Cwd;
diff --git a/contrib/buildsystems/generate b/contrib/buildsystems/generate
index bc10f25ff..9af89454a 100755
--- a/contrib/buildsystems/generate
+++ b/contrib/buildsystems/generate
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 ######################################################################
 # Generate buildsystem files
 #
@@ -19,6 +19,7 @@
 # Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
 ######################################################################
 use strict;
+use warnings;
 use File::Basename;
 use Cwd;
 
diff --git a/contrib/buildsystems/parse.pl b/contrib/buildsystems/parse.pl
index c9656ece9..33ca89eb0 100755
--- a/contrib/buildsystems/parse.pl
+++ b/contrib/buildsystems/parse.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 ######################################################################
 # Do not call this script directly!
 #
@@ -8,6 +8,7 @@
 # Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
 ######################################################################
 use strict;
+use warnings;
 use File::Basename;
 use Cwd;
 
diff --git a/contrib/examples/git-remote.perl b/contrib/examples/git-remote.perl
index d42df7b41..5bf3ffd4c 100755
--- a/contrib/examples/git-remote.perl
+++ b/contrib/examples/git-remote.perl
@@ -1,6 +1,7 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 
 use strict;
+use warnings;
 use Git;
 my $git = Git->repository();
 
diff --git a/contrib/mw-to-git/t/test-gitmw.pl b/contrib/mw-to-git/t/test-gitmw.pl
index 0ff76259f..8d0e7c078 100755
--- a/contrib/mw-to-git/t/test-gitmw.pl
+++ b/contrib/mw-to-git/t/test-gitmw.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w -s
+#!/usr/bin/perl
 # Copyright (C) 2012
 #     Charles Roussel <charles.roussel@ensimag.imag.fr>
 #     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
@@ -22,6 +22,9 @@
 #     "edit_page"
 #     "getallpagename"
 
+use strict;
+use warnings;
+
 use MediaWiki::API;
 use Getopt::Long;
 use encoding 'utf8';
-- 
2.11.0

