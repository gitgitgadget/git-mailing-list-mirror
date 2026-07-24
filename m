Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5A42376B
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890484; cv=none; b=miAqCdH9GbwP/UK0h+2Mu0nl6PK6YBrw4mnC/YIYr1BZAQCWIFAycMzeoALCzT89YB2idd7HwPbnQNElvoaK10/B1NvmARDrRMC2jYUwyg/qaJC7/7otKWAJ+IUaDI5SxFtBC0FKa1seCuGXnaHl+rYfTHyscEYRinXW2dDwJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890484; c=relaxed/simple;
	bh=quNPQ5ARs/cJAS0qhanXe3ka0KJ6gexQ6eXipsAXAlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lr9kpwGaPrKd2jNt5kFd9OIzXOy7kdXhh2788GYkq376JEzX3/b/7YeSZDUIGoxtLukhJxsBIIoLmrnkex+QbTNDXgZQUs61PPRZlQWhP8IvKzNbqu4JnY2JwxRN1/fAZwCI+IGYcqWVcD4B78QMzF4xjQFaKakJRz7nLnC25Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjg0sl8F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjg0sl8F"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso1931335e9.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890479; x=1785495279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vA1wGWZ4NMtuGA32lyCT4Km46waNTEO892vawSQBSkc=;
        b=Rjg0sl8FVcXvr+9XazZFXDoDEgO8UuVmhIjzFQvDrISZmBZdebO9EfUQhtJ30Fr+7l
         05bIVKRFoU6wI0qKSfVR0y3uw3u2q5AZB5cIYdMJCpyYawSeOWbDyI4/C7DKP8XSMV1g
         mZmk/VXdPNmynvLdOr7A/4QtqYdEZV8bs/KPNwefS4KWEh5xGX7pCEJRcOsUR6JhoKg0
         If9kLXSUmY0BlUPWxTBMaLTAiEFnTg0QEPblr/cP75JIfrDGeBLr3eLJ7i+uMy9MPGiI
         yCe3/gWQzUlo4aoctwtmJ0BdTFgwGCr1ZMPgpzLkvTP0DJk1fZutx++sxlK0xjF/qdNv
         3ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890479; x=1785495279;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vA1wGWZ4NMtuGA32lyCT4Km46waNTEO892vawSQBSkc=;
        b=SNiuQ0QgGnuI/I5p3WolBlj0Ow1UAUxzXJOLIb8M6RgLbC4LXp5hX97PJDPNSfr8nU
         LZqaR7/e4MK+A85b1rxGqy4C5iYesPZQ5k4sdT10bagako6atZw3ZyYAPV5KoZLtVmNf
         N3m2Efvbgu5ww73g1q6sKkMGptH084el3g2Xv9ZnZLrjEpC9MIdQXculQKcOM2ZiDhP4
         7N76agz65SJtVfqD5zEQKGaFI6VktMfFc2xKlPRW1Pftvj8H5TXeHhX6aCNW/zMvEHlG
         o5SBIjH5TPbLGfA/g5yKyoFI9i8lydGrY3F5d/IrLnhRGGLLctC83QT7sE8b/RJuG3wC
         KjhQ==
X-Gm-Message-State: AOJu0Yx1aGxvO9BQod+RmPMp9Y1UA46qpIVJgrnYWlhCZdI2Wf9xC5Fi
	bJhndfXzn4HXD35uSBAD3JQBTyDw8AcUi/mcldu2W/4PAqfJli76o2TFZtQFY01I
X-Gm-Gg: AR+sD12aqZgi08qkrgr6uPz3RChDTdtbSOWR4QRdlFtp/gaEf25JkkTOMQ3aG2MH5a/
	p4qADGlBzL5qw1YxZSXZzetzr+XUO2QGiqQfP5xznDG3/8kLPjCfa1aAc9bII6hLzs6WknNx38T
	KXoHm5x2d9CUT6xUEk4mWhXZ/ySL9PagWokd4NgyFn+umqeC6H/ALn4fmRlyTD3KfgxEJp7ocMK
	nptpIkk5qmiAd0HSxwrUuWObK9b1nfvJ7VdyZJmGanuHXbFsLEqixPatQt/unGDDE9gGPLiGVyE
	cNZI47Aw6i01q5Ghn8MODMMi/bwoxXsswJygyKG01WHbNz5qfS3j7HJMbO9X2ieKNTG5tT96bHH
	RsS/xiu4VrIkPZlVdmp2tlTPsr04AVfTopWvUpV9k15DTF4qA3lp7k1JC4wvqu/r8n2NiHRF7hI
	GwBg102j3wojrABAnQMZFH+nD9wqRcVTKZJaFTZXu3rNd/bL5gd9eglhlLXkQGxHDk2uwKvCDYb
	9FljgZkb7AKA8XCXfRDy6IpVY0www6HQcPaDMlU+fOfW8RdgUdqbEdlQ/tTPywluHjFD7sf+zrS
	cuQZ9j1J7+w2qJKdejCmWcbxWk40RPOpZai0
X-Received: by 2002:a05:600c:2049:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-49573cc1a7cmr53899065e9.4.1784890479453;
        Fri, 24 Jul 2026 03:54:39 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:39 -0700 (PDT)
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
Subject: [PATCH GSoC v21 09/13] protocol-caps: check object existence regardless of the attributes requested
Date: Fri, 24 Jul 2026 12:54:20 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-9-ba67f024fdff@gmail.com>
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

Currently, send_info() only checks for existence when the attribute
'size' is also requested. Requesting a bare OID, without attributes only
echoes back the OID.

Extract the existence check to be done regardless of the number of
attributes requested.

