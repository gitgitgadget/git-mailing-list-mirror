From: Junio C Hamano <junkio@cox.net>
Subject: [4/4] What's not in 1.5.2 (other bits and pieces)
Date: Wed, 16 May 2007 15:47:16 -0700
Message-ID: <11793556383977-git-send-email-junkio@cox.net>
References: <11793556363795-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 00:47:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoSHY-0005dw-QD
	for gcvg-git@gmane.org; Thu, 17 May 2007 00:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318AbXEPWrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 18:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757467AbXEPWrZ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 18:47:25 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56518 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318AbXEPWrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 18:47:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516224719.VCEN22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 16 May 2007 18:47:19 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zynG1W00a1kojtg0000400; Wed, 16 May 2007 18:47:18 -0400
X-Mailer: git-send-email 1.5.2.rc3.50.gfdcb7
In-Reply-To: <11793556363795-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47469>

Here are the leftover pieces I have in todo:TODO file that I did
not mention in the earlier messages.  I left them out from the
third message of this series, as (1) some are more of "trivial
fix" category, and (2) others are heavier and would probably not
fit for a single release cycle such as 1.5.3.

The easier ones
---------------

* parse-remote.sh has POSIXLY incorrect shell construct.

Message-ID: <20070505080313.GA12170@gondor.apana.org.au>

* Use 'git diff' not 'git diff-tree' in merge and rebase

From: James Bowes <jbowes@dangerouslyinc.com>
Message-ID: <1178398134288-git-send-email-jbowes@dangerouslyinc.com>

* gitk --left-right

From: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
From: Junio C Hamano <junkio@cox.net>
Message-ID: <7vabwifl23.fsf@assigned-by-dhcp.cox.net>

* Handling pushing into non-bare repository more gracefully.

When git-push is done to a non-bare repository and updates the
branch that is currently checked out, we currently do not do
anything special.

From: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0704160931550.5473@woody.linux-foundation.org>

* git-daemon bug?

From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Message-ID: <450EABD0.1040102@innova-card.com>

Repeated requests against git-daemon makes it stuck under --syslog

[jc: does not reproduce easily for me; has anybody seen it?]

* AsciiDoc 8 would break our documentation.

From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Message-ID: <4523EC14.6070806@s5r6.in-berlin.de>

AsciiDoc 8 does not grok documents written for AsciiDoc 7 out of
the box.

[jc: limbo?]

* Delegate gitweb part to somebody else.

* Use gitattributes for more things.

 - 'precious' files that are not tracked but not
   build-products.  Currently people seem to put them in
   .gitignore, but that is not quite right, as .gitignore is
   meant for ignoring things that can be lost (build products,
   editor backup files).  "git clean -x" and "git checkout" to
   another branch that has a file where the current branch has a
   directory could lose such 'precious' files.

 - Customized "diff -p" markers per path (Johannes, on #git
   2007-04-30).

   I think it makes sense to give an extra parameter to xdiff
   machinery to affect how "diff -p" markers are constructed (as
   opposed to teach xdiff machinery to read gitattributes -- the
   code does not have path information at that level).  The
   simplest interface would be to pass a regexp and have the
   existing code always look for that regexp backwards.  A more
   complex one would involve a callback function, but I do not
   know if that kind of complexity is worth it.

 - Others???

* upload-pack support for start fetching from any valid point on
  the history, not just published refs. (Erik W. Biederman
  <m164jc9ekx.fsf@ebiederm.dsl.xmission.com>)

* Give --stdin to git-log, similar to git-rev-list

From: "Marco Costalba" <mcostalba@gmail.com>
Message-ID: <e5bfff550705110413q28aef3d8k3aeb0d342eeb2016@mail.gmail.com>

* Update the lockfile protocol so that closing and renaming are
  done inside lockfile commit time.  Some filesystems do not
  like an open file renamed and then closed.  Come up with a
  patch and pass Alex for an Ack.


Probably not so important ones
------------------------------

* daemon --strict-symlink.

* Maybe grok PGP signed text/plain in applymbox as well.

* Mbx (not mbox) support for git-mailsplit.

* git-proxy should be spawned with sh -c 'command' $1 $2.

[jc: should it? -- deciding if it should may not be "trivial",
but if it turns out to be the right thing to do, the change
itself is trivial.]

* Maybe a true git-proxy command that reads the first request
  pkt-line, and redirects the request to its real destination.

* test scripts for the relative directory path stuff.


The heavier ones
----------------

* Use blame machinery to track a single file (not path) in a finer
  grained way.

From: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <alpine.LFD.0.98.0704201554550.9964@woody.linux-foundation.org>

[jc: I have a fixed-up one parked in 'pu' and also outlined what
other things I think are needed in my response:

    Message-ID: <7vwt06wqv8.fsf@assigned-by-dhcp.cox.net>
]

* "git fetch" should be able to use foreign SCM import backends
  such as svnimport and cvsimport.

* git-clone fails .git/refs/foo (Yann Dirson <ydirson@altern.org>)
  <20060610225040.GA7766@nowhere.earth>
