From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 23 Sep 2008 12:08:37 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0809231202560.28506@ds9.cixit.se>
References: <loom.20080915T222909-709@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 13:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki5mR-0001gK-Hx
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 13:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbYIWLIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 07:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbYIWLIn
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 07:08:43 -0400
Received: from ds9.cixit.se ([193.15.169.228]:52047 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbYIWLIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 07:08:42 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8NB8cY1004074
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Sep 2008 13:08:38 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8NB8bEE004067;
	Tue, 23 Sep 2008 13:08:37 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <loom.20080915T222909-709@post.gmane.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 23 Sep 2008 13:08:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96546>

Sergio Callegari:

> To try it, save the following as "rezip" with execution permission:

I had some problems when I tried to implement this a Windows machine,
it did not handle paths with spaces in them properly, and "Documents
and Settings" does contain spaces.

The following patch fixes that for me:
---
 rezip |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rezip b/rezip
index 15f83a4..845e875 100755
--- a/rezip
+++ b/rezip
@@ -66,7 +66,7 @@ done
 
 if [ $# = 0 ] ; then
     tmpcopy=$(mktemp rezip.zip.XXXXXX)
-    cat > $tmpcopy
+    cat > "$tmpcopy"
     filename="$tmpcopy"
 else
     tmpcopy=""
@@ -76,12 +76,12 @@ fi
 workdir=$(mktemp -d -t rezip.workdir.XXXXXX)
 curdir=$(pwd)
 
-cd $workdir
+cd "$workdir"
 unzip $UNZIP_OPTS "$curdir/$filename"
 zip $ZIP_OPTS "$curdir/$filename" .
-cd $curdir
-rm -fr $workdir
+cd "$curdir"
+rm -fr "$workdir"
 if [ ! -z "$tmpcopy" ] ; then
-  cat $filename
-  rm $tmpcopy
+  cat "$filename"
+  rm "$tmpcopy"
 fi
-- 
\\// Peter - http://www.softwolves.pp.se/
