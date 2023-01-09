Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD110C54EBE
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 12:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbjAIMaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 07:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbjAIM3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 07:29:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BF11400A
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 04:29:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c26so1534152pfp.10
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 04:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQLqYIrT6E/PtGmxwXisuCxOX3reJdfpRuxdh5sB/bg=;
        b=RVSRNX6ybIsFzzeVnz7yE92ybnpWIg4KYK5SnxuyKgzekclcHxFmVlRuv4TK4AjiWu
         IFGgE/RPAEDvIVAduXc8zjl61w3p+uUx5VRCDN4xSzFaB3N9mPg4/IWp/pbtOiqDcWnA
         pRicIEnC9Ba4+KcuYgqdLEUf6Q/SYOTsOI1WtUD/xzgrBNRBi5MfkuYTtdeDyD9nbsWK
         TjYeleKuwNTDWWPubJG6ExlykyREkeIR4w6Njva5dYPoR3Dc/Idd3sGHBQsYZYQ0+7wd
         COxzvDFOcYZ/HrcE80V08h7OgeoD/kbLH5Nu47M11QYIcYT/AMEiXg5MXkZSsHUe1T+o
         vpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQLqYIrT6E/PtGmxwXisuCxOX3reJdfpRuxdh5sB/bg=;
        b=37XqQQ/V9El4n+/726WaXbo7Ga13UPLLD1oO6pPtEiTzDWI5COBTMRaEpRHJOPRG2L
         pEvv8Rgt5rqx0L/UWWqVC4Nze79rbBKO1l50iHiZy+tXr/2okUgrwj6YV1KF1/xxQlLS
         VyrvvYJ4UXBC/ovn/hO5m4cJqkrd8YnC1Ic8IQYzjeWs0rtqTCKufEUM2f5InIBla1o4
         5Ush6zuPSV02Ftg5z4V7RaQBjs6q9Exgu96+OAH0RrpA/0OYE9xrsOscfQcnNyGUWXmX
         e27NpUUJLzTpbG1Wyki3JSuKB+8LmKh77+QCK1bYHSmzp06Mq4CMwKrHCqqszXiTvmhS
         tjVg==
X-Gm-Message-State: AFqh2kqJ3MkYYwnfFu5YmfY+gt5aTeGjcxwra1v0UC56ypSpE9pdGHWK
        q5bmp5j1LAPESb/1rv47QGajF8YoAHc=
X-Google-Smtp-Source: AMrXdXsYb6JFy5F4jP5gdSy5SnI5Ib9p7+j+AtJuFA3Opylb2T9VYjDTj3GGlihwVGOU5uy0QEKmGQ==
X-Received: by 2002:a62:524d:0:b0:582:cddd:784a with SMTP id g74-20020a62524d000000b00582cddd784amr20179825pfb.5.1673267373089;
        Mon, 09 Jan 2023 04:29:33 -0800 (PST)
Received: from localhost.localdomain ([103.156.58.205])
        by smtp.gmail.com with ESMTPSA id b12-20020aa78ecc000000b00581a156b920sm5933674pfr.132.2023.01.09.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 04:29:32 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>,
        plavarre@purestorage.com, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] date.c: limit less precision ISO-8601 with its marker
Date:   Mon,  9 Jan 2023 19:29:15 +0700
Message-Id: <20230109122915.30973-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.39.0.287.g690a66fa66
In-Reply-To: <Y7v6jThT9GQ8Oav8@danh.dev>
References: <Y7v6jThT9GQ8Oav8@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The newly added heuristic to parse less precision ISO-8601 conflicts
with other heuristics to parse datetime-strings. E.g.:

	Thu, 7 Apr 2005 15:14:13 -0700

Let's limit the new heuristic to only datetime string with a 'T'
followed immediately by some digits, and if we failed to parse the
upcoming string, rollback the change.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Here is a better thought out change, which tried to minimize the impact of
new heuristics.

