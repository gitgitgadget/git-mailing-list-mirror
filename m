Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826C394
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091178; cv=none; b=lfqwIHW3NFJTcL2CEoNumfOAaV1EPc48LqhHQogfl+TFgyIh3r3PWbuIeurqHt0vXDJgKJ8v4RXlu8IlPtbV0dFvgyW9voLodO8U4afnNpn87xeQO4O/JMnGJiHiCkAyva3JDumPiZ25ZZsdcv2DOwGuoTE8CLEZQRajcujeHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091178; c=relaxed/simple;
	bh=pn6lJAactYJsBSPTIFSgV7vIlupiXwHHFTTCX2GvoxQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ADogUnCpJtfkoO2OeLWV6w+QXx/5ygaBJao6WqWiXC/qewCNWl5cB7O3QhMKoECdF/nDL7ASweiqMjqX0Ytmpi00WiXcmWfuUFL+itTPsaBBeY2bDO6eG3NwpuR5aDSLgT2JRoqIdoewNQYJrpsl0bU5ZHYzk5maQqmjjaWoJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef4C8E7P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef4C8E7P"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b39d38cf6so12350255e9.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091175; x=1714695975; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7/iBf6uowCR02s0pWxLwpTzzI1CCRdM3LPVm9XghlE=;
        b=Ef4C8E7P2Mh5LifiMfEQfY05jdUrMvOQzJ1Jx3WLYimcS0gn6mEVa7FUWvAtd9FJpX
         TIMghXNZ/OHtcDD4jvtGj2+5sl0Cwa3+P0t9RnrNx4XqJhBlF6UpQMLEg9itRe1LYeBo
         4s5+EyMSkSRc8ihsjBUYpmKgn5gqncQh6G6SV9vwoYa+JmrwkREKr76tdwqDXWQaVrZi
         aocjST8RxQIuEqyeYaBLgF4GpWWc3WNDJl1K+C3WJSbbagU/OW/Zu1ej9IoVwB3F+4Xn
         qSkFkQLWHZCTYXp+J96S2OeDEPnfSnwQbiq2wJDkL9oMxZkgqWlVB9Xzo4a49QRCaj+F
         A4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091175; x=1714695975;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7/iBf6uowCR02s0pWxLwpTzzI1CCRdM3LPVm9XghlE=;
        b=NMiWcMEHABhK8RNxCxiY0uQW6IvlX/Xn/FuxLgfpkIrgxSJOmE/RbpdAVMrIu+BsID
         BpMj/CobWy0IYSLmOnKVLAoLlP6DRNrt/GHB+/eOGgQdOc2ugk/HGxlQAZcGE9Zq/iss
         KphYnbOz+gVZerzN0rX4Qq5kFPRYecEU6BWvVVCEywtTHMb+VrR7+wf467pHKhORQYae
         +eBnO/ot3dlHM2EMj8ehRbD0Iqf9ZqQfdvldAJgudzzxcToTdZNXxfbqAAo1GUD7XpJw
         qLBDw44Yh+9uiTTXOxz5ITos54XP9XUccJx5cxq9c1z8N8YPo4anetZXOabnU0UfpE2W
         F29g==
X-Gm-Message-State: AOJu0Yzb0E+XtpF2Uacjm5YXhcqOQKx6IaaQJj5JL70OFFmpt6JF/UGj
	zcmTJmk3NzSpAFEl1XoHww+Rr6tV6VZcCgcoJRU6bsq+pFc/lhfacG9+Yg==
X-Google-Smtp-Source: AGHT+IF/ewagsng/QHBWVidOl0u4Um0kjDgZyf7rqPMHHBE6CMtTelgfDaTwaXovGFbjvTnhtsSRxA==
X-Received: by 2002:a05:600c:474c:b0:418:fe93:22d0 with SMTP id w12-20020a05600c474c00b00418fe9322d0mr726770wmo.11.1714091174675;
        Thu, 25 Apr 2024 17:26:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b00349d8717feasm21005614wrc.56.2024.04.25.17.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:14 -0700 (PDT)
Message-Id: <9077d5a315d0d7272266856bf75a75b0a24df91d.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:03 +0000
Subject: [PATCH v3 03/10] trailer: teach iterator about non-trailer lines
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

Previously the iterator did not iterate over non-trailer lines. This was
somewhat unfortunate, because trailer blocks could have non-trailer
lines in them since 146245063e (trailer: allow non-trailers in trailer
block, 2016-10-21), which was before the iterator was created in
f0939a0eb1 (trailer: add interface for iterating over commit trailers,
2020-09-27).

So if trailer API users wanted to iterate over all lines in a trailer
block (including non-trailer lines), they could not use the iterator and
were forced to use the lower-level trailer_info struct directly (which
provides a raw string array that includes all lines in the trailer
block).

