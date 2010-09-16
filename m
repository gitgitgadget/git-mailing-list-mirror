From: Kent Borg <kentborg@borg.org>
Subject: Re: git-p4
Date: Thu, 16 Sep 2010 08:14:19 -0400
Message-ID: <4C920A1B.1030707@borg.org>
References: <4C8A8CE8.90600@borg.org>	<20100910235323.773d2c5b@varda>	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>	<4C8CF231.6090403@borg.org>	<AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>	<4C8D14F9.90705@borg.org>	<AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>	<4C8D3303.1030302@borg.org>	<AANLkTikrSt4djXep-o4Hr8EZAsiNXnqCHa2fLrys8T==@mail.gmail.com>	<4C8E33DF.7010904@borg.org>	<AANLkTimL3mB8LeUOANsJO7p9uwqDCN9wKnLVMTq_-=3H@mail.gmail.com>	<4C8E511F.8000400@borg.org> <AANLkTingvEFDygkKipBXfCHJr2=oMQrYv3FKpxpo+TkW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 14:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwDMF-0004c4-BL
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 14:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab0IPMO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 08:14:26 -0400
Received: from borg.org ([64.105.205.123]:52377 "EHLO borg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab0IPMOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 08:14:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: kentborg)
	by borg.org (Postfix) with ESMTP id 86FCD878D6;
	Thu, 16 Sep 2010 08:14:21 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <AANLkTingvEFDygkKipBXfCHJr2=oMQrYv3FKpxpo+TkW@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156326>

Tor Arvid Lund wrote:
> Well, then I think you are a bit confused ;)
>   

That I know is true, but I am making progress.

 - I have "git p4 rebase"-d changes from p4 world out to
   git.  More than once even.

 - I have "git p4 submit"-ted changes from git back into
   p4 world.  Again, more than once.

 - I can pull and push from/to this git repository to my primary git
repository.

> The p4/master branch is git's view of your p4 history. So p4/master
> points to the most recent git/perforce commit. 

Yes.

> An important side point
> here, is that if you have another remote (which you do in your case)
> that is a pure git remote that knows nothing about p4, then the
> p4/master branch and the origin/master branch will be disjoint.
>   

That, I think I fixed!  The first commit on the p4/master branch used to
be a sync from p4, but after surgery on branch references (correct
term?) my gateway git-p4 repository's p4/master branch now has history
all the way back to the beginning of time in the git universe (back to
good ol' Linux 2.6.12-rc2).  The recent commits have git-p4 comments
that mark the matching p4 changesets.  I am not sure exactly how I did
it, but it seems that doing a "git-p4 rebase" instead of "git-p4 sync"
made my surgery work.

One odd thing that had me worried was seeing the git side of the gateway
repository show a single history back and then show a short split
history and then a single history, flopping as I ran transactions
through it.  I am not sure what was going on, but I think git-p4 is
doing an amend of the last commit to put its notes in the message, and
if I have anything newer hanging from that commit this is a very bad
thing.  I am still worried but less so as long as I behave myself about
not expecting it to make amendments to anything but the newest commits.

Part of the consideration is to simply be very aware of those "[git-p4:
..." notes and decide where this should propagate to and design the
workflow accordingly.  (lkml probably won't want to see p4 notations...)

But anyway, I seem to have git-p4 working in both directions, with a
complete beginning-of-time history on the git side.


Tor Arvid: I owe you a beer (or whatever you drink when someone offers
you a beer), how often do you visit Boston?


Thanks for everyone's patience with a newbie,

-kb
