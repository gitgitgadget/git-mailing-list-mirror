Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24F2904
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091181; cv=none; b=sRvCyAbqvItw+j09eH1zR8PL3ZJiOpb/Nb79FAwWwzGUBG668vVmkmJwq+vpFA4ZJgHK1ILmQnS1LppyybOt9SD/ctAYXnJ+6FkXRY9mRlU26zCL6yZROB5MY5dEJpywBLIemYng6MGlGREypwFIKAI7DS9K3XrWoMPN21Sk9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091181; c=relaxed/simple;
	bh=es/8xvwikbdf4BTLJ8Qn7X1Yb95TjQhL82KXUPLxrrs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cqha0nxXwvuDRaGTyMaM7A4VtcW9ZpsGMw/3si665/8leocgYQIzFbRunudqsHS7tsx56yfMsBX0V+eSX6td+Fc10yTKq7yk5MIXBvzLlGMTthylOccQC/oqs2N5BWI6JlGwOxBLhNORfum4jbc5dGJ75ycQOQJdoOBLH7M7fZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLvtddnL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLvtddnL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b2119da94so13385685e9.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091177; x=1714695977; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5jundgRnTRZ1UeFsaoiYa52OHNNlsJEIZK+0TSBpDI=;
        b=OLvtddnLnR0/8CnpexI4wAcGIK0WFJ8VEUhSSm8JWdrfwxhZw8/pJ8GLKYzx4ngk0G
         ccz6hztGYBpyIFWeggBBvH4n35J7JYk8bs7cGR+RqxyBWU4G2jaPkmZ+C97P9qX1oAFS
         ngQD5LLJlq6DqG2jPp+uWrD/2KXDaGZS+3XnAHsmLtzZIYqJMBQQ0K2EXHWZcqrllbSl
         ACKC75P0mIVA5d6BUIAwF4kQTikmOQsGjj6YZCRZk6Kru+Rdeyn/b2mj9J/1adOi0xkx
         sAhDmU5BWDZe6qJyxwtESNN63neo8recPhF9qOcMfOhLQ6PSvUlmpZXdudZI7x/0p8Kg
         jwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091177; x=1714695977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5jundgRnTRZ1UeFsaoiYa52OHNNlsJEIZK+0TSBpDI=;
        b=dlXAjc/NotxHBEt306D0jq+sZ0RAUPZxJ3joVhMmDRusInpRSZ7Bt6vFzMXcP3Dpjq
         d656EWRI5OhCunngCzL/FnQYxUzR9dAKGtSWxSxJKusLirqLAvtWh+1DGaNOLnrjBW+i
         sCdHxUJ1DId9hNI+VIjZqHxOvfewAvNqygXo8SsdXNXF+B9UBK/TpE4u7QiF15Fh5nTT
         bD4AejQG7bJaLOo2RvmFJanAMudY2IzlQBIGqGkMwX3VkdLe9vWXI+T3mVdOPrt/BeWm
         S+tccvieZzvc/Vi0EaqnF5GIMgOD+PDxDoyI7fg05oSTDRpxuy4HMW6aCk/6Miv9Dk2T
         7ZHw==
X-Gm-Message-State: AOJu0YwTbeQB9jqLSkK4OmsI4SuF4yQvZMEZfLp2gudTrXqHPwGlhxrq
	IoA+RsL6ghxPyUa9KIa6AI2sgWlxqICvX5DjyRBTcGF4L+E903bYGOKoaw==
X-Google-Smtp-Source: AGHT+IE4mpDizJdD1EVGPwQW8lN2yr4H0S+HYLyNUN/aax536oCHMxV45ysmbdyCV9Kk+d3SfOE5XQ==
X-Received: by 2002:adf:f10b:0:b0:33e:7c9a:9368 with SMTP id r11-20020adff10b000000b0033e7c9a9368mr593961wro.63.1714091177095;
        Thu, 25 Apr 2024 17:26:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d48c5000000b0034afaa9ca47sm12718356wrs.1.2024.04.25.17.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:15 -0700 (PDT)
Message-Id: <460979ba9643c5b7eb0fb93a51ba4817396bcbf7.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:05 +0000
Subject: [PATCH v3 05/10] interpret-trailers: access trailer_info with new
 helpers
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
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Instead of directly accessing trailer_info members, access them
indirectly through new helper functions exposed by the trailer API.

This is the first of two preparatory commits which will allow us to
use the so-called "pimpl" (pointer to implementation) idiom for the
trailer API, by making the trailer_info struct private to the trailer
implementation (and thus hidden from the API).

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 12 ++++++------
 trailer.c                    | 21 +++++++++++++++++++++
 trailer.h                    |  4 ++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 11f4ce9e4a2..f3240682e35 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -141,7 +141,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info info;
+	struct trailer_info *info = trailer_info_new();
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -151,13 +151,13 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	parse_trailers(opts, &info, sb.buf, &head);
+	parse_trailers(opts, info, sb.buf, &head);
 
 	/* Print the lines before the trailers */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+		fwrite(sb.buf, 1, trailer_block_start(info), outfile);
 
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
+	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
 		fprintf(outfile, "\n");
 
 
@@ -178,8 +178,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
-	trailer_info_release(&info);
+		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
+	trailer_info_release(info);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
diff --git a/trailer.c b/trailer.c
index 4700c441442..95b4c9b8f19 100644
--- a/trailer.c
+++ b/trailer.c
@@ -952,6 +952,12 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
+struct trailer_info *trailer_info_new(void)
+{
+	struct trailer_info *info = xcalloc(1, sizeof(*info));
+	return info;
+}
+
 /*
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
@@ -1000,6 +1006,21 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
+size_t trailer_block_start(struct trailer_info *info)
+{
+	return info->trailer_block_start;
+}
+
+size_t trailer_block_end(struct trailer_info *info)
+{
+	return info->trailer_block_end;
+}
+
+int blank_line_before_trailer_block(struct trailer_info *info)
+{
+	return info->blank_line_before_trailer;
+}
+
 void trailer_info_get(const struct process_trailer_options *opts,
 		      const char *str,
 		      struct trailer_info *info)
diff --git a/trailer.h b/trailer.h
index ebafa3657e4..9ac4be853c5 100644
--- a/trailer.h
+++ b/trailer.h
@@ -97,6 +97,10 @@ void parse_trailers(const struct process_trailer_options *,
 void trailer_info_get(const struct process_trailer_options *,
 		      const char *str,
 		      struct trailer_info *);
+size_t trailer_block_start(struct trailer_info *);
+size_t trailer_block_end(struct trailer_info *);
+int blank_line_before_trailer_block(struct trailer_info *);
+struct trailer_info *trailer_info_new(void);
 
 void trailer_info_release(struct trailer_info *info);
 
-- 
gitgitgadget

