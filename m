Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F137266D
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833159; cv=none; b=BZo/kYnJr8WKAMVGIABElrStbOUCd4cpLK2c/bz9IEBcua1bWRdliBQOVw+7ktktpS0tTqUcf4qurzOQtkw8LELRwJ4BDBhG6QZKq5MuOCwFmNeRQCQdXN0nG/nA8i/u0zjuvhooXTeMXmUFduNe87TTE0bycXLGz5bAzd9v6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833159; c=relaxed/simple;
	bh=62U+nri5FQUCGefkD3j96fZlWRHc3kDNNHvRZ2xWAOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHuEO0csjS9Zh6mVDEVvM6/ZMT/wm/0xIQC4wEZWCDXtsL/2IoP8ioG+ldnYAY56fcEP2CBCX135qlkNHX2Hdh6Z31shohfWCIY6EIPXq9oFLE8HPSAdTjufzuZwQ0GaY86MbDwnsZKqKUwY+Q4nUl8Bzn2ha3jr2KhFsfP6HWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tZg1wYub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0vBSXD9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tZg1wYub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0vBSXD9"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5BA3814000F4;
	Thu,  1 Oct 2026 01:39:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 01 Oct 2026 01:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790833153;
	 x=1790919553; bh=fS6t3MBkmNxbqeTXfAh+Jwd1Ova8cm4BBKju73AxVuQ=; b=
	tZg1wYubBghdZY83NTdpd6wboJUP/C33RzlPS1bL/VQKfdxOfnbOnWAyblTpORg9
	7o3AG6z7BGA1Ko8gVSEq0nMSFV1n4nx0r0r30P0prpr/Wibph1w6mv1X0wzXjDQC
	CQXc9AytkUEnVwklQd54sa9YgtfNW86WYm6rUh8oPv+BKyHcdaUNnSgwa6u2brjr
	2LaJocepHSDi5VNGX82yL+zE4fu/CXkENmbvBAeCHkgZVwuu6zPjH6D1LzOJxcCp
	f4mnoSb9Pq0lnvAvdb055aKXP1F1rK0LH9QUeGJueAAGlrhJrO3qTaqeeZjnCdll
	3RM6IEDIQ3PsDXiLJn3fXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790833153; x=
	1790919553; bh=fS6t3MBkmNxbqeTXfAh+Jwd1Ova8cm4BBKju73AxVuQ=; b=P
	0vBSXD9m0vLtO/iMSRg/XoJN5dVAA42ZzBiptB/rlqR3d4Pir6WHRFWRU+TeUK0K
	6YWi0utqDW8Vnn6PyrMM0520rM3U/HWNhCeHtL7ax0hO3QGQl2hrX7mhkCmwvJv8
	qXpHXUc5Bx6FUHeEJMyuCjW1Hlp1t+3+xcCjcAd3hDQq1arzmpao0vlFVJZcGNO7
	zF88gi9W99X2xPUv6/kn2GohAXLMY6IiqlRoqAVF6UQid3mxLpUSZjxEX2ufksns
	hdVYKf4GEBw4WMbqENEEY4vFnvVj+HZVTW8uLnvXTZvTZWajRrhSwC/NRakr9GwV
	iDHiVTQDgKO5vzejH2nrg==
X-ME-Sender: <xms:AfK9ahy71cqEvA7cI8TZLIIL0nf4Lxy-7_Knxjp7ye612ae1q_gAPQ>
    <xme:AfK9avHgCwKQLiDiDswrOvJwA9dWiELoQ36ZwEU309ZXGYxU3p53v71sfUt1gL8Wd
    XqBqDgJR-UsIs2Zi3tpwmrSlh6dWFqDRDQDH8D2t68FCdluDRnKlng>
