Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702C1EB5C1
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040213; cv=none; b=JFQ8syDk6J0KSPiKlVcS+4zv6N/ODS58pZIQzpR88UmJ06jwiHrBceKbxUK65XRuyeULC4VJT5e24G92niT3TO3ITN9+NumhoyjYCCnJDFddJtdWujOIGgIpNCQzZsCjhMB0mhQ1jAmgmmGzW/t+sFwU9J5pvYCIm3lBPX4dz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040213; c=relaxed/simple;
	bh=qWGfasLMZtQ5KSysSkSmO82av0z2MRy2vgLBbeyiFNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4aOGgdJ93/SqZNLd69ijdmzf7GFDU+brQNKcBB8yS0lfNAhVa8edyaJh14bzvdUGN/8WhPTVsT7szQaqVUKiEamHuz6jKMhiK5VAsCHagCSqYLx6ZpthtgnNCxqX1L0sXNcrFWCzz7yL9X3s7roIkacWOZf31fGQymuaXBCki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/qAUKLU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/qAUKLU"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb97e15bcbso124596866b.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040210; x=1740645010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFsVhNE7usTqD/kbJ6QEgxQEFOfvh9nTaAXkr5/PEa8=;
        b=m/qAUKLUgLTMTC/ODwX2xlTPD3zpmCdHQJ3IjzBi5/Z9eX3+jUXhIFwB6i2QAWrJlI
         kPcgWC0aA7lpwwcSJ8Ho9NqyYMKXMyBIDzMGMzr/Yh1orSDjXrBS2v4TXI11eOtfZebt
         CzVHGW5kLKG/uNRMTiKWJ0XM7yc3xlHFjfASA1KVjdoACPGvGVS/q+thE5SXrJiu2U57
         wpXsEN0eOHBunq1PFZNlb3HJwUxb/Iyt2Pzvj8aXLVmAR9TBG8SoO4LbqkrL64gwXXBf
         i4tt+ogsai4FKRTPuigmPCosu9nOs6Ki7YGMZTwd/tRkD2p/MDhOpLapkeG92yvlOEgX
         727w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040210; x=1740645010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFsVhNE7usTqD/kbJ6QEgxQEFOfvh9nTaAXkr5/PEa8=;
        b=klutXQbfJKQwjreKCRorL9lIhgIYkftdxCQsoD4Y9eT24hXxQdphxPsxsIYa9mSI1G
         lhmhmSjq2nomGxohtQYun7ZaTQsvlIr8K8Cd3zHOsCKKqX8S0H+v2AEWEQjtgbSndxx4
         Fd/5YU6rabzEjYcjP1xjfR/PwtjZELjPpnxiDzhGE1Ew8q58PFap+uiPh4SN2SarA6V6
         WtFvhHOSJvDR51dQUYDSGqbnuYqCVro8W76+e5mUyu9AnSkJZhcXOJbpViBuWj/PvbqB
         oPxwScN0odQt+Q0yKjo9WGTVP8hE9oDGsH/HfghxOXIIb1eZ0sy6g2cHa450rlLPnU6p
         rMew==
X-Gm-Message-State: AOJu0Yz7QnOpRRUCn/sMOudzQWeT0YUOzu1hrpVi/y4RXBD9xjzCFqds
	//gH+B4gYnY2+fstCK909kGnUdYClKTBeY3xVYxnhIOKvCUnADeBCE43wOLX78vT5A==
X-Gm-Gg: ASbGncvffsphnjCf78feV0G6vMZbGDGhRMsG/uSux+nHVumnf5e5ziobvHV4Xi6I56C
	YD/GFvuEjHJjHhwiI6hTJkzmn80WpRXcEpWO0kZOYaS/VNN++7t1iplS0TTHaHSr6iICUU72vz/
	aumi2jqB843eBmAGATVdNB9G463OOV3WL3E6Zg3Jk29a36FU8hzWIm48gg0oOqnDWU0ZGo4SCr3
	1BswqJmg3AxU+hpSRYET3Hb/1zSgCyy3gCS9pzDdhvreekw63eyGbWXIzm4E+NOExs4AAsMrwde
	7SO8MVtddjLO+OlJA9TriEFGc5k=
