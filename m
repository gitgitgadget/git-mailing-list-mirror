Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAD37CD31
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300743; cv=none; b=L82mrlCfq9f++NSmVq3Ct2zF/bBB4QI9bgZSZLvxSKSNeuoHXdfPHzinZd1Jw+D6yC0Gtmw065snL6hn8R1bilD/eiRGV+KO47CfZYdjbGkGR+3Vh2ZWS1yr1tNNKHGi8wU7FsK+wSf33TgfT0Ahe6lPWxNIxl1QI2CIkmzvV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300743; c=relaxed/simple;
	bh=E2/kpOYqtSRq/fFCVKjSsPeuJErGkrtwufgWuvu7OnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGEBQZpZeJNRHvZsGyWoknZNmMsIoM3LmsAFzIfHTCIdrJdww34bXtIjnTpAFUmfvqiMxukzbqlGs+jpaPWHv4btGl4RlQQOAMjLN5X/IzcFdfzHv14Dkebs+sEycDsQDRgzVDSyiYIpKxYmYtdlGPGNoe6OhktL11ntWLgNidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OM/Amkju; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OM/Amkju"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495437bb891so11846465e9.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300735; x=1784905535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9n554t8qNyHpbYehSPUIk1XoJ0MkDjYymavaCMPlZXE=;
        b=OM/AmkjuPHvy9O2AOEfo4o7r4ZF6CzzLimGvWY8Lyl1J3V0djPv7E0gjtob31h/s4O
         GDkVCxUcyLk8D/KGlHumC2nasRjrcxYb3nbD39tMzrKmGJfosTiCjZ2kv1Tsa+U/Pldr
         Td05xHfRcShB+XpO0EnVk9APn7wx9uiY+5Dy0MeNx7fWaXREsLuJ93IHMxwwySUyrNQN
         QjolMGAlFFbaPIlVKxMt5u70Dboobq0oUdj2b2e1GWZ/fDFemFFJBVUUt5tdLWxJxH2+
         l5D7iYfGqWk7Awj+WDXFTid8n8Bslzdyh8JMsbitMDE5feScLtsE7aWXtfSNycFTp0w2
         7Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300735; x=1784905535;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9n554t8qNyHpbYehSPUIk1XoJ0MkDjYymavaCMPlZXE=;
        b=oVkCiJaMGnpY2cGzlxm52nX6tmzFnREpJx/za9x5UIOyN1Q4dmOR1V7HNY5VlHC54u
         HZRFRPYyjWq50dsfbTtDl2MKsTnGqf5GOGMoUUIa9fxdygsqkuoV+AC4DWiJQFq47Bdv
         7A/7UUUXkgXXo7YgoM64cGq4ToZaNwha1pkbZwfVE0OdxtqZq6Qwc7W+87F8x0sWESjr
         J1dC1DWDkYLGpEaEtZPqvbAZ60BpS9z8dU5HcJTFosEDA0faaqpBScrMICHE0flObd/Y
         TQH+zp7nliyJW48WQvS2+2Pax5f+14NR5HPejpbTNKTDY6SNuEg5lcmKxmokRwYMpbhI
         XjWQ==
X-Gm-Message-State: AOJu0Yzn7qzvJ9/YI1tyBkRwVEMo0NADnyeCXKcJ9DGz6irIAPqDeCqE
	SsZKuyPn6yblxZYl2qGcjqgGdaY6WhecfrA5M/sQ5tdRWmSpIaT1cWHXKmUejZAY
X-Gm-Gg: AfdE7clLGvWsatXq3UKoPoEUClWyvA25WWTRnCApIGttkng8IGnMvqf2wfKrQ0+zKvC
	E8TnQjcXL15Nnw6gxcugYDqrHhEXVjCupSH6pxDt43QngpxuC8Y71vEbwqnJ40St9uN9jyPO3XT
	SCPaAJnU6Pc+xwxzL3y1GK0k0lJ1siy1IAcqgVC2PGZ51bikeSDJElK4zX25KeNcK3O/4ggUJp4
	3fcLjR8WYl+vrpprZQIDpYbxuor7eDAysMw/hNOaR01XB/Ge8CfvYKAP9mA8o7Mx8iZwkdu3EUR
	QQQJA+cWDYhNiaOMuaNOdOz1seL/pRwNS2tZpBGbX8KC1PKr8qvywKRFTb5kU8bGJXAMbZmdawj
	jvNeRpr2Vsb1z/XAlAvvly+qxDcWlMasc0nuve67A4fJnytMs1LbdmJ4jo5yp2udKNdBt+wZ6hH
	h6Wanb723Ys3VOInx2pSQLirUolgPFNOwOK+9Le7x87KE6pbwXW3+8EyDxSo5r2dlJlnZOmFlLX
	7ABhl0G3cLwu8vSDe60x72y+eAxyki7sq3sDLsybKRMq+Ri0JZOm9UMmhQ7b/Kq50pB1RDZXXTj
	W3JP6aSSY3H7jg58RLFWyyM8yla5av8Z
X-Received: by 2002:a05:600c:1906:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-4954affd764mr27192025e9.2.1784300735150;
        Fri, 17 Jul 2026 08:05:35 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:34 -0700 (PDT)
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
	toon@iotcl.com
Subject: [PATCH GSoC v19 05/13] fetch-pack: move write_fetch_command_and_capabilities() to connect.c
Date: Fri, 17 Jul 2026 17:05:15 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-5-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
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
index 47e39d2a73..31e5ab958b 100644
--- a/connect.c
+++ b/connect.c
@@ -700,6 +700,40 @@ int server_supports(const char *feature)
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
+		int hash_algo = hash_algo_by_name(hash_name);
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
index 65ebfec09f..f7789e8456 100644
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