X-ME-Received: <xmr:AfK9alyClJROlGkDirFmI8UxuQzMQMPu4u83k-xbJLdKWcCWQT0-AjLtIeqmC8e3prTs9Q>
X-ME-Proxy-Cause: dmFkZTG0u7o+ksaeHQI+bcVRTOo6KrX3Faeon9Sz/aWNKAGGO72QL80JZ6aJgQvzrGZ3hu
    wwZY/LOnOyrSsS2xNVTYVQR+RUBiGpybY33SKWuVX4WQbF35/yCUu6bxPUK25I/lUOBMF1
    WNcWwinBZmXg7U1lN84mlQhzIBzyDULjT/AEKJlX1KxkmYSUIIZ5AF2IlcTCsr7ocSJ+wb
    E9jlLGgpv5WK73E7aOx9nl190NJEcreVJvgz7oWSD3AkmP9MgWe0oSP8PD8Gs8L18kG0fN
    bmRfN0PTg/92z9JCjtQu8TuCv/LioVDZeBFvTxOCCjNmitDxx7qkaR/q37ikj41IPDX7iX
    S1ERj/puoxIJuvkshTW6IwN4dHF8LUHvA77HipZ8X85Z0BLnNAjtRtThgCgSa4o5hW/d0t
    Zg3E/EiT7wfA9Z81+ep8IgAhT1BUklKuq4niUWooMwRj+gLyTGPV7bvIr+mZUeV6Et4bti
    7Eb5oFAidmqt0FQESY4btdLRL6Yr3ix2ynKtgD66752QECjIWxdyZE9lHr+jRZ/Ne6G1G1
    0qDmESSDonafnVu4rmKiY6v7znAC2Y74QHYRiBy37iDl+i9l2e9KEFngCsEW+RrCCuW+np
    VI8TPbDt7Y+LwhyVjjxmNfKuZJEH6y3EYlqHvSglX4BI1MTa12PhxsmszIOg
X-ME-Proxy: <xmx:AfK9agt3wPPJy_otcFrf4K93M-rmpXyOVHPzeA-sHvlJBZBV8RWZbA>
    <xmx:AfK9ai2l9YO1Bc_Z7B83iotsrDhalDaswj8SbTTouOoIVVdnhxH0lA>
    <xmx:AfK9ar-opkiYSI_ntNiTWDzPgtbKXPFMa22zdMbVowC-vVZtBVvgXw>
    <xmx:AfK9ajMGuH8CBdLNLvKhI0cO4prsKyZ5Qe8BwZhEjOCamkljCyr4NQ>
    <xmx:AfK9arJTuNrEjRSGjyLHfQn4wyi-pdG3v5bwwxUUj5COwwGG4NOj1MTS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 01:39:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be0e470e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 05:39:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 01 Oct 2026 07:39:00 +0200
Subject: [PATCH v2 1/3] date: add helpers to convert between "+HHMM"
 timezones and minutes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-pks-reftables-fix-timezone-format-v2-1-a4fd1f7cd21a@pks.im>
References: <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
In-Reply-To: <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
To: git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The timezones that we store in commits as part of the identity
information are encoded in "[+-]HHMM", for example "-0700" for UTC-7.
Internally we typically pass around this timezone either as string or as
a parsed integer (-700).

Some sites want to convert between this format and minutes or vice
versa, and that conversion is performed ad-hoc. We're about to introduce
another site though that wants to have access to this logic, and having
it cluttered across our codebase is a bit awkward.

Introduce two new helpers `tz_to_minutes()` and `minutes_to_tz()` that
perform the conversion for us and convert call sites to use them.

Note that we used to perform a dance in `gm_time_t()` where we first
convert `tz` into a positive value, then calculate the minutes, and
finally turn the minutes into a negative value again. This dance is
performed because it is implementation-defined in C89 whether the
division on negative values truncates towards zero or not [1]:

  If either operand is negative, whether the result of the / operator is
  the largest integer less than the algebraic quotient or the smallest
  integer greater than the algebraic quotient is implementation-defined,
  as is the sign of the result of the % operator.

So under C89, `-130 / 100` could legitimately result in -1 or -2, and
`-130 % 100` could result in either -30 or 70. For us though, the result
that we want is the first one (-1 and -30), which is called truncation
toward zero.

This part of the C language has changed in C99, where this edge case is
now well-defined to always truncate towards zero [2]:

  When integers are divided, the result of the / operator is the
  algebraic quotient with any fractional part discarded.90) If the
  quotient a/b is representable, the expression (a/b)*b + a%b shall
  equal a.

  90) This is often called ''truncation toward zero''.

So in theory it's unlikely that we still need this logic. In practice
though it feels safer to just retain it as we don't require a fully
C99-compliant compiler in Git.

