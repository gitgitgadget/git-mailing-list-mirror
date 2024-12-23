Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0C1C5F1C
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734996358; cv=none; b=ON6TTmT6IlqUN1M2wQ8eEKQmz9Nw0geyBeTvSmHyTcN/gSJMqvVtyiGr9tjfD3aCa1tWrJwXw9ubpIiqqTaqFWU9rQEPKz+NvliD38l0yI50UzXfKQVZHdH1sziBMqJR9HyXPgu29YomezEH2EHd/QXdRqzX/4V+L4BkjsUn6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734996358; c=relaxed/simple;
	bh=xEIfI0WgMzR2ex+pWILzX9i5HvbAokYZOntVeDOPzbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBSQjIiPCRleM4bQmatbHY0KG+ceZlNfbQLtAsNaqEzZIkZ/papFVID0tAOV2+bxT9T9wJ3oXKCXZFRVTK+w+GVbECrnPfffxn/C9I4vkSfrdIyMZm+uOcZ+KViqyMEtuwa8dMleYvIS5+oQkbMG7mAizOEAYUGsNwZev7Hp97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih+RvY16; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih+RvY16"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d888fc8300so21955696d6.3
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 15:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734996355; x=1735601155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uvAssubBOmPx78nm4+Rh9dueCvU0Liv8u+rH9R5LLI=;
        b=ih+RvY16pMdvvNsANZYo9RoPmWFiq2T0xIEJf/5zWK7r93cd+KYn03bpsrMx5E+WJt
         wduuEzApdy5sgcUNB8aFXgs6IABxaxawy45zvJiujARPA1jIby3gBn1ticinaafgVt+o
         OnqrOG2cw1KAyKO5n6HaOioNeNy8ldJjG0bOaUnUAKWzHVTLsRM8N33hDB8a+JZ89A7A
         KkzdVtYHvucDtvWjAaYOptRgUiCUbpKOsG7u8WxZCTVgNBj94Ng/aJlCrdjqFx/bW4M6
         jXxlWEYWOUIX3zofCsHi3L5p+doWLru20foUb/JtK3BmXOrrJQkoVfeJ0Br6meaQp4GQ
         DZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734996355; x=1735601155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uvAssubBOmPx78nm4+Rh9dueCvU0Liv8u+rH9R5LLI=;
        b=KBS5W6DYbb92c24Sai4hppID1xxflz7L/qX3c2v4YilskRe/AmUouQCnGrg3Q1r26D
         zNPljUVbVlz9TRRaVswdfmy/ejpoz1cQCKSk3wgZ85djOQY0eocb96//Rdl/xXSv8fTm
         yLO7+/Lrd6BLwKCA4SJsaaxWZTCfkumeEMXbjnTnMF+XYbTXRd4NpoFyYu8zt8VxIbta
         rSUavZxvzu27P70l3fXB6VWPDAGGHDuOOcgnWRjgVHq/qpGrrc5KgrTicbGiJ+9QoI1n
         +DnhzjzYFkO08Y1vmWjXa3qFDf9rIVl0p47foDrXf6GQ+q8gKleubrBA1MmHGH9MQutu
         PaLQ==
X-Gm-Message-State: AOJu0YwUEsfDPBB3036hytRJNXG0xcfYTRFzx/InQxFex/RWv+CXS7Kl
	x8rTiHP89qJeIwYN8sBIMywGyJfqghGZRfI//2/1vuCLjc2EXAoJwm2jOUQ4
X-Gm-Gg: ASbGncvnYbBBphHV8Pq0pxaKUcUjZpnDCUf6CsExp+B9nSrqoF+rzvESU3ncYeFO2TE
	OzCIjVHvx3/zW4qL4KLWKm9gr+tEmGCpckHCq6hN7WDT+BvbxMEGBn4idSIzxgoxyHz2Td7cy33
	XhPuknp2TEugS+Mt6d6i4VSxCvCkBMmO6JWYoheGdShfwen4wku/s5BOIF4VU191RctZBewfxSQ
	HajtK19O2FhbfE1wcc4i7O/N7OzPowCqdLKkKrN7126rEHvQlKqwXLw/yR9mgD1CBRtPIZ1OgTj
	7A5ktMYki3PcOcFMkRJTko1FWvCylWfD8HtQ+uDQH7Kq0voUGq/Q2+ghLAvA1Q==
X-Google-Smtp-Source: AGHT+IEc4OXLr+t5p6RTpRkKLoggadErBSxJEhc2YF0+YmrhDXlyCDd1gfCnaUVt/3qgPjxvw9gilA==
X-Received: by 2002:a05:6214:260b:b0:6d4:2646:108a with SMTP id 6a1803df08f44-6dd23329655mr245699076d6.12.1734996355146;
        Mon, 23 Dec 2024 15:25:55 -0800 (PST)
