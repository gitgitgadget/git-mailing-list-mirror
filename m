Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812D520A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 00:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeLLAZZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:25:25 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56888 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLAZY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:25:24 -0500
Received: by mail-pg1-f202.google.com with SMTP id d3so10954820pgv.23
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tEocrAbE4nXSQtORigWnkF7jqJbWCC3+Yzx/rHxNh2c=;
        b=GBUjp89wrAn3oFyOiJlZwJM1N7YZt7WGC7/KycfP9BFstu0MB1GtPIqcVTaxG9TMBD
         RSa5zYjh3UcsnGwCIqU00K1/jON0tJd8rJNWqF69wIDi9UyVb4S3aSf22njBNp74ohCS
         99dBxqO2QMrbO45LAgM1BcpFFmphuyCQVdM0QUzEbpNR8L6dz0X4rhvKWbKY1v8M4biN
         Sfdl0jtRR/2CWjF4Ss1PcpY5OwYg4hxBg/t9m96HJ4EeX0K/uck0MJJzzloMVg1IbgMM
         Zyr/pzUlvkl2akzSvHPLlHHTfM5XkeCzBmcOEHhKb1Wr/VnOo7pbCs+nY90dPzvgYkCi
         DCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tEocrAbE4nXSQtORigWnkF7jqJbWCC3+Yzx/rHxNh2c=;
        b=l7LhaHZW6PPBKNrgLPUVFUm8HevHje95kGxAxBSqfffKowZrKSkRwCc+ceCnus/xh7
         +89QHkdrC3ZW1LXOBCKw6gEdY+57UUOQRe7/QdYwgUlxTUAClTdU4HMkpry1oCjIgIif
         NNViT5F/Fvet2OZ9YUhGiTFI3JqHd7HU7lHeY21bZXVsTBVMCRvz/3D3VH6LQe7vAHTU
         tfbpsiiXkw9PwU7hC6U/fz0i7k5j6QmjsUY0DMENDtP3SNs9Gx3ehLh06mR8UZmafAxv
         GyYu48TWTMA23zy/vXRUDzuWy6oNj4t1XO62dxpoggswJYn2l/j8Nz2gxsx0L4z9/Gnt
         t7CA==
X-Gm-Message-State: AA+aEWY11Znk8sTwHBrZGNY9r2h0TaePVeV29hgVPXeur1knIVJURVQs
        c4UsAmW5gtV3AF/6HJv+/YatRJkrMW/iNKL9BFgjCcYz7aHxshZvy+wNVdV4j0OHXRbSI6VjN4r
        Cel/CDgm73Tc8kN907uDPt5fv/d/Uwf7hgqV7sU6Qb1i1Ohv+JpqFaxkiiuRv76Q=
X-Google-Smtp-Source: AFSGD/Wn1ZKFt4fp4dHdPdLctab/rIJBAhbRirkjLhMbdKe9PsuLPKP0PKayhbUFRLKxtD+zI97cC2RI9HeSzg==
X-Received: by 2002:a63:464f:: with SMTP id v15mr9499033pgk.34.1544574323201;
 Tue, 11 Dec 2018 16:25:23 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:25:15 -0800
In-Reply-To: <cover.1544572142.git.steadmon@google.com>
Message-Id: <df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com>
Mime-Version: 1.0
References: <20181116084427.GA31493@sigill.intra.peff.net> <cover.1544572142.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v3 1/4] pack-protocol.txt: accept error packets in any context
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, masayasuzuki@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Masaya Suzuki <masayasuzuki@google.com>

In the Git pack protocol definition, an error packet may appear only in
a certain context. However, servers can face a runtime error (e.g. I/O
error) at an arbitrary timing. This patch changes the protocol to allow
an error packet to be sent instead of any packet.

Following this protocol spec change, the error packet handling code is
moved to pkt-line.c.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/pack-protocol.txt | 20 +++++++++++---------
 builtin/archive.c                         |  2 --
 connect.c                                 |  3 ---
 fetch-pack.c                              |  2 --
 pkt-line.c                                |  4 ++++
 t/t5703-upload-pack-ref-in-want.sh        |  4 ++--
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 6ac774d5f6..7a2375a55d 100644
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
index d2455237ce..5d179bbd16 100644
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
index 24281b6082..4813f005ab 100644
--- a/connect.c
+++ b/connect.c
@@ -296,7 +296,6 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 	struct ref **orig_list = list;
 	int len = 0;
 	enum get_remote_heads_state state = EXPECTING_FIRST_REF;
-	const char *arg;
 
 	*list = NULL;
 
@@ -306,8 +305,6 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 			die_initial_contact(1);
 		case PACKET_READ_NORMAL:
 			len = reader->pktlen;
-			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))
-				die(_("remote error: %s"), arg);
 			break;
 		case PACKET_READ_FLUSH:
 			state = EXPECTING_DONE;
diff --git a/fetch-pack.c b/fetch-pack.c
index 9691046e64..e66cd7b71b 100644
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
index 04d10bbd03..ce9e42d10e 100644
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
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 3f58f05cbb..d2a9d0c127 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -208,7 +208,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	cp -r "$LOCAL_PRISTINE" local &&
 	inconsistency master 1234567890123456789012345678901234567890 &&
 	test_must_fail git -C local fetch 2>err &&
-	grep "ERR upload-pack: not our ref" err
+	grep "fatal: remote error: upload-pack: not our ref" err
 '
 
 test_expect_success 'server is initially ahead - ref in want' '
@@ -254,7 +254,7 @@ test_expect_success 'server loses a ref - ref in want' '
 	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-sed" &&
 	test_must_fail git -C local fetch 2>err &&
 
-	grep "ERR unknown ref refs/heads/raster" err
+	grep "fatal: remote error: unknown ref refs/heads/raster" err
 '
 
 stop_httpd
-- 
2.20.0.rc2.403.gdbc3b29805-goog

