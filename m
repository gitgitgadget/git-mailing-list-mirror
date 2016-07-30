Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F951F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 15:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbcG3PM2 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 11:12:28 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36677 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbcG3PMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 11:12:20 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so6850756pab.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 08:12:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2aYEhMtczJdhR4eQDUe5Lc741wD8SpW6m1thQTO9SPo=;
        b=C9Slvr+BC31PkNJEeTfSFCmfV14QI4jGPl0qhEYkry9DxnvP7YZ799KKq5LijsgaV7
         FDQ741iO4nPM32VVum6V61pFO/d6bvcKSd+C1F+DXTBq+4sr5aFieSbiWdcH2EtM8uJW
         F7sAbeIj00tA4EwEExHKWugzZppUd01xEnkFhntn/ljt31bIdd3a74RZytmOtHxxyEzL
         lpB4ekGbquETlR2nB/igJPsjMJAhczxzXXZ0hwJJg2WxDA92I5WxV7uvj3Ux5twpalyw
         EwGulKQRbMyivlGSYLWIS8z4c9cwmY+TIQKfzIo4577VPL6iJaPFF9TpqRmxnffs0yAZ
         38Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2aYEhMtczJdhR4eQDUe5Lc741wD8SpW6m1thQTO9SPo=;
        b=FkfOHW2HufvBUM7AANRuFF1kBGxH087bU4U9bZdQ5XCW+2hwzt9bTzwEP0zerfVYEl
         txdMF5A/Y5k3m18a8Rrpo9XFqBvH8G1o1VLsUpVMVXQJKZfErR7Gii+4dGnXoTlg8isO
         fMdnlZ2FXgz460ku484Lkdpw73euAYyyQ3D26+twqInXay6VaQV0IwVda+txHuEAgrXi
         Na8XnpC8+hgVewhyxohZOWupXB7F7HNJbYmBeOipsbXNuZCoCZ28zHfNmFjQPI3y4Scm
         X3Xjx6j2N+aQe8TCv1Jc4472b5Bn8MeXT7A4U3kNkL/TAYly2SSbirwFaL7YOmsgq48K
         hZwg==
X-Gm-Message-State: AEkoousaezZfd2AwNg7n4XnZlHaAv1L/kEHZ8sIkvnT7+nGx8uZTwMOXDwYT+L7d8m31kQ==
X-Received: by 10.66.162.4 with SMTP id xw4mr78394442pab.97.1469891539860;
        Sat, 30 Jul 2016 08:12:19 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id x184sm33113398pfd.70.2016.07.30.08.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 08:12:19 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH 3/3] diff-highlight: add support for --graph output.
Date:	Sat, 30 Jul 2016 08:11:49 -0700
Message-Id: <20160730151149.15980-4-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160730151149.15980-1-henderson.bj@gmail.com>
References: <20160730151149.15980-1-henderson.bj@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

---
 contrib/diff-highlight/diff-highlight | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..ec31356 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -20,6 +20,7 @@ my @NEW_HIGHLIGHT = (
 my $RESET = "\x1b[m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
+my $GRAPH = qr/$COLOR?\|$COLOR?\s+/;
 
 my @removed;
 my @added;
@@ -32,12 +33,12 @@ $SIG{PIPE} = 'DEFAULT';
 while (<>) {
 	if (!$in_hunk) {
 		print;
-		$in_hunk = /^$COLOR*\@/;
+		$in_hunk = /^$GRAPH*$COLOR*\@/;
 	}
-	elsif (/^$COLOR*-/) {
+	elsif (/^$GRAPH*$COLOR*-/) {
 		push @removed, $_;
 	}
-	elsif (/^$COLOR*\+/) {
+	elsif (/^$GRAPH*$COLOR*\+/) {
 		push @added, $_;
 	}
 	else {
@@ -46,7 +47,7 @@ while (<>) {
 		@added = ();
 
 		print;
-		$in_hunk = /^$COLOR*[\@ ]/;
+		$in_hunk = /^$GRAPH*$COLOR*[\@ ]/;
 	}
 
 	# Most of the time there is enough output to keep things streaming,
@@ -211,8 +212,8 @@ sub is_pair_interesting {
 	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
 	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
 
-	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
-	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
+	return $prefix_a !~ /^$GRAPH*$COLOR*-$BORING*$/ ||
+	       $prefix_b !~ /^$GRAPH*$COLOR*\+$BORING*$/ ||
 	       $suffix_a !~ /^$BORING*$/ ||
 	       $suffix_b !~ /^$BORING*$/;
 }
-- 
2.9.0

