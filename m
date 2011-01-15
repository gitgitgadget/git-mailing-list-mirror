From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] date: Expose the time_to_tm function
Date: Sat, 15 Jan 2011 12:21:10 +0530
Message-ID: <1295074272-19559-2-git-send-email-artagnon@gmail.com>
References: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 15 07:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdzyU-0006Ei-Bh
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 07:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972Ab1AOGui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 01:50:38 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56481 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1AOGuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 01:50:37 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so3205802iwn.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 22:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QjA1ukRL29p1Dw2bm/wMknfokEJcRgbkF4lm4qTFd5U=;
        b=Vjs+i6QI/n3ahgVKMBg/K86sY9Gj9/cr5jJO7rFNoGTT3z1AmgEKFSOoJ/1SCMeugY
         tKfQ31Y8nqeofr4+0FB8Qk/GZZ2rD41H9uMlOKqmhi30MkRnln7PsG08v7t6+vDSafGg
         iPtzge00C2XBf2CXHv2ue5o/EnSnR8ij5aoFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=poR+ehryyShn3YibY05XbUgfC6/9KdF6bxCQL6vvaBrr03Ut7T9jT23tYrlE77RhZX
         W7woEL46Z9rvwLqEdadnMGox/xYGXQJ3IMLLNGmEpgp42Jjqo1yFF9G/j3yunBCiB75J
         ua94x/vNh46Rse/gemFDVUs/+ZrYMJulxd7ro=
Received: by 10.42.180.131 with SMTP id bu3mr1789431icb.366.1295074236581;
        Fri, 14 Jan 2011 22:50:36 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id k38sm1484334ick.9.2011.01.14.22.50.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 22:50:35 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165139>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 cache.h |    1 +
 date.c  |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index d83d68c..95fea31 100644
--- a/cache.h
+++ b/cache.h
@@ -816,6 +816,7 @@ enum date_mode {
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
