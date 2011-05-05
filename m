From: Jerome Martin <tramjoe.merin@gmail.com>
Subject: Re: Private/public branches/repos workflow
Date: Thu, 5 May 2011 22:43:09 +0200
Message-ID: <BANLkTimggn-E+JsXp78_a2P3eWku3oTSbQ@mail.gmail.com>
References: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>
	<7v4o598164.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI5OG-0003ve-SV
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab1EEUnM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 16:43:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57609 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab1EEUnK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 16:43:10 -0400
Received: by gwaa18 with SMTP id a18so915127gwa.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=En5S+d/OMCyeVeZQzT/84GmqlUAu7gM8NNKdflPtQlI=;
        b=eDFVAojQly0dpDxQxgNCfvalcCp7XxAXV41BojmCYyfpL72L8Wzy4xjn2dCGzoQgej
         AUPu8DegyvTIq6PgZuJEzNr6JL/ZSlsaVzy1x3gOiJdGVcfNYeIaut767+eB89YPlbr5
         0i/KFNFdUhGphZNuoYy1dWjbxtDFyzbyqYpSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OLdl+UdOb0FGLe9sJNmb1yJz1+6FlsmdFpJ4DORHnRoPz30bcDO11cr28Xh4c3mzw1
         AhUcdZYPRsFuWDjh76YJHWJt/qoXpb3spoO2qCjGaHWgSa4nyZ1uSnk/UObbUyfX/1gc
         vf9Ro+/ml+dxpNsHw1a0hYeWVdAv3/HTShZqE=
Received: by 10.236.66.75 with SMTP id g51mr3297046yhd.524.1304628189552; Thu,
 05 May 2011 13:43:09 -0700 (PDT)
Received: by 10.147.167.8 with HTTP; Thu, 5 May 2011 13:43:09 -0700 (PDT)
In-Reply-To: <7v4o598164.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172911>

Junio,

Thanks a lot for your lengthy email and nice ASCII art making it a lot
clearer to me why I was running in circles with the wrong idea on
merge semantics :-) I think I understand clearly what you suggest, and
the part about discipline is the conclusion I was drawing myself when
answering Seth above.

I understand there is no silver bullet, and that an orphan branch +
discipline (regarding merges) + clever usage/planning of development
branches is as good as the system might get with that 'hidden' history
restriction. However, I am still wondering how (un?)practical this is
in real life.

It is probably just me not being fluent enough with git, but I still
cannot help feeling the whole workflow as being awkward and
error-prone for a daily usage. But hey, you seem to say that it is
already used around a lot, at least for the maintenance/development
branches case, so I guess it must be usable ;-)

Could you tell me how you would see usage of rebasing inside the
workflow you describe ? I am thinking about features (mistakenly)
implemented on top of the private branch that need later to be release
in the public branch. Can this be the shortcut to avoid lengthy
cherry-picks ?

On Thu, May 5, 2011 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jerome Martin <tramjoe.merin@gmail.com> writes:
>
>> I have an application that lives in a git tree. That application is =
a
>> commercial product, but we have decided to dual-licence it and relea=
se
>> an open-source version of it, along with all further commits to it.
>> Preparatory work for this has been done, and I now have two (let's
>> ignore the other) branches in my git tree, 'public' and 'private'.
>>
>> The problem is, I cannot simply push the public branch on a public
>> repository, because the history contains a lot of stuff that are not
>> to be publicly released.
>
> To do this properly without heavy cherry-picking, you would need a lo=
t of
> discipline. =A0Not just "you" as an integrator, but everybody in your
> development organization who has an access to the 'private' branch.
>
> What you have is something like this:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O =A0 public
>
> =A0...---x---x---x---X =A0 private
>
> where X is the tip of private branch that contains unreleasable stuff=
,
> while O is the tip of public branch, a redacted version fit for relea=
sing
> to the general public. =A0The former has a lot of history behind it, =
commits
> marked with 'x' that you are ashamed of showing to the public ;-), wh=
ile
> the latter does not have any history behind it (the initial code dump=
).
>
> Of course, if you build some feature that is not proprietary directly=
 on
