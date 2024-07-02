Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168D14D42C
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906618; cv=none; b=B7jWkKoWMSy6hfKNf0b8WQMWnBH4pl6fivutqMQgOuN5IgFBPKAcwELKOEck3YWxzykoFTVB6gjll4duEyDFmsPo67fLEHZs4wwbiDRPAOQDd20CXZuM5FXuGL0bNCbpSLxD/mQsYygVBgO0wRfMtb45diJ6vh/5c3CM3uzISs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906618; c=relaxed/simple;
	bh=kpm8IEjm7/FpsXEgHos1G/0PiCCq+iAmNFz30yyxqig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVjMxrRxIslQvY7k+o32Gey2EmjLc2ulUH6YAtVV4Bv/VHXk+da5dX1uyhHufcPVDWW6SR0y8m7/K/2XbQzEGV4ZbndY0ZDAjJTHokWIugoPNNr5UiVnfbqZEJQ/7av1csTAXG055EyyhV8/nQSqxW14GAsG2MBn30Lbu7EFBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/54zsWR; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/54zsWR"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f8d0a1e500so3557597a34.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906616; x=1720511416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDSXlzAo1+yDEpsERu682IX3LxAq0JyvYBIm8EjFNuM=;
        b=d/54zsWRAE+XBpejGBF5cqR911BeNBvBPrHSBq6F6t7ZsVWlRqm7dTNkcKxm61890Q
         QcOSmCal1JcDa5Wlvh5Lw8am1svSTTAZhi/FTCKyBsbjXquJ591MFpQOUFzE93xbF4sE
         ikPOOUOLvghlQaChYXMNd2WaUhUucQY2CnSxTcsCDD6RnhxpLaiWSi7hdyCtmwUcrxPb
         5hX60ZKrvtTPsviTKpKd2yWn6uwH57lbptUgZGEAooo/hhq3/p9nmWzbQt2M65E7BZTb
         R3J5lGXh3WcSkEmtt2702VjNjYTa2RQv64CJb3suPqabCZJxlerGh/mLQXFk7kbWm/8C
         GKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906616; x=1720511416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDSXlzAo1+yDEpsERu682IX3LxAq0JyvYBIm8EjFNuM=;
        b=oAecyCBsjgRh598BU+6VWSi4vslGb4tItamq6BPsd1Pt5MdAcEXIwSndGmOqyC9EgM
         WfGpd+oO0HNVAuArBRU05+rkzbvpxJ0cICe2skIGb3VywXzIA8/J5kSUprv5Rh+zvPhp
         uFVkzpATUn/Dpsa22z2cMtzTXGoseaHNZydTTwwpgL7aMpSWXbYVrTVwC6bFNSTLbgeI
         TPhbAEYK1AaAuuWL8+rW8VkHpPs1aSqT02wd4dOJ19ao9/ty46XQzXnDOvsHHILZDfHW
         ar5loshXhV5LOEMII7JW6wJz/5Z+tr7XBXbbhsxgcUMYw90q2QTwCvb44lcA4eV80GG4
         viRQ==
X-Gm-Message-State: AOJu0YxLmcJZMtMEbgOYt8HBZBVc0G/xinG4WduDE8iUZk3PPifo4hEN
	3iNj5suPv+S/Gbvz/nWW8yuyrvnhrpbyKlJikSpRPFzgO5MQhL8dEitCRuNgsgg=
X-Google-Smtp-Source: AGHT+IFU9ttNcHc651WJOGhXm9ExIFs61eEE9GthyPtmnhFFPqa3iVPepxpnopzdYFxhKCFKdLSiaA==
X-Received: by 2002:a05:6830:1e27:b0:702:1e88:6092 with SMTP id 46e09a7af769-7021e886112mr2753861a34.20.1719906615818;
        Tue, 02 Jul 2024 00:50:15 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:50:15 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
Date: Tue,  2 Jul 2024 12:52:23 +0530
Message-ID: <20240702074906.5587-11-chandrapratap3519@gmail.com>
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

reftable_ref_record_compare_name() is a function defined by
reftable/record.{c, h} and is used to compare the refname of two
ref records when sorting multiple ref records using 'qsort'.
In the current testing setup, this function is left unexercised.
Add a testing function for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 43b5d40899..c0668cd8b4 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -95,6 +95,25 @@ static void t_reftable_ref_record_comparison(void)
 	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
+static void t_reftable_ref_record_compare_name(void)
+{
+	struct reftable_ref_record recs[3] = {
+		{
+			.refname = (char *) "refs/heads/a"
+		},
+		{
+			.refname = (char *) "refs/heads/b"
+		},
+		{
+			.refname = (char *) "refs/heads/a"
+		},
+	};
+
+	check_int(reftable_ref_record_compare_name(&recs[0], &recs[1]), <, 0);
+	check_int(reftable_ref_record_compare_name(&recs[1], &recs[0]), >, 0);
+	check_int(reftable_ref_record_compare_name(&recs[0], &recs[2]), ==, 0);
+}
+
 static void t_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
@@ -490,6 +509,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(t_reftable_obj_record_comparison(), "comparison operations work on obj record");
+	TEST(t_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

