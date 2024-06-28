Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AD6F30E
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556644; cv=none; b=AzZ4Mb4mB3G+DCPLsLmKC68NrhYDqDFC76Vo/0yiyu7UZ0VbvYBzAXgL7oJQTATM5rqe+wTGKfhVNfiHOAlCEgLa9iANbJrpG6fLdUG8dnviVdhJbsSwige08Ei5tPwkm+bn5xK/OGDbRJgFxZEdZo/fYL5ffp1kKgLsrsjHYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556644; c=relaxed/simple;
	bh=C6FME0k7ynPldudu0jkCQRgGAEjpyrUAR9OvFTILbRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pdo0xbvLXp32llz7i0JR9AhP5x1dH2sf+ChBUMyo/ACbXybLBRFAkcq0CRYAGTd2St0fKz27X1CZ554tkmP/gx2RsME7vg+hmIfW7CniXd3GIaCwl7pn/Bkz/9VmBL8gQAbqLuXlDFNESoDMx0oQEcvM7b6U6zGwy0WfK+8l3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab4Js9bJ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab4Js9bJ"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d55ed47cc6so161155b6e.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556641; x=1720161441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDijk4fdcZL1Vh6O5OQRHk5Kw7/talJd4QVeXB0hW2I=;
        b=Ab4Js9bJnj/dNeUdFi4HjIOAzb4VDO30XZDDhud5R3x++ZLl6zBwWVDL9Q03vnNAbT
         cE2of7vTeGliHl+jXv0QCa+Olsdjgt+CkRKRhwfJHhu0gn99eMThAkPOnTEVJXF25G4K
         Yq4980UN8zf7NDFkU6lG/N4GkzMk/vun7CqA5AH6SNturdBf2KTjmzucxEUFDI0yzp1c
         dAqSti/L7dG1mkCVJnAwJ7r5xs99pH+YuwGtU010Wdcs9tvZYhGEmqN1MTxTXG7QOyE+
         IiFQbjd4rHu5jkXHGCJCOTwTD+4VV8WqT3T76UzwguExak4phZ9LErDRYF6Jwf0yCRYo
         Yy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556641; x=1720161441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDijk4fdcZL1Vh6O5OQRHk5Kw7/talJd4QVeXB0hW2I=;
        b=DkckSTb1pvBK7hs/LlCLnwzWamvVq8TNC6JWFU0swtg1XfmiNY43yzUZhc4Jr0/LFx
         Qpyz86oSncRJkzp0t86C3dkg14I1XLudeBql7fk4Dph8pF/UxH/O++g+l8TgYMauQpVU
         WkmaTPrIa6qn2NKwytOMSmYE08qEuV7fKXYDh1GRDfNkDeqPxvaHjq2/3p6rkzA6CfSF
         cswyFPuYFth6LNbIocDmFLpm9gjdo0GIcGZNEzubz4z4m4AwltzBjyOeDo/9qAWOokwu
         sYDjfkV4x579HQcFiqKVcDyda5WBzlph3aMAacm5J4DnP4H8RYhPFa4i6MA73wdAliWk
         sAdw==
X-Gm-Message-State: AOJu0YxAPIUvZuGOeXuzVQOZaGfE5tYYG/LbFpbU1lnMrur0ioVCQyir
	O3waR4B/a+B+3JkRkHwB5ga/8V+A8OgxxRg/fyfF74QE39OXjcbZ6RxUi3GRp/4=
X-Google-Smtp-Source: AGHT+IGZtHGAtoKLwKpIFggqyv1Bdv4gKKFH7k9QLFTg7NOfgCYP5aaBpe6Jc0xrQq9X1oWX4BalLw==
X-Received: by 2002:a05:6808:2018:b0:3d6:2d45:a791 with SMTP id 5614622812f47-3d62d45dd73mr3400845b6e.32.1719556640829;
        Thu, 27 Jun 2024 23:37:20 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:20 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 05/11] t-reftable-record: add comparison tests for obj records
Date: Fri, 28 Jun 2024 11:49:35 +0530
Message-ID: <20240628063625.4092-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for obj records, the comparison
functions for obj records, reftable_obj_record_cmp_void() and
reftable_obj_record_equal_void() are left untested.

Add tests for the same by using the wrapper functions
reftable_record_cmp() and reftable_record_equal() for
reftable_index_record_cmp_void() and reftable_index_record_equal_void()
respectively.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index e242a3923c..bdd54ad265 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -299,6 +299,44 @@ static void test_key_roundtrip(void)
 	strbuf_release(&roundtrip);
 }
 
+static void test_reftable_obj_record_comparison(void)
+{
+
+	uint8_t id_bytes[] = { 0, 1, 2, 3, 4, 5, 6 };
+	uint64_t offsets[] = { 0, 16, 32, 48, 64, 80, 96, 112};
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 7,
+			.u.obj.offsets = offsets,
+			.u.obj.offset_len = 8,
+		},
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 7,
+			.u.obj.offsets = offsets,
+			.u.obj.offset_len = 5,
+		},
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 5,
+		},
+	};
+
+	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+
+	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+
+	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
+	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+}
+
 static void test_reftable_obj_record_roundtrip(void)
 {
 	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
@@ -443,6 +481,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
+	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

