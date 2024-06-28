Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D807E0FB
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556639; cv=none; b=peYndwsHI2HPhavsiXdOXT8jxV//FyJ2kJTY64ooRg90AsWOx0w3U5I5IlNVGZAzonZ5OEUnp50uvi1JldIDDjS/LH/mcSmYqv9EJHtXe+E+cC6ytf89iBAXVBQM79UIjTcuvE4HgTOJoh+CVq8XxZxLE8uKW+qGYFd1wjZHbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556639; c=relaxed/simple;
	bh=pJ3RRy2LV9Y1begKljn4MTG/q2YxPyWnq2jeuw4PwqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVkgeGB7sGZz43CHdG2lKfRShZECFKieP+97b/bcI/PH4fojR8nz4SKHD9ZSm3g+kU9qzC+79HnTXlSjNSm+XULCAUzWxXlSUOz0qbRPD/LbWaj/1zqllO78cFbFX+w1zWzg+v4C/dcskdQoZIF6YMcpdyiHuk96LUYmqSD0OIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8zplVBY; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8zplVBY"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d562b35fb6so158076b6e.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556632; x=1720161432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTKNtf0Hzo0wYVprslC7gTj07VA7lPre3x2EJnw78H8=;
        b=f8zplVBYQsy7B5bbY0X2kABvAOQ59CxXxxOemWMqhOH3zePHrXLLs5rPQ/CLZpKCkC
         zEq6cNv/5IigDeOLKimxDXmilZ24oJGABi/EW0GikupI2Ms1SX5+BlwCw1NuX84SmTi9
         sX1MI82VWZx5ZF6+gjZjjohD2uVf6uc6+Ae2tPfUMjXcOG272n3UQL+v5v/QSYYtquP1
         34wpdbwr5eopL0rUnACBv4zx7mxwAHqrsRqhtQaVuoH/7vAbqbLzkVXhwcbkXOewTR/Q
         7wMEnLuwfhvyLvW+gVMm13deZtgc9lSh+0q6XGZJEWn+ss/eH24aXikUY/PcPSRBwAVB
         Mx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556632; x=1720161432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTKNtf0Hzo0wYVprslC7gTj07VA7lPre3x2EJnw78H8=;
        b=rP8vA11kcimn6vIf/6x16pdBG7EL6/4JUHLRbVmymULetgzkEdcEOlaTCPgLS3Le+y
         dCaX1r46x0rD8wjxDpJgTxjbPksUn8yqYB7fJjTvMpfDV33ndSAN8okbVprv2D1/LW20
         KoVJiI9M6KRP4pjODwHMi6xWfEcl26v5UhrYsnJ67CmquU22hCzpm7fQnNmrv7rMIIPz
         bbxlGKjRk9aKkbuX7bdtIdheAv1irkfzNmVeTBrjEs3XM4Fxh1GyraHdLEJpycPO0bdm
         CPJUbaoplLpXo1+OiJ40D5b8bPgm2XbGebNjTsyOBnszK5Jr/xkW0S89jt2xEEHn/OiE
         owZw==
X-Gm-Message-State: AOJu0Yz2b8yRdtDgWmqFRmEr+RwiB4DLdPjymBSFQjFWNKLeQkNQvucS
	/BDdYjHtMLl9NSiQm0+qE93xIRONXOkixC/pRiqvjD2094NOleOyfiT3De2uW+U=
X-Google-Smtp-Source: AGHT+IGPYufva2CrsSpB+2vS5NUXjIfdPRrDF3mWOCmgUJcOVUEv/SEDOTm6/IxeNeNQna4pClZMrQ==
X-Received: by 2002:a05:6808:1388:b0:3d2:2b43:1808 with SMTP id 5614622812f47-3d541d45316mr19677517b6e.55.1719556632037;
        Thu, 27 Jun 2024 23:37:12 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:11 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 02/11] t-reftable-record: add reftable_record_cmp() tests for log records
Date: Fri, 28 Jun 2024 11:49:32 +0530
Message-ID: <20240628063625.4092-3-chandrapratap3519@gmail.com>
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

In the current testing setup for log records, only
reftable_log_record_equal() among log record's comparison functions
is tested.

Modify the existing tests to exercise reftable_log_record_cmp_void()
(using the wrapper function reftable_record_cmp()) alongside
reftable_log_record_equal().
Note that to achieve this, we'll need to replace instances of
reftable_log_record_equal() with the wrapper function
reftable_record_equal().

Rename the now modified test to reflect its nature of exercising
all comparison operations, not just equality.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 38 +++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 9305919e1e..82988d9231 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -120,24 +120,36 @@ static void test_reftable_ref_record_roundtrip(void)
 	strbuf_release(&scratch);
 }
 
-static void test_reftable_log_record_equal(void)
+static void test_reftable_log_record_comparison(void)
 {
-	struct reftable_log_record in[2] = {
+	struct reftable_record in[3] = {
 		{
-			.refname = xstrdup("refs/heads/master"),
-			.update_index = 42,
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = (char *) "refs/heads/master",
+			.u.log.update_index = 42,
 		},
 		{
-			.refname = xstrdup("refs/heads/master"),
-			.update_index = 22,
-		}
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = (char *) "refs/heads/master",
+			.u.log.update_index = 22,
+		},
+		{
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = (char *) "refs/heads/main",
+			.u.log.update_index = 22,
+		},
 	};
 
-	check(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
-	in[1].update_index = in[0].update_index;
-	check(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
-	reftable_log_record_release(&in[0]);
-	reftable_log_record_release(&in[1]);
+	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	/* comparison should be reversed for equal keys, because
+	 * comparison is now performed on the basis of update indices */
+	check_int(reftable_record_cmp(&in[0], &in[1]), <, 0);
+
+	in[1].u.log.update_index = in[0].u.log.update_index;
+	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
 static void test_reftable_log_record_roundtrip(void)
@@ -359,7 +371,7 @@ static void test_reftable_index_record_roundtrip(void)
 
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
+	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

