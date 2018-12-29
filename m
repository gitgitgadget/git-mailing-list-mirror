Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610A51F932
	for <e@80x24.org>; Sat, 29 Dec 2018 21:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeL2VTc (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 16:19:32 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43820 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeL2VTc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 16:19:32 -0500
Received: by mail-pf1-f202.google.com with SMTP id b8so26170908pfe.10
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=McAs4yLm/E9xRpvm/x8MOjVc9WOE12egY5LWkT9iajg=;
        b=EIsMmQQ5vKsX8HfWmxozjIefeefbgvfG4jIlW8DyPkDrjaFNxAkS6TU60nWwFDXvow
         wFjGiuQ89nO8lQsM6kqRoCKcCWbGJdSdDTIVqPlYocKZi5aHivIIVYkYUEVmJZ720blH
         cJcFIJyFMixsSn/3UPkCDQ6RvFzXNVxP4q4WeBkbYnEphTXJWi7o5j+Mx+eCws3bTtvz
         duj0Z4/6ARcvx3/78sp9neDhdx2hXgmGRwIEF7PyFa315P7cGl4lp8ShB4Iro89y5fVR
         Rp3tlm3woV3stRMQGzDNN9rlTWJntaafJFl2BvV/oOQdqvYvB1Fz3asikYT4u40R80dX
         x6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=McAs4yLm/E9xRpvm/x8MOjVc9WOE12egY5LWkT9iajg=;
        b=eHE2/D/fP0heqe9Irg/T9aCDe5JQ+H4S+F8k1NwV7bQdWAao0qwiiLOU+AnwIPZIkt
         WeIlrWEa/kyYpDjWj+wO0Px2Og0v+QR2T1y6YA/4VOQFQsyZ/S3JKFyTmYJcEuvVxTEq
         iLTZSmZnvqhcwS7Gp/S7SzpE/Ar12uoKBPjgH+k51uC5WdZQ+9W6pUIa6juT9yGTXR+O
         MC2it+n3GtOjHWz/dlN54FH0XnvFM8wA8NaVNQSi6JMlhlLa0tEWC8JiQnuYVEb9b55j
         IuqRjFwNn0FIhMwmJYxhaPyN9j7VAGCXMXI5IL8BPAKiuIPfyboBP7SamoIX7o/WnGUe
         kjDw==
X-Gm-Message-State: AA+aEWbMREycUalmKvBJpRL7e9/NSNtG6NS+R9buatzQNiFzjrHPb5M8
        S3JXWxezUCa7Vk1FQDsOoYJj6LldYOBOFUyWrZE=
X-Google-Smtp-Source: ALg8bN4wrbqE4N4gEG+Iqdu3BPewSltwDi8I3tp7yH4z1FhC5RbUOv9UsQLHJrzz5CdobZCWNro8Y20LGaf4bUZZT1k=
X-Received: by 2002:a62:449b:: with SMTP id m27mr14690216pfi.87.1546118371489;
 Sat, 29 Dec 2018 13:19:31 -0800 (PST)
Date:   Sat, 29 Dec 2018 13:19:15 -0800
In-Reply-To: <20181229211915.161686-1-masayasuzuki@google.com>
Message-Id: <20181229211915.161686-3-masayasuzuki@google.com>
Mime-Version: 1.0
References: <reply-to=20181127045301.103807-1-masayasuzuki@google.com> <20181229211915.161686-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH v2 2/2] pack-protocol.txt: accept error packets in any context
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, peff@peff.net, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the Git pack protocol definition, an error packet may appear only in
a certain context. However, servers can face a runtime error (e.g. I/O
error) at an arbitrary timing. This patch changes the protocol to allow
an error packet to be sent instead of any packet.

Without this protocol spec change, when a server cannot process a
request, there's no way to tell that to a client. Since the server
cannot produce a valid response, it would be forced to cut a connection
without telling why. With this protocol spec change, the server can be
more gentle in this situation. An old client may see these error packets
as an unexpected packet, but this is not worse than having an unexpected
EOF.

