Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB864208BD
	for <e@80x24.org>; Thu,  3 Aug 2017 09:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdHCJTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:19:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36491 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdHCJTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id d40so1421187wma.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FNn0Xx59PLByEtMRC1G6D7k7Y96rwW9Di0kUaZOJ36Y=;
        b=KrGyXlBeGwFVDfPXe4YVgWQNQU0Ez2+wTh3Ae/ED4PK5WmaLowsfHBNnRZv24PhRwP
         oW2MaXK+gc0mvLWm4APbrpK7IJ5UwLnNzG8uewz+7hIeapB9wjrhieXXmvAdr+QFDBK5
         s4EDITek1/wxc7ei8Oaz8yHdMAKQpx27UGbmt3Xm+rioihvuAag0VgldOZ8Uf+m6+UKF
         5+PFOl/LVnM+omOaM0Y6bLnGvxsTLPeIKqQp4mZvKyHD98fp2fIqkaDzAWBexTqVn7Wt
         KZfrMTGV4vTt3r11k7l9R6lr+1CRBTL1UACC3opXQanf7RJw/Uae2CODuY7bR+YqVKR8
         NrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FNn0Xx59PLByEtMRC1G6D7k7Y96rwW9Di0kUaZOJ36Y=;
        b=pF4FTUpakbYDz+37rRW3gQhjPs45NKAAzHyOBTLz1LlXfsbYx7Wh4CL/gm1lZXGded
         4KZSaePMyW5Yx60P1j4+zKY3JriX2HLZ/rsoe5olUXnb1RIo9UxxfbP4GRheKjNSvCfW
         DrphtOU/8sgY2HgAtD6TjqgRCV0qN8ykw7k1ZoRH68T3XeM37yJNJI2TWx16dvzBJGNX
         +tkFXDy4Yo8p+3KnA7A5lyn7vP+496I8AKYX6YCvVaZaX3oR8xD6ra5JZ1865msqakrt
         mPItpXSWZxy9okvlTmDjyJy9t2Z9PjrgH3p8XKIQRkUC6AdEZc4dMfKX7R8qnolhfOOa
         FSCQ==
X-Gm-Message-State: AHYfb5ggpDwq0X7MgpGGUGyaAL28yd1Z7Oo37cs/Dy0Tf0tWv2KgMUOA
        U3SLjpJlAAtL5I3I
X-Received: by 10.28.14.149 with SMTP id 143mr677348wmo.102.1501751982601;
        Thu, 03 Aug 2017 02:19:42 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 04/40] Add Git/Packet.pm from parts of t0021/rot13-filter.pl
Date:   Thu,  3 Aug 2017 11:18:50 +0200
Message-Id: <20170803091926.1755-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
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
2.14.0.rc1.52.gf02fb0ddac.dirty

