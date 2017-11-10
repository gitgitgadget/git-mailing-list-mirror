Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9F71F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbdKJNWW (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:22:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33548 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdKJNWV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:22:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so5868462wmr.0
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=75/ULDbIy8/rgiPf2p2ayHpeYgAStzl9wCVZAapB3dw=;
        b=BDgyFxTPFRqAxE2v3jaSV4CEdMpFbNnbBfXR7SNR95tfmH7UNJfKa8rtC8W8KBhw5d
         tWaHBQE6RGnBMmfvL83uhixXXLPISGuxx+4uoV59FqyEBb6zneV5JJfImzA0EDACkMoJ
         DXosIANvMyA/ZRdkvtYU+rLP+GO2nnkmcJ7/snhSH2VmFlrLor0EeSQXnR3kwrRWKVSY
         dM7dCB5f6KBekVweUZ5v5RYkZY+Xh7MISVZKTT5ytRzGnEqQkbD+yxLjtaYw/gJQpmkH
         Ggz+5F7r2tXMlkAvIgvLc3vPA0JAk7PjQFC92r69lnP5vjDxX+LvP2oMxOjpuTMHbggp
         FQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=75/ULDbIy8/rgiPf2p2ayHpeYgAStzl9wCVZAapB3dw=;
        b=spJWdXRNBKVA+RD5IeGfnJPitOk1vPpv03n3OtWneG7rawFwWAYKjY5aOKgHjkdA6B
         iGjxmPeN7D5pUAw8N9JMMDNr7DdlSvMMdY9p4YqcrS+k4SR40yUlRXV/sYMJvJ2c16On
         nTJicHW693wTp1Ogluj81GMXE/ZDrGKqGfPyLbPIKCwQSjILoRBpnkmOu4Z6rd0vmgrj
         nnfN9s5wm/481HoO9Rmn44Okv58VvM5RoRsuyHaX5Tk9D6QbKzsdDwUZA3RTNdxzv8/d
         W2Pi4SUxNqEO5AX6SbVSebsxQNNHq12DS+qWe7BircJDNJLrF81DoQctQP7GLtBqBjgJ
         qmTA==
X-Gm-Message-State: AJaThX5xDTglnAJ2txfhjTOFLshBXraNiuULS3ZIByArlLkqRL+FwLiJ
        ySazJhkmRkHjiPRwRsLwR9fZoxgK
X-Google-Smtp-Source: AGs4zMZrq255X+YhMUTl/2j0BV6Jncmp4EkzjxAO3vzCAceTf3/SbngQk3EsrCjfIDHWgJS5fkIHYw==
X-Received: by 10.28.131.200 with SMTP id f191mr235185wmd.39.1510320139567;
        Fri, 10 Nov 2017 05:22:19 -0800 (PST)
Received: from christian-Latitude-E6330.register.onboard.eurostar.com ([82.113.183.179])
        by smtp.gmail.com with ESMTPSA id 19sm2232731wmn.15.2017.11.10.05.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 05:22:18 -0800 (PST)
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
Subject: [PATCH v3 0/8] Create Git/Packet.pm
Date:   Fri, 10 Nov 2017 14:21:52 +0100
Message-Id: <20171110132200.7871-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.132.g7ad97d78be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~

Packet related functions in Perl can be useful to write new filters or
to debug or test existing filters. They might also in the future be
used by other software using the same packet line protocol. So instead
of having them in t0021/rot13-filter.pl, let's extract them into a new
Git/Packet.pm module.

Changes since the previous version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are only a few small changes compared to v2:

Patch 2/8 has the following change:

  - packet_required_key_val_read() is renamed packet_key_val_read()
    and a comment is added before the function,

Patch 2/8 and 6/8 have the following change:

  - "if" is used instead of "unless" to make the logic easier to
    understand

The diff with the previous version is:

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index 255b28c098..1682403ffc 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -17,7 +17,7 @@ our @EXPORT = qw(
                        packet_compare_lists
                        packet_bin_read
                        packet_txt_read
-                       packet_required_key_val_read
+                       packet_key_val_read
                        packet_bin_write
                        packet_txt_write
                        packet_flush
@@ -68,28 +68,29 @@ sub packet_bin_read {
 
 sub remove_final_lf_or_die {
        my $buf = shift;
-       unless ( $buf =~ s/\n$// ) {
-               die "A non-binary line MUST be terminated by an LF.\n"
-                   . "Received: '$buf'";
+       if ( $buf =~ s/\n$// ) {
+               return $buf;
        }
-       return $buf;
+       die "A non-binary line MUST be terminated by an LF.\n"
+           . "Received: '$buf'";
 }

 sub packet_txt_read {
        my ( $res, $buf ) = packet_bin_read();
-       unless ( $res == -1 or $buf eq '' ) {
+       if ( $res != -1 and $buf ne '' ) {
                $buf = remove_final_lf_or_die($buf);
        }
        return ( $res, $buf );
 }
 
-sub packet_required_key_val_read {
+# Read a text line and check that it is in the form "key=value"
+sub packet_key_val_read {
        my ( $key ) = @_;
        my ( $res, $buf ) = packet_txt_read();
-       unless ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
-               die "bad $key: '$buf'";
+       if ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
+               return ( $res, $buf );
        }
-       return ( $res, $buf );
+       die "bad $key: '$buf'";
 }
 
 sub packet_bin_write {
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 6fd7fa476b..f1678851de 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -70,7 +70,7 @@ print $debug "init handshake complete\n";
 $debug->flush();
 
 while (1) {
-       my ( $res, $command ) = packet_required_key_val_read("command");
+       my ( $res, $command ) = packet_key_val_read("command");
        if ( $res == -1 ) {
                print $debug "STOP\n";
                exit();
@@ -106,7 +106,7 @@ while (1) {
                packet_txt_write("status=success");
                packet_flush();
        } else {
-               my ( $res, $pathname ) = packet_required_key_val_read("pathname");
+               my ( $res, $pathname ) = packet_key_val_read("pathname");
                if ( $res == -1 ) {
                        die "unexpected EOF while expecting pathname";
                }

Links
~~~~~

This patch series is on the following branch:

https://github.com/chriscool/git/commits/gl-prep-external-odb

Version 1 and 2 of this patch series are on the mailing list here:

https://public-inbox.org/git/20171019123030.17338-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20171105213836.11717-1-chriscool@tuxfamily.org/

They are also available in the following branch:

https://github.com/chriscool/git/commits/gl-prep-external-odb1
https://github.com/chriscool/git/commits/gl-prep-external-odb14

This patch series was extracted from previous "Add initial
experimental external ODB support" patch series.

Version 1, 2, 3, 4, 5 and 6 of this previous series are on the mailing
list here:

https://public-inbox.org/git/20160613085546.11784-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170803091926.1755-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170916080731.13925-1-chriscool@tuxfamily.org/

They are also available in the following branches:

https://github.com/chriscool/git/commits/gl-external-odb12
https://github.com/chriscool/git/commits/gl-external-odb22
https://github.com/chriscool/git/commits/gl-external-odb61
https://github.com/chriscool/git/commits/gl-external-odb239
https://github.com/chriscool/git/commits/gl-external-odb373
https://github.com/chriscool/git/commits/gl-external-odb411


Christian Couder (8):
  t0021/rot13-filter: fix list comparison
  t0021/rot13-filter: refactor packet reading functions
  t0021/rot13-filter: improve 'if .. elsif .. else' style
  t0021/rot13-filter: improve error message
  t0021/rot13-filter: add packet_initialize()
  t0021/rot13-filter: refactor checking final lf
  t0021/rot13-filter: add capability functions
  Add Git/Packet.pm from parts of t0021/rot13-filter.pl

 perl/Git/Packet.pm      | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile           |   1 +
 t/t0021/rot13-filter.pl | 127 ++++++++++--------------------------
 3 files changed, 203 insertions(+), 94 deletions(-)
 create mode 100644 perl/Git/Packet.pm

-- 
2.15.0.132.g7ad97d78be

