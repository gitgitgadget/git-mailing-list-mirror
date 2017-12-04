Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB3B820954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbdLDX7o (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:44 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33940 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbdLDX71 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:27 -0500
Received: by mail-pg0-f54.google.com with SMTP id j4so9392331pgp.1
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b7csQNb7Hj48YY8D4MkVgCWzJ5YlaPWX1I+nc9hzpVA=;
        b=DmlKb24sXPcS+ycKDMqjoDmLWxB9JEjVaT73RsAneFrosz8eYGrlv7Mn6U+ip280sR
         FvA3hStTEWhMZq0iCjOYgVTp/VpCHZbmc1y0n3EObIgt3ItT17CjjBSl/epvQOHq0JUy
         MAsUZAB76Y1Wbk/7WoYGHnSHijnNWvo2YUruAT9HxmoxPqRF40zN3qMH9baTI3u6ooAJ
         8pBRflbiOAKJVChpbyzmwlid9ht9Gdv2qGPRy4afUWIVBQbS2xhfEnfgxxN52lZC4QhX
         dkk8Zhf5DBUT9astIK+QlGzczIBrfz56B5KxHevj1dO3BNjWzNPV4335/6eEms/+ErIb
         52nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b7csQNb7Hj48YY8D4MkVgCWzJ5YlaPWX1I+nc9hzpVA=;
        b=MrNZ10xeht80yHnayRv6aSHKwI/HfWiq/ZQ/iC1i4+aO0Dzw/kbK4swjD9MVb0rETx
         Dogix3PMyydijlQqERHxBgn5NGcIVt8YavCP1Xc2kzNUaKfSut1K3BPJpwrgugKrhuHJ
         MtxFg7QKJgXIWjsuQgzUSYZpmxDlUbPWGUD7k3ANT/lW8ZzKHi0BptR7XzMGqAN3Abj+
         zhvQy/Z0LRdHJwPwcxHI9HdxshxHi3wkSLSpD1X71hwtxtOL9dXtcDwehQVP53B8aKeS
         tg7rvhRroKvhBilyllAbJ3O35XTIUC1Sk9rZKsGGJLByzO10tpEjNioxylJm+J2RYZsC
         ybww==
X-Gm-Message-State: AJaThX5u3g/lpNyf2xwJhxykY0q5Vu0ngWaiI1xn803+xfZ4rp8Sz+DB
        aY9RascduaPOyUK4lP/FGRa2DADq1bs=
X-Google-Smtp-Source: AGs4zMblo9kzTvv8m6zlwzDlXikjUdU7tG/ILSH8Wwkm0YckzRusu5gkDy6GM/3ZmWygmeJLCnbasw==
X-Received: by 10.84.128.103 with SMTP id 94mr16656029pla.119.1512431965763;
        Mon, 04 Dec 2017 15:59:25 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:24 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 14/15] upload_pack: introduce fetch server command
Date:   Mon,  4 Dec 2017 15:58:22 -0800
Message-Id: <20171204235823.63299-15-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the 'fetch' server command.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 serve.c       |   2 +
 upload-pack.c | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.h |   9 +++
 3 files changed, 234 insertions(+)
 create mode 100644 upload-pack.h

diff --git a/serve.c b/serve.c
index 36f77c365..7823ef0d9 100644
--- a/serve.c
+++ b/serve.c
@@ -6,6 +6,7 @@
 #include "argv-array.h"
 #include "ls-refs.h"
 #include "serve.h"
+#include "upload-pack.h"
 
 static int always_advertise(struct repository *r,
 			    struct strbuf *value)
@@ -34,6 +35,7 @@ struct protocol_capability {
 static struct protocol_capability capabilities[] = {
 	{ "agent", 0, agent_advertise, NULL },
 	{ "ls-refs", 0, always_advertise, ls_refs },
+	{ "fetch", 0, always_advertise, upload_pack_v2 },
 };
 
 static void advertise_capabilities(void)
diff --git a/upload-pack.c b/upload-pack.c
index 3296831f8..dc4421ab3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -20,6 +20,7 @@
 #include "prio-queue.h"
 #include "protocol.h"
 #include "serve.h"
+#include "upload-pack.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git upload-pack [<options>] <dir>"),
@@ -1041,6 +1042,228 @@ static void upload_pack(void)
 	}
 }
 
