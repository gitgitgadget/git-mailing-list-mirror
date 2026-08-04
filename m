Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69D4322EE
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868991; cv=none; b=RUsWTXgRTgeTZ5suJ9l8eH+UhgXz0GH92dRUsJEAA+ZlW5mZaBWNbaiIEwiGiGD/NbJBOFgwhIcw5FHcyg4FnIlEmLQ30zIj9YCMfXu8wlIV+O/NOAVlRO/QkUYJazfaLW/aYEUU8ezpdcHr8Glkm8ZXNHWLWI5+F7TC4l+OyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868991; c=relaxed/simple;
	bh=sWEQrASP86cGvfrjPvEwUiqrVnt4Oa+/Y8tug5tE4KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAYgiW5fcaDIPGnaJAQiw+jbHkna5ZqIqTeM4tTOEWJZ29GE81gM7zQo0Elc5JlbLXYpQk76MetBuo5ZKuO1qJfkTx0AqfjpGqatinD7TNG9POvn2/rNdMsYKZ4zWRYvp1vilfPLny3D5DPWFf7hGorxo4DonwAWhiI6e1mNbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQT+09Ts; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQT+09Ts"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so1050585e9.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868987; x=1786473787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDNN7L4VIg+U3kuAzpDbaiyKRWmeNoJPdDWv/gJGx7U=;
        b=HQT+09TsYkErkptScVrpBIt88zo1gkk3jVQtG0HQHK/YwgmLbPT1jUmITd5aiK9XB2
         loNGM14PuLYosPUBJX5p5Gd9JCnR6sjYULVYsW8jRhZOcmFiznseEshKzDHwPhCE8rxy
         dbtBhHvW2s5adg9yNuygpYGohECIp/QqyRrgtUsgqQd2iim66NdoM7LvMyrPbdfJ3wVy
         /nO8jGLojphrIcEsr4JHiuyZ8clO3FvS11RTMR8rqWHpj1zDFxe7am6gQV/PO/rhECex
         m+61ns7HmeNvKQmK2RKaQMBbPiQlmFKnb6R58kdiiLvdrSBO/hFI6yXjrYrwvO2IASB4
         MuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868987; x=1786473787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDNN7L4VIg+U3kuAzpDbaiyKRWmeNoJPdDWv/gJGx7U=;
        b=MgZUcTMcsl9CJ9teaPknJkHVH1qlruXhXky35axlmIsDsPyt90BiR3bpgNDkpOJ6I8
         Ou9uvkQaIytLEIrEBX9wvOXhdPUR6ZE8dmilPYa0jGdIhkiIjd2NP+fEtA49M6NU/t84
         s4cP21PN+BkhIdT+EWqdybb5aHKDdR75pZDsiuAZBmpoSUwzK03y6uXAdtGdiAEmdceF
         jNIn0dYI3ddDRfy1thUmGHwRu3tE4JquMOAHmrnz0D1gf6PslIHaYv7zoQl7nxwaw6xg
         NSYf1qPU5KzNdnDy3Pi2S6WLcXgGMCAViN7SDDoYcntOw7DeDRVYVoly56cN9xrstWyO
         E69g==
X-Gm-Message-State: AOJu0YyK6EQvDEqMCyUzRHxJ+Mk68/4x6HQbkhhtYdUKiJFFAQz36ZTs
	ah7UuC1rIbzMxVy7AyAHgDCfCYyMXrizluHU1VXgNL/u9dpd0ZE3QHw5TSiNjW75
X-Gm-Gg: AR+sD13tgfNJ4vDEGZdFodmoim55Q3Dbhom24cOHWnGZjoJH9nA/dsYKFkfE59yI1BG
	hovU/tM3cF1L7nGk63TS6fAKAknj1S9Gri6Udx6ypaj2L4EBCfDa22RU08vN+7pcWqzWrfbBGPy
	4n4I2HombBzmSMcO6qStECvxoHrfLAu0kuKWSKJLuBIbywQ+yrXDV3hDjp/EEqdFJhwMGjCPaJn
	bepm6TXj8P1tc7m4mNLN24iI3pRpQwdLOYurbp0+MfsBhAVh+7tnuAJdEw3La4VYKMOaA4wl5xQ
	8fAdL1tZWAmENK+FX5Qm7Uftg6oczOErHOzOkJN+6ZXQfrnb6wNllfa/In8dyxUzaeMznEyPZLO
	67cUcEwm7JKchvQiXbSPOF8rem1jqiCDgAGIW9+IcFf0QhoQ0d1WW9oQCpmDxEnXj4MkqHu9SwL
	lYBRyXb5jdfW26v7o7YFu6DSXOiGmT/p7q71vXveEbCHQZ4wd3abVULB3Rr02IvrFrOhiEes3ji
	wCL5F/BKFkODyhWNASyNGaJYRhJXbEy9QHhqU+BuJctlyQt6u8Y2EE+pcfLkMQnEi8N2YJcsBHe
	AiQa7cNXEEuAcnsoANuDGRrRRtou8YRmET8uuzJzyZcUIMdK3YtdJULOINva9Dv2v586NYqhTon
	IlzngEChpYthLLZgh+LZVv18gPG0=
X-Received: by 2002:a05:600d:8492:b0:495:69eb:27fe with SMTP id 5b1f17b1804b1-4994e7bb193mr2405805e9.11.1785868987182;
        Tue, 04 Aug 2026 11:43:07 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:43:06 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 04 Aug 2026 20:43:01 +0200
