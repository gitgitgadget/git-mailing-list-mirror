Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 9271 invoked by uid 107); 21 Apr 2010 00:43:11 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 20 Apr 2010 20:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab0DUAmq (ORCPT <rfc822;peff@peff.net>);
	Tue, 20 Apr 2010 20:42:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38293 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab0DUAmp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 20:42:45 -0400
Received: by wyb39 with SMTP id 39so3708293wyb.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 17:42:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=+Z2qxzbpFps7lkzn57IKMmuP9nTA64LnEMvNeTthLx8=;
        b=B4Xt7E0Wx0AqQb101BQwZsYRAH86FPlH6lvr6biBoJAoroiwha7LQYQt5KoXlHSvR+
         G1HyjGERH5TTLjN90FItKUzCMbWhgmgaEk+sqGgiqhhPU3WClIHLC0caP2wlW/ws7GIR
         YAiE6Jga2p1uoX5N0mHnq4JPmeaOgnS4usFhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=W0wm0Dh4KvwYM7PVGZtVnMW8xlxfVpOIM6rS7jDJ3iYacCybhmwMv6Rh7Hh1zvTWO9
         RQauDvQdzZlorxRrARb5of2qkbpzrNq0q0alGO2FvVLgJT1cXfcW7LU01GmzJNR3LAwO
         +hMjY2KdDKEVv9bVJIVAqeYe6+IhWeSSJYM8c=
Received: by 10.216.86.3 with SMTP id v3mr5674389wee.190.1271810563815;
        Tue, 20 Apr 2010 17:42:43 -0700 (PDT)
Received: from localhost (drsd-4dbd9a47.pool.mediaWays.net [77.189.154.71])
        by mx.google.com with ESMTPS id z34sm62008634wbv.14.2010.04.20.17.42.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Apr 2010 17:42:43 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Trent Piepho <tpiepho@freescale.com>
Cc:	Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [RFC/PATCH] cvsexportcommit: per branch cvsdir config option
Date:	Wed, 21 Apr 2010 02:42:41 +0200
Message-Id: <1271810562-4196-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.7.1.rc2.600.g673f92
To:	Trent Piepho <tpiepho@freescale.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This lets the user of git cvsexportcommit specify a cvs working dir on a per
branch basis.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

The config variable name is currently cvsexportcommit.<branch>.cvsdir, but
could also be branch.<branch>.cvsdir. Or whatever is prefereable.


 Documentation/git-cvsexportcommit.txt |    7 ++++++-
 git-cvsexportcommit.perl              |    5 +++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index b2696ef..0bc71cf 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -71,7 +71,8 @@ OPTIONS
 	Specify the location of the CVS checkout to use for the export. This
 	option does not require GIT_DIR to be set before execution if the
 	current directory is within a git repository.  The default is the
-	value of 'cvsexportcommit.cvsdir'.
+	value of `cvsexportcommit.<branch>.cvsdir` or, if this is not set,
+	the value of `cvsexportcommit.cvsdir`.
 
 -W::
 	Tell cvsexportcommit that the current working directory is not only
@@ -83,6 +84,10 @@ OPTIONS
 
 CONFIGURATION
 -------------
+cvsexportcommit.<branch>.cvsdir::
+	The default location for branch `<name>` of the CVS checkout to use
+	for the export.
+
 cvsexportcommit.cvsdir::
 	The default location of the CVS checkout to use for the export.
 
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 59b6722..3e0c284 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -18,6 +18,11 @@ die "Need at least one commit identifier!" unless @ARGV;
 
 # Get git-config settings
 my $repo = Git->repository();
+my $branch_name = $repo->command_oneline('rev-parse', '--abbrev-ref=loose', 'HEAD') unless defined $opt_w;
+if ($branch_name) {
+    my $per_branch_cvsdir = "cvsexportcommit.".$branch_name.".cvsdir";
+    $opt_w = $repo->config($per_branch_cvsdir);
+}
 $opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
 
 if ($opt_w || $opt_W) {
-- 
tg: (ddd02b7..) bw/per-branch-cvsdir (depends on: master)
