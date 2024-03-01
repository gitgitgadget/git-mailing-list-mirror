Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3217D5
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252098; cv=none; b=druHxWOUsPfjYyqV4xIbh5rUD67Dh4pin9ekRm29bFYkyQDHcthbKTDyRFWOc1xPwfXaC+wUfsyfRD90Xq5B4Kb1inp2QlIhR9WfZqDMT7y40/BNAg//iFmeyMz7sQ2UgTq7NImkcaz0WJmnTVynlr2A32W0Ardbv8CB4lhTviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252098; c=relaxed/simple;
	bh=ttUB/lGc31VezpwkxCUqYNd8Tz9/24eZbrL+BweDCnY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UaiZV8zE+7/3WObxf4o8lxRsm3UirbU7xo8DM2cK3A+QiN7vzLxU9057dguTn7Sd+A7HBKNm3EhSxxQpixx02BH6g1ZgltOKOGl4vfs8L9jU2dhoyG9zH68EP8VURA/W3jowf6XGB2p/HNNnOVfLqqffE+BRBhdzFXg7xF3pQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWGFRC5V; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWGFRC5V"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d2305589a2so19016371fa.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252094; x=1709856894; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2ChbUKr39IIl/empUwfg3AmHJCZvdutzce068y7PcQ=;
        b=EWGFRC5VqRrapUKs8G97jq0taImTLmh/oEJnOFBJ7iN08eUKCJ0a4Sy8OWq1AAiSXj
         QmCm0f1a07Pe39enXoJjy4LsLqz9sWT4euBNm55Yxy7SHeXOI8AHilbrqSFsUSvtT0rw
         5hX8poxJxLnS46TpzLjESelQPuukHH9LVzHASAABNmmZWEYeTqyEsvMn5LFtULh1ybCz
         Iu1KXkbsoCsyNYboUsIspOPUbPbKKC80IDTsFThGzQzxwPPfT5NYYJyQksmdnpoffr/v
         N3Jllzq4HwOUxon4in2qTrxmVzYJfztnQ8F4G2kOslFN8L9NZOJDtoAOEALt0pgn+jyD
         keXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252094; x=1709856894;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2ChbUKr39IIl/empUwfg3AmHJCZvdutzce068y7PcQ=;
        b=q/DF1uLiEqudNvktLnhaiy4mkvGIP3QImRIwg+JDK7Dx29yeRJpSoAMCLUuk+0z/3/
         Cw3DSeuTmS8fVaZGbgI8PBAqAmWrRoLI5sfjc2LU+b6R9NZCTnSPYdiRFbwRl5bMTn/K
         99dnpk5krAxzavMATC/G5+F/bVeiLuWAjLi9Zq7azwKVWWN+HuN8Hg5T/yt8zIl44uXQ
         zBN42IsP8YgHg9ht/tSHuhX4ZuKQjxsbLMhJE66FvwLkomxSxsKoMwSB8A6d4tFgRdKD
         tK7oBDjqlq5ut0a8+YZiRBI4nEb4j/tLdfMmC1ORrqjdIbjZFSl/7cpYsajRXHN3fAfI
         IIRw==
X-Gm-Message-State: AOJu0Yzmryv7SR84CNlOu0KUbRYblApJ1HSg+5hWFcJlKbinLSsZXdWA
	La3Id5yZkVXWj5BuaB8Fswp1iPeH4s3AScK4lCOsCg+u6PQUPJfz5NuVg94k
X-Google-Smtp-Source: AGHT+IEsLaDjbxMY7k7gjcOnrOHFMqqSmAFeEBESCBAzzP64ELxA0Y5kRxxsR0fgoxKiW/bpKus2fw==
X-Received: by 2002:a05:651c:113:b0:2d2:a8b3:a20e with SMTP id a19-20020a05651c011300b002d2a8b3a20emr2272200ljb.53.1709252094354;
        Thu, 29 Feb 2024 16:14:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b0041253d0acd6sm6573328wmm.47.2024.02.29.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:53 -0800 (PST)
Message-ID: <46c7f4c0e81d943bd42b4b4e17aa0c09bc5b518e.1709252086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:44 +0000
Subject: [PATCH v6 7/9] format_trailers(): use strbuf instead of FILE
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

