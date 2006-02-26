From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Sun, 26 Feb 2006 15:33:10 -0500
Message-ID: <20060226203310.GB30735@trixie.casa.cgf.cx>
References: <43FB9656.8050308@vilain.net> <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com> <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 26 21:33:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDSZu-0004ip-Tv
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 21:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWBZUdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 15:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWBZUdM
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 15:33:12 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:12744 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751005AbWBZUdK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 15:33:10 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 84BF813C3E2; Sun, 26 Feb 2006 15:33:10 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <43FDB8CC.5000503@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16797>

On Thu, Feb 23, 2006 at 02:29:48PM +0100, Andreas Ericsson wrote:
>Alex Riesen wrote:
>>On 2/23/06, Andreas Ericsson <ae@op5.se> wrote:
>>
>>>Not to be unhelpful or anything, but activestate perl seems to be quite
>>>a lot of bother. Is it worth supporting it?
>>
>>
>>It's not activestate perl actually. It's only one platform it also
>>_has_ to support.
>>Is it worth supporting Windows?
>
>
>With or without cygwin? With cygwin, I'd say "yes, unless it makes 
>things terribly difficult to maintain and so long as we don't take 
>performance hits on unices". Without cygwin, I'd say "What? It runs on 
>windows?".
>
>If we claim to support windows but do a poor job of it, no-one else will 
>start working on a windows-port. If we don't claim to support windows 
>but say that "it's known to work with cygwin, although be aware of these 
>performance penalties...", eventually someone will come along with their 
>shiny Visual Express and hack up support for it, even if some tools will 
>be missing and others unnecessarily complicated.

Well, with Cygwin, you've at least got the ear of one of the Cygwin
maintainers, which should be worth something.

Even if I disappear, you can always send concerns to the Cygwin mailing
list.  Do the ActiveState folks respond to complaints about things as
basic as pipes not working in perl?

Cygwin's goal is to make Windows look as much like Linux as we can
manage, so, unless we're total incompetents (which has been hinted in
this mailing list from time to time), it has *got* to be better,
source-code-wise to target Windows-running-Cygwin than
just-plain-Windows.  However, as has been noted, that means that there
will be a speed tradeoff.

I think that, for most projects, the convenience of not having to
clutter the code with substantial accommodations for the windows/POSIX
mismatch usually offsets the annoyance of the speed penalty.  Maybe
that's not the case for git, however.

Anyway, we're willing, within the limits of available time, to help out
where git uncovers issues with Cygwin.  I just fixed some stuff in
dirent.h in the last Cygwin release, as a direct result of people noting
a problem here.  Basically, I don't want git to be a morasse of #ifdef
__CYGWIN_'s and I'll do whatever I can to help.

We're always trying to tweak things to improve speed in Cygwin and am
open to intelligent suggestions about how we can make things better.
The dance between total linux compatibility and speed is one that we
struggle with all of the time and, sadly, over time, we've probably
sacrificed speed in the name of functionality.  That's probably because
it's easy to fix a problem like "close-on-exec doesn't work for sockets"
and feel good that you've fixed a bug even if you've just added a few
microseconds to fork/exec.

cgf
