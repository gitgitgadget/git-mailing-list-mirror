Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CF1B582
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485715; cv=none; b=OVCdQ7FkX2PjeREHG099Fe7EybQanzdaZEuTZC86EZqXu65pYqpvRFwkd3fbHICvd128I2fnmRwCdZT38+YuQf1idnrRDjSyqAmzRHTWeej8oBx2/ZRNQuIirHhHRZb29Nqjh9Qj7nxjCqd3b/+LeTDstJrZTlkN3vCcE5dE4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485715; c=relaxed/simple;
	bh=G0NGK4cxJQSAkZENR16sA7TlS1M6+v/XNrRg/guMruI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ndy66n0iKfw+GeQHYMCICN/tgyywbn0PDLqTzMU9Qm3JEooEsQRh8/DvOEZ4jIGzrr9DyMEAmWUN+QTJwqvsbKcoAr7P9Uh4TrhCOWAtxqmOj+PwflPnrnyDcN+tb/nyePTrpjxJ52VvzKqHnx2jM3BKgqLazaZkoLHQ+BP8bFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cP24/QMi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP24/QMi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-414037f37cfso255995e9.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710485711; x=1711090511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cRfiy6uaxZupXSiPyjOp8LihUUZ97Kig+lbsSWYMIc=;
        b=cP24/QMiB+vktM8t8DEJQzMGhcphRuBwvAupEjr4bb9Dd8E7qN9xIybwznVsNrJ4ql
         QnktgiTXRSeFv6x1GkJIFxpXrWAZXAYXjU6WsXZ9wwX7i3lUvmOjiuC7gxw3nCMQADFw
         TnL1698uX6efGjBd09M3dOcfUkDBNxuEJNi0voL3VFQ8kU3LSWyl8eUjqynP2uQHMfd6
         QWNsPCeN6rD6l5/VPOWp70XZ9WUhmMxuNJ9uwNXn1V3/EdZOTDkc+s+brOHeJKB08M0j
         HvfS/jDqrtuaJw7QRszaRnCpZCszKHfBgMsN9PoUlv+mOw7llWin1EDaFwHOOQBR/0Qp
         Hvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710485711; x=1711090511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cRfiy6uaxZupXSiPyjOp8LihUUZ97Kig+lbsSWYMIc=;
        b=Wer53V+NihfEQbmY0hC4P6yh4GbH25QJ9DYTzTmT4duVPUDJXdyCJ6AuiSsBabjTFC
         aCu8su2yvByLjaXt/oycPXWSrJNMlokIqz3RaVeo2thOje7ECnnXMiEJHLvI5jQe7evG
         4RxNAAMHmTakma+dJKGhj1BjKrUPm0M7grvzVgsEdfCETS8Ws/dAkPmbmTStWpRAOJ4x
         UR61G3gqjNDSgoCN7B/s+8Naa+VfnRoxWtOmKp40DxdXgoNpDhLC1FbA8WbyZpjewhVq
         C0F5tRhsFWjCUq5IIWKXniw68xx5FI/x6e90xIn7mdgx604T+BEr713VjwQ+yttK0YIC
         kb7Q==
X-Gm-Message-State: AOJu0YwrCaE5jjWt0txhjuNtQL9foA3lDSKmpQZYwYrrifEsHyFWcqqI
	OEjeAYyjBEuHON++t7KjwrSkSMUaUROKvCDZGTS2aoq1mCw7xPkBtIAl/GEq
X-Google-Smtp-Source: AGHT+IHiZrz2knMAPp6fyWEBQ4lDRgw/AOfGle+NOvHkmYPj639a0otKOfCXgPSezx8egT0vSvvzCg==
X-Received: by 2002:a05:600c:4e0c:b0:413:fecb:9240 with SMTP id b12-20020a05600c4e0c00b00413fecb9240mr1008306wmq.35.1710485711359;
        Thu, 14 Mar 2024 23:55:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c35c300b004132960286esm4796839wmq.34.2024.03.14.23.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:55:11 -0700 (PDT)
Message-ID: <f8b102a5b8c898100d24e50d197ef0a24b17a247.1710485706.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 06:55:04 +0000
Subject: [PATCH 4/5] trailer: begin formatting unification
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Christian Couder [ ]" <chriscool@tuxfamily.org>,
    "Junio C Hamano [ ]" <gitster@pobox.com>,
    "Emily Shaffer [ ]" <nasamuffin@google.com>,
    "Josh Steadmon [ ]" <steadmon@google.com>,
    "Randall S. Becker [ ]" <rsbecker@nexbridge.com>,
    "Christian Couder [ ]" <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Now that the preparatory refactors are over, we can replace the call to