> top of X and make a commit 'a', and try to merge that to the public
> branch, the resulting history will become this, pulling all the histo=
ry
> behind X:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0O----* =A0 public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/
> =A0...---x---x---x---X---a =A0 private
>
> Unlike "merge tracking" tacked on to some other systems, a merge in g=
it is
> a statement you make: "I looked at all the histories behind all the
> commits I am merging, and decided that this tree I am recording as th=
e
> merge suits the purpose of my branch better than any of the parents".
> Merging 'a' is not "The change between a's parent and a was cherry pi=
cked
> onto this branch" (i.e. what mergeinfo records for SVN). =A0In short,=
 if you
> want to keep your x's private, you have to promise yourself that you =
will
> never ever merge private to public.
>
> =A0 =A0 =A0 =A0Side note. =A0This is exactly a same discipline for ma=
naging the
> =A0 =A0 =A0 =A0maintenance track for the released version and the dev=
elopment
> =A0 =A0 =A0 =A0track for the next release in the open source world. =A0=
You queue
> =A0 =A0 =A0 =A0fixes to the maintenance track, and you may merge the =
maintenance
> =A0 =A0 =A0 =A0to the development, but you never merge the developmen=
t track to
> =A0 =A0 =A0 =A0the maintenance, because you do not want to pull new f=
eatures from
> =A0 =A0 =A0 =A0the development branch into the bugfix only branch.
>
> First of all, you would do this once before making any changes:
>
> =A0 =A0$ git checkout private
> =A0 =A0$ git merge -s ours public
>
> This will create a new commit at the tip of private, that records tha=
t all
> the histories of public is now contained in private, but the recorded
> state (i.e. the tree) is identical to that of X. =A0Let's call this c=
ommit S
> (it is a merge that synchronizes two independent histories):
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O =A0 public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0...---x---x---x---X---S =A0 private
>
> Then, from here on, your developers have a choice to make whenever
> starting to work on a new thing, be it a bugfix or a feature.
>
> If the change will _never_ be released to the public, you can continu=
e
> building on your private branch.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O =A0 public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0...---x---x---x---X---S---x---x =A0 private
>
> On the other hand, if it will _eventually_ be merged to the public, t=
hen
> you fork a topic branch from public, build it on that branch:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---a---a---a =A0feature-=
A
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O---o---o---o =A0public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0...---x---x---x---X---S---x---x =A0 private
>
> and merge it to public:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---a---a---a =A0feature-=
A
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =
\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O---o---o---o---* =A0public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0...---x---x---x---X---S---x---x =A0 private
>
> I depicted such a topic as "feature-A" that consists of four commits =
'a'
> in the pictures above. =A0Since you made the initial merge S, open so=
urce
> world may have added three commits 'o' to improve your system and you=
 also
> have a few more commits 'x' that are secret.
>
> The private branch can take the result of the work done on the topic
> branch, either by merging public wholesale:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---a---a---a =A0feature-=
A
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =
\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O---o---o---o---* =A0public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 \
> =A0...---x---x---x---X---S---x---x-------* =A0private
>
> in which case you will also get the open source improvements 'o', or =
by
> merging that particular topic alone:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---a---a---a... =A0 =A0f=
eature-A
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =
\ =A0.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O---o---o---o---* =A0. =A0pub=
lic
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0.
> =A0...---x---x---x---X---S---x---x----------* =A0private
>
> in which case your private branch will not (yet) have the three 'o' o=
pen
> source improvements.
>
> Note that you may consider some of your features "differentiating edg=
e"
> that you may want to keep private for one year and then release it to=
 the
> public. =A0In such a case, you can even choose to merge feature-A to =
private
> first:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 a---a---a---a... =A0 =A0f=
eature-A
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 O---o---o---o =A0 =A0 =A0. =A0=
public
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0.
> =A0...---x---x---x---X---S---x---x----------* =A0private
>
> and after a year, you can merge it to public to arrive at the previou=
s
> picture.
>
>



--=20
J=E9r=F4me Martin
