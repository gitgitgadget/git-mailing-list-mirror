Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE7399011
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881019; cv=none; b=CvnRbLdAzBFAAGmfxKummdhzW9MiO8EHk8IzwilKVn50SZk4VrGNfZ89QRtDwRUSV+/cqlEGPMYQ9bn/gd5zCO0RdvUdzijobAS2cv2sJggaGionhkW++tjqjJq/KLg+Ip0TSStrjoJxJF59FgfI8cRI4xwa7bTRtUeYP7ZTKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881019; c=relaxed/simple;
	bh=9PB0zRUU0RKsQVHIr3YJk4WbX0mo65Es1NlD72IHZe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXa32xBShFEEuxF1ItgS57FdbJkmHQVRF4LdcA4m28t2sY4mAeuGxjcIS17JRwnrCWYoJsfHSAPA38GZd0udhjxkz7rVv6PBHCg38aSyhSHUPJ7uqfVfVhFdhZ3s1c/4pN77GtuNoDMqpfYvwG42DV0WZtA0xTN4uF7KYX8FyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3U19Q1s; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3U19Q1s"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b613a17bso17613815e9.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881015; x=1782485815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhIcHomyerMw32bx8DR4I7irSUnGnvXmfp5Cfc2G4ts=;
        b=e3U19Q1sSWYKKck1Sueo53opkEQfvfxp2+Q9SHUWO1D8cUuHzZpGmh00+YkVi/a8w0
         xIrGZcr9+/KTmvyQUNNZcnLG4MZ/ybfJe/kTjG/QWHrn7Rkxs2OCwdwOe1kbDUG04ypC
         hjJkvqRUCogrTis3h2k1FXTE7sKhaT/2e8+QWGaV3xdAjGNx/w3x0jDBx7zv63oPopTw
         0CCubqM8QvHD4s9572+m1s3Pj38ruJCAWvFXIcjagB0V9V3SfUVCyLSYAYUlW0wu0uUr
         WlIUWK0+cj5FxTfctt8FMFGjqoZ410QgouvCXD3/b/7ela437kwNe/OVPyhBCvurVtTw
         Qnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881015; x=1782485815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhIcHomyerMw32bx8DR4I7irSUnGnvXmfp5Cfc2G4ts=;
        b=TBZuwDSR6P2SbEH6EdzGa3S06H4AOE48tWUCcP29Vm4Hvhu1OZpJULcOjPJhv6YAo9
         xpLEwJnJdI5Wz9GZMZmTxDvuo59DO23yG/S3VfpugYhiLtAik7StVOHUbw0i/WXOhhYr
         RvwkjUL1RAEw6MpsndMDytSzG4Fc4VjQT58Cu1BOS5KyDWwRmQpJIPb7oQSJtvEaYesU
         j4hVqvFj9swDJrpwU+x3Q8TjDIMa2YbDKr76k5a5OnsmRtq+WXfIxYfK4CvFo3Y+vikK
         F1bLyuEnfz2X/s+224OiNoEPTfK8wfxB8fhBlbEAoow0ZqnlqZSnqQCOvXmHl/3vV6CN
         79qw==
X-Forwarded-Encrypted: i=1; AFNElJ+505GqQws+abyzuAGL8uIZJfRJAD850EoB0odcPVg6yjKO+zB1lxH2XDV25yDdUwTnP7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9XhNa+9jxQEYCH4X+OWVrDlGZiCFeWAGs24f8adyzwdbXgUI
	aCLgBz5GBUxk5GzLTs19N5fSbvtEO8jFxMUM6HGyP5hGeIajoVHkPAuZ
X-Gm-Gg: AfdE7ckXEDdUzP21t5+07HL7qyPFh6ymldPu+wQZfrhj0b0gZM6q7nh9ARWZYk0idRF
	ptjQQJZmTcbqZGNtnZ6Ubcgq8YX7TqQw9Qs36tsHQSiXE9LXIYraNdVGB2UWy/ydIhNSHKHI/fF
	ZTO9zUwMEJ4z3sY9zKyURHvAVK0XQ9n0EspGtNf4KYPmbUGqEhI2xGFsjajvRhO2godtYE7oOVJ
	ohAhlJ+Cu9Accqpf/GxE4LoeYLMXj67Jp3ykHxr04Thg+U1VoTeB70zBI2bw0OK22BJ7juIH8Wf
	mgYySaMzTF5Zpw0xAFN/o9hOHYrT3yNtA5KFiiQlNpiEtgrk1PjdS048xLMb2cUx90Uxej3sTLO
	fHx0/CC20Yli9GN88WoUpfbEl0wYbwiNi5ku9+xF2LZXtoVvns7wyoNx7SzQ8E0VF5tg/kzK9Ai
	NXuQ1wopKwWb+GMbPffvsRboBlp4zUwBHoKEOO9GYTgxjLzWt8WsKAhKUOxXGlfxrDV5+wSdJWS
	JPKuDiL99M1KQcyppSn+W22hmxnAIXs2SvE/195rY1RWcHjBl8lvYf5m3zHrGQWDBv6d+CiL6Cd
	glOJnfeVJhdEtJ/E9oZgQ3oRqkfVvch8tNG8whSM1t/sJ6ips2ftCD/wEsou9Ef2+OlC/pQYZtX
	rLz2TgzpIeMV/Lg==
X-Received: by 2002:a05:600c:8b52:b0:492:379c:32ee with SMTP id 5b1f17b1804b1-4923ef4c629mr82847545e9.6.1781881015059;
        Fri, 19 Jun 2026 07:56:55 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.56.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:56:53 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC RFC v13 05/12] fetch-pack: move function to connect.c
Date: Fri, 19 Jun 2026 16:56:34 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-5-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
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

To move `write_fetch_command_and_capabilities()` to `connect.c`, we need
to adjust how `advertise_sid` is managed. Previously in `fetch_pack.c`,
`advertise_sid` was a static variable, modified using
`repo_config_get_bool()`.

In `connect.c`, we now initialize `advertise_sid` at the begining by
directly using `repo_config_get_bool()`. This change is safe because:

In the original `fetch-pack.c` code, there are only two places that write
`advertise_sid`:

1. In function `do_fetch_pack()`:
        if (!sever_supports("session_id"))
               advertise_sid = 0;
2. In function `fetch_pack_config()`:
        repo_config_get_bool("transfer.advertisesid", &advertise_sid);

About 1, since `do_fetch_pack()` is only relevant for protocol v1, this
assignment can be ignored, as `write_fetch_command_and_capabilities()`
is only used in v2.

About 2, `repo_config_get_bool()` is from `config.h` and it's an out-of-box
dependency of `connect.c`, so we can reuse it directly.

Move `write_fetch_command_and_capabilities()` to `connect.c`

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 connect.c    | 34 ++++++++++++++++++++++++++++++++++
 connect.h    |  4 ++++
 fetch-pack.c | 31 -------------------------------
 3 files changed, 38 insertions(+), 31 deletions(-)

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
index f13951d154..4a8a70b5f3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1376,37 +1376,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
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
