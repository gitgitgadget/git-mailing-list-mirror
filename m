Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C2173328
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314762; cv=none; b=W7rKaCYV2hLBDvTDEIsDq6g3ktm5NBf/Imm+ppS/2dpqoAoylKvU0lI4YtSsC9mhgXlh9FAwxM9b1MwnpW24ohdThv0ow5y1MogXu6B7y70uRnFwl/w2RX1n2rYoKQPmD12Hpyte9symexwbZ6uJ7mDQ77Rzttt4d/q+tZIMu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314762; c=relaxed/simple;
	bh=KsACjRuDx6DcJcAIhLa6oGueTxSxPsT6XPyPDJ2zM8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rR0y5J91O2qAPxuJPhVzIC1dAMpw4TNEj2Dk92ZoeiTK+VdGjcvDWksmSfToQqJ7pyEIxFSm69J0OkIC8XcTan7xP+FVs5iKignE4Qvl/LCn7WWQwW8bfAB1tvKzUlP0Y0LqHjWIADUBaXBDVbo677dm+Ohb9NbjPrZstgu/2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1bCz245; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1bCz245"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9a30a045cso44275385a.2
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727314759; x=1727919559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRN2sa3wEzWkV5xqjzoSKUq7vgAOTyoz7mEnn9ZC5TI=;
        b=Y1bCz245b/h/4lASsAArmsK1v0nG71VkmrMJJ5Y3o0BU2thTxWaMz6/v61qSgN9Hjt
         5eK/cyX54RcVtTS1MsNLITOC1W4uYyJ848hzHkpoqMLOFZDYD4fcLRmfj7A2k9/tFrAG
         kyXjSENAVEcb3oIRJ0w2uPnUIYdTStUjV+EAhGGc6yI7qhH2KkgUiSV2TVcCaLXwMF82
         b2yrgEwws9IgGSh0jJfw3JnBMNTnWURo84URTg2FzmGmBBwZR6MgNGkFXbBmSsXsT5Rq
         bvPq2zvjJ2Vb+XCwLa6oA1v16uGunfyLf0uObSDHz4uSqlxlqLeQiGphPXQuqLcpEl3D
         N0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314759; x=1727919559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRN2sa3wEzWkV5xqjzoSKUq7vgAOTyoz7mEnn9ZC5TI=;
        b=XzyJTm01eMQdV5QFeEI+1MqBlsT00uY6HSN4wy0a2Pj6d5NJyuYLnY3YjWw0KK6FyG
         Dj7wpPNoEn0ROwI91vbOv9eUomFq12Kcy49JASzdwACDAupdhoAljjNQy/HxXAICzx86
         bjYaqdapJUoN6uRC/8jyUdiJGhBzk7ALrH0C3DUHeFYAsZR9icuZT9+q0HNTkQ97c4Zq
         NF7ED0WFHF1mK6eVXUNafNUtQFMX4AknAclh6y5ZtkG8oW0PJGvCg6wyZkLmF6hOXe9r
         AvlUZ0JgANTfGLvqUwklkDjl/HhTuYfxVa40MEfeA1pqZJphCg3cc+c33KSECXy0dQNp
         6fNQ==
X-Gm-Message-State: AOJu0YyE8BMoevb1uwsHhNHahaL+cgn5QVONLmkqEKnaIJEP+P7B6BeU
	PzpI493CV274bqTA45ClvOPER89A5vjU+tkkEsB6OupVNiMvrS3eFgRMKKwi
X-Google-Smtp-Source: AGHT+IF4yuYF9/Yy4Uym3tuRNxP5MFtD1amnTuWz74IvsyJiqEFJnjud24LV9OuFODoeRi3bYOpUxw==
X-Received: by 2002:a05:620a:4146:b0:7a9:a356:a5f4 with SMTP id af79cd13be357-7ace745197fmr699725685a.42.1727314758851;
        Wed, 25 Sep 2024 18:39:18 -0700 (PDT)
Received: from localhost.localdomain ([142.188.15.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde49acebsm227789985a.0.2024.09.25.18.39.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 18:39:18 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v3 1/6] fetch-pack: refactor packet writing
Date: Wed, 25 Sep 2024 21:38:51 -0400
Message-ID: <20240926013856.35527-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926013856.35527-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com>
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
2.46.0

