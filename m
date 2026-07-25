Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7C322C67
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980535; cv=none; b=f/odE5ZlYqqMCAJ8HBTOJ7T0bIrNUXQlU+7oM2cPCQ2UbVyb5bxI4x7HfTtJ2g+/K7gZi34eoEjHXU/atRYWJUY5aONE+mHukW7LookN8OJkJwjTIcuqdRupyQVyPB5d1v+Qx+kqMKVXGLg8ygl+IInBPWy3h28InqBW8j0Mrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980535; c=relaxed/simple;
	bh=uGCnhVg1+S2n75BDrQzzr8PkH8Nw0axrcM6oK65YphY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GajB4Afur/rb6bLt3mLx6VWpEMexytnwPIFXWKZnLSp1kWj5KsB2xXaimLi28aCbM6FfxgLrGpgZbBxI2mFNYlPaMSwSOv3CyeiusY1kxNKIIz3UtOxrZrj8A83ozr0zVJVykmRFxSBgj4BCMLthCiol9anTIkHpC2utLpijVTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5o571GE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5o571GE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so9465985e9.3
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784980533; x=1785585333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DVnJdU89aT5YuzX0xuhwVNyuVu8x5Q5P5hBY+FuP9lE=;
        b=M5o571GEYmP8jFh0Yu7NFXMKT3nkBbxU9AyC+LcLE6D5BJ58nevBpjIekZDDmkwL/i
         R7xHB+P2qNvpG4SNIRyrNhZL7RlsRaSyjMKCHRKjN6MDu0aOl6CRETW0FLiQw74Slgqn
         ncGxgoaPi6y83iROKQKDGy/vqFy1B9NJF0JkjafzgC/u+ibHxcxzjOQYq/EMQuxSqZ+U
         VrG4JLktKlimlY8/0sGtBUsRlicwb1wFOi6JDbN7R8uv32v/RVAVfRTXYh35tdy2prpS
         nnj+2kowZb+sJOAx6k75ccUs6HEXkqNOlaDUXNVohndtnN4t12G4oHDdNREF1XNLnW5+
         MYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784980533; x=1785585333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVnJdU89aT5YuzX0xuhwVNyuVu8x5Q5P5hBY+FuP9lE=;
        b=V25gocWadcok+/KuyRSoqE5SYqt7EwCviWauuA2xOXnJJ+MlMVunBbUDxaPyRLEr8e
         hYsXbMt2/MtY8XwUngWMbtOrKk01SqeCTshk1c4idoaM4uXdEm+BHNVDeK6rhvzhjYz1
         fd7gqmnkCCiW+lBzxgrjqvhkM3XSY4hzfIOlS0J5njul45MKA9Bd+5Gfal2YYWvw6Hq2
         WPS4wmTvTsQvchuTFDJO4l/TcYBvOdmNt4NXzS34STPaaW0JySZkz56IdwafmT7JWjBs
         5eUhoU2dSGy18kpThAk3duhoGsr6Urmb/OgAZwpSQTdYEtjfrAMVZ4eL9Bjep1MJ6uSN
         XxzA==
X-Gm-Message-State: AOJu0Yxy4D2WopIzZYZcizNHOSvpsNKqPZeo0h0q6GTY4jfxbx3OCpUL
	KF49d4/8INtQYvXfTHk2XWBS8J9w31/b1jah3QKWZ3rp3D3nmTaZU2z8
