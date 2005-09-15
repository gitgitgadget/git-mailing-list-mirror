From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Thu, 15 Sep 2005 19:48:27 +0200
Message-ID: <u5toe6uql1w.fsf@lysator.liu.se>
References: <7255.1126583985@kao2.melbourne.sgi.com>
	<1126674993.5681.9.camel@localhost.localdomain>
	<1126745323.7199.3.camel@localhost.localdomain>
	<Pine.LNX.4.58.0509142018410.26803@g5.osdl.org>
	<43290486.5020301@zytor.com> <7v7jdibwqq.fsf@assigned-by-dhcp.cox.net>
	<u5tvf12sp1v.fsf@lysator.liu.se>
	<Pine.LNX.4.58.0509150905070.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Sep 15 19:56:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFxto-0002Jv-Ma
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 19:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVIORvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Sep 2005 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVIORvu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 13:51:50 -0400
Received: from main.gmane.org ([80.91.229.2]:61861 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932160AbVIORvt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 13:51:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EFxtX-0002Da-QF
	for git@vger.kernel.org; Thu, 15 Sep 2005 19:51:35 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 19:51:35 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 19:51:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:rKnNg/Xhmrx8+9dgP/rn2cioCz0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8618>

Linus Torvalds <torvalds@osdl.org> writes:

> They have "sensible-pager", but not "less"?

No, you read my message wrong, or I failed to describe it properly.

sensible-pager is just an indirection that uses your preferred pager.
This will usually be less, but if a user prefers to use e.g. "w3m" (or
"more") that can be done by reconfiguring a symlink (using the
update-alternatives program, or even a GUI such as galternatives).

So no, they haven't replaced less with sensible-pager.  They just
provided another way to select which pager you want.  Setting $PAGER
will still work the trick.

Running "sensible-pager" will check $PAGER an run that if set,
otherwise run the pager selected via the alternatives sytem, which
will usually be "less".  The alternatives selection is done with a
symlink called "/usr/bin/pager".

The advantage is, I guess, consistency.  Different programs don't have
to encode their own default pager.

To summarize: on a Debian system with "less" as the preferred pager,
these four invokations are equal:

  $ ${PAGER:-less}
  $ sensible-pager
  $ pager
  $ less

If you set $PAGER to something else, the first two variants will run
$PAGER, while the last two will still run "less".

--=20
David K=E5gedal