+static int process_want(const char *line)
+{
+	const char *arg;
+	if (skip_prefix(line, "want ", &arg)) {
+		struct object_id oid;
+		struct object *o;
+
+		if (get_oid_hex(arg, &oid))
+			die("git upload-pack: protocol error, "
+			    "expected to get oid, not '%s'", line);
+
+		o = parse_object(&oid);
+		if (!o) {
+			packet_write_fmt(1,
+					 "ERR upload-pack: not our ref %s",
+					 oid_to_hex(&oid));
+			die("git upload-pack: not our ref %s",
+			    oid_to_hex(&oid));
+		}
+
+		if (!(o->flags & WANTED)) {
+			o->flags |= WANTED;
+			add_object_array(o, NULL, &want_obj);
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int parse_have(const char *line, struct oid_array *haves)
+{
+	const char *arg;
+	if (skip_prefix(line, "have ", &arg)) {
+		struct object_id oid;
+
+		if (get_oid_hex(arg, &oid))
+			die("git upload-pack: expected SHA1 object, got '%s'", arg);
+		oid_array_append(haves, &oid);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void process_args(struct argv_array *args, struct oid_array *haves_oid)
+{
+	int i;
+
+	for (i = 0; i < args->argc; i++) {
+		const char *arg = args->argv[i];
+
+		/* process want */
+		if (process_want(arg))
+			continue;
+		/* process have line */
+		if (parse_have(arg, haves_oid))
+			continue;
+
+		/* process args like thin-pack */
+		if (!strcmp(arg, "thin-pack")) {
+			use_thin_pack = 1;
+			continue;
+		}
+		if (!strcmp(arg, "ofs-delta")) {
+			use_ofs_delta = 1;
+			continue;
+		}
+		if (!strcmp(arg, "no-progress")) {
+			no_progress = 1;
+			continue;
+		}
+		if (!strcmp(arg, "include-tag")) {
+			use_include_tag = 1;
+			continue;
+		}
+
+		/* ignore unknown lines maybe? */
+		die("unexpect line: '%s'", arg);
+	}
+}
+
+static int process_haves(struct oid_array *haves, struct oid_array *common)
+{
+	int i;
+
+	/* Process haves */
+	for (i = 0; i < haves->nr; i++) {
+		const struct object_id *oid = &haves->oid[i];
+		struct object *o;
+		int we_knew_they_have = 0;
+
+		if (!has_object_file(oid))
+			continue;
+
+		oid_array_append(common, oid);
+
+		o = parse_object(oid);
+		if (!o)
+			die("oops (%s)", oid_to_hex(oid));
+		if (o->type == OBJ_COMMIT) {
+			struct commit_list *parents;
+			struct commit *commit = (struct commit *)o;
+			if (o->flags & THEY_HAVE)
+				we_knew_they_have = 1;
+			else
+				o->flags |= THEY_HAVE;
+			if (!oldest_have || (commit->date < oldest_have))
+				oldest_have = commit->date;
+			for (parents = commit->parents;
+			     parents;
+			     parents = parents->next)
+				parents->item->object.flags |= THEY_HAVE;
+		}
+		if (!we_knew_they_have)
+			add_object_array(o, NULL, &have_obj);
+	}
+
+	return 0;
+}
+
+static int send_acks(struct oid_array *acks, struct strbuf *response)
+{
+	int i;
+	/* Send Acks */
+	if (!acks->nr)
+		packet_buf_write(response, "NAK\n");
+
+	for (i = 0; i < acks->nr; i++) {
+		packet_buf_write(response, "ACK %s common\n",
+				 oid_to_hex(&acks->oid[i]));
+	}
+
+	if (ok_to_give_up()) {
+		/* Send Ready */
+		packet_buf_write(response, "ACK %s ready\n",
+				 oid_to_hex(&acks->oid[i-1]));
+		return 1;
+	}
+
+	return 0;
+}
+
+#define COMMON_START 0
+#define COMMON_DONE 1
+#define COMMON_READ_HAVES 2
+#define COMMON_PROCESS_HAVES 3
+
+static int get_common_commits_v2(struct oid_array *haves_oid)
+{
+	struct packet_reader reader;
+	int done = 0;
+	int state = haves_oid->nr ? COMMON_PROCESS_HAVES : COMMON_DONE;
+	struct oid_array common = OID_ARRAY_INIT;
+	struct strbuf response = STRBUF_INIT;
+	packet_reader_init(&reader, 0, NULL, 0);
+
+	while (state != COMMON_DONE) {
+		switch (state) {
+		case COMMON_START:
+			break;
+		case COMMON_READ_HAVES:
+			while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
+
+				if (parse_have(reader.line, haves_oid))
+					continue;
+				if (!strcmp(reader.line, "done")) {
+					done = 1;
+					continue;
+				}
+			}
+			if (reader.status != PACKET_READ_FLUSH)
+				die("ERROR");
+
+			state = COMMON_PROCESS_HAVES;
+			break;
+		case COMMON_PROCESS_HAVES:
+			process_haves(haves_oid, &common);
+			if (done) {
+				state = COMMON_DONE;
+			} else if (send_acks(&common, &response)) {
+				packet_buf_delim(&response);
+				state = COMMON_DONE;
+			} else {
+				/* Add Flush */
+				packet_buf_flush(&response);
+				state = COMMON_READ_HAVES;
+			}
+
+			/* Send response */
+			write_or_die(1, response.buf, response.len);
+			strbuf_reset(&response);
+			oid_array_clear(haves_oid);
+			oid_array_clear(&common);
+			break;
+		case COMMON_DONE:
+			break;
+		default:
+			BUG("invalid state");
+		}
+	}
+	return 0;
+}
+
+int upload_pack_v2(struct repository *r, struct argv_array *keys,
+		   struct argv_array *args)
+{
+	struct oid_array haves_oid = OID_ARRAY_INIT;
+	use_sideband = LARGE_PACKET_MAX;
+	process_args(args, &haves_oid);
+
+	if (want_obj.nr) {
+		/* Determine Common Commits */
+		get_common_commits_v2(&haves_oid);
+		/* create packfile */
+		create_pack_file();
+	}
+
+	return 0;
+}
+
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
diff --git a/upload-pack.h b/upload-pack.h
new file mode 100644
index 000000000..54c429563
--- /dev/null
+++ b/upload-pack.h
@@ -0,0 +1,9 @@
+#ifndef UPLOAD_PACK_H
+#define UPLOAD_PACK_H
+
+struct repository;
+struct argv_array;
+extern int upload_pack_v2(struct repository *r, struct argv_array *keys,
+			  struct argv_array *args);
+
+#endif /* UPLOAD_PACK_H */
-- 
2.15.1.424.g9478a66081-goog

