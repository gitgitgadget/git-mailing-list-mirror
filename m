Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F24340DBC
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606076; cv=none; b=kfWT0RJDfxTjMqfk/612srLCDMD9I4HDCO1y6FC+ybY77BglZNWBgyR1MaT/M3FPyIfaTUiYgzGPSYBpMmJLjHdpHgRTrCYvlM3rQgEFi7JPgVunJrqg3h2xS7NLgQTyIeDNu8CTsI5ODEFobIQvChNo//5x+c9Sd8TjsdX2p9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606076; c=relaxed/simple;
	bh=VleGcEC1bswoI3ZT4Qc9WSBs66C783AK61qtxS2vsi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uF8ZrRD7uPlSyxK8yPymvxHt7KrlaJ8BDLCAFtd1P5NKB0ePaqAK9W4SburBt1rSI9Q5bsM7xBtRFK6qWe4fBwU4QOBmsfVxbNYdAxVUjl9DPCRKhPsGdLFaKiTOQQ5JijZdOqTSCmgsiksxZpV70mkZfn82bhbNzjyIwtS5Xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf6O+qPC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf6O+qPC"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9e4147690so3437007f8f.2
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606072; x=1756210872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UybkPc4bAxyKhtnHsUQy93u0fPa2OEZDhmkPyuJe6ik=;
        b=Hf6O+qPCnimooPqpsrFhB6f3gDAWW1yvqMsPmk0WyRL6gKh2RSB+U0jakevwXF7FAd
         dVbOB/5J66ZPqWkh5Wp4lJCbzBX3uyJmx3Dr+tNwtx2Xz//B01M9ugKxRwGPzEDEhwvI
         41SsWQh8YTfFqvFeZCeafvlG8bWaTPY6UsgSYpfUTYtjkdlYwCaFj23THimncYBU6qsa
         oHPwB1YGw8JQy9KRo3OxLkoMLY+8IAy6UwP7e4kcC981J0v13RKkdzNKKn4aua+237CC
         QBBLqlfqE1SH+YjrdFthw5/EU6K/4wz5oZZsPax+yMfdqL6bFvEKDZEWCxyh5D/vR0d2
         ehgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606072; x=1756210872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UybkPc4bAxyKhtnHsUQy93u0fPa2OEZDhmkPyuJe6ik=;
        b=ClSua3+x3aUKSODzDkZaXy05DLZd68/0s2flZX4YR0DZtOQizvr6y5Ye7Q42edHPkH
         rhPLei5AvhWhHBoPZ+hxwl36VPCzadTrRrBTgF2w73zd6gUg52s4ajpLnm9aCm9g3R+Y
         IHqJ+B0mxoIdWz35hQc2J2x4ngtKE+TlVkxkHxMFtNPwEDKo5Shl5bYFJAW1ZwySmInm
         n8TEpYv39PQENaMqBH9gneaJJERpkMoistWrPri0Ghqfu6NnEIpmqmBQhq31+2bwUgzH
         bOMNVy5Q0rzxENvus/sIhovB2vCRMg43bT0Bcn7r/mC7SPNVdLWQeVtwL6LO3oCI6uHK
         sekw==
X-Gm-Message-State: AOJu0Yyy/DbJ3WEktwgVpXVsZ8xOYV31UnP+3lGI2CAz7gfdIoTGtqca
	aVDg+6tiIpPHab51iKJ7L7FcxKnnszBGcdnFHZfZU34FgW9lzxy+Kb/zW3707g==
X-Gm-Gg: ASbGnctEK/gf6gkuJBk8zVWaQePd8HJ6+K0ISb/a4wr0sxzO/XBM3iP3fzj+/xoiZYn
	BKqTdhHIgMEZ37/qpJ0WCLFiWnQ1sDlSdZenFJ6TDDqEB43lHyzBEq+wI55w96HApDNYccMQ6G0
	Pwe0Nya1surNE7vib+5DYER8vIETTKmSlbI0OTip4wlR8FZcSCAVMEz6D4PlalywFP7GeEdmJHB
	0m4NFGEojwPS1jy6zDreQ2bwxWWgsqbgsH4gXUh1j/oR28qGNtt41K35XM7XJyrTqla7ca5y9Ti
	WbHa5keOC+8jl5tIUJgvn+HTJvZie5MBuhIf/AR2NkWjk1wRGYyOkbzRKg5oFl0t/tdiqJVa3El
	4cavUbzjtbAGzg4INTFmwdY29I2qJZaqElG4=
