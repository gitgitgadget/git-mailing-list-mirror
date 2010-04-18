From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] Documentation/remote-helpers: Add invocation section
Date: Sun, 18 Apr 2010 06:25:27 +0530
Message-ID: <1271552116-sup-1388@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 02:57:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3IpO-0004h9-Hs
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 02:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab0DRA5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 20:57:33 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:44902 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab0DRA5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 20:57:32 -0400
Received: by yxe29 with SMTP id 29so1859268yxe.4
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 17:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=Jwp536S5WW6sNCK+NB0qTdNrXjG6zPQd+mcVzO5xsa4=;
        b=QCaq1wEVDpdqmgq2HwGf3wcMVuUAyEb1uDm3fF47xQcGx1R7PY6YKGl3pQAmfCiErH
         uvG5itYGr6ZeJDGRdDhcB/xRn1jyH36j9YdBSSEqSLbHvkgaWoI+yKBHOKeilwlYrK73
         38vAS3RQ0sB3L+dztB1bkOXvuuUoVZPLOWfIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=IqVOtI5mvCu09wzUdR/rIPllhTjcs+ireMKwBs7pUXtScdcv5m59ahP/MuJrYhp09t
         KCuJWAl0RYzIMH5nvJfzI9URI2cP+uHZGgN+itSbKDSpnGoE1UH2/wZXztLAvbL1ueHv
         VCNYSgcGYcTrfP0oFIZ5TH11J+YH0jOTJd9WQ=
Received: by 10.91.94.2 with SMTP id w2mr457927agl.106.1271552251647;
        Sat, 17 Apr 2010 17:57:31 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 22sm3336911iwn.12.2010.04.17.17.57.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 17:57:31 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145197>

Add an 'Invocation' section to specify what the command line arguments
mean. Also include a link to git-remote in the 'See Also' section.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-remote-helpers.txt |   35 +++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 15214ae..25a0a16 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -7,7 +7,7 @@ git-remote-helpers - Helper programs to interact with remote repositories
 
 SYNOPSIS
 --------
-'git remote-<transport>' <remote>
+'git remote-<transport>' <repository> [<URL>]
 
 DESCRIPTION
 -----------
@@ -38,6 +38,35 @@ transport protocols, such as 'git-remote-http', 'git-remote-https',
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
 
@@ -211,6 +240,10 @@ OPTIONS
 	helper MUST NOT rely on this option being set before
 	connect request occurs.
 
+SEE ALSO
+--------
+linkgit:git-remote[1]
+
 Documentation
 -------------
 Documentation by Daniel Barkalow and Ilari Liusvaara
-- 
1.7.0.4
