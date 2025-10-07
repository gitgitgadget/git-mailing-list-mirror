Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E792DE6FC
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839102; cv=none; b=Aq1g66pU8vrtdP5T519iN1V+RcvSKreBLg7qsTSbi9cZqo6kuka3kNHf5dRFwL/g22LxkER/riA16/vuKjAhzW5nGo3s2Hnykd6/WHvGPXO0y9tHCbkWS4y5o5EqLuoxse1PLZztSkHpR64gcWve+j8iD99eHwJ6EsCdGrPppFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839102; c=relaxed/simple;
	bh=8pu02Pbs69YrtElU9PJNvgsE2tA96Td/IGEF0c8v3IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d67WRLYkDmRh4RCw0n8CWHMGMxZN5WtVhsmUkgxSN3b00JNOjVHxwFp8jcOoOPE0X+8Je+q4NxICPj5f6oUMPq2/t//z7x/TFRxQj5/JAGEgi/yJ7yT5vrE+Z3t5pCnz4l+CcHXghxVfgPIdGo1o7v5UnfxjG173F2RRC6f+mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2fWPjpn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2fWPjpn"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b456d2dc440so985276066b.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839099; x=1760443899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djy2wyY3fAXCCEAcu6XnkFcXVHHN28jteNj/JmHlLMw=;
        b=V2fWPjpngxC3ak1tIoukpT+SwAqAxDLpEiDW6xxvFRahW7H2o4hvlzRtqSRGYT+Pp/
         8avxHHSSa1Im96spgWkafiHZvPYB5TdW3ptfEriOUg02b0QviB1CCS37lB1u/1evgNxw
         hQE/CmTVUCIq5Wa2b+/oNIVbZLgP7TfDfDSCySk2sn2csviuDlCBjt8sU1uWIPoHzsRc
         nqCFUPY2TsAkysy4Obq3l30EhYvzazV/cUod3E+1dS/IU8Gs0DMhuUDWIEuMoDYIROcs
         7fObxbZwQ6X2slmLJ6Gy61NDWtOciv6jZ2ZXe248ANbyZmvNYvrDls85Bm+8eFI0Wfvm
         o02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839099; x=1760443899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djy2wyY3fAXCCEAcu6XnkFcXVHHN28jteNj/JmHlLMw=;
        b=xGNnP6bb/gWgVnGxB18iKU55RAtAb0bsNQ+0ILn3PlmVEQq9CqUyUFoLky3OiiNv8/
         cnKi17fDbKrUjGC1o0mFgbdSaGfmovttqdGV3qmAUDUCpY7S5coKW2RxlFwoMz1GeCkM
         yEQWUcLpAixmRnD7H6Q6W5VJ3BDCKAt2ZrRJ3dXCScC4TgPNoZBIjGKY2sP5MZA7UnRo
         4/07WyytsUXzaqB5U41CQkuN59VtI+h2QmEvBXV2+jQGP/PJQapXhPcSwtWZLQ86ln7d
         /NDg/af6tLxFW4MjjlOid1i3QC17fmXivedpBlPrCqAcmdBQiw5N0pFRj0xO7cWEPtfV
         NNZw==
X-Gm-Message-State: AOJu0YxyztVq4GhvAA24hx88ewggCF4+EE0ZztaK7em5zpxuxWR7UuW1
	OdCWjLQF++Q7MvT/r7MCdwPe3lvSp5F3+WBlVNhhk1WpNE5gN2Krq1sW
X-Gm-Gg: ASbGncsTosNcuqmqdBLY1EdBbVV6fZmrQohniVm6S+MkpJdKzel3zZpfOapDi9j2WyR
	vfD0ekL8MyoVOkF9hxy2yflHANRPQc1jrRfm1um27wNZZ8T4IYmKVBrtu4hViqQE7lBLtTQt+4o
	iuIa6S1x49t9Qf0uCmTzQG4WiiiyMZenS6bkCBOu87Vf0vYw1inoXCRtvcg1oig/nCrNVoOPOE3
	ZXy3M11plU5zO2BJ/2NgQmhs4JwA8HWqi5YhWX2n4JWr97C3MVWqf2Te1obztHZETickZSns5LE
	38arLjEmtt8VS1w8JTdVa2BRZ5gQSW18jaA/whrOXogI3ewXFZbzDTjPCwu4aFeb2WWax0OBybG
	9y+hD3WVRUQUKsFnjywhNUZVmr6PwOuoYehbp56FOGEkEX8/f
X-Google-Smtp-Source: AGHT+IFQAK8Li2ie4zDH3NA7tdmgMW1vTnWEKwbf+Z/9etxqB0mrDb58Lm3FzOy3ae8xOvk9Im9Wtg==
X-Received: by 2002:a17:907:9692:b0:b45:a84e:8b88 with SMTP id a640c23a62f3a-b49c4498b98mr1756485466b.58.1759839098557;
        Tue, 07 Oct 2025 05:11:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:406:6e87:ed:4c93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1367386866b.62.2025.10.07.05.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:11:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 07 Oct 2025 14:11:29 +0200