X-Google-Smtp-Source: AGHT+IES92wZp9UHTCg7ZWU33z/a+cfeygS8gZIxnlFfQlcZ4RuDVgogV/x9cJWSZBiI2SqV6sDcWw==
X-Received: by 2002:a17:906:32c4:b0:ab6:6018:df18 with SMTP id a640c23a62f3a-abbccd0052emr551192866b.6.1740040209435;
        Thu, 20 Feb 2025 00:30:09 -0800 (PST)
Received: from localhost.localdomain ([154.118.9.41])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abbdf53d765sm230533966b.39.2025.02.20.00.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:30:09 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 1/5] t/unit-tests: implement oid helper functions in unit-tests.{c,h}
Date: Thu, 20 Feb 2025 09:29:55 +0100
Message-ID: <20250220082959.10854-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250220082959.10854-1-kuforiji98@gmail.com>
References: <20250220082959.10854-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`get_oid_arbitrary_hex()` and `init_hash_algo()` are both required for
oid-related tests to run without errors. In the current implementation,
both functions are defined and declared in the
`t/unit-tests/lib-oid.{c,h}` which is utilized by oid-related tests in
the homegrown unit tests structure.

Implement equivalent functions in unit-tests.{c,h}. Both these functions
become available for oid-related test files implemented using the clar
testing framework, which requires them. This will be used by subsequent
commits.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/unit-tests/unit-test.c | 42 ++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/unit-test.h | 19 ++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index fa8818842a..13d54f192a 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -1,5 +1,7 @@
 #include "unit-test.h"
+#include "hex.h"
 #include "parse-options.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "strvec.h"
 
@@ -62,3 +64,43 @@ int cmd_main(int argc, const char **argv)
 	strvec_clear(&args);
 	return ret;
 }
+
+int init_hash_algo(void)
+{
+	static int algo = -1;
+
+	if (algo < 0) {
+		const char *algo_name = getenv("GIT_TEST_DEFAULT_HASH");
+		algo = algo_name ? hash_algo_by_name(algo_name) : GIT_HASH_SHA1;
+
+		cl_assert(algo != GIT_HASH_UNKNOWN);
+	}
+	return algo;
+}
+
+static void cl_parse_oid(const char *hex, struct object_id *oid,
+				       const struct git_hash_algo *algop)
+{
+	int ret;
+	size_t sz = strlen(hex);
+	struct strbuf buf = STRBUF_INIT;
+
+	cl_assert(sz <= algop->hexsz);
+
+	strbuf_add(&buf, hex, sz);
+	strbuf_addchars(&buf, '0', algop->hexsz - sz);
+
+	ret = get_oid_hex_algop(buf.buf, oid, algop);
+	cl_assert_equal_i(ret, 0);
+
+	strbuf_release(&buf);
+}
+
+
+void cl_parse_any_oid(const char *hex, struct object_id *oid)
+{
+	int hash_algo = init_hash_algo();
+
+	cl_assert(hash_algo != GIT_HASH_UNKNOWN);
+	cl_parse_oid(hex, oid, &hash_algos[hash_algo]);
+}
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
index 85e5d6a948..ebed51212f 100644
--- a/t/unit-tests/unit-test.h
+++ b/t/unit-tests/unit-test.h
@@ -8,3 +8,22 @@
 	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
 	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
 } while (0)
+
+/*
+ * Convert arbitrary hex string to object_id.
+ * For example, passing "abc12" will generate
+ * "abc1200000000000000000000000000000000000" hex of length 40 for SHA-1 and
+ * create object_id with that.
+ * WARNING: passing a string of length more than the hexsz of respective hash
+ * algo is not allowed. The hash algo is decided based on GIT_TEST_DEFAULT_HASH
+ * environment variable.
+ */
+void cl_parse_any_oid(const char *s, struct object_id *oid);
+/*
+ * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
+ * GIT_TEST_DEFAULT_HASH environment variable. The fallback value in the
+ * absence of GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1. It also uses
+ * cl_assert(algo != GIT_HASH_UNKNOWN) before returning to verify if the
+ * GIT_TEST_DEFAULT_HASH's value is valid or not.
+ */
+int init_hash_algo(void);
-- 
2.47.0.86.g15030f9556

