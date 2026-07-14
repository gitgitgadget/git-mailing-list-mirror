Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A263CAA3B
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029525; cv=none; b=F5xHoIH7b2bEWXAbdZN5B+mtJqZirxF4oyG27j0ST/vRqe4Ipe17CkXOBmqwtyoUgoTj5WErFcfhrGbDQko+z57rm7pghaQg8quZwnel6YdN9JKaDHGjpP60ZStiuI5AgS9qjDJd1WA5WhCpI86lwPVjup4gUQNCVs4bzv3qliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029525; c=relaxed/simple;
	bh=Bnee36W2p94XD3UYp9ZZBSfOSPequOU8Ss5DlFucYpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIR/9rQOMthzB8zrMeeLCGFj8Q5w62SVDdl16gv+Hvj65Np7DbFETUsPwZNEHKZ0l5EC0iEWb1xtTfhoZT3AN57IBblvA+Gmf3JdFvcgvnAIilCKKHrJMafr/IeaY54V6Lti+RCF6FFodtoCFg1qFGtfZS3FTa4BZpokT2zDPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtG1Qg8l; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtG1Qg8l"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493f45e206dso4995395e9.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029522; x=1784634322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gkAmkM6JVkhy385xVgrQ7ee8ZA94lGvMaX2peGSZup0=;
        b=JtG1Qg8lnHaESfAzjb2i+v8s73ePsuMboLFUd2UZ18Z97ztIWhhsr213IvwuK2c/HJ
         sM+idB7pBwMWq4gC5M56YW6SSqoDsN4QbyYJYvH1/HebFL1Pwh2S1R4gE35N8rhWNTvD
         J5c4PO8yAwqFjeHYkUmSl+g/Izy8DTL2U+jVyaPH7PnmsbYzmvnTZA+mDtxX+n96AK79
         aOWCvoxR71+vsZHtS9NRcw1OHUGabw+9GMeR6wySKeZZnjwLoYZTNl8qrOU8pqx4IR0H
         AP/VlbZtxBJb5OxloxYzl4j9rkhUNj4+hcG1YztbCAzQsTD3gV9F5ziJ/k/MgCbS5zjR
         dAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029522; x=1784634322;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gkAmkM6JVkhy385xVgrQ7ee8ZA94lGvMaX2peGSZup0=;
        b=ef3uDfeDvt5Yy13RHBv3Z/o+PEx2DxwINx0u/ZjPyBXDHijRltvfPn+nP1VK40yPho
         fLYPpfBL6pR4HPlEwLJfT1h86F2uk52h1oiQN+iXCmPRyzEV1S0uqCWmDmQGT9GzAs/f
         eCysTgTCMJBi0fZ3py0lEIIhh0j8R14S1ycYEMv4fYrEdWnPwdfIryKzs5Z6XvnDEVLZ
         spMtVzSObzYhIwknsXG3On9J4fpc2s2JwO4PWFnocvvYtUbTVlvx76vEWELnHFcoSJqo
         WNZ9zKSxvf9U3JOPFToy6MSLojlaGKBf32+h4gJKqbKJseyKrITdFRwVRXAiCkjRpQ5K
         l22Q==
X-Forwarded-Encrypted: i=1; AHgh+RrjSSvcHVJIk/lDF7R09Ug/dm8gJc9oki58QWOc2Scz0jYRQQp2Qe7VRcC4D+F3sseTjSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGJOOW+PbN2XXShAQgb107GTs3LS2W8t7WGUB9BxkiSCTvKt8
	iGzQmx0FrZwYywTvt113+CipM+4QvPMOfzD49c2IsgMszo12fiXEwO9y
X-Gm-Gg: AfdE7cmIfR4ByAGB32DAK0IG/3fM0I6znvdj3vtvR502jA6QfFEthNf7XOGLMq04xOc
	zdAhR0kQ8LYZQKXxmQr7C/zua9ZL5XHWG6dXrPZNZCFNZh3QzTmUO21DaHUWzkD0Y7YqLfKofG1
	Wyx+uwb3zy+ak5h1rG/OtC1HChMSu8vtB9Bogi2t4JiO8fcZdVeoru7M7/RUgJ73wbp9PlVJ0re
	DQhRvRg0Ke/gNeUmEzEsjHzBjKxm1ChQEPeIko4vtosN7Af3+yA4bfpy5ZuIPknuB4unj7jSPQ6
	QBzIbdRndm8yoWYvcE8DtOpyl0GnXdYYNXdXxdf4pcTOs0rRF5tPYHYxdefOLbIC/sixDTMq9YQ
	OtTC4reXumhBSY+vcbdYoHRP99n0Vj3+eIBPFMrCi9B2BhwgOOvbgt8rRoD8GhI+kgcxvQng/1B
	k+TFF5YfyfZLkoICL1KcCtZcsV5o8EFWzjz3UJHbGjcE7FiqmwmID2ZjDRODEFAb/NOwHHfiQIo
	Qd71qviGwnVJ3VE+wew08wbUDbuOfg1Vwm1EXamygRHUMr8zv4NhUtx9s0XXa6lW2acQV2dGwR0
	J+cZgEnmxMSXR5o1SsEGgthLl5cDmPNhQXdIsEhQ0rT428a5qJYW5Gx4u2mJjo4zxSnH230L3/v
	PSPGkWLUFvA==
X-Received: by 2002:a05:600d:6401:10b0:493:b698:9247 with SMTP id 5b1f17b1804b1-493f88c71fcmr96332815e9.14.1784029521480;
        Tue, 14 Jul 2026 04:45:21 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:21 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v17 07/13] connect: make write_fetch_command_and_capabilities() more generic
Date: Tue, 14 Jul 2026 13:45:03 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-7-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Refactor write_fetch_command_and_capabilities(), enabling it to serve
both fetch and additional commands.

In this context, "command" refers to the "operations" supported by
Git's wire protocol https://git-scm.com/docs/protocol-v2, such as a Git
subcommand (e.g., git-fetch(1)) or a server-side operation like
"object-info" as implemented in commit a2ba162
(object-info: support for retrieving object info, 2021-04-20).

Refactor the function signature to accept a command instead of the
hardcoded "fetch".

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 connect.c    | 8 ++++----
 connect.h    | 8 ++++++--
 fetch-pack.c | 4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index c09947cc56..127ed4a2e6 100644
--- a/connect.c
+++ b/connect.c
@@ -700,16 +700,16 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options)
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options)
 {
 	const char *hash_name;
 	int advertise_sid = 0;
 
 	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
-	ensure_server_supports_v2("fetch");
-	packet_buf_write(req_buf, "command=fetch");
+	ensure_server_supports_v2(command);
+	packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent"))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id"))
diff --git a/connect.h b/connect.h
index c4f6ea4b0a..c2bf492ed9 100644
--- a/connect.h
+++ b/connect.h
@@ -35,7 +35,11 @@ void check_stateless_delimiter(int stateless_rpc,
 			       const char *error);
 
 struct string_list;
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options);
+/*
+ * Writes a command along with the requested server capabilities/features into a
+ * request buffer.
+ */
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 5e7c4f1d46..783e3474a6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1386,7 +1386,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2253,7 +2253,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 

-- 
2.54.0
