From: tactical <a5158017@nepwk.com>
Subject: Re: More Beginning Git Questions
Date: Sun, 25 Sep 2011 22:07:24 +0100
Message-ID: <1ttmqsxtaj98i$.hv6s5shjeugr.dlg@40tude.net>
References: <4E7C9AAD.7060209@gmail.com> <m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com> <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net> <op.v2byz2p80aolir@keputer.lokaal> <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net> <201109242259.p8OMxqIM026259@no.baka.org> <1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net> <m31uv4rc47.fsf@localhost.localdomain> <1rwoliveqwr1v.u3bsx5axtgsb$.dlg@40tude.net> <m3oby8pcfz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 23:09:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7vxI-0003YT-8f
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 23:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab1IYVHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 17:07:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:53414 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182Ab1IYVHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 17:07:42 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R7vvI-0002sn-Te
	for git@vger.kernel.org; Sun, 25 Sep 2011 23:07:40 +0200
Received: from 31.64.20.134 ([31.64.20.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 23:07:40 +0200
Received: from a5158017 by 31.64.20.134 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 23:07:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 31.64.20.134
User-Agent: 40tude_Dialog/2.0.15.84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182084>

Jakub Narebski wrote:

>>> With merging into branch with uncomitted changes your fairly well
>>> understood 3-way merge (sometimes virtual 3-way merge in the case of
>>> multiple common ancestors) would turn into 4-way merge.
>> 
>> I don't see why it would be a four-way merge rather than a three-way merge.
> 
> You have four version: "base" (ancestor version), "theirs"
> (branch/clone being merged), "ours" (comitted changes on current
> branch) and "new" (uncomitted changes on current branch).
> 
> Unless Mercurial does 3-way merge of "new", "theirs" and "base"...
> with transaction based atomicity (saving "new" before attempting
> merge) they can do that.

I've not read the code, but surely Mercurial does a three-way merge here.
It wouldn't be sane to do anything else.

>>> What you use uncomitted changes for, I would use is a separate branch,
>>> and keep it rebasing (something like using 'mq' in Mercurial).
>> 
>> Yes, but, as I mentioned, rebasing is less flexible.  A rebase here is
>> effectively a merge and a commit in one step, whereas my approach separates
>> the merge and the commit.
> 
> Errr... what?  You first commit your changes, then keep it rebasing to
> keep them up to date on top of fresh version.

Like I said before, with my approach, after I merge, I can check that
everything still compiles, that unit tests still pass, and so on, before
finally checking in.  Rebasing, on the other hand, is essentially merging
and checking in in one step.  *After* you've rebased, you can run unit
tests, etc., but you've *already* checked in at that point.  (Sure, you
could then mutate history if need be, but it's rather less flexible than my
approach, where the check-in is not made until desired.)

>>> What do you use anonymous branching for?
>> 
>> Anonymous branching is great for minor divergence that isn't really
>> significant enough to deserve a name.  It's also great for branches that
>> *are* significant enough to deserve a name, but where you want to defer
>> naming the branch right up until you merge it into another branch.  At that
>> point you can 'name' the branch in the commit message.
> 
> I think you can use detached HEAD for that, at least when working on
> one issue at a time (you have to name branch when switching to some
> other work).

But in Mercurial I can switch between anonymous branches as much as I like
without anything ever being deleted.

>> From what I read, detached heads are subject to garbage collection.
>  
> No, HEAD is protected against garbage collecting.  To be sure you
> should name a branch when switching branches, though reflog would
> protect you for 30 days (by default) even if you don't do that.

So Git doesn't really support anonymous branching as part of a normal
workflow.
