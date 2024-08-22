Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8171D1F57
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724363877; cv=none; b=W0H6PMauARMgKqepz82GeDlL3wU9f6f2YjJlWT1jt3qQIMXO6Aa1119JZScxbHhTnF5/yQ5BxYbtiu/VQzccYT9a7pBCY+HdTu1COkqXhnzpeU9kPTK3HxycYEjHQjcRY3gypHCth266+QoNKmS4y+5humN5DWtTeVpIsgiHhu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724363877; c=relaxed/simple;
	bh=5Pwro6nhs+4TWySdQVXlCrjnuka0MfIh2v/FCYEwi4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gViu+g2df1WhnkSYkRvoqm5S0tJOx/WJ8ZegiVh25sbuAFmBfyuaOYGZlCsWWpyfs0C1ZMpghC0wC9Qma9QOwjpTkwqB8puRrl4jGXuCmIfBJHShesxWOZ9thTysWb54OxM4Cdj2tVErhMteg10z/3SAYTNTdleksfUQeUiuXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3iVgbur; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3iVgbur"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so28265507b3.3
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724363875; x=1724968675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7QwKjMvDV2HZQEtHHY+BmfEHf/61LRTqf6VgscGldM=;
        b=l3iVgburdbsaWkeaUYSRPmWempP2Ns5s2qUP0bMXubwmyEl2D3jX0xnQPG7mwyPzlk
         xc9ELPhBsjddtDKGQKmIVxpJc3XxqMq5gVHAGVidRw3pLtnN/HTYBp9klzKumQd/SggZ
         JwClWbAVfoahpE63AIPQvxY5JsGt+pFMQ32nHT42AjA0jOMoUPNpZPILlp2mKMpKxi7Q
         0hKq5z+3t5N519v2OGM/4oM45oksTTTWAYyRBPXxlXQzq0Lz7fQgdjI9DTNKC8U0zw/l
         ufjxF6IdJDe8knNQkTshTt8yvP7qrL2zFBo5nIsTBGPS8A6ixhwpi/T8FT9yj7P7HHzm
         QBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724363875; x=1724968675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7QwKjMvDV2HZQEtHHY+BmfEHf/61LRTqf6VgscGldM=;
        b=P9IKbDHp24qCQ8ojybAaM4BoqFMP5mZGa1HSQtJ0O5tXCxdfIAAKr/A+8HRf5XHle8
         YHaugoG1WT0Zjy+32dOHzT5l7eaTcvA3nWWqunK6bjgZZqutVV8TFo8YFW7vAbc2VYPl
         U8uqoEUGjUjfN0EUA/rOpISSuRphP7jjguL77gqu0Jw4Vztqy2w4QkGBSrusYSUJm0Rc
         FklpK30TCkKRD9X+olQw43VYjEBilGc38KTT3M7JbGV39dRAT1yUUKiG74qq7pOE7hpO
         fxd9+XFffJqE6DbHM0F8lhMl43zsWz4SKDy+/nvMs5OeZw/epo7otzTaaSOgTBjUSJ5S
         8QZw==
X-Gm-Message-State: AOJu0Yzd3KsMovDep1G/5VQMne91vZw+lB3OI/JTY4KRL6LMRnU+FSw3
	wZmM4DgHrGkrjp/n/UTQg9OyEM71zFRg5heIFh4hrYaCnL19V2aL5cknUjnjoRPDZnNX7jaLfKK
	GmypAiTmxutEcYk4AP2a3dmldjumPuMw2uWCB24QrBgq5KDpvP1w4dI8CHg3qRqC1LGptPr0wGc
	NYkre038+1eWQmiB56/Onz1bkmTA18OiCoVz5Nv/I=
X-Google-Smtp-Source: AGHT+IFhzbhftKLHZJqYGwravfEFckBDdbaJJ+9n/aXj/E/5jkqnduLTm9Ihc3ScMoBPndmDQyKzeZCmhA/DXw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:9ba9:7ac3:74ce:2b8f])
 (user=steadmon job=sendgmr) by 2002:a05:690c:74c1:b0:62d:a29:53a0 with SMTP
 id 00721157ae682-6c628b9655dmr65137b3.7.1724363874988; Thu, 22 Aug 2024
 14:57:54 -0700 (PDT)
Date: Thu, 22 Aug 2024 14:57:47 -0700
In-Reply-To: <cover.1724363615.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723747832.git.steadmon@google.com> <cover.1724363615.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <1927bb5b1f8c6486d49013fb216c4cd672fcfbc5.1724363615.git.steadmon@google.com>
Subject: [PATCH v2 3/3] send-pack: add new tracing regions for push
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

At $DAYJOB we experienced some slow pushes and needed additional trace
data to diagnose them.

Add trace2 regions for various sections of send_pack().

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 send-pack.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index fa2f5eec17..9666b2c995 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -75,6 +75,7 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 	int i;
 	int rc;
 
+	trace2_region_enter("send_pack", "pack_objects", the_repository);
 	strvec_push(&po.args, "pack-objects");
 	strvec_push(&po.args, "--all-progress-implied");
 	strvec_push(&po.args, "--revs");
@@ -146,8 +147,10 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 		 */
 		if (rc > 128 && rc != 141)
 			error("pack-objects died of signal %d", rc - 128);
+		trace2_region_leave("send_pack", "pack_objects", the_repository);
 		return -1;
 	}
+	trace2_region_leave("send_pack", "pack_objects", the_repository);
 	return 0;
 }
 
@@ -170,6 +173,7 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 	int new_report = 0;
 	int once = 0;
 
+	trace2_region_enter("send_pack", "receive_status", the_repository);
 	hint = NULL;
 	ret = receive_unpack_status(reader);
 	while (1) {
@@ -268,6 +272,7 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 			new_report = 1;
 		}
 	}
+	trace2_region_leave("send_pack", "receive_status", the_repository);
 	return ret;
 }
 
@@ -512,8 +517,11 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	git_config_get_bool("push.negotiate", &push_negotiate);
-	if (push_negotiate)
+	if (push_negotiate) {
+		trace2_region_enter("send_pack", "push_negotiate", the_repository);
 		get_commons_through_negotiation(args->url, remote_refs, &commons);
+		trace2_region_leave("send_pack", "push_negotiate", the_repository);
+	}
 
 	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
 		args->disable_bitmaps = !use_bitmaps;
@@ -641,10 +649,11 @@ int send_pack(struct send_pack_args *args,
 	/*
 	 * Finally, tell the other end!
 	 */
-	if (!args->dry_run && push_cert_nonce)
+	if (!args->dry_run && push_cert_nonce) {
 		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
 					       cap_buf.buf, push_cert_nonce);
-	else if (!args->dry_run)
+		trace2_printf("Generated push certificate");
+	} else if (!args->dry_run) {
 		for (ref = remote_refs; ref; ref = ref->next) {
 			char *old_hex, *new_hex;
 
@@ -664,6 +673,7 @@ int send_pack(struct send_pack_args *args,
 						 old_hex, new_hex, ref->name);
 			}
 		}
+	}
 
 	if (use_push_options) {
 		struct string_list_item *item;
-- 
2.46.0.295.g3b9ea8a38a-goog

