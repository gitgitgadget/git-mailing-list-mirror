Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E1D20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbdFTH5j (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35186 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbdFTH41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id z45so16317907wrb.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ztElU55KVwjo3OFXcA0qrMpiFgRFT7oa0TKxJGjVNFg=;
        b=kizHQnt6+gzH7K6qAYSb3mpMwazhjfwP+AdY6daYF8pfd/IbbloOsNa6XoXxwt7SWW
         /wf1p14npXGpCUlNpEhy7Q7JzUTC/jDNVL+8lOhNNWZuzJBhXrl7C6kl/iGnaVoypB70
         AAR86qnwf4/pHEcMFrq4oGCMYAiTtf7recW/rqP1Ay7rgg7kx+YQfZNExdSY48goov3M
         iWACWbJR3cFDISQEsHM9/W6pgSL1CVoYuDcNvGZQFwjX1C/v1zwbHDxSwJU0oCs+5Wn1
         Jk2dxMmYOkpEm1dtN9uQ0cjY99Xy6ijcZ28+D7Rbu7DE3IZOs3a4mQ4WbcFwT5KEnHkn
         a3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ztElU55KVwjo3OFXcA0qrMpiFgRFT7oa0TKxJGjVNFg=;
        b=oP+bp6Zzy2srACqAVmMlIm/Cpam2TySR35px572oIeCsIrR4aULuoo7D3rGz3SId/o
         10NaUZIi8QUoCQ+Hahw1Svq1MJI/niLbgXSXavm+glN3b8Kx+xdGjBZOhXXVRW/hg238
         wQGAvqAyLezLUg4u/tEVU9gNAk9ZF85paQ8UfksQzds8jLEqIGz3DYGhbmEDeRfcTyAx
         WuAed2wRMlnpzV88cgXwXGdEjiYQ7jReHwkNtE3Y+wqpn0644evHogiaAj9LdV0/12S9
         evwqjP+n8hyroKuOlMqAPY0X/h5hepznohJu5XSoCSy0GF3kICGayCLyn/fUeLRyJNFo
         SKvw==
X-Gm-Message-State: AKS2vOzggh4aBxYydJG7UxmkIADjPMOIacNg3ZrBX4lctcPOS0BYmJcp
        Sz4r21x4/62trEJx
X-Received: by 10.223.135.29 with SMTP id a29mr8920864wra.138.1497945385858;
        Tue, 20 Jun 2017 00:56:25 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: [RFC/PATCH v4 28/49] contrib: add long-running-read-object/example.pl
Date:   Tue, 20 Jun 2017 09:55:02 +0200
Message-Id: <20170620075523.26961-29-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 contrib/long-running-read-object/example.pl | 114 ++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 contrib/long-running-read-object/example.pl

diff --git a/contrib/long-running-read-object/example.pl b/contrib/long-running-read-object/example.pl
new file mode 100644
index 0000000000..6587333b87
--- /dev/null
+++ b/contrib/long-running-read-object/example.pl
@@ -0,0 +1,114 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git read-object protocol version 1
+# See Documentation/technical/read-object-protocol.txt
+#
+# Allows you to test the ability for blobs to be pulled from a host git repo
+# "on demand."  Called when git needs a blob it couldn't find locally due to
+# a lazy clone that only cloned the commits and trees.
+#
+# A lazy clone can be simulated via the following commands from the host repo
+# you wish to create a lazy clone of:
+#
+# cd /host_repo
+# git rev-parse HEAD
+# git init /guest_repo
+# git cat-file --batch-check --batch-all-objects | grep -v 'blob' |
+#	cut -d' ' -f1 | git pack-objects /e/guest_repo/.git/objects/pack/noblobs
+# cd /guest_repo
+# git config core.virtualizeobjects true
+# git reset --hard <sha from rev-parse call above>
+#
+# Please note, this sample is a minimal skeleton. No proper error handling
+# was implemented.
+#
+
+use strict;
+use warnings;
+
+#
+# Point $DIR to the folder where your host git repo is located so we can pull
+# missing objects from it
+#
+my $DIR = "/host_repo/.git/";
+
+sub packet_bin_read {
+	my $buffer;
+	my $bytes_read = read STDIN, $buffer, 4;
+	if ( $bytes_read == 0 ) {
+
+		# EOF - Git stopped talking to us!
+		exit();
+	}
+	elsif ( $bytes_read != 4 ) {
+		die "invalid packet: '$buffer'";
+	}
+	my $pkt_size = hex($buffer);
+	if ( $pkt_size == 0 ) {
+		return ( 1, "" );
+	}
+	elsif ( $pkt_size > 4 ) {
+		my $content_size = $pkt_size - 4;
+		$bytes_read = read STDIN, $buffer, $content_size;
+		if ( $bytes_read != $content_size ) {
+			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
+		}
+		return ( 0, $buffer );
+	}
+	else {
+		die "invalid packet size: $pkt_size";
+	}
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $buf =~ s/\n$// ) {
+		die "A non-binary line MUST be terminated by an LF.";
+	}
+	return ( $res, $buf );
+}
+
+sub packet_bin_write {
+	my $buf = shift;
+	print STDOUT sprintf( "%04x", length($buf) + 4 );
+	print STDOUT $buf;
+	STDOUT->flush();
+}
+
+sub packet_txt_write {
+	packet_bin_write( $_[0] . "\n" );
+}
+
+sub packet_flush {
+	print STDOUT sprintf( "%04x", 0 );
+	STDOUT->flush();
+}
+
+( packet_txt_read() eq ( 0, "git-read-object-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=1" ) )				 || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                       || die "bad version end";
+
+packet_txt_write("git-read-object-server");
+packet_txt_write("version=1");
+packet_flush();
+
+( packet_txt_read() eq ( 0, "capability=get" ) )    || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+
+packet_txt_write("capability=get");
+packet_flush();
+
+while (1) {
+	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+
+	if ( $command eq "get" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		system ('git --git-dir="' . $DIR . '" cat-file blob ' . $sha1 . ' | git -c core.virtualizeobjects=false hash-object -w --stdin >/dev/null 2>&1');
+		packet_txt_write(($?) ? "status=error" : "status=success");
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.13.1.565.gbfcd7a9048

