Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409FC132
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721447036; cv=none; b=FO7kjk+1+NjkaCIU5e0bH/DATKQs/kl5rM4LVUYabQQxNvh0D9GK3mB5Ic7CMU2fHrzq999Q0P1uPivng73jh1ADLk3I/L6uaSX8TtdPhRDB2d5PCAr5z47xcP0FBnd3Bez+QCrH5Uof+cUysx8TXhAwcxpf9+GtcWRtJaDctNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721447036; c=relaxed/simple;
	bh=68J8rWZytDNPK2UF0u450YUZZpabXDXIT8zbqD/y5nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FStV1OEC+oX/kqKTEhjIfJ3+UhPn3wz1Nkvuwyb6mwnNmqZ0sYvqqL7qBvyk9+ZF45vnBwfbMPd9CR9TpHS3L0CNQYjJdgr8awLRiS7GKLr3uLz8Jj8Xvj+/WE96tQkIvJFIElSlms78UPD1joYAjC7N0n31Icoyza57N81t5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4xQ3Gh2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4xQ3Gh2"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f323f084eso135294385a.3
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721447034; x=1722051834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJvl9xkzpCuXEpujzmUrficdZxEe3PBklsEQh6bXZKE=;
        b=S4xQ3Gh2FExdgy7YnC1biSNfyaX7sLWj/CDSNmDhiIa4sgzGKG+mpDi+7fmOEGgIte
         +L8XeKebeo8TonYYd7y2gAEhfhxk8ieUVoCiC6OPvb6aUEHT7Fky0JS3FOMTJOHJmo+L
         NSHIxHnNUFQS3m0lYvFR/B68/NoKs8MsulpIc5cs6tjiOSA5QxI6UgsRGNmkE00buqQD
         QGK2FipRFacY5ymeD8a6X/0ijtKV2/Hdfw5cy38sj00qSc2D54qoLUxsQHfTtxOc7wUD
         F179Rto6V+L7ijNXY7ApjPjno1UT+DYJ7IRHnE40PwMeqW+Vymp+B8Aze5Fa1HPMa3WK
         kLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721447034; x=1722051834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJvl9xkzpCuXEpujzmUrficdZxEe3PBklsEQh6bXZKE=;
        b=MLXL/QvuUbY4ngnWk5Oufll4lT7LwGJsFwhife9rCdjwQBKmvqNgiuHfBNnUEYbwwB
         M4xwGozNVNcofpMZcGZUJMaFaUHUkX6u5UHtwTB4taPTAD7yiqIPXVOgaWkuLDbP8qfp
         CW522cPI2MDwKSreaWhVKcleNC51tRsKuxrFS0dggx1yfwhI1/o4/rLNRffmnHbwkXwt
         /zRBCYV996xbaqEtpL3ysWHcoiYo65xMl8Mkq3hH1ExVlU7+XnuhWkTv83VMbtoC8fFR
         9DH7h9DYjILJPmjT6/Y9CoiGrV76nlSlq9RhuHJN8ZNqHnh14WuIzRgvoU/nxiD4ksaf
         VnNw==
X-Gm-Message-State: AOJu0Yy+XeWWWRE488qGX3i23htlPHN5pNzjlPVKz3L5ll7x0DLXG4Ag
	Vz1xxwByWcyHAtmqTeuGMvSCiZLxDo9JrGCyWQVKAOxhEwg3T4z1tW3dM+2OZYE=
X-Google-Smtp-Source: AGHT+IG/+/ISRO3yy5FDyVzJMsKFlhdDgK2UIueLgLwaIVJAmWeZZhoFJi7f00Qob9g2h8MhxNz9nA==
X-Received: by 2002:a05:620a:2889:b0:79f:41b:aaa8 with SMTP id af79cd13be357-7a1a133d645mr204794185a.29.1721447033758;
        Fri, 19 Jul 2024 20:43:53 -0700 (PDT)
Received: from localhost.localdomain (bras-base-unvlon5586w-grc-14-76-71-94-205.dsl.bell.ca. [76.71.94.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199073b49sm150487385a.100.2024.07.19.20.43.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jul 2024 20:43:53 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v2 1/6] fetch-pack: refactor packet writing
Date: Fri, 19 Jul 2024 23:43:32 -0400
Message-ID: <20240720034337.57125-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240720034337.57125-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

A subsequent patch needs to write capabilities for another command.
Refactor write_fetch_command_and_capabilities() to be a more general
purpose function write_command_and_capabilities(), so that it can be
used by both fetch and future command.

Here "command" means the "operations" supported by Git’s wire protocol
https://git-scm.com/docs/protocol-v2. An example would be a
git's subcommand, such as git-fetch(1); or an operation supported by
the server side such as "object-info" implemented in "a2ba162cda
(object-info: support for retrieving object info, 2021-04-20)".

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 732511604b..9c8cda0f9e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1312,13 +1312,13 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
+static void write_command_and_capabilities(struct strbuf *req_buf,
+						 const struct string_list *server_options, const char* command)
 {
 	const char *hash_name;
 
-	ensure_server_supports_v2("fetch");
-	packet_buf_write(req_buf, "command=fetch");
+	ensure_server_supports_v2(command);
+	packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent"))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id"))
@@ -1354,7 +1354,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, args->server_options, "fetch");
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2172,7 +2172,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, server_options, "fetch");
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.45.2