format_trailers() in interpret-trailers with format_trailer_info(). This
unifies the trailer formatting machinery

In order to avoid breakages in t7502 and t7513, we have to steal the
features present in format_trailers(). Namely, we have to teach
format_trailer_info() as follows:

  (1) make it aware of opts->trim_empty, and

  (2) make it avoid hardcoding ": " as the separator and space (which
  can result in double-printing these characters).

For (2), make it only print the separator and space if we cannot find
any recognized separator somewhere in the key (yes, keys may have a
trailing separator in it --- we will eventually fix this design but not
now). Do so by copying the code out of print_tok_val(), and deleting the
same function.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  2 +-
 trailer.c                    | 54 ++++++++++++------------------------
 trailer.h                    |  2 +-
 3 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 11f4ce9e4a2..f57af0db37b 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -171,7 +171,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	}
 
 	/* Print trailer block. */
-	format_trailers(opts, &head, &trailer_block);
+	format_trailer_info(opts, &head, &trailer_block);
 	free_trailers(&head);
 	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
 	strbuf_release(&trailer_block);
diff --git a/trailer.c b/trailer.c
index fe8b0819d55..43d5baef9ce 100644
--- a/trailer.c
+++ b/trailer.c
@@ -144,38 +144,6 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(struct strbuf *out, const char *tok, const char *val)
-{
-	char c;
-
-	if (!tok) {
-		strbuf_addf(out, "%s\n", val);
-		return;
-	}
-
-	c = last_non_space_char(tok);
-	if (!c)
-		return;
-	if (strchr(separators, c))
-		strbuf_addf(out, "%s%s\n", tok, val);
-	else
-		strbuf_addf(out, "%s%c %s\n", tok, separators[0], val);
-}
-
-void format_trailers(const struct process_trailer_options *opts,
-		     struct list_head *trailers,
-		     struct strbuf *out)
-{
-	struct list_head *pos;
-	struct trailer_item *item;
-	list_for_each(pos, trailers) {
-		item = list_entry(pos, struct trailer_item, list);
-		if ((!opts->trim_empty || strlen(item->value) > 0) &&
-		    (!opts->only_trailers || item->token))
-			print_tok_val(out, item->token, item->value);
-	}
-}
-
 static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
 	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
@@ -1084,9 +1052,9 @@ void trailer_info_release(struct trailer_info *info)
 	free(info->trailers);
 }
 
-static void format_trailer_info(const struct process_trailer_options *opts,
-				struct list_head *trailers,
-				struct strbuf *out)
+void format_trailer_info(const struct process_trailer_options *opts,
+			 struct list_head *trailers,
+			 struct strbuf *out)
 {
 	size_t origlen = out->len;
 	struct list_head *pos;
@@ -1100,6 +1068,15 @@ static void format_trailer_info(const struct process_trailer_options *opts,
 			strbuf_addstr(&tok, item->token);
 			strbuf_addstr(&val, item->value);
 
+			/*
+			 * Skip key/value pairs where the value was empty. This
+			 * can happen from trailers specified without a
+			 * separator, like `--trailer "Reviewed-by"` (no
+			 * corresponding value).
+			 */
+			if (opts->trim_empty && !strlen(item->value))
+				continue;
+
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
 				if (opts->separator && out->len != origlen)
 					strbuf_addbuf(out, opts->separator);
@@ -1108,8 +1085,11 @@ static void format_trailer_info(const struct process_trailer_options *opts,
 				if (!opts->key_only && !opts->value_only) {
 					if (opts->key_value_separator)
 						strbuf_addbuf(out, opts->key_value_separator);
-					else
-						strbuf_addstr(out, ": ");
+					else {
+						char c = last_non_space_char(tok.buf);
+						if (c && !strchr(separators, c))
+							strbuf_addf(out, "%c ", separators[0]);
+					}
 				}
 				if (!opts->key_only)
 					strbuf_addbuf(out, &val);
diff --git a/trailer.h b/trailer.h
index 1d106b6dd40..3c13006a4c1 100644
--- a/trailer.h
+++ b/trailer.h
@@ -101,7 +101,7 @@ void trailer_info_get(const struct process_trailer_options *,
 void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
-void format_trailers(const struct process_trailer_options *,
+void format_trailer_info(const struct process_trailer_options *,
 		     struct list_head *trailers,
 		     struct strbuf *out);
 void free_trailers(struct list_head *);
-- 
gitgitgadget