X-Google-Smtp-Source: AGHT+IEDmqkly8uj6baEXqst5HC9MluZdYdicBxO8TMdvCB2nz7DVtT/eKHHY5zct+Dvxx2JF/IzlQ==
X-Received: by 2002:a05:6000:4024:b0:3b9:2960:bf3b with SMTP id ffacd0b85a97d-3c0ecc323f1mr1768980f8f.50.1755606072307;
        Tue, 19 Aug 2025 05:21:12 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.216.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1a97sm3501954f8f.31.2025.08.19.05.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:21:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Aug 2025 14:21:04 +0200
Subject: [PATCH 5/5] refs/reftable: add fsck check for incorrect update
 index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-228-reftable-introduce-consistency-checks-v1-5-8b8f6879fa9e@gmail.com>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6501; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=VleGcEC1bswoI3ZT4Qc9WSBs66C783AK61qtxS2vsi8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGikbDNjn8X4SZLtEFqFw2OiNjZmzqmeXa3Ez
 WksqgrYGDFDgIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJopGwzAAoJED7VnySO
 Rox/Ti4L/0Xv31CzZ37wtyfGj/w43YURX3QGa/sTK0A3bb/jkBgflqy2BFzIUhdI570Lgj3u8qQ
 C5nVvRr1xqbD2PAdIjS8DdckRUoiAYwjheIaI4iYZt7JqugVSO1ps88CdbAK/SnJ5/ap8eO6j7T
 Hn2mMPaNjHfarCafDJJ1uYaL4xhxQiYcsPPGXSsY8WlajnOEoi5krOAzUa5ijsIPqXkFIxAPGVk
 ixyS0Ktus1r2DeeIr56W4fIrI824INil76fch1MakpU1tT3KUb+WW6NDJZu9eaZnkbhA1wFhdfq
 xJwKJjJEW3ugLB/DAvQScO6BGBcd6MngkpjOpg6JRpk4hl78DGVNMOxpVQLF92fnRDTvsWceT1w
 owAmuwSjwxNVx6GsBpuv73i3WYTLZMrdCWOKk5XXu+Kkk828FxlvgZdGh5ldevRlb8HgSTl8fp5
 sy38F3PYsbKW3d0m+4mTN8j1bRvVN1q7YDK3PWdV5q22B7Yfw6OGRwY10OMV7+BrqPPzFTS6ye5
 eM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a fsck check for the reftable backend, which checks if the
tables in 'tables.list' contain sequential update index. The tables in
the reftable backend should contain sequential update index. This fsck
check ensures that.

We must note that the reftable backend itself doesn't check to ensure
this and it also doesn't check to ensure that the index in the table
name matches the index in the header or the table. The latter is not
implemented in this fsck check either and will be added in a future
patch where we add fsck checks for internals of a table.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |  3 ++
 fsck.h                         |  1 +
 refs/reftable-backend.c        |  3 ++
 reftable/fsck.c                | 14 +++++++++-
 reftable/reftable-fsck.h       |  2 ++
 t/t0614-reftable-fsck.sh       | 62 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 1432b1de06..982d51876c 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -47,6 +47,9 @@
 `badReftableTableName`::
 	(ERROR) A reftable table has an invalid name.
 