Change the iterator's behavior so that we also iterate over non-trailer
lines, instead of skipping over them. The new "raw" member of the
iterator allows API users to access previously inaccessible non-trailer
lines. Reword the variable "trailer" to just "line" because this
variable can now hold both trailer lines _and_ non-trailer lines.

The new "raw" member is important because anyone currently not using the
iterator is using trailer_info's raw string array directly to access
lines to check what the combined key + value looks like. If we didn't
provide a "raw" member here, iterator users would have to re-construct
the unparsed line by concatenating the key and value back together again
--- which places an undue burden for iterator users.

The next commit demonstrates the use of the iterator in sequencer.c as an
example of where "raw" will be useful, so that it can start using the
iterator.

For the existing use of the iterator in builtin/shortlog.c, we don't
have to change the code there because that code does

    trailer_iterator_init(&iter, body);
    while (trailer_iterator_advance(&iter)) {
        const char *value = iter.val.buf;

        if (!string_list_has_string(&log->trailers, iter.key.buf))
            continue;

        ...

and the

        if (!string_list_has_string(&log->trailers, iter.key.buf))

condition already skips over non-trailer lines (iter.key.buf is empty
for non-trailer lines, making the comparison still work even with this
commit).

Rename "num_expected_trailers" to "num_expected_objects" in
t/unit-tests/t-trailer.c because the items we iterate over now include
non-trailer lines.

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/unit-tests/t-trailer.c | 16 +++++++++++-----
 trailer.c                | 12 +++++-------
 trailer.h                |  8 ++++++++
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
index c1f897235c7..262e2838273 100644
--- a/t/unit-tests/t-trailer.c
+++ b/t/unit-tests/t-trailer.c
@@ -1,7 +1,7 @@
 #include "test-lib.h"
 #include "trailer.h"
 
-static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
+static void t_trailer_iterator(const char *msg, size_t num_expected_objects)
 {
 	struct trailer_iterator iter;
 	size_t i = 0;
@@ -11,7 +11,7 @@ static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
 		i++;
 	trailer_iterator_release(&iter);
 
-	check_uint(i, ==, num_expected_trailers);
+	check_uint(i, ==, num_expected_objects);
 }
 
 static void run_t_trailer_iterator(void)
@@ -19,7 +19,7 @@ static void run_t_trailer_iterator(void)
 	static struct test_cases {
 		const char *name;
 		const char *msg;
-		size_t num_expected_trailers;
+		size_t num_expected_objects;
 	} tc[] = {
 		{
 			"empty input",
@@ -119,7 +119,13 @@ static void run_t_trailer_iterator(void)
 			"not a trailer line\n"
 			"not a trailer line\n"
 			"Signed-off-by: x\n",
-			1
+			/*
+			 * Even though there is only really 1 real "trailer"
+			 * (Signed-off-by), we still have 4 trailer objects
+			 * because we still want to iterate through the entire
+			 * block.
+			 */
+			4
 		},
 		{
 			"with non-trailer lines (one too many) in trailer block",
@@ -162,7 +168,7 @@ static void run_t_trailer_iterator(void)
 
 	for (int i = 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
 		TEST(t_trailer_iterator(tc[i].msg,
-					tc[i].num_expected_trailers),
+					tc[i].num_expected_objects),
 		     "%s", tc[i].name);
 	}
 }
diff --git a/trailer.c b/trailer.c
index 3e4dab9c065..4700c441442 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1146,17 +1146,15 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	while (iter->internal.cur < iter->internal.info.trailer_nr) {
-		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
-		int separator_pos = find_separator(trailer, separators);
-
-		if (separator_pos < 1)
-			continue; /* not a real trailer */
+	if (iter->internal.cur < iter->internal.info.trailer_nr) {
+		char *line = iter->internal.info.trailers[iter->internal.cur++];
+		int separator_pos = find_separator(line, separators);
 
+		iter->raw = line;
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
 		parse_trailer(&iter->key, &iter->val, NULL,
-			      trailer, separator_pos);
+			      line, separator_pos);
 		/* Always unfold values during iteration. */
 		unfold_value(&iter->val);
 		return 1;
diff --git a/trailer.h b/trailer.h
index 9f42aa75994..ebafa3657e4 100644
--- a/trailer.h
+++ b/trailer.h
@@ -125,6 +125,14 @@ void format_trailers_from_commit(const struct process_trailer_options *,
  *   trailer_iterator_release(&iter);
  */
 struct trailer_iterator {
+	/*
+	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
+	 * key/val pair as part of a trailer block. A trailer block can be
+	 * either 100% trailer lines, or mixed in with non-trailer lines (in
+	 * which case at least 25% must be trailer lines).
+	 */
+	const char *raw;
+
 	struct strbuf key;
 	struct strbuf val;
 
-- 
gitgitgadget

