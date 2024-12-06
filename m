Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B44205AA3
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490813; cv=none; b=rbUbMQ31yN7Ya1Ssy0XFqJCzyUrOmmJlk04UKrs96krhYRqBIOOi4HJQDwigm8TfVRTC5ZsSozrPGRIW+6iGnFv3N6QhJlZ3RpyiCBWPMbk8v0ZzZUjvtysZU+LV8dQGmvjurCzC0APJN4bcjTu5zPkukfCo9YsBgQjjaGMqamo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490813; c=relaxed/simple;
	bh=P0HW4TbJFPMQbtXSyUjzM5/zfZmuYqnoDm0LaQmJkTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=ZINQnC7UogtvlPDYrNKqtSv8zYSL1RJSQf2xF5jlIvgxayKktOcG4W7wY2R5zdF+zAoM8JXivmx6nqO6q7i/0E9OJjiJU2gge8mjO3CM+LN2WLcsU7e7NQTcSzyB6G2j8HJSwubqXJcA2u4COhIhQKXON3UYeOl5es5W38oreyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMdIzbDh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMdIzbDh"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa62f1d2b21so213961066b.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 05:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733490810; x=1734095610; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UA1tfB2SK+pyT13GRJBiYsdP/Uw/l5L8cjW5Pei3n3o=;
        b=iMdIzbDhcybo+3tvY/mCZSIJZ7LFiJ8Ht1RUOFpSc3k9u3xiiJ9ih3S9WkiRuYLYwS
         GNBy6NW6Y6TNNBMLW2ROT1rBpG77beLBhqWubDxf5+82RNmxB3Zrsr1WcdbfiHHrcJOF
         T37xJzJtYz0EQfaWBU4RccVTASzKcyVaU9y3USZjjrLVWBSKendBVgwaBHnTi4He2b66
         u2VqCApWu+oMjN/Lk2xH02C5beMBR2bsavRv+VdyOvP9CI8zkO01/hSORKaHVon4HFGo
         HYRp3w9oWN+UOL1k4wI8uUr3k1e+b6LL3QipSAx4sD6VTfN4PStHbfu7HdgGhyNaCF67
         bIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490810; x=1734095610;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UA1tfB2SK+pyT13GRJBiYsdP/Uw/l5L8cjW5Pei3n3o=;
        b=PZ6Lr8WeU0iio5OLOj46A6NT+oASLsyfquMX/peZ9BkB+9o6J2bLxqGotjNHRv7uqn
         xdL3FcfGbQ8K9oZkoCY0bWJZP3V8HIQJpG/PvMpTUACMMO0KOTY+Gtly7hNX72hdStgP
         V1Pffd0mFT9ulbY/0hQ3V2hIKPY3q2zN2pYuFdZUPKPM1yTdUzLShvK4EzZJjr6h6CX4
         Y5MLarwgPNy3CowzbdbLTGoW1JdBkgdG5kDp6Bnz8Sk/IW3p1JzRIPuB2XOoNxO/4laA
         GfWMQSN3Vz0kBBh5RK4pCC3zOJcRnyr07teo81FoQitdgqXm0LY5OBrcVMIKImsxJNWb
         Zq1Q==
X-Gm-Message-State: AOJu0YykVv1URbcaTWq+dpDAQWYpArw3WsGPb5v+C+A4M0AqTVO5zUFP
	lSqqVM3Fr3rQPJjG4SiOpYFXlEfa2i84CllVAo9Em+B57XQEtPO4J+NtfVXL
X-Gm-Gg: ASbGncuPLsj9uga81bZRrKiw7cVa+HnnDQe9xiNp5Tddq11gxvwsq+0qQk8fAh02xrj
	DZer+e+S3xekGWZlpOjxwHx3jwz5c7fMzpIMAZHIjNRUAnwgErzM+9x3319Bq6zxrY/nuRmScU1
	bX0YkYneuA2G12gcLDYIm4H37hgbmFuUr1m6+tgIJYzIBeV5YD5xmsrFOLInD2wE8c++vb6CAmV
	9NUdrv1WJQxSXKYidkdPWOef850uuEnrVMV5dhkFc2zKeR597Yo
X-Google-Smtp-Source: AGHT+IGUwmSU91fEYQ7CbFGAQVzl3wFpAD2lJJmUbInBu9qgiI+GoaOMp+REpOr1P8nlsXU68EVOMg==
X-Received: by 2002:a17:906:3096:b0:aa5:274b:60e4 with SMTP id a640c23a62f3a-aa63a088bc4mr185189766b.29.1733490809439;
        Fri, 06 Dec 2024 05:13:29 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dbfesm238256566b.6.2024.12.06.05.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:13:28 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 06 Dec 2024 14:13:19 +0100
