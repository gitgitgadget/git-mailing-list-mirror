From: Andrej Manduch <amanduch@gmail.com>
Subject: [PATCH] git-svn: doublecheck if really file or dir
Date: Fri, 18 Jul 2014 06:05:04 +0200
Message-ID: <1405656304-30926-1-git-send-email-amanduch@gmail.com>
Cc: Andrej Manduch <amanduch@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 06:05:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7zQ6-0003Pe-BC
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 06:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaGREFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 00:05:12 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:42844 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaGREFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 00:05:10 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so2930037wgh.5
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 21:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+YH/KqaglbftdmEh6gp+dOsWNP9y1K2sLmUg1FSmdZ4=;
        b=aGxA1+VsyM7Z+DgmwvpgfevxjRMob27cMdGmXdgBplIzgezKu6Zmh5hUU9UxoyE6Ju
         oOKQMKUDyTdhBnMcIgW6Kf3DeDXFeSOZw1qzhgBP6XA8YFZW/aEVDpPhp+A/Iv+aL5C4
         0AaRgkwRGXojqTfcTRHHmKyiJsec8Wv9ZpzspPzTOgf4dMUKO9f2CoFdekzxIWbVoxMH
         gjXSIMljwKHZrZU2XXO+ZVaGnVKjSy2c3O6b+jGdKSofadekfmxQpLbVTZPFC5iWhRCg
         CxS8oQLKuvlrCXJPy9jl+EIB3ZQA/vuHWmNUOQmQFF7JoplziiW//bSVOeXdOMdwJC3i
         W4pQ==
X-Received: by 10.194.58.180 with SMTP id s20mr2129790wjq.119.1405656309159;
        Thu, 17 Jul 2014 21:05:09 -0700 (PDT)
Received: from localhost.localdomain ([80.242.44.116])
        by mx.google.com with ESMTPSA id es1sm1915120wib.16.2014.07.17.21.05.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jul 2014 21:05:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253792>

* this fixes 'git svn info `pwd`' buggy behaviour

Signed-off-by: Andrej Manduch <amanduch@gmail.com>
---
 git-svn.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0a32372..c3d893e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2029,7 +2029,7 @@ sub find_file_type_and_diff_status {
 	my $mode = (split(' ', $ls_tree))[0] || "";
 
 	return ("link", $diff_status) if $mode eq "120000";
-	return ("dir", $diff_status) if $mode eq "040000";
+	return ("dir", $diff_status) if $mode eq "040000" od -d $path;
 	return ("file", $diff_status);
 }
 
-- 
2.0.0.GIT
