Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB415E5BA
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877813; cv=none; b=tYKrzWDJLXkKoJ/FunzSuythQaFQ6iGAL3HyjsszIL/3u7kd9gw2050TmfKLFVXLQJSM87c1lslRMnOfbTN46eN23rikV6KrIAgefnZgwB3SR6CMkuBw8tqxgckJmLDoeePUNKzsoMHyj++ijG6z/Y6EfUdRFqdDF7xpSuHL9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877813; c=relaxed/simple;
	bh=R9C9JOqxtsAXJmX1E1KNE9t9idwSw8TxOfDQjFbVCy0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u1KFM6+XbL7CsfennZyWikGx87kCf+gscxRPIyAym1/u3AIXc1p1tkBmqwhDRWhC2MR+f+neJ17VTFaXWlP2Bm/JUjFic6VrgItqrunwp2LPvC411ViXtkfrAs/WE/25cN+av9gCMqSOGDIpSqmeFTgkFQmXzhgNv4lhHQgrLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwNQLo6r; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwNQLo6r"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4281faefea9so61782975e9.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722877810; x=1723482610; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frlPs7B5IIEUAoWJSbJI83ThdVbBlcNMBDICca+av6w=;
        b=EwNQLo6rRJs0AQLkgF06gc0yah7Oa1y3UtZJXVPbuTqWKlZoij40h9Ky08r62sfsUd
         JWiDROKOnsFvqJ2jgPZBKlLwZjKx7ORO1licLM5ZR8UsOIvs4hulqC5qCD1ttW+q363U
         6ao4brT/fFQJliG6H26Mmusj0iYDuoi7BO0Ay48bm8ztAe5eNJS522m3RI7kxtv+Sjjy
         O/hjb0Na96p6ZX8OMN14L2w/cNXXUWeNbeNOYNC7ttv6T2Ca/DHdmEwZIAgdR7U3FqL8
         pyHHwJZMKhHmWNO1XREid3UaAQyVmvcCLkzydfQ71cFqrSm0Lq/V6cKa4a9JemxM03zL
         0BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877810; x=1723482610;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frlPs7B5IIEUAoWJSbJI83ThdVbBlcNMBDICca+av6w=;
        b=bfcCbZocZ5tYyAxoS5K9III7R1bvJzlJm7UJ+DJ6f7Eu+jSI3T96p/2TBctel/rYiR
         CC15ZbbOcQSQLXcyElMkeW+gj3FJ/53tGWGs9A+A2V1ti6WTCUervGR0Wd4JxK1xo0SZ
         a720CjyHLzRhY2pmCcxZuCklXboXzbgGH8peyY1sXWKXI9E14oUyEhbxM+6b9PkwP6gQ
         GH34Qw/PFJ/WvZMVikzoIrtTWX3I0JSl1dyW3ZWZBHVYOfS1lZZ3ETCuEAmJ4YhhDplf
         rxnO5xvV8sJMvPjkQ1GLKdqhcRrO2dLioIvyb2YocbMfUZsiT21IzOYThucIRc/EzPWJ
         yvxw==
X-Gm-Message-State: AOJu0YzccRnP/TY4e6+eS6kB5a2SYfTio1ZTjrWrT0kkorFPmC/HwDch
	7+mDBoICxDDJmalO8dnSiMRoAJiUoXc8rYZUQG55Mr9SGSbExZoh4wY8vA==
X-Google-Smtp-Source: AGHT+IGmvtADSn+98ANfnQ8Pr/JFzkP2rQLNdJbMgE+h2mF8D89nE2rD1PA2FftI7A2ObWbp1hDi3g==
X-Received: by 2002:a05:600c:1f92:b0:426:6f62:3bc1 with SMTP id 5b1f17b1804b1-428e6af23f4mr69669025e9.5.1722877809956;
        Mon, 05 Aug 2024 10:10:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9c9fdsm147168855e9.41.2024.08.05.10.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:10:09 -0700 (PDT)
Message-Id: <4dbd0bec40a0f9fd715e07a56bc6f12c4b29a83c.1722877808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.v3.git.git.1722877808.gitgitgadget@gmail.com>
References: <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
	<pull.1756.v3.git.git.1722877808.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Aug 2024 17:10:07 +0000
Subject: [PATCH v3 1/2] set errno=0 before strtoX calls
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
    Eric Sunshine <sunshine@sunshineco.com>,
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

