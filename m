From: Guanglin Xu <mzguanglin@gmail.com>
Subject: [PATCH v3] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon,  3 Mar 2014 10:24:55 +0800
Message-ID: <1393813495-9079-1-git-send-email-mzguanglin@gmail.com>
Content-Type: text/plain; charset="utf-8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 03:25:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKIZf-000506-Np
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 03:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbaCCCZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 21:25:12 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:50538 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbaCCCZL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 21:25:11 -0500
Received: by mail-pd0-f175.google.com with SMTP id x10so3085987pdj.20
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 18:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:content-type;
        bh=bfrbBHgX8zcErOFqxXjY8ieLfhu3kVd3LWvRsAhAzOg=;
        b=yx36PCq8tDLNewx9uMvhdGGIhNTHu6IIy1Bs0Pi3zRAQ7AZx4xs9S82IwSsuIzo1mS
         U/0aIcrgXFdusTxKW6SLPA//MejanPsSvpD2mWka9nmlm8KCkjmktfNcBk02NCBrEY2Q
         dfPjZ6pHAzCA0NqdGYkaNzVLVILzzvdJtXVc7leQe+Kgev6EWzsuwXCmcvWFbputnm+a
         T/BIcXc0U2hKmxSGMUui+6NmmhX3+DrhA1lCCFPGdLXxH42JiInwSjJq/CxPY33qnc88
         3BQLvhb6y5/iYzw72i3vuNLhHjxNIZ5abD7GmOAte0jpVedGkdRTkFH2C4Cjn3PdMpLr
         73ig==
X-Received: by 10.66.218.234 with SMTP id pj10mr292775pac.156.1393813510918;
        Sun, 02 Mar 2014 18:25:10 -0800 (PST)
Received: from localhost.localdomain ([113.107.25.71])
        by mx.google.com with ESMTPSA id g6sm73926781pat.2.2014.03.02.18.25.08
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Mar 2014 18:25:10 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243173>

to avoid a magic code of 11.

Helped-by: Eric Sunshine <sunsh...@sunshineco.com>
Helped-by: Jacopo Notarstefano <jaco...@gmail.com>
Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
---

This is an implementation of the idea#2 of GSoC 2014 microproject.

 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 723a36b..3e2551e 100644
--- a/branch.c
+++ b/branch.c
@@ -49,7 +49,7 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
-	const char *shortname = remote + 11;
+	const char *shortname = skip_prefix(remote ,"refs/heads/");
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
-- 
1.9.0