Subject: [PATCH v2] reftable/writer: ensure valid range for log's
 update_index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-424-reftable-writer-add-check-for-limits-v2-1-82ca350b10be@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG74UmcC/43NQQ6CMBCF4auQrh3Tjm0grryHYdGWASaCNW2DG
 sLdrXgBl/8k875VJIpMSZyrVURaOHG4l8BDJfxo7wMBd6UFStRKoQSNGiL12bqJ4Bk5UwTbdeB
 H8jfoQ4SJZ84JpHKqd7U8GWxEmXuUL37t1LUtPXLKIb53eVHf6w9Baf5HFgUKHDa1k8ag1HQZZ
 svT0YdZtNu2fQD3IAsV4AAAAA==
X-Change-ID: 20241120-424-reftable-writer-add-check-for-limits-01b1fb703528
In-Reply-To: <20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com>
References: <20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8050; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=P0HW4TbJFPMQbtXSyUjzM5/zfZmuYqnoDm0LaQmJkTc=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnUvh41dQzWhAAKNsVhPIFoQ5KKEM9VLhMjtnwO
 U+B1qgmh0SJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1L4eAAKCRA+1Z8kjkaM
 f/UIC/4womC+BrVALtuK9uhwettpLqqoFPAJeggfXEwjMIqbLUF9LvLsW23beiXPuKr1rN5R+zp
 b257BAbIaDwvpENI6f2jABGEs3kv8XaXxB25NV+bSJZE4vtcKM8m/LFvrnquSlt2WBew1JwkB0Z
 l8tm3hxIa8W9vH64ztRabs6rKffkebmfjs8qXlxID5ZEXk1Ke8tuNB9xL+H3EuavoWvdaVv3FnT
 PRcV5dmhNKkePyDCyNKbmSMIsYrKHif21pnNCcRXMuHVY0ef1HbBBdTO4eJuL8LSIkJfyt8rwu0
 pPDUTM1csgdYCWgMWPvI6OboOvYx0IpkuADzo2Oafjzq6yxtXKH0TNJEWw6hTfuIWoDtuc4FdKK
 Wsec0WqhtgO3/sIUqbP5l6tVVDRMsbp2Uw+PMroJoOeMYz2dKtnr/Yh958HpVt/GvVvC4pK2pGz
 MlFLfLmocgThpc8JEk63RnVbwMjFOLDkPTKi8yb0uDu0KVkitSu3LF7yHOxvmDNvSvUWo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Each reftable addition has an associated update_index. While writing
refs, the update_index is verified to be within the range of the
reftable writer, i.e. `writer.min_update_index <= ref.update_index` and
`writer.max_update_index => ref.update_index`.

The corresponding check for reflogs in `reftable_writer_add_log` is
however missing. Add a similar check, but only check for the upper
limit. This is because reflogs are treated a bit differently than refs.
Each reflog entry in reftable has an associated update_index and we also
allow expiring entries in the middle, which is done by simply writing a
new reflog entry with the same update_index. This means, writing reflog
entries with update_index lesser than the writer's update_index is an
expected scenario.

