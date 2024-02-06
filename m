Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3437CF23
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196363; cv=none; b=PVLmZ7BzqNm+FYzv15vERQckgj0M1vFUBnLJGeadBPqbg437Nr4Dn1TQYrhUjxjP2N15s97ZcBzCmC26Wj31s3VxU5aYkOKQKShtbaem/ZQboXqXczh/qzrxkU9U63YIF4dEF16c0tjm2bQ1WIiOwtdDGEFS5+v3nOSrpWHTJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196363; c=relaxed/simple;
	bh=jvQWPxf7kpxSJj/54NmB40/CUhVRrZoz5BssuSfyvSc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ReCfO8kBqsDC0kfwiPYYc5sGU5hI4AA38HA52FNF+EmIHoJuQszdurrk/eesY7kQdU0dSeORhsr3ZFMlIMwmgvpNxAErnmoQ8FWvkdjVwn9RjC/Y9EuvGwHq187xeXLLymfwO5qZamgQKzIM1p7L6UFnb0W+wJn7PtYjgvFQvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g98ztMlc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g98ztMlc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fe00cb134so5697535e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196360; x=1707801160; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIw1jmLJIxWt2mChf3XzMatF0mxGbl45fmiYLc5det4=;
        b=g98ztMlcUJZLUpuO5qcmq1c/9uipw5dRsYsl7Y2pfzp+rW/L9BK1YaQkrmGMZxRLnf
         DQoIm/qyLsojs4JN8W3gKfxGL41YfkCxZooLrkrWzJzaJ5+BcziRDv3EIVWjWUd4e9Jq
         VORWOgY30UUjqnOxC2rvcHNhVOoVTSku7nc/IThu81+9afZw8uEK9eNX//BQ0cbB/pYd
         G1rlAi2YVyX8nYVx/RfM4iDUlXkWOT3Phh16vGMC2FU1Plwu9Ym5eWz+IZdYLXGrYUS7
         Tyf+AWIGgmPGn3KBH3dRN8hfnopvyh32Fcie4fyH3wdV+PatLHstBfrFnsZNr4mt9k9h
         Y+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196360; x=1707801160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIw1jmLJIxWt2mChf3XzMatF0mxGbl45fmiYLc5det4=;
        b=ezy40xygUAKNerinmRn/D8+ETUndNUrl3FJnjEPxHKu/JmNk/cT+buuHe86a5Ol8t8
         19GEHjY69m43NqDdO0scy5PMhxWS8sZuUtBchJJT6MNRE+TmtwNFfmlgbzWAHp+4FBC+
         fgOnQECA/5LSkbcQKZQfgI8yZJAluOW4YVmyhLVC+QiYNuF0y26IwowHHMez3WaKngnh
         H9cshgCSbP0H2dXPLQdLonJ+k02zGkhp3clJIlW1Hp3LZm9caHrtIkZGmxKLY2rmt+Xs
         fqWgmpNPs2NVxgJhgFNKjvkm7zHpJQ9MfqxpErDJ/5epJBEkCCAfYufI+2gwgJsHcLkF
         4Kig==
X-Gm-Message-State: AOJu0YyEbT2akZWTZHEbsfcQ+QCeogq3/JzDLKZ8Xt33Pkd+elSZaXZS
	TBNI+hqOkwdGOB8gRV5AldGO9XdjavnsBo2dYj41QqEsBc2lnugYr606iWit
X-Google-Smtp-Source: AGHT+IGYxE+xYLZN4Yru/kemyHyGbd/gL2BjIZkfyhmNj0bD2jkBBhAGrXMmd2PzRfvv1MWeBCuKSg==
X-Received: by 2002:a05:600c:3502:b0:40e:f5d0:8517 with SMTP id h2-20020a05600c350200b0040ef5d08517mr1130564wmq.33.1707196360231;
        Mon, 05 Feb 2024 21:12:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4Y4ShnGy5Fu1eAWdyYsgwNUh6LVEwTJP+TuR4b7xBSidJD6W+XEI5GhxmRKfqOfmt5l5PzJSB/K6Vk5RWlIjq86LrOPW3cyIk2Gi1VJSHNmViLK/xB0sBP8OsyPkICIR6eW05VnxetoMWHl7tmL5O/uyewJksBWG4n67+4T0GG4U2sXeUcWb9nIu6LXlR1Nfu3nP/HJlMig==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c1d8400b0040fe930b52esm16990wms.9.2024.02.05.21.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:39 -0800 (PST)
Message-ID: <f5b7ba08aa7c80a3bd5bcbf5563eac8896fe7054.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:10 +0000
Subject: [PATCH v4 10/28] format_trailer_info(): use trailer_item objects
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

This is another preparatory refactor to unify the trailer formatters.

Make format_trailer_info() operate on trailer_item objects, not the raw
string array.

This breaks t4205 and t6300. We will continue to make improvements until
the test suite passes again, ultimately renaming format_trailer_info()
to format_trailers(), at which point the unification of these formatters
will be complete.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/trailer.c b/trailer.c
index e6665c99cc3..6333dfe1c11 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1086,21 +1086,21 @@ void trailer_info_release(struct trailer_info *info)
 }
 
 static void format_trailer_info(const struct process_trailer_options *opts,
-				const struct trailer_info *info,
+				struct list_head *trailers,
 				struct strbuf *out)
 {
 	size_t origlen = out->len;
-	size_t i;
-
-	for (i = 0; i < info->trailer_nr; i++) {
-		char *trailer = info->trailers[i];
-		ssize_t separator_pos = find_separator(trailer, separators);
+	struct list_head *pos;
+	struct trailer_item *item;
 
-		if (separator_pos >= 1) {
+	list_for_each(pos, trailers) {
+		item = list_entry(pos, struct trailer_item, list);
+		if (item->token) {
 			struct strbuf tok = STRBUF_INIT;
 			struct strbuf val = STRBUF_INIT;
+			strbuf_addstr(&tok, item->token);
+			strbuf_addstr(&val, item->value);
 
-			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
 				if (opts->unfold)
 					unfold_value(&val);
@@ -1127,13 +1127,12 @@ static void format_trailer_info(const struct process_trailer_options *opts,
 			if (opts->separator && out->len != origlen) {
 				strbuf_addbuf(out, opts->separator);
 			}
-			strbuf_addstr(out, trailer);
+			strbuf_addstr(out, item->value);
 			if (opts->separator) {
 				strbuf_rtrim(out);
 			}
 		}
 	}
-
 }
 
 void format_trailers_from_commit(const struct process_trailer_options *opts,
@@ -1152,7 +1151,7 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 		strbuf_add(out, msg + info.trailer_block_start,
 			   info.trailer_block_end - info.trailer_block_start);
 	} else
-		format_trailer_info(opts, &info, out);
+		format_trailer_info(opts, &trailers, out);
 
 	free_trailers(&trailers);
 	trailer_info_release(&info);
-- 
gitgitgadget

