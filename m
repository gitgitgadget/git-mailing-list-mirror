Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F33B6BF5
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684191; cv=none; b=kFszpesog8N1aReWFqc4Ro22Z9Cj/YBJheRDa1vgg4BZYMRx3YeiCA0+0aVdQsAF9cWw7Yy/aXOgRalzMZ2q+d0J3cWQhdyrns15SOcXxJe0HJc56giE1kCQqLCvOREU9xXZu9Sw9avixmMywFjaI1V74Y8p8boXIgaZuzoPalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684191; c=relaxed/simple;
	bh=BIeqqWDk5hidBV4m1wXARs9szT2YpUwEEAWUf44ZxmI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eY+/hJvMPfyWZVeU5Gj3w6xIRIc7/D2Ux4BP3n2vL4HFegP7v1IhSM9bo/qXbF1RuL04ZLgRDwzSgY5mKB9FU82SjkmVNhhzydksPBw8FwqN40Lp8a8GpEM9jOtg5DEF9CMYHb0mDxhiTbxq03CVwmlUJGbOoCJKUbVdM20t6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2dnMYM9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2dnMYM9"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso63591a12.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684186; x=1788288986; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tFePORA2mJCRT78YpOLRT2QNCNk3z3ycMZ4SlMRXvvE=;
        b=o2dnMYM9XZVW9D4uFjGBGrgjkUy4gSZg8VY+XwhX+07CcxV0oZgshD/m4oX2VUaLDI
         B+faJEI84Lu2Ma6r/lu6Z/vDgk8xT75cVPilVV82WCr18sz4oVtliDLVM1HclE360yNr
         GE/lAqnOM0qsB1aB5H/mBZXV2PCvfeYDKS0DesnOMP6Q7axSpcNuxQZ5MHF0Vvf8EPRL
         bjP5W60ptMwFaAPKbCr3Jjcj4bNcdHiElFRO+3/4M+my0ATYHdolGz11nG+4EfB8al1P
         SU/6tR7gv/7iTBPEuBRkToWnvdc70qnJnbbKnINCd/Ek1Kpy3A+s5YZK8I0AGw+BudKz
         iHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684186; x=1788288986;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tFePORA2mJCRT78YpOLRT2QNCNk3z3ycMZ4SlMRXvvE=;
        b=NB9D8cxMr5GJJzkR5J0f4DWvHBtoGXXMVzV2NsPNEhGu5W6glVa4lbwyH+iYM0x8mg
         TVgg9QaIe/A28WG5oInIetcYkXgmNAxWWK+x41WtTwv/7CBONBmrjtlzScOh1ZFNUW9B
         HavKEi7kOasZHGWUsr/xi3rl6f1Em/6iyLa2K/jRnqRbfA74iwGt74VZmjCgTP37bkUr
         N253wToqcSURfgRI+G4rkUZoHq0NvPPnoHbfbxjzaoKU0ylPmbQ9upDFTBhaVF4tZ2ir
         iR8PGxYcuF3CsWWvLKUJnki9hG6Ae9sUXxpXHmb1rPWcZl/7x1NUzHdC24jIOw2Cb/yC
         lSMg==
X-Gm-Message-State: AFuF++nD0MKX1t/s/DOzun0/aqEMF3EQ49Fes+kuyIZ7rWo6d8cLSLpU
	gd4PxPWOWxxo0ClkMzeiBVov/9RGnjNXsDNCS3KwwXlxHeTwRyVpUdwMl/7+qLNo
X-Gm-Gg: AR+sD12htCByBBthI6JG6WnG0iNtSip1LEGOaD0RL+K0GzgIWPNOl+XGK270heCKpYq
	EQI+PBkvMnfraar35Op9K1yXMJML3Y42LSWLc+Ci0Ii1YLkftbCotk/6fCsfrDtU7QwzBEMqK+Z
	2iir3GG6EAaxkiE2ng3bRubaNFYCEMyGpESqroVDUODN5b/ouG0QjZS2XacCDD9GPDHFBEYAzLT
	xTY4hF174MctCXpWjg+1JS9jZfNg6wjf3o94RHsGn3dthbCCKeZaEmpfQg1JYYvlNpy8UZqpZo5
	NTBNAfNFL63jfyf1vV2FRQy+kULUc1hZhyzcuqspt7AsdZO6CA9UXWH6uJftpNR0qJInhkRBism
	QP8NaXIK22IEWJDbt2wkkXE8uNae5RViMgp7rfOe95b2rIzZYGFTUDoFi495p8X0m5Jr4YKT2ZD
	XdVRmGpLUhWIPBh3p0bL0OX3mwWWmp/KaVEFzCKo2r7uPeAkN/+FDfHkwFh7ubVHI=
X-Received: by 2002:a05:6a20:a11f:b0:3cc:fb7d:a9ab with SMTP id adf61e73a8af0-3cf7586eccdmr957852637.2.1787684186401;
        Tue, 25 Aug 2026 11:56:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d886256sm1000588eec.16.2026.08.25.11.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:56:25 -0700 (PDT)
Message-Id: <bd45f46a34aeb539d45d71b76c12c319abbfbcb5.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 18:56:16 +0000
Subject: [PATCH v2 2/7] trace2: tolerate failed timestamp formatting
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
Cc: gitster@pobox.com,
    Taylor Blau <ttaylorr@openai.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Some users reported issues of repeated messages:

  fatal: recursion detected in die handler

This wasn't happening every time, but we eventually captured a
GIT_TRACE2_PERF log file with this issue and revealed an interesting
internal detail, failing with this message:

  unable to format message: %4d-%02d-%02dT%02d:%02d:%02d.%06ldZ

