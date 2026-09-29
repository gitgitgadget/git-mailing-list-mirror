Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C21B4F0A
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675814; cv=none; b=eR1ofYc4EejyBlnkIm7L58OnXDriTQXpMPLwUFCzgmu3Ttcu0rvPkVVaDlrwHWcjMHRDA6r6ISmx68kELfGR2oH8pbAFIkw3nWWad2m1SVzpqFY9vVUyD2BDf0m9xYqon/7LMXXSHlPgxHaoxsyWo+kiV7qnVBKnVSmMdawHJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675814; c=relaxed/simple;
	bh=STSr/mEVsciBuzELjJ4dmtHQrZduzKWQN+PhgGMR8Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjDiYVId4WSvyvcPnZfb5MUUfDDoECJTvUlJgVZQDUww5F2lor/AezSSXH9LA0+ScbZ4Sm6/tW6Hs0tKecOwIMLyxyqxkMM55qVDDdFrSfyD9ixhLaD/Q0MAMuJuri4wCd+QUtPOisJ7Anjuk9N49+/1UO9oGJdnYoFLaxIldc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LUQWkTSX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wJR9u3Z/; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LUQWkTSX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wJR9u3Z/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C58D17A0088;
	Tue, 29 Sep 2026 05:56:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Sep 2026 05:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790675811;
	 x=1790762211; bh=SyOD1TpsYPcPLFTxINLcGGmGYwaLDInNfwflFR+25H0=; b=
	LUQWkTSXbwTB/BR/NVh82KLn8edDYD5RvmAhp2jrwBVyst5/YFO1YDeSacehxrM6
	vpt1s3JqW/wOOJjnlcmOnAmV6n0w2NJXairWRLEMYs8bdHOcR/gXKpQ59D2vJOwV
	tF8o/istrjTt5bRv3NiskTXn++OpmswllijTT6pgilGRplgxtxfasVBzbDIY/7co
	7lWGCRAW9PXw9+q8uNouiUi8haKb/NP9rt0Fd0Sm+TSWYfYsXK5o2+jLF0UnxY0g
	sSAut8q2jilV+IsSYlNBqcb+fLnxIOf0PUnaIXUKADlHVc20FLjvXmtzpixHa4U4
	kn6EagcIy81a3rlyBvHpOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790675811; x=
	1790762211; bh=SyOD1TpsYPcPLFTxINLcGGmGYwaLDInNfwflFR+25H0=; b=w
	JR9u3Z/Le4qRqNXDkO2VS60KJSJmxd9N0sYZr8bfrt/vefs0KYDPpuxQdd5BsHBA
	votcT+zlJjP8sDj4RQMRU5Lnr7UnBg65nqd7VaPvNWMGyLNMHqsJlgm5XiiirABC
	TTKch0DZuA0s2wqmV34JRa1NQzjD/pbB+PgMROT09MGeVgZW7t34qrIt4DSV6avd
	pJEpTJk79Gvcak5hkk5SvxMXod5wZRNvRsiSIYXwygsyjxk/aSF9CnsbzfoRf0d2
	hKSHgnwwCumCpwNEfibmkOMshjuWp5sqK+XHBa294L6dmfpio1H9XISwOdD+V/JK
	wIKwJBxfMtCh2yrqGhJ8w==
X-ME-Sender: <xms:Y4u7asec3U-Yxwdq1eTk1SE9ttQ8cPpAfjaSXvW8o_4yuPNXgc1V4g>
    <xme:Y4u7al8OdR693LQAJ0HxLlYnA_8Cvc8xIR2b-bmcgqetQ6cNLuD8zPrytQ7tj5AMF
    _GQoGDciV4iVNSb5FzhTc5wYWktbOhpT-RO7eyjZnZvo0bjf9aRaIU>
X-ME-Received: <xmr:Y4u7agn0tS7fSFK9yzZ2Prl7u-B6P3FboBS-VPTi51zn4CN_rjui2Q>
X-ME-Proxy-Cause: dmFkZTF0vBBr3ykEk1iy4ExF83uKT1lBhMpULRFcY6aI0bgKBqITWQaZp2ewmqaObRxiwy
    DY2TxGd+h6JoNTJQlzCSZsGTj64ePm2IUv6Uh4t3qNoYsw0dAjHZQv09arOokoIVtRUstF
    o8vfrKCwDSsjKbhS5HqbUexE4U8cgTXo6qoZAjOzjveHV+YpKWC5TJD8pv9duT+hE4a8UM
    6C6hdBcikjVFv1GuwrJt1hQyHbgAjwj6iF2zhiMy8k9eJ4edXIFB8hqx7tj8cc+n/c0th/
    cfngCcluUXBmcug5mto26cok/g0Lmxz0Pvz/10cPcjOH8cKxu/m6lHIseyK/dR/qMz3uVr
    gi8e8N32aP4BbHZCPtEoAD/p/K6F4Lsxz6ImyG3jgmL8m/aZMPa1m1fugUBBoAjOPhVk6I
    6VshlkTF6EaghTVK9maqaHtp8+gsCA++qUZvEJ8HVvoZJ7CbkUUvp8VmPwZoCETQ04+2IS
    R/4s6KKmOMRJ7fcCVmYJ0UXSbLwXb+E1w2mxCMKjhLP5ahz2wdpN7wRtBd4GSMC/C2BV06
    ixq0z496TF63FvPSkHwiVxVat0ryKT4m/bouFGaq/FX9opTT6zDod1pqGiDIIU9k+1AYbt
    W4vn4RFVYaJ8i3FXdwzU6lP3FA2stP6lIETBcP0FOGbQF5bPWK+AfRpZ7DmQ
X-ME-Proxy: <xmx:Y4u7av9-li1wMfEjbxKNlq527qFz6BzuKOWdexsu5H45OqBg08jwjg>
    <xmx:Y4u7amk2FEItqp8f7KmH1v7dWDodoJiMO57fIepF7yXGsjucZ1SwYg>
    <xmx:Y4u7ak1BeOWXJC4E7cBrWY0LEcwAXNQPuIH38QAGcc-MwP6hCLBTVg>
    <xmx:Y4u7apoJxSXcqdcbmrz7mrm_vW97X6tOG4l7eID6gEymU9Du_Jvk8A>
    <xmx:Y4u7aiik71wPDt2l6BXdmaJRs9mRKedkWD_vEYDxbuEDVg8BMSHa86iI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 05:56:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d04c4310 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 29 Sep 2026 09:56:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Sep 2026 11:56:29 +0200
Subject: [PATCH 1/3] date: add helpers to convert between "+HHMM" timezones
 and minutes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-pks-reftables-fix-timezone-format-v1-1-3df105a95ed1@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
In-Reply-To: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
To: git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, 
 Junio C Hamano <gitster@pobox.com>
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
index 014065b419..63ea9dbc76 100644
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
+	return minutes_to_tz(offset * eastwest);
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
2.56.0.rc2.329.gd58861e689.dirty

