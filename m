Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F12E6116
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796742; cv=none; b=t7mnElnghYIrv0BDco8kGVqOpP+grLafbjD5fATSeVnyxV9CHIut2q6cugK5J5nUtxwrHOjNRrE1GDyP3wwLDg0trpmoHEbQloqObEbyj0jkV6RQjjihyjytWJv+GetTrim9DTQRDU04t82RNAPX4GbTV91NkSDq1qQ50b6nzo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796742; c=relaxed/simple;
	bh=z/RuY5xgeil9jDhU58AlcwvGa7Ie6B74FDT5nGNF+5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5su6rIZ2NuGkeA7jxNNgz+aIRQ6oH2p9iblMXIbgDOTflAq4hjCO9aELbPPwuRt5+b2ZLLOcPb+RVrsrkSSy9UWs/EWTcRGl1Bc8hyNcLcx7C1WqnFikYm6MBdaEGfDHoRjeTtVbxqayhtexJH+fbgUBFfeJVikwBBmZU69srs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLrC5xjl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLrC5xjl"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb78ead12so813304566b.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796739; x=1757401539; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAcf8rsKOwYkY0bzN+59CXvVXBsCjD4QF7ocSOsXoLY=;
        b=BLrC5xjlv8jnsFYtWCUb+9BDtQlspJlR4u5b9xfUYhbB4KHBpQWM4Y9+zJ73/7IfPP
         Ldu6Ns4mx/CaJifpA62u/B0riD4q/frpZHtFllLoy8vJIqkxkWrVQ3eUWXK/kwyNu1Av
         irWqp4a51/niW/Ho+flxlrspjmyYxVm6jW/tvxl3cE7sAzyPFbwBnPwnmiE6aOj/9G7V
         cT07Cd4FH+y2lgcS+Cd8L7khWDdZ+858ADY7qoFkq4DrOSWiAAQVX5oIpKGCCPWj3Otj
         d9/w0YiLpQ16d3phcFcBgdMnr+/EO1/UkBmztE8jTrizkbES7b2LJoL6LN6hVIejeFcB
         9aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796739; x=1757401539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAcf8rsKOwYkY0bzN+59CXvVXBsCjD4QF7ocSOsXoLY=;
        b=WSwvpJFF9PzZjDUbBon95L3fVt8/qdP3TbxLo83pCc/2qFHFSvOyWdFhv9Zq99Jmfn
         fqBw7y9oDO1ABDOzEbo3i8yzvJT1oOIXOK1gGluN8WIoVChPrz9z/2Yt91NKLv8GDImJ
         rGGdJJs6MDVUsIi+E/rNGujZwUzYBpktWTBB0dx+29Pg/blKL+X1nCqYnh1hynAPyayI
         SnSbvnoVX+VTXFoPmVLJgbF7zV/n+kYeAb2dVqbTzK58uiEGeKqwepMRKjmuW2Jwr+u3
         zWdOV0D13Eo3IybIm0jgTnF3ZDKvyCwl4VQidJRkedCzf6vekyVbRiR2fq+jNzdWYhZ5
         9VBw==
X-Gm-Message-State: AOJu0YyquRIdMUb8W8Ygcs8whExAVqKm0id/Imk/4/d94VgOHipg2+PI
	3fRsWJ0pJlavZVSQTEJYs7dkImsrlKRJ1QPYFv9yC6bmoi4tUYc8uO1psDJVBw==
X-Gm-Gg: ASbGncuWW9AjxdjFir2yHbCIRWErscCIPvBeCHMqZhEswnsxkafrRsvMtv+czMrn7jo
	JcuFFeIZ+esgda1T6a5+NFtkOyq4bOa3is+U61ZVA0Xquly1jjzIzlb4DnNsCsFL30oKtjMmqmd
	YTJhoMUjth08k20RwK/yY1y5kkMQANoKLj8xWpSQSAZ8Va6oA5dtgDqEwHu6fjVka2kX0Y0iJ56
	r/rsoTJmRCc+Hr+/qYJ01lK4is8cpBaSJUHhbo9yRJXQPixtqiqfLbHgVUDwCU2Ec/bKhouMDjr
	zbgVN4AcgmTDuewJG5MuEotvYAjGo+0NnywVxp99E9xqOw8y55EpFwmC7slonNfjku23YVqhBSp
	iBXiTchG8oi+wiELQ0/V5ThyMnrgx53iPwoVEiRo=
