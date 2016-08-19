Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8E91F859
	for <e@80x24.org>; Fri, 19 Aug 2016 17:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbcHSRI5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 13:08:57 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36399 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755428AbcHSRIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 13:08:48 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so3684605pab.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fQQvKEJAzEMFIhbKDMoUV5EIXQuYj0ToWRNOF2yXg2c=;
        b=VQUbMHMrT2DNEUqK4q94nCo5y3Baj4sEJNfuJvpeKKdS4e5DGmwvgnMMG7UwVlm4S1
         eoumfsrhh59QA/HA0MusCHLG0Dl3PIRubH79Ertaj/jxtChjAQ7IShGNlOyjFnOl7UTM
         71jRdqp8br7gkUolCxuNzHF5GczpDCrSac9wiF4Jb2k40XpfemMjSNSWk6svXrPVR949
         Afr0hskX7up62vo5/bAjbqvHiewIM1q06UyzdZryQyRzP2dnVB9zfFDkC3avS2bjzoQq
         Dp+6uGIUBUsarqaApH8YWC44QKuBjAaIb+xmac6lh0zKXvH7teGKjEuUDb+LKnQV7gMh
         bRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fQQvKEJAzEMFIhbKDMoUV5EIXQuYj0ToWRNOF2yXg2c=;
        b=HCWX3XJPB1ofdIwANKCFge6qthsGPgTEDgvgRnb1yeZXAVsnJYNCtdaY3ef2wWUivx
         Do/4sW9S9owIiJ/wCXerHCgTOdYjavxUZ7Ilpg0Y6daNuZWRou+kRCxsyrwriIJ5ZIIE
         anhGEP3Z49ckej9aLV1uIsit49KJc3tTSG5WZ5pkyqSIsffzRMRsTbVqXVtQr4yc+gvC
         6tklillP4+hrblBh0olK2latZzF7dTpCqxZX24tKNdvt/xbn9192VHTbqgm2uxtFx2I/
         Vr9OMWoGfwqLRkuBKfKjD5XKXJ+cVJtHUGLdyd/6Rn9jWOdmbfQ6IYiv2swTFxfXgXeD
         kh1w==
X-Gm-Message-State: AEkoouv76KNbZz4TMxmyorMPQ+1xjod47pwFvPBEh6DvS8JUNp2/wGsQlAhEx7nIUmC5Fw==
X-Received: by 10.67.7.170 with SMTP id dd10mr15364776pad.152.1471626506896;
        Fri, 19 Aug 2016 10:08:26 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id m128sm7930676pfm.42.2016.08.19.10.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Aug 2016 10:08:26 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v3 3/3] diff-highlight: add support for --graph output.
Date:   Fri, 19 Aug 2016 10:08:12 -0700
Message-Id: <20160819170812.1676-4-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160819170812.1676-1-henderson.bj@gmail.com>
References: <20160819170812.1676-1-henderson.bj@gmail.com>
In-Reply-To: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
References: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
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
index 3b3c831..b88174e 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -185,7 +185,7 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
 
 # TODO add multi-byte test
 
-test_expect_failure 'diff-highlight works with the --graph option' '
+test_expect_success 'diff-highlight works with the --graph option' '
 	dh_test_setup_history \
 		"aaa\nbbb\nccc\n" \
 		"aaa\n0bb\nccc\n" \
-- 
2.9.0

