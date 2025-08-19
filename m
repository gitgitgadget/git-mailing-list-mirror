Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3633CEB4
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606074; cv=none; b=PhhqNWP9syMxNwviO/AdaeFBeBRr8n5GRf1gp2Z3qR7ihGdCPMqou31TxGuP6VOwv1GRzVHTDDVZ0DRHp4dtT9SmQhUnSBs0raz68Vsfvw2LRZiIt6H0BU8N8Iq/khcRn4aB62wSxRGxM7wBj+M3i+2CmXHbEOWf0UIotvndgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606074; c=relaxed/simple;
	bh=7NySYNte5xfgjsDMML5FLOSSy1hQSIDTPJ+3e7lkvFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gsjJkf9dgIdmAHWHpohr6voH46hvk54y0ORx/329hQGYURoq41NGtOLlXntgpPyUW3Wb6UIVi/dMWUU59brPW7bx7YPWB8mAWZMgK00r8P6cWFkvs8R2wa3t4atXVBYscx4rla/AS0xuQgUS9NT7z06Lusrnzb5HSdxvVcZxv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6ZDmtkv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6ZDmtkv"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3bb30c72433so1712474f8f.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606071; x=1756210871; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpfrZfZJRJMDiWfRB8gDnOxO0Jg5JGck1BsYvBjgNb0=;
        b=L6ZDmtkvblfY+YiFKoESYTetFVVWjxUxBHVb124xREjS7K535lIyr+ymSkfrwRHG5x
         u6qYR1D9cCZeBYBMpzPBrSBC4/g3kpfHtm448P03OO/1odxo1w4qhk7UhvEMiZNmg41P
         yoJBY2fk5kKbgrEXfAPyLPNlXrmddvtFTifnvoMXbOVExhYdp67fFjAKWwSWwh62uiMN
         p8CdCSMoapAOw6qmxYeE7s/gBuqFRgEdAmIgo7n19ZjjJG7ndcSQmJN2RucznJTYx5Ee
         NhBDLvOO01XCMttgkSlbEo5vlLmmXvdPwr4bXNWNapGVAJlV1SqDQaLZx9Lwh2GTrEYM
         6QRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606071; x=1756210871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpfrZfZJRJMDiWfRB8gDnOxO0Jg5JGck1BsYvBjgNb0=;
        b=LEnRoHBh/PByKYpy1oR6J7PdwXHZbYy502iOIcB9dZYpqXEaCJ66gn+NdpJ+VBKs6A
         yjCD4VOdIadFI8cX0fdCduBHSNC11Qfs5zl1iZQd3pxSLMaxiTwgUfhx+OrBrKfySMjX
         1xY2gEmVMcALp6cFXfpO8Py+/nL3R04oebUFDWjq/Hq3Wnn51ex6RBn4sP7hZCz8gqDA
         dujht/elio0iUrCOqSXC6AlLZRthZg2XuD0ccQx7SkIluOEAnZBTKq3D1pSAWT8Nkd/l
         f1hkpj1eaODYAbz/+3RC+Y9aHClITqzxQtAI0ipNVP4GfvxSavFK2mTDCt8iea90eviR
         DBZA==
X-Gm-Message-State: AOJu0YxmzS9Y0XGzWnn5M//hYCSTI6CKn4a+AJ3XXWgS92jV6WtOKODW
	mIF4vV/hDDgdjjTuF7J04DjQEoffQYSWDK+MH2BXOGYUnVbVjIEMfelnQ6y+oA==
X-Gm-Gg: ASbGncs/Q1oI/oO20OVPUlhFH8Cd6HJd4jTFnvWGNFVFfmZWvJS+J9cp+1+r+7wPocZ
	e5Cgu5QCQ1STfKJOvZJ+a5e9AARIUktw0bZVn+anKjkLNt/Cu6mG0QDcCtbjk7jioNwv4eLZAm/
	EWzGxN5UD2K/HMTvkvFYO6+voq6IkkH8OG8wJnkzZAcsIy22LbUBOIeksjG36n6ArppcOPUgvwW
	KpACxfz7XEbNNri3wTtgpJFA71+Htng7BVkeUwAp27QnMITu64x7QojmLY48/l6gdsUlVejX0nK
	ovkOCBWKWLh5hLV+EOU/gDAhBz3VCwqE4AMauu/HsEWrag/mQ9IB5srLM6tve5j9P7QnraHMPc0
	mg/UUHGHc9UboERV2m97rEC7A8dXOiRrdCDA=
X-Google-Smtp-Source: AGHT+IGyZ4F0YTfbn4CFdRvx+78x5UuGfuWSOWaHv3AuEWxRf1ClMzgfTZRP6E6OTKRlf776ATWJFg==
X-Received: by 2002:a5d:5d86:0:b0:3b7:942c:5450 with SMTP id ffacd0b85a97d-3c0ea3d1548mr1604281f8f.9.1755606070847;
        Tue, 19 Aug 2025 05:21:10 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.216.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1a97sm3501954f8f.31.2025.08.19.05.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:21:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Aug 2025 14:21:02 +0200
