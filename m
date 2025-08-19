Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2E341AA4
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606075; cv=none; b=F5ckrEMgSgnFcnxRH+F52+VJe599s0lGY+ersPyI/dZkO5LJ7EsnOFX0/s8HEM5Lq/l6e659/8AMZYpgE73xLdCZ/6f1B69RyeOmHRmHjcyPO6IjyzT1BhCk89GhsAdR4gkg4pysIf8dKdFR6w7zGoVFU7GqLrvTe2Sf8otivZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606075; c=relaxed/simple;
	bh=lK26mWEUgx113jIUcunAfDDmH/6tNJQMeXuuKZfJ7mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKfmW3xbOMBhPK8CCYkFoUJXm8nEwbbNCvm87tDfxeTseMPrITn6OMUK7nMsBnDFGiaiYESZK1XRQPm1fqbHWsMD7WknrLVxcAxL09GEuL1+5zP96Bb7Ocd361GqaZ7c1G+zSPwOvOACKmVUqd0mlpk4A+mtqyAuObKUUp1ZHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCbfN1s2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCbfN1s2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so43418485e9.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606072; x=1756210872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyVpofcifbfdHz/o2rFlUTAY9dqTNYDcls/QhvddamI=;
        b=VCbfN1s2r4amf0Lj9MSrH7UtZh9iLHpQihM2KT5rZezDs086AQNS5WRbPufwim6j72
         cIGDHFHdv2PD3hgfdy63ujK0VFb7TyqfPqoCY+gFVO2Db0ETeyemXfL6OfsQh9MQSb/E
         tsJVyc/2lswkiXimDFV+ipMUNpWC4+huXmO0lBKKtloeSjz7NrTC0fsb2way7Beb4eEE
         I7nE5rScq6MgpQhS+jEFRogLlACa4nzJX/bJfWqnzdZz3Mjg6Wv17qt4lZeNU+LU+5BL
         0BCReLlkcShpNbE/by0416nXyA06oN7SIAR9GA6cF9c7BBxp6RaXd9bCPeaynXgk0Yci
         1vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606072; x=1756210872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyVpofcifbfdHz/o2rFlUTAY9dqTNYDcls/QhvddamI=;
        b=RfAQUJpVomNczDEvquvo/mOyKwRxmi8JNzEZrzWEafP/LY7RBJf1Qb82VzWOjaV6BL
         FRjFhjz9nlXn37O0vvFzqFpFdFKWLLMfnfza22bfpbBJBp900C2K8lxp0VlxXoSEZCJB
         qSUSI+c4oQOIJodOvTVbpB4a8OpnZj51UUo2TOU/gm4rRgvQuzYRbIJWfFR72z4vDlqX
         P9OZfoUGdG0RCN9pKu1wj7KLRtIkzMnLtsE8ihFTpmzldGGOpEZd53a1joKeRgOPdKXy
         1a8SFHvA4U5Zrh9p5xy7pxST73+sVO+9DNobkdlZHxjxYt96AmXs3Ax9zTi3jC80QQI/
         CLiA==
X-Gm-Message-State: AOJu0Yw5e0OkpbLwc19egLqwmbwJaztI4iOwyIKR9i110aHFGKk4ZQkd
	Fott4EkDYx8fkvZcXU9s2KnlCTFWLpmpWbcrKbLF5dLacEZ4VDybChxEofPDkQ==
X-Gm-Gg: ASbGnctgMLYlnJILMclhj4E7A1XtcFzM4idGUcVyqKH2Fr4bJwt8RNUf6RgwE3ugjuh
	ogQw65vFQzAw5iLCtM2p/rlkp4jIdO0vo/WtZ/k/CXCVgE8IurbhUWwipJcgnvRGrS+VKywV1sq
	kq95d5TawZqSNWl7B3aePr54WovIHfHA8Hd0mrBLYi0XWrafF+36f1BTapb6qHhRSvrfCDPHNEM
	fI8kcNkVMFidSBwDdCfDCeer+uQF3D1uyfVYD9/GoYCnCnn9aOhbXT1+7m0x9yCGGdG7JSOrQRh
	p6M/k1C10PZvRwxwNWVZxw40uO/VlH7dt2KU9EbpFxxpxJlBmHAINS4lcBNNgb0CkZvoddjbX3l
	GUEVEH+i2EWNvkmzGVXTvS9pu
