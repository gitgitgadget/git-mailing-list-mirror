From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 37/44] refs.c: pass NULL as *flags to read_ref_full
Date: Thu, 15 May 2014 10:29:52 -0700
Message-ID: <1400174999-26786-38-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVX-0001sq-PE
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbaEORbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:44 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:61722 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so256387pbb.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zOcgpqQAD9tci99+pcl/6mzQum3QNdkvk7WFWUsNNGU=;
        b=prRwuWb/+B1RNBO63zkkbAXtJqXqNxKLzWOS+FvCdgLJLgN0SJdYoQ0kUg1wMLTHDI
         zCEKL7WM4mYeNFUzzBV/dYMyXTUfHEmdeujhTTnux0X6kebFK1VKCYbNhUiLqusyUtlP
         FRngNOGLKl1mbGSVl802VUOX2bPNJjzWGhqa24QXpoWZrvgW1Nbd6dEym8jpbqwIKHua
         7AJQJtWH/IAss6/4uBjMZ+fPRhYmhxzBpl+Hjc/zWKcE3fB0V9v9f2TqGmwSfgQbyzUz
         ojngYawAXtj1pvAq2Dn8AdgBPjl4PykpEq1rYFfWKAogGhQno+b2i0EaVQh5ISFn8C7H
         JAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zOcgpqQAD9tci99+pcl/6mzQum3QNdkvk7WFWUsNNGU=;
        b=eSrjJdMoZwKg0H16W8jON1tVq519kYAMBwDv/x0vyZDtsg5T09R0iewEY/RwU2Ki/t
         f0choY2v9UiNOaQnVJukHKW+l2IUx2NoeUXbop+oUZ/4jBcqgU3SEfn8a38kIjNUm9sA
         oR3uEXP7g912X3kwuyR/0g2M+q9/GSrcve01kvwWAe0jehlKro2xc6MSm/a2HRFVealu
         0jY7zaspSqg9XD+Ip47aFgKNM0USgasaNx5CACs7Am8suuyR+J1zjExRyezWetwnaYNr
         FpgkYYKt1a+64khnt6Z+38YjTNZguGAmyaJLKyIpQN4jfk82EPliZtsPehQ5gl5j1cIa
         qr4w==
X-Gm-Message-State: ALoCoQlrF83bSKtWx1iXYvnZ9+OUH+YXJ0Guttlbwri9iE0ruWKEzTFxFQ7GM24r91d6FjhXYcMb
X-Received: by 10.66.102.36 with SMTP id fl4mr5430726pab.20.1400175007534;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si273455yhq.3.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 57CDA31C1E7;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 34D65E1129; Thu, 15 May 2014 10:30:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249146>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1977640..8105ee6 100644
--- a/refs.c
+++ b/refs.c
@@ -2612,7 +2612,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.rc3.477.g0f8edf7
