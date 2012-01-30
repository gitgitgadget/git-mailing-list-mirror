From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 30 Jan 2012 16:15:19 -0500
Message-ID: <CABURp0pDoS1wgJ+Fs3XFX=A_EuR4Gzi4mHLiQP+-icT_d3J+WQ@mail.gmail.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org>
 <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
 <7vaa6x4m5l.fsf@alter.siamese.dyndns.org> <CABURp0pPqpkWXdC+97wR8HZeX=Nbi0bn-3ji+k9LQnj0kFjCnQ@mail.gmail.com>
 <4EE7BEF5.6050205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Leif Gruenwoldt <leifer@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:15:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RryZl-0001U4-TS
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab2A3VPl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 16:15:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43387 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2A3VPk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 16:15:40 -0500
Received: by wgbed3 with SMTP id ed3so5146527wgb.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 13:15:39 -0800 (PST)
Received-SPF: pass (google.com: domain of phil.hord@gmail.com designates 10.180.109.101 as permitted sender) client-ip=10.180.109.101;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of phil.hord@gmail.com designates 10.180.109.101 as permitted sender) smtp.mail=phil.hord@gmail.com; dkim=pass header.i=phil.hord@gmail.com
Received: from mr.google.com ([10.180.109.101])
        by 10.180.109.101 with SMTP id hr5mr17113708wib.14.1327958139406 (num_hops = 1);
        Mon, 30 Jan 2012 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=m33BVqgGWzJIe8XyiRhmagU22WXhyVoaSdjeA+RAzWM=;
        b=JgL1DmTc7j2XhQ0aYoHK1lEhZSnp5dhk64Xz/HZsGECoF1NjkEswzXQAofq3Dflfuw
         DN/lV9Pz9bIg0it/jbtRXEVUtQhvoIUFt0gbwBZ7mg+5wreJZdSpJDy/PgUS/sb6Y1fo
         wDWgh2tqhgLNYTS+9PDGsWOx35XSjgy2kuT3w=
Received: by 10.180.109.101 with SMTP id hr5mr14361373wib.14.1327958139335;
 Mon, 30 Jan 2012 13:15:39 -0800 (PST)
Received: by 10.216.155.212 with HTTP; Mon, 30 Jan 2012 13:15:19 -0800 (PST)
In-Reply-To: <4EE7BEF5.6050205@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189426>

I lost my grip on this thread over the holidays...

