From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: git-write-error with cherry-pick -n usages
Date: Fri, 11 Jan 2008 06:48:11 +0100
Message-ID: <20080111054811.GA7476@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 06:48:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDClA-0004no-07
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 06:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134AbYAKFsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 00:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbYAKFsS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 00:48:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:58080 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751398AbYAKFsO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 00:48:14 -0500
Received: (qmail invoked by alias); 11 Jan 2008 05:48:12 -0000
Received: from i577ACCB6.versanet.de (EHLO atjola.local) [87.122.204.182]
  by mail.gmx.net (mp011) with SMTP; 11 Jan 2008 06:48:12 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19tTHcxq+pt5AvlVjvASvHHsxnsoAJmwkxhF8itk4
	ZJ6eZLhKCVqQtS
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-12-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70121>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

when you cherry-pick -n a commit that has changes to a file missing in
the current tree, that file will be added as "Unmerged". A subsequent
cherry-pick that tries to pick a commit that has changes to that file
will then fail with:

fatal: git-write-tree: error building trees

I've attached a small shell script to easily reproduce that.

git version 1.5.4.rc2.84.gf85fd

That specific use of cherry-pick might be an user error, but, if
possible, git should give a less cryptic error message.

Björn

--ZPt4rx8FFjLCG7dd
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0Amkdir gwt-crash=0Acd gwt-crash=0Agit init=0Atouch a=0Agit add a=
=0Agit commit -m init=0A=0Agit branch foo=0A=0Aecho 123 > new=0Agit add new=
=0Agit commit -m 123=0A=0Aecho 456 > new=0Agit commit -a -m 456=0A=0Aecho 7=
89 > new=0Agit commit -a -m 789=0A=0A=0Agit checkout foo=0Agit cherry-pick =
-n master^=0Agit cherry-pick -n master=0A
--ZPt4rx8FFjLCG7dd--
