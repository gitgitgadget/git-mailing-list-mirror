Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F97C55191
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EFF20767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rse2FujX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgDXPHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726707AbgDXPHl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:07:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71727C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a5so3973621pjh.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6Pa10RZbqUp9fkgDKJ5iLiLAKb3oXXpq5PDrmLBUk0=;
        b=rse2FujXuq1FXPAADtwUJKBL+qrfJEa0DbqD8od19nzH7biPooXJlpO9hMjVeXLStD
         yoCED3CIeGc4+QYWddagtEZhDcwG8HLESIfdrk46PaUmli9ZwNWhuojFs+PxEl0BvIyJ
         FCGPFTaV1XLi8CoGbHBDoaNrPnk14weyb/bGAScq7fWiBWeHyjytL3Pio1zlpjWuwgMz
         IQp16TKGaam/oGcDk2Eras/YjNCuWsJrygDE6tcrfDfWcWYyQGzxpGRptbfV9SFztL4r
         +1SB5tlHceF9p8y3q6Wup8mFhZYAMMHXoLj7LwOzRSvTuiOqPlAaUBHuPgOx7FXnOoKC
         PRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6Pa10RZbqUp9fkgDKJ5iLiLAKb3oXXpq5PDrmLBUk0=;
        b=sAfbRecS1wgSFQgiPxVu+yJ73VsQAddS7LRIf4vFm2BHQnNfrWYPfGcrG1yYDnUeh0
         fx/jgskz8rww6xjuEufmawyfEOCkwFG+9OjJnRfkQnjZ5Ql+1H1WolYahgbnHycrShbr
         WFYj1pKWyNrrJJ/l3s+6tZBZXiKgJiu3szcwwB/nZdHxeEiIE+GDdT/Tq7tLP9vlfRPI
         l6NIvMd46fZ4/mEZ0mHYO0p3013IWNivpK/46E3zjph8IdsRW4L2FbGv19tI1M6egMh8
         /JyI/5KOrfM+xBHUPCIKDBSzR+pQQT+TXbHNq6YzWQ+NuP6ZJUuFvbTBm753cRIzh3sO
         9xwA==
X-Gm-Message-State: AGi0PuaAhIm8kw9s2J3Le0RJgZDXQPD3MsN+DvhQ5h/kdPdWRMGamHJp
        PfGmBG30+AFvett1w0pAS/5o9ih9
X-Google-Smtp-Source: APiQypLVoaLBnKZy+QoMbMeS+Sb51cOZbyGP+15PPJZIXMM4yx2DY7bgWVKH5eJSQcTlyg+OXdtbBQ==
X-Received: by 2002:a17:902:9004:: with SMTP id a4mr8915062plp.275.1587740860747;
        Fri, 24 Apr 2020 08:07:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id c84sm6417052pfb.153.2020.04.24.08.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:07:40 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 1/4] date.c: s/is_date/set_date/
Date:   Fri, 24 Apr 2020 22:07:29 +0700
Message-Id: <1fe69008fc79e6a74e8613011504bc7e342291ab.1587740682.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587740682.git.congdanhqx@gmail.com>
References: <cover.1586856398.git.congdanhqx@gmail.com> <cover.1587740682.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function is_date, confusingly also set tm_year. tm_mon, and tm_mday
after validating input.

Rename to set_date to reflect its real usage.

Also, change return value is 0 on success and -1 on failure following
our convention on function do some real work.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 date.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/date.c b/date.c
index b0d9a8421d..b67c5abe24 100644
--- a/date.c
+++ b/date.c
@@ -497,7 +497,7 @@ static int match_alpha(const char *date, struct tm *tm, int *offset)
 	return skip_alpha(date);
 }
 
-static int is_date(int year, int month, int day, struct tm *now_tm, time_t now, struct tm *tm)
+static int set_date(int year, int month, int day, struct tm *now_tm, time_t now, struct tm *tm)
 {
 	if (month > 0 && month < 13 && day > 0 && day < 32) {
 		struct tm check = *tm;
@@ -518,9 +518,9 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 		else if (year < 38)
 			r->tm_year = year + 100;
 		else
-			return 0;
+			return -1;
 		if (!now_tm)
-			return 1;
+			return 0;
 
 		specified = tm_to_time_t(r);
 
@@ -529,14 +529,14 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 		 * sure it is not later than ten days from now...
 		 */
 		if ((specified != -1) && (now + 10*24*3600 < specified))
-			return 0;
+			return -1;
 		tm->tm_mon = r->tm_mon;
 		tm->tm_mday = r->tm_mday;
 		if (year != -1)
 			tm->tm_year = r->tm_year;
-		return 1;
+		return 0;
 	}
-	return 0;
+	return -1;
 }
 
 static int match_multi_number(timestamp_t num, char c, const char *date,
@@ -575,10 +575,10 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 
 		if (num > 70) {
 			/* yyyy-mm-dd? */
-			if (is_date(num, num2, num3, NULL, now, tm))
+			if (set_date(num, num2, num3, NULL, now, tm) == 0)
 				break;
 			/* yyyy-dd-mm? */
-			if (is_date(num, num3, num2, NULL, now, tm))
+			if (set_date(num, num3, num2, NULL, now, tm) == 0)
 				break;
 		}
 		/* Our eastern European friends say dd.mm.yy[yy]
@@ -586,14 +586,14 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 		 * mm/dd/yy[yy] form only when separator is not '.'
 		 */
 		if (c != '.' &&
-		    is_date(num3, num, num2, refuse_future, now, tm))
+		    set_date(num3, num, num2, refuse_future, now, tm) == 0)
 			break;
 		/* European dd.mm.yy[yy] or funny US dd/mm/yy[yy] */
-		if (is_date(num3, num2, num, refuse_future, now, tm))
+		if (set_date(num3, num2, num, refuse_future, now, tm) == 0)
 			break;
 		/* Funny European mm.dd.yy */
 		if (c == '.' &&
-		    is_date(num3, num, num2, refuse_future, now, tm))
+		    set_date(num3, num, num2, refuse_future, now, tm) == 0)
 			break;
 		return 0;
 	}
-- 
2.26.2.384.g435bf60bd5

