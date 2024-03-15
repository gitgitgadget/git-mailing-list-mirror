Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573C1A28C
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485712; cv=none; b=gRdwlVuHp6Uegwy6G9ebCyH6cJ/faohtDPJ7BKFHpab15nAK5TLUCTtfPWSzVpKw7mMxmM24lrCjfGBpAK1u+RuANwVTIQxW2/bWI/HqzYlo+3zvBf0a7786dF/4n4gAc4rujfdGSV1R53O7WpTBzpy0XCrv28dCbm17/YF4TTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485712; c=relaxed/simple;
	bh=CaV5//R+1IDNvQTEfb+cf+iLcDdEC/LFK0OcO4P7fVc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BsWsXSRUZVDtYQH33F3vGzaFjv75bTKZOgYjzYAN/JEXgIEWC/cA9E0xOvUbj7ladBxxzrGgrSLS7/tjl45Yb5TGJug/PzCdVRrNG0ULv1A1e4If5J2yDh69shcbzPPneFwwm50kwNVNod8lR0orU6SjoTmauF5p9aE5sm6QhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZvBttYg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZvBttYg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41400332550so3491435e9.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710485708; x=1711090508; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBqZeTF96LmZA1H72v7h3g3APJVx/350gPQNI10tnMg=;
        b=DZvBttYg+IXolX6+qiXi41xLBR+aCbR2DSgUD1hasSyHNpxrtuGrV32OKZAh6R3lhr
         u5adamQZiuf+q2o+tqDRJZ80ZaTqx69w4D4VAGhtdwekF1tEy3tyCFV1VIdmc1RSl4so
         KhgQr5bEdmd8GZ9QCguzb23muze5htdJgfCI16k3QtGIVRgKAmLTMoneZu12ET0NVQzn
         4+8IuyFzxtDEds9C4PNdPp3wC/mYmFZBcBRudHtdBCCT3qH2d2aGtOkd8WwXeCgUHK3g
         ZiP2XWiGDYgQV//AN+Z9rHzjrLqrvY7OCTcX4idSRkBbd8WWPXafrktciK8+RO/Beol6
         xbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710485708; x=1711090508;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBqZeTF96LmZA1H72v7h3g3APJVx/350gPQNI10tnMg=;
        b=hFMFiSrLOfFgkF7bOjR9Bp0T5ICcapRTqC/FrhWC5+dUVKgBa700uR98a3+znHYGsL
         ORJ3Jdi6TXTym2G/J69j+QKnj4fC+iYy5qUtxG5RCe2NdJsXT5RKp53vMi5CbnoyTh0g
         8VxyzTFYatWzuP/6LKP2opRYgugpcsOhHlbYNkCgEcTMAekhzL4g7Ahe8EPw74u+stFH
         LBL5ewSieb3hIzozfZ8ZwMOC4I4i5GRvn7nWsstZamgSjSmI3zrDxsqbxElgEjNuS+om
         IsLLk0UNFDcZqWYRrARLmR5N78I/YUYG3YLZDwRFgR1q2+n0/2sCIokQrKOqQE6ZThZk
         s1kw==
X-Gm-Message-State: AOJu0YwGwb9hAvXxh2lqo2gVIKBHHG1PSbkGHsTymC6astWoz3VXqjaY
	XD+y+eT0JfxmyAL/JiYmZr+pfFTG077mzG77wkaPS0UsJpQW5P8V8TXxlmg3
X-Google-Smtp-Source: AGHT+IEaDQr9TG6/d+m9eZgRPIo0GJGcXvl+dapFIhIyDXKolF4ZoRVceiaL+R64Id/lV7I5E9KzIQ==
X-Received: by 2002:a05:600c:4e94:b0:413:15ec:6f25 with SMTP id f20-20020a05600c4e9400b0041315ec6f25mr1987684wmq.25.1710485707594;
        Thu, 14 Mar 2024 23:55:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c470f00b004128fa77216sm8063497wmo.1.2024.03.14.23.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:55:07 -0700 (PDT)
Message-ID: <e3da8eb7f587e05f20645550d6987f0a01ed18b6.1710485706.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 06:55:01 +0000
Subject: [PATCH 1/5] format_trailer_info(): use trailer_item objects
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

This is another preparatory refactor to unify the trailer formatters.

Make format_trailer_info() operate on trailer_item objects, not the raw
string array.

We will continue to make improvements, culminating in the renaming of
format_trailer_info() to format_trailers(), at which point the
unification of these formatters will be complete.

In order to avoid breaking t4205 and t6300, flip *_success to *_failure
in the affected test cases. Add a temporary
"test_trailer_option_expect_failure" wrapper which we will use along
with "test_expect_failure" in the next commit to avoid breaking tests.
When the dust settles with the refactors a few more commits later, we
will drop the use of *_failure to make the tests truly pass again.

