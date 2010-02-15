From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Walking commits from the first
Date: Tue, 16 Feb 2010 01:05:35 +1100
Message-ID: <2cfc40321002150605l4de9d970t919ee56d7a3d697e@mail.gmail.com>
References: <e72faaa81002142037g7f5f518erb9fefbb239124bc5@mail.gmail.com>
	 <e72faaa81002142039h5531a19y354d24e595295bb1@mail.gmail.com>
	 <20100215080646.GD5347@coredump.intra.peff.net>
	 <e72faaa81002150333r4eb27a15t7de6b3c820eb4bc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 15:05:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh1a2-0002nK-QP
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 15:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab0BOOFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 09:05:37 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41609 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab0BOOFg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010 09:05:36 -0500
Received: by pwj8 with SMTP id 8so539328pwj.19
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hTbBzlppKA4Qk272QipEqC3iYplbULMmFtYsVU7xANY=;
        b=S1QArgoRsLJatrWwC+j+Ph6iF2jltN3gD1bLCj2G2PbjHYw58GUrKz3NiopL/P9zEq
         f87rc4EyayG8JySBlAPHa0Zn5IDGXVGqLPa9S8JEBjJQu4vHJYBlcsd4gpDmTB5QMQLt
         94senU9494WiWPBOR7z/UkavMoaaUWE0HvGNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZuBmKciv1TK5C/ztWYQixuOSEcjT40tSJadAmQXZirOoLqoEzuDhBn7wyi1Y57BcCZ
         dJ0uNoBfHSPjwbflvr3oWGY3DQ9WpQGWy8Qji1FtUJyC0xPyJosMJvk0js9arMAjF4DD
         KkORPvA9Kg8bwObELsWi6YJXfbgChSDu6iKeQ=
Received: by 10.115.101.40 with SMTP id d40mr3497633wam.95.1266242735487; Mon, 
	15 Feb 2010 06:05:35 -0800 (PST)
In-Reply-To: <e72faaa81002150333r4eb27a15t7de6b3c820eb4bc2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140009>

On Mon, Feb 15, 2010 at 10:33 PM, Pavan Kumar Sunkara
<pavan.sss1991@gmail.com> wrote:
>> In most repositories, you can do this:
>>
>> =A0git checkout `git rev-list --reverse HEAD | head -n 1`
>>
>
> Thanks for the command
>
>> It is not as simple as that, for two reasons.
>>
>> For walking backwards, you can take multiple paths from merge commit=
s
>> (which have multiple parents). So there may actually be several "fir=
st
>> commits" if unrelated lines of development were merged together. For
>> example, in git.git:
>>
>> =A0$ git log --format=3D'%h %p' |
>> =A0 =A0grep ' $'
>> =A016d6b8a
>> =A0cb07fc2
>> =A0161332a
>> =A01db95b0
>> =A02744b23
>> =A0e83c516
>>
>> There are six root commits. You can see what they are by piping the
>> above into "tr -d ' ' | git log --no-walk --stdin".
>>
>> For your "--next" suggestion, it is even worse. There may be an infi=
nite
>> number of commits that point to a given commit as the parent. So the=
re
>> is no such thing as "what came next from X". You can only ask
>> "leading up to some commit Y which is a descendant of X, what was th=
e
>> commit that came after X". But while there are a finite number of
>> answers, there is not necessarily just one. If two branches diverged=
 at
>> X and then remerged before Y, they are both equally "next".
>>
>> -Peff
>>
>
> My bad. I never thought of branch merging while writing this
> So, if i want to get the second commit, Is this enough or will i get
> the problem of branch diverging, if there is a branch diverging from
> there.
>

It's not merging that's the problem - it's forking. Merges are easy to
comprehend - a merge has a finite number of input branches all of
which are immediately discoverable with an O(1) operation. A merge,
once performed, is immutable for all time.  The number of forks from a
given commit is fundamentally unbounded and requires comprehensive
knowledge of the entire history of the repository.

> git checkout `git rev-list --reverse HEAD | head -n 2`
>
> Even though we have the problem branches to travel reversely, we can
> do it in another way. As, we have the timestamp for every commit, the=
n
> it will be easy to implement --next. Take the next commit in timeline
> and checkout. Even though it's completely different branch, no proble=
m
> as long as we are going in order.
>
> Also we can have git checkout --next --same-branch to checkout the
> next commit in timeline of the same branch.

If your goal is to understand the source code, then reviewing commits
in time order from start to finish is unlikely to be
very helpful.

The reason is that two adjacent commits in this order will unlikely to
have any semantic relationship of any value unless they happen to be
on the same stream of development.

The history is useful for understanding how something came to be -
commits followed backwards down one merge branch will tend to have
some semantic relationship to each other unless your committers are on
acid. Trying to comprehend the evolution of history by replaying it
forwards and keeping track of n parallel threads of development as
they diverge seems like an unnecessarily complicated way of trying to
comprehend the world.

jon.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