Add a new unit test to check for the limits and fix some of the existing
tests, which were setting arbitrary values for the update_index by
ensuring they stay within the now checked limits.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Update the commit message to have an inclusive rannge.
- Update the unit test to also include an update with index below range.
- Link to v1: https://lore.kernel.org/r/20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com
---
 reftable/writer.c                   | 12 ++++++++++
 t/unit-tests/t-reftable-readwrite.c | 47 +++++++++++++++++++++++++++++++++++--
 t/unit-tests/t-reftable-stack.c     |  8 +++++--
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index fd136794d5a27b33b5017f36fbd6b095ab8dac5b..f87086777cd20a9890a63f10c5d6932310dd5610 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -412,6 +412,18 @@ int reftable_writer_add_log(struct reftable_writer *w,
 	if (log->value_type == REFTABLE_LOG_DELETION)
 		return reftable_writer_add_log_verbatim(w, log);
 
+	/*
+	 * Verify only the upper limit of the update_index. Each reflog entry
+	 * is tied to a specific update_index. Entries in the reflog can be
+	 * replaced by adding a new entry with the same update_index,
+	 * effectively canceling the old one.
+	 *
+	 * Consequently, reflog updates may include update_index values lower
+	 * than the writer's min_update_index.
+	 */
+	if (log->update_index > w->max_update_index)
+		return REFTABLE_API_ERROR;
+
 	if (!log->refname)
 		return REFTABLE_API_ERROR;
 
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index d279b86df0aeda11b3fb4d2c15803760ae394941..7ffbd78c6759fc85ab9d5a2909d4d20662fc56c7 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -90,7 +90,7 @@ static void t_log_buffer_size(void)
 	int i;
 	struct reftable_log_record
 		log = { .refname = (char *) "refs/heads/master",
-			.update_index = 0xa,
+			.update_index = update_index,
 			.value_type = REFTABLE_LOG_UPDATE,
 			.value = { .update = {
 					   .name = (char *) "Han-Wen Nienhuys",
@@ -127,7 +127,7 @@ static void t_log_overflow(void)
 	int err;
 	struct reftable_log_record log = {
 		.refname = (char *) "refs/heads/master",
-		.update_index = 0xa,
+		.update_index = update_index,
 		.value_type = REFTABLE_LOG_UPDATE,
 		.value = {
 			.update = {
@@ -151,6 +151,48 @@ static void t_log_overflow(void)
 	reftable_buf_release(&buf);
 }
 
+static void t_log_write_limits(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_log_record log = {
+		.refname = (char *)"refs/head/master",
+		.update_index = 0,
+		.value_type = REFTABLE_LOG_UPDATE,
+		.value = {
+			.update = {
+				.old_hash = { 1 },
+				.new_hash = { 2 },
+				.name = (char *)"Han-Wen Nienhuys",
+				.email = (char *)"hanwen@google.com",
+				.tz_offset = 100,
+				.time = 0x5e430672,
+			},
+		},
+	};
+	int err;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	/* write with update_index (0) below set limits (1, 1) */
+	err = reftable_writer_add_log(w, &log);
+	check_int(err, ==, 0);
+
+	/* write with update_index (1) in the set limits (1, 1) */
+	log.update_index = 1;
+	err = reftable_writer_add_log(w, &log);
+	check_int(err, ==, 0);
+
+	/* write with update_index (3) above set limits (1, 1) */
+	log.update_index = 3;
+	err = reftable_writer_add_log(w, &log);
+	check_int(err, ==, REFTABLE_API_ERROR);
+
+	reftable_writer_free(w);
+	reftable_buf_release(&buf);
+}
+
 static void t_log_write_read(void)
 {
 	struct reftable_write_options opts = {
@@ -917,6 +959,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_corrupt_table_empty(), "read-write on an empty table");
 	TEST(t_log_buffer_size(), "buffer extension for log compression");
 	TEST(t_log_overflow(), "log overflow returns expected error");
+	TEST(t_log_write_limits(), "writer limits for writing log records");
 	TEST(t_log_write_read(), "read-write on log records");
 	TEST(t_log_zlib_corruption(), "reading corrupted log record returns expected error");
 	TEST(t_table_read_api(), "read on a table");
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 72f6747064f62106e87c9a90e5fe315139d46e60..52b81475c36aa94ff09f3bf77a7d23992957deb4 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -770,8 +770,12 @@ static void t_reftable_stack_tombstone(void)
 		}
 
 		logs[i].refname = xstrdup(buf);
-		/* update_index is part of the key. */
-		logs[i].update_index = 42;
+		/*
+		 * update_index is part of the key so should be constant.
+		 * The value itself should be less than the writer's upper
+		 * limit.
+		 */
+		logs[i].update_index = 1;
 		if (i % 2 == 0) {
 			logs[i].value_type = REFTABLE_LOG_UPDATE;
 			t_reftable_set_hash(logs[i].value.update.new_hash, i,

---

Range-diff versus v1:

1:  e30bdaeeee ! 1:  1c3cb5e92b reftable/writer: ensure valid range for log's update_index
    @@ Commit message
     
         Each reftable addition has an associated update_index. While writing
         refs, the update_index is verified to be within the range of the
    -    reftable writer, i.e. `writer.min_update_index < ref.update_index` and
    -    `writer.max_update_index > ref.update_index`.
    +    reftable writer, i.e. `writer.min_update_index <= ref.update_index` and
    +    `writer.max_update_index => ref.update_index`.
     
         The corresponding check for reflogs in `reftable_writer_add_log` is
         however missing. Add a similar check, but only check for the upper
    @@ t/unit-tests/t-reftable-readwrite.c: static void t_log_overflow(void)
     +	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
     +	struct reftable_log_record log = {
     +		.refname = (char *)"refs/head/master",
    -+		.update_index = 1,
    ++		.update_index = 0,
     +		.value_type = REFTABLE_LOG_UPDATE,
     +		.value = {
     +			.update = {
    @@ t/unit-tests/t-reftable-readwrite.c: static void t_log_overflow(void)
     +	};
     +	int err;
     +
    -+	reftable_writer_set_limits(w, 1, 2);
    ++	reftable_writer_set_limits(w, 1, 1);
     +
    ++	/* write with update_index (0) below set limits (1, 1) */
     +	err = reftable_writer_add_log(w, &log);
     +	check_int(err, ==, 0);
     +
    -+	log.update_index = 2;
    ++	/* write with update_index (1) in the set limits (1, 1) */
    ++	log.update_index = 1;
     +	err = reftable_writer_add_log(w, &log);
     +	check_int(err, ==, 0);
     +
    ++	/* write with update_index (3) above set limits (1, 1) */
     +	log.update_index = 3;
     +	err = reftable_writer_add_log(w, &log);
     +	check_int(err, ==, REFTABLE_API_ERROR);


--- 

base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
change-id: 20241120-424-reftable-writer-add-check-for-limits-01b1fb703528

Thanks
- Karthik