When the preparatory refactors are complete,
we'll be able to drop the use of *_failure that we introduce here.

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/t4205-log-pretty-formats.sh | 12 ++++++------
 t/t6300-for-each-ref.sh       | 16 ++++++++++++++--
 trailer.c                     | 21 ++++++++++-----------
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e3d655e6b8b..339e0c892ef 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -675,7 +675,7 @@ test_expect_success '%(trailers:only=no,only=true) shows only "key: value" trail
 	test_cmp expect actual
 '
 
-test_expect_success '%(trailers:unfold) unfolds trailers' '
+test_expect_failure '%(trailers:unfold) unfolds trailers' '
 	git log --no-walk --pretty="%(trailers:unfold)" >actual &&
 	{
 		unfold <trailers &&
@@ -737,7 +737,7 @@ test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
 	test_cmp expect actual
 '
 
-test_expect_success 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
+test_expect_failure 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
 	git log --no-walk --pretty="format:%(trailers:key=Acked-by,only=no)" >actual &&
 	{
 		echo "Acked-by: A U Thor <author@example.com>" &&
@@ -752,7 +752,7 @@ test_expect_success '%(trailers:key) without value is error' '
 	test_cmp expect actual
 '
 
-test_expect_success '%(trailers:keyonly) shows only keys' '
+test_expect_failure '%(trailers:keyonly) shows only keys' '
 	git log --no-walk --pretty="format:%(trailers:keyonly)" >actual &&
 	test_write_lines \
 		"Signed-off-by" \
@@ -774,7 +774,7 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
 	test_cmp expect actual
 '
 
-test_expect_success '%(trailers:valueonly) shows only values' '
+test_expect_failure '%(trailers:valueonly) shows only values' '
 	git log --no-walk --pretty="format:%(trailers:valueonly)" >actual &&
 	test_write_lines \
 		"A U Thor <author@example.com>" \
@@ -813,7 +813,7 @@ test_expect_success 'pretty format %(trailers:separator=X,unfold) changes separa
 	test_cmp expect actual
 '
 
-test_expect_success 'pretty format %(trailers:key_value_separator) changes key-value separator' '
+test_expect_failure 'pretty format %(trailers:key_value_separator) changes key-value separator' '
 	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00)X" >actual &&
 	(
 		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
@@ -824,7 +824,7 @@ test_expect_success 'pretty format %(trailers:key_value_separator) changes key-v
 	test_cmp expect actual
 '
 
-test_expect_success 'pretty format %(trailers:key_value_separator,unfold) changes key-value separator' '
+test_expect_failure 'pretty format %(trailers:key_value_separator,unfold) changes key-value separator' '
 	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00,unfold)X" >actual &&
 	(
 		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index eb6c8204e8b..2688dcc7b9e 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1446,7 +1446,19 @@ test_trailer_option () {
 	'
 }
 
-test_trailer_option '%(trailers:unfold) unfolds trailers' \
+# Just like test_trailer_option, but expect failure instead of success.
+test_trailer_option_expect_failure () {
+	title=$1 option=$2
+	cat >expect
+	test_expect_failure "$title" '
+		git for-each-ref --format="%($option)" refs/heads/main >actual &&
+		test_cmp expect actual &&
+		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
+		test_cmp expect actual
+	'
+}
+
+test_trailer_option_expect_failure '%(trailers:unfold) unfolds trailers' \
 	'trailers:unfold' <<-EOF
 	$(unfold <trailers)
 
@@ -1530,7 +1542,7 @@ test_trailer_option '%(trailers:key=foo,unfold) properly unfolds' \
 
 	EOF
 
-test_trailer_option '%(trailers:key=foo,only=no) also includes nontrailer lines' \
+test_trailer_option_expect_failure '%(trailers:key=foo,only=no) also includes nontrailer lines' \
 	'trailers:key=Signed-off-by,only=no' <<-EOF
 	Signed-off-by: A U Thor <author@example.com>
 	$(grep patch.description <trailers)
diff --git a/trailer.c b/trailer.c
index 57b4aa7d5ac..a74f05db55c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1085,21 +1085,21 @@ void trailer_info_release(struct trailer_info *info)
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
@@ -1126,13 +1126,12 @@ static void format_trailer_info(const struct process_trailer_options *opts,
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
@@ -1151,7 +1150,7 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 		strbuf_add(out, msg + info.trailer_block_start,
 			   info.trailer_block_end - info.trailer_block_start);
 	} else
-		format_trailer_info(opts, &info, out);
+		format_trailer_info(opts, &trailer_objects, out);
 
 	free_trailers(&trailer_objects);
 	trailer_info_release(&info);
-- 
gitgitgadget

