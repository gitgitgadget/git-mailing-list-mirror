Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC31C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BEB2158A
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4MdoJrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfK1MZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:25:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46202 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:25:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so13059135pfc.13
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 04:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02MJ1nQjnvLsmuFm1biNpqIssGDVVB3HH9Wa6BBhcl8=;
        b=h4MdoJrR77Bi6w1k5RVYyRS7hYU5G7wT5nhZfP7n18VSKJIfwdpY9LjDqmJnFAii4M
         WFEV7aA5k/TmOpsugJZGQGAeD/swGPn6cYN8Z8d8wR2784EM35e+X+Sa/pMsYfvq07+J
         dOfwUpDPhsfYHgw54i8nrAtzwo16efQmeKiznvwgl+NpgK1lvuTV6JHdtbT/rRRX1elY
         1lPDVr8baTgQSwH123Z4Ct8Gwoz/NsWqcHIRjIsaFABO9mazwm8zMPolmGr66QJn1sD0
         N/1ox1/8TQ5nsLdSuykPNWbZ9P6Byc72H2b9sY9+vEkeGJ6BnVVX5qxeN06qWN6sSzve
         pP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02MJ1nQjnvLsmuFm1biNpqIssGDVVB3HH9Wa6BBhcl8=;
        b=RUyspgLpgC0LdQ+yR1GG/5+viqH6ivTd6VBNNGacGMeC8MdYjkGY4vWYv4p8RgjUSv
         4n4yRd6HJk9eZwww7+Ub00Ai4M32RbGsD+kruAOH5ntNidAR9WjV/wYBdvaBoS2uQt40
         OvgEmMs9qN7zjZ27rTX47jYSdc2VVtzvI9VJIewgidtR7lqkXUwpDcM/BHjgxqfumIcx
         6hfrTTAVr2zkSKKqVzxHdDDrVNm1XVDkdo7BEOMGDSSNP24W00tnlX1PHsloA7R63yN5
         tbyX4Ps0H//DQP1NXBw9257Svn6Lw2ymi05ZZtsEPR8DFDa1a8ESR50OMPpkJA0t1nlF
         xaJQ==
X-Gm-Message-State: APjAAAWiWczxaFIX+Rz4/6WTQ7sjMC/INcZqc0WxLslY/sJwsnRPuC0c
        xYBt6kPzdLYTSDo9NrnFACZ944sw
X-Google-Smtp-Source: APXvYqxMEATMo/gEBm17Ss3OjKi/qST7NvWzvjZ5ybGfDh9wtq52v4qf5PUJYmCLdtcbCezEOOaxEw==
X-Received: by 2002:a63:e4e:: with SMTP id 14mr10944819pgo.237.1574943924852;
        Thu, 28 Nov 2019 04:25:24 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id r28sm18849448pgk.75.2019.11.28.04.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 04:25:24 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v2 0/3] Phase out non-reentrant time functions
Date:   Thu, 28 Nov 2019 19:25:02 +0700
Message-Id: <cover.1574943677.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.615.g37f5bfbdea
In-Reply-To: <cover.1574867409.git.congdanhqx@gmail.com>
References: <cover.1574867409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gmtime/localtime is considered unsafe in multithread environment.

git was started as single-thread application, but we have some
multi-thread code, right now.

replace all usage of gmtime/localtime by their respective reentrant ones.

On most POSIX systems, we won't notice any differences in performance,
since they implemented gmtime and gmtime_r mostly the same.

On Windows, we may be taxed, since gmtime_r and localtime_r is our compat
functions, because we memcpy from returned data of gmtime/localtime.

To address that, I made patch #3 and included it together with this series.
I'm not sure how much portable it is.


Doan Tran Cong Danh (3):
  date.c: switch to reentrant {gm,local}time_r
  archive-zip.c: switch to reentrant localtime_r
  mingw: use {gm,local}time_s as backend for {gm,local}time_r

 archive-zip.c  | 10 +++++-----
 compat/mingw.c | 12 ++++++------
 date.c         | 18 ++++++++++--------
 3 files changed, 21 insertions(+), 19 deletions(-)

