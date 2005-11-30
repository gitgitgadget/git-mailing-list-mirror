From: Tommi Virtanen <tv@inoi.fi>
Subject: [PATCH] Do not attempt to access literal dirname "GIT_OBJECT_DIRECTORY".
Date: Wed, 30 Nov 2005 17:37:10 +0200
Message-ID: <11333650304031-git-send-email-tv@inoi.fi>
Reply-To: Tommi Virtanen <tv@inoi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@inoi.fi>
X-From: git-owner@vger.kernel.org Wed Nov 30 17:29:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhU1J-0007rk-VK
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 16:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVK3PhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 10:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVK3PhR
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 10:37:17 -0500
Received: from i1.inoi.fi ([194.100.97.46]:35239 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S1751374AbVK3PhQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 10:37:16 -0500
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 7C2F612694F;
	Wed, 30 Nov 2005 17:37:20 +0200 (EET)
Received: from pooch.inoi.fi (GMMDXXVII.dsl.saunalahti.fi [85.76.242.28])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 4A96D12694E;
	Wed, 30 Nov 2005 17:37:20 +0200 (EET)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id C08CCBA068;
	Wed, 30 Nov 2005 17:37:10 +0200 (EET)
In-Reply-To: 1133359173.4117.68.camel@baythorne.infradead.org
X-Mailer: git-send-email
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13004>

Dereference the environment variable before using it.

Signed-off-by: Tommi Virtanen <tv@inoi.fi>

---

 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: fa10b18d1546129bf73713b64fbc4a8feae3487f
a4a0e60f920f906284f4f6a4d3b4ffb043834bc7
diff --git a/setup.c b/setup.c
index cc44a72..3286a56 100644
--- a/setup.c
+++ b/setup.c
@@ -116,7 +116,7 @@ static const char *setup_git_directory_1
 		if (validate_symref(path))
 			goto bad_dir_environ;
 		if (getenv(DB_ENVIRONMENT)) {
-			if (access(DB_ENVIRONMENT, X_OK))
+			if (access(getenv(DB_ENVIRONMENT), X_OK))
 				goto bad_dir_environ;
 		}
 		else {
---
0.99.9.GIT
