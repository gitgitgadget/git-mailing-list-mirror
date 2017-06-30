Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ABA3202AE
	for <e@80x24.org>; Fri, 30 Jun 2017 20:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbdF3Ulh (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:41:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34884 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbdF3Ulf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:41:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id z45so40129365wrb.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2TXaW5OPGSEa3Xyz2md7buuIQswOYfp4ik2d/N9un5k=;
        b=aItnFIPS/353FTkkcgmQiiXs3eICqhkhbileH2+TAy/pLW4kF83QpnFXEoxB/OViiP
         qkpdfu5OGSPMxLckvPPK6bvCeEhXSjzJ0Coyx3cQO4J5U8D+2Ji/XvCcWk6k1N3GnVJ1
         WyLsl6TvFbECimb6jdF2is8hrKJGEopQqmRfFzCdYPRxVDGztdby/Xhs+F6sc3CL2eNc
         olvDCJnGs8p0l/PkwpJnMKvx1rW+wkSrrCvwyl1FupPrfFHGEewGOV4NtIhjsFAvzhLx
         f2JjNCn1qvT4AbWkxxgT7MDYzw6VgobFSiiP72V+XCwLO2y/YvFLCQjiYo5JMJxaDnzy
         jgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2TXaW5OPGSEa3Xyz2md7buuIQswOYfp4ik2d/N9un5k=;
        b=ApaEYAtl4AtTcmDlecE0onXA3EtblBHqU2raijaTO7qSTLtLYcYjVC4b/Bh2EIqhy4
         bTJGTgPhQlpQcJM0YKUr01kQl8F7xQQSnOGTZvpuHyFXg3fu1Y5UnTs3OQo30AXSGTtm
         DyW45yEQymEztcLTNHeg/0jCABwAFfTCxye4gZnwSoBDTaiDrkIbuGG5LHs9ZVBoQm+L
         Hrg6vRdHi2eYaokfojXWsh/eSxVvwe5JDYPhq7OLdbsYEk2mSJlNzyUR46H9rFYqcNAM
         tDHsIelOsSVbaWfeyoK+gBAtKPE1UhEyw+Q7ZT+VV2CYDx1LvDe12gJRG1fLd2wUzW10
         WQ5Q==
X-Gm-Message-State: AKS2vOzzYgFC/uFzR84aD6fhPzC0HJnGxzzXt/Z6SQ/nBvJNTkZAMQM9
        2EIL7K6MrbEvPqDs
X-Received: by 10.223.164.80 with SMTP id e16mr27984207wra.24.1498855293991;
        Fri, 30 Jun 2017 13:41:33 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4C89.dip0.t-ipconnect.de. [93.219.76.137])
        by smtp.gmail.com with ESMTPSA id v144sm10648239wmv.27.2017.06.30.13.41.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:41:33 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v9 3/7] t0021: write "OUT <size>" only on success
Date:   Fri, 30 Jun 2017 22:41:24 +0200
Message-Id: <20170630204128.48708-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170630204128.48708-1-larsxschneider@gmail.com>
References: <20170630204128.48708-1-larsxschneider@gmail.com>
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

