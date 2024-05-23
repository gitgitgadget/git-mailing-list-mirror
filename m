Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43E129A8D
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499603; cv=none; b=JBn1QqufGnnjKuoANuMYGV0CEu6luUEaEF+jR3Q/2UZsnQX0EDw5bUJlWWCm42sfSYuUytMBQz5mZ7m1gb7M0nBA66LEHjIfociPvoFPU9yVRjM7vZC9mosXmLq0usjuK1uSHruJiXmFLmr6n5SaIP4Ivm7vysqMssZH5YbcjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499603; c=relaxed/simple;
	bh=PDDKKLKXhPKgAyB8WLSvpQfWsh1rhVfb3RxpnUg1cU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCDzkCg9GurhufyEpqv+3+HTLpW1jW8opfpsPKhRBtLEoHqn+B3kx0WT1kgNqEcVGjbdNWedYETLcIYN6qcxYx+arvd0zRCOYCYWDRZPFrkxFsB7k4nbaLs7JXhLx1xxNMXk1B7s/9n8M+xDcIia5PDnYZfNnhIaOkW1/MVE80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Dx1LjLSv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Dx1LjLSv"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43f984101e4so13397851cf.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499601; x=1717104401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTcbwPcZypBcoxrLy2Og5e1jrS3bI5Iptd80FyJcJwg=;
        b=Dx1LjLSvWYxEWpKubdXJlilHih4VlL/M8b+nDbE6efan0QeYyF9KCBmOHDC0S8lLzy
         eUHKwLDXQ70SaNnYL4a5IwAJcfyoP8vIDgPGdJfVmGnMdv6GXy21EmJtCtQF5KScxLPv
         UoTFK78Ngp1viKzNkWsF8AZADt95lyX14pVOWzCm2uAdF5MZTyifcUw3kvC3A80Ib2YY
         w0AWg0QHDT3kBybqARLAgHjNgNstzlSHcW0yFCRW9lT65/BNHC4vRMoUPB3I4qrTPBl6
         Fl0DYhp63ebKaIDa6bRnb5gL+2muA1VtRlR+X1XvAnx5eY0g7YFG6i9YdhjpihwTgbgd
         LJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499601; x=1717104401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTcbwPcZypBcoxrLy2Og5e1jrS3bI5Iptd80FyJcJwg=;
        b=q1ZAPNiCaOuIKHG+iZ/C6uxJwlNZQUtpK0JEPXBv7HTWw6lhd8zfTwS3QzjeiNR/Pi
         nS0crfNyLdOonbZNfo2Lj/j6BLfRiIEflRlIrl7CgZqfwSGUxNXBmuKQY7cR2JcJPkGj
         vbLldfqPvT8YJRea4QmWYtQWxBJ4QReOZqtfxwEHWqUNyXeqWgJn/SfYbfbSA8Z68kAY
         SC9ySz7yMfWcS72Qqr+vxPw8FqGVa1n0RPNwC8fw2C9eCribav1pPm/pgetvtNUQbtlo
         QM8Oa0X7FFlJJ6NZXeIFSzGNSV7/CnThB8Smuw5GpRiu5VIkJHX6zUmk7S55GbmwRMA4
         gn0A==
X-Gm-Message-State: AOJu0YzdhofJ6rFY0fmsIEDxTIMbhIHBtmgJbvH/Vuiv6i2zXHak6tO4
	UQYvuYxpd2qSwxGcg4ahoW/hHGdX/ltfHgUrG0X/BuoOQ9bnsusH/r/trHvlfx7BHbn67kEGIBP
	D
X-Google-Smtp-Source: AGHT+IFq08hCrUpA63o2PYOyPXOQB+VSzsZyB3vzEf2hnGI1pGi5ongrN/2tLl3c/Tn+3t7bobyfnA==
X-Received: by 2002:ac8:5952:0:b0:43a:88e1:43a2 with SMTP id d75a77b69052e-43fb0e49918mr3478701cf.3.1716499600942;
        Thu, 23 May 2024 14:26:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18c5b5csm519881cf.91.2024.05.23.14.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:40 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 10/24] config: introduce `git_config_double()`
Message-ID: <6c77671ae9ce063d5659ab0542d4bfa3e1303995.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

Future commits will want to parse a double-precision floating point
value from configuration, but we have no way to parse such a value prior
to this patch.

The core of the routine is implemented in git_parse_double(). Unlike
git_parse_unsigned() and git_parse_signed(), however, the function
implemented here only works on type "double", and not related types like
"float", or "long double".

This is because "float" and "long double" use different functions to
convert from ASCII strings to floating point values (strtof() and
strtold(), respectively). Likewise, there is no pointer type that can
assign to any of these values (except for "void *"), so the only way to
define this trio of functions would be with a macro expansion that is
parameterized over the floating point type and conversion function.

That is all doable, but likely to be overkill given our current needs,
which is only to parse double-precision floats.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.c |  9 +++++++++
 config.h |  7 +++++++
 parse.c  | 29 +++++++++++++++++++++++++++++
 parse.h  |  1 +
 4 files changed, 46 insertions(+)

diff --git a/config.c b/config.c
index 77a0fd2d80e..7df89f17275 100644
--- a/config.c
+++ b/config.c
@@ -1243,6 +1243,15 @@ ssize_t git_config_ssize_t(const char *name, const char *value,
 	return ret;
 }
 
+double git_config_double(const char *name, const char *value,
+			 const struct key_value_info *kvi)
+{
+	double ret;
+	if (!git_parse_double(value, &ret))
+		die_bad_number(name, value, kvi);
+	return ret;
+}
+
 static const struct fsync_component_name {
 	const char *name;
 	enum fsync_component component_bits;
diff --git a/config.h b/config.h
index f4966e37494..f5f306f373d 100644
--- a/config.h
+++ b/config.h
@@ -261,6 +261,13 @@ unsigned long git_config_ulong(const char *, const char *,
 ssize_t git_config_ssize_t(const char *, const char *,
 			   const struct key_value_info *);
 
+/**
+ * Identically to `git_config_double`, but for double-precision floating point
+ * values.
+ */
+double git_config_double(const char *, const char *,
+			 const struct key_value_info *);
+
 /**
  * Same as `git_config_bool`, except that integers are returned as-is, and
  * an `is_bool` flag is unset.
diff --git a/parse.c b/parse.c
index 42d691a0fbb..7a60a4f816c 100644
--- a/parse.c
+++ b/parse.c
@@ -125,6 +125,35 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
+int git_parse_double(const char *value, double *ret)
+{
+	char *end;
+	double val;
+	uintmax_t factor;
+
+	if (!value || !*value) {
+		errno = EINVAL;
+		return 0;
+	}
+
+	errno = 0;
+	val = strtod(value, &end);
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
index 07d2193d698..6bb9a54d9ac 100644
--- a/parse.h
+++ b/parse.h
@@ -6,6 +6,7 @@ int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
 int git_parse_int(const char *value, int *ret);
 int git_parse_int64(const char *value, int64_t *ret);
+int git_parse_double(const char *value, double *ret);
 
 /**
  * Same as `git_config_bool`, except that it returns -1 on error rather
-- 
2.45.1.175.gcf0316ad0e9

