From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] git-commit.sh: convert run_status to a C builtin
Date: Thu, 07 Sep 2006 22:56:11 -0700
Message-ID: <7v64fynbpg.fsf@assigned-by-dhcp.cox.net>
References: <64c62cc942e872b29d7225999e74a07be586674a.1157610743.git.peff@peff.net>
	<20060907063621.GC17083@coredump.intra.peff.net>
	<7vzmdbqke3.fsf@assigned-by-dhcp.cox.net>
	<20060908054226.GA19537@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 07:56:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLZLJ-0000jA-4W
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 07:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbWIHFzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 01:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbWIHFzy
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 01:55:54 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20130 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1752221AbWIHFzw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 01:55:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908055551.HGIL2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 8 Sep 2006 01:55:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Khvj1V00H1kojtg0000000
	Fri, 08 Sep 2006 01:55:44 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060908054226.GA19537@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 8 Sep 2006 01:42:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26678>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 07, 2006 at 05:20:20PM -0700, Junio C Hamano wrote:
>
>> "status.h" and "struct status" somehow sounds too broad.
>> Granted, "object.h" is also broad, but in git context "object"
>> has a specific meaning.
>
> I agree it is quite broad (as is git-runstatus). Conceptually it's
> another type of diff format, but making it a diff argument doesn't
> really makes much sense. We're at least not introducing any broadness,
> since there is already git-status; are we interested in fixing that
> name?

The command name is a name exposed to the end user.  We do not
currently have a command to give "repository status", and even
if we had one such a specialized command for repository
administrators would be called git-repository-status so
git-status is definitely fine as is.

I just wanted to point it out because I felt the names to
programmers are slightly different matter.

> wt_status? ucu_status (updated, changed, untracked)?

Yeah, something along those lines.

>> Very nicely done.  Especially I liked that you are careful not
>> to paint leading '#\t' (which is noticeable when you use reverse
>> as an attribute).
>
> Yes. I seem to recall some issues raised about color attributes
> persisting over a newline, but I can't find any reference to it now.
> Using color_printf makes sure every color is 'closed' but it sometimes
> includes the newline in the colorized portion. Does anybody object to
> that?

In a distant past I saw some terminals get confused near the
edge if you do that, but these days everybody is on some sort of
Xterm so it may not matter.  But that would probably be nice to
fix.

> OK. Besides the things you mentioned, what improvements would you like
> to see?

Besides the things I mentioned?  I dunno offhand -- otherwise I
would have mentioned them ;-).
