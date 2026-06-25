Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D23E1211
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389631; cv=none; b=N4wMAgbhrZaUpanYZJP6Hnmd3L8IiCVMzLcEJlHmli543XXobBwuU7bUlXGC4ZjHOkHsgS7iY4ONrGKLHWHrhn2/7uOrsmD3k3GUM7et8UWxCXPjJbz0KeKpXsh95pt0xPP42YeLTppq5yYcdXkJJ7FfylfIlUq7cEO3nbYM8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389631; c=relaxed/simple;
	bh=dI1a7upTI/ShAzrpsI5jXFDlt/1om4vNZM/1VUYVrP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0mywu8bevTFTFIa9M+nVo0Bd5ZT82QCGog++RNCNmjg/iKuYciAF3oLA3pVLo98ivXhEiP4SqOHWAP3sekBAIR5zvGVRujx/9+hvh/6bQoWOeUsrrqDmqpABpEP+O2pkVJkC1eVJ/A5QPF/XllCyRLd4Sh0YlyWdQF3N9X03m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9ILp5nX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9ILp5nX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49241896317so10052495e9.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389628; x=1782994428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7CzHEfJqZsnxjAC0kuMbHI3AapCvToRZt72r91hUWs=;
        b=V9ILp5nXGlFcduEFEAN6Pk+g6esEObZ1oFKxYDTI1Zl0+vkDJ8mrPjxxtEmwJs8Jwq
         B0079dlAvdhbhyCCmMUZ6eXCWhNLYzVTg0K7efmZ0ltVApK1eE9XGnWWMzBTrV0dIrMo
         2DDGnM/+VOilyAR0+/hCmsotshGhVI8Qh3oB/bgohI/DhuDXj21rIK+rakiHPzCoqJfc
         Bd+s8uodBr8kbnrVZBP5Bf+h1ImdI+/5MdYfRrw5JAEb3xAU6AxVR8oiEGxNJFVrVHBM
         UbAm5UpkdsmpoK7HQK5IUL9H5Zv6mFlkb5vZN8hHoXUsi9PUQItBK+Md+2S/gQOwZaUv
         EwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389628; x=1782994428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L7CzHEfJqZsnxjAC0kuMbHI3AapCvToRZt72r91hUWs=;
        b=gk08vmHvWnAPL8X0c96bPTzl/OtP58mjBuyAjm9DlSwgfccxkVOVubP9Ksh5QTOfXq
         6F3io2k2g+PI7YnUJvU8W1RS8J1U+y1OFihvfsTvwMoFwmO6rZ8tFUcGxkpJOtlGbjDb
         q/kG3xVTyjjMkc3LBOo8uxHhEc/Gnr/XHTTEtLXTTYSPD5CD2tjPjX9avT+cHwF9Pe1n
         LZVR/adAh7ql1TCiytFRAtny6+7/s8i7Uos9I2UHM4T1MXYSlZO32x8MMxNOAqM6mve0
         LDXHm1eZYSmcvfHUOgxwiqey0Crz/AwWB4qaYNTkfMO5GgKhW/hR2RECTmuVLFF9NLol
         3gHA==
X-Gm-Message-State: AOJu0YwRCBvefGK4HEtFkFU2H7PIAB4iDHi2Cl4MySuCDfiyge25iP+n
	UiTYafjBmCjNyGnC1Ju0YX5j/MDMQk5hNLO/PDoVzqUmA9K6aAWXW7vLAoR7pumt
X-Gm-Gg: AfdE7clNZcaYeWynXJaCfyZl9FFEe6UtEyeUvGKz9ZKN4I2xJeGF6CqHRKP6NAc8KUH
	cb2x0fUd7mNiuH+mjznQeL3ff8xVaeyzpe/1eUdmgVEdKQR7vjd7UFcMldFILomF90lbIIDDzn9
	/vFiS3FaA2pRdU5SsMmqml4kSoUHowNUqe5kbI+K7JgMszD5vY994jsJXAsribgkgAG4Of0Sj/h
	lDiU369JnMe+5gJulBGxkhPaSbnIaZjzSQAeJP14Al7xxyD69gVfN4J+EjQtZCtOWgzRWKllM/l
	dN1tMIhaViRu+975nfFGiQY7LC8Gf4cPI3bSkT25jFXG7v1xZ3hamzBG2857Tt/ddfzzW7QShBu
	OE6K20GsIiKSY1Y2OinDCK63/NHozG/aRcWVoqeCk2B/tDDc8F9qOT/t+JzWxwyv7O69s0PxLMV
	clI7RYma7wLKXTVidfnFJYdihdbegW6s9SBdYuovfNQV1jDFW/4deGIEicdGfCpKkdzBvyTK64w
	yjagJ3jDgw9cQxlMIhQ1KpJ2Oxw6yHvWsFO1ah2/7Jj7xW2s1CfV0w6r4adhi+ImWvb+8DLiQyi
	E1t74AMZIDzee0xZmejxln2iEdpHKM5FB10jLoPgSWFhmc/ACvENGBsUWCEgCKrOtQqCPMrUH1p
	FNNurxkG9UQHeQaBCSNyi
X-Received: by 2002:a05:600c:1f91:b0:490:6e12:542d with SMTP id 5b1f17b1804b1-49266881932mr25187535e9.19.1782389627911;
        Thu, 25 Jun 2026 05:13:47 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:47 -0700 (PDT)
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
Subject: [PATCH GSoC v14 07/13] connect: refactor packet writing
Date: Thu, 25 Jun 2026 14:13:29 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-7-09f7ffe21a53@gmail.com>
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

Refactor `write_fetch_command_and_capabilities()`, enabling it to serve
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
index 1dced8e632..7b472f8e5f 100644
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
 	int advertise_sid;
 
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
index 4a8a70b5f3..3d32114907 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1387,7 +1387,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2255,7 +2255,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 

-- 
2.54.0