Received: from localhost.localdomain (pool-174-118-208-220.cpe.net.cable.rogers.com. [174.118.208.220])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18136e56sm47672496d6.61.2024.12.23.15.25.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Dec 2024 15:25:54 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v8 2/6] fetch-pack: refactor packet writing
Date: Mon, 23 Dec 2024 19:25:19 -0400
Message-ID: <20241223232523.76236-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241223232523.76236-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241223232523.76236-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Refactor write_fetch_command_and_capabilities() to a more
general-purpose function, write_command_and_capabilities(), enabling it
to serve both fetch and additional commands.

In this context, "command" refers to the "operations" supported by
Git's wire protocol https://git-scm.com/docs/protocol-v2, such as a Git
subcommand (e.g., git-fetch(1)) or a server-side operation like
"object-info" as implemented in commit a2ba162c
(object-info: support for retrieving object info, 2021-04-20).

Furthermore, write_command_and_capabilities() is moved to connect.c,
making it accessible to additional commands in the future.

To move write_command_and_capabilities() to connect.c, we need to
adjust how `advertise_sid` is managed. Previously,
in fetch_pack.c, `advertise_sid` was a static variable, modified using
git_config_get_bool().

In connect.c, we now initialize `advertise_sid` at the beginning by
directly using git_config_get_bool(). This change is safe because:

In the original fetch-pack.c code, there are only two places that
write `advertise_sid` :
1. In function do_fetch_pack:
        if (!server_supports("session-id"))
                advertise_sid = 0;
2. In function fetch_pack_config():
        git_config_get_bool("transfer.advertisesid", &advertise_sid);

About 1, since do_fetch_pack() is only relevant for protocol v1, this
assignment can be ignored in our refactor, as
write_command_and_capabilities() is only used in protocol v2.

About 2, git_config_get_bool() is from config.h and it is an out-of-box
dependency of connect.c, so we can reuse it directly.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 connect.c    | 34 ++++++++++++++++++++++++++++++++++
 connect.h    |  8 ++++++++
 fetch-pack.c | 35 ++---------------------------------
 3 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/connect.c b/connect.c
index 10fad43e98..2b51cf09bf 100644
--- a/connect.c
+++ b/connect.c
@@ -689,6 +689,40 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options)
+{
+	const char *hash_name;
+	int advertise_sid;
+
+	git_config_get_bool("transfer.advertisesid", &advertise_sid);
+
+	ensure_server_supports_v2(command);
+	packet_buf_write(req_buf, "command=%s", command);
+	if (server_supports_v2("agent"))
+		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
+	if (advertise_sid && server_supports_v2("session-id"))
+		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
+	if (server_options && server_options->nr) {
+		ensure_server_supports_v2("server-option");
+		for (int i = 0; i < server_options->nr; i++)
+			packet_buf_write(req_buf, "server-option=%s",
+					 server_options->items[i].string);
+	}
+
+	if (server_feature_v2("object-format", &hash_name)) {
+		const int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
+			die(_("mismatched algorithms: client %s; server %s"),
+				the_hash_algo->name, hash_name);
+		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
+	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
+		die(_("the server does not support algorithm '%s'"),
+			the_hash_algo->name);
+	}
+	packet_buf_delim(req_buf);
+}
+
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_FILE,
diff --git a/connect.h b/connect.h
index 1645126c17..8b56a68b62 100644
--- a/connect.h
+++ b/connect.h
@@ -1,6 +1,7 @@
 #ifndef CONNECT_H
 #define CONNECT_H
 
+#include "string-list.h"
 #include "protocol.h"
 
 #define CONNECT_VERBOSE       (1u << 0)
@@ -30,4 +31,11 @@ void check_stateless_delimiter(int stateless_rpc,
 			       struct packet_reader *reader,
 			       const char *error);
 
+/**
+ * write_command_and_capabilities writes a command along with the requested
+ * server capabilities/features into a request buffer.
+ */
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
+
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 72c6a254c9..78e7d38c47 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1317,37 +1317,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
-{
-	const char *hash_name;
-
-	ensure_server_supports_v2("fetch");
-	packet_buf_write(req_buf, "command=fetch");
-	if (server_supports_v2("agent"))
-		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
-	if (advertise_sid && server_supports_v2("session-id"))
-		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
-	if (server_options && server_options->nr) {
-		ensure_server_supports_v2("server-option");
-		for (int i = 0; i < server_options->nr; i++)
-			packet_buf_write(req_buf, "server-option=%s",
-					 server_options->items[i].string);
-	}
-
-	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
-			die(_("mismatched algorithms: client %s; server %s"),
-			    the_hash_algo->name, hash_name);
-		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
-	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
-		die(_("the server does not support algorithm '%s'"),
-		    the_hash_algo->name);
-	}
-	packet_buf_delim(req_buf);
-}
-
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
@@ -1358,7 +1327,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2186,7 +2155,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.47.0

