From: Phil Hord <phil.hord@gmail.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 18:53:32 -0400
Message-ID: <CABURp0oP3YBEhpDrAL-mvt1dR+ZH3av-P_sqDQAdgcN10WS2ig@mail.gmail.com>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <7vvclvrrad.fsf@alter.siamese.dyndns.org> <20120324165536.GA17932@neilslaptop.think-freely.org>
 <7v1uofqoa7.fsf@alter.siamese.dyndns.org> <20120326172028.GB12843@hmsreliant.think-freely.org>
 <4F70E53E.6060608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neil Horman <nhorman@tuxdriver.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 00:54:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCInf-0001v5-5u
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 00:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab2CZWxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 18:53:54 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64516 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752408Ab2CZWxy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 18:53:54 -0400
Received: by lahj13 with SMTP id j13so4308585lah.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 15:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jA3LOpqSMLnojii3BQnmUtAVm2ulIipczAGzDgtNgQ0=;
        b=v9wGnrEibBZD4UolqN20m2mrndzgrhbF+arvZ9nnUQx5CGnIzmgJVFBlT66gyTHMwm
         fSSx0BWsSVYVC/CFuR8u8Ab1CPEyPgeYT4HkODBJFqGH3I5MVa/cmXTslGA0Tg/most2
         OQnosmmXj8M2dAXmUTdALEz2bQZuOqmIYYQojoJ2JZHYqxElCHJi0hz5B5HXo/jw4SBO
         375H4oKR2HBD7Sv4ITf8oT8RtouxeUImNIaGbJiGQ9sOhgu6ow/gJvJCTPAKLbDf147Z
         Jqbr9yfFEKUPA0aZ9RtdtePI2BvZ0vXlUrFjECnpzYnlYV2mptRwGMOSmrgVj/qnMQXy
         kS+Q==
Received: by 10.112.86.229 with SMTP id s5mr8650639lbz.0.1332802432377; Mon,
 26 Mar 2012 15:53:52 -0700 (PDT)
Received: by 10.112.55.43 with HTTP; Mon, 26 Mar 2012 15:53:32 -0700 (PDT)
In-Reply-To: <4F70E53E.6060608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193983>

On Mon, Mar 26, 2012 at 5:53 PM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
> On 3/26/2012 12:20 PM, Neil Horman wrote:
>>
>> On Mon, Mar 26, 2012 at 10:12:48AM -0700, Junio C Hamano wrote:
>>>
>>> Neil Horman<nhorman@tuxdriver.com> =A0writes:
>>>
>>>> I agree, I think perhaps adding an --allow-empty option to the reb=
ase
>>>> logic, so
>>>> that empty commits (or perhaps just initially empty, as opposed to
>>>> commits made
>>>> empty) would be very beneficial.
>>>
>>>
>>> Yeah, that probably may make sense.
>>>
>> Ok, cool, I'll have a patch in a few days, thanks!
>>
> IMO, it seems like --allow-empty is an appropriate patch for git-reba=
se
> (non-interactive), and that git-rebase -i would need a command like "=
k"eep
> to distinguish which empty commits are not to be discarded and which =
empty
> commits are ok to discard automatically. =A0git-rebase -i should allo=
w
> explicit control on a commit by commit basis as opposed to blanket ru=
les
> like "discard all empty commits" or "keep all empty commits" that app=
ly to
> all commits in the rebase-to-do list based on a single cli option.

But I don't want a 'keep-even-if-empty' option in interactive.  I want
a 'purge-if-empty' option instead.  But I don't want to be bothered
with telling git this for every commit.

I recently had a long-running branch to clean up.  It was polluted
with commits pulled in by a ham-fisted  developer collaborating on
this and another branch.  He's not quite got the git mental model yet
and he had lots of commits doing things and then undoing them later
on.  Rebase scares him.

So I did a lot of interactive rebasing on this branch to reorder the
"good" change commits to the front of the line where they could be
pushed to code review sooner.  In the meantime, I wanted to keep the
rest of the branch in place so I could see what was left to tackle.

I cherry-picked replacements for many of the "good" commits -- from
their original topic branches HamFist swiped them from -- so I would
have the current, reviewable commit to push. Then I tested the
long-running branch on top of these commits.  This involved about 8 or
10 passes through 'git rebase -i master' for one reason or another.

On this branch of 40 commits, git interrupted me about 10 times on
each pass to ask me what to do.  The reason is always one of these:

  1. There is a new conflict I need to resolve
      examine / mergetool / test / --continue

  2. There is a rerere autoresolved conflict git wants me to approve
      examine / test / --continue

  3. There are no changes left in this commit because either
        a. they were introduced into earlier commits, or
        b. git-rerere-membered that I don't want those changes
      examine / --skip

I went through this process about 5 or 6 times as I massaged the stink
out of this branch.  Cases 2 and 3 became more common as I went along.
 But git always wanted to stop and ask my approval before continuing.
It was frustrating.

I always had my original branch to go compare to.  This one is really
a trial rework of these commits.  So I wish I could tell git to only
bother me when he sees a new conflict.  Don't stop and ask me for
something every 3 or 4 commits.

I really wanted something like this:

   $ git rebase --purge-empty --accept-rerere-authority -i master

So, even though this is an "interactive" rebase, I wish git would do
more of the busywork for me.  That is, I only want it to be as
interactive as it needs to be, and no more so.

Phil