While I think it's a fixup, but I still needs explaination, I think I may
reword it's as a full patch instead.
Range-diff:
1:  4036e5a944 ! 1:  b703425a57 fixup! date.c: allow ISO 8601 reduced precision times
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    fixup! date.c: allow ISO 8601 reduced precision times
    +    date.c: limit less precision ISO-8601 with its marker
    +
    +    The newly added heuristic to parse less precision ISO-8601 conflicts
    +    with other heuristics to parse datetime-strings. E.g.:
    +
    +            Thu, 7 Apr 2005 15:14:13 -0700
    +
    +    Let's limit the new heuristic to only datetime string with a 'T'
    +    followed immediately by some digits, and if we failed to parse the
    +    upcoming string, rollback the change.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    @@ date.c: static int match_alpha(const char *date, struct tm *tm, int *offset)
      	}
      
     +	/* ISO-8601 allows yyyymmDD'T'HHMMSS, with less precision */
    -+	if (*date == 'T' && isdigit(date[1])) {
    -+		tm->tm_hour = tm->tm_min = tm->tm_sec = 0;
    -+		return strlen("T");
    ++	if (*date == 'T' && isdigit(date[1]) && tm->tm_hour == -1) {
    ++		tm->tm_min = tm->tm_sec = 0;
    ++		return 1;
     +	}
     +
      	/* BAD CRAP */
    @@ date.c: static inline int nodate(struct tm *tm)
     - * We just do a binary 'and' to see if the sign bit
     - * is set in all the values.
     + * Have we seen an ISO-8601-alike date, i.e. 20220101T0,
    -+ * In those special case, those fields have been set to 0
    ++ * In which, hour is still unset,
    ++ * and minutes and second has been set to 0.
       */
     -static inline int notime(struct tm *tm)
     +static inline int maybeiso8601(struct tm *tm)
    @@ date.c: static inline int nodate(struct tm *tm)
     -	return (tm->tm_hour &
     -		tm->tm_min &
     -		tm->tm_sec) < 0;
    -+	return tm->tm_hour == 0 &&
    ++	return tm->tm_hour == -1 &&
     +		tm->tm_min == 0 &&
     +		tm->tm_sec == 0;
      }
      
      /*
     @@ date.c: static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
    - 	/* 4 digits, compact style of ISO-8601's time: HHMM */
    - 	/* 2 digits, compact style of ISO-8601's time: HH */
    - 	if (n == 8 || n == 6 ||
    + 
    + 	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
    + 	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
    +-	/* 4 digits, compact style of ISO-8601's time: HHMM */
    +-	/* 2 digits, compact style of ISO-8601's time: HH */
    +-	if (n == 8 || n == 6 ||
     -		(!nodate(tm) && notime(tm) &&
    -+		(!nodate(tm) && maybeiso8601(tm) &&
    - 		(n == 4 || n == 2))) {
    +-		(n == 4 || n == 2))) {
    ++	if (n == 8 || n == 6) {
      		unsigned int num1 = num / 10000;
      		unsigned int num2 = (num % 10000) / 100;
    + 		unsigned int num3 = num % 100;
    +@@ date.c: static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
    + 		else if (n == 6 && set_time(num1, num2, num3, tm) == 0 &&
    + 			 *end == '.' && isdigit(end[1]))
    + 			strtoul(end + 1, &end, 10);
    +-		else if (n == 4)
    +-			set_time(num2, num3, 0, tm);
    +-		else if (n == 2)
    +-			set_time(num3, 0, 0, tm);
    + 		return end - date;
    + 	}
    + 
    ++	/* reduced precision of ISO-8601's time: HHMM or HH */
    ++	if (maybeiso8601(tm)) {
    ++		unsigned int num1 = num;
    ++		unsigned int num2 = 0;
    ++		if (n == 4) {
    ++			num1 = num / 100;
    ++			num2 = num % 100;
    ++		}
    ++		if ((n == 4 || n == 2) && !nodate(tm) &&
    ++		    set_time(num1, num2, 0, tm) == 0)
    ++			return n;
    ++		/*
    ++		 * We thought this is an ISO-8601 time string,
    ++		 * we set minutes and seconds to 0,
    ++		 * turn out it isn't, rollback the change.
    ++		 */
    ++		tm->tm_min = tm->tm_sec = -1;
    ++	}
    ++
    + 	/* Four-digit year or a timezone? */
    + 	if (n == 4) {
    + 		if (num <= 1400 && *offset == -1) {
     
      ## t/t0006-date.sh ##
     @@ t/t0006-date.sh: check_parse '20080214T20:30' '2008-02-14 20:30:00 +0000'

 date.c          | 49 +++++++++++++++++++++++++++++++++----------------
 t/t0006-date.sh |  3 ++-
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/date.c b/date.c
index b011b9d6b3..6f45eeb356 100644
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
@@ -639,15 +645,15 @@ static inline int nodate(struct tm *tm)
 }
 
 /*
- * Have we filled in any part of the time yet?
- * We just do a binary 'and' to see if the sign bit
- * is set in all the values.
+ * Have we seen an ISO-8601-alike date, i.e. 20220101T0,
+ * In which, hour is still unset,
+ * and minutes and second has been set to 0.
  */
-static inline int notime(struct tm *tm)
+static inline int maybeiso8601(struct tm *tm)
 {
-	return (tm->tm_hour &
-		tm->tm_min &
-		tm->tm_sec) < 0;
+	return tm->tm_hour == -1 &&
+		tm->tm_min == 0 &&
+		tm->tm_sec == 0;
 }
 
 /*
@@ -701,11 +707,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 
 	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
 	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
-	/* 4 digits, compact style of ISO-8601's time: HHMM */
-	/* 2 digits, compact style of ISO-8601's time: HH */
-	if (n == 8 || n == 6 ||
-		(!nodate(tm) && notime(tm) &&
-		(n == 4 || n == 2))) {
+	if (n == 8 || n == 6) {
 		unsigned int num1 = num / 10000;
 		unsigned int num2 = (num % 10000) / 100;
 		unsigned int num3 = num % 100;
@@ -714,13 +716,28 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 		else if (n == 6 && set_time(num1, num2, num3, tm) == 0 &&
 			 *end == '.' && isdigit(end[1]))
 			strtoul(end + 1, &end, 10);
-		else if (n == 4)
-			set_time(num2, num3, 0, tm);
-		else if (n == 2)
-			set_time(num3, 0, 0, tm);
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
index 16fb0bf4bd..130207fc04 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -93,7 +93,8 @@ check_parse '20080214T20:30' '2008-02-14 20:30:00 +0000'
 check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
 check_parse '20080214T203045' '2008-02-14 20:30:45 +0000'
 check_parse '20080214T2030' '2008-02-14 20:30:00 +0000'
-check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
+check_parse '20080214T000000.20' '2008-02-14 00:00:00 +0000'
+check_parse '20080214T00:00:00.20' '2008-02-14 00:00:00 +0000'
 check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
 check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'
-- 
2.39.0.287.g690a66fa66

