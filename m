Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF03481244
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908340; cv=none; b=mG9gM7GINXeFv2bXJUdEwQWMSLia8tQqntyEZwZYkB+kr6iePix1auhBMQwlLnRtGGR2KtR59uA2uG+ah7TrhiaorToAFB/WTMQb50zxlg6WRVCzVTkbjVpmyc453aCl4ouQUqT97l8QF5Zgfp9VLYI0U7+X7Rt2OcOjymwb5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908340; c=relaxed/simple;
	bh=Z5lJcua+edVTITMpxHPJX2GZn+IJAzhuEGMURCheLJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgjAguHGqxMT0t+fUVetExeba2jTNasP+lxxjQPX1ZVCmCGJCVPanjRtIUGDyGkLnwJshDHYfajkMaGoIoO6uBM9M//FCwugRJCVcq+OdujHtEgFICtTIron+IZhdnVx3cdffO2iXwAWV5Hbk2x+IwTASUfp1ZmIPp+SiwUiCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THPXqnMC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THPXqnMC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-476a130c138so604206f8f.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908337; x=1783513137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMQAK9lEFgRoPwe30lNDHpCD5nqHwUuhOnvraSX4ses=;
        b=THPXqnMCw+5q6sEMOrHte7R+c8ERWX/zMqJCl98WTZAE2CQT3QOQ6LaApemI5E7mdt
         Q+NxJwIv3hVtP5dXC2YmnJihRVWVDt97ypoTVaG843Ja5ppz6Jb4A7peGtaRc+J0984g
         gf9hFdRC+bzUZOtcAn99qyt1eM376A4RzM6ClbzbwI1/4wm+NJacdgsXLEF/lXhx8OCQ
         Tu9UpyfuJQL59EvJKrHkeRuDehx6GOAcnN0E/HZede8PM1uIgV3PTn+WakKdmE9ONIzf
         TlDAypGnDB//M0myzbpcw5HvOz4mdDApwKKsRRfMrqARXH/3dM86g0H6rcHTpPjVjy7x
         NAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908337; x=1783513137;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMQAK9lEFgRoPwe30lNDHpCD5nqHwUuhOnvraSX4ses=;
        b=h55sYsuS0MdNK4Y/3toTiCh4OpJWs6U6wUiAt+44HPCgJ94bGac8H4zP8kYm6VIhpO
         gcJFSyUN0Jph3pu+68xPzD4lo3MQA3L3y+T074o+SEwfpE6iZ8x1GBt9M9IjWS7L4MBW
         MWbpTKmkw0W+oyDci4dy6Tcs72Y820OGDbTP9LUM+gF+IS8lp8NXxqRxp1GrGHT+3h7x
         +Zr4Z6AVzda3OUwdgt/ivWa1Vm1edufpzlHpFFrCeoKq/kzrP4LwwEGfWgaw212u4Jqb
         TsSJC54/u+k3iQAbbaVQ7JEUeE4cKIbwmZgNhPvuUMumkCsuNsd21NtXT8BBMWk/w7Ys
         cg7A==
X-Gm-Message-State: AOJu0YzDoQGQqRDP74yEo85bdf+zZh0tTc04IwMS2FB9BoRtpuZaNTcR
	xZ+4bslN33rE6VkDj2G9+sXTt6+pm73VZf8IwRsN4UUKHNfuoV9fDalzH7A5RFg0
X-Gm-Gg: AfdE7cmgLi9p4d8bDDNnfnwog4Kw9DIiVS9L39SpfBKa6BZi1Rrw4+cO7W3wtHyxeWG
	pp8irsu/zvBBCrvyjGtZ+IyK4+4+PfByn15VNN4thnTmSfE1uVSll5hqyvrnlz1FR+EBlJn2leR
	54orafBbgo/fCIoG/mS8R1nlZsxYo+mYep+Oeg8SqIUKa1bfOTesH9Lbin3Ek5CdzhFOLpEQBMj
	Zge8kQp1TMfsP6ANoOuCR/m+uo2Om2Nd82IE09MTmqNKMkCnCDdHTs2ptyIwIFPCkJhnFtZF8Cn
	tyhsiJicaCvnHtaAg9tNcZgl9XG2i4udfOxkxFsGTV4p8YWxdYdXTTcUvNEPgn07Z8ikpUTk8Vv
	gu89k/rafOsIJijNCNvGxbQWjQMtoHq/X1G7iSWUYEvSHxMFOeiOtogWHqAbFQrC4AzH6kaM4Ua
	3nN3vBo44JcN2eMkPy5zT+OXxhDuIBESv6RUsdDmMvb8G6SNz4QI48MSKqYaQdq1yoV+Zto6r61
	nd13/AIY6WAa1XALccsldb4BFYY2iMbrEzTIH0qO6qcADQIXwxgDygU0LZPx5u20koIylCKmHXW
	EUCf+UJ09eUSAMinQlLdY1XCqRQ7W91Yq0FLctYWMLgwm3dfotqdL7XfmUMr5sbJDdvaTPCC4v3
	FPQaHNOO3LQ==
X-Received: by 2002:a05:600c:e494:20b0:493:915b:dc4a with SMTP id 5b1f17b1804b1-493c3cd0f07mr4943675e9.8.1782908336707;
        Wed, 01 Jul 2026 05:18:56 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:56 -0700 (PDT)
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
Subject: [PATCH GSoC v15 06/13] fetch-pack: move `write_fetch_command_and_capabilities()` to connect.c
Date: Wed,  1 Jul 2026 14:18:40 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-6-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

`write_fetch_command_and_capabilities()` is refactored in a subsequent
commit where it becomes a more general-purpose function, making it
more accessible to additional commands in the future.

Move `write_fetch_command_and_capabilities()` to `connect.c`, where
there are similar purpose functions.

Because `string_list` is only used as a pointer, use a forward
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
