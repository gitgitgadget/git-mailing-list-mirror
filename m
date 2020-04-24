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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0753C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DDC20706
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxozZgMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgDXPHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726707AbgDXPHn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:07:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC47C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so3973653pjh.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FMNth40AlDOhVFhvSbiwCFY2eVihWdAM/UgMz7Xh3U=;
        b=DxozZgMfNId4ikeruPebzoQuzwv98mWSpXbYICiQlYimcq+EBTf6Q1if/p7pEg5d2M
         0JKebiKZ3BVU74HJHIh9OrKJGE80tzdHCvgoWReQiCXlN555vcc9qUzKsYtcfCJxJRYJ
         Zo6nqHQdb7a4Xy/X8SAAoeLk9O4Mz9ZrUsIn+EJrmOe77H8tEUVqqbjkKi/qs8tRunwf
         pcPfm0oA7nkdPONM48tPuBGXGL0uiQizoZsez1RzlO8SdVuLBXmF4tL3AOtByH/6pHxA
         mHGw8NTtjqw+dmvq9pcOY/sQ5pkz7CXiIiRVINUUC83tpBouKjfP3qV5VAmJ5BIKF3Os
         QxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FMNth40AlDOhVFhvSbiwCFY2eVihWdAM/UgMz7Xh3U=;
        b=nwIiGdaF+X5vqaVChx+PZmU4WnyDXq+Hsd5hL7TphXPLk0yYZLeWw3iG4YGo6fK/VK
         luVOvtKWxGZ78/u6SGFOOzve8Jyn32QYR0KyJolBBoFMOE47N4lO8Qo6InSmwjHre92U
         /GRLb8dThNXiUkyhZk8WCQCIblVq2uTRpg6o0iT5pbRJfzVBn5XKmleQpz682LRpmc9q
         wLBcWt80kNWMEaIoUKhfKUGxf++ClZvmMnV6CEAIYZiyKAPK4oYdvVrdor1P2vVE7Xt3
         2g63mReKDD66SfMzYJXuddXqDj+LdQFZ3be4/14jIfdzVhLTqtUBXe7ZhYsHQCXnsf5E
         RfFA==
X-Gm-Message-State: AGi0PuZQVxeSeAPCB4x6PENEj9g2ND513t0XhB087w5ZRMfLGg7YtgQv
        Ann83Heg3BX1sTqp7CfhhNFemmOn
X-Google-Smtp-Source: APiQypLHwQApfq+8B13AimmFp+d9fHnYp5zrw5I99Jks2Gafz+aMRL5pBHaTINb8O5fzezkOZgECqA==
X-Received: by 2002:a17:902:e905:: with SMTP id k5mr4356945pld.232.1587740862465;
        Fri, 24 Apr 2020 08:07:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id c84sm6417052pfb.153.2020.04.24.08.07.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:07:41 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 2/4] date.c: validate and set time in a helper function
Date:   Fri, 24 Apr 2020 22:07:30 +0700
Message-Id: <a6b97b19f2b3177ad3d7460a024ce08d6f5f0c55.1587740682.git.congdanhqx@gmail.com>
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

In a later patch, we will reuse this logic, move it to a helper, now.

While we're at it, explicit states that we intentionally ignore
old-and-defective 2nd leap second.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Notes:
    I intentionally leave a pair of bracket around if (set_time(...))
    to reduce the noise in next patch

 date.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/date.c b/date.c
index b67c5abe24..fa39e5e8a5 100644
--- a/date.c
+++ b/date.c
@@ -539,6 +539,20 @@ static int set_date(int year, int month, int day, struct tm *now_tm, time_t now,
 	return -1;
 }
 
+static int set_time(long hour, long minute, long second, struct tm *tm)
+{
+	/* We accept 61st second because of leap second */
+	if (0 <= hour && hour <= 24 &&
+	    0 <= minute && minute < 60 &&
+	    0 <= second && second <= 60) {
+		tm->tm_hour = hour;
+		tm->tm_min = minute;
+		tm->tm_sec = second;
+		return 0;
+	}
+	return -1;
+}
+
 static int match_multi_number(timestamp_t num, char c, const char *date,
 			      char *end, struct tm *tm, time_t now)
 {
@@ -556,10 +570,7 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 	case ':':
 		if (num3 < 0)
 			num3 = 0;
-		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
-			tm->tm_hour = num;
-			tm->tm_min = num2;
-			tm->tm_sec = num3;
+		if (set_time(num, num2, num3, tm) == 0) {
 			break;
 		}
 		return 0;
-- 
2.26.2.384.g435bf60bd5

