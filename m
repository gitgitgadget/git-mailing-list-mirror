From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] date: Expose the time_to_tm function
Date: Wed, 19 Jan 2011 11:14:55 +0530
Message-ID: <1295415899-1192-2-git-send-email-artagnon@gmail.com>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 06:44:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfQqW-0001OM-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 06:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab1ASFoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 00:44:18 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46341 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1ASFoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 00:44:17 -0500
Received: by ywl5 with SMTP id 5so127820ywl.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 21:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QjA1ukRL29p1Dw2bm/wMknfokEJcRgbkF4lm4qTFd5U=;
        b=KV9cm1rE9LxbfpTgrPCnY6yfmDADP8oATi6YRw12EFlF6FNc4njHVPIcY9s2DbJ5WF
         utnYywrg1UYY2PC//fZbK/8Zzj5WLv0ENUvFh87ng0sO+pfK0gQg2nJojqykQYNMxKuz
         Fz+cSzSatysbr9w/3uQrpkN8IWM2t0WLZ1ixA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FXd/kL/zooKtpyYLqhdIRyJe+twOViSkK+CHr/iGO2G1uqvWqjaMKQiZx+0JGS59D9
         byfeW37tzk1FxVhAmqHT9bmrywZ/CAleINDUsEdOlR661oBadDnKqYENRDFLITAcB5ku
         Ily+cscBlJCZA4pF4U6eT0o3uAmDUHFHIaYOo=
Received: by 10.90.25.19 with SMTP id 19mr380602agy.161.1295415856550;
        Tue, 18 Jan 2011 21:44:16 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d15sm7968646ana.35.2011.01.18.21.44.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 21:44:15 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165238>

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
