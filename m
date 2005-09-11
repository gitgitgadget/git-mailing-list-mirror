From: Frank Sorenson <frank@tuxrocks.com>
Subject: git problems on Kernel.org?
Date: Sun, 11 Sep 2005 01:58:56 -0600
Message-ID: <4323E3C0.1090109@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 11 10:01:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEMk5-0002Hc-2Z
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 09:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVIKH7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 03:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVIKH7L
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 03:59:11 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:55568 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S964819AbVIKH7K (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 03:59:10 -0400
Received: from [10.0.0.10] (216-190-206-130.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j8B7x0Yv002148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 11 Sep 2005 01:59:08 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8273>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Something appears to be something odd going on with the git repos on
kernel.org, including both the git and linux trees.  I believe that I've
tracked down the problem to differences that occur between the repos
located at the various IPs that kernel.org translates to (zeus-pub1:
204.152.191.5 and zeus-pub2: 204.152.191.37).

In this case, it appears that the repo located at zeus-pub1 has been
updated, but the changes haven't propagated over to zeus-pub2 yet.  The
result is that one call fetches a list of objects, but the next call
goes to the other IP, and it can't find an object it needs, so it ends
up dying.

This is probably a temporary error that will periodically (and probably
very rarely) occur when pulling from a source with more than a single IP
and some lag before the mirror is updated.

Is this an issue that we need to watch for and program around (other
than forcing www.kernel.org's IP in /etc/hosts), or is it just one of
those things that should be such a rare occurrance that we shouldn't
have to worry about it?

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDI+PAaI0dwg4A47wRAgEhAKDPjvyHZwTSw/e+FwE5BXtpH2novACdGBaF
+R64XoAYx+WXGjbczO+ZQtY=
=vCRj
-----END PGP SIGNATURE-----
