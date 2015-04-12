From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 4/7] credential-store.c: replace home_config_paths() with xdg_config_home()
Date: Sun, 12 Apr 2015 15:46:09 +0800
Message-ID: <1428824772-8736-4-git-send-email-pyokagan@gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 09:47:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhCbv-0004qZ-TQ
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 09:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbbDLHrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 03:47:14 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35690 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbDLHrK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 03:47:10 -0400
Received: by pddn5 with SMTP id n5so71682636pdd.2
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RxMoVlUlYsiuFsz1gEYsmjKNP5Cs1pTKXJYscbgxeV0=;
        b=lnAvMjDaAclVDBZUaDNwdRjr/ixHe5YAnryk39lQecagW58F2KIekPHBPn2nE8RTiv
         hELFt7eRFaMrjVFTUGsclq8Bb2MgDRJ6Aihi1Jk8Y+XpGxOVsiJOpH4SDRG0u7Lu71YG
         fVTPlDq7+giFjiot+cQPysNYTBqgjE6oxqV3lg8GOXUjwKHbz2WLo+LX75LIc9h0beL5
         Am0EzBMKVQ+xmIJXFlanyLthtlbfc5HJlyBVVl6HpTq9pcqPKbs1/w500L6IPbk9ltlN
         5VcRmio9tA+aRDqYvlFwmbmKE7JK8XF8fyhOOuDz/ATnFpA4nj0DtByHNU7uvx0BY8AE
         tTsQ==
X-Received: by 10.70.37.144 with SMTP id y16mr16433428pdj.86.1428824830423;
        Sun, 12 Apr 2015 00:47:10 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id ei17sm3783153pac.20.2015.04.12.00.47.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Apr 2015 00:47:09 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267045>

Since only the xdg credentials file path is required, and
home_config_paths() is unable to construct the path ~/.git-credentials,
simplify the code by replacing home_config_paths() with
xdg_config_home().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 credential-store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential-store.c b/credential-store.c
index 8b22251..f692509 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -170,7 +170,7 @@ int main(int argc, char **argv)
 	} else {
 		if ((file = expand_user_path("~/.git-credentials")))
 			string_list_append_nodup(&fns, file);
-		home_config_paths(NULL, &file, "credentials");
+		file = xdg_config_home("credentials");
 		if (file)
 			string_list_append_nodup(&fns, file);
 	}
-- 
2.1.4
