From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 42/48] refs.c: pass NULL as *flags to read_ref_full
Date: Thu, 19 Jun 2014 08:53:24 -0700
Message-ID: <1403193210-6028-43-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxefc-00074w-MI
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957AbaFSPyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:16 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:65219 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758083AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so331875qcz.4
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Etf6EZXoo6Ue+T9ZmJTKMMUFO/NrbW+nLcarfOS6X/o=;
        b=fUBFv7SkV2uo1+GOOAM1pXAr2aVPoVSr4D+GAVbhIriE+MXCDTE97OhXWDV7Rp/4bg
         paF/Zsqsz+ulRs/zDioZm5BjqC4mUZjeyYsQyZkg/vsrXt3UY7lBVUMeYzZACryRix+O
         x2mkK7EA019Yr8Ag9hYPEKdkak7BELzXpttUxBMCykbMXG9Xbds42wg5Wkk9xqgIKiKy
         NWjB///6IfERHcuWHrQ/eiQoAwZf32GwfxjoawOpbU+dovrt5FrSBD+0DGhWC0QDahby
         LN8vqR7bPlDOh2TcCGyoc0XqX11hyRsPNO3aOghRSaoojMbwHJdk6O2bs3EznY3Z4YaJ
         yXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Etf6EZXoo6Ue+T9ZmJTKMMUFO/NrbW+nLcarfOS6X/o=;
        b=AZk9hSfcDId/1WV7iyaehZRw61Xbp3eElR27namnO6/HcIosYbNuDITAnzhD7SDyCq
         tuN4Ys6Sg5iWXN4kP8cz7KcdkfcJE8HRRVwa2f4DN8Boc9c1jGx/9nB0cQN+cV6Cpyo6
         Ysq1/zmcCRH5PT7Av6vqykAVKMSnHR8Mhj1ZEbYZMmxQR1CUszbMxUX8d2rV5Jbwhuzq
         NIQ000PHPuYn+x6llYp0v9F6AhLgOnpuazImoBzkbb4Ya/Wjyw1cNooEpTUp3UnklW93
         yzXlVZJR+W5T7MPnAF21c6V+2IZUg412K9F6bfyocggZ8zO6oUwpOhd15kZYkgoJgCmN
         gcKQ==
X-Gm-Message-State: ALoCoQnXJOGdgMAiftQb1dapbfUwV2HUES0h6ldTaYWVMU1QOe5PsG3lVVnNGwjY6+EPFXOwLlOn
X-Received: by 10.236.150.114 with SMTP id y78mr2525368yhj.7.1403193214611;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si419905yhb.3.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 777BF31C3A6;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 57E3AE11C5; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252132>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3521033..d6467c8 100644
--- a/refs.c
+++ b/refs.c
@@ -2688,7 +2688,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.438.g337c581
