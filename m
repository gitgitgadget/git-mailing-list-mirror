Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35BC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB582081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="HAYU0IjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgERKEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgERKEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 06:04:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A254C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u35so4585930pgk.6
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAjg/Yp0mAZPWl24JjXXSq+zcbC9DZHqTmFs2u+lT+w=;
        b=HAYU0IjFZSOnS22tD38nZxN0p5kRJfsBX5skyslX7VX72IcsPJHd/Y/r5EhoELoNEk
         TaTsPninKK24SneP5f9xUV3Dvp2m8diJzBX3LBB4GnXGgsUvALm5MLDcC1oHN9WDft6o
         NfokWm39QXQqQDO1Py0fJ096pql38FspUtb3eQkX5OAFx72cSAbUnBQ2dU0IG++zK3G3
         L/r8c7AfEm6eOt/miQrlR7oTHpBrFlf0eQ0nYuA/bNDWMT5Eq/yj1U6BHRw7YrZxLDEW
         qWbqIl84XEqJ9v6mJvHUX4AuPI1QJFiar1PANvAxOsJYzAi2sgheyBoqvZn28BD5ZJex
         6zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAjg/Yp0mAZPWl24JjXXSq+zcbC9DZHqTmFs2u+lT+w=;
        b=Ht3DOWlZm+/54T+I3M7jbjH/lJReRHEdUmCYKZOFeT3ahOV6PgUTyct2YjkZhFOLPr
         J+Szd5C92VB/hcp8x7Rfnfe7tNkJbdkJeYbVRFqC9esukxqPasOKPgQUzRIrbhLR8BYz
         Z3iuHB67V8QzAbmYmUa8FuT4DLq1TWreXDgRf+uvk7+u9bXHQeF9I7S8ymXEf9ROSjz8
         6Hun2GiA6iyKj+C1zapCwRmhVcINdtytxgmKu8zYT77r3GYnHTa0AhnfgijmslgBq0fw
         A8riFdPmk6L/YbBJo1wQdCoLUDZerQ6pVojRAO9TrFVNXS0oM5yBhXLp2ByNIKNUZuN7
         +deQ==
X-Gm-Message-State: AOAM532LrVPgrsTb5JaIJWy2WazPPYWTOZb3PH9RYoW7dxUcEdcinhky
        zkUsvmy3cKqsgTsJZ5ze1M0gvF0xA7NBKvAZwSpiPcuEWyZT8nvSUVRpKZKF/6ykt7DYYlVM7zH
        cppNDCzbbCoCD9n2hfZsoHXwevR93BfnfJgUPNvyNbONhYg27Vwg032L1sXhVQwc=
X-Google-Smtp-Source: ABdhPJyZ8OE3ErFvkoU3rN/THy1/Yy7dX2nf/dKM2OaloVrL5f0kQ2qU6XJAOfxMyzJwA+i0ZagQVQ==
X-Received: by 2002:a65:66d5:: with SMTP id c21mr13843886pgw.155.1589796247391;
        Mon, 18 May 2020 03:04:07 -0700 (PDT)
Received: from fw.dtucker.net (ppp59-167-129-32.static.internode.on.net. [59.167.129.32])
        by smtp.gmail.com with ESMTPSA id cc8sm8094167pjb.11.2020.05.18.03.04.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 03:04:06 -0700 (PDT)
Received: from gate.dtucker.net (2001-44b8-3110-fb01-0000-0000-0000-0001.static.ipv6.internode.on.net [2001:44b8:3110:fb01::1])
        by fw.dtucker.net (OpenSMTPD) with ESMTP id 3a372151
        for <git@vger.kernel.org>;
        Mon, 18 May 2020 20:04:02 +1000 (AEST)
Received: from gate.dtucker.net (localhost.localdomain [127.0.0.1])
        by gate.dtucker.net (8.15.2/8.15.2) with ESMTP id 04IA41hA029473;
        Mon, 18 May 2020 20:04:01 +1000
Received: (from dtucker@localhost)
        by gate.dtucker.net (8.15.2/8.15.2/Submit) id 04IA4116029466;
        Mon, 18 May 2020 20:04:01 +1000
From:   Darren Tucker <dtucker@dtucker.net>
To:     git@vger.kernel.org
Cc:     Darren Tucker <dtucker@dtucker.net>
Subject: [PATCH 4/7] Use strtoumax instead of strtoull.
Date:   Mon, 18 May 2020 20:03:53 +1000
Message-Id: <20200518100356.29292-4-dtucker@dtucker.net>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518100356.29292-1-dtucker@dtucker.net>
References: <20200518100356.29292-1-dtucker@dtucker.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strtoumax is in the compat library so this works on platforms that don't
have a native strtoull.

Signed-off-by: Darren Tucker <dtucker@dtucker.net>
---
 t/helper/test-progress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 5d05cbe789..3e9eb2abe3 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -47,7 +47,7 @@ int cmd__progress(int argc, const char **argv)
 		char *end;
 
 		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
-			uint64_t item_count = strtoull(end, &end, 10);
+			uint64_t item_count = strtoumax(end, &end, 10);
 			if (*end != '\0')
 				die("invalid input: '%s'\n", line.buf);
 			display_progress(progress, item_count);
@@ -55,10 +55,10 @@ int cmd__progress(int argc, const char **argv)
 				       (const char **) &end)) {
 			uint64_t byte_count, test_ms;
 
-			byte_count = strtoull(end, &end, 10);
+			byte_count = strtoumax(end, &end, 10);
 			if (*end != ' ')
 				die("invalid input: '%s'\n", line.buf);
-			test_ms = strtoull(end + 1, &end, 10);
+			test_ms = strtoumax(end + 1, &end, 10);
 			if (*end != '\0')
 				die("invalid input: '%s'\n", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;
-- 
2.21.3

