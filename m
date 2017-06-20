Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7FC20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdFTH6W (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:58:22 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32860 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdFTHzz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:55:55 -0400
Received: by mail-wr0-f194.google.com with SMTP id x23so16334421wrb.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fMj2ujz88n3MuHlaDOPG4jx8+PC6w+Sy0Z/zBGyX+U8=;
        b=fZAZ2Wj6V4DFTPDgkkUsIpROXNun9zaSvyIpexWIecDqp8iOyUUzgO5bFkvOeukYrO
         09U+7pmb1wK1tzlaXo69Rpg6djwNrSXIhHD/dVVUkeHku6jpzAe2vQuWMCiP+j/NUH+b
         gIcRVyUzdZwUV01gS0b51yZKgUQqNmNfQ//1aFjc/DqH29vfbkw8OAyE1UJzH5QNcGRX
         AyrX7Dfeq3XhRp5fLRXR/izzDh30f+Z6oyXHYkqUwsrFWDdLOcaWDSlqKduk/PVrqJ6H
         H6TPdZVWDGc3XmksHpspihQb8QY45RA2qG3SvuEAasNIN53Oaeaf6pC6ak5Bi2hEij61
         k8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fMj2ujz88n3MuHlaDOPG4jx8+PC6w+Sy0Z/zBGyX+U8=;
        b=NXRVy5j+KSTprGnKzdY9dY0gkp8IMelR6WYDVY81wOe2dY7VaPoUXq9EQ68iKRnJ4V
         /p/omDJohGHh5gdW6XdCbLzeiK6Mtq81hdzrQiEn3MfwV7+rHJxq8AjT073mVdJO2ro9
         54U3q29c7RfhLWxnntzAb4l6SAjW4BlET1mMxdIL9TB+5802QAkG+FNEnAEDTCJQVX8d
         7yMDSHDvA1Yy98uDIXB5l/4t9yWAwmYr/VCLkmao/JrJbx3fggFmKWG3HnXjndJ025Bw
         +hvItevPJYPCXryuxO9SFVZPu3HbCkPOTGXKnwDDor5W9ab8JrM3uo4CCCJDEDg1619d
         13Mw==
X-Gm-Message-State: AKS2vOxE2Aub4R06WksozuszOC3ZxWYt9Ip+D46HKiSbm/4iijA11lDX
        1Y5XrUXxye+sb8w0
X-Received: by 10.223.148.226 with SMTP id 89mr6449275wrr.169.1497945354080;
        Tue, 20 Jun 2017 00:55:54 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:55:53 -0700 (PDT)
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
Subject: [RFC/PATCH v4 04/49] Add Git/Packet.pm from parts of t0021/rot13-filter.pl
Date:   Tue, 20 Jun 2017 09:54:38 +0200
Message-Id: <20170620075523.26961-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will make it possible to reuse packet reading and writing
functions in other test scripts.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 perl/Git/Packet.pm | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 perl/Git/Packet.pm

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
new file mode 100644
index 0000000000..aaffecbe2a
--- /dev/null
+++ b/perl/Git/Packet.pm
@@ -0,0 +1,71 @@
+package Git::Packet;
+use 5.008;
+use strict;
+use warnings;
+BEGIN {
+	require Exporter;
+	if ($] < 5.008003) {
+		*import = \&Exporter::import;
+	} else {
+		# Exporter 5.57 which supports this invocation was
+		# released with perl 5.8.3
+		Exporter->import('import');
+	}
+}
+
+our @EXPORT = qw(
+			packet_bin_read
+			packet_txt_read
+			packet_bin_write
+			packet_txt_write
+			packet_flush
+		);
+our @EXPORT_OK = @EXPORT;
+
+sub packet_bin_read {
+	my $buffer;
+	my $bytes_read = read STDIN, $buffer, 4;
+	if ( $bytes_read == 0 ) {
+		# EOF - Git stopped talking to us!
+		return ( -1, "" );
+	} elsif ( $bytes_read != 4 ) {
+		die "invalid packet: '$buffer'";
+	}
+	my $pkt_size = hex($buffer);
+	if ( $pkt_size == 0 ) {
+		return ( 1, "" );
+	} elsif ( $pkt_size > 4 ) {
+		my $content_size = $pkt_size - 4;
+		$bytes_read = read STDIN, $buffer, $content_size;
+		if ( $bytes_read != $content_size ) {
+			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
+		}
+		return ( 0, $buffer );
+	} else {
+		die "invalid packet size: $pkt_size";
+	}
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $res == -1 || $buf =~ s/\n$// ) {
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
-- 
2.13.1.565.gbfcd7a9048

