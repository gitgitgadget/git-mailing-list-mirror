From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/8] remote-bzr: fix for files with spaces
Date: Thu, 16 May 2013 03:36:41 -0500
Message-ID: <1368693407-21267-3-git-send-email-felipe.contreras@gmail.com>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 10:38:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucthy-0000N5-KW
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab3EPIie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:38:34 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:56775 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab3EPIic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:38:32 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so3390493oah.21
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WI3doNkkcj1Y5sfTv7xRiTGv3GNB2UP2ueIr7bAPPVA=;
        b=kZlpSoECa9WWr9k1Mpmnx7oZ+wjpXNpN/SQqd/HVUQo7E/JdfPA4+k9naIAmU1OoGN
         Pn+IsD/LyIZ8BAkfToiJWNGEsRHv35VDt/uQ4Rx0LSVCXsw5y8pfcY11Y7pOVhsH6teW
         IaBSXkp1Wh640irLkokFyhM5JUmBAqpGTMkKpu5ZmdEw60SzgFruRjfiTpozZ2TFsP2n
         +CwvzCKrRCKvyy4EPQVzFUWTNgUdhgLhzf8tBRQs9SOXCXoKxqxtIhnq82NQCbtXfvAS
         e28v0ieAV0RhMdP0HzOXVIpYYYyr/6QVi2P6qlIi41VXATYF1jheOtfV+SsXQ6DRycuK
         i8ng==
X-Received: by 10.182.99.199 with SMTP id es7mr19402896obb.5.1368693511448;
        Thu, 16 May 2013 01:38:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm7129564oez.4.2013.05.16.01.38.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 01:38:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224502>

Set the maximum number of splits to make when dividing the diff stat
lines based on space characters.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 7cd9ed8..b849336 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -620,7 +620,7 @@ def parse_commit(parser):
             mark = int(mark_ref[1:])
             f = { 'mode' : m, 'mark' : mark }
         elif parser.check('D'):
-            t, path = line.split(' ')
+            t, path = line.split(' ', 1)
             f = { 'deleted' : True }
         else:
             die('Unknown file command: %s' % line)
-- 
1.8.3.rc2.542.g24820ba
