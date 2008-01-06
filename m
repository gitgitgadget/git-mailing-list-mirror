From: Sean <seanlkml@sympatico.ca>
Subject: Re: how to use git merge -s subtree?
Date: Sun, 6 Jan 2008 03:06:25 -0500
Message-ID: <BAYC1-PASMTP1079A31936B4563801537DAE4E0@CEZ.ICE>
References: <20080105230004.GY29972@genesis.frugalware.org>
	<BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
	<flpah7$beg$2@ger.gmane.org>
	<BAYC1-PASMTP01FC193EA959D148F19374AE4E0@CEZ.ICE>
	<47803CB6.4050102@gmx.net>
	<7vir277jz6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 09:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBQX1-0008F1-ME
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 09:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbYAFIG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 03:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbYAFIG2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 03:06:28 -0500
Received: from bay0-omc2-s37.bay0.hotmail.com ([65.54.246.173]:24711 "EHLO
	bay0-omc2-s37.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752538AbYAFIG1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2008 03:06:27 -0500
Received: from BAYC1-PASMTP10 ([65.54.191.183]) by bay0-omc2-s37.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 6 Jan 2008 00:06:27 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP10.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 6 Jan 2008 00:06:26 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JBQWP-0006ac-TV; Sun, 06 Jan 2008 03:06:17 -0500
In-Reply-To: <7vir277jz6.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 06 Jan 2008 08:06:27.0142 (UTC) FILETIME=[096BEE60:01C8503B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69715>

On Sat, 05 Jan 2008 18:42:37 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> David Soria Parra <sn_@gmx.net> writes:
> 
> > Well yes the history is preserved, but it's not connected to the
> > subdirectory. So you cannot do git-log B/foo.c as git doesnot know where
> > to search it as it thinks
> > it is in /foo.c not in B/foo.c
> 
> The thing is, what you are talking is not about the subtree
> merge strategy, but the fundamental philosophy of git.  Asking
> for "the history of file B/foo.c" does not make any sense, as
> git never tracks history of individual files.

Hi Junio,

Obviously you are making an important point here about the way Git is designed,
but I think you misspoke slightly.  Asking for the history of a file does make
sense.  Through path limiting you can ask to see just the subset of history that
touched a certain file or directory etc..

In a simple repo where you don't have any subtree merge, with a file /B/foo.c
that at some point earlier in the history was renamed from /foo.c, the command
"git log --follow B/foo.c" will show changes extending back before the rename.
However, that doesn't seem to work across a subtree merge.  Obviously there's
some technical reason for this that i'm overlooking, but on the surface the two
cases seem similar.

It would be nice to be able to do "gitk --follow git-gui.sh" in git.git and
actually see the history of that file.  As it stands now, you have to type
"gitk -- git-gui.sh ../git-gui.sh".  Is there a fundamental reason Git can't
be taught to notice this particular type of subtree merge "rename" and
support --follow type semantics?
 
At least the message you referenced from Linus leaves hope that this may be
possible as it makes the case that this is the type of thing that you can do if
you avoid locking yourself into inadequate rename-tracking data structures.

Sean