While at it, introduce a wrapper called get_object_info() similar to
odb_read_object_info() that returns OBJ_BAD on fail and adds
OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK flags.
OBJECT_INFO_SKIP_FETCH_OBJECT is so a server with a partial clone
doesn't trigger fetching objects when it gets an object-info request
with an OID that is not available locally. A server should only report
what it has locally.

Tighten the condition used to determine whether an object is
recognized. get_object_info() returns OBJ_BAD for unknown objects,
but OBJ_NONE (0) can also mean "not found". Change the check from '< 0'
to '<= OBJ_NONE' to cover both as unrecognized.

With this patch, a bare OID has two possible responses:

1. Recognized OID: the server answers with "<OID>"

2. Unrecognized OID: the server answers with "<OID> SP"

Update the object-info section in 'gitprotocol-v2.adoc':
- Require full obj-oid explicitly.
- Fix parentheses.
- Define obj-size explicitly.
- Make obj-size optional in obj-info and document the behavior
  for unrecognized object IDs.
- Describe the attr header as zero or more pkt-lines, one per attribute,
  matching what the server implements. A request with no attributes gets
  no header.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/gitprotocol-v2.adoc | 21 ++++++++-----
 protocol-caps.c                   | 45 ++++++++++++++++++++++++----
 t/t5701-git-serve.sh              | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 2beb70595f..7bf62014c3 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -568,21 +568,26 @@ An `object-info` request takes the following arguments:
 
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
-	information for.
+	information for. They must be full OIDs.
 
-The response of `object-info` is a list of the requested object ids
-and associated requested information, each separated by a single space.
+The response of `object-info` consists of one pkt-line per requested attribute,
+echoing the attributes the server will report, followed by one pkt-line per
+requested object id with its information, each field separated by a single
+space.
 
 	output = info flush-pkt
 
-	info = PKT-LINE(attrs) LF)
-		*PKT-LINE(obj-info LF)
-
-	attrs = attr | attrs SP attrs
+	info = *PKT-LINE(attr LF)
+	       *PKT-LINE(obj-info LF)
 
 	attr = "size"
 
-	obj-info = obj-id SP obj-size
+	obj-size = 1*DIGIT
+
+	obj-info = obj-id [SP [obj-size]]
+
+If the server does not recognize the OID, the response will be `<oid> SP`
+regardless of the number of attributes requested.
 
 bundle-uri
 ~~~~~~~~~~
diff --git a/protocol-caps.c b/protocol-caps.c
index 8858ea4489..02261be14d 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -30,6 +30,32 @@ static int parse_oid(const char *line, struct string_list *oid_str_list)
 	return 1;
 }
 
+/*
+ * odb_read_object_info_extended() wrapper. Similar to odb_read_object_info()
+ * but uses the flags:
+ *
+ * - OBJECT_INFO_SKIP_FETCH_OBJECT so a server won't fetch an object when a
+ *   object-info request asks for an OID that it doesn't have.
+ *
+ * - OBJECT_INFO_QUICK to avoid re-scanning packs when the object is not found.
+ */
+static enum object_type get_object_info(struct object_database *odb,
+			   const struct object_id *oid,
+			   size_t *sizep)
+{
+	enum object_type type;
+	struct object_info oi = OBJECT_INFO_INIT;
+
+	oi.typep = &type;
+	oi.sizep = sizep;
+	if (odb_read_object_info_extended(odb, oid, &oi,
+					  OBJECT_INFO_LOOKUP_REPLACE |
+					  OBJECT_INFO_SKIP_FETCH_OBJECT |
+					  OBJECT_INFO_QUICK) < 0)
+		return OBJ_BAD;
+	return type;
+}
+
 /*
  * Validates and send requested info back to the client. Any errors detected
  * are returned as they are detected.
@@ -62,15 +88,22 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 
 		strbuf_addstr(&send_buffer, oid_str);
 
+		/*
+		 * Check the existence of the object first.
+		 * If an object is not recognized by the server append SP to
+		 * the response.
+		 */
+		if (get_object_info(r->objects, &oid, &object_size) <= OBJ_NONE) {
+			strbuf_addstr(&send_buffer, " ");
+			goto write;
+		}
+
 		if (info->size) {
-			if (odb_read_object_info(r->objects, &oid, &object_size) < 0) {
-				strbuf_addstr(&send_buffer, " ");
-			} else {
-				strbuf_addf(&send_buffer, " %"PRIuMAX,
-					    (uintmax_t)object_size);
-			}
+			strbuf_addf(&send_buffer, " %"PRIuMAX,
+				    (uintmax_t)object_size);
 		}
 
+write:
 		packet_writer_write(writer, "%s", send_buffer.buf);
 		strbuf_reset(&send_buffer);
 	}
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 108eb30945..9a575aa098 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -7,6 +7,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+unknown_oid=$(printf "test" | git hash-object --stdin)
+
 test_expect_success 'setup to generate files with expected content' '
 	printf "agent=git/%s" "$(git version | cut -d" " -f3)" >agent_capability &&
 
@@ -364,6 +366,67 @@ test_expect_success 'basics of object-info' '
 	test_cmp expect actual
 '
 
+test_expect_success 'bare OID request' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	oid $(git rev-parse two:two.t)
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse two:two.t)
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'object-info with bare unrecognized OID' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	oid $unknown_oid
+	0000
+	EOF
+
+	printf "%s \n" "$unknown_oid" >expect &&
+	printf "0000\n" >>expect &&
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'object-info with size for unrecognized OID' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	size
+	oid $unknown_oid
+	0000
+	EOF
+
+	printf "size\n" >expect &&
+	printf "%s \n" "$unknown_oid" >>expect &&
+	printf "0000\n" >>expect &&
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'test capability advertisement with uploadpack.advertiseBundleURIs' '
 	test_config uploadpack.advertiseBundleURIs true &&
 

-- 
2.54.0
