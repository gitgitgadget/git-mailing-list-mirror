From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 17:05:23 +0200
Message-ID: <4534F133.1090003@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <45348B5E.8000404@op5.se> <4534E335.8070203@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 17:06:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZqVa-00024O-NN
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 17:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWJQPFb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 11:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWJQPFb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 11:05:31 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:65162 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751101AbWJQPFa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 11:05:30 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 4FFE56BD77; Tue, 17 Oct 2006 17:05:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3A5746BDE4; Tue, 17 Oct 2006 17:05:24 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <4534E335.8070203@utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29085>

Aaron Bentley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Andreas Ericsson wrote:
>> Aaron Bentley wrote:
> 
>>> When two people have copies of the same revision, it's usually because
>>> they are each pulling from a common branch, and so the revision in that
>>> branch can be named.  Bazaar does use unique ids internally, but it's
>>> extremely rare that the user needs to use them.
>>>
>> Well, if two people have the same revision in git, you *know* they have
>> pulled from each other
> 
> No, you don't.  They may have each pulled from a different repository.
> 

I realized it as I read it now. What I meant was that you know you have 
the exact same revision as the original author once committed.

> 
>>> But tags have local meaning only, unless someone has access to your
>>> repository, right?
>>>
>> I imagine the bazaar-names with url+number only has local meaning unless
>> someone has access to your repository too.
> 
> Yes.  That phrasing was from Linus' description of revnos.
> 
>> One of the great benefits of
>> git is that each revision is *always exactly the same* no matter in
>> which repository it appears. This includes file-content, filesystem
>> layout and, last but also most important, history.
> 
> In Bazaar, a revision id always refers to the same logical entity, but
> it may be stored in different formats in different repositories.
> 

This I don't understand. Let's say Alice has revision-154 in her repo, 
located at alice.example.com. Let's say that commit is accessible with 
the url "alice.example.com:revision-154". Bob pulls from her repo into 
his own, which is located at bob.example.com.

Lots of questions here, so I'll split them up. Feel free to delete the 
non-applicable ones.

Will the commit in Bob's repo be accessible at 
"bob.example.com:revision-154"?

If it's not, how can you backtrack from old bugreports and find the 
error being discussed?

If it is, how does that work if Bob suddenly wants to commit things 
before Alice is done working with her changes?

Also, suppose they both push to a master-repo where Caesar has pushed 
his changes and nicked the slot for revision-154. Does the master repo 
re-organize everything and then invalidate Bob's and Alice's changes, or 
does it tell Alice and Bob that they need to update and then reorganize 
their repos before they're allowed to push?

I really can't get my head around the usefulness of revision-numbers 
hopping around which is probably why I'm having such a trouble groking 
how it works.

> 
>>> - - you can use a checkout to maintain a local mirror of a read-only
>>>   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
>>>
>> Check. Well, actually, you just clone it as usual but with the --bare
>> argument and it won't write out the working tree files.
> 
> No, I *want* the working tree files.  I run bzr from a checkout of bzr.dev.
> 

You get the working tree files by default. Use --bare if you don't want 
them to be checked out (i.e. written to the working tree) after the 
clone is complete.

>>> You can operate that way in bzr too, but I find it nicer to have one
>>> checkout for each active branch, plus a checkout of bzr.dev.  Our switch
>>> command also rewrites only the changed part of the working tree.
>>>
>> Works in git as well, but each "checkout" (actually, locally referenced
>> repository clone) gets a separate branch/tag namespace.
> 
> In our terminology, if it can diverge from the original, it's a branch,
> not a checkout.
> 

This clears things up immensely. bazaar checkout != git checkout.
I still fail to see how a local copy you can't commit to is useful, but 
it doesn't really matter to me as I've already found a tool that does 
everything I want wrt scm needs.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