This specific format string tracks to tr2_tbuf_utc_datetime_extended()
in trace2/tr2_tbuf.c. This logic began as tr2_tbuf_utc_time() in
ee4512ed481 (trace2: create new combined trace facility, 2019-02-22) but
was later split in bad229aef23 (trace2: clarify UTC datetime formatting,
2019-04-15).

This use of xsnprintf() is writing a very specific datetime format into a
32-character buffer. The format requires that the input data will not
overflow the format digits or the buffer will not hold the result. Since
we are using xsnprintf() here, those failures turn into die() events.

This method and its siblings, tr2_tbuf_local_time() and
tr2_tbuf_utc_datetime(), are used in the tracing library. The extended
form is used only for the 'event' format, which these users were using
via a config setting for use in client-side telemetry. The non-extended
form is used to help generate the 'SID' that defines the process in the
traces.

Not only are these inappropriate times for a failure, but the extended
method is called specifially during the 'atexit' event, which was
triggering this problem in a loop as the 'atexit' event would be
retriggered by the die().

Based on other symptoms impacting users on the version reporting these
failures, it is most likely that this is actually a failure to allocate
memory, which is a specific symptom in Git for Windows. That fork uses a
different library for its implementation of vsprintf() which allocates
an array when seven or more positional arguments exist in the formatting
string, such as this one.

Ultimately, the trace2 machinery is so low-level that it should not rely on
any helper functions that perform error handling with die(), as that can
trigger issues that would then be traced, causing this kind of recursive
loop.

These changes help remove any use of die() within this file:

1. Both 'tv' and 'tm' structs are initialized with zero values, allowing
   an erroring gettimeofday() or gmtime_r() method to leave them
   zero-valued. A zero-valued date is better than a die() here.

2. Replace the use of xsnprintf() with snprintf() to avoid the
   possibility of calling die() here. Instead, check the response to see
   if there was a failure. On failure, put a blank value into the buffer
   instead of possibly allowing a value that would not format correctly
   for a trace2 consumer. This value should be seen as obviously wrong
   and therefore signals a problem.

As the core issue in this code seems to require a system method
returning an error, no test accompanies this change.

This change removes all uses of xsnprintf() from the trace2/ directory.
There are two uses of xstrdup() that could be considered for removal,
but they only die() on out-of-memory errors instead of formatting
issues. I chose to leave those in place for now.

Helped-by: Taylor Blau <ttaylorr@openai.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h      |  3 +++
 trace2/tr2_tbuf.c | 49 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/banned-die.h b/banned-die.h
index 5eff361e55..0e0a794e5d 100644
--- a/banned-die.h
+++ b/banned-die.h
@@ -11,4 +11,7 @@
 #undef die
 #define die banned(die)
 
+#undef xsnprintf
+#define xsnprintf(...) BANNED(xsnprintf)
+
 #endif /* BANNED_DIE_H */
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index 86725426f6..fff345cb99 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -4,45 +4,64 @@
 
 void tr2_tbuf_local_time(struct tr2_tbuf *tb)
 {
-	struct timeval tv;
-	struct tm tm;
+	struct timeval tv = { 0 };
+	struct tm tm = { 0 };
 	time_t secs;
+	int len;
 
 	gettimeofday(&tv, NULL);
 	secs = tv.tv_sec;
 	localtime_r(&secs, &tm);
 
-	xsnprintf(tb->buf, sizeof(tb->buf), "%02d:%02d:%02d.%06ld", tm.tm_hour,
-		  tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+	len = snprintf(tb->buf, sizeof(tb->buf), "%02d:%02d:%02d.%06ld",
+		       tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+
+	if (len < 0 || (size_t)len >= sizeof(tb->buf)) {
+		const char *blank = "00:00:00.000000";
+		strlcpy(tb->buf, blank, sizeof(tb->buf));
+	}
 }
 
 void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb)
 {
-	struct timeval tv;
-	struct tm tm;
+	struct timeval tv = { 0 };
+	struct tm tm = { 0 };
 	time_t secs;
+	int len;
 
 	gettimeofday(&tv, NULL);
 	secs = tv.tv_sec;
 	gmtime_r(&secs, &tm);
 
-	xsnprintf(tb->buf, sizeof(tb->buf),
-		  "%4d-%02d-%02dT%02d:%02d:%02d.%06ldZ", tm.tm_year + 1900,
-		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
-		  (long)tv.tv_usec);
+	len = snprintf(tb->buf, sizeof(tb->buf),
+		       "%4d-%02d-%02dT%02d:%02d:%02d.%06ldZ",
+		       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+		       tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+
+	if (len < 0 || (size_t)len >= sizeof(tb->buf)) {
+		const char *blank = "1900-00-00T00:00:00.000000Z";
+		strlcpy(tb->buf, blank, sizeof(tb->buf));
+	}
 }
 
 void tr2_tbuf_utc_datetime(struct tr2_tbuf *tb)
 {
-	struct timeval tv;
-	struct tm tm;
+	struct timeval tv = { 0 };
+	struct tm tm = { 0 };
 	time_t secs;
+	int len;
 
 	gettimeofday(&tv, NULL);
 	secs = tv.tv_sec;
 	gmtime_r(&secs, &tm);
 
-	xsnprintf(tb->buf, sizeof(tb->buf), "%4d%02d%02dT%02d%02d%02d.%06ldZ",
-		  tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
-		  tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+	len = snprintf(tb->buf, sizeof(tb->buf),
+		       "%4d%02d%02dT%02d%02d%02d.%06ldZ",
+		       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+		       tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+
+	if (len < 0 || (size_t)len >= sizeof(tb->buf)) {
+		const char *blank = "19000000T000000.000000Z";
+		strlcpy(tb->buf, blank, sizeof(tb->buf));
+	}
 }
-- 
gitgitgadget