Subject: [PATCH GSoC v4 7/9] fetch-object-info: parse type from server
 response
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-objecttype-support-v4-7-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The server can handle type requests but does not advertise the
capability yet. Prepare the client to know how to parse the server
response once the server advertises the type capability.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c  |  7 +++++++
 fetch-object-info.c | 38 +++++++++++++++++++++++++++++++++++---
 fetch-object-info.h |  3 +++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e1650b2921..7a3ae11a70 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -844,6 +844,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 
 	if (data->info.sizep)
 		results.wants_size = 1;
+	if (data->info.typep)
+		results.wants_type = 1;
 
 	if (get_remote_info(count, argv, &results, &object_info_oids))
 		die(_("failed to get object info from the remote: %s"), argv[0]);
@@ -852,6 +854,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	string_list_append(&data->remote_allowed_atoms, "objectname");
 	if (results.sizes)
 		string_list_append(&data->remote_allowed_atoms, "objectsize");
+	if (results.types)
+		string_list_append(&data->remote_allowed_atoms, "objecttype");
 
 	data->skip_object_info = 1;
 	for (size_t i = 0; i < results.nr; i++) {
@@ -870,6 +874,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		if (results.sizes)
 			data->size = results.sizes[i];
 
+		if (results.types)
+			data->type = results.types[i];
+
 		opt->batch_mode = BATCH_MODE_INFO;
 		data->is_remote = 1;
 		batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 6069d6a58b..ad27b1e4ca 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object.h"
 #include "pkt-line.h"
 #include "connect.h"
 #include "oid-array.h"
@@ -12,7 +13,8 @@
 static void send_object_info_request(const int fd_out,
 				     const struct string_list *server_options,
 				     struct oid_array *oids,
-				     unsigned ask_size)
+				     unsigned ask_size,
+				     unsigned ask_type)
 {
 	struct strbuf req_buf = STRBUF_INIT;
 
@@ -21,6 +23,9 @@ static void send_object_info_request(const int fd_out,
 	if (ask_size)
 		packet_buf_write(&req_buf, "size");
 
+	if (ask_type)
+		packet_buf_write(&req_buf, "type");
+
 	if (oids)
 		for (size_t i = 0; i < oids->nr; i++)
 			packet_buf_write(&req_buf, "oid %s",
@@ -56,7 +61,9 @@ void fetch_object_info(enum protocol_version version,
 		       int fd_out)
 {
 	unsigned ask_size = 0;
+	unsigned ask_type = 0;
 	int size_index = -1;
+	int type_index = -1;
 	size_t wanted;
 
 	results->nr = oids->nr;
@@ -71,11 +78,16 @@ void fetch_object_info(enum protocol_version version,
 		    server_supports_feature("object-info", "size", 0))
 			ask_size = 1;
 
+		if (results->wants_type &&
+		    server_supports_feature("object-info", "type", 0))
+			ask_type = 1;
+
 		/*
 		 * Even if no options are left, we still send the oid so we get
 		 * at least an existence check.
 		 */
-		send_object_info_request(fd_out, server_options, oids, ask_size);
+		send_object_info_request(fd_out, server_options, oids, ask_size,
+					 ask_type);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -83,7 +95,7 @@ void fetch_object_info(enum protocol_version version,
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
-	wanted = ask_size;
+	wanted = ask_size + ask_type;
 
 	for (size_t i = 0; i < wanted; i++) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
@@ -100,6 +112,13 @@ void fetch_object_info(enum protocol_version version,
 				die(_("object-info: duplicate 'size' attribute"));
 			size_index = (int)i;
 			CALLOC_ARRAY(results->sizes, results->nr);
+		} else if (!strcmp(reader->line, "type")) {
+			if (!ask_type)
+				die(_("object-info: unrequested 'type' attribute"));
+			if (results->types)
+				die(_("object-info: duplicate 'type' attribute"));
+			type_index = (int)i;
+			CALLOC_ARRAY(results->types, results->nr);
 		} else {
 			die(_("object-info: unknown attribute '%s'"),
 			    reader->line);
@@ -149,6 +168,18 @@ void fetch_object_info(enum protocol_version version,
 			    object_info_values.items[0].string,
 			    object_info_values.items[size_index + 1].string);
 
+		if (results->types) {
+			const char *type_str =
+				object_info_values.items[type_index + 1].string;
+			int type = type_from_string_gently(type_str, -1, 1);
+
+			if (type < 0)
+				die(_("object-info: object %s has invalid type '%s'"),
+				    object_info_values.items[0].string, type_str);
+
+			results->types[i] = type;
+		}
+
 		string_list_clear(&object_info_values, 0);
 	}
 
@@ -162,6 +193,7 @@ void fetch_object_info(enum protocol_version version,
 void free_fetch_object_info_results(struct fetch_object_info_results *results)
 {
 	free(results->sizes);
+	free(results->types);
 	free(results->unrecognized);
 	memset(results, 0, sizeof(*results));
 }
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 97ee5314c9..10b3641f7c 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -1,14 +1,17 @@
 #ifndef FETCH_OBJECT_INFO_H
 #define FETCH_OBJECT_INFO_H
 
+#include "object.h"
 #include "pkt-line.h"
 #include "protocol.h"
 
 struct fetch_object_info_results {
 	size_t *sizes;
+	enum object_type *types;
 	uint8_t *unrecognized;
 	size_t nr;
 	unsigned wants_size:1;
+	unsigned wants_type:1;
 };
 
 #define FETCH_OBJECT_INFO_RESULTS_INIT { 0 }

-- 
2.54.0

