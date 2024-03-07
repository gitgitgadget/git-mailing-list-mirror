Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADDA137C43
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842611; cv=none; b=c0fRqFcY8AjSIHpHFJzM7ZzSX/bYHoaQlPa4uQdzazYcKwgnEuleUj3Va7UESKZPahJ8zXERXnr7jpoZFGNrVGkofYoM03dBz8QjAfNlf95YgeAjzQZumjxBLH1CL4shkk7k/1m6mpo/qeT6frWrlC2hJSaW59H4hn209QszEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842611; c=relaxed/simple;
	bh=jVgUxJreaZ/aJqrh6edZ0tknoK0NruZO0nSQu2k5K9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMqO+ZbVgf5+JpWGwnGoVzMo1hLf6NM6u041Vx7DqZEw5iYt1PR+zGiSTXTeV2MiswlA+odlDJv+NpzWH8BrRq9vkVBRrXbdXPYexQ5td2ansEyxd+tqZHJjkXQomZLO+WmpUDiCMq5DdxSvlUmQk4naraXI/5iQxiz6LwvJizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=Qfco5UUP; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="Qfco5UUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1709842603;
	bh=dafujU2IpQkeZejqUY31t901zRtElUrWAq3A/k48yNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qfco5UUPmC2tQIJechv5zi2jRouegXduQHkOFp41ckRZIClDqkzcXM7xA0zqEx99z
	 e4cnuNob/2TA51hTYPHIvYjoz697p47qCnx+NFb5/FmTygXL9EwRYDLdHzft6ZhZvJ
	 6qaiTb0Jipz9F0YhbH7D2RwZGKtwQwMZzZ3ap67HV8iYinFD+7Q3M88TvPmfDrar7M
	 nYkC+EjJGac83CnSqx9+nm1Cbx7b134/dl939kSZWu+6IC0kvppQNFXI424jJGsg7B
	 nbTpz68qC2GVJOxngQfXudBxPtPm6n68AvM+9y48fv2focmtV/mmnwd0Fluha3CRjy
	 VhpdnuMLRc0pA==
Received: from [192.168.42.22] (56-97-142-46.pool.kielnet.net [46.142.97.56])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id F07BD3C02D3;
	Thu,  7 Mar 2024 21:16:42 +0100 (CET)
Message-ID: <42426c93-84fe-47d2-a41c-16284a86f003@haller-berlin.de>
Date: Thu, 7 Mar 2024 21:16:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Language: de-DE, en-US
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Derrick Stolee <derrickstolee@github.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de>
 <xmqqsf144pi7.fsf@gitster.g>
 <CABPp-BGO2ftEMHJDrf6yg3J4AfpKn=rpf_5Wt_WAS+Hi70KqPQ@mail.gmail.com>
 <845ced9a-1f35-4100-a1ff-4243db2ba34f@haller-berlin.de>
 <CABPp-BE36Zhacdumd1JSc+7NXYpxZ=CQ1=ieebze=mDewpEUGA@mail.gmail.com>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <CABPp-BE36Zhacdumd1JSc+7NXYpxZ=CQ1=ieebze=mDewpEUGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++

Elijah, thanks for your patience with this. I appreciate the time and
energy you put into understanding what I want to achieve. The questions
you are asking help me understand my proposal better myself.

It seems that I didn't do a very good job at getting my point across so
far, so I'll try again in a more structured way.

Let's begin by describing two very different user scenarios:

1) Stacked branches. Git supports these reasonably well for simple cases
through the "rebase --update-refs" command (and the "rebase.updateRefs"
config), but since they are not a first-class concept, git needs to rely
on heuristics to determine which branches are part of a stack. For
simple cases this works very well, but more esoteric cases can have
problems (e.g. a non-linear topology of multiple stacks that may share
common base branches and then diverge, in which case rebasing one of
them destroys the others; or degenerate stacks involving "empty"
branches either in the middle or at the top, in which case there's no
way to tell what the order of the branches is supposed to be).

