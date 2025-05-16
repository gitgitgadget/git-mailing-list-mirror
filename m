Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FDE2E628
	for <git@vger.kernel.org>; Fri, 16 May 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357357; cv=none; b=UJKHx68aRerpcWpUji4n9kcwx+0E1+nVxeWIj/tQ5WprEH8gMQXNoKW1SL2HPpbKLqy1iyU0YVMTgYqaoUjZ2rhgiA5mJdOmaJnFR3KWErEdRoPuXqDRXLRQ0Orm1w9UXhfy9cjaFCCYBP2EIrRZWmzUNaI9zYPZwWay3NB7n+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357357; c=relaxed/simple;
	bh=ytOYHabBNj/x6r/xnfXP0OV9Kt/m9q3lR55GqZjvLwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oY6HMsNaMDqp9tSBGDa5Myw+Yv0jyvQWuL9EtPEBCFyTtMHCHyS9J35FcyaIy2sUpCjkgUXDAtIRAxl3NYcRzzVFH/iudvUlJW/tsRhDZPZxuKAyCn4HAV49Qw7P7zS9ixo9HEGMuVG2dhH1vrlPbU6jbWwkQB3spzrD0w/oHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaWhQQQp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaWhQQQp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7423fb98cb1so1867533b3a.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 18:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747357355; x=1747962155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeVqv7CyMTDdlIx83Gpvr7aMs2DSstSLGdGqDCCpZps=;
        b=OaWhQQQpQlgQLUJNWcWOThpFVOVhqM2K8s3rgQWSPZkSPnj0P9VLPgMrEN+3c0PtS/
         1LmSKEgZkCnRuWJcBbdu8b22TQwIDqbrWULmbIKqHpCgxf8p8ZMj36wf1LYC1oVwSIzF
         sXKh7t1IFaBz8SBpZQNsAIv2d7y8eF2kmK1ME69OG1X/PZAoCt94wLgDczZ2t9N076nC
         9N82ldSJwe52VajTTh9w2yp6IOwhusIl2T7NV4Fl/BfP6PME9hmSlgE4BG564NaESHWp
         JYZidyHWv1Mkj7oC2RxB9cNN9wLlKCAcKewoy/UMKponUqfyvjRApOlqLa8ivl+B1vgS
         og8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747357355; x=1747962155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeVqv7CyMTDdlIx83Gpvr7aMs2DSstSLGdGqDCCpZps=;
        b=XaQtzVkJWhT+f1NzQ/jdTGADd2/WwkxjrUbBzIgaYqQOZK/3A+o9yjcAAGTOhqXjWO
         em4UPjnykmgSSVuBSqpkqKWbZ+lZpxfKhIQLO3C3JWOz+Y/EXJbgRDmhHHPJEl4DGvcP
         ogCe6z+QlF99iMZwOiqFjT0ZWVQ2MP3d0Yy5/T5idO/Tv4mGDZqUjNdrVdqGisGsVa/i
         TeZiJf6Yhub+Az0BOHK23DgXZn4U/7S6n/dBNBARKdSCq6NL41Lf1XhyZltLo8mwyxmA
         0fqlm3rWY5vZJY6/A2y4xWC/oyKNEhDeizBE6A/1MwzPgHH4OefzFTvaI7sg73QBliwG
         h3Lg==
X-Gm-Message-State: AOJu0Yz7yDhgdPazCERfyXippICbvHll+uW74dBWn+G+sDR2hVn7nN6/
	Pry/lHJNnjrASnmMvooCcBQAs1Y7FQSSQI+ldY+49n2arceBI/+vMO8ie53kwA==
