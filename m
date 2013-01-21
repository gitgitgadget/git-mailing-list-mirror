From: Barry Wardell <barry.wardell@gmail.com>
Subject: [PATCH 1/2] git-svn: Add test for git-svn repositories with a gitdir link
Date: Mon, 21 Jan 2013 01:22:01 +0000
Message-ID: <1358731322-44600-2-git-send-email-barry.wardell@gmail.com>
References: <20120308005103.GA27398@dcvr.yhbt.net>
 <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
Cc: Barry Wardell <barry.wardell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 02:23:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx66R-0004QB-6I
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 02:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab3AUBWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 20:22:49 -0500
Received: from mail-we0-f170.google.com ([74.125.82.170]:44757 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab3AUBWs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 20:22:48 -0500
Received: by mail-we0-f170.google.com with SMTP id r1so1549225wey.1
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 17:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=JsiA9hY0IXIqo1KTVlRzoLkp/b8UUOWxO5mjVL0XpIw=;
        b=fDxOMQPLOW4jGma3+66L6bi8Z5esSfZVFrcpWy1+cLM2gKjuVwzDmNpYYeY5DZuCS8
         FgGqZZVEcnM1GRBAeiBuBzCW0BqYcnKOOw4Z6Ur7HHo9Py6B3q8QCnKqWfYC+nr3Ne5E
         fL49l79orKE+YwCM/aU94tEkqqFG5c9HvfQne+j4HPDUBAF5sNk+3UJ2Dihw050DuHK+
         0Fkf1bm43txOmpr/oV6gBrxReYrUmwwY4oBD2haOvVM2XxONm3c2GlCEVYAxBv8xQj0a
         HL+j4zSccvkbTpjzpJpRvvhuPWNqgMNhkVWsUvoDnR+ml5KzfWm3Rb2/czzqotuQhJHB
         1dUg==
X-Received: by 10.180.85.103 with SMTP id g7mr12794336wiz.29.1358731367643;
        Sun, 20 Jan 2013 17:22:47 -0800 (PST)
Received: from localhost.localdomain (87-198-121-119.ptr.magnet.ie. [87.198.121.119])
        by mx.google.com with ESMTPS id hu8sm14717231wib.6.2013.01.20.17.22.46
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 17:22:46 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214064>

Signed-off-by: Barry Wardell <barry.wardell@gmail.com>
---
 t/t9100-git-svn-basic.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 749b75e..4fea8d9 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -306,5 +306,13 @@ test_expect_success 'git-svn works in a bare repository' '
 	git svn fetch ) &&
 	rm -rf bare-repo
 	'
+test_expect_success 'git-svn works in in a repository with a gitdir: link' '
+	mkdir worktree gitdir &&
+	( cd worktree &&
+	git svn init "$svnrepo" &&
+	git init --separate-git-dir ../gitdir &&
+	git svn fetch ) &&
+	rm -rf worktree gitdir
+	'
 
 test_done
-- 
1.8.0
