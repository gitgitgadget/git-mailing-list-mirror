Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC405A955
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571859; cv=none; b=gAtxJstDwX8OgNtxmg0xvMAq2sQNQ4R/oOMrnL6AuRTbPaL7aOfpt+tVOabBGK280PI5gcMFS5OcF6FLZahNTWDmT2iRawdWVS3MfmEXrQ0aAPDmoq1KVQ2XfCfCUnvLry8RcFp4Rt1YvJxf69X9WjKBgDJN5A7XDPsRnB0H13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571859; c=relaxed/simple;
	bh=R9C9JOqxtsAXJmX1E1KNE9t9idwSw8TxOfDQjFbVCy0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LE3PLRt4/ppnYw60vMIawI+uGW7yu3Bcw/SYvYP/zsL/4Y0yV0Ria5AVXDNM7d0wNBRovimHMwMWTs9XtE4lMlTdr35TC2a5stfl+/A39I7YL1Vph2I43uws/S70E7LB0ekL+wei7+0204AMcyRAb6XZLNjdiXzay+oa7jJlDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzG3H1wI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzG3H1wI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428163f7635so50063165e9.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 21:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571856; x=1723176656; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frlPs7B5IIEUAoWJSbJI83ThdVbBlcNMBDICca+av6w=;
        b=dzG3H1wI0yl8O4tqzwnRYoH6s+BcqES8KmbLX2KmGEOk9XiLjpWc8Z78KfOp9jQtcy
         KTNdMyPv0OZIPje8zXfn1dXyvId0e6nkpw/MGu9pyz8MZdshwr28TiHhCDtDC04GasTe
         CV1wbM1g6KYwJ8l6lbgCuubPB1ipckkM39l67aToYhBe6wg20WZXzhhwShzJZOEBUCUn
         4Ys29SrapNhVpM/cSm/qfxNINYoH7NDpzkW+ECOAOOdvzEF9QhJ0S+MycR4HVQRm4FUR
         62r4ABYVYMOTBHKF6zrYSx7Kq8IOkDLbWUDbl+d5NZxrJ3oX3TKa0ucignNAr0BfEvrG
         r/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571856; x=1723176656;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frlPs7B5IIEUAoWJSbJI83ThdVbBlcNMBDICca+av6w=;
        b=SIICXip596A9wGcsHojLLvNJkw8sstju7xPvRIz7iyU/pbVOZCRrbvqMD5fBnX329h
         E6mU4ic1h/0r0QN6U0Nrnx3M/gAZVD7G66IATMWBG4A1bx02cg2JfdJQhcMQCmsoZRRH
         lnQS2k6TRxTkaJm4DmZnlAbZK2s7m602DchkFm1rYaX5QVC9Ki8iTTx9MDHKa+rd0Fe4
         RJcEUylTwpBZmFIprYturhtVuchGku4wGsFQzJlSPD0vLVacZISJMl67Cdt1N5FPlz9P
         2gpBncRxYFUZGL7tV2qlnXcCg9KpQS93zIylFCdW3p+Kd+DxwNe6ZyJBDAgzReaZL0Fo
         y9eQ==
X-Gm-Message-State: AOJu0Yx7B7MNJgrvnhQSD31hl3+V+oyqOwmr3cGTk53Vh//xLVX6veLm
	O/6O+SEpGDA4FFOpO1HZEbVmMdCo0pNVF+ueuzDxZCnlPE0kRmNU/JyZ0g==
X-Google-Smtp-Source: AGHT+IFQjJqspyls547okSNfVVjXf0xl8vp1iTkXpZre0UeCBd5sVAppEL0dXC+Eb8Je7VtpYglGQw==
X-Received: by 2002:a05:600c:5489:b0:426:5983:ed0a with SMTP id 5b1f17b1804b1-428e6b78e24mr11641935e9.30.1722571855465;
        Thu, 01 Aug 2024 21:10:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428ea7dc80asm5990705e9.37.2024.08.01.21.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:10:55 -0700 (PDT)
Message-Id: <4dbd0bec40a0f9fd715e07a56bc6f12c4b29a83c.1722571853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 04:10:51 +0000
Subject: [PATCH 1/3] set errno=0 before strtoX calls
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

To detect conversion failure after calls to functions like `strtod`, one
can check `errno == ERANGE`. These functions are not guaranteed to set
`errno` to `0` on successful conversion, however. Manual manipulation of
`errno` can likely be avoided by checking that the output pointer
differs from the input pointer, but that's not how other locations, such
as parse.c:139, handle this issue; they set errno to 0 prior to
executing the function.

For every place I could find a strtoX function with an ERANGE check
following it, set `errno = 0;` prior to executing the conversion
function.

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
 builtin/get-tar-commit-id.c | 1 +
 ref-filter.c                | 1 +
 t/helper/test-json-writer.c | 2 ++
 t/helper/test-trace2.c      | 1 +
 4 files changed, 5 insertions(+)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 66a7389f9f4..7195a072edc 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -35,6 +35,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv UNUSED, const char *prefix
 	if (header->typeflag[0] != TYPEFLAG_GLOBAL_HEADER)
 		return 1;
 
+	errno = 0;
 	len = strtol(content, &end, 10);
 	if (errno == ERANGE || end == content || len < 0)
 		return 1;
diff --git a/ref-filter.c b/ref-filter.c
index 8c5e673fc0a..54880a2497a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1628,6 +1628,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	timestamp = parse_timestamp(eoemail + 2, &zone, 10);
 	if (timestamp == TIME_MAX)
 		goto bad;
+	errno = 0;
 	tz = strtol(zone, NULL, 10);
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
 		goto bad;
diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
index ed52eb76bfc..a288069b04c 100644
--- a/t/helper/test-json-writer.c
+++ b/t/helper/test-json-writer.c
@@ -415,6 +415,7 @@ static void get_i(struct line *line, intmax_t *s_in)
 
 	get_s(line, &s);
 
+	errno = 0;
 	*s_in = strtol(s, &endptr, 10);
 	if (*endptr || errno == ERANGE)
 		die("line[%d]: invalid integer value", line->nr);
@@ -427,6 +428,7 @@ static void get_d(struct line *line, double *s_in)
 
 	get_s(line, &s);
 
+	errno = 0;
 	*s_in = strtod(s, &endptr);
 	if (*endptr || errno == ERANGE)
 		die("line[%d]: invalid float value", line->nr);
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index cd955ec63e9..c588c273ce7 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -26,6 +26,7 @@ static int get_i(int *p_value, const char *data)
 	if (!data || !*data)
 		return MyError;
 
+	errno = 0;
 	*p_value = strtol(data, &endptr, 10);
 	if (*endptr || errno == ERANGE)
 		return MyError;
-- 
gitgitgadget

