From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #2
Date: Thu, 04 May 2006 11:26:00 +0200
Organization: At home
Message-ID: <e3ch94$o7e$1@sea.gmane.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <e3ce4j$chl$1@sea.gmane.org> <7vwtd240e0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu May 04 11:25:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fba5Q-0002qh-I7
	for gcvg-git@gmane.org; Thu, 04 May 2006 11:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWEDJZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 05:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWEDJZU
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 05:25:20 -0400
Received: from main.gmane.org ([80.91.229.2]:22940 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751458AbWEDJZS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 05:25:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fba54-0002mV-A0
	for git@vger.kernel.org; Thu, 04 May 2006 11:25:06 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 May 2006 11:25:06 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 May 2006 11:25:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19561>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>>   I am beginning to think using "graft" to cauterize history
>>>   for this, while it technically would work, would not be so
>>>   helpful to users, so the design needs to be worked out again.
>>
>> Perhaps use comment for marking graft as cauterizing history?
> 
> ?

For example:

# begin shallow clone
<sha1 of commit 1> # no parents... - cut-off commit
<sha1 of commit 2>
...
<sha1 of commmit n>
# end shallow clone

I don't think it is very good idea, though...

>> There was also talk about proposed git-splithist, which would move some
>> of the history to other (historical, archive) repository.
> 
> I stayed out from that discussion, but my impression was that
> you could essentially do the same thing as what Linus did when
> he started the recent kernel history since v2.6.12-rc2 without
> any tool support.
> 
> The older kernel history from BKCVS was resurrected later by
> independent parties and Linus's history can be grafted onto it,
> but if you have an existing history stored in git, you could do:
> (1) take a snapshot of the tip of your development with "git
> tar-tree HEAD"; (2) extract it into an empty repository and
> start a new history; (3) build on top of the truncated history;
> and (4) graft that onto the history that stopped at (1), which
> you tentatively abandoned, as needed.

I have thought about splitting not at current tip(s), but for example at 1
year ago. Current repository would have history cautherized using grafts
(although it would be nice to have option to omit grafts and reach to
historic repository), and archive/history repository ending with commits up
to (but not including) the cut-off (cauterization) points.

IIRC the problem with 'shallow clone' was telling which commits the clone
has, and how to join commits and recauterize history.

-- 
Jakub Narebski
Warsaw, Poland
