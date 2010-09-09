From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Coping with the pull-before-you-push model
Date: Thu, 09 Sep 2010 08:43:53 -0600
Message-ID: <4C88F2A9.2080306@workspacewhiz.com>
References: <4C8866F9.1040705@workspacewhiz.com> <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 16:44:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtiM5-00031n-Vl
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 16:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab0IIOn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 10:43:56 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:33135 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab0IIOnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 10:43:55 -0400
Received: (qmail 8204 invoked by uid 399); 9 Sep 2010 08:43:54 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.197.127)
  by hsmail.qwknetllc.com with ESMTPAM; 9 Sep 2010 08:43:54 -0600
X-Originating-IP: 75.220.197.127
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155859>

  ----- Original Message -----
=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
Date: 9/9/2010 7:06 AM
> On Thu, Sep 9, 2010 at 04:47, Joshua Jensen<jjensen@workspacewhiz.com=
>  wrote:
>>   After a deployment of Git on a centralized server at my place of b=
usiness,
>> the largest amount of grumbling has been with the pull-before-you-pu=
sh
>> model.  Coming from the file-centric Perforce where you need only ha=
ve
>> latest of just the files you are submitting, the pull-before-you-pus=
h model
>> has really been a pain in the neck for a large team.
>>
>> Even with topic branches being used, merges to master occur frequent=
ly.  It
>> can really be a frustrating battle to get your merged branch pushed =
to the
>> central master branch.  In the time it took you to pull, test, and p=
ush,
>> someone has probably already pushed before you.  To cope with this, =
people
>> will pull, not bother testing, and immediately push their changes.  =
Yes,
>> this could result in build instability, but it is considered better =
than
>> never being able to make your change live.
>>
>> (Let's ignore what we should or shouldn't be doing as far as 'develo=
pment
>> practices'.  :)  We're solving the problems one step at a time...)
> Let's not ignore that.
=46air.
> Presumably you had exactly the same problem in perforce, i.e. because
> you only had have the files you were changing checked out in Perforce
> in the time between `hack&&  pull&&  test&&  push` someone else might
> have already pushed. Thus what you just submitted wasn't guaranteed t=
o
> pass tests.
>
> So is the flow in Git where you don't run the tests again, rebase and
> push and hope for the best any different?
The end result is the same; submitted code is never really tested=20
against latest in Perforce either.  The primary difference between the=20
two is that the Perforce submit is successful the majority of the time=20
(odds of someone editing and submitting the same file as you are low),=20
and the Git push fails the majority of the time.

Don't get me wrong.  I've given training on why Git's enforced=20
pull-before-you-push model can be better than what we had before=20
(reproducible state, fewer broken builds, etc).  Nevertheless, the issu=
e=20
is very frequent, and that's why I am querying others.
>> Gerrit provides a compelling model where branches are pushed to the =
code
>> review server in the form refs/for/master, and the given push will a=
lways
>> succeed.  Code reviews are performed, someone sets the verified bit,=
 and the
>> change is submitted and merged to master by Gerrit itself in a queue=
d
>> fashion.  Unfortunately, its general "requirement" to squash your br=
anch
>> down to a single commit is, possibly, a showstopper.  If it treated =
a branch
>> merge as a group of commits that MUST stay together, that would be p=
erfect.
> This sounds like something that's configurable in Gerrit, or should
> be.
Agreed, but it appears it is currently a missing feature.  There have=20
been discussions about it on their mailing list over the past months,=20
and a feature request is in their tracker.  I am unsure of their=20
progress or even interest.
>> [..]
>>
>> Is there another workflow that is successful for your large(-ish) en=
terprise
>> team?
> Linux manages to deal with a huge number of commits, but does so by
> having subsystems.
>
> Maybe that's something you can use in your codebase?
Unless I'm mistaken, though, it seems to work in reverse of what our=20
working model has been for years.

I'm grossly oversimplifying the process, but the Linux model seems to b=
e=20
built on hierarchical 'pull requests'.  I can tell a subsystem=20
maintainer I have some changes and then ask that maintainer to pull the=
m=20
from a certain location.  When that person has time/inclination, the=20
change is pulled, merged in, and then another pull request is sent to=20
the upstream hierarchy.

This _is_ compelling, but even if it would work within the company I=20
work for, it is such a dramatic shift in workflow that I am certain it=20
could not be done in one fell swoop.

Thanks for your insights!

Josh
