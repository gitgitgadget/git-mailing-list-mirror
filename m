From: "Duncan Mak" <duncan@a-chinaman.com>
Subject: Re: [PATCH] fix vc git
Date: Thu, 21 Dec 2006 06:59:37 -0500
Message-ID: <8e745ecf0612210359j3f895521r1fff497a512253d3@mail.gmail.com>
References: <8e745ecf0612210325m72a569d7k370dd5953ccf6f27@mail.gmail.com>
	 <emdr6v$9ma$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 12:59:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxMaM-0005Y4-8n
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 12:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWLUL7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 06:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWLUL7j
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 06:59:39 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:35326 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030188AbWLUL7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 06:59:38 -0500
Received: by wr-out-0506.google.com with SMTP id i11so1076348wra
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 03:59:38 -0800 (PST)
Received: by 10.78.185.7 with SMTP id i7mr521116huf.1166702377460;
        Thu, 21 Dec 2006 03:59:37 -0800 (PST)
Received: by 10.78.172.10 with HTTP; Thu, 21 Dec 2006 03:59:37 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <emdr6v$9ma$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35060>

Fix vc-git.el to not cd into a non-existent directory.

---

 contrib/emacs/vc-git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

base 54851157acf707eb953eada2a84830897dde5c1d
last c2af9380cd8ec0170b9b251c0ee8a5efa63bac87
diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 8b6361922fd6e6a2fcd9acb20fd54f5b645b36f0..b3c8040dd766c9b15e1d0a9247b6343fdf0a8caf
100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -58,7 +58,7 @@
   (with-temp-buffer
     (let* ((dir (file-name-directory file))
            (name (file-relative-name file dir)))
-      (when dir (cd dir))
+      (when (file-exists-p dir) (cd dir))
       (and (ignore-errors (eq 0 (call-process "git" nil '(t nil) nil
"ls-files" "-c" "-z" "--" name)))
            (let ((str (buffer-string)))
              (and (> (length str) (length name))
-- 
1.4.4.1
