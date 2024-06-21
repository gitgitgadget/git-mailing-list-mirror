Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29C15665D
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949732; cv=none; b=fKZsnVaKLtC/zQFWuYt32qnRJQ6LwmaKAWt2l7UIfkIq4cbyzErJGtaT9QgSie8pUqyIpOwArBfHVEEyfDbAFQ9mblXHgfLriASyEpeGfxEmmJsyEGxklt0PcNVioxMAeGJS9Vx4Nup4Sce+yuO7TJLK0u5B65Ox2HtEmZr4W10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949732; c=relaxed/simple;
	bh=kGozN0PNCDQg0ql/dELVVZXPn57dOtEhDCIExh/EY7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz+LJt2TJ4Mw4AjNA0EASb0W7u6lO1zG8hbvksKG1v3J3v2Ymh9W6pmwFHu4jGSaNvvUqDLpVwelaji6FFHbWMrLgMRZxmuAGZaHuOg4ImlP+2b6klJKsAYpvR/ZM2hqnn1s0k3pTBZzyYT7zRSUXeY09yN9iBD5ojxpz2T/UMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STbp8/Ki; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STbp8/Ki"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70436048c25so1662270b3a.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949730; x=1719554530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCWxDG58DmCFHAUZ7wdMTUrJXjFUu4UDqHA3yP7rjJY=;
        b=STbp8/KiwnTpQgQlPSon9bHtHncguIE2xBeokqltguzrE7Zmd9iBDdPjkxgKFP7zoa
         fqr5eYAwQm6uZLicorA02WwO1KBscVRVIG35JSTcIauKWBXvbS17SS/VmJwk++71W+Id
         ViLaqPKPMp1bv+qJ6JhE3H0lCl68ruua8E/yOpp16lsJOgqRMYdIJySPDVH0fU7iHjCM
         rr1vIUP82KbaWwzbvD6bdPpCSCAVUIlwLeoeBOuNMI0lRfj8GNC+xzDrodDcgA3t/1/G
         VEh9XuqfnL7vkCKsy1zL9AVOth+S+WNuIzoTaeAE2AlZNlHPy8X7VlKBtBCYVDn+pk4Z
         MCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949730; x=1719554530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCWxDG58DmCFHAUZ7wdMTUrJXjFUu4UDqHA3yP7rjJY=;
        b=NKGIEg1EYfXSqZOxgwzyQkyQZXa05OBouWBhyUEswQpI9V2HSZ3fgSVULTLqQJ4XRL
         303rQf78AkgIlIyg1AI4TkhcCOiLquLSZyByxLofT3NkYIVLroALqpcFswlPdby4GeMD
         83cPuj+WgjVWZDTUo1ub8JY9kCy75G/AA48b7JJWMGq1FLZ/wY7WBQRxXTljuXeUgYs1
         qcUMV/K82H0u7eY/LUk77LmM1S2LqO/OAG5qd4XPYsatMNkJFlAkJWm2j43EDh6xiH6B
         bDQjtO0O7OThX8yw8SU5xY6PtXe5+dEq4udzlHKIoXhUeSQrxcoMWwO9uANYUCGq1fLc
         PL8w==
X-Gm-Message-State: AOJu0YzNbqQr3hY7vuZOointWIc/UIuIVyNmH66UgEXodCKvDod01dYx
	z4aQKNoBvvF8GMpFA0wyadysubwzpHJCD523qMu0of8CEsaoM9M0wC8yZg==
X-Google-Smtp-Source: AGHT+IGmxt6VlGQaZNuKH5XdnUy55KyiXJp3b1FIiwy+OSkLpPI5bG9vWuehdibYrj4WlPqTAdCikw==
X-Received: by 2002:a05:6a20:12d4:b0:1b4:c499:788d with SMTP id adf61e73a8af0-1bcbb422be8mr8777745637.15.1718949729803;
        Thu, 20 Jun 2024 23:02:09 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:02:09 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
Date: Fri, 21 Jun 2024 11:17:09 +0530
Message-ID: <20240621060018.12795-11-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621060018.12795-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-record.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index bb2986eef6..e04aac8d7d 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -98,6 +98,26 @@ static void test_reftable_ref_record_comparison(void)
 	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
+static void test_reftable_ref_record_compare_name(void)
+{
+	struct reftable_ref_record recs[14] = { 0 };
+	size_t N = ARRAY_SIZE(recs), i;
+	char refname[100];
+
+	for (i = 0; i < N; i++) {
+		xsnprintf(refname, sizeof(refname), "%02"PRIuMAX, (uintmax_t)i);
+		recs[i].refname = xstrdup(refname);
+	}
+
+	QSORT(recs, N, reftable_ref_record_compare_name);
+
+	for (i = 1; i < N; i++)
+		check(reftable_ref_record_compare_name(&recs[i - 1], &recs[i]) < 0);
+
+	for (i = 0; i < N; i++)
+		reftable_ref_record_release(&recs[i]);
+}
+
 static void test_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
@@ -495,6 +515,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
+	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

