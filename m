Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499D1494B7
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318153; cv=none; b=TM9KilQDm4PZ4QMKXAEv1Ugi3QvV/gjqBrVZ/RKmriFfUvOc6VlJo1pS1pMwMa90B7aF8i7pYrvjrTVpyJjXMAS6bs0UB7Bz/dsbeCeVCNx1j2ETPpeiygFOddTs3Es7TKcYTRjsBnF09+nwN6lbdLFqGlWaOw2hUeA1tHu3uUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318153; c=relaxed/simple;
	bh=8hHu9KwFLQ7vz7SK56W3iSbAgdPyyqvkExomSPkkEBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbIB+Nxg+vb73QX8jgnNCbxD3nJIqj9maxNZXolQvXv2y+csmf3ypWl7PxlgASZcqwHwQbj4Cur0MMyI8yqCyMTFI66eJr0PQbvWS/SHXMsVI8lC/1Yz6R2htm1SNxEyk56RZO4vAbSe462elTgCa8ipJRBYZ6P0Q85LlpZwc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Y+3p9uaO; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Y+3p9uaO"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23f0d54c5ffso2484227fac.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318151; x=1716922951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUPYn6RxoH8N1CxZ5+akeynFHJMEMPuogtfmSZQvq2U=;
        b=Y+3p9uaOJ/C2THwHgGB2UlmHcAu6CQgrMH19awaONCuyG67bNTx61eqQswhPW6PyNg
         imlTzu9aO4YFBbnF7qH/3FdnsbP8vW2+XTrV+jQufhZaJ4BqwKQQ5FyLYwJXZZSoeXQW
         CGHJt8uVphaxby7Aw7nPtqB8igZJq8owGwuoDKzBoSaCSdAFDC2TPkh2p5WhYoTDm+Hi
         BkkeaMlmAXglMKsfFNELkJFDn2TBOxPN6HgH/oS/GrfuRs4Ir4tTpGAMheBzTkrZefQj
         LM9cHGfkLQ2/gl/LIQRm0pbsk+/oAXTjSKBd6JZwT5tNSdVMXxWpU0OZ6VdKXrSewtzE
         980Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318151; x=1716922951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUPYn6RxoH8N1CxZ5+akeynFHJMEMPuogtfmSZQvq2U=;
        b=C1VJKJKwvM0aEAaJ4xu1If3e86bb3qdj/0ht0fJj9SQFYLF50Ijy9OmAUiStTM1w0p
         mFDesrYbL3pupqVTIO8kJPKVB/o036REQ9xkUbSENryqnam+c3goApo/G5KPiV08vPBD
         e7rWYSV0sxqkPNMTfE0cpGr1cOwryVnjYsUtB7ZOP6Eo1Lh2NFH7jf2x11uK2anm4wOz
         toAQo8oWXmvTB3nK5ScXtSmiXhvKz9VE4Nw6VaadJJHZk+wcAaS7TyjN6kwyJAPc81Ax
         bewZtSIY0dzDbUoTh+a+QNz5QaEssRGr1kVs0G8UrqL5yHfG35dTbL9RdRxWv26fB7rV
         3qhg==
X-Gm-Message-State: AOJu0Ywy/CR4+fe8A8GaSoMqqS6odlnszCPQUDVOtRFZ3QZtrSqpFHkF
	+Z1oknhFyNlQuMaj5WGv/zuuEvzWmjLMMAq/KmKwykAT51uFXSjOO8F0FuhgE3RIEE0ZOtP0Ya+
	b
X-Google-Smtp-Source: AGHT+IHO4ISwX7n3blXsLdP1YVlwvKeDpwEN8l9ktJLJT6iCa52WEOhgBeWf4o40J6wpb6bC2ZnCfg==
X-Received: by 2002:a05:6870:e40f:b0:221:bf34:b15f with SMTP id 586e51a60fabf-24c68b2732bmr10923fac.25.1716318150822;
        Tue, 21 May 2024 12:02:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6aa10d89780sm25894896d6.94.2024.05.21.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:30 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/30] config: introduce git_config_float()
Message-ID: <3070135eb4b9bd16117e82f1817c112c56a24b55.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

Future commits will want to parse a floating point value from
configuration, but we have no way to parse such a value prior to this
patch.

The core of the routine is implemented in git_parse_float(). Unlike
git_parse_unsigned() and git_parse_signed(), however, the function
implemented here only works on type "float", and not related types like
"double", or "long double".

This is because "double" and "long double" use different functions to
convert from ASCII strings to floating point values (strtod() and
strtold(), respectively). Likewise, there is no pointer type that can
assign to any of these values (except for "void *"), so the only way to
define this trio of functions would be with a macro expansion that is
parameterized over the floating point type and conversion function.

That is all doable, but likely to be overkill given our current needs,
which is only to parse floats.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.c |  9 +++++++++
 config.h |  6 ++++++
 parse.c  | 29 +++++++++++++++++++++++++++++
 parse.h  |  1 +
 4 files changed, 45 insertions(+)

diff --git a/config.c b/config.c
index 77a0fd2d80e..ee681fda34b 100644
--- a/config.c
+++ b/config.c
@@ -1243,6 +1243,15 @@ ssize_t git_config_ssize_t(const char *name, const char *value,
 	return ret;
 }
 
+float git_config_float(const char *name, const char *value,
+		       const struct key_value_info *kvi)
+{
+	float ret;
+	if (!git_parse_float(value, &ret))
+		die_bad_number(name, value, kvi);
+	return ret;
+}
+
 static const struct fsync_component_name {
 	const char *name;
 	enum fsync_component component_bits;
diff --git a/config.h b/config.h
index f4966e37494..b0d1baba95a 100644
--- a/config.h
+++ b/config.h
@@ -261,6 +261,12 @@ unsigned long git_config_ulong(const char *, const char *,
 ssize_t git_config_ssize_t(const char *, const char *,
 			   const struct key_value_info *);
 
+/**
+ * Identical to `git_config_int`, but for floating point values.
+ */
+float git_config_float(const char *, const char *,
+		       const struct key_value_info *);
+
 /**
  * Same as `git_config_bool`, except that integers are returned as-is, and
  * an `is_bool` flag is unset.
diff --git a/parse.c b/parse.c
index 42d691a0fbb..a5967e80910 100644
--- a/parse.c
+++ b/parse.c
@@ -125,6 +125,35 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
+int git_parse_float(const char *value, float *ret)
+{
+	char *end;
+	float val;
+	uintmax_t factor;
+
+	if (!value || !*value) {
+		errno = EINVAL;
+		return 0;
+	}
+
+	errno = 0;
+	val = strtof(value, &end);
+	if (errno == ERANGE)
+		return 0;
+	if (end == value) {
+		errno = EINVAL;
+		return 0;
+	}
+	factor = get_unit_factor(end);
+	if (!factor) {
+		errno = EINVAL;
+		return 0;
+	}
+	val *= factor;
+	*ret = val;
+	return 1;
+}
+
 int git_parse_maybe_bool_text(const char *value)
 {
 	if (!value)
diff --git a/parse.h b/parse.h
index 07d2193d698..7df82c5f5b8 100644
--- a/parse.h
+++ b/parse.h
@@ -6,6 +6,7 @@ int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
 int git_parse_int(const char *value, int *ret);
 int git_parse_int64(const char *value, int64_t *ret);
+int git_parse_float(const char *value, float *ret);
 
 /**
  * Same as `git_config_bool`, except that it returns -1 on error rather
-- 
2.45.1.175.gbea44add9db

