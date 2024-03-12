Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49F3BBF0
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235768; cv=none; b=kth+I7bO0fo910WBsSvPIqdxqH2fxsG2MYCJ5R7wAE2PNcbKyOSrOflQkvI/NcrxbvgoMAYaa3Fv9jY9xWKW0Il843xbeX5lUmXr5kSADX26JKFrK0hUCGw36+UIAjfl3LxDuOCUi/BhxrBvP0Z+DJgbb4biiNjqvr4ERripk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235768; c=relaxed/simple;
	bh=CNXo5Sgkxw13wZ/D08F9ZivweFNafQTiCSwreld0xxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzGiiju6cSVuMeHJtnw/qQPFDJWsfu2lfYdrxbu929gEtx+4IDZCJAz4x9nYKnt9CXOXdeQonNBZrjolvv9yUBxJlYfCjYiqWidqJ7vlpS+t2z1XoFjC5guXYn2WbnRoBadBMjGL4R4oMSr35EjxXJyNvWadDAqrILpbdxEUePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=cHLNwu85; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="cHLNwu85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1710235756;
	bh=Zku/7rFhBhFhyv5MuvsNOUqZxU6YR30fMHh2okRfD/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cHLNwu85euF0KvLvJzACz/DnIrU6+kw4In0jPTyDMuoJ61aDArJlCCGiwdczIEVio
	 eBAm+FmyX/gfEffiohTSFiBM2IMypvZLWQ2CizbB1d25ZlwF1cccWQfbp8H5L6a66C
	 ok81hW5tILc4iuFxUF7ZTFfww2MjKxaglj4akhhoGBOv5tAO1Wzngax8F9rbJY4Zo2
	 8F1x8r7MOPhCpF5k5uaI9RzVWwMy/0Njymy5LbJpDTO7ULuMqtgZ0sye7sbfO0S10z
	 +mIQGMv3+tIHwhuOeQLkkIz55bSp4golPxZP59YYw5q1bDba1alZvT10wy4TlE/mdz
	 H8rA9NJZlj5MQ==
Received: from [172.18.72.71] (ip-185-104-138-52.ptr.icomera.net [185.104.138.52])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 790AC3C0FBE;
	Tue, 12 Mar 2024 10:29:15 +0100 (CET)
Message-ID: <042bfc26-0dcd-4c0d-aa02-f4ccf9f4e66e@haller-berlin.de>
Date: Tue, 12 Mar 2024 10:28:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Language: en-US
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
 <42426c93-84fe-47d2-a41c-16284a86f003@haller-berlin.de>
 <CABPp-BF_hWGynLm8FwjWWVYc=7wc6iBr_f79=h==thkzJVoRzw@mail.gmail.com>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <CABPp-BF_hWGynLm8FwjWWVYc=7wc6iBr_f79=h==thkzJVoRzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +

On 09.03.24 04:28, Elijah Newren wrote:
>> That would be the wrong way round. I want to leave the original branch
>> untouched, make a new branch and rebase that away from the original.
> 
> Ah, sorry for misunderstanding.  Still, though, what's wrong with running
>     git branch -f original_branch original_branch@{1}
> after the operation?

