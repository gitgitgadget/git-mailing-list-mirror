Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7017829C
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906601; cv=none; b=s+oaVddcKi6O8W7HgT3dpdSOcUsrtTbu+v3REy7UfTbWap0d6+/AMGjwENq0hUrVph5yX45nHP21CdycN1jKAEtzCpsDwRlNo7mXepGV14QInfjXB+EN77VZKAXhvNxC9Jck1v4OXHG5WK3jHmq+LibkeEsYUeLitHiSxBluVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906601; c=relaxed/simple;
	bh=xSUnpyVRsn+apiNVMctanSVmerZ9z45ivFvBGsHhupU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYF8xVL11gjETVfCGZBB/jk9kROiSYmPhzxQrBiBq7vneW3CGndnmp5tS4ufYCs8bM1lxm1crODAtLiY6m+JJLhUquc/B4l0VxecRM/eeEXFTUGYkjlvTa1lBgEIKQuT3B2E+z7vwRbWd4L6T8fMBagxfwPWKD79sSu0jTNLFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNHT9JgE; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNHT9JgE"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d55cfebcc5so1693103b6e.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906598; x=1720511398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6pyvVkkEdKASWRr9WbGaKCIkhXsJJSZG4HhAp3FrrQ=;
        b=LNHT9JgEhqGTNWo3ytAuRhzAg52t4JXuHb7rHfHXOZqEvx7POi608aJ/WS4uFKzwCE
         e59LqqV0OTwHrkLsHaA1E222dPN+L/X04vEGYBJGgs17/G2hsBCHZHJF+xy0pYM06x6y
         1m9w6/HKEARi/SlCsKMGl4e5qB4GAVqKRzLAJ0kEn7AAyYdcfPjsLw4H52xUYY9SWe9f
         UxnespdJYxX49nm7GnYjpJ1NoVG7ho0hcVbtDfcxiBOJCfbnCT5Ad1j0ldalfKhGCrrX
         rdKvODbhlbL3EQjyrjOEGHNcDwru7O7gtg0roZ81aImy8r74n3RXUviXAt7cUfrkHziD
         PnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906598; x=1720511398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6pyvVkkEdKASWRr9WbGaKCIkhXsJJSZG4HhAp3FrrQ=;
        b=PpVG7sJfL1sOiVnkZQCK2nTDwVAoYkKHX8c0mU2/2c9KerUlI/3wvkjP1+LUJ/cy0z
         EQQTRMVnipLqrQrVsEMZ4x6ftKODTRFnxq6DHo0L6gVrzAXg5VhgwJbEv6WuRu+WHh6k
         pqLVMrhG08FTfdQ5+7W5ZNviymHFp4VflPIwyK1ozg7m7e+xEBfui39NV0x/3yeOYVju
         bi6IddSc/PcgPbMHrdz6ytgodFTDbYm3qci8htP0T8g5B8/EBTaaPU5pz2B4dMR4GELD
         fJxf6MWL/L78RhAs5/GwQV3oJcm3fx8NuqpphUhXVN2J8Pzx3RR3qIoXdEzj7FDx0Gor
         W0tw==
X-Gm-Message-State: AOJu0YzELZHuWS84zi5poQCHeJVrPYvipaUXgNHGnuCxUnjeNgmy22TB
	8XMxraDsvgaPKJ0TTbu6aypEkRBLDnWcdUc3qVv5Ef7dJ/H8ZXUltelNGMv/0rA=
X-Google-Smtp-Source: AGHT+IFNGN2DVh7Vw/gC1mU7Umhdv1cImasPXw1YlbSAwwbq0rtDrHasjo/xOu88f2et37onP9iaYg==
X-Received: by 2002:a05:6808:308d:b0:3d6:2d2e:76a3 with SMTP id 5614622812f47-3d6b4de23f3mr7831064b6e.38.1719906598582;
        Tue, 02 Jul 2024 00:49:58 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:49:58 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 05/11] t-reftable-record: add comparison tests for obj records
Date: Tue,  2 Jul 2024 12:52:18 +0530
Message-ID: <20240702074906.5587-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240702074906.5587-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
 <20240702074906.5587-1-chandrapratap3519@gmail.com>
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
index e8db337eb8..46614de948 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -299,6 +299,44 @@ static void t_key_roundtrip(void)
 	strbuf_release(&roundtrip);
 }
 
+static void t_reftable_obj_record_comparison(void)
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
 static void t_reftable_obj_record_roundtrip(void)
 {
 	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
@@ -443,6 +481,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
+	TEST(t_reftable_obj_record_comparison(), "comparison operations work on obj record");
 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

