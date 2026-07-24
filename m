Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF842376B
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890477; cv=none; b=Pe7G7GOHZAljiTSjfj3753XeT4iGlaW1aJOVhrZP+/czHh1yCUp08HQ5XGrYv9Z9qHQNUWiILfghfqbsN/mvIfn/QJASNDDcSI3DZDZeRzczqUu1+7c44JQh89lHzdeV77ygkjkiBjm53PZS3PQjiIJrHQ2FkH6Jt1A3D0T7j7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890477; c=relaxed/simple;
	bh=Xpz/gWkgxXqWwmr0E7ukCF9AUfrougib6MMg7TPM7A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkJ/3NzaQVCxDj8Im+Z8OdJoEa8lNEE6xlGbFYQtJGXMZjYtAWA/qVWZiUxgW5bpiGCrPz/rr/8DJzPO4h1qPaqOkPkBv58nb9+I0SGSuPkkyqJrjwF9iu1YVVnl7P5/FmomXNGpqiY/uwt/oF6kKjNcDSS4xgCgpeYCgSzqf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGWYEDhp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGWYEDhp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f6de72faso2765445e9.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890471; x=1785495271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QOkJx3ugz5N9zJ8XaZJ2Od8TyKPVP0/tsmC+V5aQhWg=;
        b=ZGWYEDhp6po5PSgVy7AlxelDQ0LiKocEep4aHqYFwtOIS5pGpYP5bZKq1ujEtlKyPO
         zJ5yDZgY55dCkasFt0+i3zM0i5LihiTCYv1B2uvkKlGjxS9mBGkCD7aq3GRS6tXKAKdm
         OaoSjJQtRHPlcTd4W6FtedFDnmwiVDSkCsai4UjUzZtqN8NpbzrlDF2Y+3FCTw/UXSsm
         iRN22jP6UeKA+lNtJo8cFMW5SkxL6W45T5DnsCQIwCERvdPoiJGZq8dw3S7va3fSFqJy
         fLdRzKRi/8QFQSkcILSZLxZYDAlHhf281i3bnk1ggP8j1Uov6xC+fl6IbbvpWCa+DVib
         CXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890471; x=1785495271;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOkJx3ugz5N9zJ8XaZJ2Od8TyKPVP0/tsmC+V5aQhWg=;
        b=HPj2MQ5nechkrC02Z8dMBTaskkl0rINlUxrXmwappjZq7MFnEH5S1h6bJlwyzR3yde
         Xod0lQeZi3qUtX5HOutM/UjiIaB+MvTYOm+NsrYBp1ahZPYdWjbD6zQWz9OlzBNvd4pf
         d+gwUJGad2V++SVhppFeHDgxKkwz02LZNhpJLS9C2hzPSCYfs19zKAJLprgQziMSQ9QT
         jMk//S0Sp9izsvgkxqaTk34A7Uwm3Xe+Vb/gNlllax9+itrjDRm4V5hIvWmkuDQM7EHC
         J7wYFzTrjQMHYC6hKNrrS5qRy/XN8kTX5AHnT0gV2mdp0DYqmZzk897qjhZm+iuVUons
         nNLw==
X-Gm-Message-State: AOJu0YxvAtvmNso5H77RDk6VMDeHuHPAfFI5LtDT8bqn1Zi/VjbUI+WE
	yjvKr+VKJom8QdnlxLIw2RcUNsFPFt73KYn2jof3+nssGNP2qUn7xi+jmjU3w/w4
