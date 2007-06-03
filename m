From: david@lang.hm
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 12:07:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0706031203220.6705@asgard.lang.hm>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org>
 <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net>
 <20070603151921.GB30347@artemis> <vpq1wgtnith.fsf@bauges.imag.fr>
 <20070603160736.GC30347@artemis> <Pine.LNX.4.64.0706031031520.6705@asgard.lang.hm>
 <20070603184957.GE30347@artemis>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 21:07:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuvQ1-0000qe-HV
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 21:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbXFCTGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 15:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbXFCTGv
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 15:06:51 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:37943
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbXFCTGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 15:06:50 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l53J6ZuS019782;
	Sun, 3 Jun 2007 12:06:35 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070603184957.GE30347@artemis>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49023>

On Sun, 3 Jun 2007, Pierre Habouzit wrote:

> 
> On Sun, Jun 03, 2007 at 10:35:48AM -0700, david@lang.hm wrote:
>> On Sun, 3 Jun 2007, Pierre Habouzit wrote:
>>
>>> On Sun, Jun 03, 2007 at 05:44:58PM +0200, Matthieu Moy wrote:
>>>> Pierre Habouzit <madcoder@debian.org> writes:
>>>>
>>>>>  Yeah, now that I read that thread, well yeah, I think notes are a
>>>>> hell
>>>>> of a good concept for my ideas. I mean, a bug report would be
>>>>> basically
>>>>> a collection of notes:
>>>>>  * the bug has been found at this commit ;
>>>>>  * the bug has been not-found at this commit ;
>>>>>  * this commit is a fix for that bug ;
>>>>
>>>> That's my feeling too. "Commiting" bug information in the tree is only
>>>> half of a good idea. You want to be able to say, after the fact, "This
>>>> commit had bug XYZ". OTOH, the idea (followed by bugs everywhere) that
>>>> merging a branch would automatically close bugs fixed by this branch
>>>> is a really cool thing.
>>>
>>> That would work with notes, as while merging you'll get the notes of
>>> the commit in your branch, *and* the note about the fixing patch. So
>>> there is no loss of "concept" here. In fact that was the thing that I
>>> looked for. Notes are good. They just may not be enough to write an
>>> in-git bugtracking tool, as a bug needs the "notes collection" concepts,
>>> and maybe a few other.
>>
>> how would you identify bugs in such a way that they will match up when
>> you merge different trees?
>
>  well, because they will be sha1's, a git object. And when it's a
> duplicate, well, let's face it, not bugtracker helps *automatically*
> tracking duplicates. The merge work is up to the QA people. Yeah,
> bugtracker won't do all the tracking. In a way, that's good, that means
> there is still place for humans in that world :)
>
>> if you can manage to do this it sounds like a great idea. but I'm not
>> seeing a good way to do it at the moment. the answer may be a combination
>> of a number of factors.
>>
>> 1. bug number doesn't work well in a distributed environment
>
>  Sure, SCM revisions either. But git solved that once, I don't see why
> the solution found at that time would be less of a solution now :)

git's tracking of revisions works becouse it's tracking the content, it 
doesn't care _how_ the content got that way, if it's the same it's the 
same and will have the same hash.

with bugs the reports aren't the same so you can use the sha1 to track a 
particular entry/tag/comment but not to identify the bug itself

>> 2. something based on indentifying the cause of the bug (commit id + file
>> + line????) will only work after you know the real cause of the bug
>
>  It does not work in a real world, where real user don't grok code.
>
>> 3. description is worthless, too many ways to describe things that have
>> the same underlying cause
>
>  Sure, though it could help finding dupes. BUt in my experience what
> helps most, is fine grained categorizing, because you end up with few
> bugs for a given component, and "same" bugs end up actually being near
> in the UI or query tool. Of course it let space for bugs that get
> actually miscategorized. But hell, my experience is also that many bugs
> are discovered as beeing fixed years after the fix anyway.

fine grained categorization is something that takes place long after the 
bug is reported, users don't know how to correctly categorize bugs any 
more then they know what code caused the bug.

>  I don't plan fixing all that stuff, it can't really be. I just would
> like to create a tool that isn't as painful for the programmer as
> bugzilla (or rt or ...) is, while it would still be as pleasant and easy
> to stick a web UI for the users over it, hence not making the user
> experience less pleasant.
>
>  My experience with bugtracking is that the most efficient way to deal
> it is to let the programmer in charge of the responsible module deal
> with those bugs. What programmer aren't willing to do is the triaging,
> and pulling the bugs off a distant database/UI/.. off something that
> isn't in their usual workflow.

this only works if someone goes to the work to send the bugs to the right 
programmer. in many cases this is non-trivial.

David Lang
