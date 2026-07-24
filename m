Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BEE3859E0
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890479; cv=none; b=GBnwKL+GlyTliexQ5iILm75AxXWFAuGLLPmDXoN+eYPAh+AQzAEETkEJGYs1k9SB6s1T5hHTKvdqn7cHXGZfF2dbHnIWonf8Gbc4X7YdZOPcwNRS1dJLbelZYcqBvVcHxOd7tQ5hn7VEsCbQ/QQ3W6PyrIjU9CxWiuCmH8loSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890479; c=relaxed/simple;
	bh=m/hoCN+tL9c/d8e6B4ufk0+bKnclhUNFKlZnXS3xMdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOAQgMsCxj392SuDRQAAn6YOcosU4ic5/Pm/XZ1IaN3HsQDsyy/O1Cem6RVC5TQ/of20R0GozkZRogIE6WY5X5xyHfe72brrEC/z2biHDuO4iaaCtXZJek0OVLaTdzm2fCiu7UfDTsqRNe7cNlI8xV5n5GIYeiJcCXluW1Zkf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP6FBGkD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP6FBGkD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49558ce01afso2635485e9.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890474; x=1785495274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0S21+yeFdgc0y93qB5qfnRebYCzqFjkIpeJPnHjN20Y=;
        b=ZP6FBGkDERIda7sz9Wq0eyhFqmbhoLE6DrZZjsXSgDHJAC6q4Tu2moJyrU1u1l0Lu7
         lt6dM3QnCfoL3F1Pn+2UNFDGZbSkl+G6dDkuQEZFFwU5kPIBniLVJ/VFu9/iOOsOwVrb
         JVyXJ971b6o/+IgBz4CIugYs8UPcW3IWPOCAbEeQDclBm1OsXaFZmcm4/F24fbtluSZ9
         MD9N8Nhda6CLO5LukYWLeknLGwBsOHMoz8dk0/a68GWuzqG89KlNJhv6A3Tc7LaRvqlP
         tHitFw0npwnnR1owuYghxyaAA20KmAbYZ0SqZB+EwMv/s8OsdON3XCakHk4Zf6bqHfRq
         l1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890474; x=1785495274;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0S21+yeFdgc0y93qB5qfnRebYCzqFjkIpeJPnHjN20Y=;
        b=FzQCjHnSmhn3SrkBl17/+8ClfL75M6metHDvKEy+wLyEH1OU07j1Xm/zBGfW0WKNgs
         4GK59fU/CXGW7QZKdaTFRF6zJO/OyVle+4u3UZObZNUBMiJyAuPZlaDkU+J0FrTztsVZ
         s+mPvsYCvY2mNPBcYEe0ZEw8XrpvewJIiZIVy8SowpbkBm/qohCCm4x4dJnwcE6q6gil
         U4MKfuTImQ0nFpP8WuDf02kTA603gmfe4ElX1VgtXPanMQjTv8I7IixmpR86L3KCHB/7
         dkImc9at6aOaMEPqxkABFEfHkMOKqGuhXvRt+vDEw08+1p7xyi0KrRfb8LcD41oXG446
         YJlg==
X-Gm-Message-State: AOJu0YwDZIZ3J8XC3n08iaMgHkkslWAhP0DtPSsYGdBtTu5iu6YRhXlv
	0GqPAa+FNWvb36kNy1a3becyNu0IdbmGz2y5XXh4T17iJdQgIf72U5+C1dqwFU07
X-Gm-Gg: AR+sD10xOhx7Nkh/ajHsi4vcBYBha1IspDT3wzjOCR7c2Rnc6QsBvDFYtwmcu6zi1KJ
	NrZvYpn0nA45VXgZl7iuuG9F712mvtcS7ST2V3j5ojim9wcj+6SNJDrOR7ju5xk9+U+8N8MEfVN
	FEEWBeqkmLjWKUE9ejg9ApGXY5QRk7birK81c1ZCYrGVYP9KlGKCbuZ6XkKmL/XLW+Ytniz7YxU
	tdduukwYK0DLgEmk61T4hwhyoipF2T+l3qbe4p7l/0e80Mae/kocVFaZY6AQ4Ij21E08VXrHGOI
	PceXTnGFiaOnu/i/OgkOgO3DicrGpYYx1PIHXxQAXznbwBga9/jIi3aLnVCsjfa8TzyEZu3K79m
	vSlgKOvofyNGd4P8pGs6KH21Lg+O10kG59gfucAmn9+FKaZJGrI2kXGGXRHb9zX7YXse+X/0eAR
	oWxjqvpTmULzquVu8WRjedb502KCTcfupgP16JtrOWW+RwggAsmuZeSgvkuWtzXs3JFKChTPIMY
	v3ihWEIcx/kaStfwpWN4Lg4/y/ZOE7SADmJjYPTNRcdIgYxCFvZuSItNTuJ6ipkymFApUVlJmsF
	OXnIIpCcUlbV+ZkmbSQmPe8TeUzHjdUorqRb
X-Received: by 2002:a7b:cb83:0:b0:495:6b55:f938 with SMTP id 5b1f17b1804b1-49573cc6d02mr54149965e9.10.1784890474390;
        Fri, 24 Jul 2026 03:54:34 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:33 -0700 (PDT)
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
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 06/13] fetch-pack: move write_fetch_command_and_capabilities() to connect.c
Date: Fri, 24 Jul 2026 12:54:17 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-6-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In a subsequent commit write_fetch_command_and_capabilities() will be
refactored to a more general-purpose function, making it more accessible
to additional commands in the future.

Move write_fetch_command_and_capabilities() to 'connect.c', where
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
index 1d74c1eda2..0d197eca84 100644
--- a/connect.c
+++ b/connect.c
@@ -709,6 +709,40 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
+void write_fetch_command_and_capabilities(struct strbuf *req_buf,
+					  const struct string_list *server_options)
+{
+	const char *hash_name;
+	int advertise_sid = 0;
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
index f1e64160fc..f7789e8456 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1375,40 +1375,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
-{
-	const char *hash_name;
-	int advertise_sid = 0;
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
