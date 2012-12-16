From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH] git-completion.bash: update obsolete code.
Date: Sun, 16 Dec 2012 22:50:02 +0100
Message-ID: <1355694602-8771-1-git-send-email-manlio.perillo@gmail.com>
Cc: Manlio Perillo <manlio.perillo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 22:50:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkM6b-0007vd-Nn
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 22:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775Ab2LPVuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 16:50:23 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47353 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab2LPVuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 16:50:23 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2423731bkw.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 13:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=hAaxdch1G+R7hAqXYmqQ5cq/hb4wxBPrBubI+swUTeQ=;
        b=mcnzdIUt28M5pHq3hIL8Y53Mtu+pFFKrD/zVFp+2YWQMh5FYy2xeMOeLZBOZPJEiZI
         hPX89v2z3LSLTDqY6SLpLDUhLp2HAg+xy2+y0gbAExkhzicW8gaISRWdTRqj9NTxKAht
         upsgZMucJaL/hximB80PWaJo8wWueLOLc1L8eFo5HDusCkHwyAD1IzclpQGQ+mO/0+hM
         Tb8Cdlj7VMBGmB8b1VZKfDh4c12ZQzYG3aCfDgUZDNqxqqemtoCSQQ3Kq8Pxxz5H6794
         L88t9MHB15zgEr9IwG3buY3MvucWJ7qmNlYf0qj+EmXduEmKJWCys1q3WslHH+qFogPY
         OvTA==
Received: by 10.204.8.143 with SMTP id h15mr5085303bkh.115.1355694621946;
        Sun, 16 Dec 2012 13:50:21 -0800 (PST)
Received: from synapsis.synapsis ([151.70.213.162])
        by mx.google.com with ESMTPS id d16sm8002475bkw.2.2012.12.16.13.50.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 13:50:20 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.18.g9db0d25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211614>

The git-completion.bash script was using the git ls-tree command
without the --name-only option, with a sed filter to parse path names;
use the --name-only option, instead.

Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
---
 contrib/completion/git-completion.bash | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b77eb1..85d9051 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -397,20 +397,7 @@ __git_complete_revlist_file ()
 		*)   pfx="$ref:$pfx" ;;
 		esac
 
-		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
-				| sed '/^100... blob /{
-				           s,^.*	,,
-				           s,$, ,
-				       }
-				       /^120000 blob /{
-				           s,^.*	,,
-				           s,$, ,
-				       }
-				       /^040000 tree /{
-				           s,^.*	,,
-				           s,$,/,
-				       }
-				       s/^.*	//')" \
+		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree --name-only "$ls")" \
 			"$pfx" "$cur_" ""
 		;;
 	*...*)
-- 
1.8.1.rc1.18.g9db0d25
