Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FA3FF886
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399777; cv=none; b=GxZzMm1VbNL3TW5napjDrw0A5rboSD3uM7kBRtAu69AV7B19zWrsyg5MUW2ac52vLUzyol9evVU8YEvll2zDZqA9p4AKji43PDKrWii/S326+/s2XArUQoXiMhOWA8EI4AYCm19siZNDA/FMgVp0xoh4BwIn+U9NFLy6KA7T5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399777; c=relaxed/simple;
	bh=XUIAeX+RNefJZxty8pF5xXuRVlAzsiADjHoREmzb+6c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rIUet+CG2m69WQoEMItJr/vJKHk6QK6jBjoUJSkz+GkWZ8/YTQDV9VL5nT/Bw7A+nJV2q0RXz5SPMx8TB9ne1jlTiNVy/T+XbhkUOauAgC97ApO5b2LFvUv69/lb/OuoNa/PiAXtdUU1JMNjBYHdUVYxfMnhD8gjUlceXG1au5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Aeio3HYJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CB2opL/O; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Aeio3HYJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CB2opL/O"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id E7C221D0014D
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 15:02:54 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 07 Oct 2026 15:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791399772;
	 x=1791486172; bh=IAq5t2Aww4oQe0T4KQL5+MaevMh2QoO+zStJM+8xJr4=; b=
	Aeio3HYJd59ixUGrXTrONEhgDSzMjudITZ0ucdocsWAvWOZlcukB08KCYqNyBNoj
	6hz5BCefFYukTfasFnrdH+Qkn+UVQnQtmLU7PiZTDVewOHT4bKSASP5QDCgplznE
	SebT/zl81+pH1YlHGmOueP75ux/+0fZNm/qLbRKthp87ZT5f7K58/XkjPGZKMG2E
	kLgV2/9Neyq2RMVbmVE4gf8IgDrsM/caT5OQbm76ItffM5UARrDBkNQlWd+w05np
	7+spS/n4MbBI9IQhIwAAe2T5VfF3tZyTYH6Xp2OpZrhGpRXkvGcHxmgyhNoFe3Hm
	/ne3QWY/FqaJEHmVqDrdew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791399772; x=
	1791486172; bh=IAq5t2Aww4oQe0T4KQL5+MaevMh2QoO+zStJM+8xJr4=; b=C
	B2opL/Ob7UQwaz57s79e9qkpC0DeZkJG0OhD+e5BRwMBHI3DU0d0xZ9VkG1hLPg7
	8PkqS5k4x+bX1MDVDDiaWI/F3Y5Nu1GlOFwhPlxQNI7G/6bBkRw8TTO1gsNslXF4
	hTEPq/3JeQLvP2zNhKPWXSj56cCyPRPrB6vZld2L5XadfgwMahuxH6wUdlzPna11
	+m/rQ2oPembJrpy5FB9FvAAPSOTEo0rg4AKpDC2ujsiYXeEyGbDaLQV9CTTlKfNa
	0Ds45YIwmHRh2c691ZcNFwh2OczSxqOVpwmnDTW3V0M6qraoDsClwPOM1A1tU0HU
	Lx2bNvmjRcH9/Dr6PG+vQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791399772; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:l+ebXSHoQC71lEniCyDKW6RlPo/kv9voJt/uF3Ehnhqbjky
	9iGAkREJkER1OxTyX39b0UG+HPGYf3nNXF54i7awVUDujZt2e+0zdeY164THp7ze
	/Q94UpH8WSd4lRgEBS5lI1UPsnAtu630m5UOcopsDGlL3Dz5GxExGyCouf0fT8RM
	u1b1kN+O3GwiNPMmGRzYb0CRHQl2xgkpgonT0kVMGYXr5pRewMbzk1z190zrFsf0
	xTVeceZeGxgTKl/Q9ZScWakVepz3R2YdM3WaGORz8BFouImCbjioee0cnlEB2vNa
	fq0aPO1qx9nNVwg5eNY6fYXkBHXjRadMbEmxCpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hrtcNMdOVr2cmCPL4KWUEdgjB3QmYsp1BkeVdkpUSaE=:XUIAeX+RNefJZxty8pF5xXuRVlAzsiADjHoREmzb+6c=;
