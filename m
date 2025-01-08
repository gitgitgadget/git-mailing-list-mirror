Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D51202C43
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361484; cv=none; b=EqsJh7SBqsddNW/hg1t4bUaa6tdAfhumITDaagQz1mfAq1K/d5W6OSqXB800khRPAp5bi6PJHGo8hBnXk7gsa/aaj8Ejt9+dxRuI4B3CqORvgi3ZFiLdpeeqB311dsYpw29OiVUfC7H1hvJ3YdOFkSrUcgeGpzQVsTQaIDABSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361484; c=relaxed/simple;
	bh=U9/DyBi+NftKREWco74mHRab48WeC/WAjVhbOLWAFek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtCOSKD13UUw0hJDkwytSESaZ8j0lg8Skb13Tt2RDwjGgDoMz7I3a8OwbTeCbLTHoCiA+X1zLXQxMX5S8u5qTNzBH2Dq/zQu2jqbLbooz5bw+ye3l6XNKCF3m9WNJne6TBDYeK3qj+g/CE7JhNAgLNBpBhqHKzCa5GMIpBj664U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtNt24NA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtNt24NA"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a37a2a53so189021cf.2
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 10:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736361481; x=1736966281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taJPcW8QU2LxZOovWt2m4TysQWnS8cJZw2EpQbtPYEU=;
        b=mtNt24NAmOmNopTfjJLP6PUZy2+wEhpwVebJ/2ueDi791KjvGTmcd5hLLfFvQ3fxOB
         t8qNQ4MHMZRAHDD+dg9RBox8g3oZ2fC72IiPdCzfgJZMK933P6LSSwrk2pI4vlGj/1dH
         xlBsUe594vTHQuet8+lrROr5xpR7D4/uUqd7wEEYuAQeCz10kQvjD5NrxwBHPKmYAzqp
         mNlcyswdg0rXs0LTjyfPpxblu7EJMpSKRLJf5Yq8iS7fT43P6NXcOXSwiORDi2px1p4s
         WRzrozivNHoQy0nzgvTIANQk34ft2e6zOmXw35msv0BsxEeRS68t0iQm4tqWofjdN/QM
         HCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361481; x=1736966281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taJPcW8QU2LxZOovWt2m4TysQWnS8cJZw2EpQbtPYEU=;
        b=oq8mpIiUOCnVBbVXDIFTGp1yDCTzdhCQEI6vRpsthpavPP+n5KSA4O9buY8aDegFFT
         3Qqdw44uFJeYtwtVmh+4JpL8jtN7vm7lRHf5nsO4oWU1maJ+Rr5y43K7LN6ycn5c3pcs
         W1zMmcXG9YDM2g5k0xvm45kHKToJJdwLoTloiAOlIM/IHJs0EwpHqkaY1WwjaKqUlGrj
         0fy5OaSQPJmDXCcw8afbC2SD5mfwnwdNBjFyIHxJDIfYsjKbaUZSlIIoYiIo1f8elCQs
         JSnHUw1tY+AjS3zg84nFbj9TU+ZrXXdQN7eSaNKskEDdDlpRuAtK7MvQRuB18Yby3ViA
         r48w==
X-Gm-Message-State: AOJu0YxvH2E/wrg/03Hx3XQ2nMQp114S2BupExhQQQB3HWM+2/G3kJLO
	f63Or3Jpi2lCCeq3qfgIg2NdvWgbbWS9koz8gB/G/OAvEatU3g/HBGUkdxpd5Zs=
X-Gm-Gg: ASbGncvhXMbTcPH9rnodMeNSklZ8DsSlPnqAZdru5GKqjIw9HsDPu3iGU9uaDIMxtUh
	UHbG57CUoUfOdEvNy8B1Xy/DEojZSetrAhL01DPe8qUXnDSjRECXlkwS81jbJpBXBxrpNbXnZNB
	YLZyY07VRU9oY4iIL8IfPxGzEDbsYEUVxiIgsl5fd74wHeIWYnXP5q2VjkO6A016VAxSeqhhQ0k
	hd89osnFpjV7Uz2zzwIzPVyC4n2exwHxtO0G3tMN7zmxeLZmL4jzD1jb4mYm/2WQdGrAvukpEGs
	6kLplOHcug==
X-Google-Smtp-Source: AGHT+IFBpXbbDlnZUysVsxTAHMkPbuNgAsxABkvujN3k7fHJxyo9RpQe3wZjXOYrVwQ4XD9KTNIlYg==
X-Received: by 2002:a05:6214:e6a:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6df9b2d0aa1mr57818306d6.38.1736361481254;
        Wed, 08 Jan 2025 10:38:01 -0800 (PST)
Received: from localhost.localdomain ([184.148.194.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea74bsm193228036d6.25.2025.01.08.10.38.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jan 2025 10:38:01 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v9 4/8] fetch-pack: refactor packet writing
Date: Wed,  8 Jan 2025 13:37:35 -0500
Message-ID: <20250108183740.67022-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108183740.67022-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com>
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
index 10fad43e98..d89591f043 100644
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
+		for (size_t i = 0; i < server_options->nr; i++)
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
index 1645126c17..d904c73a85 100644
--- a/connect.h
+++ b/connect.h
@@ -30,4 +30,12 @@ void check_stateless_delimiter(int stateless_rpc,
 			       struct packet_reader *reader,
 			       const char *error);
 
+/*
+ * Writes a command along with the requested
+ * server capabilities/features into a request buffer.
+ */
+struct string_list;
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
+
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index f5a63f12cd..78e7d38c47 100644
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
-		for (size_t i = 0; i < server_options->nr; i++)
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

