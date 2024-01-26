Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D765A7B8
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308748; cv=none; b=dJcdpwE8OVCRNTr2zfMoBSYuYYqJu4IYPmywJgY7HS/n06VMnlKP20IR6Awqw1OuVgApse3BuR2AWNyYVgk+kiLNMKcjmYxM5II901ngyltEf966VzvbemDNv02eKlOMcJzDCFKWgZhawZDTcRIb3qzYlk+Rw9xa1ASdfqQOkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308748; c=relaxed/simple;
	bh=BeCA9NimrzHxV5yv+yfyAVz592dcO/1kGWixHYKqjv8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d6165uRULHI/Ehjawl2h4auJKcuY2hC4r6aGdTJlKaLHK0yz/VMOY1Y6yVyOiTjHE5hDbdk8alWLgaT+Z7IY2bwrX7uIaOQByrtz0OmrybJ7PRnZ2B2PmfmFqyf7a0UYSnImUSCtAoRWOtF5jZUDtzYENMiwKmx17DUMUlxj7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsG+XJK8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsG+XJK8"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51022133a84so1213194e87.3
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308743; x=1706913543; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWcfZGdnOoF8T+7DEPxIEnkTNfcTKabTkpAgfF5BPdI=;
        b=XsG+XJK8irGtMQyzxeU0HS02O/xsKeC2HQNI+b9nvdKNGWT4qqUEa7Q6PcrAOs4d5a
         Lre8kwJ3R9MDGw1NHDwDX5I6q91C37sQ8x6OemebWL3ZLQHG/5Zy9BPbpEW3PmAhjtf+
         nsu9EX+UFGJJ3wiG3o6DhpnV7BEt2y6NM0P9z2jzsqgEvOIkwER64z/iFHOz75p9Zh2g
         zfQg+TG7gwdh87QkP2vMo9g6N9JD7fkY/2OOpxGtYtHwhg0lPGAWummX8utbNBPBWEBJ
         XqCUKT/injvcXFQ1j58VsvmM6poD9k9kznT5cRBvc7FNcQeNeEJVE5Zpaxwes4j9cjny
         sGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308743; x=1706913543;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWcfZGdnOoF8T+7DEPxIEnkTNfcTKabTkpAgfF5BPdI=;
        b=EYgJp8kZE8S93HTBtQSpiW7lDCmd0W7H6iA3vNWvLr+aVGALtFfZf3rdjgbA8mPylK
         YAguRtdtkM4wxZy9OrXTwqgFg1QFTiFTYPgF16MWwYVwFF3Y4fRyWxBZWDIMnRtvx99F
         yrXev5nlm+jRFCmZ94XNxjr+f+P/49eeETBF5J3Fq4DbdHUSpH1l9+8CWzg1k/YfPOiV
         t1PPDKVq52OwKJUWn0Wfg5EQNPCS0gO87ogvRowPKjPJ3dlbTGA1pLKBqJM7RFwuNT1j
         Iwq5RqT8CdKxI0zaZBtodI7nzu43kgxTTExj1TUdfchG4CKx7As9AdrWxGW6Q6HdpcDh
         555A==
X-Gm-Message-State: AOJu0Yx6PRsxDCcauqYlgWBQBgUsDyTC8chmnxdOotfBRltZDXqfdE+q
	wxP9ZO4Gv9vRfI3s5fI84ZNn6Dx8Wfx5LmUvjNYcX63xb0M5AAaaV6/vTJiP
X-Google-Smtp-Source: AGHT+IHlMQu3zHXG8vf0dfXpE3wXcz99bxmcb0ANiRr9/BJWpFCP49UKXeWNi24t7TrMEbFaBM9uJA==
X-Received: by 2002:a05:6512:3147:b0:50e:7749:7b99 with SMTP id s7-20020a056512314700b0050e77497b99mr605284lfi.37.1706308743305;
        Fri, 26 Jan 2024 14:39:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a0560001a4600b00337be1c7d2fsm2112463wry.58.2024.01.26.14.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:39:02 -0800 (PST)
Message-ID: <f1171f5202f576fdc73719d0ab184b0557733ec2.1706308737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:51 +0000
Subject: [PATCH v2 04/10] trailer: delete obsolete formatting functions
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 79 -------------------------------------------------------
 1 file changed, 79 deletions(-)

diff --git a/trailer.c b/trailer.c
index 7692bf9eb40..71ea2bb67f8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -144,24 +144,6 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(FILE *outfile, const char *tok, const char *val)
-{
-	char c;
-
-	if (!tok) {
-		fprintf(outfile, "%s\n", val);
-		return;
-	}
-
-	c = last_non_space_char(tok);
-	if (!c)
-		return;
-	if (strchr(separators, c))
-		fprintf(outfile, "%s%s\n", tok, val);
-	else
-		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
-}
-
 static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
 	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
@@ -1142,67 +1124,6 @@ void trailer_info_release(struct trailer_info *info)
 	free(info->trailers);
 }
 
-static void format_trailer_info(struct strbuf *out,
-				const struct trailer_info *info,
-				const char *msg,
-				const struct process_trailer_options *opts)
-{
-	size_t origlen = out->len;
-	size_t i;
-
-	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
-	    !opts->separator && !opts->key_only && !opts->value_only &&
-	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info->trailer_block_start,
-			   info->trailer_block_end - info->trailer_block_start);
-		return;
-	}
-
-	for (i = 0; i < info->trailer_nr; i++) {
-		char *trailer = info->trailers[i];
-		ssize_t separator_pos = find_separator(trailer, separators);
-
-		if (separator_pos >= 1) {
-			struct strbuf tok = STRBUF_INIT;
-			struct strbuf val = STRBUF_INIT;
-
-			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
-			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
-				if (opts->unfold)
-					unfold_value(&val);
-
-				if (opts->separator && out->len != origlen)
-					strbuf_addbuf(out, opts->separator);
-				if (!opts->value_only)
-					strbuf_addbuf(out, &tok);
-				if (!opts->key_only && !opts->value_only) {
-					if (opts->key_value_separator)
-						strbuf_addbuf(out, opts->key_value_separator);
-					else
-						strbuf_addstr(out, ": ");
-				}
-				if (!opts->key_only)
-					strbuf_addbuf(out, &val);
-				if (!opts->separator)
-					strbuf_addch(out, '\n');
-			}
-			strbuf_release(&tok);
-			strbuf_release(&val);
-
-		} else if (!opts->only_trailers) {
-			if (opts->separator && out->len != origlen) {
-				strbuf_addbuf(out, opts->separator);
-			}
-			strbuf_addstr(out, trailer);
-			if (opts->separator) {
-				strbuf_rtrim(out);
-			}
-		}
-	}
-
-}
-
 void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 const char *msg,
 				 struct strbuf *out)
-- 
gitgitgadget

