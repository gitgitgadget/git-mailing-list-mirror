From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 14 Nov 2011 15:57:07 +0200
Message-ID: <CAMP44s1G9jJyiis7z7XbPvW925E-u=0_-h9jJKkj2wyPS9o5ig@mail.gmail.com>
References: <20111107172218.GB3621@sigill.intra.peff.net>
	<CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
	<20111107183938.GA5155@sigill.intra.peff.net>
	<CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
	<20111107210134.GA7380@sigill.intra.peff.net>
	<CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
	<20111108181442.GA17317@sigill.intra.peff.net>
	<CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
	<20111111181352.GA16055@sigill.intra.peff.net>
	<CAMP44s06p+KyJAu4ddiCa8CFRq5eogbqxxJU16Z-SUb3GSp67Q@mail.gmail.com>
	<20111114122556.GB19746@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 14 14:57:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPx2E-0006e1-HZ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 14:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065Ab1KNN5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Nov 2011 08:57:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59078 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1KNN5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2011 08:57:08 -0500
Received: by ywt32 with SMTP id 32so2198138ywt.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 05:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tqOXzJS0Beu6rmvs6/7vhwZgw6QPqa7mY5YMmqEEDlw=;
        b=SvEP3S9Tc6WEuCf42NMnxAsSFdU84a1PHQjuSrCmQ0c/7ijIVIWXKYpprqirnEn9le
         Hxh+fmqZhRXMx/PspMCPERlhsgHoBhQkgO3+ggt9VMo2dogygFVUNo33pekfAq5ho80s
         46ZfyUXkGZyH1331Hq2quQVqgcAQTA2ZPGTf4=
Received: by 10.68.72.168 with SMTP id e8mr49980660pbv.127.1321279027703; Mon,
 14 Nov 2011 05:57:07 -0800 (PST)
Received: by 10.68.58.38 with HTTP; Mon, 14 Nov 2011 05:57:07 -0800 (PST)
In-Reply-To: <20111114122556.GB19746@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185385>

On Mon, Nov 14, 2011 at 2:25 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 13, 2011 at 12:07:19AM +0200, Felipe Contreras wrote:
>
>> > So in that sense, it is poorly named, and "--branches" (or "--head=
s")
>> > would be more accurate. At the same time, it is probably more like=
ly
>> > what the user wants to do (you almost never want to push "refs/rem=
otes",
>> > for example).
>>
>> But you do want to push tags, and --all --tags doesn't sound right; =
if
>> I'm pushing everything, why do I specify I want to push more stuff.
>> And then, why it --all --tags disallowed?
>
> I agree that "--all --tags" looks silly. I don't know why it's
> disallowed; from my reading, it should be a perfectly sensible
> operation. You might try digging in the history or the mailing list.

Yeah, I might do that.

>> > So I am a little hesitant to suggest changing it, even
>> > with a warning and deprecation period.
>>
>> It is confusing and wrong, what more reason do you need?
>
> Because I am worried that "--all" pushing refs/remotes will also be
> confusing; it's not what most people are going to want.
>
> If your suggestion is to deprecate the name "--all" and start calling=
 it
> "--branches" or "--heads", then that is an improvement. But making
> "refs/*:refs/*" easier to accidentally use might not be.

That's what I meant; replace --all with --branches (remember heads is
a plumbing name).

>> > and then it really is just a special way of spelling "refs/heads/*=
". But
>> > then, I also think it's good for users to understand that the opti=
ons
>> > are refspecs, and what that means. It's not a hard concept, and th=
en
>> > when they inevitably say "how can I do BRANCHES, except put the re=
sult
>> > somewhere else in the remote namespace", it's a very natural exten=
sion
>> > to learn about the right-hand side o the refspec.
>> >
>> > Of course I also think BRANCHES looks ugly, and people should just=
 learn
>> > "refs/heads/*".
>>
>> Look, I'm all in favor of people learning stuff, but I have been
>> involved in Git since basically day 1, and up to this day I was (am?=
)
>> not familiar with refspecs, I don't use them regularly, and never
>> really had a need to, and that's fine. People are already complainin=
g
>> about the learning curve of git, and what you are suggesting is that=
:
>>
>> Instead of doing:
>> % git push remote --branches --tags
>>
>> They should do:
>> % git push remote 'refs/heads/*' 'refs/tags/*'
>
> Sorry, I should have been more clear with what I wrote. My "of
> course..." was more of a tangential "well, this is so far from what m=
y
> gut tells me is reasonable that I'm not sure my definition of ugly is
> even relevant here".
>
> For me personally as a user, I prefer learning how a tool actually wo=
rks
> at its core (in this case, refspecs), and then applying syntactic sug=
ar
> to simplify usage. But I also respect that not everybody feels that w=
ay.
>
>> I'm not going to investigate the subtleties of these different setup=
s,
>> I'm going to put my common user hat and ask; how do I fetch as a
>> mirror?
>
> The problem with that question is that you haven't defined mirror. Do=
es
> that mean you just want pruning, or does it mean that you want your
> local ref namespace to match that of the remote?

