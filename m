From: Eunsuk Kang <eskang@csail.mit.edu>
Subject: git rm bug?
Date: Wed, 30 Oct 2013 01:23:29 -0400
Message-ID: <155154AA-15E8-49E8-8261-6295AC6F6CF7@csail.mit.edu>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 30 06:53:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOiq-0001Vg-6t
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768Ab3J3FxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:53:22 -0400
Received: from outgoing.csail.mit.edu ([128.30.2.149]:54106 "EHLO
	outgoing.csail.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab3J3FxV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:53:21 -0400
X-Greylist: delayed 1785 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 01:53:21 EDT
Received: from [18.189.107.95]
	by outgoing.csail.mit.edu with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <eskang@csail.mit.edu>)
	id 1VbOFg-0006zZ-Qu
	for git@vger.kernel.org; Wed, 30 Oct 2013 01:23:32 -0400
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236982>

Hello,

My understanding was that running "git rm" on a file will delete all ancestors of the file that are empty directories from the file system. I've ran into a case that seems a little strange.

To reproduce (using version 1.8.4.1 on Mac OS X 10.7.5):

git init
mkdir a
mkdir b
touch a/b/c.txt
git add .
git commit

Then, running the commands

$ rm a/b/c.txt
$ git rm a/b/c.txt

deletes "c.txt" as well as both directories "a" and "b", as expected. But if I instead do

$ rm -r a/b
$ git rm a/b/c.txt

then git deletes "c.txt" and "b", but leaves "a" intact in the file system. Is this a bug?

Thank you,
Eunsuk
