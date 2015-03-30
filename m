From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] enter_repo(): fix suffix precedence documentation
Date: Mon, 30 Mar 2015 18:30:33 +0800
Message-ID: <1427711433-3104-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 12:31:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcWy6-0004wI-SA
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 12:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbbC3Kau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 06:30:50 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35791 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbC3Kat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 06:30:49 -0400
Received: by pddn5 with SMTP id n5so55517046pdd.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EbWzpaJ0zjg2wD+UT0M6k4F8mK2mOFNjByClqp3SDTY=;
        b=NcVBWJmBSly/WzElEfOUjOfK3KW5aehv33nBiapD6ynrBgw6DK7g2QiizoTfI3/PRB
         CrZ36KQaz3HaCt5BBzmdB0noGITBVQOkk8F8UojTY0b0hoxa22h8Y7g9n8E7ErKJ3i9M
         v92T2OqxyLcCB8bqxLpuqQmoDlsoRKKaCZ8kL0XCKLDxonsxM9KS1cnXczstWK6h61bC
         i3TYBjPBzL2MPxhjuXT1xrnTdrQZ6T7L87QpzWmpoeAFOnfUEpg/iWaNJDG967gg8v65
         2ogr5nTmIwndYpcZ3wNLRLzRxlopLQiFK/mUHY0tgl0v0ZDV86wB4lpiUIlFvdo5LQZN
         iP9Q==
X-Received: by 10.69.13.225 with SMTP id fb1mr57955982pbd.104.1427711448828;
        Mon, 30 Mar 2015 03:30:48 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.172.217])
        by mx.google.com with ESMTPSA id z14sm10107470pbt.21.2015.03.30.03.30.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2015 03:30:47 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YcWxw-0000pR-Jc; Mon, 30 Mar 2015 18:30:44 +0800
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266451>

The ordering of the list of suffixes tested in enter_repo() is
documented as "%s.git/.git", "%s/.git", "%s.git", "%s". This does not
match the ordering of the list of suffixes tested in the code which is
"%s/.git", "%s", "%s.git/.git", "%s.git". Fix this.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 path.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index e608993..6479352 100644
--- a/path.c
+++ b/path.c
@@ -303,8 +303,8 @@ return_null:
  * (3) "relative/path" to mean cwd relative directory; or
  * (4) "/absolute/path" to mean absolute directory.
  *
- * Unless "strict" is given, we try access() for existence of "%s.git/.git",
- * "%s/.git", "%s.git", "%s" in this order.  The first one that exists is
+ * Unless "strict" is given, we try access() for existence of "%s/.git",
+ * "%s", "%s.git/.git", "%s.git" in this order. The first one that exists is
  * what we try.
  *
  * Second, we try chdir() to that.  Upon failure, we return NULL.
-- 
2.1.4
