From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Wed, 7 Apr 2010 11:27:12 +0530
Message-ID: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Apr 07 07:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzOGh-0004eD-HV
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 07:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868Ab0DGF5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 01:57:34 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:50165 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab0DGF5d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 01:57:33 -0400
Received: by ywh2 with SMTP id 2so438820ywh.33
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 22:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=Yhjl32Qxevd452xRAwZ0/TVz7kZxjDdIlrumLy5PG4Q=;
        b=Gm25mQzBAnSFtDFd6JX88QmxWavF+ngkV/KlIO+yfTmVD4yZWrKLMAZke0O8JFjj6l
         wxLGgWKRE2XkFFNVigkAihM7CR8b2Ue3lqtGtdhxNt/bRNMUxnlxDd2Sdju3OpJD/RbW
         1zDBR9Axx0z0bLBSz5inGl3sCobjg8xzoLIo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=pLfb1dXnvNNW/axRtJ6n2MwI/fd1sHC53FsdVJaXvuxZBISZm2iagADfckVRyZWyra
         FIafmtme37EG0SMdUOkA1zBbkxzYxFu2edvXIACDqbGsV0DBeovCplynwzEZLcgJplc8
         ulD87TqbuI6TiA+03FP0+kvGl0n0vISRVRPpM=
Received: by 10.90.69.14 with HTTP; Tue, 6 Apr 2010 22:57:12 -0700 (PDT)
Received: by 10.90.59.29 with SMTP id h29mr599717aga.14.1270619852100; Tue, 06 
	Apr 2010 22:57:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144199>

Add an 'Invocation' section to specify what the command line arguments
mean. Also include a link to git-remote in the 'See Also' section.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Changes: The second argument may be an arbitrary string as
 Jonathan pointed out.

 Documentation/git-remote-helpers.txt |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 7a5569c..b0e7d54 100644
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
@@ -38,6 +38,34 @@ transport protocols, such as 'git-remote-http',
'git-remote-https',
 'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilities
 'fetch', 'option', and 'push'.

+INVOCATION
+----------
+
+Remote helper programs are invoked with one or (optionally) two
+arguments. The first argument specifies a remote repository as in git;
+it is either the name of a configured remote or a URL. The second
+argument specifies a URL; it is usually of the form
+'<transport>://<address>', but any arbitrary string is possible.
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

@@ -206,6 +234,10 @@ OPTIONS
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
