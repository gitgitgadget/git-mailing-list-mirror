From: "Post, Mark K" <mark.post@eds.com>
Subject: Git-daemon messing up permissions for gitweb
Date: Fri, 9 Jun 2006 14:41:35 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF41050795782F@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Fri Jun 09 20:42:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Folvy-0007YH-TV
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 20:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWFISmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 14:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWFISmJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 14:42:09 -0400
Received: from ahmler3.mail.eds.com ([192.85.154.74]:35041 "EHLO
	ahmler3.mail.eds.com") by vger.kernel.org with ESMTP
	id S1030370AbWFISmE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 14:42:04 -0400
Received: from ahmlir5.mail.eds.com (ahmlir5-2.mail.eds.com [192.85.154.135])
	by ahmler3.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59Ig3Ab009069
	for <git@vger.kernel.org>; Fri, 9 Jun 2006 14:42:03 -0400
Received: from ahmlir5.mail.eds.com (localhost [127.0.0.1])
	by ahmlir5.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59If42N018448
	for <git@vger.kernel.org>; Fri, 9 Jun 2006 14:41:04 -0400
Received: from usahm012.amer.corp.eds.com ([130.175.214.153])
	by ahmlir5.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59If43m018440
	for <git@vger.kernel.org>; Fri, 9 Jun 2006 14:41:04 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by usahm012.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Jun 2006 14:41:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-daemon messing up permissions for gitweb
Thread-Index: AcaL9E46vY8XazwnT9OejiTR/uaw6Q==
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 09 Jun 2006 18:41:35.0444 (UTC) FILETIME=[55CD5940:01C68BF4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21538>

I'm trying to set up a git repository for mainframe Linux developers to
use at git390.osdl.marist.edu.  Everything _seemed_ to go well, until
Martin Schwidefsky started actually pushing changes back to the
repository.  When he does that, the projects disappear from the web page
that gitweb.cgi is generating.

As far as I can tell, the problem is happening because these files are
being written out with file permissions of 640, and since Apache is
running as user wwwrun, it can't read them:
-rw-r-----  1 sky git  5490 Jun  9 03:35 ./linux-2.6.git/info/refs
-rw-r-----  1 sky git    54 Jun  9 03:35
./linux-2.6.git/objects/info/packs
-rw-r-----  1 sky git    41 Jun  9 03:35
./linux-2.6.git/refs/heads/master
-rw-r-----  1 sky git    41 Jun  9 03:35
./linux-2.6.git/refs/heads/origin
-rw-r-----  1 sky git  5490 Jun  9 04:00
./s390-experimental.git/info/refs
-rw-r-----  1 sky git     1 Jun  9 04:00
./s390-experimental.git/objects/info/packs
-rw-r-----  1 sky git    41 Jun  9 04:00
./s390-experimental.git/refs/heads/master
-rw-r-----  1 sky git  5490 Jun  9 11:31 ./s390-features.git/info/refs
-rw-r-----  1 sky git     1 Jun  9 11:31
./s390-features.git/objects/info/packs
-rw-r-----  1 sky git    41 Jun  9 11:31
./s390-features.git/refs/heads/master
-rw-r-----  1 sky git  5490 Jun  9 03:41 ./s390-fixes.git/info/refs
-rw-r-----  1 sky git     1 Jun  9 03:41
./s390-fixes.git/objects/info/packs
-rw-r-----  1 sky git    41 Jun  9 03:41
./s390-fixes.git/refs/heads/master

I know I could brute-force this by adding wwwrun to the git group, but I
first wanted to find out if that is the solution, or if something is
wrong with the way I've set things up.  I tried searching the mailing
list archives, but nothing that appeared to be relevant turned up.

Thanks in advance for any help,

Mark Post
