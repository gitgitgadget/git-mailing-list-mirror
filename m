From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 7/9] remote-bzr: tell bazaar to be quiet
Date: Thu, 25 Apr 2013 19:08:20 -0500
Message-ID: <1366934902-18704-8-git-send-email-felipe.contreras@gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:10:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWEq-0003vw-Uk
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758304Ab3DZAKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:10:01 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50889 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477Ab3DZAJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:09:59 -0400
Received: by mail-ob0-f177.google.com with SMTP id ef5so3006838obb.22
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=GGxWx3NbYLfUtH/xy9Xa42CWSav2jicV5aJAq9XeRTs=;
        b=zp8T4HhczWXdpLn5GKMzbewBcAuRKj3aIvYohWjGjVt9FkJn8bSXDDa8hTHFsFkPlG
         QW2FrX/qCbjMEY4KlIfcDTwfjLhX5S2LjANGO9a9cBn9SaXUvfydttXGrK79H7l1Jafi
         lFr+Zvz75y7hkCn36pRud3RDDSb6bNsyPoIVjJ4Ljcq9DDFrLuRL+qaEiZqLecSN6lYr
         jasoCKaKPEAuxb7HExRZQhlJlciKPTzWlNd7yiYGUtRNEcgusMYvfH5GLtSFT5NooPVG
         xA/A+92tZFcd0w9gsNbv+mipQ/bDujCDITVZvFff9wxGXj3lMBMfEW+07vQpDmlbURhG
         Pfaw==
X-Received: by 10.182.113.164 with SMTP id iz4mr7603950obb.87.1366934998699;
        Thu, 25 Apr 2013 17:09:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jv10sm5890025oeb.3.2013.04.25.17.09.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:09:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222476>

Otherwise we get notification, progress bars, and what not.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index dda2932..8617e25 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -26,6 +26,7 @@ bzrlib.plugin.load_plugins()
 import bzrlib.generate_ids
 import bzrlib.transport
 import bzrlib.errors
+import bzrlib.ui
 
 import sys
 import os
@@ -755,6 +756,8 @@ def main(args):
     if not os.path.exists(dirname):
         os.makedirs(dirname)
 
+    bzrlib.ui.ui_factory.be_quiet(True)
+
     repo = get_repo(url, alias)
 
     marks_path = os.path.join(dirname, 'marks-int')
-- 
1.8.2.1.884.g3532a8d
