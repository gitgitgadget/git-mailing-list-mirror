From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Merges without bases
Date: Fri, 09 Sep 2005 06:02:52 -0600
Message-ID: <m1hdcuo3df.fsf@ebiederm.dsl.xmission.com>
References: <1125004228.4110.20.camel@localhost.localdomain>
	<7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508252333550.23242@iabervon.org>
	<7vzmr5gmb4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 14:06:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDhbf-0001Gb-OX
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 14:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVIIMDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 08:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVIIMDg
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 08:03:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50624 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932533AbVIIMDf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2005 08:03:35 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j89C2v9g008711;
	Fri, 9 Sep 2005 06:02:57 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j89C2spE008710;
	Fri, 9 Sep 2005 06:02:54 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmr5gmb4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 26 Aug 2005 01:00:15 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8237>

Junio C Hamano <junkio@cox.net> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> I'd still like to revive my idea of having projects overlaid on each
>> other, where the commits in the project that absorbed the other project
>> say, essentially, "also include this other commit, but any changes to
>> those files belong to that branch, not this one". That way, Linus could
>> have included gitk in git, but changes to it, even when done in a git
>> working tree, would show up in commits that only include gitk. (git
>> actually can handle this with the alternative index file mechanism that
>> Linus mentioned in a different thread.)
>
> Yes, I would love to see that cleanly done in a way that does not
> confuse uninitiated (not being sarcastic at all.  Just cheering
> up somebody with a better idea than I have --- I would be lost
> if I were to be tasked to do it by Emperor Penguin himself or
> somebody else ;-)).

I think when it comes to simplicity it would be better to have 
something that would filter all of the changes on a branch
by pathname and create a branch against the original project
with just those changes.

Then we can do the noop merge of that branch into the larger
project, and we can merge that branch into the original project.

The nice part of doing it after the fact by just filtering changes
is you don't have to plan ahead to handle that case, which
should be a lot easier to handle.

The set of pathnames to filter could be easily stored in the .git
metadata so doing repeatedly is straight forward.

Eric
