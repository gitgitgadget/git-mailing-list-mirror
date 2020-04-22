Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA288C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 13:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83FE2077D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 13:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVrRA2fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDVNQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDVNQH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 09:16:07 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA7C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 06:16:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x77so1077244pfc.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5H9WWA1a8Xmu+/NBkRkyzaKKMU+kyEzkjAC56B70nw=;
        b=FVrRA2fph8jX75p50+GUMP3ilMNvEPTDQMXt5hH1S9YwEhtPpqwcSLxP+c8LjnZq3h
         eU8F0QzcxIPiQi0QQWVTZPHCgQqxEEPYFmTkHhlz+AyEyyuePnQ1GYuGEsI9IZJzGV+K
         7ubrSJ/L2IcWd00y9hXN6bdSNze0Uceo8G1pZRtsEwlwnO0PrmKrP9fFXyNS5imkT+6J
         5M8oIk4qSEyKt7xnJnCE/kq0GWQs2Y0HRLcE06t8xVAP2qYF1fyLGy9JvWwGNQIWi14Y
         Bqf/Ur00F9c7vxGGKJslxauApy9R7+FwHf+33ONtH3vb+gtG31B9sU3evMBi2Zx+8Ntw
         257Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5H9WWA1a8Xmu+/NBkRkyzaKKMU+kyEzkjAC56B70nw=;
        b=ZZfJ7eP/0pdF3orJl1XLJACTdZ0HT4QWTgb5C8kkgA8YwLR919HjHmGTvZrp/ir+1F
         tSsiWuIr56kb2052Crwa47ks/V6cuhvIYgpS0g1oFwvYYmyLCzx65V0sZ2KNA+ai5Ao8
         EruNXlJ+STMNMkz1lWEtYqflu7GwX05SZF3sLAAFoSM8UjVgg/vP26ZHzIN/Nh+JiFDd
         GeKVWNJGL/u53aYId6oFObqshsCIAqoaWbD3I//jSMIP6BrELV16+L2EM5pgbxfPOUSh
         uvnKYvJHr9A+Q4IOmp+/WHtM1zcBwub/9DOP43XOZK7jyallZ6TD2ldC98TDRzoJ89L5
         V7Rg==
X-Gm-Message-State: AGi0PuZvRK9mCelv9baiFdUhVsLNjuKBwrh79ScOelt6/Zs9ykxPgJf4
        XDJchSzOQMKQMR1fZaRUnUcvBkyD
X-Google-Smtp-Source: APiQypIgXYV8n7lZxQyIsi5gktg1bBUWklnIFONdRxSYQ9FLIo2ViUWWXYdLAaEBeE8rSUbI7SETew==
X-Received: by 2002:a63:514a:: with SMTP id r10mr24626102pgl.246.1587561365416;
        Wed, 22 Apr 2020 06:16:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id 192sm5412635pfu.182.2020.04.22.06.16.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 06:16:04 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/2] date.c: skip fractional second part of ISO-8601
Date:   Wed, 22 Apr 2020 20:15:52 +0700
Message-Id: <c6d42785bb762f691b00c48b57c73a1933fadbc3.1587559135.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a78
In-Reply-To: <cover.1587559135.git.congdanhqx@gmail.com>
References: <cover.1586856398.git.congdanhqx@gmail.com> <cover.1587559135.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-commit(1) says ISO-8601 is one of our supported date format.

ISO-8601 allows timestamps to have a fractional number of seconds.
We represent time only in terms of whole seconds, so we never bothered
parsing fractional seconds. However, it's better for us to parse and
throw away the fractional part than to refuse to parse the timestamp
at all.

And refusing parsing fractional second part may confuse the parse to
think fractional and timezone as day and month in this example:

	2008-02-14 20:30:45.019-04:00

Reported-by: Brian M. Carlson <sandals@crustytoothpaste.net>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/date-formats.txt |  5 ++++-
 date.c                         | 10 +++++++++-
 t/t0006-date.sh                |  3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 6926e0a4c8..7e7eaba643 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -20,7 +20,10 @@ RFC 2822::
 ISO 8601::
 	Time and date specified by the ISO 8601 standard, for example
 	`2005-04-07T22:13:13`. The parser accepts a space instead of the
-	`T` character as well.
+	`T` character as well. Fractional parts of a second will be ignored,
+	for example `2005-04-07T22:13:13.019` will be treated as
+	`2005-04-07T22:13:13`
+
 +
 NOTE: In addition, the date part is accepted in the following formats:
 `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
diff --git a/date.c b/date.c
index b0d9a8421d..62f23b4702 100644
--- a/date.c
+++ b/date.c
@@ -554,8 +554,16 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 	/* Time? Date? */
 	switch (c) {
 	case ':':
-		if (num3 < 0)
+		if (num3 < 0) {
 			num3 = 0;
+		} else if (*end == '.' && isdigit(end[1]) &&
+			   tm->tm_year != -1 && tm->tm_mon != -1 &&
+			   tm->tm_mday != -1) {
+			/* Attempt to guess meaning of <num> in HHMMSS.<num>
+			 * only interpret as fractional when %Y %m %d is known.
+			 */
+			strtol(end + 1, &end, 10);
+		}
 		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
 			tm->tm_hour = num;
 			tm->tm_min = num2;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index d9fcc829a9..80917c81c3 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -81,6 +81,8 @@ check_parse 2008-02 bad
 check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
 check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
@@ -103,6 +105,7 @@ check_approxidate 5.seconds.ago '2009-08-30 19:19:55'
 check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
 check_approxidate yesterday '2009-08-29 19:20:00'
 check_approxidate 3.days.ago '2009-08-27 19:20:00'
+check_approxidate '12:34:56.3.days.ago' '2009-08-27 12:34:56'
 check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
 check_approxidate 3.months.ago '2009-05-30 19:20:00'
 check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
-- 
2.26.2.303.gf8c07b1a78