It's unintuitive. Users don't think this way, at least as far as I have
observed them (and I don't think this way myself). Also, for many users
the branch{n} syntax to access previous reflog entries is an advanced
concept that they are not familiar with.

> Also, since you're not using the git cli directly but going through
> lazygit, isn't this something you can just include in lazygit as part
> of whatever overall operation is creating the new copy branch and
> rebasing it?

Yes, there are various workarounds that I could build into lazygit.
Right now I'm planning to have lazygit check whether any branch heads
point at any of the commits in the range of commits that is being
rebased except for the head, and if not, add --no-update-refs. This will
solve it well enough for most cases, and it doesn't bother me too much
that I have to add this additional complexity to our code. I was just
hoping that cli users typing

  git checkout -b original-branch copy
  git rebase --onto devel main

would get the same improvement. It bothers me a bit that we have to
build clients around the git cli that make it perform better than the
git cli does.

>> Wait, now you are really turning things around. You make it sound like
>> my proposal is responsible for what you call a "bug" here. It's not, git
>> already behaves like this (and you may or may not consider that a
>> problem), and my proposal doesn't change anything about it. It doesn't
>> "fix" it, that's right (and this is what I referred to when I said "I'm
>> fine with it"), but it doesn't make it any worse either.
> 
> Ah, I see where I was unclear as well, and my lack of clarity stemmed
> from not understanding your proposal.  To try to close the loop, allow
> me to re-translate your "This is a good point, but..it never happens
> in practice for me." paragraph, the way I _erroneously_ read it at the
> time:
> 
> """
> For my new proposal, the case you bring up is a good point.  But it
> doesn't happen for me, so I propose to leave it as undefined behavior.
> [As undefined behavior, anyone that triggers it is likely to get
> behavior they deem buggy and not like it, but that won't affect me.]
> """
> 
> Now, obviously, that doesn't sound quite right.  I knew it at the
> time, but reading and re-reading your paragraph, it kept coming out
> that way for me.  Thus I tried to ask if that's what you really meant,
> and apologizing in advance if I was mis-reading.
> 
> Anyway, with the extra explanation in your latest email, I now see
> that you weren't leaving it undefined, but your proposal wasn't clear
> to me either in that paragraph or in combination with the rest of your
> previous email.  Sorry for my misunderstanding.

I think it's worth clarifying this again, and see whether "undefined
behavior" is the right term to use here. Again, this discussion has
improved my own understanding of the matter, so let me try to spell it
out again:

The fundamental underlying problem is that when we encounter two
branches pointing at the same commit in a rebase, git has no way to
distinguish whether this is because there's an "empty" branch in a stack
(either at the top or in the middle), or whether one branch is a copy of
the other. In the first case, both branches should be updated by "rebase
--update-ref", in the second case only one of them should, since the
other is not part of the stack. Since there's no way for git to tell for
sure, it can only guess which of the two was meant by the user, with a
heuristic that hopefully guesses right in the majority of cases. I think
it would be wrong to call it a "bug" (or an "edge case bug" like you did
earlier) if it guesses wrong in a particular scenario.

Right now, it _always_ guesses in favor of the stack, so it never
considers a branch to be a copy. For my own use of git, and of my
co-workers as I have observed them in pairing sessions, this is almost
always wrong. I have never encountered an empty branch in a stack, as
far as I remember, but I am encountering copies of branches fairly
often, so I'd like to improve the heuristic to make git guess right in
these cases. Note that this is definitely not a 5% thing as in your
three-way merging example; I can't provide any hard numbers of course,
but it feels much more like the classical 80/20 rule to me (where my
proposal would improve it for 80% of the cases, to be clear).

So, I concluded that copies are much more frequent than empty branches
in a stack, so it would make sense for me to turn the heuristic around
and always guess in favor of a copied branch. The problem is that we can
only do this for the tip of the branch, because only in that case can we
tell which branch is the copy (the one being rebased) and which one is
the original that should be left alone. For branches in the middle of
the stack we just can't tell, so we have to guess in favor of an empty
branch in a stack and update both refs, since otherwise we'd have to
randomly pick one of them to update and leave the other one alone,
risking to break the stack this way.

So that's really where my proposal comes from: guess in favor of a
copied branch only at the tip but not in the middle; not because we only
want it at the tip, but just because we only can at the tip.

But fortunately, it is in fact true that I almost never create a copy of
a branch in the middle of a stack, but then I almost never have empty
branches in the middle of a stack either, so it doesn't really matter to
me which way the heuristic guesses in this case.

I hope this clarifies it a bit more.


Having written all this, I do realize that it's probably too complex to
explain to users (not the behavior itself, which is fairly simple, but
the rationale behind it).

-Stefan