2) Copying a branch, and rebasing it away from the original one (for
non-stacked branches, see below). The use case is that you have a branch
called topic-1 (branched off main), which is pushed and in review
already, with CI running on it, and you want to test whether it works on
devel, so you make a new branch called topic-1-on-devel off of topic-1,
and rebase it onto devel. You want to make a draft PR of that new branch
to have CI run on it, too, and of course you want to keep the original
branch untouched. For me and most of my co-worker that I have observed
in pairing sessions, the natural way to achieve this is as described
above: checkout a new branch, and rebase it where you want it to go.

Next I'll describe my goals, and my non-goals. I know I can easily
achieve 2) by simply not using --update-refs, but I like to have
"rebase.updateRefs" set to true by default because it is so useful, and
having to remember to use --no-update-refs whenever I do 2) is annoying.

So my goal is to make 2) work well (in the simple, non-stacked case)
even when "rebase.updateRefs" is true, while not making 1) work any
worse in the "normal", non-degenerate case.

I'm _not_ trying to fix the problems that --update-refs has today (I
briefly mentioned some of them above, but there are more), and I'm not
trying to make 2) work well with stacked branches. It would certainly be
nice if that would work too, but I don't think it can without
introducing branch stacks as a first-class feature in git, so I'll have
to live with not supporting that case well. It would still be a big
improvement for me without that.

I'll now go on to respond to some of your questions inline below, but
I'll skip some of them in order to not make this too long. Do let me
know if there are still open questions that I didn't address.

On 07.03.24 06:36, Elijah Newren wrote:
> On Wed, Mar 6, 2024 at 1:00 PM Stefan Haller <lists@haller-berlin.de> wrote:
>>
>> On 06.03.24 03:57, Elijah Newren wrote:
>>
>>> 1) What if there is a branch that is "just a copy" of one of the
>>> branches earlier in the "stack"?  Since it's "just a copy", shouldn't
>>> it be excluded for similar reasons to what you are arguing?  And, if
>>> so, which branch is the copy?
>>
>> This is a good point, but in my experience it's a lot more rare. Maybe
>> I'm looking at all this just from my own experience, and there might be
>> other usecases that are very different from mine, but as far as I am
>> concerned, copies of branches are not long-lived.
> 
>> There is no point in having two branches point at the same commit.
> 
> But isn't that what you're doing?

Only briefly, not permanently. I only described this to illustrate why
it never happens to encounter branch copies in the middle of a stack.

>> When I create a copy of a
>> branch, I do that only to rebase the copy somewhere else _immediately_,
>> leaving the original branch where it was.
> 
> If it is inherently tied like this, why not create the new branch
> immediately after the rebase (with active_branch@{1} as the start
> point), instead of creating it immediately before?

That would be the wrong way round. I want to leave the original branch
untouched, make a new branch and rebase that away from the original.

>> Which means that I encounter
>> copied branches only at the top of the stack, not in the middle. Which
>> means that I'm fine with keeping the current behavior of "rebase
>> --update-ref" to update both copies of that middle-of-the-stack branch,
>> because it never happens in practice for me.
> 
> You've really lost me here; are you saying you're fine changing the
> design to add inherent edgecase bugs to the code because those edge
> cases "never happen in practice for me"?

Wait, now you are really turning things around. You make it sound like
my proposal is responsible for what you call a "bug" here. It's not, git
already behaves like this (and you may or may not consider that a
problem), and my proposal doesn't change anything about it. It doesn't
"fix" it, that's right (and this is what I referred to when I said "I'm
fine with it"), but it doesn't make it any worse either.

