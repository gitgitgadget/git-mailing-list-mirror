From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Thu, 16 Aug 2007 12:00:27 -0700
Message-ID: <7v7invjodw.fsf@gitster.siamese.dyndns.org>
References: <1187026955.2688.4.camel@laptopd505.fenrus.org>
	<1187037445.6628.98.camel@heimdal.trondhjem.org>
	<1187054366.2757.0.camel@laptopd505.fenrus.org>
	<46C10AA8.3090505@gmail.com>
	<20070814102033.604c8695@the-village.bc.nu>
	<46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	<46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost>
	<alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
	<20070814193333.GI21089@ftp.linux.org.uk> <46C2548D.80605@gmail.com>
	<alpine.LFD.0.999.0708151846130.16414@enigma.security.iitk.ac.in>
	<46C30220.6060007@gmail.com>
	<68B09015-4411-470A-BA88-732969469AA2@mac.com>
	<46C42DCB.1060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
	Satyam Sharma <satyam@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 21:01:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILkaV-0005HY-9R
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 21:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758045AbXHPTAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 15:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756988AbXHPTAr
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 15:00:47 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:33900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296AbXHPTAp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 15:00:45 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 51E5B11ED3F;
	Thu, 16 Aug 2007 15:00:51 -0400 (EDT)
In-Reply-To: <46C42DCB.1060502@gmail.com> (Rene Herman's message of "Thu, 16
	Aug 2007 12:58:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56029>

Rene Herman <rene.herman@gmail.com> writes:

> Am looking at it but am not so sure that's a very good idea. I guess
> it'd be largely okay-ish to require the repo to be on a filesystem
> that supports EAs for this feature to work, but keeping the attributes
> intact over file system operations seems not all that easy
> (yet). Having not used EAs before I may be missing something but my
> version of "cp" for example (GNU coreutils 6.9) appears to not copy
> them. Nor do they seem to survive a trip through GNU tar 1.16.1. EAs
> appear to not be very useful unless every single tool supports them --
> a repo should be resistant against simple operations like that.
>
> Googling around, I see subversion already has this and calls the
> meta-data "properties" (svn propset/get and friends). It uses a few
> properties itself, such as the svn:executable property (which I saw is
> also the only permission bit git keeps) and svn:ignore, which serves
> the same role as the .gitignore files for git. Both those would fit
> into this scheme nicely for git as well, if git were to do something
> similar and reserve for example the "git.*" namespace for internal use.
>
> Junio (and others), do you have an opinion on this?

Please step back a bit and imagine a world in which there was no
git.  IOW, you kernel folks switched to tarballs and patches 20
months ago.  It is a far superiour solution compared to CVS and
SVN, so it ought to work, right ;-)?

Now, would you implement the "whom would I send my patches to"
with EAs?

I would hope not.

Git or no git, I think a file that can be viewed with less,
edited with regular editor and processed with sed/perl/grep
tools is the way to go.  I do not think adding 600+ patches to
the single MAINTAINERS list is workable in the longer term, as
it would become the single file many subsystem people need to
update and is asking for merge conflicts, but I think a file
with known name (say, "CcMe.txt") sprinkled in relevant
subdirectories, perhaps with the same format originally
suggested for MAINTAINERS, would make a lot more sense.

That would give people who work with tarballs and patches, or a
subsystem managed with something other than git (one of the most
important one is quilt), the equal access to the necessary data.

Even with git, it is my understanding that kernel community
works largely on patches exchanged over e-mails, between people
who do use git and people who do not.  You would want to have
something you can easily transfer over e-mail in the patch
form.

We _could_ invent a new "patches to properties" git diff output
format that "git apply" can understand to propagate that
information, but that approach is making it less interoperable
with others, and you need to demonstrate the benefit far
outweighs that.  I do not see it for this particular
application.

There may be places for "properties" that would be useful to
git, but I do not think the "find whom to send patches to" is
one of them.
