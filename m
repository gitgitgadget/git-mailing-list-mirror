Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5A24A0E
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625677; cv=none; b=TD+vFZJ+Np4XVbWuXLE0IgVmCIGDPlyzUvFQnK5/gkXz7jpBq/cX+ODrnjamNTVx+FQlDv73msEc02Nxeyp1TWa8EDvaETCDUV8ScRIgnYK/6YNQRo3cwUQB1QK//H/JvQGjL5gQHRyIuOgNk7cxXO+4yk6eYuQXcZbajXZXWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625677; c=relaxed/simple;
	bh=0dq7EZz69LBcz5cHGHAl5MdUisMDkm7R8Z3I/8TkhYc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O12aMyiXVm2OfaeUXdDDNwBjrTrF0lqVsF4EHWNngXBQ0FIBtoMNNYUJKvcYzj6/g/DlvqVaxfThfyF23nMHnqSvDt/4K1PFr+ER01uKVu7Nwv6tk79plMVjP3rOczM313kqI+L0O0mUSghMvriGScHXuuuAecIYKlJP7+HHp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqclUX4V; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqclUX4V"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so91688511fa.0
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625673; x=1715230473; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVtPJ0vp+RWJgaMX0JHtnOVHtN9uHmXYYn1fiQs8ZC4=;
        b=WqclUX4VLcDarLljfOGpqOKrXuCStx82Z/f+bcxfr4aaRAaCbeeGziyMNQmW2gWIcB
         m5hSAhos5Vnt5mHfDImQipWJCiwpUPSeJV9/QUqWgt0/VMvpvR4Au1hzf7kq3ROygYq1
         57EBs9G0Gs0zQ6CQAH/ugnwvfLYiOA9PMGRoz5Mm0NalM5QIHjYTNQAZYkAJOEYF+1CM
         zfr+EMDASWO+4cqHnO47ohg5HGx+l7sUJ8vowLDxycjDyWUs7VyUnQFGGJ62Fd+NpGQz
         o1FhAtSZ4ahdi48ICFH+lse3i6jZ7Qqo9izAJ5QsQ0ta3kwJ2rzJ9Z5ja8IzHmOJoFWu
         1EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625673; x=1715230473;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVtPJ0vp+RWJgaMX0JHtnOVHtN9uHmXYYn1fiQs8ZC4=;
        b=UcDPIiGw+LVrs/fhAKcMB5kKP6HeBNMut/S3skP8oP6a5bSO5vcRsr8S1CWz2Qq9/h
         nvZPRZyJfk5l2yHs66uKHx5qZYCfRtugFWePoG6TRlIDtvPowqcOLSOgk55miEcPXU8q
         eH05K9wbc2qIEksgGM8lRvAgJWDn3eQ8bvJ2PnU8tmWkVZbmp81vLW4yE08xJzz2tY0D
         DPj+YbAYUxShDweB+Yr6WH7u/2i/2jWTxWXrEq+5Df+3JrQn1MZYP4KDAI/hMSXPoSMR
         shD0j8ErWM8IFIyFdDoU8JlZkLQWOXNQcNPQBpT7aoD2YUVPLT3wHrM7F7PmTxigzHxA
         RzaQ==
X-Gm-Message-State: AOJu0Yy6DL9Co85lYt6+/zWvolsroHF+MB7skmMoAjtP1rhysmgJA+0A
	SjTCsKrj1IKWQJ3tSBi+HbiVyfYiiA6uY5cq8HMK2XW5wuwSTX9Lc4B8zg==
X-Google-Smtp-Source: AGHT+IH178GrwQ5lKIc2vODGHui0ZGTlQ9Xtp4fESA4mJcoeYP6z5/zl//jqzD5Jd2Ihx2A2b1atJQ==
X-Received: by 2002:a2e:ba14:0:b0:2dc:b467:cb32 with SMTP id p20-20020a2eba14000000b002dcb467cb32mr497211lja.14.1714625673203;
        Wed, 01 May 2024 21:54:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b0041bf5b9fb93sm511167wmq.5.2024.05.01.21.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:32 -0700 (PDT)
Message-Id: <4aeb48050b14e44ec65cfa651a4d98587a6cd860.1714625668.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:20 +0000
Subject: [PATCH v4 03/10] trailer: teach iterator about non-trailer lines
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
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linus@ucla.edu>

From: Linus Arver <linus@ucla.edu>

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

Rename "num_expected_trailers" to "num_expected" in
t/unit-tests/t-trailer.c because the items we iterate over now include
non-trailer lines.

Signed-off-by: Linus Arver <linus@ucla.edu>
---
 t/unit-tests/t-trailer.c | 16 +++++++++++-----
 trailer.c                | 12 +++++-------
 trailer.h                |  7 +++++++
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
index c1f897235c7..4f640d2a4b8 100644
--- a/t/unit-tests/t-trailer.c
+++ b/t/unit-tests/t-trailer.c
@@ -1,7 +1,7 @@
 #include "test-lib.h"
 #include "trailer.h"
 
-static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
+static void t_trailer_iterator(const char *msg, size_t num_expected)
 {
 	struct trailer_iterator iter;
 	size_t i = 0;
@@ -11,7 +11,7 @@ static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
 		i++;
 	trailer_iterator_release(&iter);
 
-	check_uint(i, ==, num_expected_trailers);
+	check_uint(i, ==, num_expected);
 }
 
 static void run_t_trailer_iterator(void)
@@ -19,7 +19,7 @@ static void run_t_trailer_iterator(void)
 	static struct test_cases {
 		const char *name;
 		const char *msg;
-		size_t num_expected_trailers;
+		size_t num_expected;
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
+					tc[i].num_expected),
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
index 9f42aa75994..7e36da7d13c 100644
--- a/trailer.h
+++ b/trailer.h
@@ -125,6 +125,13 @@ void format_trailers_from_commit(const struct process_trailer_options *,
  *   trailer_iterator_release(&iter);
  */
 struct trailer_iterator {
+	/*
+	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
+	 * key/val pair as part of a trailer block (as the "key" and "val"
+	 * fields below). If a line fails to parse as a trailer, then the "key"
+	 * will be the entire line and "val" will be the empty string.
+	 */
+	const char *raw;
 	struct strbuf key;
 	struct strbuf val;
 
-- 
gitgitgadget

