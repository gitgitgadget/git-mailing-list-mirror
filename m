Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13941F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 04:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeK0Ptm (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 10:49:42 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:38889 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeK0Ptm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 10:49:42 -0500
Received: by mail-yb1-f202.google.com with SMTP id n195-v6so12642891yba.5
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 20:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2zp2+sl8A0+Md8VD8sNusoOraFNv3JD8JV+ltDEpVXg=;
        b=Oijo0w3MBRRccL33VsvxDwpz6RwNDCM47Q3b6I969sNUmmVRN6JjKN9qKdueXJOyBM
         14x3bHnaGK7qoRO/lpL+R5BNah/OXwxJO9FTtRqoDE4+1qoUH1vNqD/OCc/5hGaRbmjm
         NNTp4Kku0Q1hWQeSI0MiIE/Op3mfnTZAmV5DpXQmm8HVxLtmsgNzL3qXJMtGOhoSg2e7
         1MEyO/rxrE9GOzaJffW1Ep10b7NkmqSBq80S0CCcVbS6fT4s9vKftp68cbo3XI2WjHv6
         jfIbKKjRyaQ2xD6KZEB9DaYr04iuT0eCCqr727vovdai52F+MN8ANrfohjP/dFxexxvd
         oc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2zp2+sl8A0+Md8VD8sNusoOraFNv3JD8JV+ltDEpVXg=;
        b=mIcs8FqjS9pq2H7YelmUKuKbAuSs1s28/NcSV7zuh/AnTS5NG/4dcmW1ycf10eZn8B
         xQrUfdoLoNMuQwEzwCfYbmqE5zmWhttpCj89kpdUfAl+7bYxysq7KlHDF64Qrc13gXp7
         li/Bqegf+ZErE2pYMXv+TC9lqakiF2V9OQxHUSY1/GWiGqXlRFwVwE66j4+fTPUvbXsA
         2Jj8MAhvOUWWkXsp+iH22CaesAXbC0fAmJj6h4U7MwlWLPUj9NgUAYUtZ6rDN7eaoNrI
         V4XqPjDENKP5Qbo27EhRQaHV+x5XuyP4o1Xr3SDgu+rABjtEb/GYZVuZ837pWlzzt414
         L2Jg==
X-Gm-Message-State: AA+aEWaA/dsy1LojfbWTiL5BkBNni7m3wTjIc/PnflW/vYOldTkXeX0h
        +LNZkgyq0wrDlrD0e/n1eC1ItG9zHeecO+5hdCnP6lYVnTrA6BctFTfRAQjUNzj1v2XaTOCLTh9
        /2N4JwWzmD1VEK0D59gHOoqqAMNmCfQ3cCg3BejhY7qplads4I8j0wuO7SSG5DZCFLL3F6UPYAw
        ==
X-Google-Smtp-Source: AFSGD/X6Oep+NXfsGblP/0HbK9EhbrG0Zwvu6lKMJhJpf5f0I39HZXhTAidkuUDFTffXYv4YhPhmXHNYuPOBJPDrk70=
X-Received: by 2002:a25:a094:: with SMTP id y20-v6mr11051999ybh.90.1543294384513;
 Mon, 26 Nov 2018 20:53:04 -0800 (PST)
Date:   Mon, 26 Nov 2018 20:53:01 -0800
Message-Id: <20181127045301.103807-1-masayasuzuki@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [PATCH] pack-protocol.txt: accept error packets in any context
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the Git pack protocol definition, an error packet may appear only in
a certain context. However, servers can face a runtime error (e.g. I/O
error) at an arbitrary timing. This patch changes the protocol to allow
an error packet to be sent instead of any packet.

Following this protocol spec change, the error packet handling code is
moved to pkt-line.c.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 Documentation/technical/pack-protocol.txt | 20 +++++++++++---------
 builtin/archive.c                         |  2 --
 connect.c                                 |  2 --
 fetch-pack.c                              |  2 --
 pkt-line.c                                |  4 ++++
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 6ac774d5f..7a2375a55 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -22,6 +22,16 @@ protocol-common.txt. When the grammar indicate `PKT-LINE(...)`, unless
 otherwise noted the usual pkt-line LF rules apply: the sender SHOULD
 include a LF, but the receiver MUST NOT complain if it is not present.
 
+An error packet is a special pkt-line that contains an error string.
+
+----
+  error-line     =  PKT-LINE("ERR" SP explanation-text)
+----
+
+Throughout the protocol, where `PKT-LINE(...)` is expected, an error packet MAY
+be sent. Once this packet is sent by a client or a server, the data transfer
+process defined in this protocol is terminated.
+
 Transports
 ----------
 There are three transports over which the packfile protocol is
@@ -89,13 +99,6 @@ process on the server side over the Git protocol is this:
      "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
      nc -v example.com 9418
 
-If the server refuses the request for some reasons, it could abort
-gracefully with an error message.
-
-----
-  error-line     =  PKT-LINE("ERR" SP explanation-text)
-----
-
 
 SSH Transport
 -------------
@@ -398,12 +401,11 @@ from the client).
 Then the server will start sending its packfile data.
 
 ----
-  server-response = *ack_multi ack / nak / error-line
+  server-response = *ack_multi ack / nak
   ack_multi       = PKT-LINE("ACK" SP obj-id ack_status)
   ack_status      = "continue" / "common" / "ready"
   ack             = PKT-LINE("ACK" SP obj-id)
   nak             = PKT-LINE("NAK")
-  error-line     =  PKT-LINE("ERR" SP explanation-text)
 ----
 
 A simple clone may look like this (with no 'have' lines):
diff --git a/builtin/archive.c b/builtin/archive.c
index d2455237c..5d179bbd1 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -59,8 +59,6 @@ static int run_remote_archiver(int argc, const char **argv,
 	if (strcmp(buf, "ACK")) {
 		if (starts_with(buf, "NACK "))
 			die(_("git archive: NACK %s"), buf + 5);
-		if (starts_with(buf, "ERR "))
-			die(_("remote error: %s"), buf + 4);
 		die(_("git archive: protocol error"));
 	}
 
diff --git a/connect.c b/connect.c
index 24281b608..458906e60 100644
--- a/connect.c
+++ b/connect.c
@@ -306,8 +306,6 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 			die_initial_contact(1);
 		case PACKET_READ_NORMAL:
 			len = reader->pktlen;
-			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))
-				die(_("remote error: %s"), arg);
 			break;
 		case PACKET_READ_FLUSH:
 			state = EXPECTING_DONE;
diff --git a/fetch-pack.c b/fetch-pack.c
index 9691046e6..e66cd7b71 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -178,8 +178,6 @@ static enum ack_type get_ack(int fd, struct object_id *result_oid)
 			return ACK;
 		}
 	}
-	if (skip_prefix(line, "ERR ", &arg))
-		die(_("remote error: %s"), arg);
 	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
 }
 
diff --git a/pkt-line.c b/pkt-line.c
index 04d10bbd0..ce9e42d10 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -346,6 +346,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		return PACKET_READ_EOF;
 	}
 
+	if (starts_with(buffer, "ERR ")) {
+		die(_("remote error: %s"), buffer + 4);
+	}
+
 	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
 	    len && buffer[len-1] == '\n')
 		len--;
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

