From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 10:21:27 +0200
Organization: At home
Message-ID: <e6dvds$oes$1@sea.gmane.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com> <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org> <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org> <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com> <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org> <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com> <87y7w5lowc.wl%cworth@cworth.org> <Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jun 10 10:21:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Foyiq-0003Bm-GW
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 10:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWFJIV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 04:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWFJIV2
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 04:21:28 -0400
Received: from main.gmane.org ([80.91.229.2]:14306 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030376AbWFJIV2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 04:21:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Foyij-0003Ai-1u
	for git@vger.kernel.org; Sat, 10 Jun 2006 10:21:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 10:21:25 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 10:21:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21600>

Linus Torvalds wrote:


> On Fri, 9 Jun 2006, Carl Worth wrote:
> 
>> On Fri, 9 Jun 2006 22:21:17 -0400, "Jon Smirl" wrote:
>> > 
>> > Could you clone the repo and delete changesets earlier than 2004? Then
>> > I would clone the small repo and work with it. Later I decide I want
>> > full history, can I pull from a full repository at that point and get
>> > updated? That would need a flag to trigger it since I don't want full
>> > history to come over if I am just getting updates from someone else's
>> > tree that has a full history.
>> 
>> This is clearly a desirable feature, and has been requested by several
>> people (including myself) looking to switch some large-ish histories
>> from an existing system to git.
> 
> The thing is, to some degree it's really fundamentally hard.
> 
> It's easy for a linear history. What you do for a linear history is to 
> just get the top commit, and the tree associated with it, and then you 
> cauterize the parent by just grafting it to go away. Boom. You're done.
> 
> The problems are that if the preceding history _wasn't_ linear (or, in 
> fact, _subsequent_ development refers to it by having branched off at an 
> earlier point), and you try to pull your updates, the other end (that 
> knows about all the history) will assume you have all the history that you 
> don't have, and will send you a pack assuming that.

Couldn't it be solved by enhancing initial handshake to send from puller
(object receivier) to pullee (object sender) the contents of graft file, or
better the contents of cauterizing graft file - without splitting graft
file we better have an option to send graft file or not, when graft file is
used to join historical repository line of development not to cauterize
history.

Then the sender would use sent cauterizing history graft file for
calculating which objects to sedn _only_, "in memory" cauterizing it's own
history.

Main disadvantage is if one cauterized history too eagerly, and shallow
clone history can lack merge bases, and have no way to get them _simply_
using this approach...


Now I guess you would tell me why this very simple idea is stupid...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
