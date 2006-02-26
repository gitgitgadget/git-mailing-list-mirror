From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Sun, 26 Feb 2006 14:55:52 -0500
Message-ID: <20060226195552.GA30735@trixie.casa.cgf.cx>
References: <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com> <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 26 20:56:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDRzo-00042W-Cs
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 20:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWBZTzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 14:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWBZTzy
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 14:55:54 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:19430 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751397AbWBZTzx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 14:55:53 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id E064413C3E3; Sun, 26 Feb 2006 14:55:52 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16790>

On Thu, Feb 23, 2006 at 03:07:07PM +0100, Alex Riesen wrote:
>On 2/23/06, Andreas Ericsson <ae@op5.se> wrote:
>>>>Not to be unhelpful or anything, but activestate perl seems to be quite
>>>>a lot of bother.  Is it worth supporting it?
>>>
>>>
>>>It's not activestate perl actually.  It's only one platform it also
>>>_has_ to support.  Is it worth supporting Windows?
>>
>>With or without cygwin?  With cygwin, I'd say "yes, unless it makes
>>things terribly difficult to maintain and so long as we don't take
>>performance hits on unices".  Without cygwin, I'd say "What?  It runs
>>on windows?".
>
>There not much difference with or without cygwin.  The penalties of
>doing any kind of support for it will pile up (as they started to do
>with pipes).  Someday we'll have to start dropping features on Windows
>or restrict them beyond their usefullness.  The fork emulation in
>cygwin isn't perfect,

If the speed of cygwin's fork is an issue then I'd previously suggested
using spawn*.  The spawn family of functions were designed to emulate
Windows functions of the same name.  They start a new process without
the requirement of forking.

>signals do not work reliably (if at all),

I'm not sure if you're mixing cygwin with windows here but if signals do
not work reliably in Cygwin then that is something that we'd like to
know about.  Signals *obviously* have to work fairly well for programs
like ssh, bash, and X to work, however.

Native Windows, OTOH, hardly has any signals at all and deals with
signals in a way that is only vaguely like linux.

>filesystem is slow and locked down, and exec-attribute is NOT really
>useful even on NTFS (it is somehow related to execute permission and
>open files.  I still cannot figure out how exactly are they related).

Again, it's not clear if you're talking about Windows or Cygwin but
under Cygwin, in the default configuration, the exec attribute means the
same thing to cygwin as it does to linux.

As always, if you have questions or problems with cygwin, you can ask in
the proper forum.  The available cygwin mailing lists are here:
http://cygwin.com/lists.html.

Would getting git into the cygwin distribution solve any problems with
git adoption on Windows?  This would get an automatic green light from
anyone who was interested, if so.  Someone would just have to send an
"ITP" (Intent To Package) to the cygwin-apps mailing list and provide a
package using the guidelines here: http://cygwin.com/setup.html .

cgf
--
Christopher Faylor			spammer? ->	aaaspam@sourceware.org
Cygwin Co-Project Leader
TimeSys, Inc.
