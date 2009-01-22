From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: CR codes from git commands
Date: Thu, 22 Jan 2009 11:44:03 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901221117110.19665@iabervon.org>
References: <18805.64312.289059.660023@hungover.brentg.com> <alpine.LNX.1.00.0901212319310.19665@iabervon.org> <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com> <alpine.LNX.1.00.0901220238380.19665@iabervon.org> <7vbptzahra.fsf@gitster.siamese.dyndns.org>
 <e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com> <18808.39712.351656.138702@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:45:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2gM-0005OH-KE
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbZAVQoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbZAVQoG
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:44:06 -0500
Received: from iabervon.org ([66.92.72.58]:36744 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbZAVQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:44:04 -0500
Received: (qmail 4800 invoked by uid 1000); 22 Jan 2009 16:44:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2009 16:44:03 -0000
In-Reply-To: <18808.39712.351656.138702@hungover.brentg.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106764>

On Thu, 22 Jan 2009, Brent Goodrick wrote:

> Mike Ralphson writes:
>  > >2009/1/22 Brent Goodrick <bgoodr@gmail.com>:
>  > > The environment I'm running git under is the Shell mode inside GNU
>  > > Emacs. I can't tell you what type of terminal it is, because I believe
>  > > that is defined deep in the guts of Emacs. Having read your reply
>  > > above, I'm now wondering whether this is an Emacs issue versus a git
>  > > issue. If it is an Emacs issue, then I am truly embarrassed for having
>  > > wasted everyones time with it.
>  > 
>  > 2009/1/22 Junio C Hamano <gitster@pobox.com>:
>  > > I think we pay attention to "dumb" when deciding if pager is useful and if
>  > > we can do color, but I do not think we check anything beyond "is it a tty"
>  > > when deciding to show progress or not.  The only thing we do differently
>  > > for "dumb" terminal is if we use ANSI clear-to-eol escape sequence or fill
>  > > with a run of SPs to overwrite trailing part of a line, and we assume even
>  > > dumb terminals know how to do a carriage-return.
>  > 
>  > I think this earlier discussion is probably relevant... I'm guessing
>  > though, $EDITOR is set correctly here 8-)
> 
> I do have EDITOR set to a home-built version of gnuclient, and git
> talks to Emacs by way of that gnuclient just fine when I'm not using the
> -m "commit_message" git-commit option.
> 
>  > 
>  > 2008/12/17 Junio C Hamano <gitster@pobox.com>:
>  > > Any semi-good emacs users (let alone hackers) export PAGER=cat to be used
>  > > in compilation mode (and possibly shell mode), so this is not a problem in
>  > > practice.
>  > >
>  > > I have something like this in my .emacs:
>  > >
>  > >    (setenv "PAGER" "cat")
>  > >
>  > > I suspect (I am just a user not a hacker) this will have bad interaction
>  > > with emacs terminal emulation mode, but I do not use the mode, so it is
>  > > enough for me.
> 
> I have PAGER set to "cat" in the environment before I run Emacs for
> the same reason.
> 
> Unfortunately, this morning when I rebooted and reloaded from scratch,
> I am now unable to reproduce the CR codes output from "git pull" no
> matter what I do. I even tried the older git installed on Debian Linux
> "testing", and tried unsetting PAGER and GIT_PAGER, and saw the pager
> prompts and the terminal escape sequence output as I expected to
> (which is not the issue here).  I can't expect anyone else to help me
> debug this problem further if I can't even reproduce it
> anymore. Frustrating.
> 
> I do have automatic updates turned on, so perhaps something changed in
> the termcap or how terminal I/O is being done outside of git in my
> system.  Emacs would not have changed since I build Emacs from top of
> trunk CVS, and it only uses local Elisp packages AFAIK.
> 
> I don't suppose git has any logic that emits the progress messages
> based upon some estimate of amount of work it has to do, or has done,
> does it?

It does have logic to only emit progress messages at a reasonable rate 
(otherwise, you might be waiting for the progress messages to be printed 
instead of just waiting for the data to arrive). So it's possible that you 
now have things going fast enough that it only needs to print one message. 
It can also estimate that something hasn't taken long enough for the user 
to get impatient yet, and therefore not show progress at all (so the 
output won't be littered with progress output for every operation that 
could have taken a long time for some data, but didn't for this data).

In any case, it's all done in progress.c, so it should be easy enough to 
make changes to if you can come up with something better to do with 
progress messages and some way to determine when it should be done.

	-Daniel
*This .sig left intentionally blank*
