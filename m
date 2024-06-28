Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B295381B
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601543; cv=none; b=dYwUsT3qyXjU6QxXr0IJvcQRtZMFtRmHM9767wEf02db0+vdWYi4lA9IjyujCnaDn2Op5cHkuKdPsc8os9m18vwjpFZCpm8WjvS06i6hnsi0+9PtfPIa5MLDVEvQyhb7SHI7BTOoUVkocHcMzXMsNwNjsCnAxIx6hAQREWQWrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601543; c=relaxed/simple;
	bh=Yj+KtyTn+ETBJEyD8XUiTtzBPoLHsC+5WdG+8Ug6UU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9+i06y4Dv7o1kDs8XvhNTaYiJGMIBsMYxDNZ52kjBalqGR8KCiDfX+jwUmuiMEKTHKpenWwcRQzQS17BRAETd/Ql7xTeNGnUUhpozA2F9RfaFYOvCssJnu1dY+2JZW0mfihfXrcTiJPN8zqYjkqYjU/NxWFp8QcU/5QFmnnZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOB2DQdm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOB2DQdm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44639c3d8e7so6030821cf.1
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719601541; x=1720206341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URyEaRISo94s9l2pD7DVNc45D4IRWHLO9XQk42QL7BY=;
        b=SOB2DQdmI0eOrV2nbqu74HL8ugfqA7BRAt/iJItd5s9wYDZfq9OSBRI4h8OQ9uPEc5
         YQZ8h5QGd/pU4iu23TuiMStSm7A2eB43c6E2gwXpZ6eiw/KgRUi3gyFGMyVa1d74Yofw
         N/E4YbN+df+tqMnWSYPcuborTSvVv64Fn3XKveuQwUtd4lmdPTSm5umulz1LPzyRKXLK
         1RHzH27T9aXtC5noDTrSM1MglYlhxv3B9I+JFofKLvpUPZi2GPvQl+fJ2bLB+/x8T3U3
         Jw8lLLp1uyJ7CXvsGjUKvDr8qKpkorg2r8T7EecxgBLo4uxnl3dOqXLj0Y5ThXId73D/
         HeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601541; x=1720206341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URyEaRISo94s9l2pD7DVNc45D4IRWHLO9XQk42QL7BY=;
        b=qCbDwcSwx53eqdSu/P1geI3+mKpzweJAVuPcNGda5e+qdNW0pEQCxilHdd1lVSRmC9
         mc+hR0he3Ie6fZrk8cLGnBMfKQRUrGKE1ESd8lJ7rvGZL8wYDD4xlkyoSIVS0sbLjPg5
         EKMBhK0YBFQmDGUT83uzPccKqDK1wxeSDzVhtU6RnKgGNkt/xqz1WMVdOYLDo65BKgei
         JKfoFOBT2inY9+tJiaAOc9nsinElKFR6ucAnhIYSB4hIzTWsB3j3r6jytyCFY5p/GXdJ
         FSowylP/6QCKLdFJeVIL5kRCyZHkOqv5CfoTicqb8BKf8yPX2h5KfdrJwd0hwyhocIJa
         OItw==
X-Gm-Message-State: AOJu0Yzn8jUgf9uKeGguc2zcbeYW232JulfHCK2cHuEMNd001R9E6dTj
	Wd2BPVfQddzs2SJcw6NBv8LASShdITOxRgeW39PBnFgOrqr9UE5dXzniLekt
X-Google-Smtp-Source: AGHT+IF1d5v0hDRjYtpQHDjbwa4+cvs2c++RTxqMPMbIUmKeWyQlq8EWnn0svSQP7AMidVmlrBaRgg==
X-Received: by 2002:ad4:4088:0:b0:6b0:7b41:ca94 with SMTP id 6a1803df08f44-6b53bcdab53mr177058446d6.33.1719601540848;
        Fri, 28 Jun 2024 12:05:40 -0700 (PDT)
Received: from localhost.localdomain ([76.71.94.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e574cc4sm10262346d6.53.2024.06.28.12.05.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 12:05:40 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	John Cai <johncai86@gmail.com>,
	Eric Ju <eric.peijian@gmail.com>
Subject: [PATCH 1/6] fetch-pack: refactor packet writing
Date: Fri, 28 Jun 2024 15:04:58 -0400
Message-ID: <20240628190503.67389-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

A subsequent patch need to write capabilities for another command.
Refactor write_fetch_command_and_capabilities() to be used by both
fetch and future command.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index eba9e420ea..fc9fb66cd8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1313,13 +1313,13 @@ static int add_haves(struct fetch_negotiator *negotiator,
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
@@ -1355,7 +1355,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, args->server_options, "fetch");
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2163,7 +2163,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, server_options, "fetch");
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.45.2

