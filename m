From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 22:37:05 +0200
Message-ID: <87sk6n4426.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 22:38:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O53AR-00011k-6d
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758500Ab0DVUhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 16:37:20 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:58258 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab0DVUhN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 16:37:13 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id F137B15E6FDAD;
	Thu, 22 Apr 2010 22:37:10 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5394-0003be-00; Thu, 22 Apr 2010 22:37:10 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O538z-0001Qn-Eq; Thu, 22 Apr 2010 22:37:05 +0200
In-Reply-To: <alpine.LFD.2.00.1004221445310.7232@xanadu.home> (Nicolas Pitre's
	message of "Thu, 22 Apr 2010 15:03:07 -0400 (EDT)")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX19F8A/5v96kopKdulTr+iR+V98fLsMGR6NNBj18
	bfx5jrK2fKtdghMqgeoKvr2DDcLnkN0ozxBAO8uMP72rHv6ySs
	Azmjd0w1g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145558>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Thu, 22 Apr 2010, Goswin von Brederlow wrote:
>
>> I have never ever needed anything but
>> 
>> git commit -a
>> git commit <file> <file> ...
>
> When I was using CVS/SVN that's what I thought too.
>
>> I do commit often and commit early and I start and finish one thing
>> before I start another. Also I keep my files small so they do one thing
>> and do it well. Overall that means I don't end up with multiple changes
>> in a single file so I never need to cherry pick changes for a commit.
>
> Good for you.  I'm not that disciplined. Hence I often end up working on 
> more than one thing in parallel.  The index is just so incredibly useful 
> in that case.  I'm also a big fan of 'git add -e'.

As soon as you do 'git add -e' then you have an index. In that case a
'git commit' would use the index. There would be no change in worflow or
behaviour for you.

>> So I don't think people should be forced to utilize the index. Imho that
>> is a matter of the workflow people use. Some people work better with the
>> index and some people (or projects) don't need it.
>
> Exact.  It is therefore not progress to impose some inconvenience to one 
> work flow in order to make another one easier.  And in this case we're 
> talking about the difference between having to type an additional -a vs 
> the risk of creating a commit with unexpected content.

Is there a risk? You do get an editor with all the files affected listed
giving you a big fat warning what you are about to commit. Yes I
sometimes do start to commit wrongly too (no matter what RCS used) but
then I just close the editor to abort and commit the things seperately.

>> Alternatively an option to take all changes but only if the index is
>> empty would be helpfull. Then people could define an alias for that or
>> set the option in the config. Other than setting -a that would allow
>> using an index when needed and commit everything in the normal case
>> without having to change the command used to commit.
>
> But you're proposing to change the semantics for that command.  And I 
> also suspect that you're trying to make the index more hidden while what 
> we're actually trying to do is to promote it.

Yes, it would hide the index. But you are not just promoting it. You are
forcing people to always use it, even if only through the -a option.

> What _you_ can do though, is this:
>
> 	git config --global alias.ci "commit -a"

But then when I accidentally use 'git ci' while having an index the
index gets ignored and all changed files get commited in one big mess.
Given how seldom I need an index (so far never) the risk of using 'git
ci' accidentally is way to high. Same with typing -a. I do it so often
that when I actualy don't want it I will probably type it anyway out of
habbit.

My way would be safe in that it will never ignore an index if there is
one. And if it is a new option then it would not alter the existing
semantic, just add to it. Call the option --smart-a or --a-if-empty.

MfG
        Goswin
