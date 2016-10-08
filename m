Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8316207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935068AbcJHLZv (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:25:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35516 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbcJHLZl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id f193so6634520wmg.2
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JrCacT/Adl9u3ZQ5Z2YIO9E8ybdeqse5PidFyMz5Qv4=;
        b=0PCp1OJDBFmSKzB0drsS1q6MqZpO37Q+E/FFLFh+K05NlQRCNc+2C1Z2UsrIo/lxbc
         HPhQlwPsYwYseZqmF30UYXw1ksyjrvtVgXrZofSxorrslkhnWNxeTulgRXRDHiwcf9mn
         pSRiYOewSAX4a5oVVefPgcntX9XSC9WSWnSYBCEiU+HGQIVZ4/4nR6VZAlaGm25gY1S2
         Uh0biD1G9aRS5clJw0xJbPyA4stDhHOqCYFVB7R/0BT1wITm3pgtTVzk2SkGOyoXgGmJ
         whMIVPm+r7cVs2tpFNhk+4Hfh/M7jfygZ4DTdQuNdIjgwRxJgN+WnX8sdXYZGN3VcE5f
         cu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JrCacT/Adl9u3ZQ5Z2YIO9E8ybdeqse5PidFyMz5Qv4=;
        b=D7hGOePB6HjR7ueC7msMsgGVUQOahIBDlaNJZb7jhjmCXKBMmIYAB88D4sNKmpQLY8
         fpV8TAv0LyE5u4DA01EPDKE31pxuggPipL/Ntn+r8wIHJt+3RZLWMfDUYRuoqVk2qkiI
         8zHUUuVJG6PLQ0AFXJ8V/jKgPbM0WsMMU9c1YTtYWL+id4GS20G1fk7zepZ7ckb0lfJW
         01L/li9zoipjj+nIY/4cCLiJqR+ubJJRrgj9oMW+yFfj9lpKhB1zwdzH/hnhl3QBkUaU
         KqC4gy1Dl0kwxphczbqdvPNszcf1/BRjot/G4ZFZ5z60QnlrlYw4a//7Fg/JIf2HY+A0
         2reA==
X-Gm-Message-State: AA6/9RloFxRIBHtxhyriuD9q84AdSB4l4ERsc53LpAQTIzpmRFyIXqB4mh+L4agS53amnw==
X-Received: by 10.28.43.129 with SMTP id r123mr2919256wmr.27.1475925939943;
        Sat, 08 Oct 2016 04:25:39 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:38 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 05/14] pkt-line: rename packet_write() to packet_write_fmt()
Date:   Sat,  8 Oct 2016 13:25:21 +0200
Message-Id: <20161008112530.15506-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write() should be called packet_write_fmt() because it is a
printf-like function that takes a format string as first parameter.

