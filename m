Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0D148FF0
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124962; cv=none; b=iP+cYVpU8AAzD0hNDJQPofgtn3Zbap1wLI4fqVeo9cZI6Piz0xFpuaOY/8BsuzJfxLYjJlhbEF3CO2QIBNS3BCeCd+zzDMEO09bfMKVKicsOsJxhzPTfbPUvMwX+KWz89PevZ4pskNLz2Qi+XVSBLbEAD4gzz35t2mCmBd+YHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124962; c=relaxed/simple;
	bh=ttUB/lGc31VezpwkxCUqYNd8Tz9/24eZbrL+BweDCnY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NGIrNFwxMLjjkwuoR9puZYhRffnKig+16QVzo9VwzmOvIj1b9qfo0xpY+pVspDMmUHVDwmg3VuKz9w4F4xiFV9XIAZ68AR77om34cjcSM7EXEpTTTJ4hE4HE3Uy5cyfrKV4l/OkKHwDNK/LXfdpjgKiGkkSc1TdUGxBpecEwf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx6JCOWA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx6JCOWA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d01faf711so1133355f8f.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124958; x=1708729758; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2ChbUKr39IIl/empUwfg3AmHJCZvdutzce068y7PcQ=;
        b=Rx6JCOWATuGz85pOd43DDiGSCnfg/wcf6x0++rOqPzPjmn1ho6YMj5DMW4A+cH1D9S
         kQXg58Rt0czxNYaOviursFLt6z5pItCy8mRsGckPDTmhccl9wUpyDmBeIgIbtSlikoB1
         qtjjE/UJbdeMe9uIilkFoWqKwzoZtcCm0rt63j5b1sIgXLs9K3bZFUBlrLm2TJeoRSgm
         h4QUcONGgl22f6HShVIE7kPozTTAwjtYraSlp97xRHa7diEFR6vo//cPZRdqL7ncEKuo
         XfYQojYl7NjGalu9Lozkan4tIL0bXv8FuO18CSIvdSrihUcpPsxd0hUZv3YSF6QqqAjz
         LGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124958; x=1708729758;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2ChbUKr39IIl/empUwfg3AmHJCZvdutzce068y7PcQ=;
        b=UnA5meVaQWIgWnS17Dwzt3hEzNrniy7Hhyjl/6LqcQYpO0zFjB5LwSydqM6SGs8Y7Z
         tkUneGHWjTCmijizDuNwf9kDu4rh7RoUpeVmrI5mA8k9rGZ4DhRfRNNt6ibTy5g8tR7B
         wwgt48FhIx6cfoMAIpb6qWtRg34Aa1vnK2mX+aJe2zoIka/n+ES/yMIFLwsm6965/rkz
         EJ5EXgKG2skP+NyCFIZ7NaJcYjwcHJ2kdqmUCAUFC9zR/bi5JTYPVJh7ALocw8j93R2/
         sJTApdL7CwD2ZeQbtvV/qQ1Ph13gaavy693Efuihw6Teq8n5L+gTNLTt425BYoRPta8K
         +cAg==
X-Gm-Message-State: AOJu0YyAc5E7bx1hhWaCJWUL9m22zeH2nVQU0NbFa6rTSa4ihjPGE6WA
	U7Zt9Z+ZRXuV37wJKIn9Trs+T3tQNf7ffoalQDjEIcEYdZUuAf8CRuklAXkh
X-Google-Smtp-Source: AGHT+IF52iuoaupResgiuofNIsI35DauqtKjPHf2pU/sv6i2pUlSENHebKboGOQgPdusv9JXWx4nrA==
X-Received: by 2002:adf:f2ce:0:b0:33b:139e:9110 with SMTP id d14-20020adff2ce000000b0033b139e9110mr4117435wrp.36.1708124958605;
        Fri, 16 Feb 2024 15:09:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19-20020a1c4b13000000b00412156abf32sm3502714wma.16.2024.02.16.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:09:18 -0800 (PST)
Message-ID: <9dc912b5bc5ff07fedc0dd217b5ecb8a1eb10cc3.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Feb 2024 23:09:08 +0000
Subject: [PATCH v5 7/9] format_trailers(): use strbuf instead of FILE
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
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This is another preparatory refactor to unify the trailer formatters.

Make format_trailers() also write to a strbuf, to align with
format_trailers_from_commit() which also does the same. Doing this makes
format_trailers() behave similar to format_trailer_info() (which will
soon help us replace one with the other).

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  6 +++++-
 trailer.c                    | 13 +++++++------
 trailer.h                    |  3 ++-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index d1cf0aa33a2..11f4ce9e4a2 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -140,6 +140,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf trailer_block = STRBUF_INIT;
 	struct trailer_info info;
 	FILE *outfile = stdout;
 
@@ -169,8 +170,11 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 		process_trailers_lists(&head, &arg_head);
 	}
 
-	format_trailers(opts, &head, outfile);
+	/* Print trailer block. */
+	format_trailers(opts, &head, &trailer_block);
 	free_trailers(&head);
+	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
+	strbuf_release(&trailer_block);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
diff --git a/trailer.c b/trailer.c
index f92d844361a..cbd643cd1fe 100644
--- a/trailer.c
+++ b/trailer.c
@@ -144,12 +144,12 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(FILE *outfile, const char *tok, const char *val)
+static void print_tok_val(struct strbuf *out, const char *tok, const char *val)
 {
 	char c;
 
 	if (!tok) {
-		fprintf(outfile, "%s\n", val);
+		strbuf_addf(out, "%s\n", val);
 		return;
 	}
 
@@ -157,13 +157,14 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 	if (!c)
 		return;
 	if (strchr(separators, c))
-		fprintf(outfile, "%s%s\n", tok, val);
+		strbuf_addf(out, "%s%s\n", tok, val);
 	else
-		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
+		strbuf_addf(out, "%s%c %s\n", tok, separators[0], val);
 }
 
 void format_trailers(const struct process_trailer_options *opts,
-		     struct list_head *trailers, FILE *outfile)
+		     struct list_head *trailers,
+		     struct strbuf *out)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
@@ -171,7 +172,7 @@ void format_trailers(const struct process_trailer_options *opts,
 		item = list_entry(pos, struct trailer_item, list);
 		if ((!opts->trim_empty || strlen(item->value) > 0) &&
 		    (!opts->only_trailers || item->token))
-			print_tok_val(outfile, item->token, item->value);
+			print_tok_val(out, item->token, item->value);
 	}
 }
 
diff --git a/trailer.h b/trailer.h
index 410c61b62be..1d106b6dd40 100644
--- a/trailer.h
+++ b/trailer.h
@@ -102,7 +102,8 @@ void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
 void format_trailers(const struct process_trailer_options *,
-		     struct list_head *trailers, FILE *outfile);
+		     struct list_head *trailers,
+		     struct strbuf *out);
 void free_trailers(struct list_head *);
 
 /*
-- 
gitgitgadget

