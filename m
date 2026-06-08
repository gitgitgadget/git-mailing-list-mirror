Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16C3CEBB1
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913697; cv=none; b=G3E1laQ1mEbq2N9Yot+bJx5YxMe1hH7j3VayIaClVXblb7iUbwjNfO3WUWN74hnjMstSc4dRI79E2bR1F1xE9XpAHzHOXy+LjmcFQYrMG2qTLBWqUF3ezQd6khex8KGt8UR2X6U+TX55pUfySmBEBOH9MFjhR2/XVkFMW7MHU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913697; c=relaxed/simple;
	bh=9PB0zRUU0RKsQVHIr3YJk4WbX0mo65Es1NlD72IHZe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBAINfEkVKCCT7XZO+7/2wythCY5N233gGR+RzOp5EU1r2Y/O/xjRiGqvM+O+ev865FTswo8eZ5jHsUscI/5gpUWDA5cxwVorVOpNAke9CzzfMPElApfO5+UOC1aChKslCGNLXCN5bkwWm7ApMzdGr9JHMoT2/cjnvdLaaKiCKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NteIyYVA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NteIyYVA"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4600cbb06deso2193715f8f.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913694; x=1781518494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhIcHomyerMw32bx8DR4I7irSUnGnvXmfp5Cfc2G4ts=;
        b=NteIyYVA539EwchGBD9Y0EPqZDgPh/v08LoNbE8xqY7XGo8eEX9GvpWcTthIg27NML
         ehPy8YGE/ZkdAZWYpOUdGVXd0S0zORqoiuhRukGTLyguPoNSbufcQbZMPEEfdh534IGP
         ZumqHda/9Nelnd8YL3+px/dqN3vdleyRrBTVK4KvsWpR7dw+dcjgyXbH5MnjfFANpxXr
         DFzL/0326nzi4miy12wxJN1NWXEGVb66xSEn7Bb6xbgO6+pwSUT6cfBT1Qt4yCFOKq21
         jMMZgww2VnJ5wH6yu9iJv8SRk6WuOqepfFEWZPxDyUQySguXoAw27FncN7TCZvXiQBwU
         WIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913694; x=1781518494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhIcHomyerMw32bx8DR4I7irSUnGnvXmfp5Cfc2G4ts=;
        b=sR8DqwSAa37LS0u5KDMrRntj6IYemOX8szmC4oeeazzfm07zGYC0BCq+Zdu9DMLqLA
         H4FnXVf/lBSX4aDxuTtVC9o+/J9g3T/dpv+5IixOqX18zATvW1P9inVBGi2OvaooraeB
         IO5x2EWWioES/73vBrRODCWoxeZup4O22serguNlLjOoxikDBC2j1+w5g+YxgecgqEF3
         XTfTQ/CdyTy8pOgWXncbEGg2YkMtZ6tmAMaxHFIlL5qkYAZRvJ3lw/oH8ZvYJnTLm/Jl
         C6maUEcWdOC37KYqbBi6OtuI8dQqPsNgMOEq8bwpefcwl3WEJhkY8H7INCntfXLhOJKu
         1R6g==
X-Forwarded-Encrypted: i=1; AFNElJ/N7M0O5oJV00haWZ8idlrH1JiYj0tphxUyJzyK/chBuH7cJ6DUMXmXL+Vl+GIWZpqsfis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SFN8zLZHQFC/uVlzNfcgMvDkDcA7CiZBWSiBmcfqGCkZhMgQ
	1Q3G1z0xzEiepbTlgm4RyOoTWZVU54sopMqbYNLYUXV/Hfo8nv0DlY3icPOkkvsY
X-Gm-Gg: Acq92OGuoSh1w68Pk8iTQP/klm6+uXnkZJJ4hrV5dUgWY7fHNMlb2dwUJ2u5SEzqmbq
	cBDPaspyaQ9kaWY05a5aeFXFqjMVHWhKCymfUt9me+0mtIeDInNaHDFF7rhK+xhEwPLFhHXrHEd
	CujAcRsAA3FNIEGRO9ypx4EUv26qZpOrkmlVB84j+ZjBFzwqjj07q/Xd88+d1GJbCiMaB5ykfAo
	/VpSPg/eAi8e2UFPI0Hsa0avb268n5j28DR+qL9XkIJxJOqlYa2qvzDquz3i8XIC3OVDfhA47/8
	A7OcjkcE8JCTrI5Po7fqO3GU4TOfei4402igOPZc9pAJP3MrukjdDIMVqMroIo/ZqZ7+QjYSzdI
	cus5viWEOpnmG36UGoGk2Z8IyXE5sAqtz+wccXQhYfgkx8OnwF9MNtTqZcwBLw8eF/PXcfK9AsA
	EkRJa0cB+tV4n99VKqGvhZoeeB94M9Wl5wJKcALtHXPWSqPjNJaqFm4yPD5+Fs80yyeUwYIRn4i
	r3rJCT33DcyTTj3enbavRD5xGt3eV5xE1doKcipmXU5Mz9poZBY+843wezzOcrwdRC8iuePKRtB
	DPfET6h8Lth2lzL73BAE5XTcqGDopl4mTNaxXYz1zG4t8RCyXrGRUwMHMD3skwUoAw==
X-Received: by 2002:a05:6000:1aca:b0:45e:9520:d729 with SMTP id ffacd0b85a97d-460328109c5mr18650756f8f.0.1780913694253;
        Mon, 08 Jun 2026 03:14:54 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:14:53 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 05/12] fetch-pack: move function to connect.c
Date: Mon,  8 Jun 2026 12:14:28 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-5-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
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
