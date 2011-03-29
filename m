From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] date: Expose the time_to_tm function
Date: Tue, 29 Mar 2011 23:43:08 +0530
Message-ID: <1301422392-21177-2-git-send-email-artagnon@gmail.com>
References: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Cc: Peter Baumann <waste.manager@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:14:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dRO-0000U5-Pc
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab1C2SOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:14:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48131 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1C2SOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:14:43 -0400
Received: by yxs7 with SMTP id 7so189664yxs.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=VqMYMNINQz/zEKJcX2PIKXdbE9jvwXGj66zxHdJW24c=;
        b=tSb+ppwHaBXE36RJnPjUOd9MqWtU1amiIls6Xn4ikcRrwYy1aKHpxDHp7/kV9ZP1/H
         tP8XNy17sIMinY3mLVffU4kGjodix8fwlhbfwLYHAuZy3e/Hwe1YHFZLkNUnUVQuix2T
         AkRFai97P+0GgSqPWqXNB4X0dw9yjW5CwM9gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RLL3nsaGUo+4EfJEqTSHJz9VECdcvReIFTZjCkjb/c6wAIvM/g+il47Raky4vdotWA
         ZnGbD1jGEJjhAqQd7wRpRsJSAP6gfi5XZGEdGfnhr8nMfXAxNH53hvSjH7e5NvuOXDGe
         LeHyvosQcrgbKzLNjGJz1+GhByzkcodvpOzIM=
Received: by 10.151.62.14 with SMTP id p14mr448376ybk.30.1301422482538;
        Tue, 29 Mar 2011 11:14:42 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id o2sm1971669ybn.21.2011.03.29.11.14.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 11:14:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170291>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 cache.h |    1 +
 date.c  |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index f765cf5..76a14c6 100644
--- a/cache.h
+++ b/cache.h
@@ -834,6 +834,7 @@ enum date_mode {
 	DATE_RAW
 };
 
+struct tm *time_to_tm(unsigned long time, int tz);
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 const char *show_date_relative(unsigned long time, int tz,
 			       const struct timeval *now,
diff --git a/date.c b/date.c
index 00f9eb5..e601a50 100644
--- a/date.c
+++ b/date.c
@@ -54,7 +54,7 @@ static time_t gm_time_t(unsigned long time, int tz)
  * thing, which means that tz -0100 is passed in as the integer -100,
  * even though it means "sixty minutes off"
  */
-static struct tm *time_to_tm(unsigned long time, int tz)
+struct tm *time_to_tm(unsigned long time, int tz)
 {
 	time_t t = gm_time_t(time, tz);
 	return gmtime(&t);
-- 
1.7.4.rc1.7.g2cf08.dirty