Following this protocol spec change, the error packet handling code is
moved to pkt-line.c. Implementation wise, this implementation uses
pkt-line to communicate with a subprocess. Since this is not a part of
Git protocol, it's possible that a packet that is not supposed to be an
error packet is mistakenly parsed as an error packet. This error packet
handling is enabled only for the Git pack protocol parsing code
considering this.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 Documentation/technical/pack-protocol.txt | 20 +++++++++++---------
 builtin/archive.c                         |  6 +++---
 builtin/fetch-pack.c                      |  3 ++-
 builtin/receive-pack.c                    |  4 +++-
 builtin/send-pack.c                       |  3 ++-
 connect.c                                 |  3 ---
 fetch-pack.c                              |  8 ++++----
 pkt-line.c                                |  4 ++++
 pkt-line.h                                |  8 ++++++--
 remote-curl.c                             |  9 ++++++---
 send-pack.c                               |  4 +++-
 serve.c                                   |  5 +++--
 t/t5703-upload-pack-ref-in-want.sh        |  4 ++--
 transport.c                               |  3 ++-
 upload-pack.c                             |  4 +++-
 15 files changed, 54 insertions(+), 34 deletions(-)

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
index 2fe1f05ca..45d11669a 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -53,15 +53,15 @@ static int run_remote_archiver(int argc, const char **argv,
 		packet_write_fmt(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
-	packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+	packet_reader_init(&reader, fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
 		die(_("git archive: expected ACK/NAK, got a flush packet"));
 	if (strcmp(reader.line, "ACK")) {
 		if (starts_with(reader.line, "NACK "))
 			die(_("git archive: NACK %s"), reader.line + 5);
-		if (starts_with(reader.line, "ERR "))
-			die(_("remote error: %s"), reader.line + 4);
 		die(_("git archive: protocol error"));
 	}
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 63e69a580..85dbc2af8 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -217,7 +217,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_GENTLE_ON_EOF);
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	switch (discover_version(&reader)) {
 	case protocol_v2:
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 81cc07370..d58b7750b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1986,7 +1986,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	if (advertise_refs)
 		return 0;
 
-	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if ((commands = read_head_info(&reader, &shallow)) != NULL) {
 		const char *unpack_status = NULL;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8e3c7490f..098ebf22d 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -250,7 +250,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_GENTLE_ON_EOF);
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	switch (discover_version(&reader)) {
 	case protocol_v2:
diff --git a/connect.c b/connect.c
index 24281b608..4813f005a 100644
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
index 86790b9bb..3f9626dbf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -182,8 +182,6 @@ static enum ack_type get_ack(struct packet_reader *reader,
 			return ACK;
 		}
 	}
-	if (skip_prefix(reader->line, "ERR ", &arg))
-		die(_("remote error: %s"), arg);
 	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), reader->line);
 }
 
@@ -258,7 +256,8 @@ static int find_common(struct fetch_negotiator *negotiator,
 		die(_("--stateless-rpc requires multi_ack_detailed"));
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
-			   PACKET_READ_CHOMP_NEWLINE);
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if (!args->no_dependents) {
 		mark_tips(negotiator, args->negotiation_tips);
@@ -1358,7 +1357,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct fetch_negotiator negotiator;
 	fetch_negotiator_init(&negotiator, negotiation_algorithm);
 	packet_reader_init(&reader, fd[0], NULL, 0,
-			   PACKET_READ_CHOMP_NEWLINE);
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	while (state != FETCH_DONE) {
 		switch (state) {
diff --git a/pkt-line.c b/pkt-line.c
index 04d10bbd0..e70ea6d88 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -346,6 +346,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		return PACKET_READ_EOF;
 	}
 
+	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
+	    starts_with(buffer, "ERR "))
+		die(_("remote error: %s"), buffer + 4);
+
 	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
 	    len && buffer[len-1] == '\n')
 		len--;
