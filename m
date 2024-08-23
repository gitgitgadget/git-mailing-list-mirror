Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D8185B4B
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414771; cv=none; b=iLuRyneP8c+czm9SKcDTWRBfLOU6eW8CFOgHuc1M5sfI7JOsUDxlI2sswSb1jjasKZGDif01p14QzxdCBOGz42HALbaL2+4c+hZtCNoJhvZ1jIglQGsRPEWVhJMRhFxkRPDOSM6ZZNj7w/rHXA9hfO+JAGlRCtNfbkkWRxXmwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414771; c=relaxed/simple;
	bh=K8pmFXdOfLl3pEcZq+pW0FGeD6aSzi26xuMjqDY9+1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIzsjacom0rxlV/kDFXlAxjwygxBI1lK4GAh7c49AB9Nw3hEwqLODIc+f9mNvGf0lhnwfFORryVrWaMBK48iOt5gVVsPRdVVmrmGnTpYK0PEKnqH9Kt0pTNY9SEFc8wvMt5Yn1wzLB2rzPqUTU+fCYXP9Mm0bxz08nPIRzF0vBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/rpcNGD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/rpcNGD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201fae21398so14447325ad.1
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414769; x=1725019569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR0ImOc1x0BwSrPXFz6rDH+SoieK36QIPfHTI1NeBbs=;
        b=F/rpcNGDUOcYfGCT7t/f5JufIORu0HJEnEVNFnUvkA+AHRMfT4tQMgxkqNHH07e5r1
         CdocuRSMVD1CLqwBW9yjZFEN6AJeoSx0v9HjU8P59xK3JIGzG/c9SNNWC/2lA9iwa0dm
         qqQuGWGt5/iRjjjeei5oxTAftskfzqtDHiQqfs4ExUYtbgf6/zLF4DlcD1rYOSkxrEbD
         KzUe2sdRvOSHXZehvo90AJ33y3S442cWaKakaj3c9O5EO6WiuLlvkkir0cxLqo6JEpYY
         Vl/N5EOQXIc5lAWnfZuPX3Rco2gmPvo3XSC/6NCkyolHN/CPK3eOn+Av42aca58Q7Bvn
         4CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414769; x=1725019569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR0ImOc1x0BwSrPXFz6rDH+SoieK36QIPfHTI1NeBbs=;
        b=at1g376609C07CU42/Vnrg0sfw6cRYsjTDQ30/Ll+a5eBM1SXj7ZogVH/1RKjJ0uPJ
         jhWZ9NHFBbolf02lDG99ixvhkGCHqJvkSKOwn8srJbvdFHgCMqr0QiPBw6heq9EAMOaA
         a3OOsubLBqpgElwcyRCPn9vvhaXR+iu5sGs9fgh2JAuiBBtNP6NvzBR2eLkYKgKQIIEm
         9FjCdB+f48gRjw0ia4cQ5AerFHyJrjb7bnrP+8veazS/Vjcx7SsiXiiKmY0FGkxcM7/T
         bBDC62FQnspEyoBL0soK815yf1vbe+7ycLK1DrXMHFRjt4ktcVg+LTnVA+Zz/fpfAejj
         ecAg==
X-Gm-Message-State: AOJu0Yzf9hzbhFf79BZYXyWdA7rEwSvwyR6s0p5ysqOr2dG0TR76AnsS
	Z2FPZkoZV+qR73Rxoz59ah5xMHPgJaMberK3ogTw7qOLxTppLvU+mL8EIg==
X-Google-Smtp-Source: AGHT+IG72rdA69WH/a+2ItT9EYA+ia0zm/W2V1QtEbPLst/5IYn5XFhCVm4xp43xRQ6deVXRq1iQAw==
X-Received: by 2002:a17:902:cec1:b0:201:ffef:4652 with SMTP id d9443c01a7336-2039e4bd250mr22011825ad.2.1724414769048;
        Fri, 23 Aug 2024 05:06:09 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.77])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855ddb10sm27171925ad.177.2024.08.23.05.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:06:08 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/6] t-reftable-stack: add test for non-default compaction factor
Date: Fri, 23 Aug 2024 17:18:50 +0530
Message-ID: <20240823120514.11070-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240823120514.11070-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a recent codebase update (commit ae8e378430, merge branch
'ps/reftable-write-options', 2024/05/13) the geometric factor used
in auto-compaction of reftable tables was made configurable. Add
a test to verify the functionality introduced by this update.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 41 +++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 7c76aa67fb..51339a9939 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -837,12 +837,12 @@ static void t_empty_add(void)
 	reftable_stack_destroy(st2);
 }
 
-static int fastlog2(uint64_t sz)
+static int fastlogN(uint64_t sz, uint64_t N)
 {
 	int l = 0;
 	if (sz == 0)
 		return 0;
-	for (; sz; sz /= 2)
+	for (; sz; sz /= N)
 		l++;
 	return l - 1;
 }
@@ -875,11 +875,43 @@ static void t_reftable_stack_auto_compaction(void)
 
 		err = reftable_stack_auto_compact(st);
 		check(!err);
-		check(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
+		check(i < 2 || st->merged->stack_len < 2 * fastlogN(i, 2));
 	}
 
 	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
-	       (uint64_t)(N * fastlog2(N)));
+	       (uint64_t)(N * fastlogN(N, 2)));
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void t_reftable_stack_auto_compaction_factor(void)
+{
+	struct reftable_write_options opts = {
+		.auto_compaction_factor = 5,
+	};
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+	int err;
+	size_t N = 100;
+
+	err = reftable_new_stack(&st, dir, &opts);
+	check(!err);
+
+	for (size_t i = 0; i < N; i++) {
+		char name[20];
+		struct reftable_ref_record ref = {
+			.refname = name,
+			.update_index = reftable_stack_next_update_index(st),
+			.value_type = REFTABLE_REF_VAL1,
+		};
+		xsnprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		check(!err);
+
+		check(i < 5 || st->merged->stack_len < 5 * fastlogN(i, 5));
+	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
@@ -1086,6 +1118,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
 	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");
 	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
+	TEST(t_reftable_stack_auto_compaction_factor(), "auto-compaction with non-default geometric factor");
 	TEST(t_reftable_stack_auto_compaction_fails_gracefully(), "failure on auto-compaction");
 	TEST(t_reftable_stack_auto_compaction_with_locked_tables(), "auto compaction with locked tables");
 	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
-- 
2.45.GIT

