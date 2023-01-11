Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0D4C54EBC
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 00:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjAKAKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 19:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjAKAKP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 19:10:15 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B563614D0A
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 16:10:14 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w3so14980974ply.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 16:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIQ5l/eBawyCD3mfEvJTpdzqWkVdWiyTSoGKnPmCKyU=;
        b=FLbk+VizEo+8Am4OA0kEqHZk94x8WhhaP9SKEQSLYdsCZnfq90VJIxDQIPAPNl9FYB
         KSXmFhKTriWvE2qWHAbTHBEujvJ3tiJRqVAiOjDAWMTnxPnAYfafIU7FyFWBb7alSBLS
         HwR2IL2br9531pbEpHi+pMvcCKd7zu5feNC4K7rlS16YD1e0bPfwCZsbS2f9pn7UA49W
         IMW7D07J2v3SZ5tBQ/X+50U9n71z2z+9Gd5YpRE+I/GIVCdnJhB34xi4xEXKmxm7QGYL
         XZ84Hg65jWauYc57GaaX9mz/1G9Vh7jvavc2sG/RqOVFeG2i+bs4o8Yp8NzE2bX/MLIi
         E9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIQ5l/eBawyCD3mfEvJTpdzqWkVdWiyTSoGKnPmCKyU=;
        b=i7lXshCal2UfI0/8OJgdEx9ZgiDod7MIi4fMbSz9YibAtIAsxkZQhWLyKD4ZD/tr6D
         prQLkidI7PU4G6Eo8eVil600HL2nz8jRN5DRe6c1r89I9FS/q1e9z34dVEdyyA2GWHJf
         Unl+abrc77Bby/HMlNkKDr1QawcfjR1kBUJA/4oircyX8HYOm6FR9ne7o13YwWcq/waI
         NcBAVfjI2lWzfjctJW1Tk8YaVcry0TS4lKw8EbbsI6PS2DL1v/6lkmuH4MxvYILDGxQq
         A0msKIi0b9xtcoB9gZGzxfIA1GEnbz4Yw5QbH/zYurtDqOI0XpnUhkGVSCXwh38J8P+b
         ONnw==
X-Gm-Message-State: AFqh2kodDFywQezp8UEjFiiSDsVn/yUZR8i8O35NlOOzVYWlq/NYjzHw
        c79eYY/T6+tGmA0ocsF/D1Z+C0iu/uY=
X-Google-Smtp-Source: AMrXdXs4vOjARh9RpZKejKQnXin4wvpWoq458z/p0HNj7iSxls7rTA/zca1tL4OIC7TWJXDZGZimpw==
X-Received: by 2002:a17:902:9348:b0:190:e63a:ea91 with SMTP id g8-20020a170902934800b00190e63aea91mr66867978plp.0.1673395813822;
        Tue, 10 Jan 2023 16:10:13 -0800 (PST)
Received: from localhost.localdomain ([103.156.58.205])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b00183c6784704sm8578633plc.291.2023.01.10.16.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 16:10:13 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Phil Hord <phil.hord@gmail.com>,
        plavarre@purestorage.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] date.c: allow ISO 8601 reduced precision times
Date:   Wed, 11 Jan 2023 07:10:03 +0700
Message-Id: <20230111001003.10916-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.39.0.287.g690a66fa66
In-Reply-To: <20221216033638.2582956-1-phil.hord@gmail.com>
References: <20221216033638.2582956-1-phil.hord@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ISO 8601 permits "reduced precision" time representations to omit the
seconds value or both the minutes and the seconds values.  The
abbreviate times could look like 17:45 or 1745 to omit the seconds,
or simply as 17 to omit both the minutes and the seconds.

parse_date_basic accepts the 17:45 format but it rejects the other two.
Change it to accept 4-digit and 2-digit time values when they follow a
recognized date and a 'T'.

Before this change:

$ TZ=UTC test-tool date approxidate 2022-12-13T23:00 2022-12-13T2300 2022-12-13T23
2022-12-13T23:00 -> 2022-12-13 23:00:00 +0000
2022-12-13T2300 -> 2022-12-13 23:54:13 +0000
2022-12-13T23 -> 2022-12-13 23:54:13 +0000

