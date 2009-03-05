From: John Tapsell <johnflux@gmail.com>
Subject: Re: git push
Date: Thu, 5 Mar 2009 08:56:43 +0000
Message-ID: <43d8ce650903050056v4b7a22cfve2eb4d8d76717285@mail.gmail.com>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
	 <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
	 <20090225225826.GA13510@pvv.org> <49AF9117.1020407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Mar 05 09:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9PC-000180-7H
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 09:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbZCEI4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 03:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbZCEI4q
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 03:56:46 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:55823 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZCEI4p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 03:56:45 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1341792rvb.5
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gJ/IK3pPoFhoDCW/XW6IXr/IwlXOPVstYb5uK+3JsxI=;
        b=rwyWzWoGhBLJaYocEGitlL42v9b/GWXyspjWDSM5/RI4b+15rgSdQ9BabC6p86WoiF
         yiJf1PcvyqxGQehvYstMc4N8j6NUSIDl87PV2nhcnvntwEEgkJjDvftumYMh+zhNBz9U
         o3y3ZpaRh1A3GRyHvLaCSdyiO3ESrqenRE/bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z9Sj1ZLYcEPQwk2laAiten4DZ1OTimTJdOWkwXklFeUrEK48UaKjmm4xOloE7ZPRrw
         eLiPM26+asfPESdm0tDhMchxRT7jW9/wSuz91MKR9Kal5soenssIGndkkEwJtWmwNSB/
         bp4sSk0OocimGEcZ/63KheSJr6aF0TvR8R1Ok=
Received: by 10.142.128.6 with SMTP id a6mr430647wfd.108.1236243403532; Thu, 
	05 Mar 2009 00:56:43 -0800 (PST)
In-Reply-To: <49AF9117.1020407@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112271>

2009/3/5 Andreas Ericsson <ae@op5.se>:
> Finn Arne Gangstad wrote:
>>
>> Sorry to people receiving this mail twice, the list ate my first rep=
ly
>> since it managed to hit the spam-filter (maybe I should take a hint.=
=2E. :)
>>
>> On Tue, Feb 24, 2009 at 11:01:38PM -0800, Junio C Hamano wrote:
>>>
>>> [...]
>>>
>>> But if you are talking about changing the default when "git push" i=
s run
>>> without any parameter, I have to say it is a terrible idea, for two
>>> reasons, and one is too obvious to state so I wouldn't repeat it an=
d talk
>>> only about the other one.
>>
>> The current default behaviour of git push is very annoying for us at
>> least. The current behaviour is _dangerous_ and leads to serious
>> problems. It is too easy for someone to write "git push". They hit
>> enter too soon, or they write it expecting to get usage
>> information. They do not necessarily expect to overwrite random
>> branches in a remote repository.
>>
>> Most git commands are not destructive with no arguments at all, and
>> push is the _only_ command that really can screw things up for other=
s,
>> so this command in particular should refrain from destructive defaul=
t
>> behaviour.
>>
>> An example of random branch overwriting:
>> $ mkdir a
>> $ cd a
>> $ git init
>> $ echo contents > file
>> $ git add file
>> $ git commit -m message
>> $ cd ..
>> $ git clone a b
>> $ cd b
>> $ git checkout -b gif-support
>> $ echo foo > somefile
>> $ git add somefile
>> $ git commit -m message
>> $ ( cd ../a && git branch gif-support) # Assume done by someone else
>> $ git checkout master
>> $ # <hack away, maybe commit a bit>
>> $ git push =C2=A0# <-- OOOPS! pushes gif-support!
>>
>> Notice that what branches git push ends up pushing is out of your
>> control, since new branches can appear in the remote repository at a=
ny
>> time. This is very unfriendly in our setup with a shared incoming re=
po.
>>
>> If developer A creates "gif-support", shares it with developer B, wh=
o
>> does an additional commit on it to make it print more debug info (bu=
t
>> has no intent of pushing it anywhere), and A pushes it to the "incom=
ing"
>> repo, developer B risks overwriting that with his debug version.
>>
>
> git push will never overwrite changes in the remote repo unless you
> specify --force. If anyone *blindly* uses --force, they really should=
n't
> have write-access to anything so precious as your code repositories.

It's seems a very likely scenario to me.

I work on a remote branch with one other person, to make some new
feature.  Once we are done, I rebase and get rid of the cruft from the
history, then "git push --force" to update the branch.  Whoops, I've
just unknowingly wiped out a completely different branch.

>
> Worst-case scenario, you commits that were never intended for publica=
tion
> enter your public wateringhole and needs a revert later on. Big deal.
>
>> It is not realistic to believe that in a big project with many
>> developers, no one will ever do the mistake of typing "git push". =C2=
=A0It
>> is also not realistic to believe that everyone will know how to (or
>> remember to) configure this away.
>>
>
> But it *is* realistic to not assume that they will also use --force
> while doing so.
>
>>> If you shoot for the least damage for such people, the sanest defau=
lt for
>>> "git push" would be to do nothing. =C2=A0You *always* say what to p=
ush where,
>>> then there is no risk of pushing something you did not intend to.
>>> =C2=A0Perhaps
>>> "push.default =3D never" configuration may not be such a bad idea?
>>
>> If "git push" could do nothing at all without configuring anything, =
that
>> would be a big improvement to us.
>>
>
> I can buy this, I guess. I always type the remote-name I want to push=
 to
> anyways. A sane no-op default would probably be to list the pre-confi=
gured
> remotes along with a short usage message. I still don't quite see the=
 point
> of it.

If people don't agree on changing 'git push' to affect only the
current branch, I would also go for making 'git push' a noop.

John

>
> --
> Andreas Ericsson =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 andreas.ericsson@op5.se
> OP5 AB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 www.op5.se
> Tel: +46 8-230225 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Fax: +46 8-230231
>
> Considering the successes of the wars on alcohol, poverty, drugs and
> terror, I think we should give some serious thought to declaring war
> on peace.
>