X-ME-Sender: <xms:WpfGaiK-n8ex1voj_c7hEnzMqLMCm2Ch7RFCUzTp6DLPdt9A5uBwARM>
    <xme:WpfGak9UvSLYwY1QgDUc4kzL9pGNLcIuwDBS6oLcehMYpvi_nBAbJuDn6QS3bOVTP
    sRgsB979PtJ0g1SqsdOVZroHwMfmtcN6Azh-AJftDN7YxA-MoeVNg>
X-ME-Proxy-Cause: dmFkZTGJwNmsK4PLWjvGy6qTDw+QyUVChFYH0t1A5iapueCxVATKs0i387hQmJcUETytMD
    PNyZy9de2EW8z3dij+vnXTLjUKhVU/erVqSldtjGG5bcaFCghaERBT5krXmqdx0zeivfTj
    HZ938USOXzdJk6HFR/lsu1p/bqpOqfx/74N9fUMjcOvloq6CA9c50dbPic7JpCV9/S8bgr
    fpWE1q4BBO2zgfpE1/9oUySp6J/zOHiOdh6TEzLVn5VY97Cl2bchXQdFzyAuF5q9nckerZ
    HJowkBOEVPlOk7nxLzIyeLae/gXMlskfIs7/+6pm525P9mQ66T7FbWaco1txCNFKoPdwC5
    pNvK7I9hSnYnZjOVPP718zt7OBMCDp6pYIQBnMcojJ++froumWWS03EcQlQapu64vo6hqS
    mPCo44tvL/ofXD+qg3AghwXJWfdhUnVgbeEBUPukuGPdnPNRoem6vCZmpRSx+gEdvoyni4
    MuCes9i9meiX/3BuPwzWyURNLeP/jLM+Ly1G5slcBeYfKtFni/kSPdY1FJBOJFfumgTli0
    TZ8Q1idaxim9I51bRv+b+ther7+GlYgIxgklqpxmciqUs4mPXWoxkMUojCeRYia4kKzj/x
    e9bnqkA1z2hvK2+nkEte01eNfm1WjYrij80dFCGUGBCLqOUjvaApR2vwGX9g
X-ME-Proxy: <xmx:XJfGaunyZ1W71Ncrf4aoi1gq3frqiFFTTVK1ypivEk-c3tUeQOp4ig>
    <xmx:XJfGatlGFqfZbZZbfppcVCylocvo6hYGmPVPXU2aUYUYdqM1YiwvPQ>
    <xmx:XJfGavubkBBmgSKnWceVYVS6ldMBHJBejpXPg3F4i4CPUbK_YbV1hw>
    <xmx:XJfGagltq3mgTK8t7L-ihLnxCyuZhzaghLvRBlK8lzOBaQIki7ZhtQ>
    <xmx:XJfGaoC4Cbu7czbnhUOQ9wDb1Zdc2hkFPyqvc8w3qry62zYB5WDmL7ge>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DF55922C00A2; Wed,  7 Oct 2026 15:02:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEXXgXC9MU77
Date: Wed, 07 Oct 2026 21:02:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, gItGitgadget <gitgitgadget@gmail.com>
Cc: "Julia Evans" <julia@jvns.ca>
Message-Id: <cb482e6d-0c76-4f34-b72c-03b5234d4f37@app.fastmail.com>
In-Reply-To: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation

This change adds a standalone guide as well. The subject =E2=80=9Cjust=E2=
=80=9D make it
sound like you are rewriting the text where it is.