On Tue, Dec 13, 2011 at 4:09 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 13.12.2011 15:17, schrieb Phil Hord:
>> On Mon, Dec 12, 2011 at 2:36 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> [...]
>>> Distro package dependency tracking is a poor analogy for many reaso=
ns, but
>>> I'll only touch a few.
>> [...]
>>> Naively, one might think that two branches, branch-1.0 and branch-2=
=2E0, can
>>> be defined in the repository of L, tell somebody (like "superprojec=
t that
>>> covers all the packages in the distro") that A wants branch-1.0 and=
 B
>>> wants branch-2.0 of L respectively, to emulate this, but if one thi=
nks
>>> further, one would realize that it is insufficient. For one thing, =
it is
>>> unclear what should happen when both A and B are asked to be checke=
d out,
>>> but more importantly, in dependency requirements on real distro pac=
kaging,
>>> the application C could say "I want v1.0 API but v1.4 is broken and=
 not
>>> compatible with me", which won't fit on the two-branches model. A
>>> workaround to add more branches to L could be devised but any worka=
round
>>> cannot be a good solution that allows a random application C among =
47
>>> others to dictate how the branch structure of L project should look=
 like.
>>>
>>> Fortunately, the dependency management is a solved problem by distr=
o
>>> package management and build systems, and they do so without using
>>> anything from submodules. There is no point reinventing these logic=
 in git
>>> submodules and emulating poorly.
>>>
>>> The only remotely plausible analogy around distro packaging would b=
e a
>>> superproject full of all the packages in a distro as its submodules=
, and
>>> records exact versions of each and every package that goes on a rel=
ease
>>> CD (or DVD). In that case, you do want to have a central registry t=
hat
>>> records what exact version of each package is used to cut the CD an=
d the
>>> mother of all modules superproject could be one way to implement it=
=2E But
>>> that is not an example of floating, but is a direct opposite.
>>>
>>> This exchange convinced me further that anybody who wishes to use
>>> "floating" is better off either by doing one or both of the followi=
ng:
>>>
>>> =A0- using "exact" but not updating religiously, as the interdepenc=
y
>>> =A0 requirement in their project is not strict; or
>>>
>>> =A0- not using submodules at all, but merely keeping these unrelate=
d A, B, C
>>> =A0 and L as standalone repositories next to each other in the dire=
ctory
>>> =A0 structure.
>>
>> My interdependency requirements are not so cut-and-dry. =A0We use
>> submodules to isolate controlled regions of code. =A0We may need to
>> share our project with a contractor who is allowed to see code
>> pertaining to "vendorA" but not that for "vendorB" or "VendorN". =A0=
But
>> our in-house developers want to have all the vendor code in one plac=
e
>> for convenient integration. Submodules do this nicely for us. =A0We =
can
>> give the contractor just the main modules and the VendorA modules an=
d
>> he'll be fine. =A0In-house devs get all the submodules (using the
>> vendor-ALL superproject).
>>
>> But this necessarily means there is too much coupling for comfort
>> between our submodules. =A0 For example, when an API changes in the =
main
>> submodule, each of the vendor submodules is affected because they ea=
ch
>> implement that API in a custom method. =A0Some of those vendor modul=
es
>> belong to different people. =A0Submodule synchronization becomes a r=
eal
>> chore.
>
> Hmm, maybe having vendor-specific branches in the superproject would
> help here. But that is hard to tell without knowing more details abou=
t
> your setup. But I suspect your vendor-ALL superproject is exactly the
> right spot to deal with these kind of problems (and if that isn't eas=
y
> that might be a result of the difficulty of the problem you are tryin=
g
> to solve here, keeping different vendors in sync with your API ;-).
>
>> Floating would help, I think. =A0Instead I do this:
>>
>> =A0 git pull origin topic_foo && git submodule foreach 'git pull ori=
gin topic_foo'
>>
>> =A0 git submodule foreach 'git push origin topic_foo' && git push or=
igin topic_foo
>
> This sounds to me like you would need the "--recurse-submodules" opti=
on
> implemented for "git pull" and "git push", no?

Only if I have nested submodules, but yes, we do use --recurs* in our s=
cripts.

> And I miss to see how
> floating would help when the tips of some submodules are not ready to
> work with other submodules tips ...

By project policy, for any branch, all submodules' tips of the
same-named branch should be interoperable.  The CI server looks after
this, as much as he can.

I think of branch names as sticky notes (extra-lightweight tags,
sometimes).  We have linear history in many of our vendor submodules,
but multiple "branches" indicate where each superproject branch has
presumably finished integration.

>> But not all my developers are git-gurus yet, and they sometimes mess
>> up their ad hoc scripts or miss important changes they forgot to pus=
h
>> in one submodule or another.
>
> Sure, even though current git should help you some by showing changes
> in the submodules.

Real newbies may not even remember to use 'git status' strategically.

>> =A0Or worse, their pull or push fails and
>> they can't see the problem for all the noise. =A0So they email it to=
 me.
>
> We circumvent that by not pulling, but fetching and merging in the
> submodule first and after that in the superproject. You have much mor=
e
> control about what is going wrong where (and can have more
> git-experienced people help with - or even do - the merges).

I do that, too, and I wish I didn't have to.  I wish I could safely
and sanely recover from a conflicted "git pull --recurse-submodules"
pull from the superproject.  That is, I wish doing so were as
straightforward as recovering from the same condition would be if all
my code were in one repository instead of in submodules.

Which is the gist -- I wish submodules did not make git more
complicated than it already is.

Phil
