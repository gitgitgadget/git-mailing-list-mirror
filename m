Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646243E0754
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389629; cv=none; b=HtFXqXlYNuQuLYxufQG+Gb3dxKyrtY4WBbLFaGDpIXE4BhXO3QU3TI1PVFhFiEgxPsBcps8UZJjLqAuesW/a4DXWk25ylH+Mjy//CTT+h6lHKqApifSuf4PneSqNriM/HansBAvppz1ns5IfvLCqe1Bdkpn/uWDJcHEihJ0eLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389629; c=relaxed/simple;
	bh=mnD7xQzDdXg0KyGe+FLlZ59c9SYfKRn1bBoKhVWGDWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPZf8K5yyNWccH0/uuPve0n8df3WLA19vzgzFIbcIQzw2htTJZoUG4+XeLEoG/h2im2oHlvwvFV5NPj1ptvgdSbgL7JcV30e4f+mKjPWpkWgy/jSHI4StqGAyIhM4M2GoyztuGycUoJBa1Cgx2XWXsONDnQ+Pdmfpo0phsv+KPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKDhXvto; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKDhXvto"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ac357c55so18839365e9.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389627; x=1782994427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmym3nvwPVKK09qumprWMxgZO1CzP9FrFL+Glfxtc/w=;
        b=WKDhXvtoVa/zwbbd7jjzCTUevnuColCZRt1tQW+fmlEdlCbWsdVATMIIMYsWCZMX1U
         keCJE8AGYprKRssOI9v0YGSSHCsRhPV0RWuYv1VafJ96MYtgAKVNsC5t9RAPMfrqpoMb
         f+aCZ9T9HMD3lBzEs6XXXECjNItk9chXuI+ngC27kd56nfp3/+TnJQiGuE148zUIkOQa
         CZ9fMWs0cJruRBvG2PiavAlOrS9wft9EFmM/WEN1bx8fB9pQKVODBho+L52rPFg8/QEH
         C+DYsAeygvX0Wa1p+FsVSxTKr1ln8be1ufZ4p/BAgNvA3NZnE1Zab2+J0ijOx/ziKHM4
         z74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389627; x=1782994427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tmym3nvwPVKK09qumprWMxgZO1CzP9FrFL+Glfxtc/w=;
        b=ZWB6Y8XG2loAQ8V/0doFdcf6bDAkmC2J3oGrEakDQHTTio54OBHeeDEs+ot45M3121
         hh0s06Q6wmaZu3+Pidi8ujLLUZ5WA7NDF77ct2cUrLQU4pzIukg6AUbCf0SRTL69VhUj
         MM/XIkLHK9ZGxoYLyUACAUu+FMhc7JkzcfYqff1zsgJYsyAjr3RCwjMxaKb7AEPToG0m
         Fo06Xg7WPz3eZvFIByIljz74LIUocQ4/9+GLeXcJcoRP74LdVc9C0Jv0Pkl8YpDyKImj
         XtZPJ9k94AbDmL+5m0U5ryxWx5Zc3LFAKnaaO3EbW/sdUPBXyfJ0JMqZ99w8baRAj1HI
         RUpA==
X-Gm-Message-State: AOJu0YxIQA4kAT//IvS37BHgNQQsjOzXEwA5ZJoliDqvV+w66G7wBXI0
	/A4VlRZqZg/0KohjYzl3AlPejdQDYwH2brSvCCz/BJQzRuQ7/uqYlmOXNgZN2Ly4
