From: Giovanni Funchal <gafunchal@gmail.com>
Subject: [PATCH] Documentation: setup-git-server-over-http: Mention davfs2
Date: Mon, 18 Aug 2008 23:05:13 +0200
Message-ID: <1219093513-11248-1-git-send-email-gafunchal@gmail.com>
Cc: Johannes.Schindelin@gmx.de, git@wingding.demon.nl,
	Matthieu.Moy@imag.fr, Giovanni Funchal <gafunchal@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVBvk-00048T-HI
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 23:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbYHRVFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYHRVFT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 17:05:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:50715 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbYHRVFR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 17:05:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1760768fgg.17
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=47IokzZvKMfbf8NtT6/JYHm+8hTcPwqyCHHAEYIBDjk=;
        b=KygY5rZN6yVnbgP1liLRtrRmFfRHsV4YT1z4pUGyTHW81RXV15UsJw/YDCbt98CNeA
         9ht0t6ssVQU2QA/sS5m6wvHG4/RzzM+hWbY4qYMcw/Nd8WVUZjqPeFjtEyVT8OMUkAan
         mHCH3CjlPj2cD1sU3UAy+R7N/yxKB+TDp/doY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hIvTDbw09X9I6Mz+J88u8LBF6WNWXRTj50o4UdVESUd8fsgBeNZ6aCJ110bemzSNLt
         Im/dgtzli1yyz/it1HVO4V37cZg3PSi9L5uVCmthr9BmZmAXVBn7VaK4P+a4VfYjA9xZ
         qjx3pHPV/UDeyoCEWxuVqDK49w88P7a9q8WUk=
Received: by 10.86.72.3 with SMTP id u3mr4918566fga.62.1219093515734;
        Mon, 18 Aug 2008 14:05:15 -0700 (PDT)
Received: from localhost.localdomain ( [85.69.129.210])
        by mx.google.com with ESMTPS id l19sm926040fgb.7.2008.08.18.14.05.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 14:05:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc3.19.g4db473
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92740>

I just came across an interesting file system driver that allows to mount
WebDAV resources into file system tree: davfs2. I though it would be worth
mentioning this on setup-git-server-over-http.txt.

I also added a header for the "testing" section.

Signed-off-by: Giovanni Funchal <gafunchal@gmail.com>
---

davfs2 seems pretty stable and performance is quite good.

 Documentation/howto/setup-git-server-over-http.txt |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 4032748..cde6f56 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -164,6 +164,10 @@ Now go to http://<username>@<servername>/my-new-repo.git in your
 browser to check whether it asks for a password and accepts the right
 password.
 
+
+Step 2 1/2: testing your WebDAD server
+--------------------------------------
+
 On Debian:
 
    To test the WebDAV part, do:
@@ -173,9 +177,18 @@ On Debian:
 
    Most tests should pass.
 
-A command line tool to test WebDAV is cadaver. If you prefer GUIs, for
-example, konqueror can open WebDAV URLs as "webdav://..." or
-"webdavs://...".
+An alternative is to use davfs2, a driver that allows monting a WebDAV
+resource into the system tree. This requires root access and kernel
+support (probably your kernel includes this).
+
+  $ apt-get install davfs2
+  $ mkdir -p /mnt/webdav
+  $ mount -t davfs http://<servername>/ /mnt/webdav
+  $ ls /mnt/webdav
+  $ umount /mnt/webdav
+
+If you prefer GUIs, for example, konqueror can open WebDAV URLs as
+"webdav://..." or "webdavs://...".
 
 If you're into Windows, from XP onwards Internet Explorer supports
 WebDAV. For this, do Internet Explorer -> Open Location ->
-- 
1.5.4.3
