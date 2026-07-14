Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC773C4171
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029523; cv=none; b=OEa0mPvXtuKIYQ0f+0mYEn/QWKjG4HMRCnCmcSrC7tTKB+2j18xy770r1fadS0rpiGXl3XtDScI/08n7X/D/UdA45r1SYwvnAIaUq7wS1YhawT4U+UMz/qMki6FHIXZf5J5zCNLZMGkT+VWeAcWhDNnqbjmmQIjznLx+GFbn2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029523; c=relaxed/simple;
	bh=ilx7AwUVNf+HhO7O86yAgdsA5Fe2R80gYFNyUwj+uLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuVzNomCD0ddKw7lGEtZ0iUBBODWa84SGTIDcYGYYlguFtRCtIj79Yla7j9YqJ/7zBtIDPUHsx0T5vlVVzzzbqcs3qzx1nJASL4yyL2C0fKjyV9/FAa6A4SOSkSS4REFD1Q+f8v4/vMeJLRkoCXCRzjyGCDQ+osYJasY94SZcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V41uEQfV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V41uEQfV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493f2e39e81so17057505e9.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029519; x=1784634319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQn5DFXyZPb/tfQWfzOy3G+x/Dlb/p4a8tlg+g48zos=;
        b=V41uEQfVvrvZ8VGouYw0Y6MXr08biqwjaYcBSvSO+wni4o2Wcv54c73bm0lxZL7DW5
         ifjWe4lh3gLv8AD9Hyqx1k9da6dPamxbDhrchK5DMqdXsB4+X4uipi2A3ziD8ntesqSf
         J09Yp+rQwFLtUy+u52nXSmEMDZzUOYydO2V2290faCZ55FprvCz5fLk8yL8UkPCKi1pE
         DozGL7nobTirVZWA74wUsfVcYd7fhWHzYlq7YDmQJQ+ZmQajslrPo3Bkz4Yzw8qllszN
         ZXewKeC1NkJbQ/vKSm67Dd2qYe5ymaxU4MgoSb4qeDOj7PmQXJ2uuyQ4m+Q4fUap3sG8
         yNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029519; x=1784634319;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQn5DFXyZPb/tfQWfzOy3G+x/Dlb/p4a8tlg+g48zos=;
        b=bc9AaLwKSwxqDg5VzGbQ+nCu2BsD5FCtQQqZFnnN5RPpNSSfKO9mm9ZdMJpEI9h17f
         O06cwvM6OWkZBmsUxLVoE8yIssCYX4bHeqRIdxnLtT0eOTvaWKia+kC+hCj51B1IkEnU
         1JZxMrNxD++4iAR1hI42Hy5DyUq66Tf/Z95XPkPa02WLK99YKX9eBxbVy0SrR/mZcW0m
         jSO2ltSqEyn+jh/VDPr3FY1DW/5YoKBso2st5SadnSsKV60P0XOvZDiEKAsUPcWZVuww
         Bo+2+AsHZ4b5J7hnMtVFl0KKgVIzB27axwmxLPUA3PLEnEVGN7mN1Of+3SuHA33nZSMI
         LJiQ==
X-Forwarded-Encrypted: i=1; AHgh+RodghA3TZbcoTU1/MA+h0NBeJX6fE6RgsI5SdTHLBrSqMJVWIMJGK+L8likUCaMKjdvKFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTd5XOaDVdaWmtEluygyy1UJjG+VfomaDvpg1f0cNX8xAinx8G
	RHrYR8CHbIUaORsoFdfpmbNGji8ZhlaChpR6cu/RkbFeDcLHXfW6bWUb
X-Gm-Gg: AfdE7cnbg0wLLcR2VWgFUmttqwJxEKZ5EE4E67Jtf6+gRl2EA4b1kN5OrR4xkcQXj7p
	Zsgc9tX7OsE7brVYbwZqd/424HPX3Ijrh2DWt3+oqeEKt2WLXCNE43JI4GprOi6n8Dqs4lEdMu/
	nMPFpcvhqKCv8ZSR6cLXKupsO6EMxaB1nfrcrVyUq5lHNiI+OfXzZ0z5NN/lLaUx8iLFpBtMSQe
	6QUZrhKBhAK1h+/Z9O+QSjAPTx7VpRIU9ThnAXqdxFFrotDFviNp51Y7eUuvj+qKIuuu7bSnh3T
	RCWjn39yjKjDcgJ4wDMWRX80A4kgmUE2pUItMDTEsfhystI7Kg+mp6UjUa7vU8N/66afwx4NIxo
	dMsnpVHnJ623BRA8+RXCv4giTcl8p8dI9lt+0VR+yl9emtNr+cWBHJsdBORSI1pNBNOX5R23pNY
	ndRj1n+g0yM2D71l/MKDc5NwcoSanJyyLxtYe3FJamOMMAEh7VLx0+ZcSwR17rwuR67Q3PtO+QK
	cJA9DPni7Xt4s8YKRrenskl63yGgV2lCb1tU20HaAZqMIAWwM0bjXEEi55tjCy8qSikbpC+MARe
	cEOMEULUuCIoxHa414pTYsSKvclQpnWV70j+2q/RmLTvA1p86GvYrQc0BxocRoQ28U2qEoyV2+W
	/TqfR7yk+D0ZkI0qYKf+w
X-Received: by 2002:a05:600c:4444:b0:493:e46e:157d with SMTP id 5b1f17b1804b1-493f88243aemr130666005e9.19.1784029519132;
        Tue, 14 Jul 2026 04:45:19 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:18 -0700 (PDT)
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
Subject: [PATCH GSoC v17 05/13] fetch-pack: drop static advertise_sid variable
Date: Tue, 14 Jul 2026 13:45:01 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-5-afabfc83260e@gmail.com>
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
