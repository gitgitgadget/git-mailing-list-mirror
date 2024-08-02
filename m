Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61B4D8D1
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632293; cv=none; b=lRDBrqRr7X8ScgcFApEO+Rrn9TevZxta9jJgn/MOTFbmNafC9ZDZkkqBIYGScagYHxozjIyc6g0l+KC2VwFcqGt49qN8yBi6mHn70NsDLyvQMv/ZJ45JlR+9YE4ZX3d20NriAWtCAmra14Rg982UtA2hBDmGqLcbQNgLoPzHtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632293; c=relaxed/simple;
	bh=R9C9JOqxtsAXJmX1E1KNE9t9idwSw8TxOfDQjFbVCy0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mg6FQ903SkgG2vKKgli1aOC/Xm0tpbkVxXYBnU3o2cyn3Vtc7A0Ot3qDYSY6hlnd5aa8N6b5+EiRT++BlciDGP+wr8CP46LbmfMSsqG22bV9LMArsuRQOLxmledknnF1WoeqvYKucGuznlUx5RL+Qf7WHB2DOEeTTH2coy70LiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd9df2Xp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd9df2Xp"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368663d7f80so4314990f8f.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722632290; x=1723237090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frlPs7B5IIEUAoWJSbJI83ThdVbBlcNMBDICca+av6w=;
        b=Yd9df2XpON7csbD4TBXo/Uuifes6C6GDBIuFKXLRR7FEKwbnFEyDrUadLMwsa/wg1M
         v31GESXpG46Meg+Ai+w1rzzqVLtquLx92IZJamFbJ65w6OgQjTKo3ZbTuLakpM4fPt6B
         Dx/BbOwljJGBCOByw4jyXeBzyyt/hj+6RdalgS38mgzZMu58lUycOKQntLUv9N0ILLOE
         dqP2PSJkMqASeGs4PBuP02FDBFo2DBu1Hgs5JFMe3I7Ag1omwRFsNWorGRKJj5YNCBJM
         i2c9PHr+7Xg9IaiEFA0ochYx7uBHaBVRlEHXxLsvHUl1YhmkKusPp8HAC8q3gP/NtTSB
         08Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632290; x=1723237090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frlPs7B5IIEUAoWJSbJI83ThdVbBlcNMBDICca+av6w=;
        b=slXxmL48YlBPQrPSExpC3CcVW6HMbTlgwrGecb0aLwt/Q0bzRNz+tBjj+PmRpi4d85
         l0CXp1oEN+MMyThWg4O5qnayGk3EjbjnNhaTpG/fV8QhsFDOzAar0jyrlHVIMWBQYtGH
         gUz9yih/xU+DMb8JSisAK7SHU9LH56sS3LpvFMcpYUuBuUw8Pa75Mlic4hoDwE7sg32U
         JeFtRC1QTkpqRYt6GdRw+22ISk6wtY5d7SYqJeGkhPndP0B8+fsDDGZ8DC+aovMzHLjv
         uXNjRtXYXfwlYebfww4Y4XpM7LRP4/Vbw3O3Zp0ZQNhqt7xvobBrn2hKe2sQmwqQmE8G
         PrPg==
X-Gm-Message-State: AOJu0Yx+5Hqhzpg0zJUkLqDIWRO4Tn3DqW5RN8q0t1o4cnC97aBOZrh2
	P80QKrIVLKTGeWn4DR3/88vcJHXAVe9AsdsHvRVPKbsd7JGOiFDlaEQYVw==
X-Google-Smtp-Source: AGHT+IGKPpfC+DVjWtzF+dPu0HNGP2cTo+7X8SFy6PlIKaOESXPm1lHgdhYkeYhriBxlp7EwHmU3FA==
X-Received: by 2002:a05:6000:1e97:b0:368:74c0:6721 with SMTP id ffacd0b85a97d-36bbc14a6edmr3037470f8f.38.1722632289785;
        Fri, 02 Aug 2024 13:58:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06d03fsm2744406f8f.91.2024.08.02.13.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 13:58:09 -0700 (PDT)
Message-Id: <4dbd0bec40a0f9fd715e07a56bc6f12c4b29a83c.1722632287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 20:58:05 +0000
Subject: [PATCH v2 1/3] set errno=0 before strtoX calls
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Kyle Lippincott <spectral@google.com>,
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

