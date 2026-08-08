Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26014136351
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147358; cv=none; b=PniC850gi1/CAMp3XrD8uaiZCcQW5mSNys+2YWPrhqfK+WThIzYb31VFtNeCdcxTzqC8JCoXUl0QBmbKwVxg5eg3gVzNSWd1OalskiGtg2PXvo6jhaEGEC3RD2V+aTzj0LBj7AoKAEznSLfmphDBceodW0k9pA+IQDFzVYSzP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147358; c=relaxed/simple;
	bh=TbLELNcqKOaiKP1T0nniLTFVm7K+77Cb1B1sl8bVhgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MsKRoXMLLni/m4gawerccqkVXZrl6Kc62Qwnf5WQ05TEbU+OkrKYwulDmyjcCmL/L9akWOTM99ExVrG6pN/h7mhQ1LqWFKU3zT9QSz+qJzy6dprzkkQA6bKI4byb8JGUSIt/G3o0lrMmHDHHYlQaZBRs4AvyX9s9MGSUjTEGEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rpw+cCdr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rpw+cCdr"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f6609c657so15589f8f.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147355; x=1786752155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MoDBT0PDfQMwzCgRW7sxO7bqIH/cNlpAN9rc3dmZxr8=;
        b=Rpw+cCdr2FbHrRJxUsN1aIKqP0/5WkSfWgFVd5mxHjMD5UpE57Dl358/e66zBAz/gD
         r7k640bTzUT/nnMYkjZ611WKXb726wsBAH5xmIeJi09GyeURasoN4cRyFkcKsjxARttN
         /RyrXoN/boyOR+MvZkDZVrXpVeqNvKbGrF+zFrwDtWlrQiBdYcJkisTqT5fpICmeV8ZT
         N7nKvYhUjewc4HPuYXKdKxoaYo45JOek5jh+g3Bnn1P4wMXNT4uQIEweBEo/0s2zhya7
         iQOWj4XZp0J68nYiKxv0BYHzPRSWfk0agDCicES2hJ6bjNmD/pyRpoWI48Uv0Ajr+v1K
         Z2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147355; x=1786752155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MoDBT0PDfQMwzCgRW7sxO7bqIH/cNlpAN9rc3dmZxr8=;
        b=svF0otQX8BKyaUoskmAyn6iDQD5mTMSJnobw+NWJYWDV6a60GY+2Li9KElIYRCB57f
         sA7wyQErrGzxSvXWdqKQP6qqG+/y61MGoM8CF2lKilymJ4emU96NUhIGmFIkIdtmMTH6
         IK6wZt4nG6EzVHF2U9s/UssnU9ccJ0q2+iYuUYUqag/DQMx/7qTlHg7Wk4WD/AzHJHVW
         7wEdSdyOfCFnu3M/V04eHIK4p8KoGN9+3EOUnWoNJsGyczkFLlo3O+orpt2TvzPlrOwf
         UMYC169ffX6lLYPNuQY7Fa/MD+rdqU/3SXLsoDfYl8z+e17XGqrM+SwsOxoItTrP0vlN
         9JSQ==
X-Gm-Message-State: AOJu0YwdMzPD05h+PLes/FbimB50G0AjdLMXrhJHXCV8x+gx4kKbTN9C
	YNMy1eHjs82X0jFlaKMvLLpcLb+sKoE+7Ii4Gk5V32JuBMS56PiUvmTB
