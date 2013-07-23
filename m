From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/5] t4211: demonstrate crash when first -L encountered is empty range
Date: Tue, 23 Jul 2013 10:28:07 -0400
Message-ID: <1374589688-27751-5-git-send-email-sunshine@sunshineco.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 16:28:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1da9-00053l-Rh
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 16:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609Ab3GWO2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 10:28:45 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:56240 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab3GWO2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 10:28:44 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so1463167oag.6
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=H0HFLZBCo6ZLbk/kSUuG/8No66ggfirxTB5zUr3lmLc=;
        b=tKq0bOH0AAtozUlkPsLLrgMhx22coI3XrsfSSE8IMJmiSmyvxOsAqTwix888hJ6t66
         2slqi+igevye75EOpqu27l4Sm9qjjAdQRe6ei9yXDg18u9s3MZ0qYPfZiFXa7NW9FFQZ
         nSJbrop6+abFScKjdH0pIubVpNrrNcuUnrmJ2HZglc1fRyC2iQLQ6/ET6r1y2j+hzNjb
         167n9dbfTbbetcM3T69NFbXCbA7PURxv8f3DKtQ5Jmeke6sVFO0jxqt+pLJctZrvGCF9
         mTmnz8AxuazEd+FGlJ9rhaPp2phPdHb4aWa4K68sB123kDKvWb2fiJUpkR9JM/i0zbhJ
         sshA==
X-Received: by 10.182.205.138 with SMTP id lg10mr24966348obc.6.1374589723458;
        Tue, 23 Jul 2013 07:28:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id rs4sm40422546obc.10.2013.07.23.07.28.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 07:28:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231038>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4211-line-log.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 12814c0..7616365 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -72,4 +72,9 @@ test_expect_success '-L {empty-range} (any -L)' '
 	git log -L1,1:b.c -L$n:b.c
 '
 
+test_expect_failure '-L {empty-range} (first -L)' '
+	n=$(expr $(cat b.c | wc -l) + 1) &&
+	git log -L$n:b.c
+'
+
 test_done
-- 
1.8.3.4.1120.gc240c48