X-Google-Smtp-Source: AGHT+IEZbNStLrPBQtV881DLFIIjHkzkhVsxSvkaCVufYaBxP6ujbRvknjBc1Osk+zPIntuntJWsRQ==
X-Received: by 2002:a05:600c:3ba6:b0:459:4441:1c07 with SMTP id 5b1f17b1804b1-45b46489e46mr6342815e9.20.1755606071560;
        Tue, 19 Aug 2025 05:21:11 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.216.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1a97sm3501954f8f.31.2025.08.19.05.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:21:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Aug 2025 14:21:03 +0200
Subject: [PATCH 4/5] refs/reftable: add fsck check for trailing newline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-228-reftable-introduce-consistency-checks-v1-4-8b8f6879fa9e@gmail.com>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5168; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=lK26mWEUgx113jIUcunAfDDmH/6tNJQMeXuuKZfJ7mc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGikbDOBb0moujpE7VReGI7xMaKADikO3Pqa3
 5eXTQNGNlzJ3okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJopGwzAAoJED7VnySO
 Rox/5YIL/1vAsM2NSg637APIExZ7+xNcHUP6cd837ZfUyZvRWEbepB0EwC7LIY74JHR+8rXWYuY
 QIqAWOwfAATzTcj8yBV8GQH78PqPdq9E/iFv1P8XjyNJRltlal/+ypottBXmnZJjWVVuiZVGYCX
 44Q7YzBhJIkTcxgoParye1mQQHFmidG9nclffF2P0nUBbf5In1QYLRyg3EqdYtsMEtt74mtQxQq
 irQs4dwn2aiuHa0DQBm/D2j3IRbZofeThPM2h3Y4PI8r+TmeQe1VIp1/Mo99iFf5zXuNKbs0K+L
 2y8YB2FDJawlOMV0+aNT1nRH0XaSYh6OjRMAfBzw9ECQtdnkvTmjIDlsJ88kGpou/EDM3W21tDq
 WN/Nh/fO51WITP6pu9UDGR9zSCT1kXjQLVqMbL5OCA1uMLVwu5Wnt1Na6OZTop0CqKPLBbVtlvs
 XDEI0xjSnRA30kudQoGlPX0c9a7vEY8Xw8ZWFIWGSvlxb4rE6xjK5AllBGrlS3QB22lWP21jb66
 nk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a fsck check for the reftable backend, which checks if the
'tables.list' contains a newline. The reftable backend writes a trailing
newline when writing the 'tables.list', but it doesn't check for it when
reading the file. A missing newline however indicates that the file was
manually tampered with, so let's raise this as an error to the user.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |  3 +++
 fsck.h                         |  1 +
 refs/reftable-backend.c        |  3 +++
 reftable/fsck.c                | 36 ++++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h       |  2 ++
 t/t0614-reftable-fsck.sh       | 21 +++++++++++++++++++++
 6 files changed, 66 insertions(+)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 707e2fc50a..1432b1de06 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -41,6 +41,9 @@
 `badReftableStackCount`::
 	(ERROR) Mismatch in number of tables.
 
+`badReftableStackListNewline`::
+	(ERROR) Reftable stack list missing trailing newline.
+
 `badReftableTableName`::
 	(ERROR) A reftable table has an invalid name.
 
