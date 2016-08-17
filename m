Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0DB2018E
	for <e@80x24.org>; Wed, 17 Aug 2016 15:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbcHQPcG (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 11:32:06 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35652 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbcHQPcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 11:32:03 -0400
Received: by mail-pa0-f65.google.com with SMTP id cf3so7426980pad.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 08:32:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1ZyChs/HhWnI2jJM3cX35eSz91KPgffHoq+lvMkxros=;
        b=nxY9ZZrxkLg7oYPpnYAMTy2xsltzvS70Gbp45+LZhkOcsYlxEPHtssuyO8Fr1Z2iZE
         zq6ZnpSdlcawHMG5AC2UtaDdwnR+/NFIswcIBGa40CPlccF2eQyMqawqh8cTgKlxCPq+
         ag+wum4D1TzVYSCJPKp2k60+MYgTEGrU+80oe38sm8KgYUDjc58gaNAeWUH6kcSgEYe0
         /av4A0pYZmIhFR6APwVQKV8N+0IPZAXj6KCA+efwarLs+Ecj3vXoJvs3eUKSTwyDad3K
         mMHMlAMIj+L2BEyIqPPbtEBbCskCuaaFFvRU7mfmHLfh1Ea8foZnkwJ4/l2SJFUTdBja
         Atnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1ZyChs/HhWnI2jJM3cX35eSz91KPgffHoq+lvMkxros=;
        b=VRop/VwhJ6wfA2XRZSw8vDM6IkMxm8fgcsztB6eK2jf62cyqxf0SiQxDTSovUKOd6y
         9NxZQpTD/UF0YRgo+2RPWn3upfPWErOdaQGSCo8tK2j41zpbh4+QxAw3fRZ4r7dbBNeO
         IrCM8JhDPrFq7nS+1W0Qgj11X32EbQH/QpS++XcoUTpBsfnhGGu3/j+yoAss5XWDFjys
         NHxpmb/wsTIw92euxhCJjgBoHqtgnkYDiPb0Plqe4ct9Yd9Ablu7Uqz/aBjpmmVooJhb
         iA3rjR26O8YfMXRRrXV52Cb4X3BDS+38wvY7Cn1C5b5hUXkOHz+TeLpgPck0G++6B3O4
         Adow==
X-Gm-Message-State: AEkoouvQ3+xwPZMmqgprDpakMLmN7hvFRJ/d1059lp+BiHcGxTLrSES/5WYx5Oy1PaXeqg==
X-Received: by 10.66.137.107 with SMTP id qh11mr75154278pab.49.1471447922575;
        Wed, 17 Aug 2016 08:32:02 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id fe8sm48311671pad.2.2016.08.17.08.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Aug 2016 08:32:02 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, e@80x24.org,
	Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v2 3/3] diff-highlight: add support for --graph output.
Date:	Wed, 17 Aug 2016 08:31:24 -0700
Message-Id: <20160817153124.7770-4-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160817153124.7770-1-henderson.bj@gmail.com>
References: <20160817153124.7770-1-henderson.bj@gmail.com>
In-Reply-To: <20160810085635.GA1672@starla>
References: <20160810085635.GA1672@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
---
 contrib/diff-highlight/diff-highlight | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..9364423 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -21,6 +21,10 @@ my $RESET = "\x1b[m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
 
+# The patch portion of git log -p --graph should only ever have preceding | and
+# not / or \ as merge history only shows up on the commit line.
+my $GRAPH = qr/$COLOR?\|$COLOR?\s+/;
+
 my @removed;
 my @added;
 my $in_hunk;
@@ -32,12 +36,12 @@ $SIG{PIPE} = 'DEFAULT';
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
@@ -46,7 +50,7 @@ while (<>) {
 		@added = ();
 
 		print;
-		$in_hunk = /^$COLOR*[\@ ]/;
+		$in_hunk = /^$GRAPH*$COLOR*[\@ ]/;
 	}
 
 	# Most of the time there is enough output to keep things streaming,
@@ -211,8 +215,8 @@ sub is_pair_interesting {
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

