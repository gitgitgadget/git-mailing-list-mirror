Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4643B3C3
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701695; cv=none; b=HTSNwsD2yyue954YlNgQBHVT10KYYFhF8ggdyUTF1QpRPeAXSssI9A22EfcN59N1Vwne6mBRNru2hr7m6ni82MLzy3ttdlZHDVdcK7XH+nHJplq0ea/lKPBaWLEwSWjFjAXL48s8uD/Zrq4hDTnFopCX8i+VJGlHiIa2iHWtKoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701695; c=relaxed/simple;
	bh=ilx7AwUVNf+HhO7O86yAgdsA5Fe2R80gYFNyUwj+uLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m47vOn7D/M6zyGsa02hNGIQbp7JnL1LZxlFkcIRboyTm7KW9FgbhulCNMEc2Zah+T2PigLUlZYXQuHhCsB8bXSha7RNW++IgzquRVYVw6kyMY/ehAsCN54y+Chz6G5x4ww4xY0Lox1R+B/TWWCA2YxWhGGxz95XNL9lziAzdDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZ52PHND; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZ52PHND"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f60208a5so6431395e9.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701688; x=1784306488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQn5DFXyZPb/tfQWfzOy3G+x/Dlb/p4a8tlg+g48zos=;
        b=oZ52PHNDEIkfsVWLSwSTsgdrZdXZRA3ug2J+I1SlJBSflNrTGl0sHCZqkAd9WqV72r
         0dzPDXTrGwfn9qndEJIKADD6Bk5p1+/6nXx/gVuuCOU7MiQAEWX2bdlgqfIRPeOdDXAn
         7PkxLjbfy4mdwZcpKtLAuhAZHRtf9B1Ky1CCcT257RNtGBvcTMGuJ/O6YwuOUmoWGb6A
         q9mbhHMUFIRBnqBrXDop9BpwH/cKjK5DYqfR225lVnmZevMV61W+ZDksmx5HPIhgx2IP
         cCu1lSDpEH+nBpDJRJIYMqh/IyEtI2Bx+JvpYvfTkXfS/whMFW91MTQTYFKNmnuOUp2F
         fVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701688; x=1784306488;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQn5DFXyZPb/tfQWfzOy3G+x/Dlb/p4a8tlg+g48zos=;
        b=VO4QOmgjFNTBNgmLWd6YgdfhcD3XGxnk3NZpYJJmtvjYyEzmWTdYokMa23dFHlCL7E
         t82Dznlliv1sT6vXxa0ZRVnfx2H4aYyZ+RsJU0vDeKPDfgsU4sdf/r1Bc+Gj+HkV36yJ
         rciiSdjqhFDdsXloUkrH8tSJz32iBOg6IAfP/+3FspY5CeFcsCdQAe8wEM500mDVS9HZ
         oS/er+VyM40Jq57Rv+xd8MoDrN6GvzWZtV732uQkPopu6iHchuUyHpUsN6xJjBglATzR
         Wdleb+uvIjXrx3CMIzwg9x5ZWm1rLpHLTbdsUxdsORo7Q0GidjkIYw5aNQaXhVr9Iwba
         ztOQ==
X-Gm-Message-State: AOJu0YzRRcrZOKn3chEWwqB7G+4vM4TGwa6vp1F4ePzHKH6SrRn8UOuG
	UU5/B3aOATOGx3mf/NGDxiq/TLCJa6yf2hhDkoPAtCQYpyeRiDtAretTMelwRb9I
X-Gm-Gg: AfdE7cm/e56FIWeoYzaxbJ81qDYz5geWnu4lk0GSZrU3kcHQHyxGjhaZs/ghAw1c5zX
	te4uBXT7tbiSBMpncmsPxtPlYbLI9apxs1FN9zqRYOIDUBxx8MPiF7CMduphv8t1Xlt1IaxQ+LP
	Wka8RLxBTQLICJM2wXmHUx+CC3AtJSlhkWg9CdMlqG/XGLHLTJV/rXTGeNVmRaiCl25r4DhGThE
	mUdQ9veP6T+8eDglQYpRGdtEGSCjlAQh4sTDrPClGEb2vZPM61Jmy6ifjSF8Im4TxB1LGr65VAI
	zXlqm93+efVwbWrG+RQQYweoiSwwyBufNqLQLolR8ft8FrZHmzNBoWW3qmrgDgCZQyBz0A9fOQ+
	BTyJFIeEYsSubWRjejpy7WCKOkloHuwoUmVCfKgRO7olKRUR2wAq03JCebRarDZKKEp6oRGUI0N
	AYXQGEJRLawkpPjnE8GXkM4kEdLDcQq0MSxixHQEKgwTovcwU4dMv5PMrKiB+uV+HUiNcK0967j
	cct1wHAVeEqp+oW/vwC8wzODwyrHziIrc0eBn1ZV5qEteue6Km7+tCfaCQ5Sh1dzgDiTuMShTCV
	4ZkU3b4q4n4nda8pqW8MOEY7N1+ZEBscvkiG/Sps0+9c8Gyv8hGbwH0KsJd3Exmp7c0pyPTLf9h
	2GZBUHIXTliO2/aOfu+C/
X-Received: by 2002:a05:600c:358f:b0:493:f528:58ac with SMTP id 5b1f17b1804b1-493f5a565ffmr34799265e9.21.1783701687982;
        Fri, 10 Jul 2026 09:41:27 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:27 -0700 (PDT)
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
Subject: [PATCH GSoC v16 05/13] fetch-pack: drop static advertise_sid variable
Date: Fri, 10 Jul 2026 18:41:11 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-5-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
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
of advertise_sid. Currently advertise_sid is used in two places:

1. In function do_fetch_pack():
        if (!server_supports("session-id"))
               advertise_sid = 0;

2. In function fetch_pack_config():
        repo_config_get_bool("transfer.advertisesid", &advertise_sid);

About 1, it is only relevant for v0/v1 protocol, move it into
find_common().

About 2, call repo_config_get_bool() inside of
write_fetch_command_and_capabilities() and find_common() replacing the
static variable.

Because repo_config_get_bool() leaves advertise_sid as is if it is not
set, initialize it to 0 matching its default.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index eea72b2500..8e04db8640 100644
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
