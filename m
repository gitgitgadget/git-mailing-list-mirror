From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4] Improve remote-helpers documentation
Date: Mon, 22 Mar 2010 18:34:21 +0530
Message-ID: <f3271551003220604v4c9fbb5ep3b7c69300567a275@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 14:04:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NthJJ-0005Rw-QR
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 14:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab0CVNEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 09:04:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64958 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab0CVNEo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 09:04:44 -0400
Received: by gwaa18 with SMTP id a18so960647gwa.19
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=/UHl42gRIEMWXXSY+Bind8PMQZhHUVpOdWQOF8MXi6A=;
        b=BKzYqou8fNbIvKmh8sl7vdweJIjFr4/rpbRvusqb67oyVEd9UyA5/9n4eZSUoCB5JE
         YQCZwKtcNn1nlR2pGc0Q6yj6dc33W2En8lShOJrPr6ZBGETYHokpzODGRI19oMhuG3O1
         0qVpp4fCDz+d67JTwcZv5gBKyA2BNdwKKV+gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=AI/OxoJaXif/W4gIuXCaJXzTfa0IxJ15U+MDlC7gq9cO5EeVJW5/itC11BbosEZf21
         RmEilZ/5+T11RGEZ+Ydr8GGGRQwZMx4JkvMm9k0rIZvfcWhMnQw0YJvNowjQdgoO5TkX
         0k+Znwv9Yd3NzswNhRNjVPxFujwEBmZa5MQsA=
Received: by 10.90.16.22 with SMTP id 22mr62698agp.98.1269263083063; Mon, 22 
	Mar 2010 06:04:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142928>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-remote-helpers.txt |   40 +++++++++++++++++----------------
 1 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1b5f61a..2d5aa8c 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -3,7 +3,7 @@ git-remote-helpers(1)

 NAME
 ----
-git-remote-helpers - Helper programs for interoperation with remote git
+git-remote-helpers - Helper programs for interacting with remote repositories

 SYNOPSIS
 --------
@@ -13,10 +13,23 @@ DESCRIPTION
 -----------

 These programs are normally not used directly by end users, but are
-invoked by various git programs that interact with remote repositories
-when the repository they would operate on will be accessed using
-transport code not linked into the main git binary. Various particular
-helper programs will behave as documented here.
+invoked by various git programs that interact with remote
+repositories.  For a program to qualify as a remote helper, it must
+implement a subset of the capabilities documented here, and conform to
+the remote helper protocol. Remote helpers are spawned as binaries by
+the main git programs and interact using text streams, without
+linking.
+
+The curl helper is one such program. It is invoked via
+'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
+'git-remote-ftps', and implments the capabilities 'fetch', 'option',
+and 'push'. The curl helper essentially helps in transporting native
+git objects.
+
+As opposed to native git objects, remote helpers can also provide a
+fast-import stream through the 'import' capability. This makes them
+especially useful when native interoperability with a foreign
+versioning system is desired.

 COMMANDS
 --------
@@ -118,17 +131,9 @@ capabilities reported by the helper.
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
@@ -140,9 +145,6 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"

-'connect'::
-	This helper supports the 'connect' command.
-
 REF LIST ATTRIBUTES
 -------------------

-- 
1.7.0.2