Exactly, no mirror has been defined, because I don't want a mirror. A
mirror is supposed to have all the refs in sync all the time; that's
not what I want.

> Git should be able to do each of those cases. And I think it's fine t=
o
> have a less cumbersome syntax to specify them. But it's also importan=
t
> that we don't over-simplify the terms so much that they get option A
> when they wanted B.
>
> BTW, right now there is "git remote add --mirror ...", which sets up =
the
> fetch refspec for you (in this case, mirror is "make your refs look l=
ike
> the remote's"). Perhaps rather than adding syntactic sugar to fetch, =
it
> would be best to channel users into configuring a remote that selects
> from one of a few common setups (including different types of mirrors=
).

But that assumes that they would want the same refspec operation *all
the time* which is not the case (at least for me). Sometimes I want to
update only existing branches, sometimes I want to fetch new branches
too, sometimes I want to prune local branches, sometimes not.

> It's not as flexible (I can't do a one-off mirrored push without usin=
g
> actual refspecs), but my guess is that most users would want to set u=
p
> an actual remote, and picking from a set of configuration recipes wou=
ld
> be the ideal interface for them.

I don't think so. I doubt users would like a refspec that will delete
their local branches *always*; sometimes they would want to prune the
remote tracking branches.

>> > And "--prune-local" doesn't seem like a fetch operation to me. Eit=
her
>> > you are mirroring, and --prune already handles it as above. Or you=
 are
>> > interested in getting rid of branches whose upstream has gone away=
=2E But
>> > that's not a fetch operation; that's a branch operation.
>>
>> This would make things more confusing to the user.
>>
>> Say on one side I do this push?
>> % git push test --prune 'refs/heads/*' 'refs/tags/*'
>>
>> What do I do in the other side to synchronize the repo?
>> % git fetch test --prune-local 'refs/heads/*:refs/heads/*'
>> 'refs/tags/*:refs/tags/*'
>
> No, you would just do "--prune", because your refspecs are _already_
> indicating that you are writing into the local namespace, and anythin=
g
> you have locally would be deleted by the prune operation. I.e., there=
 is
> no need for --prune-local in this scenario; --prune already does what=
 we
> want.

That's very risky. The user might forget that this is a mirror repo,
and delete the local branches unintentionally. Plus, it would be then
impossible to prune remote tracking branches.

>> I would prefer this of course:
>> % git fetch test --all --prune-local
>>
>> But you are saying it should be:
>> % git fetch test 'refs/heads/*:refs/heads/*' 'refs/tags/*:refs/tags/=
*'
>> % git branch --prune-remote test
>>
>> That doesn't sound right to me; mixing branch operations with a spec=
ific remote?
>
> I was trying to outline a situation where "--prune" wouldn't be
> sufficient, which is:
>
> =C2=A0: we make some topic branch based on another branch
> =C2=A0$ git checkout -b topic-Y origin/topic-X
>
> =C2=A0: later, we (or someone else) deletes topic-X upstream
> =C2=A0$ git push origin :topic-X
>
> =C2=A0: now we fetch using the regular default refspecs, which put
> =C2=A0: everything in a separate remote. But we ask to prune, so that
> =C2=A0: deleted branches will go away.
> =C2=A0$ git fetch --prune origin
>
> Now origin/topic-X doesn't exist, even though it's configured as the
> upstream of topic-Y. Fetch doesn't enter into the picture, because it=
 is
> configured to only touch items in refs/remotes/.

That's only by default.

> As a user, how do I resolve the situation? I might say topic-Y is
> obsolete and get rid of it. I might rebase it onto another branch. Or=
 I
> might declare it to have no upstream. But all of those are branch
> operations, not fetch operations.

Yes, but that has nothing to do with the operation I want to achieve:
git remote sync. By which I mean synchronize the local branches with
the branches of a certain remote.

Note that in this sync operation, the upstream branch is irrelevant.

> So what I was trying to say was that either your fetch refspecs tell
> fetch to write into your local branch namespace, or not. If they do,
> then --prune is sufficient (with no -local variant required). If not,
> then touching your local branch namespace is outside the scope of fet=
ch.

I don't want this to be a *permanent* configuration. I see this
similar to --force. You can achieve the same by adding a + at the
beginning of the refspec, but this is something that should be
activated on a per-command basis, thus the option. I think this should
be the same.

Cheers.

--=20
=46elipe Contreras