X-Gm-Gg: AR+sD12slx27Z3WR5+FSYySNco8ZkAkJmAI2upaFOuQX+UWbhOBURzylfkBmAN0np16
	8LZNtRVnLYz3E7A/Pd5qC/geJLrPZlZ28y1/g1t0ZclEC4zDkMTpjlwms9EYZOI6SL2ueJ8LOsw
	yHReeVmAIXjHcnXUP9Ocyq2n4TWRgM/IJxePCvvQ3P5yoUO0gG4RUug2lmyquBmq8y7rSQ+V5mj
	o9yrEm+sxjhjuwScksf07ml2u+fuxzBlHo+gv2pXshELxUQ90TN+SCeiNm+BZx6uhJq4KcfG9uN
	qAgfK81SH/evGzr3xmBfWQQNk3YpfpuqEefUb4LWsUbiEmIyiADCAKzIHzYiVADcVVPyjeRbHU0
	fAV+52WPp6qYwChmeeHVTNmxeXYKszchwodDIwXuJUc8RDtwK2cswGLKbA0lySiWd/sRrC5oyAb
	bLNT/zV16oFOjOPjry6mv5Ht35gYLo7Sv0Sw89WePb6TYVVYyBQLkgT3SRKKkFTpn4CdfX/6ja/
	EEerE8EWh92NgtVPJOqJ8B25E1QdZI3B6xu0ES80kdwnGrgOttISoUaQfrhTeyF92OW39WT3o/1
	HICpKUN5vZn28fv4FJ42hQv+T+xfC263IbHq
X-Received: by 2002:a05:600c:1913:b0:493:b698:9247 with SMTP id 5b1f17b1804b1-49690d6944emr454525e9.14.1784890471422;
        Fri, 24 Jul 2026 03:54:31 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:31 -0700 (PDT)
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
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 04/13] fetch-pack: drop the static advertise_sid variable
Date: Fri, 24 Jul 2026 12:54:15 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-4-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

write_fetch_command_and_capabilities() is moved to 'connect.c' in a
subsequent commit. To prepare for that, drop the static variable usage
of advertise_sid.

Currently advertise_sid is set in fetch_pack_config() by reading
"transfer.advertisesid". It is used in three places:

1. In do_fetch_pack(), to clear it when the server lacks support:

        if (!server_supports("session-id"))
               advertise_sid = 0;

2. In find_common(), to advertise the session id over protocol v0/v1:

        if (advertise_sid)
                strbuf_addf(&c, " session-id=%s", trace2_session_id());

3. In write_fetch_command_and_capabilities(), to advertise it over
   protocol v2:

        if (advertise_sid && server_supports_v2("session-id"))
                packet_buf_write(req_buf, "session-id=%s", trace2_session_id());

About 1, the check only guards the v0/v1 path, and the v2 path
already checks server support inline in its condition. Follow the
same pattern and fold the check into the condition in find_common().

About 2 and 3, replace the static variable with a local read via
repo_config_get_bool() in each function.

Because repo_config_get_bool() leaves advertise_sid as is if it is not
set, initialize it to 0, matching its default.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 9eb8fc5399..65ebfec09f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -49,7 +49,6 @@ static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int agent_supported;
 static int server_supports_filtering;
-static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
@@ -363,6 +362,9 @@ static int find_common(struct fetch_negotiator *negotiator,
 	size_t state_len = 0;
 	struct packet_reader reader;
 	struct oidset negotiation_include_oids = OIDSET_INIT;
+	int advertise_sid = 0;
+
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
@@ -414,7 +416,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
-			if (advertise_sid)
+			if (advertise_sid && server_supports("session-id"))
 				strbuf_addf(&c, " session-id=%s", trace2_session_id());
 			if (args->filter_options.choice)
 				strbuf_addstr(&c, " filter");
@@ -1160,9 +1162,6 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				      (int)agent_len, agent_feature);
 	}
 
-	if (!server_supports("session-id"))
-		advertise_sid = 0;
-
 	if (server_supports("shallow"))
 		print_verbose(args, _("Server supports %s"), "shallow");
 	else if (args->depth > 0 || is_repository_shallow(r))
@@ -1380,6 +1379,9 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 						 const struct string_list *server_options)
 {
 	const char *hash_name;
+	int advertise_sid = 0;
+
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
 	ensure_server_supports_v2("fetch");
 	packet_buf_write(req_buf, "command=fetch");
@@ -1998,7 +2000,6 @@ static void fetch_pack_config(void)
 	repo_config_get_bool(the_repository, "repack.usedeltabaseoffset", &prefer_ofs_delta);
 	repo_config_get_bool(the_repository, "fetch.fsckobjects", &fetch_fsck_objects);
 	repo_config_get_bool(the_repository, "transfer.fsckobjects", &transfer_fsck_objects);
-	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 	if (!uri_protocols.nr) {
 		char *str;
 

-- 
2.54.0
