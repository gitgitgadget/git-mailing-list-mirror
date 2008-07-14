From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git-rebase eats empty commits
Date: Mon, 14 Jul 2008 17:01:08 +0200
Message-ID: <g5fpnm$3jb$1@ger.gmane.org>
References: <g4vrrm$g35$1@ger.gmane.org> <20080712221207.GB22323@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 17:02:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIPZC-00066Q-8t
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 17:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbYGNPBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 11:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbYGNPBU
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 11:01:20 -0400
Received: from main.gmane.org ([80.91.229.2]:59886 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbYGNPBT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 11:01:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KIPYD-00056j-Ae
	for git@vger.kernel.org; Mon, 14 Jul 2008 15:01:17 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 15:01:17 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 15:01:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080712221207.GB22323@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88431>

Stephan Beyer venit, vidit, dixit 13.07.2008 00:12:
> Hi,
> 
> Michael J Gruber wrote:
>> "git commit" allows empty commits with the "--allow-empty" option, i.e.  
>> commits which introduce no change at all. This is sometimes useful for  
>> keeping a log of untracked work related to tracked content.
>>
>> "git rebase" removes empty commits, for the good reason that rebasing  
>> may make certain commits obsolete; but I don't want that in the case  
>> mentioned above. Is there any way to specify "--preserve-empty" or 
>> similar?
> 
> First I can speak for git-sequencer: there is no such thing as a
> "preserve empty" option, but currently, when you are picking a commit
> that has already been applied so that no changes occur, it will pause.
> (It will not pause if it is a fast-forward.)
> Yet, I was unsure if this is a "correct" behavior, but it seemed to be
> useful, because you can inspect the situation.
> 
> In my mind, the same should happen with an empty commit, so I tested it:
>  1. It pauses.
>  2. In that pause I only need to run "git commit --allow-empty" and I have
>     the picked empty patch with that commit message.
> 
> So if this behavior is kept, there is no such need for such an option.
> 
> Now I'm checking it with the old rebase-i (I'm always referring to
> git-rebase--interactive as rebase-i) and exactly the same behavior
> occurs.
> 
> But rebase is not rebase-i.
> So I've also checked both, pure rebase and rebase-m: then the empty commit
> is lost.
> 
> To sum up, use rebase -i and when it's pausing, do "git commit --allow-empty"
> and then "git rebase --continue" and you have what you want.

I assume this is with git from master? With git 1.5.6.2 rebase -i 
doesn't stop there, not even when I change "pick" to "edit"!

So, I guess for now I'll use my hacked git-rebase ("-m", I didn't hack 
git-format-patch), maybe 1.6.0 will behave as described above. Anyway 
thanks for the hint about distinguishing between rebase and rebase -i.

Michael
