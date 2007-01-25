From: Gerrit Pape <pape@smarden.org>
Subject: cvsimport/cvsps: not all tags imported
Date: Thu, 25 Jan 2007 14:14:36 +0000
Message-ID: <20070125141436.869.qmail@4d9b601b09a43b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 15:14:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA5Ms-0003f9-8J
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 15:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbXAYOOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 09:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965365AbXAYOOQ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 09:14:16 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:52213 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S965276AbXAYOOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 09:14:16 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jan 2007 09:14:15 EST
Received: (qmail 870 invoked by uid 1000); 25 Jan 2007 14:14:36 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37722>

Hi, if there're two tags on exactly the same revisions of files in CVS,
git-cvsimport only imports one of these tags.  Not sure whether
cvsimport or cvsps is at fault, I use cvsps from
 http://ydirson.free.fr/soft/git/cvsps.git

Here's how to reproduce:

$ cvs -d /tmp/cvs init
$ mkdir repo && cd repo
$ cvs -d /tmp/cvs import -m initial repo vendor-tag release-tag

No conflicts created by this import

$ cd .. && rmdir repo
$ cvs -d /tmp/cvs co repo
cvs checkout: Updating repo
$ cd repo
$ echo foo >a
$ cvs add a
cvs add: scheduling file `a' for addition
cvs add: use `cvs commit' to add this file permanently
$ cvs ci -m a
cvs commit: Examining .
/tmp/cvs/repo/a,v  <--  a
initial revision: 1.1
$ cvs tag TAG0
cvs tag: Tagging .
T a
$ cvs tag TAG1
cvs tag: Tagging .
T a
$ git-cvsimport -C git
Committing initial tree 3203b318694e60d6edc9eb73937365384797625f
$ ls -1 git/.git/refs/tags/
TAG1
$ 

Thanks, Gerrit.
