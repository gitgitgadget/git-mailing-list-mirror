Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110A51FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 11:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755582AbcHYLUI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:20:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36064 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbcHYLUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:20:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so6926999wmf.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lwI0PsclobvENHn/DZdguBNG0crjXkYUyiasEQ4uEVg=;
        b=fJgKDc+/2rmt/zy7W3pBPboXlUWAA06W1pZ7GMX9Oa09cAncSYGhjjr/mYLofE83Kg
         kt5KCFKimTH3N0cTxdT5DhrgSsNEaYB7AczoRUWh+VdMaMDwKsB1t3djpY9IewhXmTpE
         ptYGpUCR4UZbnBExGB+cuwiYuY4jPahLQh6RG6VfSOigS1vljOeb1jLtVkFWfnE9ri9g
         5UiT1LlQp1/CqH7Cvukd42rtefEJ2Tse9aeYu5Odu96T13/ksmLVn8EgqdxPIg5B1T1s
         QDBY9eNOirWWpU7cCgYbRKGdGPgIOK99QOzBwzOiIkPczpQ9ltKvdAaQ/xQsR3DbKZZL
         hxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lwI0PsclobvENHn/DZdguBNG0crjXkYUyiasEQ4uEVg=;
        b=LE1N/kOWRVAT8ct9TBLuoZxfEm84AmLtudF15EkYb7AYSDCQn2Omaej/ZUQEEOvoqf
         dzAg1SFAVpt8FvHKgAGh8TW/9YVJOXAr0U/9gH7BK14TLnjJEHqsomLZeO2S8NtuNlHq
         zCgYduUsp8suFhi3fv4S3EbTBG6i8dCk9hEVzbDXHnTb7jgUxQoKJCYA15nC4gNexnYz
         hquwxiEdtfxaZAgbFpyvIksavOAze6qVQb3Ly+qSdjiSCua8vL7tzciVeCadLacIbk5S
         VgsAlRbtTT5NWdvJQG3UwOwPjmNS2rI2IBsnU2JVUxe6uS5jkIS8sFU3+ePJyQmB6VK0
         fjRQ==
X-Gm-Message-State: AEkoouud3UfWaLPP7+SW2MnM0pm6obIwkOG066oHNo3OMm7wOYOqxXcfaSyISMIsKYWiGw==
X-Received: by 10.194.80.104 with SMTP id q8mr7769323wjx.151.1472123277964;
        Thu, 25 Aug 2016 04:07:57 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.07.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:07:57 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 01/13] pkt-line: rename packet_write() to packet_write_fmt()
Date:   Thu, 25 Aug 2016 13:07:40 +0200
Message-Id: <20160825110752.31581-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

packet_write() should be called packet_write_fmt() as the string
parameter can be formatted.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
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
index 15c323a..d60a412 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -199,7 +199,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 static void show_ref(const char *path, const unsigned char *sha1)
 {
 	if (sent_capabilities) {
-		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
+		packet_write_fmt(1, "%s %s\n", sha1_to_hex(sha1), path);
 	} else {
 		struct strbuf cap = STRBUF_INIT;
 
@@ -212,7 +212,7 @@ static void show_ref(const char *path, const unsigned char *sha1)
 		if (push_cert_nonce)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
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
index e647254..2646d0f 100644
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
index 0d59499..aa61c18 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -460,7 +460,7 @@ static void get_info_refs(char *arg)
 		hdr_str(content_type, buf.buf);
 		end_headers();
 
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
index 4d554ca..1826114 100644
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
index d4cc414..8e77b00 100644
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
2.9.2