X-Gm-Gg: ASbGncvHpto4TgCWjeKeeuJu9mGsnAC7nIT9b4wSibs8JPkb9FI7OVpSCJhAis4K6S3
	Bv2X5ipgC0aHm023gAu78IRrEiPKQMlqP9ECiAkp0y9FW4WHvngMBbUg4JW1+Y/b7GNvddmP82d
	kfqImy7WV3FX9jiHKoP56v3AG8KtGI6B8knqGPFzYUwqPvDFq5LxlBYi7CDT0k2azuodWZvMxNu
	4kj6fGoMZPJ3zDZNpbvITfGVVTaBH3QHujjbJXHnv/wG1NMKrERn+hEmHXviaiDzyqhfAyRrIng
	3owaq32RmjbCXJR4x5GJ2RezXJcclhq37oUKh8IKPVl7KpxrNXIblEDxDymV84vauiqyTa68cpJ
	puLf57KRiE5IPuIY=
X-Google-Smtp-Source: AGHT+IEdPQOG6pIvB1Rt8YniC/xEX95KcIGQ247sJtZ4gqmIF2d9fPg2SWYYXOnxVfpxty0kYZ4dOw==
X-Received: by 2002:a05:6a00:91d3:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-742a9786a79mr1539018b3a.1.1747357354543;
        Thu, 15 May 2025 18:02:34 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:86ae:c830:7026:45db:9f87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9738f13sm437329b3a.74.2025.05.15.18.02.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 May 2025 18:02:34 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v3 1/2] json-writer: add docstrings to jw_* functions
Date: Thu, 15 May 2025 22:01:58 -0300
Message-Id: <20250516010159.27042-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250516010159.27042-1-lucasseikioshiro@gmail.com>
References: <20250516010159.27042-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a docstring for each function that manipulates json_writers.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 json-writer.c |   4 --
 json-writer.h | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/json-writer.c b/json-writer.c
index 8c5187e9fd..34577dc25f 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -268,10 +268,6 @@ static void append_sub_jw(struct json_writer *jw,
 	strbuf_addbuf(&jw->json, &value->json);
 }
 
-/*
- * Append existing (properly terminated) JSON sub-data (object or array)
- * as-is onto the given JSON data.
- */
 void jw_object_sub_jw(struct json_writer *jw, const char *key,
 		      const struct json_writer *value)
 {
diff --git a/json-writer.h b/json-writer.h
index 04413bd1af..0e8e6c3ddc 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -69,42 +69,185 @@ struct json_writer
 	.open_stack = STRBUF_INIT, \
 }
 
+/*
+ * Initialize a json_writer with empty values.
+ */
 void jw_init(struct json_writer *jw);
+
+/*
+ * Release the internal buffers of a json_writer.
+ */
 void jw_release(struct json_writer *jw);
 
+/*
+ * Begin the json_writer using an object as the top-level data structure. If
+ * pretty is set to 1, the result will be a human-readable and indented JSON,
+ * and if it is set to 0 the result will be minified single-line JSON.
+ */
 void jw_object_begin(struct json_writer *jw, int pretty);
+
+/*
+ * Begin the json_writer using an array as the top-level data structure. If
+ * pretty is set to 1, the result will be a human-readable and indented JSON,
+ * and if it is set to 0 the result will be minified single-line JSON.
+ */
 void jw_array_begin(struct json_writer *jw, int pretty);
 
+/*
+ * Append a string field to the current object of the json_writer, given its key
+ * and its value. Trigger a BUG when not in an object.
+ */
 void jw_object_string(struct json_writer *jw, const char *key,
 		      const char *value);
+
+/*
+ * Append an int field to the current object of the json_writer, given its key
+ * and its value. Trigger a BUG when not in an object.
+ */
 void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t value);
+
+/*
+ * Append a double field to the current object of the json_writer, given its key
+ * and its value. The precision parameter defines the number of significant
+ * digits, where -1 can be used for maximum precision. Trigger a BUG when not in
+ * an object.
+ */
 void jw_object_double(struct json_writer *jw, const char *key, int precision,
 		      double value);
+
+/*
+ * Append a boolean field set to true to the current object of the json_writer,
+ * given its key. Trigger a BUG when not in an object.
+ */
 void jw_object_true(struct json_writer *jw, const char *key);
+
+/*
+ * Append a boolean field set to false to the current object of the json_writer,
+ * given its key. Trigger a BUG when not in an object.
+ */
 void jw_object_false(struct json_writer *jw, const char *key);
