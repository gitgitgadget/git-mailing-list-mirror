From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 2/2] git-submodule: support 'rm' command.
Date: Tue, 26 Jun 2012 15:12:33 -0400
Message-ID: <CABURp0qFXGs6wqFbz28OKywVsFu23JKfhS8uLsen-nqhBvDAiw@mail.gmail.com>
References: <1340621820-19448-1-git-send-email-mgorny@gentoo.org>
 <1340621820-19448-2-git-send-email-mgorny@gentoo.org> <4FE898BC.2020307@web.de>
 <CABURp0od-nNFVhLQU9BsiJ=wXkdneJfhxun_PHOfV=sgzOFShg@mail.gmail.com> <4FE8D380.20803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjbCA-0002k1-Kp
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab2FZTM6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 15:12:58 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34097 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab2FZTM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 15:12:57 -0400
Received: by obbuo13 with SMTP id uo13so283379obb.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k1dVmbknLAcaPLWJwyhLabcFm/0v570Y0G5Af4t0cV0=;
        b=MBQm+jDhh3ZpgmkWcQ/OlaeUYnYJj5Xj7pGz28KOp1AMUkZb06cF8oMl/p/Ci74n3C
         2zS1gxVFp4EtD/wGvhxSGQXgr7319MADSBV7ASJQ3YygQM7WkwBLC85dyEXjqgpfBcDl
         ImtqQdzfuwiGltxVtuIUUyjKTyk2V5KZWrOnS7ikWvXG5GBOBpzI5zBEtMWBHse2tBYJ
         AWWVH5dsArSLYqsHXI43z+KieIHaoP4jDFy/qH2koSy6firqtBZZsIG6nf/Atkc85yNp
         gkyMhu9ykXL7op/RKuQyma5s5obhhvPKGoCvlaTN+knEf/tBHcdN8mkaiMf0/5kNWv5b
         kXBA==
Received: by 10.182.136.71 with SMTP id py7mr14807617obb.45.1340737977061;
 Tue, 26 Jun 2012 12:12:57 -0700 (PDT)
Received: by 10.182.111.99 with HTTP; Tue, 26 Jun 2012 12:12:33 -0700 (PDT)
In-Reply-To: <4FE8D380.20803@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200672>

On Mon, Jun 25, 2012 at 5:09 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 25.06.2012 22:53, schrieb Phil Hord:
>> On Mon, Jun 25, 2012 at 12:58 PM, Jens Lehmann <Jens.Lehmann@web.de>=
 wrote:
>>> Am 25.06.2012 12:57, schrieb Micha=C5=82 G=C3=B3rny:
>>>> Add an 'rm' command to git-submodule which provides means to
>>>> (semi-)easily remove git submodules.
>>>>
>>>> Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
>>>> ---
>>>> Right now, it requires the submodule checkout to be removed manual=
ly
>>>> first (so it does not remove unstaged commits), and just removes
>>>> the index entry and module information from config.
>>>>
>>>> I based it on 'cmd_add' code trying to preserve the original codin=
g
>>>> standards.
>>>
>>> I really like the goal of this patch but would prefer that "git rm"
>>> learns how to remove submodules instead of adding more code to the
>>> git-submodule.sh script.
>>
>> I would like to see both supported, eventually. That is, git-rm and
>> git-submodule-rm should both work. =C2=A0It would make sense to me w=
hen I
>> am looking for the counterpart to 'git submodule add' to find it und=
er
>> 'git submodule rm', and also under 'git submodule --help'.
>
> Hmm, as long as "git submodule rm" would just use "git rm" under the
> hood and not its own scripting that would be ok.

Maybe it would be better if 'git-rm' would use 'git submodule rm'
under the covers.  This would keep the .gitmodules (etc.)
manipulations out of the hair of the git-rm machinery.

Also, I hope 'git submodule rm foo' would fail if 'foo' were not a subm=
odule.

>>> Also it shouldn't be necessary for the user to remove the directory
>>> by hand before running "git rm". At least all files recorded in the
>>> submodule can be removed (and if the submodule uses a gitfile that
>>> can be removed too). Then all that is left are untracked files the
>>> user has to decide what to do with (which might be removed too when
>>> running "git rm --recurse-submodules=3Duntracked").
>>
>> That sounds like a nice next step. =C2=A0But I would expect that a '=
git
>> [submodule] rm foo' where foo has uncommitted changes to complain to
>> me (and do nothing else) unless I used --force. =C2=A0This is simila=
r to
>> how git-rm already behaves, I think. =C2=A0And in the case of a dirt=
y
>> submodule it makes sense to treat the submodule files as an atomic
>> unit. =C2=A0That is, if any of the submodule files are dirty and git=
-rm
>> will "leave" them, then it should leave the whole submodule. =C2=A0I=
t would
>> be very inconvenient to have to restore files back into place at the
>> correct commit just so I could examine them in context to determine
>> what I should have done with them before I used git-rm.
>
> We absolutely agree here, this is pretty much what I wrote further
> down in my first response ;-)
> (except additionally I consider a submodule dirty if it's HEAD isn't
> on any branch to avoid loosing commits)

So you did.  What bothered me was the suggestion that you could
partially remove a submodule's files.

>> In the special case of a submodule which does not use a gitfile, I a=
m
>> not even sure if any of the submodule files should be removed. If th=
ey
>> are, what state does that leave the submodule repository in? =C2=A0A
>> checked-out workdir whose files are all removed? =C2=A0'git-status' =
would
>> be very noisy in this case. =C2=A0I'd rather expect this to behave t=
he same
>> as if I checked out a previous commit which did not have the submodu=
le
>> added yet. =C2=A0Today, this leaves the submodule in-place and it sh=
ows up
>> as an untracked file. =C2=A0I don't know a better way to handle that=
,
>> though I expect it would be ok remove all the files even in this cas=
e
>> (if the workdir is not dirty and if the head commit is current in th=
e
>> superproject). =C2=A0But it seems extreme to do all of that and then=
 leave
>> the .git directory lying about in the former submodule directory.
>
> Good point. Another option would be to move the git directory into
> .git/modules of the superproject before removing the files, then next
> time it's updated it'll use gitfile. But maybe that's a problem which
> will go away anyways as all submodules cloned with newer git use
> gitfiles anyway.

I like this idea, but it seems a little presumptuous.  The new
behavior might cause a few panicked users to spend the day rebuilding
their "lost" repository.  Maybe we can make this an explicit action.
"git submodule convert-to-gitfile"  :-)

Phil
