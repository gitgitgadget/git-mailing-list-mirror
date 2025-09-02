Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122E28507E
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796741; cv=none; b=ZTkVZgmoF3ARaIEwQpeJ63THnII2Xixrph/XRf10epIhnpVxXk8nWIE5UtQqYNLH43OT7YpAOnSjLFiZHTT2P6FKpRQCfr7vPlMaSL3XJlG/SO7vF92BxCNiLVp3PtLTyDUAzk+pSyzf7W5g4E/kuthRrwz55SGOZNRf94yIC7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796741; c=relaxed/simple;
	bh=wO6XCJOC1cz67Miw9AXeverOsaZtoNT3fsSmXD4TCYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZX7IxEFpJYXSZyo701m5e7m6sM7L2u0SSGAuJV1l8kUFRoPxKOZ58te0+SWvwS7iY3wF/YPG341iptIwYGjKINUFQ13k5KjZY/Hp9yv0dMby2h6oTSSuIKRY2YaN49ic5lqcKFTcruG7XMj5H8I71RS9tjCcWkisAqCcRzhwig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U98GqC0B; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U98GqC0B"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0439098469so207227166b.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 00:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796738; x=1757401538; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMj2eRLA1UhThfFrLB96AHmtBoG0HRR1fKqZ4kkuP54=;
        b=U98GqC0B03GhQGsLSMueqkvTcrW8wSDxfnf3rRJZe4sQYLIt4IofEYYDtBcRBq+aXj
         HM9n6aQd3VIXuLNiHSOG+ptR9g/pOyWmU3350cJfehOCWwnOmYztFyHKZWc4Endb7xEU
         mGor9hMFwc8KlYuo+6hOX8u1qRwRJCCT8qV6iGNRZMLwUIMIz/rfbD9P/lSp/7RGmu23
         s2ztA5FCrWGTAPu1r0S1e/xf3JkuI7Lk3EsUoE3xRjUDEiWSLNFOiDZjCcrYSOMCQFWu
         emxJPGKyL9rRqcCXpEjkUqIBqmKeYLE33+hT60vcYnKdJAbUhtH99LgQxyMcnPyS6DW2
         mMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796738; x=1757401538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMj2eRLA1UhThfFrLB96AHmtBoG0HRR1fKqZ4kkuP54=;
        b=jmBpuIVB2EGZ4qTqWPHhHqBdaNDL3RXNnFnJYLZ5sFX/JRZ9TjZss2NXOeL7b4PG3H
         b59xUv1BLpEL8kzz0sBM11TwsZGIe4olJkTifunOWVSwiAMTcmTalfP+3s9iVXsUrHld
         998zKuTBSSPHb52HOnKWch2sDK381kxp89paabWHBuHwZamaK6fRKkjMst6AgMauwl5H
         3//4P792vyDGMOsOhUGcg0h6/LPue2wbkGn7cRkdpz3XRaFczNbGlqQaDsUJDrHNVJgp
         HPKGZ8EmHyflojMVpa5IdunftNXt7jW3Dqqk1J/j7xlVde3qtc4vN5qSg4aH5f0F4Y6D
         5b1w==
X-Gm-Message-State: AOJu0YxSChz7wtiQojO6zMZu1ddzNl6L4ErzUvvVzjQAUfjN/0EKW99C
	F4+dmmz5SHe+sJsdY9MPPya8RGJVeiPbIYvIfm7IdV4LKaf1oGl/yKUo19u7gQ==
X-Gm-Gg: ASbGncs5Atjqj5p7VCYukGTDZNSTWt+S5ZjecjnrczQa1daLOWCQRz3S6adkQFwqq6l
	VxETar1zn4DPbS0LYufQryBfXMNHK4g8X9lybPt/xjIJvl0Mf+06DUop6+PjkWk3CHRJ0HJgU5V
	FEqZe1M7mrp8S1YYt+HAGWuI7gPzNIGmYpFUtJXyyi0wtYFYnB85OylePCPgPgyUbq/CNisE3IV
	6QoPygjSUynSAho+uRH/EmWfBmSAoFiv03/51DTAIMio/DV9HXuFzEM066d/t4fmlYF6xs7gX6D
	yd0Q8EVo9HayfsT+jjIksCRr3cS9eojftSYYjJn7XMAX3iOwURGe4KLT1Yd2N8la+5BIOZCJa+y
	7B2vXJeg2JisIiQSq+ZIp25Boz3lDwD3C2Dpw5rjdRYhKNobh7Q==