diff --git a/pkt-line.h b/pkt-line.h
index 5b28d4347..d7e1dbc04 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -62,9 +62,13 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
  *
  * If options contains PACKET_READ_CHOMP_NEWLINE, a trailing newline (if
  * present) is removed from the buffer before returning.
+ *
+ * If options contains PACKET_READ_DIE_ON_ERR_PACKET, it dies when it sees an
+ * ERR packet.
  */
-#define PACKET_READ_GENTLE_ON_EOF (1u<<0)
-#define PACKET_READ_CHOMP_NEWLINE (1u<<1)
+#define PACKET_READ_GENTLE_ON_EOF     (1u<<0)
+#define PACKET_READ_CHOMP_NEWLINE     (1u<<1)
+#define PACKET_READ_DIE_ON_ERR_PACKET (1u<<2)
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
diff --git a/remote-curl.c b/remote-curl.c
index bbd9ba0f3..10b50869c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -204,7 +204,8 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 
 	packet_reader_init(&reader, -1, heads->buf, heads->len,
 			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_GENTLE_ON_EOF);
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	heads->version = discover_version(&reader);
 	switch (heads->version) {
@@ -411,7 +412,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	    !strbuf_cmp(&exp, &type)) {
 		struct packet_reader reader;
 		packet_reader_init(&reader, -1, last->buf, last->len,
-				   PACKET_READ_CHOMP_NEWLINE);
+				   PACKET_READ_CHOMP_NEWLINE |
+				   PACKET_READ_DIE_ON_ERR_PACKET);
 
 		/*
 		 * smart HTTP response; validate that the service
@@ -1182,7 +1184,8 @@ static void proxy_state_init(struct proxy_state *p, const char *service_name,
 		p->headers = curl_slist_append(p->headers, buf.buf);
 
 	packet_reader_init(&p->reader, p->in, NULL, 0,
-			   PACKET_READ_GENTLE_ON_EOF);
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	strbuf_release(&buf);
 }
diff --git a/send-pack.c b/send-pack.c
index 913645046..7b9829f16 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -558,7 +558,9 @@ int send_pack(struct send_pack_args *args,
 		in = demux.out;
 	}
 
-	packet_reader_init(&reader, in, NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+	packet_reader_init(&reader, in, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if (need_pack_data && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
diff --git a/serve.c b/serve.c
index bda085f09..317256c1a 100644
--- a/serve.c
+++ b/serve.c
@@ -167,7 +167,8 @@ static int process_request(void)
 
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_GENTLE_ON_EOF);
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	/*
 	 * Check to see if the client closed their end before sending another
@@ -175,7 +176,7 @@ static int process_request(void)
 	 */
 	if (packet_reader_peek(&reader) == PACKET_READ_EOF)
 		return 1;
-	reader.options = PACKET_READ_CHOMP_NEWLINE;
+	reader.options &= ~PACKET_READ_GENTLE_ON_EOF;
 
 	while (state != PROCESS_REQUEST_DONE) {
 		switch (packet_reader_peek(&reader)) {
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 3f58f05cb..d2a9d0c12 100755
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
diff --git a/transport.c b/transport.c
index 5a74b609f..12db4251c 100644
--- a/transport.c
+++ b/transport.c
@@ -273,7 +273,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
 
 	packet_reader_init(&reader, data->fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_GENTLE_ON_EOF);
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	data->version = discover_version(&reader);
 	switch (data->version) {
diff --git a/upload-pack.c b/upload-pack.c
index 1638825ee..08b547cf0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1078,7 +1078,9 @@ void upload_pack(struct upload_pack_options *options)
 	if (options->advertise_refs)
 		return;
 
-	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	receive_needs(&reader, &want_obj);
 	if (want_obj.nr) {
-- 
2.20.1.415.g653613c723-goog

