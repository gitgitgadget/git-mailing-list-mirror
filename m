Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70FBB20285
	for <e@80x24.org>; Wed, 28 Jun 2017 21:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbdF1VaG (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:30:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34386 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdF1VaA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:30:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id k67so35232461wrc.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2TXaW5OPGSEa3Xyz2md7buuIQswOYfp4ik2d/N9un5k=;
        b=vSMa4M8pETn77BahYoVc1aeoPIKqCMeZzW3Deostch23UqLT7PMEogd9VvXdQ0DjHI
         KqZZ8K5jjusOQtZY1fNu9SAuVEMKj6bXiWV0qrVyV0cpfIxbcLJU1c2Czes8q4/wGsCT
         lG0ISB0cRr1deOdy+7bMIlvui/VKYCnqGgichamYDFDWElbxBd3qle77HX+itkBuyhXl
         qFvqGX785nsFgF6UmOqRICDTp/Y0B2OvP56DEl90BG5seKTqk9sZBK3ed57+bwXUNKoG
         ZM9rtO6GmFgtQjrR1/UXo4omE8C+zhM3dK9Y/fkA3PDOgLAZVIDnat7QcA5R2nmygUiM
         x+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2TXaW5OPGSEa3Xyz2md7buuIQswOYfp4ik2d/N9un5k=;
        b=pW7wMQUm+V3NGN4Rsc1Ff0CpA0/uIi2bewhVdcHJiYPwR/H43pMfmrp9L7RkCqCyeZ
         I849plTwbPhKJvIzWanWWvB7J5E9J4Cn+DDDyrzALBZNzk3rnaBD4NQJM+pE5btVrDSb
         mbQaUBTb0p8TjcpYljHfRzENCVDbB6/sCu8AIF8dxhHCsDlfkLyrDA1yTSolt5f9QAp3
         So9tL/X6Xk+ZzExSy3L2ZR+4cEQhzGbeauGDjrJVD+DwOq+KjyH+ttwzZ94Yb4t+Fe0q
         3o8yo+63zBLEKXDExLh1D+AVyoM0TE3iE3mlARpk/7nIt92zoNaKx/S2Fprks+8bg0i1
         6xrQ==
X-Gm-Message-State: AKS2vOyBWetld/vulqnvKISQa1zSgRDO/EI+V8fRKSbCz8B89TZrAhOB
        phRCpxFB213NC9Qz
X-Received: by 10.223.160.111 with SMTP id l44mr21452144wrl.31.1498685398921;
        Wed, 28 Jun 2017 14:29:58 -0700 (PDT)
Received: from ccsh0hfn32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l20sm2581036wre.25.2017.06.28.14.29.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 14:29:58 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v8 3/6] t0021: write "OUT <size>" only on success
Date:   Wed, 28 Jun 2017 23:29:49 +0200
Message-Id: <20170628212952.60781-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170628212952.60781-1-larsxschneider@gmail.com>
References: <20170628212952.60781-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"rot13-filter.pl" always writes "OUT <size>" to the debug log at the end
of a response.

This works perfectly for the existing responses "abort", "error", and
"success". A new response "delayed", that will be introduced in a
subsequent patch, accepts the input without giving the filtered result
right away. At this point we cannot know the size of the response.
Therefore, we do not write "OUT <size>" for "delayed" responses.

To simplify the code we do not write "OUT <size>" for "abort" and
"error" responses either as their size is always zero.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh   | 6 +++---
 t/t0021/rot13-filter.pl | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 0139b460e7..0c04d346a1 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -588,7 +588,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge smudge-write-fail.r $SF [OK] -- OUT: $SF [WRITE FAIL]
+			IN: smudge smudge-write-fail.r $SF [OK] -- [WRITE FAIL]
 			START
 			init handshake complete
 			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
@@ -634,7 +634,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge error.r $SE [OK] -- OUT: 0 [ERROR]
+			IN: smudge error.r $SE [OK] -- [ERROR]
 			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
 			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			STOP
@@ -673,7 +673,7 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
+			IN: smudge abort.r $SA [OK] -- [ABORT]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 0b943bb377..5e43faeec1 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -153,9 +153,6 @@ while (1) {
 		die "bad command '$command'";
 	}
 
-	print $debug "OUT: " . length($output) . " ";
-	$debug->flush();
-
 	if ( $pathname eq "error.r" ) {
 		print $debug "[ERROR]\n";
 		$debug->flush();
@@ -178,6 +175,9 @@ while (1) {
 			die "${command} write error";
 		}
 
+		print $debug "OUT: " . length($output) . " ";
+		$debug->flush();
+
 		while ( length($output) > 0 ) {
 			my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
 			packet_bin_write($packet);
-- 
2.13.2

