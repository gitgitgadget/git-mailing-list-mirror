From: "Duncan Mak" <duncan@a-chinaman.com>
Subject: [PATCH] fix vc git
Date: Thu, 21 Dec 2006 06:25:54 -0500
Message-ID: <8e745ecf0612210325m72a569d7k370dd5953ccf6f27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 12:26:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxM3j-0007V3-Hc
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 12:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWLULZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 06:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWLULZ4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 06:25:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:40402 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964838AbWLULZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 06:25:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2597105uga
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 03:25:54 -0800 (PST)
Received: by 10.78.164.13 with SMTP id m13mr421994hue.1166700354251;
        Thu, 21 Dec 2006 03:25:54 -0800 (PST)
Received: by 10.78.172.10 with HTTP; Thu, 21 Dec 2006 03:25:54 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35052>

Fix vc-git.el to not cd into a non-existent directory.

---

 contrib/emacs/vc-git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

base 54851157acf707eb953eada2a84830897dde5c1d
last 9172c26ece749fc4289eeb89ef45c35936c5a869
diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 8b6361922fd6e6a2fcd9acb20fd54f5b645b36f0..d3ba93325255aea3dc52187dd703d7a8
63cd6e5d 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -58,7 +58,7 @@
   (with-temp-buffer
     (let* ((dir (file-name-directory file))
            (name (file-relative-name file dir)))
-      (when dir (cd dir))
+      (if (file-exists-p dir) (cd dir))
       (and (ignore-errors (eq 0 (call-process "git" nil '(t nil) nil "ls-files"
 "-c" "-z" "--" name)))
            (let ((str (buffer-string)))
              (and (> (length str) (length name))
-- 
1.4.4.1
