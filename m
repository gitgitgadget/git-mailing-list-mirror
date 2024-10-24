Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744ED19E975
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803283; cv=none; b=NccL2og/z3AhHJg0GLI3P4aErXH9rV9Ou24QwW2APmyCaA+D29r4DYROmIvVrbS76PPD5x8BWIPe6i4tU12VwHnjAlALJTS8TuRXcXjk315BNEbwwfFZxFQW66natm7lNXPddEVtU1dYgUzECsfVHeCz1rfQCuipB+tDvBJpHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803283; c=relaxed/simple;
	bh=xfSlKE3u+S/Lb3FgOzYpMWPEVbEtg3OWQY3zHW6Lzfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=et/lCg2Rlapub0L2+0xgZ9miTch8j12A24s7KdFmq+bdOKg36IO5SPHxorCm1yW3reYKtpm8bdWznYFrY0GuUiAdHfEMGmaChz83GRCfzpCk0owD1T41WXXRyoS5zym0b3uWxIrcg72DYW7pyRsA6Kf+NQUqDfnWrwJXRxY/8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UljxHAoH; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UljxHAoH"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71850708dc9so929902a34.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729803280; x=1730408080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZCysREDb1/i7PwjtM2OwhZvwSKAcX3LDfTYITGz9Dg=;
        b=UljxHAoH6L2Lbt4H9Qz+xSZEMT6nfl2gRMRtcKj/f0DZ3m069uMbzXDpftUeXiaHYp
         +KDktIOH7U5MNn014EJAJQtEY0l3+TTWmF07GxdVJBVOV1+lZZPpR0HzK2bJRGxtyMO6
         Dqch9X+Ic2QMgkRQH/qUrj5HrEhhj9MRSpHjN09gHlLm6llm5o6L9YIApYpaiQv1b390
         fJWX6Q+LVkLAiWwETOnSGa3K6KgFUtwJX6Xxc4NNnwDT5EYr0tLduGnNhMXw38E6ZEd9
         fcBZSEuo1ujiINC2kMPnRBTL+UzPAMcYVD5zPebfFgc/xt/6ydjm1O5STgTPMswxcFal
         RYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803280; x=1730408080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZCysREDb1/i7PwjtM2OwhZvwSKAcX3LDfTYITGz9Dg=;
        b=cUWDKLWRLSHjvNmyQ9H5bpVwDRmonF9pZxdQMX41r3t2+xW6kDMzttHe+rCNym/csx
         QK+nOepdQAD1AxOqQcNzz7PesRBjrQ7+jyJ1fSPtv4Nmwc7dojc7tn6dJNntEAlVukFE
         wsEqJfsUryTFPbZ3ULfzyk9pPiPFa/4hn3MQoNfyGN44uHAK5J3casELhlygygDNGVH0
         aSGhhVFNJREewPqhlvriE7mKTIMS6OD9QKaYiQsAEVXVGVy/pBwxbGpGVnbVfiev+gpR
         hnTWwrVZL38S3d2H4NYqhtwzelwHrhEnEg0Lr2icobJUIoExDzZKcYlxRzu4MPk+uE9K
         KotA==
X-Gm-Message-State: AOJu0YxL/GHt23Qn1w3DlJMODpXOwUHBEsXQmITIXrak/r6UlSaiWqMj
	IlT65B41LIYhovyzq14Nb8xnXKLpcqe8pyXzhBamKaO3ljFDoeI6/yxMrh94
X-Google-Smtp-Source: AGHT+IENDC3pvK0zd1eL+V4q2m/mi2+8XLleS7fN+21uwLJRHXDlpF35ZtGnIZP2suIROsf5wQDiSA==
X-Received: by 2002:a05:6830:630e:b0:718:41b8:5d6d with SMTP id 46e09a7af769-718598bd022mr3779803a34.24.1729803280315;
        Thu, 24 Oct 2024 13:54:40 -0700 (PDT)
Received: from PeijianitLabMBP.home ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008b951esm53421556d6.22.2024.10.24.13.54.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Oct 2024 13:54:40 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v4 1/6] fetch-pack: refactor packet writing
Date: Thu, 24 Oct 2024 16:53:54 -0400
Message-ID: <20241024205359.16376-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024205359.16376-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Refactor write_fetch_command_and_capabilities() to be a more general
purpose function write_command_and_capabilities(), so that it can be
used by both fetch and future command.

Here "command" means the "operations" supported by Git’s wire protocol
https://git-scm.com/docs/protocol-v2. An example would be a
git's subcommand, such as git-fetch(1); or an operation supported by
the server side such as "object-info" implemented in "a2ba162cda
(object-info: support for retrieving object info, 2021-04-20)".

In a future separate series, we can move
write_command_and_capabilities() to a higher-level file, such as
connect.c, so that it becomes accessible to other commands.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 fetch-pack.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f752da93a8..756fb83f89 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1314,13 +1314,14 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
+static void write_command_and_capabilities(struct strbuf *req_buf,
+										   const char *command,
+										   const struct string_list *server_options)
 {
 	const char *hash_name;
 
-	ensure_server_supports_v2("fetch");
-	packet_buf_write(req_buf, "command=fetch");
+	ensure_server_supports_v2(command);
+	packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent"))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id"))
@@ -1346,6 +1347,28 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	packet_buf_delim(req_buf);
 }
 
+
+void send_object_info_request(int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf = STRBUF_INIT;
+
+	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
+
+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
+		packet_buf_write(&req_buf, "size");
+
+	if (args->oids) {
+		for (size_t i = 0; i < args->oids->nr; i++)
+			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
+	}
+
+	packet_buf_flush(&req_buf);
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno(_("unable to write request to remote"));
+
+	strbuf_release(&req_buf);
+}
+
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
@@ -1356,7 +1379,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2174,7 +2197,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.47.0

