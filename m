Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17933F8A6
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300746; cv=none; b=TEjeVifJr2LibwmS6QoI87oSp5ltl6wVQb5qlTdnL35rUkxFi+f6VXdrCn4XU/RkK5BgunJGBYt+2f0jxkJCTjVIkjpblknFkGiIr/Lku1c7Uw0eQQukGswuWADy6oJzfRjNeDqIlxM8i1VKSr1mTNDHm7flrnt0DYpZaj5gl7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300746; c=relaxed/simple;
	bh=zMGubpclZZW8iZre61yRbFMy/wjAmOQp0WG5lSCHZfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWRDTTU6waLS0GiUMoWzl4fSU/W0Hq0N3QHdQdZcc76YOThV3I9VqatQmRs6uE/rHIfil/FRoS5VNWy2XRbjPUMTfjKJMH5YuDAP+DoCqB80o4yP3C0qAbPQgxUvM1AUtQUMLsYWtvlzhfbUL8UEFFyjfdPOq1k2pYRnx3gjgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2nVgsuH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2nVgsuH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so50350505e9.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300738; x=1784905538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TE23DE0uFcsxuvgVX9uZIKJ/qiYNpW4Mwh+7E7GGTVE=;
        b=E2nVgsuHXBMT6RM+wuTHuHK9da17yiOOoIxxpHn2NQQMciVf/0NOt5zkkVTZ65D/UZ
         PYS1JdkA4TSVkeGIiBHGOulcwYV6KUjCprq2H8BpEjN7TOpfqno0brdfsaTUFoHh9QFb
         dKkhNnKDrbDLwubPg8s0HUiEzGnlh9jnEnijb6mkbwvXwkdGU+Noy5DfhKSRWfADrqvs
         6oyxUXnveYFc75U7wHgfrVMGpuv8OUdEytuSnUtzlMqTTVc7Lrk3sBW+p5gFq4S8XggW
         MkhlwPYizQKQg0u1lfeu0BG+PsfzsbHVqhPv0Qe2dxmvdFdYkiq1QwHNC6ZrDQ4R4aIu
         D1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300738; x=1784905538;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TE23DE0uFcsxuvgVX9uZIKJ/qiYNpW4Mwh+7E7GGTVE=;
        b=l/H8t0n8whknT/9msvNNO3Dl5UiRyR2Wypxu5yst/j8PRUH4jk/aKNpBskZLCPs64C
         Czec/YaqI/YEK5/9lxkYXXlliKttIIochAfwp/o2QNFGUsh1jxVaz3OO7FtwW8imIVKL
         ZpTEXBefoPigf1zVN+YlCV/jJtJo+vXC6FesFbNr9Zs3Zvg/O8F0vB/CszDpGlzVvLXO
         9nf+hgHQTCyl6kUjzgIugFC4FPQNMLyfhbXXXcqGQ98w/MsGkviwTdyFpcnisNlCkS7a
         zgX5ENVBuOvvejk1QFE0fwwMm4jtgYgR8pn+Xr3+SUTDDMfq2VqffVNjTjbLgaVu9J7M
         B8fg==
X-Gm-Message-State: AOJu0Yw7I3wkKoJjUpxXjchn7kI9oIG01ukTntDDVQigL6m6vorZCxkn
	gnNh7Q/yQ8oRbS2fmdFJNqy2MkrMjkB48MFVitUo5ato0i45CwqxD4XamQuhlcsU
X-Gm-Gg: AfdE7ckGgJhoO2vGAdc3s3f6NfwsfpMFQUsA/Rib3fQlkAMKQ32uV/A3Py42J4xvj/1
	Aa/H3NsRrZJa7VeU6izh4W9VvD6++Q+6vlZAGBUF0eTL779rSUa/zmEB+AvSHnNWt/TR8lLSFGb
	krCYGafqWahgclCl1j+RJcdB+0LT6SPQpN/25Psj5SDlqEqesxUKPLCFnDJgx9XetTgWEcfavaT
	bBXCyhKgWUDnSoDEFNEYYTLOKR+t9V6Sm51Ad6tsC6fuoR9MGtRrozZqiCVdqwivK7vGUsyA/Jl
	GP3DCb1++AQ829M+KKPpmPYb2k71Le/C2evIVpIsEIWqSak8UQIRYP0UVW1rxbjfTWhsZwQ8Cif
	XNFf6YpB/3WWla7arjjN9j3amvqJKX5Zd23xMHF7qtj4VKoEsrgHpJJa0SeYLHqF/lVmc6Xo207
	W6AIxF7jXlcQfaIO7srfc29dOvL9YgG31X94PM/BNYoVJ/Gv+Sr73O34u0hUrwVwiM/bYmthNQY
	BuLnOo9Opn8xp+Oe/8RZhg0iPyQ4wypbnFe0MuFL8BKjq0Z3LNWJSFxjYNnRmDOSeU/pVflkw3l
	qJ8i6s9HmFrvgJdcNipY27EnhK/mu/HUvww+9rhN7bQ=
X-Received: by 2002:a05:600c:e549:20b0:495:4586:f190 with SMTP id 5b1f17b1804b1-4954a40c181mr27344105e9.27.1784300737383;
        Fri, 17 Jul 2026 08:05:37 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:37 -0700 (PDT)
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
Subject: [PATCH GSoC v19 07/13] connect: make write_fetch_command_and_capabilities() more generic
Date: Fri, 17 Jul 2026 17:05:17 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-7-d4faee35764b@gmail.com>
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

Refactor write_fetch_command_and_capabilities(), enabling it to serve
both fetch and additional commands.

In this context, "command" refers to the "operations" supported by
Git's wire protocol Documentation/gitprotocol-v2.adoc, such as a Git
subcommand (e.g., git-fetch(1)) or a server-side operation like
"object-info" as implemented in commit a2ba162cda
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
index 9d236e7bba..9d54d40770 100644
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
index c4f6ea4b0a..957e5fe2b9 100644
--- a/connect.h
+++ b/connect.h
@@ -35,7 +35,11 @@ void check_stateless_delimiter(int stateless_rpc,
 			       const char *error);
 
 struct string_list;
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options);
+/*
+ * Write a protocol v2 command request, along with the capability
+ * advertisements, into req_buf.
+ */
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index f7789e8456..3695059cd5 100644
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