Subject: [PATCH 3/5] refs/reftable: add fsck check for number of tables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-228-reftable-introduce-consistency-checks-v1-3-8b8f6879fa9e@gmail.com>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4761; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=7NySYNte5xfgjsDMML5FLOSSy1hQSIDTPJ+3e7lkvFU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGikbDNCWv1mXAOx/VENl0hRubkAQb77LTDqM
 r4DHe4tR08m6okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJopGwzAAoJED7VnySO
 Rox/Mq0L/RhaIhZXnzURO13VT2xU1/dK5xnq6xmtECgOcFsDO3kgYW3uhfPT/3L1PPSEd3xowC2
 hSdbEDsWts7etnTNWmm6n4M45eF/Q69zzEG++/GU+eztK9e6FQpDakq7kaob0j1xukfcrusl4sM
 rPatQAwpEIchW6Obkc2tdScjx3h2Yw/ngCT3Ncuzi3X/Ohazh/R66tLwbWmHBt7PjS7jDLY7d4R
 8W7SbGEWFskO2dEukfEJludypkK8FFJIAOaJfghSDptopYHyrBO6q/vA+bCY7GYG19xVRtVlbCr
 OlZYrk/D09Osc9ksa3fcNNNqFmK0mfEWJOoG6vVwh1v/aBTk6pgc0aCQvrGWQREHArLdKNbeojw
 Bkg65Bf8zxF2i7aXQ8t18Hc61C0ujQYiOTFwGxpl+AKpwvAaE9pmrPsYQQeVtNp2k3KcomWv2Xc
 tTGI1xURJ1lgZLJTx+qrGdTJzBOM2vR2OrTfR3YVkn0WEWOVei2zBclQTyYhp15FOVp5RQG8MU5
 wY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a reftable fsck check to check that the number of files in the
reftable directory matches the number of files listed in 'tables.list'.
We do this by iterating over the files in the reftable directory and
counting all the files present excluding the 'tables.list'. This is also
exposed over Git's fsck checks as a 'badReftableStackCount' error.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |  3 +++
 fsck.h                         |  1 +
 refs/reftable-backend.c        |  3 +++
 reftable/fsck.c                | 34 ++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h       |  2 ++
 t/t0614-reftable-fsck.sh       | 20 ++++++++++++++++++++
 6 files changed, 63 insertions(+)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 784ddc0df5..707e2fc50a 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -38,6 +38,9 @@
 `badReferentName`::
 	(ERROR) The referent name of a symref is invalid.
 
+`badReftableStackCount`::
+	(ERROR) Mismatch in number of tables.
+
 `badReftableTableName`::
 	(ERROR) A reftable table has an invalid name.
 
diff --git a/fsck.h b/fsck.h
index 5901f944a1..256effc4f8 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,6 +34,7 @@ enum fsck_msg_type {
 	FUNC(BAD_PACKED_REF_HEADER, ERROR)                         \
 	FUNC(BAD_PARENT_SHA1, ERROR)                               \
 	FUNC(BAD_REFERENT_NAME, ERROR)                             \
+	FUNC(BAD_REFTABLE_STACK_COUNT, ERROR)                      \
 	FUNC(BAD_REFTABLE_TABLE_NAME, ERROR)                       \
 	FUNC(BAD_REF_CONTENT, ERROR)                               \
 	FUNC(BAD_REF_FILETYPE, ERROR)                              \
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index ccd12052f2..616f4ee0f3 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2695,6 +2695,9 @@ static int reftable_fsck_error_handler(struct reftable_fsck_info info,
 	case REFTABLE_FSCK_ERROR_TABLE_NAME:
 		msg_id = FSCK_MSG_BAD_REFTABLE_TABLE_NAME;
 		break;
+	case REFTABLE_FSCK_ERROR_STACK_COUNT:
+		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_COUNT;
+		break;
 	default:
 		BUG("unknown fsck error: %d", info.error);
 	}
diff --git a/reftable/fsck.c b/reftable/fsck.c
index 22ec3c26e9..e92a630276 100644
--- a/reftable/fsck.c
+++ b/reftable/fsck.c
@@ -2,6 +2,28 @@
 #include "reftable-fsck.h"
 #include "stack.h"
 
+static int reftable_fsck_valid_stack_count(struct reftable_stack *st)
+{
+	DIR *dir = opendir(st->reftable_dir);
+	struct dirent *d = NULL;
+	unsigned int count = 0;
+
+	if (!dir)
+		return 0;
+
+	while ((d = readdir(dir))) {
+		if (!strcmp(d->d_name, "tables.list"))
+			continue;
+
+		if (d->d_type == DT_REG)
+			count++;
+	}
+
+	closedir(dir);
+
+	return count == st->tables_len;
+}
+
 int reftable_fsck_check(struct reftable_stack *stack,
 			reftable_fsck_report_fn report_fn,
 			reftable_fsck_verbose_fn verbose_fn,
@@ -44,6 +66,18 @@ int reftable_fsck_check(struct reftable_stack *stack,
 		}
 	}
 
+	verbose_fn("Checking reftable tables count", cb_data);
+
+	if (!reftable_fsck_valid_stack_count(stack)) {
+		struct reftable_fsck_info info = {
+			.error = REFTABLE_FSCK_ERROR_STACK_COUNT,
+			.path = stack->list_file,
+			.msg = "mismatch in number of tables"
+		};
+
+		err = report_fn(info, cb_data);
+	}
+
 out:
 	free_names(names);
 	return err;
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
index 087430d979..888c3968b7 100644
--- a/reftable/reftable-fsck.h
+++ b/reftable/reftable-fsck.h
@@ -6,6 +6,8 @@
 enum reftable_fsck_error {
 	/* Invalid table name */
 	REFTABLE_FSCK_ERROR_TABLE_NAME = -1,
+	/* Incorrect number of tables present */
+	REFTABLE_FSCK_ERROR_STACK_COUNT = -2,
 };
 
 /* Represents an individual error encounctered during the FSCK checks. */
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index 0d11871b1c..a351fed562 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -32,4 +32,24 @@ test_expect_success 'table name should be checked' '
 	)
 '
 
+test_expect_success 'table count should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		touch .git/reftable/0x000000002812-0x000000002813-c830a596.ref &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: $(pwd)/.git/reftable/tables.list: badReftableStackCount: mismatch in number of tables
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done

-- 
2.50.1