X-Google-Smtp-Source: AGHT+IEX0D8TnczVI7cML5FKuE8pew1c6GWYCPbHW8K/eXqj1nrUe87ic0czwDIDWX2Aftp5tIYQVw==
X-Received: by 2002:a17:907:1c87:b0:afe:ca26:5490 with SMTP id a640c23a62f3a-b01d8a71328mr1267519366b.16.1756796737912;
        Tue, 02 Sep 2025 00:05:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:39c9:1f0d:23f0:502f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff9918dbd2sm821575866b.103.2025.09.02.00.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:05:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 02 Sep 2025 09:05:23 +0200
Subject: [PATCH v2 3/5] refs/reftable: add fsck check for number of tables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-228-reftable-introduce-consistency-checks-v2-3-4f96b3834779@gmail.com>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4757; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=wO6XCJOC1cz67Miw9AXeverOsaZtoNT3fsSmXD4TCYw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi2lz1jBaxJvfvo7YRnG8RKJ0Bf8CzQbcDdp
 WxmXWetf3Anx4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJotpc9AAoJED7VnySO
 Rox/IYYL/jKuKtK0nLkdjtxSe8gjweoAoBjebXZFzOXsyPfyzK2QJW4uVQYnsnHxPpBKyXNqKrH
 p6bpbiY+OJev9P6XdC4bbGuNaygIFSXnNfHmmTkQcFggfD0ita+mXwuIgDi+rMqZA/H6eQxqfmh
 AyudLoIgJ7YVn2bf7VB7FTM10QitNeXpF0knCR/ncZOBrSTsPIVFUXG8QKUmuEnPhq5yCLKd/C3
 j7sLKEcrzq9y4M8CeaTj85ZG4PXV2EdRU0054PlgUHSqbXQgFl62aKPpXU9GePMui05CuGwVTlN
 DR+i4MJ3ajHx+mcu2Lezw9mXHwmUPDH1jWZ3tPVoXyCmGG35DL0oXZNBjsqJ1CzYdD0pSqPHn6M
 UdBje4EIssLeI1P0S9mN9uRUPZsXel6R5zD2XzYE+OzTKhR0+adBgoebnqXRJM6POJakPGdrca3
 i41lKlcSYHRX3/NaZQwJCprKdzZJCwKpOgrFHaMjxtVn437ScY8ll0DfxysDMICbM9bjHAwQAB5
 78=
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
index c38c6422f8..59c39f9b52 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2695,6 +2695,9 @@ static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
 	case REFTABLE_FSCK_ERROR_TABLE_NAME:
 		msg_id = FSCK_MSG_BAD_REFTABLE_TABLE_NAME;
 		break;
+	case REFTABLE_FSCK_ERROR_STACK_COUNT:
+		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_COUNT;
+		break;
 	default:
 		BUG("unknown fsck error: %d", info->error);
 	}
diff --git a/reftable/fsck.c b/reftable/fsck.c
index 4282b1413e..20e6bfb0f1 100644
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
@@ -47,6 +69,18 @@ int reftable_fsck_check(struct reftable_stack *stack,
 		}
 	}
 
+	verbose_fn("Checking reftable tables count", cb_data);
+
+	if (!reftable_fsck_valid_stack_count(stack)) {
+		struct reftable_fsck_info info = {
+			.error = REFTABLE_FSCK_ERROR_STACK_COUNT,
+			.path = "reftable/tables.list",
+			.msg = "mismatch in number of tables"
+		};
+
+		err = report_fn(&info, cb_data);
+	}
+
 out:
 	free_names(names);
 	return err;
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
index 4cf0053234..beba1bdd1a 100644
--- a/reftable/reftable-fsck.h
+++ b/reftable/reftable-fsck.h
@@ -6,6 +6,8 @@
 enum reftable_fsck_error {
 	/* Invalid table name */
 	REFTABLE_FSCK_ERROR_TABLE_NAME = -1,
+	/* Incorrect number of tables present */
+	REFTABLE_FSCK_ERROR_STACK_COUNT = -2,
 };
 
 /* Represents an individual error encountered during the FSCK checks. */
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index 81d30df2d7..3a34a31890 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -55,4 +55,24 @@ test_expect_success 'table name should be checked' '
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
+		error: reftable/tables.list: badReftableStackCount: mismatch in number of tables
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done

-- 
2.50.1

