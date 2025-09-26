Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F62874FC
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871562; cv=none; b=QRcAGPtlOcjhmIeJV+ugspggLuMaaxLCzHyGdmZgOJgXCwm+fVHdz7+Y8Z7RfuEFiiQZeTx0zZhAERgGU/WiKr7434LZGGe4ogVr/BXDnorOtekVecs4p7wsJIZ7ZK43D3LaMFigdtHeki60pQnf7ZqHTBDYzFaO31b4dNNLl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871562; c=relaxed/simple;
	bh=8pu02Pbs69YrtElU9PJNvgsE2tA96Td/IGEF0c8v3IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYv+iFRaeb2u5GfMiuLiJg9RnA7/3xWwbPdqdrBviAHabnb9krPKYEicUBp6iBxCqwMDtKZeSKB2bNP91dP0I4X7gqpsNZZp29EiG3HJFcLv6oqDG76WXK6X4wKtq9xVa6DiOIpOiK++Xuta8qMP19ajxHUH+AGXkSTRxmVpHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI9NCEcv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI9NCEcv"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so2526787a12.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871559; x=1759476359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djy2wyY3fAXCCEAcu6XnkFcXVHHN28jteNj/JmHlLMw=;
        b=gI9NCEcvrx6ZGxLIH/iIDAmomXSO9A0oMYE/4iK49gGyH5XTXDb5cF+UvH7OJ2cNZn
         cSNdPS+2kxeXTZs9aAfd/IodM0j4Iww6gcJG5wBr3n4P0iWKSJEtDnvEmxcCysnK6HWe
         ljK7cL7XnC5ErvXn7/21114ttmlI7D4VY1/XdqWT3nQeCeAQEL8gQ+44ih3S1qY4J18r
         6WLSEQWEyLs9J31igYNyOhPTWIIx2AYRLYOqxPFXYaVxjDIwde5dZ5iCjdmOUlcISHec
         HS99VL9cPRHJR8SREwYSRJ/ZiXvwTaDuo18uIUq5+U/wK7vViqA0tPu74UFXSS1/a2qb
         w79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871559; x=1759476359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djy2wyY3fAXCCEAcu6XnkFcXVHHN28jteNj/JmHlLMw=;
        b=Wc1DTyte4s3JlsEVce0NIXYXF9hGo32ca22p7H3vSYcq66xzyWankkT/rxqqLjMSHy
         EfKQYQlSU3fFfyDhXuncfBEfU8PkJ2sJOt6HvXh6bto2rWMtcQfpBo/q008/SSLEtPOx
         GLX+WqOMQRabXmEaBEGurgsLbePPTPxw5vxJHfbnGE2EmZNdiSYNNzilYwKk+c878JjT
         k/0uRYhvGeKEAv/V/YrEwr6URmZ8Ljr6TnmsDyhSQ3y/OXe79sBjo0HGUPltNtNXI4Nx
         UcZW+oWqCNDLUVveuV6DZ7QjKkU01PtfH0mFljaO5HRmLRZNim/00ubLpb4ogX4/31u/
         KG2A==
X-Gm-Message-State: AOJu0Yy9DfFNr8g9vVqD5L7p05ATZG0WI2J0ty/lcIL8mZS75o3rEKG1
	maw4s5U0Ac0rP0IU8cAa2sajFVfAaHDz5i7GEMh3zUDcf9n+alWsLCpxYrpktk+4
X-Gm-Gg: ASbGnctuioOUAzYYdFcqjV/klHat4uZJPI0Bi/PHgG+em3pBaL/6VscQmQyVTGSIFap
	Fz1LvVdaQqKv7KRRtB+g7l6nAWOkCn7/PuwWg9lT5UolmbueeYCUZz13Nqt9VZBAJA1YKo04NLT
	l2JGaEDp1XmD05I9JYq8MyhAd0OzScWssbc9c/uxfvMx4S0GmNrpfoe7XiHAvYd2/Ah5yEf+tlT
	i7i7BvE3xm2SbooAt+KH8DBLiYBZBy0tj8AYLwfK19CBW++WLkv0IHPue79W+CH1d+EAVDZash0
	c03f8wJ7Z326eKLM1EsgKbYXrWbJZJudR8zCG8z5q2zZykv9fU7WDp5uSQSUcFbXz+cLTwASCne
	/iXZ0ZEE6DekD/Yphnv23nwWN/hob
X-Google-Smtp-Source: AGHT+IFZbz0mA42AOCCI8nx3J3aoUaIMIkykv2QD1zabVtMk9nmiqgn1WR7oy4n+svjYrLFMzifBPA==
X-Received: by 2002:a05:6402:a14d:b0:634:11d7:f71e with SMTP id 4fb4d7f45d1cf-6349f9cc02amr3969611a12.8.1758871558558;
        Fri, 26 Sep 2025 00:25:58 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2fd5:3bfb:87f3:d768])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af54desm2368795a12.40.2025.09.26.00.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:25:58 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 26 Sep 2025 09:25:48 +0200
Subject: [PATCH v4 5/7] fsck: order 'fsck_msg_type' alphabetically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-228-reftable-introduce-consistency-checks-v4-5-c96fd8551c0d@gmail.com>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=8pu02Pbs69YrtElU9PJNvgsE2tA96Td/IGEF0c8v3IQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjWQABAuzujo38maAH8aEuvvAXNjVOnRATol
 2ogVqzdW0O2KYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo1kAAAAoJED7VnySO
 Rox/WuIL/jyurlSYiJt66iQlOibPNjo21KvzGC1pTwpiXdF/DupPbOwDEJp/mH+11cmxxfB2BH8
 YQ0bSu2kN3oW5ICMfE6dZ3Kw9MUT9ynkAQ6WJVn21c1Pl93VXIS4BQEaTfNDE96C2kJlQZtSdPz
 mYauh/TGH0L9jHsRohpCkPI7f3OY0U7eQ8x2FVkRsaRYdUyKdHcqblwqQ88wuaJBZ6vbipJfbPh
 oGj43m0axb7HUGT2a4jo5gDqsh1MfbOasFwGQqyX55aOr2qpKOZJbSnVkBdb+51HTx56msW3yeO
 CPHF6wnvaHgDlplIQIGWc93AaCn5QzoMc0v2NerVSx0YKAOmn145SweOydYLmG/SaSCQaJza89r
 kCcJMiVqEMZoHm9Luqq0+zeMlqHNlRyJ4DYcUrY/u4afpiabKeQBKG5IYXEoqV85sdzgWd/N+mx
 gGN892Vq4Jy1A4TzR/D8dFG4Q5nZhqlz6V+MOwOz3YRURoYjrSDdVfhejn7yf6vFKDWUU/oy4v4
 Aw=
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

