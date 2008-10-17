From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Working with remotes; cloning remote references
Date: Fri, 17 Oct 2008 17:08:14 +0200
Message-ID: <48F8AA5E.6090908@drmicha.warpmail.net>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 17:11:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqqyg-000417-RB
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 17:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbYJQPIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 11:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756740AbYJQPIT
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 11:08:19 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33954 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756319AbYJQPIR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2008 11:08:17 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B67271814AE;
	Fri, 17 Oct 2008 11:08:16 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 17 Oct 2008 11:08:16 -0400
X-Sasl-enc: iTaWrUthVFUhhWQIBrNK8CxoGMeHsn/QdUufMYvDZbOE 1224256096
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BCBE82CB5E;
	Fri, 17 Oct 2008 11:08:15 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <48F8A4E8.8070008@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98481>

Marc Branchaud venit, vidit, dixit 17.10.2008 16:44:
> Thanks for joining the thread, Michael!

Sure, there's no need to mention it.

Well, maybe there is, given the recent discussion: Everyone can
contribute (with or without C/perl/whatever fu) and thus "pay back" for
free software, even by "only" trying to answer questions. But it
requires participation, combining efforts, rather than splitting off and
not returning... Uh, sorry, your question:

> Michael J Gruber wrote:
>> Would it be sufficient for you if a clone could trigger the main repo to
>> update its remotes (i.e. git remote update)?
> 
> Hmmm, I'm not sure...  How would the overall 
> merge-in-changes-from-upstream process work in that case?

I thought your problem was "transporting" the remote branches from main
(which tracks external) to clone, without having the remote config for
external on the clones. In that case being able to trigger "remote
update" on main from the clones would help.

> Say the main repo has the code for "ThingOne" merged under a top-level 
> thing-one/ directory:
> 
> main/$ git remote add -f ThingOne git://thing/ThingOne.git
> main/$ git merge -s ours --no-commit ThingOne/master
> main/$ git read-tree --prefix=thing-one/ -i ThingOne/master
> main/$ git commit -m "Merged ThingOne into /thing-one/"
> 
> Then the ThingOne folks update their code, so we want to incorporate 
> their changes into our version of their code.  I think you're suggesting 
> that we might make a clone of the main repo then trigger a "git remote 
> update" in the clone's origin:
> 
> clone/$ make-origin-do-git-remote-update
> 
> What's not clear to me is how to proceed from here.  At this point I'm 
> hoping there's some way I could do some work in the clone to merge the 
> changes the ThingOne folks did into our code.  I'm too new to git to 
> know if there is a way forward -- is there?
> 
> (With the subtree merge pattern I'd run "git pull -s subtree ThingOne 
> master" in the main repo -- is there an equivalent achievable in the 
> clone if the main has done a "git remote update"?)

"pull -s strategy repo master" does a fetch followed by "merge -s
strategy repomaster", where repomaster is the ref for master on repo.
So, if you got that branch (repomaster=ThingOne/master) by cloning from
main you can do the merge (subtree or other) on your clone, even without
the remote repo config for ThingOne on clone.

I guess you want to do those merges on several clones, and main, and
push everything back to main. I don't know how well that mixes, but I
don't expect problems, only unexpected ones ;)

Cheers,
Michael