X-Gm-Gg: AfdE7cmsYjQQ/kmZwygTKQ7bVKo6LCxiHNh2ManfG5tk+hsdvSdzNAOpO/zqKjvp6ar
	oAjb1nMe5zQ9iFNSIv3v4mCCkq8K95+tOfR7L0GKdWF1Yh+ZSb5fbPAyjodV8TDQ64eshcmemS7
	r2DdlDS+ViV9RBckvU2eAAQ7L2i61PrBlys5zEkdsMhb7eix7GtGfmoCtUlaawNts7wO45SPA3a
	mtiDwrt4xYYyTlRtiAO9vRw8eZAjS7YLGTNVgYEczW9oENgVzlKShwokgN8PDV38s6hEHUfKRsk
	O+97lW2SNQTuMRUU5VkV7THpJYenqhK96q9EGi4LSrOiLIlBvZZOZeYKSh8zMb66KlzO3EGZ+82
	GTlqSISkoXvA2u74nOlcdz5WeGbqvIE+7tnVY+REYS/rn5YnHTfRYH6vCnyIA9+QBRYO/m6YAGt
	T3FBtk6mkUDiZ9DiNko4bm+Hje21sBQfdbiu4dyjDozkW5YeWWIn370w8lcjukLM+W+2vDqI4Ch
	5nhB676novjy/LNpMo5+xKT4lz0kFGI+4gkRgCldbkECt/mQ07pFH0rPMj1CGyIBRyC8z84LEvT
	bag6cx6StGEgqvJB0ozYzgN9gEFFvDlu3e3vDp27mQdA+dygK6xo/kI9KgFE1oiAaHlo2MzYZal
	m3sandRmSSA==
X-Received: by 2002:a05:600c:3f06:b0:492:32a0:7f92 with SMTP id 5b1f17b1804b1-49266873fc0mr30982905e9.12.1782389626715;
        Thu, 25 Jun 2026 05:13:46 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:46 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v14 06/13] fetch-pack: move function to connect.c
Date: Thu, 25 Jun 2026 14:13:28 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-6-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

write_fetch_command_and_capabilities will be refactored in a subsequent
commit where it will become a more general-purpose function, making it
more accessible to additional commands in the future.

Move `write_fetch_command_and_capabilities()` to `connect.c`, where
there are similar purpose functions.

Because string_list is only used as a pointer, use a forward
declaration [1].

[1]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 connect.c    | 34 ++++++++++++++++++++++++++++++++++
 connect.h    |  4 ++++
 fetch-pack.c | 34 ----------------------------------
 3 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/connect.c b/connect.c
index 47e39d2a73..1dced8e632 100644
--- a/connect.c
+++ b/connect.c
@@ -700,6 +700,40 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
+void write_fetch_command_and_capabilities(struct strbuf *req_buf,
+					  const struct string_list *server_options)
+{
+	const char *hash_name;
+	int advertise_sid;
+
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
+
+	ensure_server_supports_v2("fetch");
+	packet_buf_write(req_buf, "command=fetch");
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
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
+			die(_("mismatched algorithms: client %s; server %s"),
+			    the_hash_algo->name, hash_name);
+		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
+	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
+		die(_("the server does not support algorithm '%s'"),
+		    the_hash_algo->name);
+	}
+	packet_buf_delim(req_buf);
+}
+
 static const char *url_scheme_name(enum url_scheme scheme)
 {
 	switch (scheme) {
diff --git a/connect.h b/connect.h
index aa482a37fb..c4f6ea4b0a 100644
--- a/connect.h
+++ b/connect.h
@@ -34,4 +34,8 @@ void check_stateless_delimiter(int stateless_rpc,
 			       struct packet_reader *reader,
 			       const char *error);
 
+struct string_list;
+void write_fetch_command_and_capabilities(struct strbuf *req_buf,
+					  const struct string_list *server_options);
+
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index ad07603755..4a8a70b5f3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1376,40 +1376,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
-{
-	const char *hash_name;
-	int advertise_sid;
-
-	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
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
-		const unsigned int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
-			die(_("mismatched algorithms: client %s; server %s"),
-			    the_hash_algo->name, hash_name);
-		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
-	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
-		die(_("the server does not support algorithm '%s'"),
-		    the_hash_algo->name);
-	}
-	packet_buf_delim(req_buf);
-}
-
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,

-- 
2.54.0
