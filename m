From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 2/2] git-submodule: support 'rm' command.
Date: Wed, 27 Jun 2012 14:48:49 -0400
Message-ID: <CABURp0p-PL3E2wfPptL7KcwQaiK+p3oAa_aQ7R=Jge6oVvJ8iA@mail.gmail.com>
References: <1340621820-19448-1-git-send-email-mgorny@gentoo.org>
 <1340621820-19448-2-git-send-email-mgorny@gentoo.org> <4FE898BC.2020307@web.de>
 <CABURp0od-nNFVhLQU9BsiJ=wXkdneJfhxun_PHOfV=sgzOFShg@mail.gmail.com>
 <4FE8D380.20803@web.de> <CABURp0qFXGs6wqFbz28OKywVsFu23JKfhS8uLsen-nqhBvDAiw@mail.gmail.com>
 <4FEA1494.404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 27 20:49:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjxIq-0000N6-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 20:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab2F0StL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jun 2012 14:49:11 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56053 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab2F0StK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jun 2012 14:49:10 -0400
Received: by gglu4 with SMTP id u4so1206436ggl.19
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=S/o5YISAPPmZ8SW31Y845BhHSjSUED72aauWIqr9HFM=;
        b=MO178XhdU7pT+OfY8jdHeNXBMqTYYdjleyX/VNAJzbmFif3DdZZoHRyrzZaWWAVIDd
         fVfMz/nhx13WRhp00smj11MYCK5qPc8Bl4PlJ7u3Fk6RsbQ17SndTBylc2hotzGHTW8d
         RB++obKGbgzb4KUxAAnHRwVvZUvTg2v5FOenU4zvQZfnHQFLKfL30yILXaoYwIau5ZCA
         B7Bf9EQiLVXwh+jOAbjwZfcMjXPs/WvrYTS8bcp7wexoOUIgo+UQ1W+rsc8NXjAA82eF
         tLz7f13HNdHFsEKYk2j+O3FJvDnxOSPDUOouTHvjjw/8kVJcFPGbYywZO9adkJ5PUuo8
         Myrw==
Received: by 10.236.153.8 with SMTP id e8mr24712023yhk.80.1340822949621; Wed,
 27 Jun 2012 11:49:09 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Wed, 27 Jun 2012 11:48:49 -0700 (PDT)
In-Reply-To: <4FEA1494.404@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200735>

On Tue, Jun 26, 2012 at 3:59 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 26.06.2012 21:12, schrieb Phil Hord:
>> On Mon, Jun 25, 2012 at 5:09 PM, Jens Lehmann <Jens.Lehmann@web.de> =
wrote:
>>> Am 25.06.2012 22:53, schrieb Phil Hord:
>>>> On Mon, Jun 25, 2012 at 12:58 PM, Jens Lehmann <Jens.Lehmann@web.d=
e> wrote:
>>>>> Am 25.06.2012 12:57, schrieb Micha=C5=82 G=C3=B3rny:
>>>>>> Add an 'rm' command to git-submodule which provides means to
>>>>>> (semi-)easily remove git submodules.
>>>>>>
>>>>>> Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
>>>>>> ---
>>>>>> Right now, it requires the submodule checkout to be removed manu=
ally
>>>>>> first (so it does not remove unstaged commits), and just removes
>>>>>> the index entry and module information from config.
>>>>>>
>>>>>> I based it on 'cmd_add' code trying to preserve the original cod=
ing
>>>>>> standards.
>>>>>
>>>>> I really like the goal of this patch but would prefer that "git r=
m"
>>>>> learns how to remove submodules instead of adding more code to th=
e
>>>>> git-submodule.sh script.
>>>>
>>>> I would like to see both supported, eventually. That is, git-rm an=
d
>>>> git-submodule-rm should both work. =C2=A0It would make sense to me=
 when I
>>>> am looking for the counterpart to 'git submodule add' to find it u=
nder
>>>> 'git submodule rm', and also under 'git submodule --help'.
>>>
>>> Hmm, as long as "git submodule rm" would just use "git rm" under th=
e
>>> hood and not its own scripting that would be ok.
>>
>> Maybe it would be better if 'git-rm' would use 'git submodule rm'
>> under the covers. =C2=A0This would keep the .gitmodules (etc.)
>> manipulations out of the hair of the git-rm machinery.
>
> I disagree, me thinks submodules should become first class citizens.

Sounds ok to me.  But maybe keep it in a separate module just for
manipulating submodules; you know, to reduce our spaghetti score.

>> Also, I hope 'git submodule rm foo' would fail if 'foo' were not a s=
ubmodule.
>
> Yes, it should. But that'd be easy to test there.
>
>>>> In the special case of a submodule which does not use a gitfile, I=
 am
>>>> not even sure if any of the submodule files should be removed. If =
they
>>>> are, what state does that leave the submodule repository in? =C2=A0=
A
>>>> checked-out workdir whose files are all removed? =C2=A0'git-status=
' would
>>>> be very noisy in this case. =C2=A0I'd rather expect this to behave=
 the same
>>>> as if I checked out a previous commit which did not have the submo=
dule
>>>> added yet. =C2=A0Today, this leaves the submodule in-place and it =
shows up
>>>> as an untracked file. =C2=A0I don't know a better way to handle th=
at,
>>>> though I expect it would be ok remove all the files even in this c=
ase
>>>> (if the workdir is not dirty and if the head commit is current in =
the
>>>> superproject). =C2=A0But it seems extreme to do all of that and th=
en leave
>>>> the .git directory lying about in the former submodule directory.
>>>
>>> Good point. Another option would be to move the git directory into
>>> .git/modules of the superproject before removing the files, then ne=
xt
>>> time it's updated it'll use gitfile. But maybe that's a problem whi=
ch
>>> will go away anyways as all submodules cloned with newer git use
>>> gitfiles anyway.
>>
>> I like this idea, but it seems a little presumptuous. =C2=A0The new
>> behavior might cause a few panicked users to spend the day rebuildin=
g
>> their "lost" repository.
>
> Me thinks we should teach "git rm" only to remove the submodule when
> the --recurse-submodules option is used with it (which is what "git
> submodule rm" would do). Then later the to be added "autoupdate"
> submodule config =C2=A0setting (which I intend to use for automatic
> submodule updates during checkout, merge, etc. too) could enable this=
=2E
> No surprises for users who didn't ask for it.

I like that, though I despise the --recurse-submodules option because
A) it is too long, and B) it is sometimes spelled "--recurse" (for
good reasons, I'm sure, but it's irritating nonetheless).

>> =C2=A0Maybe we can make this an explicit action.
>> "git submodule convert-to-gitfile" =C2=A0:-)
>
> I like it!
