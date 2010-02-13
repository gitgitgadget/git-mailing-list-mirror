From: Jan Koprowski <jan.koprowski@gmail.com>
Subject: Re: Solve continuous integration (pending head / commit queue) 
	problem using git
Date: Sat, 13 Feb 2010 08:04:50 +0100
Message-ID: <c41cd75d1002122304i5aab52abt598e6a553defe1cf@mail.gmail.com>
References: <c41cd75d1002120837t20f2a47fi41e8c67245c4284c@mail.gmail.com>
	 <32541b131002120942w50a29e7cjf2c10820b3286017@mail.gmail.com>
	 <c41cd75d1002121007k4da9a617t161b699a3bca0fa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 08:05:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgC3p-0003dQ-Pt
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 08:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704Ab0BMHE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 02:04:57 -0500
Received: from mail-bw0-f222.google.com ([209.85.218.222]:42515 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0BMHE4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 02:04:56 -0500
Received: by bwz22 with SMTP id 22so50243bwz.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 23:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Uw5LQM8qg5hiyUpaP3BzNswfutNgNuDt0IZ4wdf7IyY=;
        b=rqE2UKw/G3zSMMMp1nmBX0QUbcAGm3pA4mGfq/Gn6TR99VXnpq+1immmpPpfWUC+4m
         aJsMFhqTP8GJIACc1+H5ljZuSZOKGEKNKUwXiztqB2PPbOJbqINtmuCaN1qM1ahzUosg
         G669S8N6UJW0lV0XvtlaQ9z9cpzzLoqY4DuPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ESoG2V91w7WNWJLHwI8httHR+Yah5DGdDhPYeRp0PROEQDOV8G9jt75D7+yR+i2FB5
         XhHcBWXLVyPa8UY6Vb8+e37k0E0DTR/+Bif/jEXbBaAcKNp/lMnkWZdZuFbAv3acBc/U
         DEqqGmnhguO2TdQkycilEf8S0jiGbxl9orMkk=
Received: by 10.204.10.3 with SMTP id n3mr1538554bkn.81.1266044690761; Fri, 12 
	Feb 2010 23:04:50 -0800 (PST)
In-Reply-To: <c41cd75d1002121007k4da9a617t161b699a3bca0fa7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139778>

On Fri, Feb 12, 2010 at 7:07 PM, Jan Koprowski <jan.koprowski@gmail.com=
> wrote:
> On Fri, Feb 12, 2010 at 6:42 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> On Fri, Feb 12, 2010 at 11:37 AM, Jan Koprowski <jan.koprowski@gmail=
=2Ecom> wrote:
>>> Now. My idea. There is some revision tagged as "stable". *Clone* an=
d
>>> *pull* operations is somehow "overloaded" from server side and alwa=
ys!
>>> return last revision tagged as stable. After compiling external too=
l
>>> just move tag to another revision which pass all tests. Of course
>>> there is some additional parameter (for example --last or --unstabl=
e)
>>> which can clone fine way of repository.
>>>
>>> Two questions.
>>> 1) Maybe I try to invent the wheel again. Is there any way to take =
the
>>> effect without overloading standard git behaviours.
>>> 2) If not how overload git behaviors on git "server side" repo?
>>
>> In general, code that lies to you about what's the most revision is
>> evil. =C2=A0Sometimes you *do* want to fetch that revision it's lyin=
g to
>> you and saying doesn't exist, precisely because you'd like to help f=
ix
>> it before integration.
>>
>> What you really want is:
>>
>> - nobody can push to the "integration branch" except the "integratio=
n manager"
>>
>> - the "integration manager" should be a computer program, so that yo=
u
>> can have "continuous integration"
>>
>> This isn't actually that hard. =C2=A0Give each user their own reposi=
tory;
>> no user can write to any other user's repository. =C2=A0(This is the
>> default setup on github.com, for example.) =C2=A0Alternatively, just=
 tell
>> people to never, ever push to the master branch by themselves. =C2=A0=
People
>> are easily capable of following rules like that unless they're
>> actively trying to screw you.
>>
>> Then set up something like gitbuilder
>> (http://github.com/apenwarr/gitbuilder) (Full disclosure: I wrote it=
)
>> to build *all* the branches from *all* the users. =C2=A0This sounds =
like it
>> would create exponential work for the build machine, but it doesn't,
>> since most users will have mostly the same commits anyway.
>>
>> When gitbuilder tags a particular commit as having built and passed
>> all tests, then it becomes a candidate for merging into the
>> integration branch. =C2=A0Write a little script that goes through ca=
ndidate
>> branches, checks their gitbuilder status, and if they've passed,
>> pushes them into the integration branch. =C2=A0The push will only su=
cceed
>> if the integration branch can be fast-forwarded to match the branch
>> you're trying to push; if you can't, it'll be rejected, which is wha=
t
>> you want, since merging (even conflict-free merging) might break
>> tests.
>>
>> That mechanism works pretty well at my company, with one exception: =
we
>> didn't bother with an automatic tool that merges into master. =C2=A0=
We
>> prefer to have a release manager do that.
>>
>> Have fun,
>>
>> Avery
>>
>
> Probably I don't have a problem (or it is a lateness). Because only
> tagging as stable and making two compile loops: one per management
> always compiling stable tag and second compiling latest repo... And
> that is all :D
>
> --
>><> Jan Koprowski [696775174] GSM
>

Here is a thing :)
After I install Hudson CI and equip them of Git plugin I saw two ways
supported by Hudson:
1) Compile specific branch of code which suggest merging stable
changes to this branch
2) Merging witch "something" before building and rollback changes
after which suggest some unstable "branch" or "repository" where all
programmers commit and changes from are "merged" before build to the
stable branch. I don't check details because I choose first option.

Sad thing there is no support for tagging in Git plugin.


--=20
><> Jan Koprowski [696775174] GSM