After this change:

$ TZ=UTC helper/test-tool date approxidate 2022-12-13T23:00 2022-12-13T2300 2022-12-13T23
2022-12-13T23:00 -> 2022-12-13 23:00:00 +0000
2022-12-13T2300 -> 2022-12-13 23:00:00 +0000
2022-12-13T23 -> 2022-12-13 23:00:00 +0000

Note: ISO 8601 also allows reduced precision date strings such as
"2022-12" and "2022". This patch does not attempt to address these.

Reported-by: Pat LaVarre <plavarre@purestorage.com>
Signed-off-by: Phil Hord <phil.hord@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Since this is a complete re-implementation from Phil Hord's version.
I'm reassigning the author to me.

This version change the implementation to only treat the string as ISO8601 if
a 'T' existed and date has been parsed. I also added a test for parsing
RFC-822, which Hord accidentally broke.

The commit message has been changed:
* The example has been changed to be independent from local timezone
* Remove the mention of adding test-cases, since it's obviously necessary.

 date.c          | 37 +++++++++++++++++++++++++++++++++++++
 t/t0006-date.sh |  8 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/date.c b/date.c
index 53bd6a7932..6f45eeb356 100644
--- a/date.c
+++ b/date.c
@@ -493,6 +493,12 @@ static int match_alpha(const char *date, struct tm *tm, int *offset)
 		return 2;
 	}
 
+	/* ISO-8601 allows yyyymmDD'T'HHMMSS, with less precision */
+	if (*date == 'T' && isdigit(date[1]) && tm->tm_hour == -1) {
+		tm->tm_min = tm->tm_sec = 0;
+		return 1;
+	}
+
 	/* BAD CRAP */
 	return skip_alpha(date);
 }
@@ -638,6 +644,18 @@ static inline int nodate(struct tm *tm)
 		tm->tm_sec) < 0;
 }
 
+/*
+ * Have we seen an ISO-8601-alike date, i.e. 20220101T0,
+ * In which, hour is still unset,
+ * and minutes and second has been set to 0.
+ */
+static inline int maybeiso8601(struct tm *tm)
+{
+	return tm->tm_hour == -1 &&
+		tm->tm_min == 0 &&
+		tm->tm_sec == 0;
+}
+
 /*
  * We've seen a digit. Time? Year? Date?
  */
@@ -701,6 +719,25 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 		return end - date;
 	}
 
+	/* reduced precision of ISO-8601's time: HHMM or HH */
+	if (maybeiso8601(tm)) {
+		unsigned int num1 = num;
+		unsigned int num2 = 0;
+		if (n == 4) {
+			num1 = num / 100;
+			num2 = num % 100;
+		}
+		if ((n == 4 || n == 2) && !nodate(tm) &&
+		    set_time(num1, num2, 0, tm) == 0)
+			return n;
+		/*
+		 * We thought this is an ISO-8601 time string,
+		 * we set minutes and seconds to 0,
+		 * turn out it isn't, rollback the change.
+		 */
+		tm->tm_min = tm->tm_sec = -1;
+	}
+
 	/* Four-digit year or a timezone? */
 	if (n == 4) {
 		if (num <= 1400 && *offset == -1) {
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 2490162071..e18b160286 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -88,6 +88,13 @@ check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
 check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '20080214T20:30:45' '2008-02-14 20:30:45 +0000'
+check_parse '20080214T20:30' '2008-02-14 20:30:00 +0000'
+check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
+check_parse '20080214T203045' '2008-02-14 20:30:45 +0000'
+check_parse '20080214T2030' '2008-02-14 20:30:00 +0000'
+check_parse '20080214T000000.20' '2008-02-14 00:00:00 +0000'
+check_parse '20080214T00:00:00.20' '2008-02-14 00:00:00 +0000'
 check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
 check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'
@@ -99,6 +106,7 @@ check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
 check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
+check_parse 'Thu, 7 Apr 2005 15:14:13 -0700' '2005-04-07 15:14:13 -0700'
 
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect
-- 
2.39.0.287.g690a66fa66

