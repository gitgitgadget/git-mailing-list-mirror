From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 09:29:14 -0400
Message-ID: <20070728092914.48f6305c.seanlkml@sympatico.ca>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
	<7vodhwptba.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 15:30:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEmNF-0000VJ-Ti
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 15:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbXG1NaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 09:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbXG1NaW
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 09:30:22 -0400
Received: from bay0-omc1-s23.bay0.hotmail.com ([65.54.246.95]:43674 "EHLO
	bay0-omc1-s23.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751158AbXG1NaV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 09:30:21 -0400
Received: from BAYC1-PASMTP05.bayc1.hotmail.com ([65.54.191.165]) by bay0-omc1-s23.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 28 Jul 2007 06:30:21 -0700
X-Originating-IP: [69.156.137.240]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.137.240]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 28 Jul 2007 06:30:20 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IEmN9-0001pk-L7; Sat, 28 Jul 2007 09:30:19 -0400
In-Reply-To: <7vodhwptba.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 28 Jul 2007 13:30:20.0887 (UTC) FILETIME=[71EA9670:01C7D11B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54032>

On Sat, 28 Jul 2007 06:10:49 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> In short, your original commit log message is broken.
> 
> The recommended convention for commit messages is to start it
> with a single line that describes what it does, followed by a
> blank line (i.e. the first paragraph consists of a single line),
> followed by a longer explanation of why the change brought by
> the commit is a good thing.

That explains why I hadn't seen the problem before, since I
usually follow the commit message convention.  For testing
purposes I had simply mashed the home row to add five or
six lines without thinking...

> Following this convention is recommended to make other peoples'
> lives more pleasant, and git assumes you follow this convention
> at several places.  For example, "git log --pretty=oneline",
> "git reflog", and "git show-branch" are ways to get concise
> listing of commits; git-shortlog gives the list of such commit
> titles in its output, omitting the longer explanation.  Patches
> prepared for e-mail exchange ("git format-patch", and
> --pretty=email) use the title on the Subject: line of the
> message.  

Yes, Bisecting shows this "problem" was introduced in your
commit 4234a76167 which mentions that commit messages following
the normal convention would be unaffected.

...[SNIPPED]...
> Having said all that, so that the readers understand the
> background, here is a not-so-heavily-tested patch, which might
> help.  It passes all the test suite as before, but that tells
> how existing git-svn tests do not test many things.
> 
> I am not considering this for inclusion right now, by the way.

FWIW your patch fixed my test case here.

Cheers,
Sean