packet_write_fmt() should be used for text strings only. Arbitrary
binary data should use a new packet_write() function that is introduced
in a subsequent patch.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/archive.c        |  4 ++--
 builtin/receive-pack.c   |  4 ++--
 builtin/remote-ext.c     |  4 ++--
 builtin/upload-archive.c |  4 ++--
 connect.c                |  2 +-
 daemon.c                 |  2 +-
 http-backend.c           |  2 +-
 pkt-line.c               |  2 +-
 pkt-line.h               |  2 +-
 shallow.c                |  2 +-
 upload-pack.c            | 30 +++++++++++++++---------------
 11 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index a1e3b94..49f4914 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -47,10 +47,10 @@ static int run_remote_archiver(int argc, const char **argv,
 	if (name_hint) {
 		const char *format = archive_format_from_filename(name_hint);
 		if (format)
-			packet_write(fd[1], "argument --format=%s\n", format);
+			packet_write_fmt(fd[1], "argument --format=%s\n", format);
 	}
 	for (i = 1; i < argc; i++)
-		packet_write(fd[1], "argument %s\n", argv[i]);
+		packet_write_fmt(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
 	buf = packet_read_line(fd[0], NULL);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 011db00..1ce7682 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -218,7 +218,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 static void show_ref(const char *path, const unsigned char *sha1)
 {
 	if (sent_capabilities) {
-		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
+		packet_write_fmt(1, "%s %s\n", sha1_to_hex(sha1), path);
 	} else {
 		struct strbuf cap = STRBUF_INIT;
 
@@ -233,7 +233,7 @@ static void show_ref(const char *path, const unsigned char *sha1)
 		if (advertise_push_options)
 			strbuf_addstr(&cap, " push-options");
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
-		packet_write(1, "%s %s%c%s\n",
+		packet_write_fmt(1, "%s %s%c%s\n",
 			     sha1_to_hex(sha1), path, 0, cap.buf);
 		strbuf_release(&cap);
 		sent_capabilities = 1;
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 88eb8f9..11b48bf 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -128,9 +128,9 @@ static void send_git_request(int stdin_fd, const char *serv, const char *repo,
 	const char *vhost)
 {
 	if (!vhost)
-		packet_write(stdin_fd, "%s %s%c", serv, repo, 0);
+		packet_write_fmt(stdin_fd, "%s %s%c", serv, repo, 0);
 	else
-		packet_write(stdin_fd, "%s %s%chost=%s%c", serv, repo, 0,
+		packet_write_fmt(stdin_fd, "%s %s%chost=%s%c", serv, repo, 0,
 			     vhost, 0);
 }
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 2caedf1..dc872f6 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -88,11 +88,11 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 	writer.git_cmd = 1;
 	if (start_command(&writer)) {
 		int err = errno;
-		packet_write(1, "NACK unable to spawn subprocess\n");
+		packet_write_fmt(1, "NACK unable to spawn subprocess\n");
 		die("upload-archive: %s", strerror(err));
 	}
 
-	packet_write(1, "ACK\n");
+	packet_write_fmt(1, "ACK\n");
 	packet_flush(1);
 
 	while (1) {
diff --git a/connect.c b/connect.c
index 722dc3f..5330d9c 100644
--- a/connect.c
+++ b/connect.c
@@ -730,7 +730,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 * Note: Do not add any other headers here!  Doing so
 		 * will cause older git-daemon servers to crash.
 		 */
-		packet_write(fd[1],
+		packet_write_fmt(fd[1],
 			     "%s %s%chost=%s%c",
 			     prog, path, 0,
 			     target_host, 0);
diff --git a/daemon.c b/daemon.c
index 425aad0..afce1b9 100644
--- a/daemon.c
+++ b/daemon.c
@@ -281,7 +281,7 @@ static int daemon_error(const char *dir, const char *msg)
 {
 	if (!informative_errors)
 		msg = "access denied or repository not exported";
-	packet_write(1, "ERR %s: %s", msg, dir);
+	packet_write_fmt(1, "ERR %s: %s", msg, dir);
 	return -1;
 }
 
diff --git a/http-backend.c b/http-backend.c
index adc8c8c..eef0a36 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -464,7 +464,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg)
 		hdr_str(hdr, content_type, buf.buf);
 		end_headers(hdr);
 
-		packet_write(1, "# service=git-%s\n", svc->name);
+		packet_write_fmt(1, "# service=git-%s\n", svc->name);
 		packet_flush(1);
 
 		argv[0] = svc->name;
diff --git a/pkt-line.c b/pkt-line.c
index 62fdb37..0a9b61c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -118,7 +118,7 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
-void packet_write(int fd, const char *fmt, ...)
+void packet_write_fmt(int fd, const char *fmt, ...)
 {
 	static struct strbuf buf = STRBUF_INIT;
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 3cb9d91..1902fb3 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -20,7 +20,7 @@
  * side can't, we stay with pure read/write interfaces.
  */
 void packet_flush(int fd);
-void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
diff --git a/shallow.c b/shallow.c
index 54e2db7..d666e24 100644
--- a/shallow.c
+++ b/shallow.c
@@ -260,7 +260,7 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 {
 	int fd = *(int *)cb;
 	if (graft->nr_parent == -1)
-		packet_write(fd, "shallow %s\n", oid_to_hex(&graft->oid));
+		packet_write_fmt(fd, "shallow %s\n", oid_to_hex(&graft->oid));
 	return 0;
 }
 
diff --git a/upload-pack.c b/upload-pack.c
index ca7f941..cd47de6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -393,13 +393,13 @@ static int get_common_commits(void)
 			if (multi_ack == 2 && got_common
 			    && !got_other && ok_to_give_up()) {
 				sent_ready = 1;
-				packet_write(1, "ACK %s ready\n", last_hex);
+				packet_write_fmt(1, "ACK %s ready\n", last_hex);
 			}
 			if (have_obj.nr == 0 || multi_ack)
-				packet_write(1, "NAK\n");
+				packet_write_fmt(1, "NAK\n");
 
 			if (no_done && sent_ready) {
-				packet_write(1, "ACK %s\n", last_hex);
+				packet_write_fmt(1, "ACK %s\n", last_hex);
 				return 0;
 			}
 			if (stateless_rpc)
@@ -416,20 +416,20 @@ static int get_common_commits(void)
 					const char *hex = sha1_to_hex(sha1);
 					if (multi_ack == 2) {
 						sent_ready = 1;
-						packet_write(1, "ACK %s ready\n", hex);
+						packet_write_fmt(1, "ACK %s ready\n", hex);
 					} else
-						packet_write(1, "ACK %s continue\n", hex);
+						packet_write_fmt(1, "ACK %s continue\n", hex);
 				}
 				break;
 			default:
 				got_common = 1;
 				memcpy(last_hex, sha1_to_hex(sha1), 41);
 				if (multi_ack == 2)
-					packet_write(1, "ACK %s common\n", last_hex);
+					packet_write_fmt(1, "ACK %s common\n", last_hex);
 				else if (multi_ack)
-					packet_write(1, "ACK %s continue\n", last_hex);
+					packet_write_fmt(1, "ACK %s continue\n", last_hex);
 				else if (have_obj.nr == 1)
-					packet_write(1, "ACK %s\n", last_hex);
+					packet_write_fmt(1, "ACK %s\n", last_hex);
 				break;
 			}
 			continue;
@@ -437,10 +437,10 @@ static int get_common_commits(void)
 		if (!strcmp(line, "done")) {
 			if (have_obj.nr > 0) {
 				if (multi_ack)
-					packet_write(1, "ACK %s\n", last_hex);
+					packet_write_fmt(1, "ACK %s\n", last_hex);
 				return 0;
 			}
-			packet_write(1, "NAK\n");
+			packet_write_fmt(1, "NAK\n");
 			return -1;
 		}
 		die("git upload-pack: expected SHA1 list, got '%s'", line);
@@ -650,7 +650,7 @@ static void receive_needs(void)
 		while (result) {
 			struct object *object = &result->item->object;
 			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
-				packet_write(1, "shallow %s",
+				packet_write_fmt(1, "shallow %s",
 						oid_to_hex(&object->oid));
 				register_shallow(object->oid.hash);
 				shallow_nr++;
@@ -662,7 +662,7 @@ static void receive_needs(void)
 			struct object *object = shallows.objects[i].item;
 			if (object->flags & NOT_SHALLOW) {
 				struct commit_list *parents;
-				packet_write(1, "unshallow %s",
+				packet_write_fmt(1, "unshallow %s",
 					oid_to_hex(&object->oid));
 				object->flags &= ~CLIENT_SHALLOW;
 				/* make sure the real parents are parsed */
@@ -741,7 +741,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
-		packet_write(1, "%s %s%c%s%s%s%s%s agent=%s\n",
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
@@ -753,11 +753,11 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
-		packet_write(1, "%s %s\n", oid_to_hex(oid), refname_nons);
+		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
 	if (!peel_ref(refname, peeled.hash))
-		packet_write(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return 0;
 }
 
-- 
2.10.0

