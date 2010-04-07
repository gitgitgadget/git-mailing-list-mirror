From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v8] Documentation/remote-helpers: Add invocation section
Date: Wed, 7 Apr 2010 11:14:41 +0530
Message-ID: <h2gf3271551004062244t99a6da09o4fee6be399953c9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 07:45:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzO4w-00088h-OM
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 07:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab0DGFpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 01:45:05 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44096 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab0DGFpD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 01:45:03 -0400
Received: by gwb19 with SMTP id 19so426655gwb.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 22:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=iFX41GeYJlD2YL4d1qIFffmEE/a5+ZoXnQoQRKodrko=;
        b=rOdBGNMok8uOF9Op3+I5NhHyczpWHjumUq/KXgtC2Kxi3IQ++JkwQGb78NydwUPyZ/
         lK/pKaMBPSkfpfOP77JmOrRDMBzKeUzkP6kyuS8cREqmq86VIZBfPaIBZuKERCjilmad
         FBP6xTpXfTZEbko6GNBJCVcNa2mcczY5ZBHbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=ELuVSNgvaF1aQqK7M3PdTg6JXTrnG+KXCqa0mCZf717wPw3X9i12bwy3gOypQ0HlA6
         Yuj5Ovp2tJbmXzTG7RKc3RjPMn3VBTq+/BDw99i9uoc6/EMKOahBa6IF+BR8Lf4jwdd2
         o3sbfAHfmclnDcLK+W3jbEcPArB9+XUBUvX1M=
Received: by 10.90.69.14 with HTTP; Tue, 6 Apr 2010 22:44:41 -0700 (PDT)
Received: by 10.91.219.15 with SMTP id w15mr356715agq.18.1270619101395; Tue, 
	06 Apr 2010 22:45:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144195>

Add an 'Invocation' section to specify what the command line arguments
mean. Also include a link to git-remote in the 'See Also' section.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I forgot to send v7 to the list, so here are the changes since v6:
 Corrected some factual errors pointed out by Jonathan and incorporated
 some other minor suggestions by Junio and Jonathan.

 Documentation/git-remote-helpers.txt |   35 +++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 7a5569c..5a11b28 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -7,7 +7,7 @@ git-remote-helpers - Helper programs to interact with
remote repositories

 SYNOPSIS
 --------
-'git remote-<transport>' <remote>
+'git remote-<transport>' <repository> [<URL>]

 DESCRIPTION
 -----------
@@ -38,6 +38,35 @@ transport protocols, such as 'git-remote-http',
'git-remote-https',
 'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilities
 'fetch', 'option', and 'push'.

+INVOCATION
+----------
+
+Remote helper programs are invoked with one or (optionally) two
+arguments. The first argument specifies a remote repository as in git;
+it is either the name of a configured remote or a URL. The second
+argument specifies a URL of the form '<transport>://<address>' or
+'<transport>::<address>', where '<address>' may be an arbitrary
+string.
+
+When git encounters a URL of the form '<transport>://<address>', where
+'<transport>' is a protocol that it cannot handle natively, it
+automatically invokes 'git remote-<transport>' with the full URL as
+the second argument. If such a URL is encountered directly on the
+command line, the first argument is the same as the second, and if it
+is encountered in a configured remote, the first argument is the name
+of that remote.
+
+A URL of the form '<transport>::<address>' explicitly instructs git to
+invoke 'git remote-<transport>' with '<address>' as the second
+argument. If such a URL is encountered directly on the command line,
+the first argument is '<address>', and if it is encountered in a
+configured remote, the first argument is the name of that remote.
+
+Additionally, when a configured remote has 'remote.<name>.vcs' set to
+'<transport>', git explicitly invokes 'git remote-<transport>' with
+'<name>' as the first argument. If set, the second argument is
+'remote.<name>.url'; otherwise, the second argument is omitted.
+
 COMMANDS
 --------

@@ -206,6 +235,10 @@ OPTIONS
 	must not rely on this option being set before
 	connect request occurs.

+SEE ALSO
+--------
+linkgit:git-remote[1]
+
 Documentation
 -------------
 Documentation by Daniel Barkalow and Ilari Liusvaara
-- 
1.7.0.3