+
+/*
+ * Append a boolean field to the current object of the json_writer, given its
+ * key and its value. Trigger a BUG when not in an object.
+ */
 void jw_object_bool(struct json_writer *jw, const char *key, int value);
+
+/*
+ * Append a null field to the current object of the json_writer, given its key.
+ * Trigger a BUG when not in an object.
+ */
 void jw_object_null(struct json_writer *jw, const char *key);
+
+/*
+ * Append a field to the current object of the json_writer, given its key and
+ * another json_writer that represents its content. Trigger a BUG when not in
+ * an object.
+ */
 void jw_object_sub_jw(struct json_writer *jw, const char *key,
 		      const struct json_writer *value);
 
+/*
+ * Start an object as the value of a field in the current object of the
+ * json_writer. Trigger a BUG when not in an object.
+ */
 void jw_object_inline_begin_object(struct json_writer *jw, const char *key);
+
+/*
+ * Start an array as the value of a field in the current object of the
+ * json_writer. Trigger a BUG when not in an object.
+ */
 void jw_object_inline_begin_array(struct json_writer *jw, const char *key);
 
+/*
+ * Append a string value to the current array of the json_writer. Trigger a BUG
+ * when not in an array.
+ */
 void jw_array_string(struct json_writer *jw, const char *value);
+
+/*
+ * Append an int value to the current array of the json_writer. Trigger a BUG
+ * when not in an array.
+ */
 void jw_array_intmax(struct json_writer *jw, intmax_t value);
+
+/*
+ * Append a double value to the current array of the json_writer. The precision
+ * parameter defines the number of significant digits, where -1 can be used for
+ * maximum precision. Trigger a BUG when not in an array.
+ */
 void jw_array_double(struct json_writer *jw, int precision, double value);
+
+/*
+ * Append a true value to the current array of the json_writer. Trigger a BUG
+ * when not in an array.
+ */
 void jw_array_true(struct json_writer *jw);
+
+/*
+ * Append a false value to the current array of the json_writer. Trigger a BUG
+ * when not in an array.
+ */
 void jw_array_false(struct json_writer *jw);
+
+/*
+ * Append a boolean value to the current array of the json_writer. Trigger a BUG
+ * when not in an array.
+ */
 void jw_array_bool(struct json_writer *jw, int value);
+
+/*
+ * Append a null value to the current array of the json_writer. Trigger a BUG
+ * when not in an array.
+ */
 void jw_array_null(struct json_writer *jw);
+
+/*
+ * Append a json_writer as a value to the current array of the
+ * json_writer. Trigger a BUG when not in an array.
+ */
 void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value);
+
+/*
+ * Append the first argc values from the argv array of strings to the current
+ * array of the json_writer. Trigger a BUG when not in an array.
+ *
+ * This function does not provide safety for cases where the array has less than
+ * argc values.
+ */
 void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv);
+
+/*
+ * Append a null-terminated array of strings to the current array of the
+ * json_writer. Trigger a BUG when not in an array.
+ */
 void jw_array_argv(struct json_writer *jw, const char **argv);
 
+/*
+ * Start an object as a value in the current array of the json_writer. Trigger a
+ * BUG when not in an array.
+ */
 void jw_array_inline_begin_object(struct json_writer *jw);
+
+/*
+ * Start an array as a value in the current array. Trigger a BUG when not in an
+ * array.
+ */
 void jw_array_inline_begin_array(struct json_writer *jw);
 
+/*
+ * Return whether the json_writer is terminated. In other words, if the all the
+ * objects and arrays are already closed.
+ */
 int jw_is_terminated(const struct json_writer *jw);
+
+/*
+ * Terminates the current object or array of the json_writer. In other words,
+ * append a ] if the current array is not closed or } if the current object
+ * is not closed.
+ *
+ * Abort the execution if there's no object or array that can be terminated.
+ */
 void jw_end(struct json_writer *jw);
 
 #endif /* JSON_WRITER_H */
-- 
2.39.5 (Apple Git-154)

