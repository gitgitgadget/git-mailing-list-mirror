From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Tue, 02 Jan 2007 09:32:30 -0800
Message-ID: <7vps9xwd01.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<20061223051210.GA29814@segfault.peff.net>
	<7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
	<7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
	<20070102144940.GA23932@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 18:32:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1nV8-0006rV-RV
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 18:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbXABRcc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 12:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbXABRcc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 12:32:32 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:62148 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbXABRcb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 12:32:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102173230.VMHH16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 12:32:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6HXj1W00M1kojtg0000000; Tue, 02 Jan 2007 12:31:44 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070102144940.GA23932@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 2 Jan 2007 09:49:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35792>

Jeff King <peff@peff.net> writes:

> On Sat, Dec 23, 2006 at 01:51:03AM -0800, Junio C Hamano wrote:
>
>> If you (or other people) use branch.*.merge, with its value set
>> to remote name _and_ local name, and actually verify that either
>> form works without confusion, please report back and I'll apply.
>
> This [using tracking branches in branch.*.merge] seems to be working for
> me, but it is possible to get some confusing results with it. Try this
> config:
>
> [remote "origin"]
>   url = /my/other/git/repo
>   fetch = refs/heads/master:refs/heads/origin
>   fetch = refs/heads/origin:refs/heads/junio
> [branch "master"]
>   remote = origin
>   merge = refs/heads/origin
>
> That is, we have a local tracking branch 'X' which has the same name as
> a remote branch 'X'. When we fetch, both will be marked for merge in
> FETCH_HEAD, and git-pull will attempt to do an octopus.
>
> Is this too convoluted a config to worry about (no, I don't actually do
> this in my repository -- I just constructed the most plausible reason I
> could think of for having conflicting names). I actually think having a
> branch.*.mergelocal would make just as much sense and would be more
> robust (plus, it should be safe and sensible for "git-checkout -b foo
> bar" to point branch.foo.mergelocal to refs/heads/bar).

If we are to worry about, and I think we might have to, I think
not worrying about mergelocal and not accepting the name of
local tracking branch is the only sensible thing to do.

Is there a problem if we did that?  I do not think of any.
