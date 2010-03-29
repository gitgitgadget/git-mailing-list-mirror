From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] Documentation/remote-helpers: Add invocation and see also 
	sections
Date: Mon, 29 Mar 2010 09:34:35 +0530
Message-ID: <f3271551003282104v384d2dc7qe0d3c092c01bc505@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 06:11:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw6Jt-0007yg-Tg
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 06:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142Ab0C2ELR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 00:11:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61129 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab0C2ELQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 00:11:16 -0400
Received: by gwaa18 with SMTP id a18so3819022gwa.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 21:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=htDMvILprj+gDk8XH4s6ngOMfDUnvKXlb4UOsKicpaY=;
        b=tyw93wrox9/G60fM5PTb7Lhx7feuFI+e6X8CAILhcFcnO2AJHMAUaiCCiKn2Sqo4+k
         WmVX7bd6nM4erKQznMvAUaWxBU12b8q1Tq+0+eeiUAAq1SYf/9c+IkHIOwBfvfou2+UG
         QgXzrzm/pkXp9fU6Tz0K3DrkKcRZe5QwOdmV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=NDVT6O1bav+ZQyL9ZnL9tbPwvDB0AHTDhTKhzV2N87K9W+FauSkeGTkjaztSbTcu/R
         REYyMM+F3AdSvJsa8qoL1Tv6NvaZ6KKa4LOVDpaCHt9wo7T5XNXk8N2wrYq+Y8qXBJWy
         bJt+qBGjk7tj2ea8+96LDWKfH+PDWVEOzkPWg=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 21:04:35 -0700 (PDT)
Received: by 10.90.1.34 with SMTP id 34mr3313669aga.21.1269835495160; Sun, 28 
	Mar 2010 21:04:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143434>

Add Invocation section, and fill it with documentation by Ilari
Liusvaara. Add See Also section refering to the git-config page
because several configration options are referred to in the Invocation
section.
---
 Documentation/git-remote-helpers.txt |   51 +++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 2382fb4..58533e5 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -38,6 +38,54 @@ Git comes with a "curl" family of remote helpers,
specifically
 'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
 and 'push'.

+INVOCATION
+----------
+
+These programs can always be invoked as 'git remote-<transport>' by
+the end user. However, the following are five situations in which
+these programs are automatically invoked by git in decreasing order of
+priority.
+
+1. URL using <transport>::<string> syntax is used directly on command
+   line.
++
+The helper is invoked with <transport>::<string> as the first argument
+and <string> as the second argument.
++
+<name> can only contain alphanumeric characters 0-9, A-Z and a-z.
+
+2. remote.<name>.url is unset, but remote.<name>.vcs is set to
+   <transport>.
++
+The helper is invoked with a single argument, <name>.
+
+3. remote.<name>.url is set to a value using the <transport>::<string>
+   syntax.
++
+The helper is invoked with <name> as the first argument and <string>
+as the second argument.
++
+<name> can only contain alphanumeric characters 0-9, A-Z and a-z.
+
+4. remote.<name>.url is set to a value using the
+   <transport>://<rest-of-URL> syntax.
++
+The helper is invoked with <name> as the first argument and
+<helper>://<rest-of-URL> as the second argument.
++
+<transport> cannot be equal to any of builtin protocols 'rsync',
+'file', 'git', 'ssh', 'git+ssh' and 'ssh+git'
+
+5. URL using <transport>://<rest-of-URL> syntax is used directly on
+   command line.
++
+The helper is invoked with two arguments, both equal to
+<transport>://<rest-of-URL>.
++
+<transport> cannot be equal to any of builtin protocols 'rsync',
+'file', 'git', 'ssh', 'git+ssh' and 'ssh+git'
+
 COMMANDS
 --------

@@ -206,6 +254,10 @@ OPTIONS
 	must not rely on this option being set before
 	connect request occurs.

+SEE ALSO
+--------
+linkgit:git-config[1]
+
 Documentation
 -------------
 Documentation by Daniel Barkalow and Ilari Liusvaara
-- 
1.7.0.3