X-Gm-Gg: AR+sD10s7/2dVj5Z3N9jp5iSMxszkRl0ruWTBwfZQ/rvj13Kl+km+wMF31W3RAy3scu
	A+AbYA4oZX+gUQtH9U5PdldWwClK4tKAT4rlZ6O114pn6Cu67o1TTynsDMrbArACrI93itUi1Im
	9bDe5UgHLwuVodf6TE+K8E656AUCsMksI0FCopWrhl5btoNHBW0ANPG1GeCeO+Ty02rUNHZE0Ez
	GxFAstsjJ7bvrb8kHI2mz5+R83yvwnA8XpUQB4gkxBPGBdiwPTVtzCYjFmfofFQo1TFWewCVvfa
	06b3WlnpgizvKuo6UP3IVEanjTdZZNbgQVLss9yn6rKZqu2J5wvUPApAiE/66sLnV56QkUjDHh5
	aYnBChwhonPcCRZN0V+vwSBvFsaifC3SraJWmrfHyKNCGxU5yNhsRZ5yW4LlM4uUWMKbno9wef7
	Pc02hzWcDDvU7xAfYZjhjnuJQUYyOT0lnjTw22fJbCTe4fF7JWH6b3wWNWhnzVe9DOC+UDbQXOz
	YlFtnFSYsSYWMwo7UdED1ClbLByQ2i6gbQ7JxAFPXuj3c7kCHCR/oYteXW6yt5NNiXyGh3zbMQH
	gg3ILOU7dJtaEweB2SGsjv6s1HpA7B/QNKib0F0m8MFwWsMxkuC25B0C1Msvw+BcxvuKAmCcuNY
	NKYetoqZwbDA+LNiCZ4aYQJYsiS8wqkZ/g19F3llUcp8h0bnyBIzY3nebQHMmaWdU5zPe97Rz5g
	==
X-Received: by 2002:a05:600c:1553:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-496b5731987mr26377625e9.39.1784980532364;
        Sat, 25 Jul 2026 04:55:32 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (132.red-37-158-18.dynamicip.rima-tde.net. [37.158.18.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4858e86sm41700515e9.1.2026.07.25.04.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:55:31 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 25 Jul 2026 13:55:02 +0200
Subject: [PATCH GSoC 1/5] protocol-caps: add type support to object-info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-objecttype-support-v1-1-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Teach the server-side object-info handler to accept type as a requested
field. When the client includes type in its object-info request, the
server returns the requested object type.

While at it, fix requested_info->size bit field style.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 protocol-caps.c      | 21 ++++++++++++++++++---
 t/t5701-git-serve.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index 02261be14d..5531d388f0 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -11,7 +11,8 @@
 #include "strbuf.h"
 
 struct requested_info {
-	unsigned size : 1;
+	unsigned size:1;
+	unsigned type:1;
 };
 
 /*
@@ -73,15 +74,20 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 	if (info->size)
 		packet_writer_write(writer, "size");
 
+	if (info->type)
+		packet_writer_write(writer, "type");
+
 	for_each_string_list_item (item, oid_str_list) {
 		const char *oid_str = item->string;
 		struct object_id oid;
 		size_t object_size;
+		enum object_type object_type;
 
 		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
 			packet_writer_error(
 				writer,
-				"object-info: protocol error, expected to get oid, not '%s'",
+				"object-info: protocol error, expected to get "
+				"oid, not '%s'",
 				oid_str);
 			continue;
 		}
@@ -93,7 +99,8 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 		 * If an object is not recognized by the server append SP to
 		 * the response.
 		 */
-		if (get_object_info(r->objects, &oid, &object_size) <= OBJ_NONE) {
+		object_type = get_object_info(r->objects, &oid, &object_size);
+		if (object_type <= OBJ_NONE) {
 			strbuf_addstr(&send_buffer, " ");
 			goto write;
 		}
@@ -103,6 +110,9 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 				    (uintmax_t)object_size);
 		}
 
+		if (info->type)
+			strbuf_addf(&send_buffer, " %s", type_name(object_type));
+
 write:
 		packet_writer_write(writer, "%s", send_buffer.buf);
 		strbuf_reset(&send_buffer);
@@ -124,6 +134,11 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
 			continue;
 		}
 
+		if (!strcmp("type", request->line)) {
+			info.type = 1;
+			continue;
+		}
+
 		if (parse_oid(request->line, &oid_str_list))
 			continue;
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 9a575aa098..d7c93b5b55 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -366,6 +366,33 @@ test_expect_success 'basics of object-info' '
 	test_cmp expect actual
 '
 
+test_expect_success 'type' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	size
+	type
+	oid $(git rev-parse two:two.t)
+	oid $(git rev-parse two:two.t)
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	size
+	type
+	$(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob
+	$(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare OID request' '
 	test_config transfer.advertiseObjectInfo true &&
 

-- 
2.54.0

