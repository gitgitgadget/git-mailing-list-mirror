Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E425F2018E
	for <e@80x24.org>; Mon, 29 Aug 2016 17:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752993AbcH2ReK (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:34:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35326 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753023AbcH2ReG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:34:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id h186so9635817pfg.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=efdJUCHzMUnC7KzqWWLGy3lVkK8uJiUVpDudV/c5+zE=;
        b=kXKL9qQ3pJVg7PYRSPU2Ip40adWZzXaV/UROEEPI+8SE0M17zSwQ8NwLjaQHgSQPhL
         saqNiCJ/9GiYdBJCCJX5Zi64YEMrn/Lj519OlkBfMidRrkXwG3rw7MP6UsqcVeg9iqOg
         Zjua+atGXU8mPi7li701A8fbHftlRPsqlUcrFFeNNwWVOd4VOoCcv377ijSHnRc1jHgk
         WUuXdpdbhesuX/oDeRrUtKukdT/y8T3zs1J/SWlFWi4H0Tds/j4RmCQCLIibv/zJnrsT
         GUqiatXizF4ioMb+k/NUW9MGlwnVtpSoejqRhh5Hqfzo2rDJ7/pYxexfVQ/fet3FRyC5
         qzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=efdJUCHzMUnC7KzqWWLGy3lVkK8uJiUVpDudV/c5+zE=;
        b=KTs9NbomSp1Ij/rbGtCUX5yM2aHXFHBtDznCR6+bMKwp+1clDayDCyps8fFr38rzPO
         6gAHtGjlfGIhH5Xg4ZLOUWb0q1QLBTM87QgxrgIQhouJmB45jPgxWjIVSCuT15MGguat
         JpKYGjlSDS+pVdUX5TTKIBFe/gNwHyb6zRUZRjR4tTd6GesNIyZgs54pGY6QsPPce4JP
         HH5AvLt/hShuz6gfFHhvqR0prlOm37eV3tEPJRCt8hw1Jmem0xoBi7U0BOkAcSWSwlXC
         /LyXph/i/+gtuXOQCFQ0RzaB0gJJpSdqnL5vfZNxyRjZTdlobhW2GCAPd2VqZmuIlHNk
         PNsw==
X-Gm-Message-State: AE9vXwPOnMhWPf1TxIXoKi3JyxTWHUPQNzQJNTpiAWrYXLPiKAZmTB2yc2hvgvif70ly3A==
X-Received: by 10.98.8.142 with SMTP id 14mr34600644pfi.57.1472492045759;
        Mon, 29 Aug 2016 10:34:05 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id h125sm50721234pfg.54.2016.08.29.10.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 10:34:05 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v4 3/3] diff-highlight: add support for --graph output.
Date:   Mon, 29 Aug 2016 10:33:47 -0700
Message-Id: <20160829173347.454-4-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160829173347.454-1-henderson.bj@gmail.com>
References: <20160823041252.53ldwacgdey2euxt@sigill.intra.peff.net>
 <20160829173347.454-1-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 contrib/diff-highlight/diff-highlight            | 19 +++++++++++++------
 contrib/diff-highlight/t/t9400-diff-highlight.sh |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..9280c88 100755
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
@@ -163,6 +167,9 @@ sub highlight_pair {
 	}
 }
 
+# we split either by $COLOR or by character. This has the side effect of
+# leaving in graph cruft. It works because the graph cruft does not contain "-"
+# or "+"
 sub split_line {
 	local $_ = shift;
 	return utf8::decode($_) ?
@@ -211,8 +218,8 @@ sub is_pair_interesting {
 	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
 	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
 
-	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
-	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
+	return $prefix_a !~ /^$GRAPH*$COLOR*-$BORING*$/ ||
+	       $prefix_b !~ /^$GRAPH*$COLOR*\+$BORING*$/ ||
 	       $suffix_a !~ /^$BORING*$/ ||
 	       $suffix_b !~ /^$BORING*$/;
 }
diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 54e11fe..e42232d 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -209,7 +209,7 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
 
 # TODO add multi-byte test
 
-test_expect_failure 'diff-highlight works with the --graph option' '
+test_expect_success 'diff-highlight works with the --graph option' '
 	dh_test_setup_history &&
 
 	# topo-order so that the order of the commits is the same as with --graph
-- 
2.9.3

