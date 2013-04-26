From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 8/9] remote-bzr: strip extra newline
Date: Thu, 25 Apr 2013 19:08:21 -0500
Message-ID: <1366934902-18704-9-git-send-email-felipe.contreras@gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWEw-0003zV-GX
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932814Ab3DZAKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:10:05 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:63197 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758313Ab3DZAKC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:10:02 -0400
Received: by mail-ob0-f179.google.com with SMTP id oi10so2985009obb.38
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=iiVH6vglyMpueDEu2LOUTssUG3BZXqJYZzrnZFc/uRg=;
        b=VZSu5M360Qbl8xHpojHeDliaY99i79WYhoQ9k2rpfjqfTGlUm8yJ6oak37m8DxMmS1
         nYV8OGhTokliTFgbbaRJ+EVhyhcyLkBuAGngo5poDCvy0ExXqJe89uJxNV6LbOGtjrOh
         0yxVdGcGfbAVCRA5wnrJDfAlzGFwQ7bou2V8KahPpDz1mqvkTkO/GPYUElkwDINezolZ
         HIjleez8yDfCp++/b25DlwdBqUFCLS/YPp31qM/lPkIghhqf/20I21/8fEK4wDRZ14IX
         GbRNjKG8IJOMCwX0YLdHAyIBF8XecltyfveWzWtlol6yVuukOZehhWBq3M3MzFUh7SgK
         IZMQ==
X-Received: by 10.60.34.232 with SMTP id c8mr4627676oej.45.1366935001706;
        Thu, 25 Apr 2013 17:10:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ka6sm5650083obb.3.2013.04.25.17.09.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:10:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222477>

It's added by fast-export, the user didn't type it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 8617e25..9f56297 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -549,6 +549,10 @@ def parse_commit(parser):
         parents.append(parser.get_mark())
         parser.next()
 
+    # fast-export adds an extra newline
+    if data[-1] == '\n':
+        data = data[:-1]
+
     files = {}
 
     for line in parser:
-- 
1.8.2.1.884.g3532a8d
