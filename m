From: willievu <willievu@dev.java.net>
Subject: http-push sends MKCOL command to create remote directory MKCOL
 http://user@server:80/url/.git/refs/ that already exists
Date: Fri, 14 Aug 2009 10:42:01 -0500 (CDT)
Message-ID: <1250264521299-3445796.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 18:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbzET-0005Pi-W5
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 18:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbZHNQCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 12:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754882AbZHNQCM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 12:02:12 -0400
Received: from 216-139-236-80.aus.us.siteprotect.com ([216.139.236.80]:1383
	"EHLO jim.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbZHNQCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 12:02:12 -0400
X-Greylist: delayed 1213 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Aug 2009 12:02:12 EDT
Received: from jim ([127.0.0.1]) by jim.nabble.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Aug 2009 10:42:01 -0500
X-Nabble-From: willievu@dev.java.net
X-OriginalArrivalTime: 14 Aug 2009 15:42:01.0315 (UTC) FILETIME=[C3ED3B30:01CA1CF5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125933>


Steps will reproduce the problem:
1. create a bare & shared repository locally and copy to remote server
2. create a local repository. add and commit some files
3. git push to the remote server

$ git push --verbose --thin upload HEAD
Pushing to http://user@server/url/.git/
Password:
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master' using 'HEAD'
  from 0000000000000000000000000000000000000000
  to   0120f45ebfd90501868e990bfbb9f50fb0a8ebae

<<<<< Here, a MKCOL http://user@server:80/url/.git/refs/ request is sent.  
The WebDAV server returns a HTTP 500 Internal Server Error.  Then, the 
following message continues:

Unable to create branch path http://user@server/url/.git/refs/
Unable to lock remote branch refs/heads/master
error: failed to push some refs to 'http://user@server/url/.git/'

This is the server:

Server: Oracle9iAS/9.0.2.3.0 Oracle HTTP Server (Unix) mod_plsql/9.0.2.6.0b 
DAV/1.0.3.2.4-0119 (OraDAV enabled) mod_osso/9.0.2.0.0 mod_ossl/9.0.2.0.0 
mod_fastcgi/2.2.12 mod_perl/1.26 mod_oc4j/3.0

Is MKCOL expected even for existing directory in the remote repository?  Is
this a WebDAV server problem that 500 is returned?

-- 
View this message in context: http://n2.nabble.com/http-push-sends-MKCOL-command-to-create-remote-directory-MKCOL-http%3A--user%40server%3A80-url-.git-refs--that-already-exists-tp3445796p3445796.html
Sent from the git mailing list archive at Nabble.com.
