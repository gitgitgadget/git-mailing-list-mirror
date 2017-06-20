Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BEC420D12
	for <e@80x24.org>; Tue, 20 Jun 2017 07:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdFTHz4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:55:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33531 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdFTHzy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:55:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id f90so21267193wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eMnPcF5uvMyeSu7W7BsS+MMSna4FSjUV3EHLi0XFBIM=;
        b=kWhPpL/gjQQK4BcCKEoEwvUQxPZ9WHvXC58IBC3PZsAulFbgw84daoIRCKlXQH9h2V
         /OHftQ5hIluRZ86DeSl+HZfwyV6T7iodS5hHnrZic4WjOH7SuQhupvdt3JFd/CIfte4l
         7dvfkPfb3XncsrX5NpMjZ/jxlR7n0vQDPJv+dL+eZbtgI5gvSwrPXNs1eioM8uVP31mV
         sISSqwTOOuin6/EZ1JXT4vtdleTLdGUBRNrABFUV/bkrKWM4ksvO6xpPakUy//SN4Mgk
         StksWKWiBPzGKfazWs0743HrlEGIXJlnrk3yqQRL5u7cdwVjdbWdJNoZgCHSPxObDclo
         wK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eMnPcF5uvMyeSu7W7BsS+MMSna4FSjUV3EHLi0XFBIM=;
        b=nCUj/AGLlWHOG0/Abraroa1TcOoIBeLwSWxO/i/tEP4rulxApkXT9kdldcOLzZtgn+
         CKEWCE7hf0mwjnsDoEMDvu/lUSHQ+Ph0CR3rnrI9HmD5VagPnSC4WeGUbtNudDQeaMur
         3iCSrORjELFoVp9SIahCZrug8OIHDwugEbw6kdwkzOWjsfpvavDh5GJoSw2nLd1z5rnu
         xLtqLgB5vSlkLtZVnqHEPkbMZ+DZz3KMgMU15Pf/MaRqvP6QB0ypv1/067BL28iUGHjj
         xOOLHo4m4fQfPWI45utPLqYaeVoSDm0VIN3Z4UNe2CjTJJrfpzqbgN4xi5Cz65bYh5QK
         GpsQ==
X-Gm-Message-State: AKS2vOwsRPeS7UQCmaAYGuKBaBT5pFE3GvWZQMomBS/B0akM30zrUhct
        MA6i6x77pL2JqLI5
X-Received: by 10.28.169.87 with SMTP id s84mr1765152wme.62.1497945352917;
        Tue, 20 Jun 2017 00:55:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:55:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 03/49] t0021/rot13-filter: improve 'if .. elsif .. else' style
Date:   Tue, 20 Jun 2017 09:54:37 +0200
Message-Id: <20170620075523.26961-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index d6411ca523..1fc581c814 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -40,23 +40,20 @@ sub packet_bin_read {
 	if ( $bytes_read == 0 ) {
 		# EOF - Git stopped talking to us!
 		return ( -1, "" );
-	}
-	elsif ( $bytes_read != 4 ) {
+	} elsif ( $bytes_read != 4 ) {
 		die "invalid packet: '$buffer'";
 	}
 	my $pkt_size = hex($buffer);
 	if ( $pkt_size == 0 ) {
 		return ( 1, "" );
-	}
-	elsif ( $pkt_size > 4 ) {
+	} elsif ( $pkt_size > 4 ) {
 		my $content_size = $pkt_size - 4;
 		$bytes_read = read STDIN, $buffer, $content_size;
 		if ( $bytes_read != $content_size ) {
 			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
 		}
 		return ( 0, $buffer );
-	}
-	else {
+	} else {
 		die "invalid packet size: $pkt_size";
 	}
 }
@@ -144,14 +141,11 @@ while (1) {
 	my $output;
 	if ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
 		$output = "";
-	}
-	elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
+	} elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
 		$output = rot13($input);
-	}
-	elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
+	} elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
 		$output = rot13($input);
-	}
-	else {
+	} else {
 		die "bad command '$command'";
 	}
 
@@ -163,14 +157,12 @@ while (1) {
 		$debug->flush();
 		packet_txt_write("status=error");
 		packet_flush();
-	}
-	elsif ( $pathname eq "abort.r" ) {
+	} elsif ( $pathname eq "abort.r" ) {
 		print $debug "[ABORT]\n";
 		$debug->flush();
 		packet_txt_write("status=abort");
 		packet_flush();
-	}
-	else {
+	} else {
 		packet_txt_write("status=success");
 		packet_flush();
 
@@ -187,8 +179,7 @@ while (1) {
 			print $debug ".";
 			if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
 				$output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
-			}
-			else {
+			} else {
 				$output = "";
 			}
 		}
-- 
2.13.1.565.gbfcd7a9048

