From: "Mark Grimes" <mark@stateful.net>
Subject: git-svn fails different ways depending on svn-remote.svn.url protocol
Date: Thu, 28 Jun 2007 10:05:44 -0800
Message-ID: <y59sLxMx.1183053944.4686070.mgrimes@harwood.textdrive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 20:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3yu5-0004Q0-5V
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 20:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759724AbXF1Sjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 14:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758668AbXF1Sjj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 14:39:39 -0400
Received: from mailscan1.textdrive.com ([207.7.108.214]:54911 "EHLO
	mailscan1.textdrive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585AbXF1Sji convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2007 14:39:38 -0400
X-Greylist: delayed 2032 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2007 14:39:38 EDT
Received: from webmail.textdrivehosting.com (webmail1.textdrive.com [10.0.0.193])
	by mailscan1.textdrive.com (Postfix) with SMTP id 6EE60147C66
	for <git@vger.kernel.org>; Thu, 28 Jun 2007 18:05:56 +0000 (GMT)
Received: from 198.151.12.15 (auth. user mgrimes@harwood.textdrive.com)
          by webmail.textdrivehosting.com with HTTP; Thu, 28 Jun 2007 10:05:44 -0800
X-Mailer: IlohaMail/0.8.14 (On: webmail.textdrivehosting.com)
Bounce-To: "Mark Grimes" <mark@stateful.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51123>

I'm at a complete loss as to what is happening here.  The HTTPS error
that does not allow me to fulfill the commit is:

RA layer request failed: PUT of
'/repository/macports/!svn/wrk/e983e9c6-e86a-4223-b30b-2a7457845272/trunk/dports/perl/p5-params-util/Portfile':
SSL negotiation failed: SSL error: sslv3 alert bad record mac
(https://svn.macports.org) at /opt/local/bin/git-svn line 405

It's pretty consistent but after a few dozen attempts I was able to get
my 10 changes across 10 files committed through a series of commits and
resets until the dcommit was successful.

If I switch the svn url to HTTP, I get something even stranger (I did
create the repository initially from the HTTP URL, but I would hope that
flipping svn-remote.svn.url back and forth between http and https would
be completely transparent) -- however the HTTP version of the error is:

Merge conflict during commit: Your file or directory
'dports/audio/libid3tag/Portfile' is probably out-of-date: The version
resource does not correspond to the resource within the transaction. 
Either the requested version resource is out of date (needs to be
updated), or the requested version resource is newer than the
transaction root (restart the commit). at /opt/local/bin/git-svn line 405

Note that libid3tag/Portfile work was by another committer and about 30
or so commits away from head.  How does one bring this up from being
out-of-date?

I have full transcriptions of the process if this helps, but didn't want
to spam the list with it.

Does anyone have any ideas what might solve either problem?  I think the
former is a Subversion issue because I've heard this complaint from
committers using the svn client... The solution seems to be keep trying
till it takes, which has me shaking my head at the entire process.

I did finally get the commit in through bruteforce via HTTPS, but I lack
confidence in patching any more then a file or two at a time, which is
quite disheartening while trying to follow the philosophy of whole
functional commits and not spread out due to technical deficiencies.
