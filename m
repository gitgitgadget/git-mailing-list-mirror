From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 14/44] refs.c: move is_branch to the common code
Date: Mon, 12 Oct 2015 17:51:34 -0400
Message-ID: <1444686725-27660-15-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:54:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2t-00064R-Sx
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbbJLVyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:54:10 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35403 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbJLVw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:28 -0400
Received: by qgt47 with SMTP id 47so129530491qgt.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rd7fRamKdqKcn3hLEph/fXcRs/eWAzqWmAS1Wq2xHxM=;
        b=gIB7scq3rVgtgYFx9IrmVoR2eE9Y8Zer5INaPtp5h08ExHMksJaCCKTVORmydgAYtR
         BvJ4H0NSshhYqifubfhglDAhCm6ajQKj2GOyJ62dncbvFUn/U8lLlwsJkrbB3P3ZjOGc
         6yGgkwB5bIcUmdby9nCLKiAdlL37joRtRQbJJ7BeIZik1UASDaee6HvFJMlzfxWORh+b
         RLJpQdKWxmvZlIJAgfTfqyBK8Da8aVSBMz+Cd3dQSJwGre3uU+JE8nm0+ijkAjnp1vG5
         JiWSHUCTCZCnJ5VHkLnH1aa6LzOnZEIveYe8o7Bb90Iv+LBP7vr8d1kOCl2faIpr3rBc
         vdrg==
X-Gm-Message-State: ALoCoQnCj5uy8c+kUtj6xiko5VsmHgWAYYU1Adb7XxzSkmw+R5ttseN8+UHZe6iYc/mtYWB8vwpt
X-Received: by 10.140.43.164 with SMTP id e33mr35142784qga.62.1444686747672;
        Mon, 12 Oct 2015 14:52:27 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279458>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 5 -----
 refs.c          | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 9c57dcc..1214d9e 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2957,11 +2957,6 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	return ret;
 }
 
-int is_branch(const char *refname)
-{
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
-}
-
 /*
  * Write sha1 into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and
diff --git a/refs.c b/refs.c
index e9cc2d4..bc8750c 100644
--- a/refs.c
+++ b/refs.c
@@ -767,3 +767,8 @@ int check_refname_format(const char *refname, int flags)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
+
+int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+}
-- 
2.4.2.644.g97b850b-twtrsrc