diff --git a/fsck.h b/fsck.h
index 256effc4f8..33432bae79 100644
--- a/fsck.h
+++ b/fsck.h
@@ -35,6 +35,7 @@ enum fsck_msg_type {
 	FUNC(BAD_PARENT_SHA1, ERROR)                               \
 	FUNC(BAD_REFERENT_NAME, ERROR)                             \
 	FUNC(BAD_REFTABLE_STACK_COUNT, ERROR)                      \
+	FUNC(BAD_REFTABLE_STACK_LIST_NEWLINE, ERROR)               \
 	FUNC(BAD_REFTABLE_TABLE_NAME, ERROR)                       \
 	FUNC(BAD_REF_CONTENT, ERROR)                               \
 	FUNC(BAD_REF_FILETYPE, ERROR)                              \
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 616f4ee0f3..0087afa3ac 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2698,6 +2698,9 @@ static int reftable_fsck_error_handler(struct reftable_fsck_info info,
 	case REFTABLE_FSCK_ERROR_STACK_COUNT:
 		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_COUNT;
 		break;
+	case REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE:
+		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_LIST_NEWLINE;
+		break;
 	default:
 		BUG("unknown fsck error: %d", info.error);
 	}
diff --git a/reftable/fsck.c b/reftable/fsck.c
index e92a630276..b4898fd2cd 100644
--- a/reftable/fsck.c
+++ b/reftable/fsck.c
@@ -1,7 +1,31 @@
 #include "basics.h"
+#include "reftable-error.h"
 #include "reftable-fsck.h"
 #include "stack.h"
 
+static int reftable_fsck_stack_contains_newline(const char *list_file)
+{
+	FILE *f = fopen(list_file, "r");
+	int c = 0;
+
+	if (f == NULL) {
+		if (errno == ENOENT)
+			return 0;
+		return REFTABLE_IO_ERROR;
+	}
+
+	if (fseek(f, 0, SEEK_END) == 0) {
+		long size = ftell(f);
+		if (size <= 0)
+			return REFTABLE_IO_ERROR;
+		fseek(f, -1, SEEK_END);
+		c = fgetc(f);
+	}
+	fclose(f);
+
+	return c == '\n';
+}
+
 static int reftable_fsck_valid_stack_count(struct reftable_stack *st)
 {
 	DIR *dir = opendir(st->reftable_dir);
@@ -66,6 +90,18 @@ int reftable_fsck_check(struct reftable_stack *stack,
 		}
 	}
 
+	verbose_fn("Checking trailing newline in stack list", cb_data);
+
+	if (!reftable_fsck_stack_contains_newline(stack->list_file)) {
+		struct reftable_fsck_info info = {
+			.error = REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE,
+			.path = stack->list_file,
+			.msg = "trailing newline missing in stack list"
+		};
+
+		err = report_fn(info, cb_data);
+	}
+
 	verbose_fn("Checking reftable tables count", cb_data);
 
 	if (!reftable_fsck_valid_stack_count(stack)) {
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
index 888c3968b7..8e6cb6c7d2 100644
--- a/reftable/reftable-fsck.h
+++ b/reftable/reftable-fsck.h
@@ -8,6 +8,8 @@ enum reftable_fsck_error {
 	REFTABLE_FSCK_ERROR_TABLE_NAME = -1,
 	/* Incorrect number of tables present */
 	REFTABLE_FSCK_ERROR_STACK_COUNT = -2,
+	/* Newline missing at the end of the stack list */
+	REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE = -3,
 };
 
 /* Represents an individual error encounctered during the FSCK checks. */
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index a351fed562..937c5dd37a 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -52,4 +52,25 @@ test_expect_success 'table count should be checked' '
 	)
 '
 
+test_expect_success 'stack list must contain trailing newline' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		printf "%s" "$(cat .git/reftable/tables.list)" >.git/reftable/tables.list.tmp &&
+		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: $(pwd)/.git/reftable/tables.list: badReftableStackListNewline: trailing newline missing in stack list
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done

-- 
2.50.1