On Wed, Oct 7, 2026, at 16:52, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> The current explanation has the following issues:
>
> - Says detached HEAD state is useful but doesn't explain why
> - Takes many paragraphs before explaining what detached HEAD state is
> - It's common for users to accidentally end up in detached HEAD state,
>   but it doesn't explain why that might happen
> - One of the UI improvements in `git switch` is to make it harder
>   to detach accidentally, but that isn't advertised.
>   See 7968bef06b (switch: only allow explicit detached HEAD, 2019-03-2=
9)
> - Too many confusing diagrams
>
> Write a new explanation addressing these issues, and put it in a
> standalone guide so that we can easily reference it from advice
> ("see `git help detachedhead`").
> The result is a shorter guide that covers more material.
>
> The framing that "Git considers commits that aren't on a branch/other
> reference to be garbage" is taken from Steve Klabnik's tutorial
> https://steveklabnik.github.io/jujutsu-tutorial/branching-merging-and-=
conflicts/anonymous-branches.html.
> It's funny and it's consistent with the way Git uses the term
> "garbage collection".
>
> Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>     doc: checkout: rewrite detached HEAD state explanation
>
>     Often when rewriting these explanations I go through a process whe=
re I
>     ask users' feedback on the old explanation. Here I didn't do that
>     basically because that process takes a long time and I'm working o=
n a
>     bunch of other time consuming docs projects so I did a quick rewri=
te
>     based on my previous experience explaining detached HEAD state to =
folks.
>
>     I thought this could be a nice quick docs win on a topic which many
>     users find quite confusing. If the changes here are too controvers=
ial I
>     can drop it for now.
>
>     Also if folks object to making a separate git help detachedhead gu=
ide
>     I'm happy to drop that too. Personally I'm excited about the idea =
of
>     being able to reference the guides in our advice (which is one of =
our
>     best tools for getting users info about how to use Git!), but it's=
 not
>     possible to let users jump to a subsection, so this is sort of a h=
ack
>     around that.
>
> Published-As:
> https://github.com/gitgitgadget/git/releases/tag/pr-2250%2Fjvns%2Fdeta=
ched-head-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> pr-2250/jvns/detached-head-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2250
>
>  Documentation/detached-head.adoc   |  43 ++++++++++
>  Documentation/git-checkout.adoc    | 129 +----------------------------
>  Documentation/gitdetachedhead.adoc |  14 ++++

Why in one word instead of hyphenating `detached-head`?
(gitdetached-head(7))

>  advice.c                           |   1 +
>  command-list.txt                   |   1 +

This is missing meson/Makefile changes in order to make
gitdetachedhead(7).

>  5 files changed, 60 insertions(+), 128 deletions(-)
>  create mode 100644 Documentation/detached-head.adoc
>  create mode 100644 Documentation/gitdetachedhead.adoc
>
> diff --git a/Documentation/detached-head.adoc
> b/Documentation/detached-head.adoc
> new file mode 100644
> index 0000000000..1e00712124
> --- /dev/null
> +++ b/Documentation/detached-head.adoc
> @@ -0,0 +1,43 @@
> +`HEAD` is where Git stores your current branch. `HEAD` can either be:

I see that this is similar to gitdatamodel(7). Except it adds =E2=80=9C,=
 if
there is a current branch=E2=80=9D:

    HEAD is where Git stores your current branch, if there is a current
    branch. HEAD can either be: [...]

But a potential problem with that is:

A: What is HEAD?
B: It stores the current branch, if there is a current branch.
A: Oh so it is *empty* if there is no current branch?
B: No. Then it stores a commit.

This is of course revealed later here. But I wonder if starting with
current-branch can set someone up for a double take.

One could go in the other direction: you are almost always on a
commit. For most people the exception will be the unborn branch state
after `git init`. That commit is stored in the thing called `HEAD`. And
if you are on branch it also points to that branch. (It doesn=E2=80=99t =
point at
two things at the same time but instead at the branch, which is in turn
points at the commit for the branch, but conceptually it=E2=80=99s the s=
ame
difference).

> +
> +1. A branch, which is your current branch.
> +2. A commit ID, when you don't have a current branch.
> +   This is called "detached HEAD state".
> +
> +It can sometimes be useful for `HEAD` to be a commit ID.
> +For example, it lets you look at an old version of your code
> +(with `git checkout COMMIT_ID`).

Maybe go straight to `git switch --detached COMMIT_ID` here.

It is very useful to describe detached `HEAD` as something that you can
fall into by accident. It is very much perenially needed. And this
paragraph explains a legitimate, intentional use.

But a dedicated guide is also an opportunity to not only acknowledge hey
there is a use here but to explain actively why it is
convenient. Because one thing is =E2=80=9Cdetached `HEAD`=E2=80=9D as a =
conceptual,
scary blind alley where my work might get garbage collected. But only
thinking in terms of branches and tags can lead to a dead end of only
thinking of Git as:

1. The state of our collective work right now (=E2=80=9Cmain=E2=80=9D)
2. Our important waypoints (tags)

So before you lead them out of the maw of the garbage incinerator, you
can help level up their use of Git by explaining why checking out
commits freely is useful with an example of why they would do that.

