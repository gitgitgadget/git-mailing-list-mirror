From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCH 1/2] Add feature release instructions to MaintNotes addendum
Date: Thu, 26 Mar 2009 17:37:06 -0400
Message-ID: <49CBF582.8010406@fastmail.fm>
References: <1238032575-10987-1-git-send-email-rocketraman@fastmail.fm> <20090326121017.6117@nanako3.lavabit.com> <49CB8871.2020605@fastmail.fm> <7vprg4m3k9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 22:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmxHn-0000Tq-7l
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757710AbZCZVhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757031AbZCZVhU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:37:20 -0400
Received: from smtp119.rog.mail.re2.yahoo.com ([68.142.224.74]:47854 "HELO
	smtp119.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756614AbZCZVhT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 17:37:19 -0400
Received: (qmail 55986 invoked from network); 26 Mar 2009 21:37:16 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp119.rog.mail.re2.yahoo.com with SMTP; 26 Mar 2009 21:37:15 -0000
X-YMail-OSG: B1AsEfwVM1mRevvMVWNRT0MYkdLLkyN9CsnuosTTPT66ovt9ReKgda.jDbV1ygXtxg--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 2284521C051A;
	Thu, 26 Mar 2009 17:37:15 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id toDYhVEENOKJ; Thu, 26 Mar 2009 17:37:06 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 788C421C0519;
	Thu, 26 Mar 2009 17:37:06 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vprg4m3k9.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114829>

Junio C Hamano wrote:
> Raman Gupta <rocketraman@fastmail.fm> writes:
> 
>> Nanako Shiraishi wrote:
>>> Quoting rocketraman@fastmail.fm:
>>>
>>>> + - The 'maint' branch is updated to the new release.
>>>> +
>>>> +     $ git checkout maint
>>>> +     $ git merge master
>>>> +
>>>> +   This is equivalent to deleting maint and recreating it from
>>>> +   master, but it preserves the maint reflog.
>>> After giving a recipe that is better than an alternative, what's
>>> the point of describing an inferior alternative as "equivalent",
>>> when it is obviously not "equivalent"?
>> Is this better:
>>
>> The resulting maint tree is equivalent to deleting maint and
>> recreating it from the tip of master, but merging from master
>> preserves the maint reflog.
> 
> It is unclear what you are trying to explain with these two (in your
> original) or three (your rewrite) lines.  As an explanation for the two
> command sequence, I would expect to see:
> 
>     "This merges the tip of the master into maint".
> 
> But that is literally what the command sequence does, so it goes without
> saying.

Let me see if I can explain why I think the extra verbiage, at least
in some form, is useful...

It is my understanding that the _goal_ in this case is for the maint
tree to match the master tree (so that the maint tree matches the new
feature release). The "obvious" way to do that, at least for less
experienced folks, is to delete maint, and recreate it from the tip of
master (or from the feature release tag which should be the same commit).

In this particular case, because and only because of the semantics of
the maint and master branch i.e. we know that master already contains
everything that maint does, merging from master to maint makes the
trees equivalent, while *also* maintaining the reflog. However,
someone less familiar with the semantics of the maint and master
branches may not draw this conclusion automatically.

BTW, would:

git branch -f maint master

be another way of doing this?

> If there is anything that needs to be said further, I think it is not how
> delete-then-recreate is inappropriate (I do not think it is even worth
> teaching).  But you may want to explain the reason _why_ maint gets this
> update from master.  I thought the explanation "... is updated to the new
> release" already covers that motivation, but if you want to make the
> description really novice-friendly, you _could_ say something like:
> 
>     Now a new release X.Y.Z is out, the 'maint' branch will be used to
>     manage the fixes to it.  The branch used to be used for managing the
>     fixes to X.Y.(Z-1), and does not have any feature development that
>     happened between X.Y.(Z-1) and X.Y.Z.  Because these changes are
>     contained in the 'master' branch, we can merge 'master' to 'maint' to
>     have the latter have them, which prepares it to be used for managing
>     the fixes to X.Y.Z.
> 
> I personally would not want to see somebody who needs the above to be
> explained to take over git maintenance after I get hit by a wayward bus,
> by the way ;-)

:) Very true, but there are lots of people out there who are trying to
understand and use git, and when they come across documentation like
this they rightfully think "hey if this works for the git.git guys, it
would probably be a pretty good starting point for me as well!". I
know I did. So a bit of explanation may be appropriate, even though
its not relevant for your intended audience. On the other hand, maybe
the newbie-level explanation can be skipped here, and instead be put
into gitworkflows(7). For my next patch iteration, I'll assume that's
what you want unless you tell me otherwise.

Cheers,
Raman
