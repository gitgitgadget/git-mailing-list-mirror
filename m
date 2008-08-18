From: Giovanni Funchal <gafunchal@gmail.com>
Subject: [PATCH] Documentation: setup-git-server-over-http: Mention davfs2
Date: Mon, 18 Aug 2008 23:46:07 +0200
Message-ID: <1219095967-15971-1-git-send-email-gafunchal@gmail.com>
References: <48A9E8BE.9040807@gmail.com>
Cc: Johannes.Schindelin@gmx.de, git@wingding.demon.nl,
	Matthieu.Moy@imag.fr, Giovanni Funchal <gafunchal@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVCZd-0003lU-Bz
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 23:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417AbYHRVqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756410AbYHRVqM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 17:46:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:64036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387AbYHRVqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 17:46:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1777587fgg.17
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DoOK61Bqh749WV/OsBXQkSWOAX3k5op80LulcPDf90I=;
        b=T4OCoWKWEZWjtXz8TBE4TNAnhANb9VEdydLkvk9EVCiXHTw0dzFuj3e4NoG0NcPx19
         MXK7N+ECFv+b3kkCdWhdn0orJWgRSAdTDiq66LYnxVoIRNcoMi7VogcdBW/aqp5HlD6f
         7YehaayyI87o30T/QLgLkHRpFrgi43LzJkI7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jGZ1ukhZJURobvwdKPN1Bj10epbZ0H53D8wnkKMPUQWyL0EqJnjCmoaUnPJgSvYexQ
         15ecwMf5AgWWhwnr60Vgij4Ib7hIpW7EPch9mz1/b/Sck9DrEkTCMFTaWw1UAvsMXrmd
         kLmiNVuEDsqU12NjT1Cpx1Wnx1X8Euy5oGSEg=
Received: by 10.86.1.11 with SMTP id 11mr5006724fga.27.1219095969839;
        Mon, 18 Aug 2008 14:46:09 -0700 (PDT)
Received: from localhost.localdomain ( [85.69.129.210])
        by mx.google.com with ESMTPS id l19sm11838152fgb.7.2008.08.18.14.46.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 14:46:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.6.g8822b
In-Reply-To: <48A9E8BE.9040807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92745>

I just came across an interesting file system driver that allows to mount
WebDAV resources into file system tree: davfs2. I though it would be worth
mentioning this on setup-git-server-over-http.txt.

I also added a header for the "testing" section.

Signed-off-by: Giovanni Funchal <gafunchal@gmail.com>
---
 Documentation/howto/setup-git-server-over-http.txt |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 4032748..827eb43 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -164,6 +164,10 @@ Now go to http://<username>@<servername>/my-new-repo.git in your
 browser to check whether it asks for a password and accepts the right
 password.
 
+
+Step 2 1/2: testing your WebDAV server
+--------------------------------------
+
 On Debian:
 
    To test the WebDAV part, do:
@@ -173,9 +177,18 @@ On Debian:
 
    Most tests should pass.
 
-A command line tool to test WebDAV is cadaver. If you prefer GUIs, for
-example, konqueror can open WebDAV URLs as "webdav://..." or
-"webdavs://...".
+An alternative is to use davfs2, a driver that allows mounting a WebDAV
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
1.6.0.6.g8822b