1. Finding buggy commits manually (this would probably end with a
   mention of git-bisect(1))
2. Testing that each commit on a branch (forked from `main`) passes the
   test suite
3. Browsing an interesting commit manually instead of pointing `git
   grep` at the commit (or something)
4. Just being on `origin/main` instead of having a `main`. I never
   update =E2=80=9Cmain=E2=80=9D. So why would I go to the trouble of ke=
eping it up to
   date? I can just =E2=80=9Cbe on=E2=80=9D `origin/main` (detached on w=
hatever that
   points to).

   See also StackOverflow questions about how to update hundreds of
   local branches with git-pull(1) or something. Why? They do not have
   hundreds of local branches that they are authoring. They just want
   those branches by other people to be updated. But that is not
   necessary for anything. You just need the remote-tracking
   branches. Including if you want to check them out (on detached
   `HEAD`).

This conceptual dead end (of no =E2=80=9Cdetached `HEAD`) could manifest=
 itself
like this:

=E2=80=A2 =E2=80=9CI must always be on a branch=E2=80=9D
=E2=80=A2 =E2=80=9CTherefore I can only check out old commits by first c=
reating a
  branch=E2=80=9D
=E2=80=A2 =E2=80=9CEvery interesting commit must have a tag for posterie=
ty so we can
  name it=E2=80=9D (you just need the hash, even abbreviated)
=E2=80=A2 =E2=80=9CWe must tag this commit for the build so we can name =
the build=E2=80=9D (you
  can just use the hash or use part-of-the-hash with git-describe(1))

> +
> +The only problem is that if you create new commits while in detached
> +HEAD state, those commits won't be on a branch. This makes those new
> +commits much harder to find later. Also, Git considers commits that
> +aren't on any branch (or a tag or other reference) to be garbage.
> +Git will eventually permanently delete those "garbage" commits during
> +garbage collection.

Maybe this is where you should mention git-reflog(1) (and git-log(1)
maybe (see later)).

Maybe this about garbage collection could be tempered with a mention of
the however-many default days for reflog expiry. It=E2=80=99s such a lon=
g time
that if any of my commits get garbage collected... I probably didn=E2=80=
=99t
need them.

> +
> +There are 3 main ways you can end up in detached HEAD state
> +unintentionally:

I would say =E2=80=9Ctypical=E2=80=9D instead of =E2=80=9Cmain=E2=80=9D.=
 As in these things are the
typical gateways to this state (unintentionally).

> +
> +1. `git checkout COMMIT_ID`, where `COMMIT_ID` is a commit ID
> +2. `git checkout v1.3`, where v1.3 is a tag name
> +3. `git checkout origin/main`, where `origin/main` is
> +   a remote-tracking branch
> +
> +Checking out a tag puts you in detached HEAD state because `HEAD` can
> +only be a branch or a commit, not a tag or any other reference.
> +So `git checkout TAG` will set HEAD to the commit for that tag.

Nice.

> +
> +The easiest way to avoid accidentally ending up in detached HEAD state
> +is to use linkgit:git-switch[1] instead of linkgit:git-checkout[1] to
> +switch branches. `git switch` won't let you detach unless you
> explicitly
> +pass the `--detach` argument.
> +
> +To get back onto a branch, you can:
> +
> +1. Switch to the branch you want to be on, with `git switch BRANCHNAM=
E`.
> +2. Create a new branch at the current commit, with `git switch -c BRA=
NCHNAME`.
> +   You might want to do this if you've created new commits, so that y=
ou can
> +   find the commit later and so that it won't be garbage collected.
> +
> +If you create commits in detached HEAD state that aren't on a branch,
> +you can find them later using linkgit:git-reflog[1].

Okay, but it=E2=80=99s more immediate and obvious to use `git log`. Say =
you
created three commits by accident while not on a branch. Then they will
be immediately um logged.

git-reflog(1) is excellent too of course, mostly because you are likely
to find all of them if you did a lot of weird checkouts in one session.

> diff --git a/Documentation/git-checkout.adoc
> b/Documentation/git-checkout.adoc
> index 2aefea0228..4e9e94e24d 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -376,135 +376,8 @@ For more details, see the 'pathspec' entry in
> [snip]

I didn=E2=80=99t read the rest here.
