Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E006EB4C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513002; cv=none; b=Apz5D1lCJig0sydr/aBi7wGgD4Vvk9sBmwiz39fiCFVhVUDQL2LK9e/FOj1TGlldnwXM5z+8k6HH9Jg67Ze4ebCNoHDKBS2Mr8bqywCGx7YuD7OeIEmBEKJZui6lf+z+AOVuNRYzCFZCkRhvQlxZQ7ygmLfc/ZYrIe6lAOt3XGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513002; c=relaxed/simple;
	bh=eD+Tr+YdcewypZ3gLwFyHeGe+vm1OsLW/dzASVkGy9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnLZdgutFNtBYC+c39EHV/3hjVe16IJoAYu/WaPm6GK4w2dOd3r6L0PVimiVLJCRdmcLDfYcXU3GAbMfoBSWn2GWLyEsvOdwKG0k/pxYYeJr1+V8q/f9r3itaQ6V9Lt0t/jUjLAkUjdl5NVCSqhZVjcw32aiZhM+qdFyVSPzx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2E7wz6k; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2E7wz6k"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b35b1ca0c2so582237685a.0
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 21:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732512999; x=1733117799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXgrxglWf+wocSZ9KYWpP3Qz3kR+LoEHzvxIk9rfM3I=;
        b=j2E7wz6k0yFWljqO2ce5qCNyhXqjNSfMIlGGylBQR1VUr++pti/enL6hdU7QvKVG8t
         GC4BuaHtQE7iJ9DZYHnI9Jo+IxKEvDMzA9++0mAaMpQYPZOubBIL2meVLRvqjCpxbxR2
         3Kuhokf97oAvQCWoOISy9aHw0SeC4hgHf9bMyIMp5LX8e8SXhCo9uEp3SLf3BoIwZlOm
         oc07Mo8R9KTRU06tCRwj2oBwM0zlzOdT/DGGoynWTXIWBfEhOQxRXq1UHQqfspKY7Ak3
         YlmUm6BEo6c94vmPQaZregWeF6Xx200yo34rWkAN7XGcZ7Q7j+O3MNs/Hhj/Z5cFrCNW
         lzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732512999; x=1733117799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXgrxglWf+wocSZ9KYWpP3Qz3kR+LoEHzvxIk9rfM3I=;
        b=paiRdcAZJpAxK87ucTzeK2rTIArbYFGEK+P8dn5zvA69udX45wA9uw95yMf9pUvtJ0
         tJE6EiKGCQzDjMQYu7a2YUU0WUdIdAWZ9snlToLH2rGKuEhLXnnhajQqB+D2MEsQ4srf
         qd4mZkg3FzZnrddzHFrItqrcjhyeYKzrx7E7sFQW6kTQzgjBhJO9gNojFt0pbn3uHtX9
         qpsvOcuW6YfsWjZPJFYSf7L8F8LrpMOPHpgMbBUpgA2hFv96Rhhj+AdmEypAPK5BEkmP
         zq0EHBHOb6Tp1FUkybyi7JyRtmvRgX6nUiD5K8FtoIbRx/FdHEaaqdJjGXG2yrneTa0E
         0p+Q==
X-Gm-Message-State: AOJu0Yw2C/PTjWIR62kDNpo0Pz9erSnhbuCjtrvFyLz1IDS6YEcudbL4
	SEw3fOJ+81YojuvfM8JB9lGFPe0UYVwmgW6+nVjon2kJ0gRx9ZYyelMCYo+W
X-Gm-Gg: ASbGnctrwAL4ClsYikIIm6Tf/mV0lQM0h0o3ve82y2aNE20pcWPoPRP0zEYgzZbFsBd
	F4dTuWitvydpoBDjp+XC91R4tL34F/d1m/bpKVYgkY1hHKqYSTGXgpfEcGTr43/M1Ly1a+Nwgye
	T6TKS2L3FD8B0N+rm8ydJqUb3xENytB/VxvunnbDH5D/I1hmqT0m1arYN87hd3RZo17ePyhnR1Y
	RVRw1tjWLNqZype/u4YUg6/fKkA+hjyu8v/qcZULgGmK1+/IXDrUg8LNvbMYIlgAhGEedEnhicY
	Jw==
X-Google-Smtp-Source: AGHT+IENeAK8EPIjWRg0b7XJlDeSmB8CeYlloVBsHkrmIoXTqSlsB3ep8WHAPfqR0ufZmuQo/VJ6Uw==
X-Received: by 2002:a05:620a:400a:b0:7b6:6fb4:2967 with SMTP id af79cd13be357-7b66fb42d21mr86304385a.10.1732512999299;
        Sun, 24 Nov 2024 21:36:39 -0800 (PST)
Received: from localhost.localdomain ([184.146.186.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f90534sm320522585a.25.2024.11.24.21.36.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Nov 2024 21:36:38 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v7 2/6] fetch-pack: refactor packet writing
Date: Mon, 25 Nov 2024 00:36:12 -0500
Message-ID: <20241125053616.25170-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125053616.25170-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
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
index 58f53d8dcb..5dd544335c 100644
--- a/connect.c
+++ b/connect.c
@@ -688,6 +688,40 @@ int server_supports(const char *feature)
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
index bb7ec96963..bcee4004a1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1316,37 +1316,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
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
@@ -1357,7 +1326,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2175,7 +2144,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.47.0