Range-diff against v1:
1:  1e7e08b3c7 < -:  ---------- date.c::datestamp: switch to reentrant localtime_r
2:  130eba77db ! 1:  71de738864 date.c::time_to_tm_local: use reentrant localtime_r(3)
    @@ Metadata
     Author: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    date.c::time_to_tm_local: use reentrant localtime_r(3)
    +    date.c: switch to reentrant {gm,local}time_r
     
    -    Phase out `localtime(3)' in favour of reentrant `localtime_r(3)'
    +    Originally, git was intended to be single-thread executable.
    +    `gmtime(3)' and `localtime(3)' can be used in such codebase
    +    for cleaner code.
    +
    +    Overtime, we're employing multithread in our code base.
    +
    +    Let's phase out `gmtime(3)' and `localtime(3)' in favour of
    +    `gmtime_r(3)' and `localtime_r(3)'.
     
         Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
      ## date.c ##
    -@@ date.c: static struct tm *time_to_tm(timestamp_t time, int tz)
    - 	return gmtime(&t);
    +@@ date.c: static time_t gm_time_t(timestamp_t time, int tz)
    +  * thing, which means that tz -0100 is passed in as the integer -100,
    +  * even though it means "sixty minutes off"
    +  */
    +-static struct tm *time_to_tm(timestamp_t time, int tz)
    ++static struct tm *time_to_tm(timestamp_t time, int tz, struct tm *tm)
    + {
    + 	time_t t = gm_time_t(time, tz);
    +-	return gmtime(&t);
    ++	return gmtime_r(&t, tm);
      }
      
     -static struct tm *time_to_tm_local(timestamp_t time)
    @@ date.c: const char *show_date(timestamp_t time, int tz, const struct date_mode *
     -		tm = time_to_tm_local(time);
     +		tm = time_to_tm_local(time, &tmbuf);
      	else
    - 		tm = time_to_tm(time, tz);
    +-		tm = time_to_tm(time, tz);
    ++		tm = time_to_tm(time, tz, &tmbuf);
      	if (!tm) {
    +-		tm = time_to_tm(0, 0);
    ++		tm = time_to_tm(0, 0, &tmbuf);
    + 		tz = 0;
    + 	}
    + 
    +@@ date.c: void datestamp(struct strbuf *out)
    + {
    + 	time_t now;
    + 	int offset;
    ++	struct tm tm = { 0 };
    + 
    + 	time(&now);
    + 
    +-	offset = tm_to_time_t(localtime(&now)) - now;
    ++	offset = tm_to_time_t(localtime_r(&now, &tm)) - now;
    + 	offset /= 60;
    + 
    + 	date_string(now, offset, out);
3:  ce7fe7bcf3 < -:  ---------- date.c::time_to_tm: use reentrant gmtime_r(3)
4:  f6fd89dfe1 ! 2:  77798f1773 archive-zip: use reentrant localtime_r(3)
    @@ Metadata
     Author: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    archive-zip: use reentrant localtime_r(3)
    +    archive-zip.c: switch to reentrant localtime_r
    +
    +    Originally, git was intended to be single-thread executable.
    +    `localtime(3)' can be used in such codebase for cleaner code.
    +
    +    Overtime, we're employing multithread in our code base.
    +
    +    Let's phase out `gmtime(3)' in favour of `localtime_r(3)'.
    +
    +    Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
      ## archive-zip.c ##
     @@ archive-zip.c: static void write_zip_trailer(const struct object_id *oid)
5:  2c39f9a04f ! 3:  33a67eb377 mingw: use {gm,local}time_s as backend for {gm,local}time_r
    @@ Commit message
         Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
      ## compat/mingw.c ##
    -@@
    - #include "../git-compat-util.h"
    - #include "win32.h"
    - #include <conio.h>
    -+#include <errno.h>
    - #include <wchar.h>
    - #include "../strbuf.h"
    - #include "../run-command.h"
     @@ compat/mingw.c: int pipe(int filedes[2])
      
      struct tm *gmtime_r(const time_t *timep, struct tm *result)
-- 
2.24.0.615.g37f5bfbdea