X-Gm-Gg: AR+sD12DU/wHBeY2JfHtXB7lVVhTL5mBoRi0LsCPZvUsg7u4Q7c5HXnzmxeFlR6eLan
	Jw3XUWjs3VWRIpDf42gEHSkTFgpGgMpKVgf3u9wKV8DeVOX5kP4uyLq2CuU47xKvz1fSCrKbxse
	MFvjx9eBceT3eBFiIPfQKKHnDaYgBzWVP73VR8HdVU6EswbOr4FRRHhO2nq9c+J3/aYUMDnfWHk
	wU3l6Bb3da37bV5TjoS0wgS4sqT34BU574aKHdg+2DT3oyf1yjfrKYGyucHTt4B4AVLExwGAhfR
	vBXYKyz6eIL5CZw8v42+U1aiMfdk6nPizw8sEzVpKKu6axGUCmYyKxu+WyLqRQJaCnYtc8HF+xy
	Lg6cKUA4kCGHjnsXbdxlBhGv6W4xbQMyLktuv1mD9lCtTVH3G7L/UlYJjmZYMyiSi6u4z0nb0Hb
	jR+fCT4+JhrgUcbeansSJy/tPNmL9n/HRC9s+lTP5c6PvJrYi6uKj3khMJ7u5CPaE9YWxfBIEwz
	HLscixsRLuAvuudG7pGJ0bgSJJXOkWSfID1cwKK7Wqkq0rLUekYyDCeueSi++MvjD0R3w7MYaP6
	OlnWGWLKcCQ9wx/EFpYSTvjK7fN3WL54xkqafuvwR9BMa5+icxEjxYSVQNHJiU8Lc2YvN+jE2vN
	Cjv65yrfNImLwCyIuSqf7tCkO3xLE/SsDbtdFIHo4HIa913DvA+hbaBp/DqLeY5IFoQqaEfYGD3
	9Mnqg=
X-Received: by 2002:a05:600c:1987:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4995e0dfb2emr103624015e9.16.1786147355270;
        Fri, 07 Aug 2026 17:02:35 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:34 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 02:02:23 +0200
Subject: [PATCH GSoC v6 08/10] fetch-object-info: parse type from server
 response
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v6-8-e5cdaf27a49c@gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
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
index 8dcad2f5eb..8502020083 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -842,6 +842,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 
 	if (data->info.sizep)
 		results.wants_size = 1;
+	if (data->info.typep)
+		results.wants_type = 1;
 
 	if (get_remote_info(count, argv, &results, &object_info_oids))
 		die(_("failed to get object info from the remote: %s"), argv[0]);
@@ -850,6 +852,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	string_list_append(&data->remote_allowed_atoms, "objectname");
 	if (results.sizes)
 		string_list_append(&data->remote_allowed_atoms, "objectsize");
+	if (results.types)
+		string_list_append(&data->remote_allowed_atoms, "objecttype");
 
 	data->skip_object_info = 1;
 	for (size_t i = 0; i < results.nr; i++) {
@@ -868,6 +872,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		if (results.sizes)
 			data->size = results.sizes[i];
 
+		if (results.types)
+			data->type = results.types[i];
+
 		opt->batch_mode = BATCH_MODE_INFO;
 		data->is_remote = 1;
 		batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
diff --git a/fetch-object-info.c b/fetch-object-info.c
index fe26bf4bbc..0a58308f9b 100644
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
 				     const struct oid_array *oids,
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
@@ -56,7 +61,9 @@ void fetch_object_info(const enum protocol_version version,
 		       const int fd_out)
 {
 	unsigned ask_size = 0;
+	unsigned ask_type = 0;
 	int size_index = -1;
+	int type_index = -1;
 	size_t wanted;
 
 	results->nr = oids->nr;
@@ -71,11 +78,16 @@ void fetch_object_info(const enum protocol_version version,
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
@@ -83,7 +95,7 @@ void fetch_object_info(const enum protocol_version version,
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
-	wanted = ask_size;
+	wanted = ask_size + ask_type;
 
 	for (size_t i = 0; i < wanted; i++) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
@@ -100,6 +112,13 @@ void fetch_object_info(const enum protocol_version version,
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
@@ -149,6 +168,18 @@ void fetch_object_info(const enum protocol_version version,
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
 
@@ -162,6 +193,7 @@ void fetch_object_info(const enum protocol_version version,
 void free_fetch_object_info_results(struct fetch_object_info_results *results)
 {
 	free(results->sizes);
+	free(results->types);
 	free(results->unrecognized);
 	memset(results, 0, sizeof(*results));
 }
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 10cf9f5f63..2fba96c6f7 100644
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