>> I don't see a contradiction here. I don't tend to do this in practice,
>> but I can totally imagine a tree of stacked branches that share some
>> common base branches in the beginning and then diverge into different
>> branches from there. It's true that "rebase --update-refs", when told to
>> rebase one of the leaf branches, will destroy this tree because it pulls
>> the base branches away from under the other leaf branches, but this is
>> unrelated to my proposal, it has this problem today already. And it's
>> awesome that git replay has a way to avoid this by rebasing the whole
>> tree at once, keeping everything intact. Still, I don't see what's bad
>> about excluding branches that point at the same commits as the leaf
>> branches it is told to rebase when using "replay --contains".
> 
> By "leaf branches", do you mean (a) those commits explicitly mentioned
> on the command line for being replayed, (b) only the subset of the
> branches mentioned on the command line which aren't an ancestor of
> another commit being replayed, or (c) something else?

If I understand you right (and if I understand the user interface of
git-replay right), then what I mean is the combination of all single
commits that are mentioned on the command line, plus the right side of
all A..B ranges that are mentioned on the command line. In my mental
model those are "the things that are being rebased" (please let me know
if that mental model is wrong), and I am proposing to exclude all
branches from updating that point to any of those and are not mentioned
on the command line, because they can be considered copies.

> Let me re-ask my question another way.  If someone runs
>     git replay --onto A --contained ^B ^C D E F
> when branches G, H, & I are in the revision range of "^B ^C D E F",
> with G in particular pointing where D does and H pointing where E
> does, and E contains D in its history, and F contains commits that are
> in neither D nor E, how do I figure out which of D-I should be
> updated?

D, E, F, and I are updated, G and H are not; this seems very obvious to
me. D, E, and F because they are all mentioned explicitly; G and H are
not updated because they point to one of the "things-to-be-rebased", so
they are copies; I is updated because it is contained in E but does not
point at one of the "things-to-be-rebased", so it's part of a "stack"
(or whatever you want to call this topology).

It's a heuristic; we need a way to distinguish things that are part of a
stack from things that are copies. My heuristic for this relies on the
assumption that the stack is not degenerate in the sense that it doesn't
contain any "empty" branches in the middle or at the top of the stack,
otherwise it wouldn't be possible to distinguish the two.

>> No, I don't think I need HEAD to be special. "The thing that I'm
>> rebasing" is special, and it is always HEAD for git rebase, but it can
>> be something else for replay.
> 
> But what exactly should that something else be?  I still don't
> understand what that is from your explanation so far.

All the refs that are mentioned on the command line, either as a single
commit or as the second half of an A..B expression. It may well be that
I have some misconception of how exactly git replay works, this sounds
like the most likely explanation for why we don't understand each other.

> Something like `git log --format=%D --decorate-refs=refs/heads/
> ${base}..HEAD^1 | grep -v ^$`, plus adding in the current branch,
> right?
> 
> Or is the concern with this suggestion the performance hit you'd take
> (which admittedly might be a problem with this solution, since you
> walk the commits an extra time)?

Yes, I can do that, and no, I'm not concerned about performance. We
already have all that data cached in memory anyway, so that's not a
problem. But this would only work for git replay, there's no way to do
the same thing for --update-ref. My goal is to offer the same features
both for the checked out branch (using rebase) and other branches (using
replay), and have them behave the same.

So my proposal is more about changing --update-ref, since I can solve it
manually for replay, as you described. However, _if_ we decide to change
"rebase --update-ref", then I think it would make sense to change
"replay --contains" in the same way, so that they behave more consistently.

>> One last remark: whenever I describe my use case involving copies of
>> branches, people tell me not to do that, use detached heads instead, or
>> other ways to achieve what I want. But then I don't understand why my
>> proposal would make a difference for them. If you don't use copied
>> branches, then why do you care whether "rebase --update-refs" or "replay
>> --contained" moves those copies or not? I still haven't heard a good
>> argument for why the current behavior is desirable, except for the one
>> example of a degenerate stack that Phillip Wood described in [1].
> 
> The current behavior is easy to describe and explain to users, and
> generalizes nicely to cases of replaying multiple diverging and
> converging branches.

It sounds like you value the property of being easy to describe higher
than doing the expected thing in as many cases as possible.

-Stefan
