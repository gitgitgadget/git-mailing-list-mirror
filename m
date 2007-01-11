From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Removing files
Date: Thu, 11 Jan 2007 21:10:20 +0100
Message-ID: <87bql5cok3.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jan 11 21:10:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H56G9-00035H-Mb
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 21:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXAKUKr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 11 Jan 2007 15:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXAKUKr
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 15:10:47 -0500
Received: from main.gmane.org ([80.91.229.2]:54212 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbXAKUKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 15:10:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H56Fq-0004W5-Iq
	for git@vger.kernel.org; Thu, 11 Jan 2007 21:10:30 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 21:10:30 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 21:10:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:3Dbevxw41vZqQQf9fAt5s9VnQGQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36605>

I'm wondering what the best way to commit the removal of a file is.

Let's assume that I have a file "foo" in my tree, that I have removed
from my working tree (e.g. by using patch -E).

git status shows:

  $ git status
  # On branch refs/heads/messages
  # Changed but not added:
  #   (use "git add <file>..." to incrementally add content to commit)
  #
  #       deleted:    foo

Ok, so I try to follow the instructions in the message:

  $ git add foo
  fatal: pathspec 'foo' did not match any files

Ok, so that didn't work.  Let's try rm instead:

  $ git rm foo
  fatal: pathspec 'foo' did not match any files

Hm, something is wrong here.  But hey, there's a -f option to rm that
claims to prevent the "up-do-date check"

  $ git rm -f foo
  fatal: pathspec 'foo' did not match any files

=46inally, I have to resort to using update-index.

  $ git update-index --remove foo
  fatal: pathspec 'foo' did not match any files

Since I believe that the idea is to move to an interface where you use
e.g. "git add" instead of explicitly mentioning the index, I think
this is bad.

What could be the correct command for this situation.  Some suggestions=
:

  $ git add foo
  $ git add --remove foo
  $ git rm foo
  $ git rm -f foo

--=20
David K=C3=A5gedal
