From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3] Improve remote-helpers documentation
Date: Mon, 22 Mar 2010 09:07:05 +0530
Message-ID: <f3271551003212037u66e9680cm8677c80b25f4b3a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 04:37:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtYSL-0005qC-Sp
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 04:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab0CVDh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 23:37:27 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:63214 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab0CVDh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 23:37:26 -0400
Received: by gxk9 with SMTP id 9so269753gxk.8
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 20:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=vQSSy0OxF7IfRXYqcIpPZO2O/zUfO5V1YrTz9PJmaYE=;
        b=Yv8kxbqfdftfUd40kxv1w4I/g119QNbS4uQ7i0uYy15JHaqYtFcDdhPfQdiJ33MrmU
         ubFBZfCwEwWIlY2BhVsi5roy7g6Ebu4Ymxkq6juJQEKJnZiE+OZKYh6BKiYdSwe5rd1X
         J1jRK2N3okWKmq3jHWtyG5OkHyshVbBTUcBCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=GXqiG1gvX4vgs/buc4yBUrCI5/x37lo5wj2ofuMDajK4UdP9CJREF4v2BfbZpZpXb/
         ymeXyaTE3jZYXikkFisL7RccEQ0uNwS1/iF3FUZ97OD4eOrMTd7mR5HJ4UGTEYj83/2h
         LRXWbeZvu/4aMH9ZIeqvaPfvSJRYe5uehMosY=
Received: by 10.90.37.31 with SMTP id k31mr3646723agk.107.1269229045269; Sun, 
	21 Mar 2010 20:37:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142889>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-remote-helpers.txt |   39 +++++++++++++++++----------------
 1 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1b5f61a..b1f4e5d 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -3,7 +3,7 @@ git-remote-helpers(1)

 NAME
 ----
-git-remote-helpers - Helper programs for interoperation with remote git
+git-remote-helpers - Helper programs for interacting with main git
without linking

 SYNOPSIS
 --------
@@ -13,10 +13,22 @@ DESCRIPTION
 -----------

 These programs are normally not used directly by end users, but are
-invoked by various git programs that interact with remote repositories
-when the repository they would operate on will be accessed using
-transport code not linked into the main git binary. Various particular
-helper programs will behave as documented here.
+invoked by various git programs that interact with remote
+repositories.  For a program to qualify as a remote helper, it must
+implement a subset of the capabilities documented here, and conform to
+the remote helper protocol. Remote helpers interact with the main git
+programs via text streams, and do not link to them.
+
+The curl helper is one such program. It is invoked via
+'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
+'git-remote-ftps', and implments the capabilities 'fetch', 'option',
+and 'push'. The curl helper essentially helps in moving around native
+git objects.
+
+As opposed to native git objects, remote helpers can also provide a
+fast-import stream through the 'import' capability. This makes it
+especially useful when native interoperability with a foreign
+versioning system is desired.

 COMMANDS
 --------
@@ -118,17 +130,9 @@ capabilities reported by the helper.
 CAPABILITIES
 ------------

-'fetch'::
-	This helper supports the 'fetch' command.
-
-'option'::
-	This helper supports the option command.
-
-'push'::
-	This helper supports the 'push' command.
-
-'import'::
-	This helper supports the 'import' command.
+The following capabilities indicate that the remote helper supports
+the corresponding command with the same name: 'fetch', 'option',
+'push', 'connect', and 'import'.

 'refspec' 'spec'::
 	When using the import command, expect the source ref to have
@@ -140,9 +144,6 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"

-'connect'::
-	This helper supports the 'connect' command.
-
 REF LIST ATTRIBUTES
 -------------------

-- 
1.7.0
