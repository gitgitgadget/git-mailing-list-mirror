From: miket99@Safe-mail.net
Subject: pull from stdin
Date: Thu, 7 Jul 2011 11:23:04 -0400
Message-ID: <N1B-u7I8PJ0byN@Safe-mail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 19:40:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QesYp-0008JM-OU
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 19:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102Ab1GGRkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 13:40:15 -0400
Received: from tamar.safe-mail.net ([213.8.161.229]:35997 "EHLO
	tamar.safe-mail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab1GGRkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 13:40:13 -0400
X-Greylist: delayed 8220 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jul 2011 13:40:13 EDT
Received: by tamar.safe-mail.net with Safe-mail (Exim 4.66)
	(envelope-from <miket99@Safe-mail.net>)
	id 1QeqPw-0007Hl-Co
	for git@vger.kernel.org; Thu, 07 Jul 2011 11:23:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
	s=N1-0105; d=Safe-mail.net;
	b=HckV/bcJahF5EtUvl+n8B/ihM01y474Y6GNmFtaT7qx3oeFRbbQbFGdFpCjw4VbO
	ot6dr8E2Qh2RwDsirImrfFCCFn7+Mrt4SHzXyZHcAv13TPByx1ZPm7WAQFPWfZ+Q
	w84VZnv7oPZrqtgsrwMji3mOw43mK/BH7ds+ylC5msY=;
Received: from pc ([199.48.147.4]) by Safe-mail.net with https
X-SMType: Regular
X-SMRef: N1B-u7I8PJ0byN
X-SMSignature: M78QHrlnEde1EGCH2CQA2/glD4TrmNL80TNGUk9ojNthElhQfNDSmRy/Dt2xikF2
	E6zCe1GP0lQmjQKrXGqPLiDp4rHTZCzy0Nw6fyNIbv/SvOSAFm5AJVeCkEd1DB9T
	JOJFRVK87rfTeiClEO+ojLHnH/isoqzfJKDS9mUusno=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176763>

Hello,

I am using a rather complicated distributed workflow to keep various git repositories in sync. Basically I am creating bundles, pushing them to a server, and pull them again using a special application which output the bundle content to stdin. Unfortunately git-fetch and friends do not like /dev/stdin as input. Is there any way to pass the bundle contents via stdin to git?

Minimal sample:
~$ mkdir test
~$ cd test
~/test$ git init
Initialized empty Git repository in /home/test/test/.git/
~/test$ echo a > a
~/test$ git add -A
~/test$ git commit -m test
[master (root-commit) 4ed639a] test
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
~/test$ git bundle create b --all
Counting objects: 3, done.
Writing objects: 100% (3/3), 193 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
~/test$ cat b | git pull -- /dev/stdin
fatal: '/dev/stdin' does not appear to be a git repository
fatal: The remote end hung up unexpectedly
