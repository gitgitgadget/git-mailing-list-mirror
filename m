From: Lawrence Mitchell <wence@gmx.li>
Subject: [PATCH 1/3] git-blame.el: Do not use goto-line in lisp code
Date: Sun, 10 Jun 2012 12:58:02 +0100
Message-ID: <1339329484-12088-1-git-send-email-wence@gmx.li>
References: <20120610073803.GA29461@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, git@vger.kernel.org, davidk@lysator.liu.se,
	user42@zip.com.au, osv@javad.com
To: =?UTF-8?q?R=C3=BCdiger=20Sonderfeld?= <ruediger@c-plusplus.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 14:35:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdhMb-0000hG-4Q
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 14:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab2FJMfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 08:35:16 -0400
Received: from treacle.ucs.ed.ac.uk ([129.215.16.102]:53124 "EHLO
	treacle.ucs.ed.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2FJMfO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 08:35:14 -0400
Received: from lmtp1.ucs.ed.ac.uk (lmtp1.ucs.ed.ac.uk [129.215.149.64])
	by treacle.ucs.ed.ac.uk (8.13.8/8.13.4) with ESMTP id q5ABwSnb006525;
	Sun, 10 Jun 2012 12:58:30 +0100 (BST)
Received: from localhost.localdomain (cpc11-sgyl30-2-0-cust962.sgyl.cable.virginmedia.com [94.175.87.195])
	(authenticated user=lmitche4 mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id q5ABw4hl029717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 10 Jun 2012 12:58:14 +0100 (BST)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <20120610073803.GA29461@burratino>
X-Edinburgh-Scanned: at treacle.ucs.ed.ac.uk
    with MIMEDefang 2.60, Sophie, Sophos Anti-Virus, Clam AntiVirus
X-Scanned-By: MIMEDefang 2.60 on 129.215.16.102
X-Scanned-By: MIMEDefang 2.52 on 129.215.149.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199596>

=46rom: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>

goto-line is a user-level command, instead use the lisp-level
construct recommended in Emacs documentation.

Signed-off-by: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>
Signed-off-by: Lawrence Mitchell <wence@gmx.li>
---
 contrib/emacs/git-blame.el | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Here we go, all R=C3=BCdiger's changes look sensible, I've split them i=
nto bits though

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 37d797e..5428ff7 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -389,7 +389,8 @@ See also function `git-blame-mode'."
     (set-buffer git-blame-file)
     (let ((inhibit-point-motion-hooks t)
           (inhibit-modification-hooks t))
-      (goto-line start-line)
+      (goto-char (point-min))
+      (forward-line (1- start-line))
       (let* ((start (point))
              (end (progn (forward-line num-lines) (point)))
              (ovl (make-overlay start end))
--=20
1.7.10.2.552.gaa3bb87
