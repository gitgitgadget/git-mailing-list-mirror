From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Tue, 31 Jan 2012 17:50:02 -0500
Message-ID: <CABURp0pSGGT8eyzNad-dNNx49oioAxOPOf3dmqu7M3fnV+PzdA@mail.gmail.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org>
 <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
 <7vaa6x4m5l.fsf@alter.siamese.dyndns.org> <CABURp0pPqpkWXdC+97wR8HZeX=Nbi0bn-3ji+k9LQnj0kFjCnQ@mail.gmail.com>
 <4EE7BEF5.6050205@web.de> <CABURp0pDoS1wgJ+Fs3XFX=A_EuR4Gzi4mHLiQP+-icT_d3J+WQ@mail.gmail.com>
 <4F28554D.9090107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Leif Gruenwoldt <leifer@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 31 23:50:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsMWy-0005iL-SH
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 23:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab2AaWuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 17:50:24 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62048 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab2AaWuX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 17:50:23 -0500
Received: by wgbdt10 with SMTP id dt10so540187wgb.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=685oKBYBA58GJMsZeUpu/oF8vZ9M4KkDFoOtuuHTZwQ=;
        b=oMg2jCvrcIFTDZd/disVnqeWaoOwEdfDqgt8zXqatP397uyPirvhM6EIyS/zSERJKK
         PYnUs+efaYet9P1q1hBUQRTUR0WgKKaaLbez38FqEpgB/o+QmmCPinN9s2ehkHhknWgU
         2Ue2zwERjxZt6xpv3zKwVCgBob7Cp1hYom4jg=
Received: by 10.180.80.8 with SMTP id n8mr37987694wix.14.1328050222241; Tue,
 31 Jan 2012 14:50:22 -0800 (PST)
Received: by 10.216.155.212 with HTTP; Tue, 31 Jan 2012 14:50:02 -0800 (PST)
In-Reply-To: <4F28554D.9090107@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189480>

On Tue, Jan 31, 2012 at 3:55 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 30.01.2012 22:15, schrieb Phil Hord:
>> I lost my grip on this thread over the holidays...
>>
>> On Tue, Dec 13, 2011 at 4:09 PM, Jens Lehmann <Jens.Lehmann@web.de> =
wrote:
>>> Am 13.12.2011 15:17, schrieb Phil Hord:
>>>> =A0 git pull origin topic_foo && git submodule foreach 'git pull o=
rigin topic_foo'
>>>>
>>>> =A0 git submodule foreach 'git push origin topic_foo' && git push =
origin topic_foo
>>>
>>> This sounds to me like you would need the "--recurse-submodules" op=
tion
>>> implemented for "git pull" and "git push", no?
>>
>> Only if I have nested submodules, but yes, we do use --recurs* in ou=
r scripts.
>
> I'm confused, push doesn't know the "--recurse-submodules" option
> at all yet while pull only does a deep fetch when it is given, the
> submodule work trees are not updated to the merge result right now.

Sorry.  I type faster than I think sometimes.

I meant that I do use something like this:
  =A0 git submodule foreach --recursive 'git checkout master' && git
checkout master

And I expect to use something like this:
  =A0 git submodule foreach --recursive 'git push origin topic_foo' &&
git push origin topic_foo

>>> And I miss to see how
>>> floating would help when the tips of some submodules are not ready =
to
>>> work with other submodules tips ...
>>
>> By project policy, for any branch, all submodules' tips of the
>> same-named branch should be interoperable. =A0The CI server looks af=
ter
>> this, as much as he can.
>
> We do the same thing on our CI server, but it can only test some
> combinations (even though that tends to show most problems pretty
> early). But in the end every superproject is responsible to use a
> working set of submodule commits, and I would rather bet on a
> combination the CI server tested than on what happens to be on the
> current tips.

Yes, I see what you mean.  In our case, what "happens to be on the
tips" should also have been vetted by our Gerrit+Jenkins code review
dance (for each branch * each superproject), and so it should always
be good.  If it's not, we have the Jenkins-maintained gitlink history
we can use to bisect.

>> I think of branch names as sticky notes (extra-lightweight tags,
>> sometimes). =A0We have linear history in many of our vendor submodul=
es,
>> but multiple "branches" indicate where each superproject branch has
>> presumably finished integration.
>
> We also add a branch in submodules every time a superproject needs
> to move away from the submodules master (so the commits won't get
> lost by accident).

Good idea.  Gerrit sees to this for us also, but we do share code on
ancillary git servers and we follow the same practice.

>>>> But not all my developers are git-gurus yet, and they sometimes me=
ss
>>>> up their ad hoc scripts or miss important changes they forgot to p=
ush
>>>> in one submodule or another.
>>>
>>> Sure, even though current git should help you some by showing chang=
es
>>> in the submodules.
>>
>> Real newbies may not even remember to use 'git status' strategically=
=2E
>
> Hmm, but then they will screw up things in the superproject too, no?

What I mean is that a developer may be completely focused on one
particular submodule (his domain).  He does his work in this module,
and when it's ready he commits and pushes to the server.  'git status'
shows him that his directory is clean.  But this is only because he
doesn't really know where the submodules top-directories are, so he
doesn't realize that he has changes in another submodule that he has
not committed.  He has to know to run 'git status' from somewhere in
the superproject (ostensibly in the root directory of that
superproject).  But he may forget since 'git status' already assured
him he was done.

Like this:

#-- Setup
mkdir super && cd super && git init
mkdir A && touch A/foo
git add .
git submodule add gerrit:iptv/iptv_scripts B
git commit -m "Initial commit"

#-- Work flow
cd A && echo changes > foo
cd ../B && echo changes > foo
git add . && git commit -m "Made some changes"
git status
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#
nothing to commit (working directory clean)

So git just told my new-to-git developer that his workdir is clean
because he happened to run it from super/B.  But if he ran it from
super/A (or super) it would tell him otherwise.

I guess what would help here is something like the opposite of 'git
status' showing the status of descendant submodules;  it would help if
it showed the status of sibling submodules and the superproject as
well.

>>>> =A0Or worse, their pull or push fails and
>>>> they can't see the problem for all the noise. =A0So they email it =
to me.
>>>
>>> We circumvent that by not pulling, but fetching and merging in the
>>> submodule first and after that in the superproject. You have much m=
ore
>>> control about what is going wrong where (and can have more
>>> git-experienced people help with - or even do - the merges).
>>
>> I do that, too, and I wish I didn't have to. =A0I wish I could safel=
y
>> and sanely recover from a conflicted "git pull --recurse-submodules"
>> pull from the superproject.
>
> That's what my recursive checkout work is aiming at. Me thinks after
> that we will also need some good ideas on how to present and help
> solving submodule merge conflicts.
>
>> That is, I wish doing so were as
>> straightforward as recovering from the same condition would be if al=
l
>> my code were in one repository instead of in submodules.
>>
>> Which is the gist -- I wish submodules did not make git more
>> complicated than it already is.
>
> I think we can make working with submodule much easier than it is
> now, the next step being updating all submodule work trees as git
> updates the superproject's work tree. Even though I suspect that in
> the long run submodules will always be a bit more complicated than
> having everything in one repository, I'm confident that will be by
> far outweighed by the advantages they bring.

I'm really looking forward to it.

Thanks,
Phil
