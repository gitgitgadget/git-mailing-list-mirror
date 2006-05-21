From: Gang Chen <goncha.ml@gmail.com>
Subject: [PATCH] compress output of `cd' when installing templates
Date: Sun, 21 May 2006 23:41:02 +0800
Message-ID: <83mzdbjshd.fsf@skypiea.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 21 17:41:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhq3Q-0006Sd-RX
	for gcvg-git@gmane.org; Sun, 21 May 2006 17:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWEUPlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 11:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWEUPlL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 11:41:11 -0400
Received: from [220.234.92.111] ([220.234.92.111]:64652 "EHLO skypiea.yi.org")
	by vger.kernel.org with ESMTP id S964888AbWEUPlK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 11:41:10 -0400
Received: from skypiea.yi.org (localhost [127.0.0.1])
	by skypiea.yi.org (8.13.6/8.13.6) with ESMTP id k4LFf8Qn008169
	for <git@vger.kernel.org>; Sun, 21 May 2006 23:41:08 +0800
Received: (from gang@localhost)
	by skypiea.yi.org (8.13.6/8.13.6/Submit) id k4LFf7so008168;
	Sun, 21 May 2006 23:41:07 +0800
To: GIT <git@vger.kernel.org>
Replay-To: Gang Chen <goncha.ml@gmail.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20452>

When CDPATH is set in Bash, `cd' writes new working directory to
stdout, which corrupts output of `tar cf - .'.

Signed-off-by: Gang Chen <goncha.ml@gmail.com>

---

 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/Makefile b/templates/Makefile
index 8f7f4fe..cb67489 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -44,5 +44,5 @@ clean:
 
 install: all
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(template_dir))
-	(cd blt && $(TAR) cf - .) | \
+	(cd blt > /dev/null && $(TAR) cf - .) | \
 	(cd $(call shellquote,$(DESTDIR)$(template_dir)) && $(TAR) xf -)

-- 
If it makes you happy, it can't be that bad.