X-Google-Smtp-Source: AGHT+IFbfIFx2QXPnrPZP46Vd+USNMhaH863kBb811tRpWadZCMEk3IjYy480gvawhvnrDqMD7AisQ==
X-Received: by 2002:a17:907:728c:b0:afe:98cb:e624 with SMTP id a640c23a62f3a-b01d97abb2amr1074121566b.51.1756796738856;
        Tue, 02 Sep 2025 00:05:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:39c9:1f0d:23f0:502f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff9918dbd2sm821575866b.103.2025.09.02.00.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:05:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 02 Sep 2025 09:05:24 +0200
Subject: [PATCH v2 4/5] refs/reftable: add fsck check for trailing newline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-228-reftable-introduce-consistency-checks-v2-4-4f96b3834779@gmail.com>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5164; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=z/RuY5xgeil9jDhU58AlcwvGa7Ie6B74FDT5nGNF+5c=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi2lz0kjrX/EkWwnyrgfEYyiq62gyCajIIxI
 rCU5VdrZLasZ4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJotpc9AAoJED7VnySO
 Rox/qhYL/joaSNRnW3gIMYZWvUIF4gwc9iLmi3TSFkjG+7mtT2MQ8SPFZbnK2BB4hxHpmlt28GD
 GTi7iEQ2sxZV/wizjahxm+cBNXdYUO42HumVwHYFF07GanklvEOOcJisOL8TpvttNvyTnth9xEJ
 ev6omQ7CryBz/VccF7W7IaetEZz1+2ibU3LUG4oGpoFp6FJc/CAhYKo4HaV2YQV//ZPE623/YKO
 RTTyNfYg+NdDvoW8+9pzgFlP2ydDQ3bvO0rjtPEz753cIz7jn/wzENTGo4Pl2cKp52vFw2fwvBO
 RmZhgRQFOVsv3oS35h5VdTaqB6eFVfuATeI23/kP0MS+jbdeOcHnjUpXpDg05rpnvEhRD8l2x50
 SffLhWAtUyxw4eYNedT7EOTmt51KW+kleSGDOhZvzo/IEapXgp2YEt0UkYce4v7bUqSMeTa7XK+
 Iyrf0p1Hhyt6wB1kl8jdXUXrA+kX5q3Mcd/hVZvbi5YGi+iT7LGvA4yUzpRMmZOU5VaI3SuDfr6
 io=
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
index 59c39f9b52..7331513b19 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2698,6 +2698,9 @@ static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
 	case REFTABLE_FSCK_ERROR_STACK_COUNT:
 		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_COUNT;
 		break;
+	case REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE:
+		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_LIST_NEWLINE;
+		break;
 	default:
 		BUG("unknown fsck error: %d", info->error);
 	}
diff --git a/reftable/fsck.c b/reftable/fsck.c
index 20e6bfb0f1..9a7f22c56b 100644
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
@@ -69,6 +93,18 @@ int reftable_fsck_check(struct reftable_stack *stack,
 		}
 	}
 
+	verbose_fn("Checking trailing newline in stack list", cb_data);
+
+	if (!reftable_fsck_stack_contains_newline(stack->list_file)) {
+		struct reftable_fsck_info info = {
+			.error = REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE,
+			.path = "reftable/tables.list",
+			.msg = "trailing newline missing in stack list"
+		};
+
+		err = report_fn(&info, cb_data);
+	}
+
 	verbose_fn("Checking reftable tables count", cb_data);
 
 	if (!reftable_fsck_valid_stack_count(stack)) {
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
index beba1bdd1a..17df661da8 100644
--- a/reftable/reftable-fsck.h
+++ b/reftable/reftable-fsck.h
@@ -8,6 +8,8 @@ enum reftable_fsck_error {
 	REFTABLE_FSCK_ERROR_TABLE_NAME = -1,
 	/* Incorrect number of tables present */
 	REFTABLE_FSCK_ERROR_STACK_COUNT = -2,
+	/* Newline missing at the end of the stack list */
+	REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE = -3,
 };
 
 /* Represents an individual error encountered during the FSCK checks. */
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index 3a34a31890..3b119eae62 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -75,4 +75,25 @@ test_expect_success 'table count should be checked' '
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
+		error: reftable/tables.list: badReftableStackListNewline: trailing newline missing in stack list
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done

-- 
2.50.1

