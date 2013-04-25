From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 8/9] remote-bzr: tell bazaar to be quiet
Date: Thu, 25 Apr 2013 06:20:48 -0500
Message-ID: <1366888849-19607-9-git-send-email-felipe.contreras@gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:23:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKGY-0004yr-J9
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758185Ab3DYLW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:22:56 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:52871 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067Ab3DYLWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:22:55 -0400
Received: by mail-ob0-f176.google.com with SMTP id wd20so2380183obb.21
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=t8o6/aE0zU36Dkc2hIvUGHOiSJbLTvCz7/ujbb2AsJY=;
        b=QgUSbb/kAWya/dSFLTK+lGwbeRRRqQofSEaTJIEYjUjRK8geoyDOCY18MhGqXbHmbC
         xxh73r3UVaUkdqs9F/Dh4+1l0hU4ANexd/sxNeMOr4t5EdvzmBz7ZcA1xBGpY2zd3b+l
         n5oEUSks2HVd1YBgyOd2l4qutbQgo5GnTbj3xwGxfdT7+tYxu83RwJj7BFmRhudcTihY
         BjMH5MtW6tDbT2XbwnSsEj696kGl1ZWam/rDd1MZBbxfL4RisP8Qq4O1MQ/59YAgqs9w
         D5V9HOqwhYocjSZuke4tASJFlVxUvIy66eq7utTxiuMUy+tbnLFGouvyuPAhl4zQpW8Y
         1FOA==
X-Received: by 10.182.38.201 with SMTP id i9mr8486327obk.55.1366888974913;
        Thu, 25 Apr 2013 04:22:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id it9sm3014566obb.6.2013.04.25.04.22.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:22:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222376>

Otherwise we get notification, progress bars, and what not.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 3d3b1c1..19668a9 100755
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
1.8.2.1