[1]: https://port70.net/~nsz/c/c89/c89-draft.html#3.3.5
[2]: https://port70.net/~nsz/c/c99/n1256.html#6.5.5p6

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c  |  3 ++-
 date.c   | 25 +++++++++++++++++--------
 date.h   |  9 +++++++++
 strbuf.c |  3 +--
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index f00b7ba4d3..367271b8ac 100644
--- a/apply.c
+++ b/apply.c
@@ -14,6 +14,7 @@
 #include "abspath.h"
 #include "base85.h"
 #include "config.h"
+#include "date.h"
 #include "odb.h"
 #include "delta.h"
 #include "diff.h"
@@ -851,7 +852,7 @@ static int has_epoch_timestamp(const char *nameline)
 	if (*colon == ':')
 		zoneoffset = zoneoffset * 60 + strtol(colon + 1, NULL, 10);
 	else
-		zoneoffset = (zoneoffset / 100) * 60 + (zoneoffset % 100);
+		zoneoffset = tz_to_minutes(zoneoffset);
 	if (timestamp[m[3].rm_so] == '-')
 		zoneoffset = -zoneoffset;
 
diff --git a/date.c b/date.c
index 014065b419..c50f45d310 100644
--- a/date.c
+++ b/date.c
@@ -45,13 +45,23 @@ static const char *weekday_names[] = {
 	"Sundays", "Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays"
 };
 
-static time_t gm_time_t(timestamp_t time, int tz)
+int tz_to_minutes(int tz)
 {
-	int minutes;
+	int minutes = tz < 0 ? -tz : tz;
+	minutes = (minutes / 100) * 60 + (minutes % 100);
+	return tz < 0 ? -minutes : minutes;
+}
 
-	minutes = tz < 0 ? -tz : tz;
-	minutes = (minutes / 100)*60 + (minutes % 100);
-	minutes = tz < 0 ? -minutes : minutes;
+int minutes_to_tz(int minutes)
+{
+	int tz = minutes < 0 ? -minutes : minutes;
+	tz = (tz / 60) * 100 + (tz % 60);
+	return minutes < 0 ? -tz : tz;
+}
+
+static time_t gm_time_t(timestamp_t time, int tz)
+{
+	int minutes = tz_to_minutes(tz);
 
 	if (minutes > 0) {
 		if (unsigned_add_overflows(time, minutes * 60))
@@ -103,8 +113,7 @@ static int local_time_tzoffset(time_t t, struct tm *tm)
 		offset = t_local - t;
 	}
 	offset /= 60; /* in minutes */
-	offset = (offset % 60) + ((offset / 60) * 100);
-	return offset * eastwest;
+	return minutes_to_tz(offset)  * eastwest;
 }
 
 /*
@@ -862,7 +871,7 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
 	ofs = strtol(date, &end, 10);
 	if ((*end != '\0' && (*end != '\n')) || end != date + 4)
 		return -1;
-	ofs = (ofs / 100) * 60 + (ofs % 100);
+	ofs = tz_to_minutes(ofs);
 	if (date[-1] == '-')
 		ofs = -ofs;
 	*timestamp = stamp;
diff --git a/date.h b/date.h
index 0747864fd7..816df5b833 100644
--- a/date.h
+++ b/date.h
@@ -70,4 +70,13 @@ void datestamp(struct strbuf *out);
 timestamp_t approxidate_careful(const char *, int *);
 int date_overflows(timestamp_t date);
 time_t tm_to_time_t(const struct tm *tm);
+
+/**
+ * Convert between the "[+-]HHMM" timezone format and minutes. This format is
+ * used for example as part of commit headers and reflogs. For example, the
+ * timezone -0100 is converted to -60 minutes.
+ */
+int tz_to_minutes(int tz);
+int minutes_to_tz(int minutes);
+
 #endif
diff --git a/strbuf.c b/strbuf.c
index 44955669e8..c3baa47b3f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1023,8 +1023,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 		else if (skip_prefix(fmt, "s", &fmt))
 			strbuf_addf(&munged_fmt, "%"PRItime,
 				    (timestamp_t)tm_to_time_t(tm) -
-				    3600 * (tz_offset / 100) -
-				    60 * (tz_offset % 100));
+				    60 * tz_to_minutes(tz_offset));
 		else if (skip_prefix(fmt, "z", &fmt))
 			strbuf_addf(&munged_fmt, "%+05d", tz_offset);
 		else if (suppress_tz_name && skip_prefix(fmt, "Z", &fmt))

-- 
2.56.0.353.g0856645cf6.dirty