Subject: [PATCH v6 5/7] fsck: order 'fsck_msg_type' alphabetically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-228-reftable-introduce-consistency-checks-v6-5-638cff42f0b0@gmail.com>
References: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
In-Reply-To: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, peff@peff.net, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=8pu02Pbs69YrtElU9PJNvgsE2tA96Td/IGEF0c8v3IQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjlA3TVjw4PX8Unpanw+wPg2cte5PZ7VfUAd
 JRFHUh/BteWrokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo5QN0AAoJED7VnySO
 Rox/6jgMAIvm+0f7kgi8RoT1LQS3oufwIs0VZNQnG/eGZwfqabMhnnl7+cPtGsIJUOOml5lojgg
 lDSNH85yaTGamngbLVhk+ztrRpZ9MyGX7QMFkXGoDsDm4ShjsYyMkCmbzct6RhR9iHW4VgXxW7b
 TKP4RJkwyee2j6QB99Ce9PjE02BIkvrKd179RfK9PMkBmHc66okI+8mbFWxJJR0SjnbVJKFkclk
 a2cpfsIill2HUE/yuFZFLjIxoaCv+1wzsEJq2HUHkicuwJmdDLl/foTZ4F9NzUEnR8S4VVf8AYK
 uQng7u7ajYLG3gc0MKpuh9PNdutL7+wHTGSKIaif5ziML/RC3Zam4/fxJ3/Q4MghMvlYHXHblQj
 PtCTuVTPSF68MMZ4aSubbuqkDqxN8r5gd3d5SE7323reedCZhnAZCjeqEOdJ98FZYyJQ80FdvW4
 LAZxfyGz4kC7xwjzb2AXhIP7EFfI0c+V09X28ty19r35NBH2GAO3pWWQ5xSjTczonAggt9Ae/c5
 UI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The list of 'fsck_msg_type' seem to be alphabetically ordered, but there
are a few small misses. Fix this by sorting the sub-sections of the
list to maintain alphabetical ordering.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 fsck.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fsck.h b/fsck.h
index dd7df3d5b3..6b0db235e0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -33,15 +33,27 @@ enum fsck_msg_type {
 	FUNC(BAD_PACKED_REF_ENTRY, ERROR) \
 	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REFERENT_NAME, ERROR) \
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
-	FUNC(BAD_REFERENT_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
 	FUNC(BAD_TYPE, ERROR) \
 	FUNC(DUPLICATE_ENTRIES, ERROR) \
+	FUNC(GITATTRIBUTES_BLOB, ERROR) \
+	FUNC(GITATTRIBUTES_LARGE, ERROR) \
+	FUNC(GITATTRIBUTES_LINE_LENGTH, ERROR) \
+	FUNC(GITATTRIBUTES_MISSING, ERROR) \
+	FUNC(GITMODULES_BLOB, ERROR) \
+	FUNC(GITMODULES_LARGE, ERROR) \
+	FUNC(GITMODULES_MISSING, ERROR) \
+	FUNC(GITMODULES_NAME, ERROR) \
+	FUNC(GITMODULES_PATH, ERROR) \
+	FUNC(GITMODULES_SYMLINK, ERROR) \
+	FUNC(GITMODULES_UPDATE, ERROR) \
+	FUNC(GITMODULES_URL, ERROR) \
 	FUNC(MISSING_AUTHOR, ERROR) \
 	FUNC(MISSING_COMMITTER, ERROR) \
 	FUNC(MISSING_EMAIL, ERROR) \
@@ -60,39 +72,27 @@ enum fsck_msg_type {
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
-	FUNC(GITMODULES_MISSING, ERROR) \
-	FUNC(GITMODULES_BLOB, ERROR) \
-	FUNC(GITMODULES_LARGE, ERROR) \
-	FUNC(GITMODULES_NAME, ERROR) \
-	FUNC(GITMODULES_SYMLINK, ERROR) \
-	FUNC(GITMODULES_URL, ERROR) \
-	FUNC(GITMODULES_PATH, ERROR) \
-	FUNC(GITMODULES_UPDATE, ERROR) \
-	FUNC(GITATTRIBUTES_MISSING, ERROR) \
-	FUNC(GITATTRIBUTES_LARGE, ERROR) \
-	FUNC(GITATTRIBUTES_LINE_LENGTH, ERROR) \
-	FUNC(GITATTRIBUTES_BLOB, ERROR) \
 	/* warnings */ \
 	FUNC(EMPTY_NAME, WARN) \
 	FUNC(FULL_PATHNAME, WARN) \
 	FUNC(HAS_DOT, WARN) \
 	FUNC(HAS_DOTDOT, WARN) \
 	FUNC(HAS_DOTGIT, WARN) \
+	FUNC(LARGE_PATHNAME, WARN) \
 	FUNC(NULL_SHA1, WARN) \
-	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
-	FUNC(LARGE_PATHNAME, WARN) \
+	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_FILEMODE, INFO) \
+	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(EMPTY_PACKED_REFS_FILE, INFO) \
-	FUNC(GITMODULES_PARSE, INFO) \
-	FUNC(GITIGNORE_SYMLINK, INFO) \
 	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
+	FUNC(GITIGNORE_SYMLINK, INFO) \
+	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(MAILMAP_SYMLINK, INFO) \
-	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
-	FUNC(SYMLINK_REF, INFO) \
 	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(SYMLINK_REF, INFO) \
 	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \

-- 
2.51.0

