Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822D2D59E8
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760592; cv=none; b=owtHOWo4wmed9MhST3cIE8io2AfPEbVQYi9XAqTMSqaaIi3p7LRgBMyFAB25zXKhD69LiF7hhXHt7UPcT+qNHL0K58YXmBirUsn5j/2QA0/zjRMX1CRGA4FfZBzY+SojbWsYMDAWdjGNcQ4WKogMbt6e8LVM9JRb1eQ1r5aF7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760592; c=relaxed/simple;
	bh=8pu02Pbs69YrtElU9PJNvgsE2tA96Td/IGEF0c8v3IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Az1r32ngdj/pzweDyWcyo+ab2EHeJc9obrTDs4MlUdUc+/no4PQhu0ApmgqU/0B3yCCaa+nnrsG0rbFfhX/ok3/eL9oaxYO3hYgHrt5iwIi6TTRbusNsidV4dTcwsll0U3EoUphVqdg/a45b72CZjLv0rsVsjQVy+IVTkl2N2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6KtiMiw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6KtiMiw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so47771915e9.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760588; x=1760365388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djy2wyY3fAXCCEAcu6XnkFcXVHHN28jteNj/JmHlLMw=;
        b=d6KtiMiw9DCbRUUAahTdBUhMeoAR3xOeR+vPGmOfaEzVqwaSt49ASZs6rueamh0MYI
         fOPQmxQO4wZYde+zCff39sjwIKb0RwIJkiRlq+iXF9gYO60KKbnfqGjr3ILAOPAw1zKB
         eBO9Zgj46HzUNB1u8oO8cRVE02/PIYh39CHbpQtLmuWYgoUTdQnZelmUdqCE9jDIknS9
         y0iXdV0HJS+ccpju02xISbmjiTxmMcr1gE1qSTDHSAYme8sOy/GJC22aSZXJeEiv/ipE
         5l9+A0QO7XVxrcpCd+pnS9yQYxBhgUb5RkxxCyxQnkdRqn8QkBbdRPBU6dFCb0mdewFR
         c/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760588; x=1760365388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djy2wyY3fAXCCEAcu6XnkFcXVHHN28jteNj/JmHlLMw=;
        b=anQXc4mlZzoRLmqUXX7bkEXkuqahtQMVPogxu6hZPdoov9/2+IYjMPXn1em/1yh+fd
         WxSRdaZ7Ro3vB3voUEI38v4vL7R8SBKFl+eOkvyiJlOfrDMeBihS0eNSvN0You7cUmqE
         7qcxYlQSwSkndp41OwAijGLFn1uvC4mBZpVp//RwwrbPw8+tmOUWBm8mx9ABGPj8osPU
         iJR2//9GkgNwZ+YTyfxiDNtY9TjnhpBMosRaNun7ABQA1KbSu51v3k/n8neN6uN3to2o
         +vZ6Hd4NrQkOLhGPj54VLSslJQ9xcLYYxWrEoJV6gZBGSUOq7na4E1m57LHZ8HlxBNV/
         mpfQ==
X-Gm-Message-State: AOJu0YxraxNIhy1802I2wi3oKUrDGlRfncZbj8YImVZeDRJW20S1MEjN
	6G3fnaLOqhnilLj33uXVn7+2NafGO5z1jeGLxZu5yuu+EHlo+YejaqT4+czrMP7B
X-Gm-Gg: ASbGncvWu1XS5/puMoDkArgfGCAqwGmrGHz+4ftLVytK7p6ZMZ/MVGkdoV9OzrN2Oyx
	48jdlIHoURbBofHDFNXY4fLAcdVsg2adDdDd2xcHUo9f6jpGxKhkdiDgpwekZPP2ZKn206rJTti
	6iabnsyo46nh5DdntJrLesDsPKQIlD28H/1W7n8QK1SnOKE/K85aBFuNpKoIwsuPrXV51VxUxFI
	RmakLtNmCfGQt8uhu0I30LEcdlyUXvAnkoW61qaGK6wqRnsmvaTJLWb4FWK5xUhXyIQfUUjfD7h
	UcI8tAun5QRA4Bl3fZFTQhoccAZY/IkJloWjb94EU8OCdnuPCDuUNEvVqbVeR8OJCoZbPFTAEYO
	7SjZxqjZLZ/pCob5CWLmmfp0o9aKIfDkHN+NuaSbNib166A==
X-Google-Smtp-Source: AGHT+IGWIVa5bQ14eF3Mg846/X6kFW9aVh+om5p95hotilmjmeejj4n/56Mm3hO/wKrDRbcIaTEpxg==
X-Received: by 2002:a05:600c:8188:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-46e710fe31amr83506775e9.3.1759760588295;
        Mon, 06 Oct 2025 07:23:08 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f547sm171237555e9.9.2025.10.06.07.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:23:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 06 Oct 2025 16:23:03 +0200
Subject: [PATCH v5 5/7] fsck: order 'fsck_msg_type' alphabetically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-228-reftable-introduce-consistency-checks-v5-5-f196d386214f@gmail.com>
References: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
In-Reply-To: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=8pu02Pbs69YrtElU9PJNvgsE2tA96Td/IGEF0c8v3IQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjj0MaG6jiQcKSnDX+i5HdtxLzJxZJGhRlBf
 wkHVADsKHvfcYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo49DGAAoJED7VnySO
 Rox/k1gMAKHai/bP6CGYWZE0eqYHURL81ho8dmvU1imafpLMuaBZZD++fD0eJa03Qa1GCc4jFnr
 STujQ6+DW/6EC2Q9G5yaNE2gdy0/2H1KkGyqfDjqJOePPAj4KfbExOqXQQaqPbFaTllw4hX2Spi
 B1PdDQh5nCrFclMajwhOUStMwbaLGsVcQGQ6pgCDcgYKMQa9V/ZAJ/caJ9Ik0sgP3MlKxl0Ke0T
 jTkRhKu2ut1+eP8uzWcT9rOoLhnXi0/aaR+egGQtdM1OgxTI2mrk0prd0A4UJtfRIKArEVzeSla
 92KsSvoUa4jCEP5tc4hSIGrccqhSZBeOa6V8kqzNlCYCL0wRD2eig+jro18rM2a21Vh0JNGctAa
 QK1uMaXkB/fFdhL7i5QJNGfbnFOQ1Ke4rfhs1i0GJMgo9KnKSc8oQCVyyX6Am60qB/8pgtMSRto
 pXAhUUmaOszMfLZD7UeFJM2ZBwLepzNuXk7aUSg2M3hSd7jvmC0oG2EPr6nrctKiWk5IsxMtvi4
 mM=
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