+`badReftableUpdateIndex`::
+	(ERROR) Incorrect update index found for table.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index 33432bae79..60e9b84183 100644
--- a/fsck.h
+++ b/fsck.h
@@ -37,6 +37,7 @@ enum fsck_msg_type {
 	FUNC(BAD_REFTABLE_STACK_COUNT, ERROR)                      \
 	FUNC(BAD_REFTABLE_STACK_LIST_NEWLINE, ERROR)               \
 	FUNC(BAD_REFTABLE_TABLE_NAME, ERROR)                       \
+	FUNC(BAD_REFTABLE_UPDATE_INDEX, ERROR)                     \
 	FUNC(BAD_REF_CONTENT, ERROR)                               \
 	FUNC(BAD_REF_FILETYPE, ERROR)                              \
 	FUNC(BAD_REF_NAME, ERROR)                                  \
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0087afa3ac..d5993238db 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2701,6 +2701,9 @@ static int reftable_fsck_error_handler(struct reftable_fsck_info info,
 	case REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE:
 		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_LIST_NEWLINE;
 		break;
+	case REFTABLE_FSCK_ERROR_UPDATE_INDEX:
+		msg_id = FSCK_MSG_BAD_REFTABLE_UPDATE_INDEX;
+		break;
 	default:
 		BUG("unknown fsck error: %d", info.error);
 	}
diff --git a/reftable/fsck.c b/reftable/fsck.c
index b4898fd2cd..a6551b9a3c 100644
--- a/reftable/fsck.c
+++ b/reftable/fsck.c
@@ -53,8 +53,8 @@ int reftable_fsck_check(struct reftable_stack *stack,
 			reftable_fsck_verbose_fn verbose_fn,
 			void *cb_data)
 {
+	uint64_t min, max, prev_max = 0;
 	char **names = NULL;
-	uint64_t min, max;
 	int err = 0;
 
 	if (stack == NULL)
@@ -85,9 +85,21 @@ int reftable_fsck_check(struct reftable_stack *stack,
 			err = report_fn(info, cb_data);
 		}
 
+		if (min != (prev_max + 1) || max < min) {
+			struct reftable_fsck_info info = {
+				.error = REFTABLE_FSCK_ERROR_UPDATE_INDEX,
+				.path = names[i],
+				.msg = "incorrect update index in table name"
+			};
+
+			err = report_fn(info, cb_data);
+		}
+
 		if (strcmp(tail, ".ref")) {
 			err = report_fn(info, cb_data);
 		}
+
+		prev_max = max;
 	}
 
 	verbose_fn("Checking trailing newline in stack list", cb_data);
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
index 8e6cb6c7d2..49437280bb 100644
--- a/reftable/reftable-fsck.h
+++ b/reftable/reftable-fsck.h
@@ -10,6 +10,8 @@ enum reftable_fsck_error {
 	REFTABLE_FSCK_ERROR_STACK_COUNT = -2,
 	/* Newline missing at the end of the stack list */
 	REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE = -3,
+	/* Incorrect update index for table */
+	REFTABLE_FSCK_ERROR_UPDATE_INDEX = -4,
 };
 
 /* Represents an individual error encounctered during the FSCK checks. */
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index 937c5dd37a..bdcbd65a9f 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -73,4 +73,66 @@ test_expect_success 'stack list must contain trailing newline' '
 	)
 '
 
+test_expect_success 'table update index should be sequential between tables' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		# Lock the existing table to disable auto-compaction
+		CUR_TABLE=$(cat .git/reftable/tables.list | tail -n1) &&
+		touch .git/reftable/${CUR_TABLE}.lock &&
+		git update-ref refs/heads/sample @ &&
+		rm .git/reftable/${CUR_TABLE}.lock &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		TABLE_NAME=$(cat .git/reftable/tables.list | tail -n1) &&
+		NEW_TABLE_NAME=$(echo ${TABLE_NAME} | sed "s/0003/0009/g") &&
+
+		sed "2s/.*/${NEW_TABLE_NAME}/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
+		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
+		mv .git/reftable/${TABLE_NAME} .git/reftable/${NEW_TABLE_NAME} &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: ${NEW_TABLE_NAME}: badReftableUpdateIndex: incorrect update index in table name
+		EOF
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'table update index should be sequential within a table' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		# Lock the existing table to disable auto-compaction
+		CUR_TABLE=$(cat .git/reftable/tables.list | tail -n1) &&
+		touch .git/reftable/${CUR_TABLE}.lock &&
+		git update-ref refs/heads/sample @ &&
+		rm .git/reftable/${CUR_TABLE}.lock &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		TABLE_NAME=$(cat .git/reftable/tables.list | tail -n1) &&
+		NEW_TABLE_NAME=$(echo ${TABLE_NAME} | sed "s/\(.*\)0003/\10002/") &&
+
+		sed "2s/.*/${NEW_TABLE_NAME}/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
+		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
+		mv .git/reftable/${TABLE_NAME} .git/reftable/${NEW_TABLE_NAME} &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: ${NEW_TABLE_NAME}: badReftableUpdateIndex: incorrect update index in table name
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done

-- 
2.50.1

