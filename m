Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1484E2F2A
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892142; cv=none; b=Tv2GlKFMlhs7QX3HlsM5F4Zm1qV8RaPM5d3KeTTqEi/o/MImf6XwxBETSNrdGzzLF01n30nBBzAhjRfe9k5+5d/xXx/bP0C1l+fA+sTpehHtq05hmI1nkVwuM7zJk/A/mn93UZqb45Wf+T7nguipHuSBueNZ+lYMX1XTVZoi06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892142; c=relaxed/simple;
	bh=GL7lEFSHq9y7Ru/pNlqKLCtImIBbEjNaxNLS47VjjB4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EdDKRWq8YM7tK+BT+OgT3FI+GFa+Lg2wApZjBTJNr+v3W47LXGb5G5D/BtKmRrY8rLVjrnWEnnS3nBBvlgol/+U7EVe6ShMKJZ4uPzV8hfEW3tLN82UKxs9L6mwJBUhCkkGofzON9gi3IMqfzCOf3vlt5LWLsMfvR0foRoMO/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=JjxZWm8v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRWy3Emi; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="JjxZWm8v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRWy3Emi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A511FEC04D9
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:48:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 07:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791892138;
	 x=1791978538; bh=aeanUZNqD/pfbJWkf9U2pxYGcEQlEgJDCmF5wusABag=; b=
	JjxZWm8vpdrTHj+dd+Xp8p2eXX5FrL0MUI8TleQiba5AS13hOtMM3Am4OY1TWGFj
	CVcjs7DaAeNz7r5DWhcEiJmlLCvWfubz5PPmdJ4ICFpZ7li/6ADNxP1HDEV903SR
	yVNa+Mlxet1++dTKH2y9Qy9+t1nPtYOKDpOoHx+mcJswPxAnCJ+Une9JX+zYPRju
	pHVXFcmakB1hnx0MNd7tMUyGOGFgy1WFnxukE/iZ5iGKHuwzNRdFJAfxUTRSaA8T
	hrKYsLvDAU23GN4P84QcQ8SPM865S9ltwzR8QEfDm7pAog8faNekaKXpZ+HdZeqh
	DJ74GZ/4mSqz3CJTZRxElw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791892138; x=1791978538; bh=a
	eanUZNqD/pfbJWkf9U2pxYGcEQlEgJDCmF5wusABag=; b=KRWy3EmiPjTT060VM
	pYBsj307kDUUuEY9puYQUfHZROyyEV8ahlVuCAU6Sr6pH1rAmhoPAXM+ad4+YK4+
	Ldb4ciyJBErxL+3kDbOfSP9ddMkpW7U3b7DRRIkh1p2j7G1DBPXpMGqBfn2chkDC
	vPvy2JSNjVsF4lfyEP1xd1WTJvVZ5WwlrniDBqeDldejFaoyAMc0JFn3m9BZtnWR
	F/BWNOVcEEZuV9WOpN0DLGWMnCcIP6qOhKb5ZKMYRcH7b+z7J52dUhWE6JI3D14L
	NJ4yA5p88YkyLY1f/Q2Fb85ZNj7VZHb/Ndpjn2uhlA5kfnp+qUDSPUIrVE//Mhhs
	R3T2w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791892138; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:u+SJnAZ6hD0uL5P3BkXk0lgF4o0+cCFjt+lvAysOmzHRtoA
	K6CHu1xVJasLgcKTTi4MJ/Z0wzs7dm2zt0/ava3F7PRO24+dQ8rWhy7FtDZtnoNO
	Bkap9fUKn0bcXCwHL6H77XeI2Jlsta+KBPtaV47no/wBmKruQPfmYfsaIugzIPBw
	AUu25jtLLmMUPs6RXIeDbChWLaDqI1+IZFKK57SYd7iIEXPNoZeTDc0oOTTQKir8
	sFUKd+wtL2lD7hucaF23dxgJF6JGA67654NTKSw0VCQIS/t41srNhbZIVhtNBhtr
	QiaOQOOFj72Nam5j5ID7DaXmwHE1bMD1wpTsRgA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RSkpbXcNZinbwlUBfdJHkCrVmCIfgkhOj/pIsnXoajw=:GL7lEFSHq9y7Ru/pNlqKLCtImIBbEjNaxNLS47VjjB4=;
X-ME-Sender: <xms:qhrOakOkROtH9fd4oWTLTlHc5K1nXgYNCTQ7bJ9crA-uB96UHPRYig>
    <xme:qhrOalz2IDsULzUmDxAZwEUg8Ej53UltA4rPtThOFfdHpAimEdJuq3or-HXd80QrJ
    7QoOu1oCQP7fKDV5urpMEIKayrpV7e6CvmdqesXHTO2DnVwkTrYBzw>
X-ME-Proxy-Cause: dmFkZTE6OxxwkJ0kYyGkpPNFVYc4+EIdfZAeJgWsZ+HPD2QLxgKW/ETcu/mWchvzzpfv+X
    eouOWWS21OcSoGmJ1327wl3cDJvCkJrIcFxYlwIVzrwkD/AzAoDW1W/x/Yp4GZpUtD5Bd4
    BPyLBpDpXsLkw7xUOO0qrbXkv2OUAszgnzmV2RUBJ9t0pX3J8ogcMML96tUeedIFeGicIA
    LNa4rwmmzybRkeZYSqPgFFf6e5tfoNON4TNdD38eMmU7lZq+I19EzAoTZT0EoGqMgRD9wZ
    XZLsM245a9rVEXIyC2HfVZ2iA6hWsMB9rG4VQJYI5kPEDeD0gycdITIFzxWjs8xcOoiVmc
    XisCeNQjAqMrI2FTQBiZDf9AUKnFkoK1M9qK6YPdK86JtV17E1xnuiVGKS3CXyICBsIl7m
    Gq2lHdtK8Vc3eddBrtrPDh5KhE9va7eHiL0AXGrfvvO3j24szCqrWEfkpNAm+2niAfLu45
    VgW+k5TmT8xcyvpDk5INZD7iTz+ZBRrwHWctcsio5tmDD1FdGLk3o8FHi2Nvs5M/CJiCjr
    vj8SoEZuA0xI6I8ulrj1ZWDD6yROR7jwOkLPn1e4IlEx3KQ4Qi932hjIt1F5F4YIFIjcxr
    LG8nYNLx6vYynsrnJHNeM+DRjSXnPtrZZpNKiYTEfYuN40IjRu35zCdgS8hQ
X-ME-Proxy: <xmx:qhrOakLIeaycQPONmyVKpFUuZW7TG2QZqeWnegT-BarixxLBx4roqA>
    <xmx:qhrOar4TaJtJXE9N1XAF7H9oGReFH4708etA1P1irJ8LppWmUZt5Kg>
    <xmx:qhrOanyXlg4-bJ3Kq3jzgthYQD_Ir5itgYpNtP1qGw47kj0GTjxefA>
    <xmx:qhrOavZoGbv5suUKLbYW88MSjgnr1sn7a1GvNzOeFUTUkB9pnZS5Cg>
    <xmx:qhrOajFF0dBzXq1YgG_IISFTRGFBsI5M-MICZBgki2iHGGHlNSOlshXL>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 664B3782738; Tue, 13 Oct 2026 07:48:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1sfaQj8oK1o
Date: Tue, 13 Oct 2026 07:48:38 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Julia Evans" <gitgitgadget@gmail.com>
Message-Id: <5dad29e9-24e6-494a-9b0f-701af856ae69@app.fastmail.com>
In-Reply-To: <cb482e6d-0c76-4f34-b72c-03b5234d4f37@app.fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <cb482e6d-0c76-4f34-b72c-03b5234d4f37@app.fastmail.com>
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

To make this process easier, I'm going to first deal with factual issues
(like any mistakes or ideas for more information content to include).
I'll mark comments that are suggestions for how to make the wording
more clear with "style comment" to potentially address later.

On Wed, Oct 7, 2026, at 3:02 PM, Kristoffer Haugsbakk wrote:
>> Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
>
> This change adds a standalone guide as well. The subject =E2=80=9Cjust=
=E2=80=9D make it
> sound like you are rewriting the text where it is.

Yes. I ran out of space while writing the subject line.=20
Happy to make changes to how the commit is structured if that would
be better.

>>  Documentation/detached-head.adoc   |  43 ++++++++++
>>  Documentation/git-checkout.adoc    | 129 +--------------------------=
--
>>  Documentation/gitdetachedhead.adoc |  14 ++++
>
> Why in one word instead of hyphenating `detached-head`?
> (gitdetached-head(7))

Currently the guides are all one word with no hyphens.
Happy to use a different style if folks think we shouldn't use
the current naming convention for the guides=20

>>  advice.c                           |   1 +
>>  command-list.txt                   |   1 +
>
> This is missing meson/Makefile changes in order to make
> gitdetachedhead(7).

Thanks, will fix.

>>  5 files changed, 60 insertions(+), 128 deletions(-)
>>  create mode 100644 Documentation/detached-head.adoc
>>  create mode 100644 Documentation/gitdetachedhead.adoc
>>
>> diff --git a/Documentation/detached-head.adoc
>> b/Documentation/detached-head.adoc
>> new file mode 100644
>> index 0000000000..1e00712124
>> --- /dev/null
>> +++ b/Documentation/detached-head.adoc
>> @@ -0,0 +1,43 @@
>> +`HEAD` is where Git stores your current branch. `HEAD` can either be:
>
>
>> +
>> +1. A branch, which is your current branch.
>> +2. A commit ID, when you don't have a current branch.
>> +   This is called "detached HEAD state".
>> +
>> +It can sometimes be useful for `HEAD` to be a commit ID.
>> +For example, it lets you look at an old version of your code
>> +(with `git checkout COMMIT_ID`).
>
> Maybe go straight to `git switch --detached COMMIT_ID` here.

Style comment.

> It is very useful to describe detached `HEAD` as something that you can
> fall into by accident. It is very much perenially needed. And this
> paragraph explains a legitimate, intentional use.
>
> But a dedicated guide is also an opportunity to not only acknowledge h=
ey
> there is a use here but to explain actively why it is
> convenient. Because one thing is =E2=80=9Cdetached `HEAD`=E2=80=9D as =
a conceptual,
> scary blind alley where my work might get garbage collected. But only
> thinking in terms of branches and tags can lead to a dead end of only
> thinking of Git as:
>
> 1. The state of our collective work right now (=E2=80=9Cmain=E2=80=9D)
> 2. Our important waypoints (tags)
>
> So before you lead them out of the maw of the garbage incinerator, you
> can help level up their use of Git by explaining why checking out
> commits freely is useful with an example of why they would do that.
>
> 1. Finding buggy commits manually (this would probably end with a
>    mention of git-bisect(1))
> 2. Testing that each commit on a branch (forked from `main`) passes the
>    test suite
> 3. Browsing an interesting commit manually instead of pointing `git
>    grep` at the commit (or something)
> 4. Just being on `origin/main` instead of having a `main`. I never
>    update =E2=80=9Cmain=E2=80=9D. So why would I go to the trouble of =
keeping it up to
>    date? I can just =E2=80=9Cbe on=E2=80=9D `origin/main` (detached on=
 whatever that
>    points to).

This is a nice list of reasons being in detached head state, thanks.
Not sure if it will be helpful to include or not though.

>    See also StackOverflow questions about how to update hundreds of
>    local branches with git-pull(1) or something. Why? They do not have
>    hundreds of local branches that they are authoring. They just want
>    those branches by other people to be updated. But that is not
>    necessary for anything. You just need the remote-tracking
>    branches. Including if you want to check them out (on detached
>    `HEAD`).
>
> This conceptual dead end (of no =E2=80=9Cdetached `HEAD`) could manife=
st itself
> like this:
>
> =E2=80=A2 =E2=80=9CI must always be on a branch=E2=80=9D
> =E2=80=A2 =E2=80=9CTherefore I can only check out old commits by first=
 creating a
>   branch=E2=80=9D
> =E2=80=A2 =E2=80=9CEvery interesting commit must have a tag for poster=
iety so we can
>   name it=E2=80=9D (you just need the hash, even abbreviated)
> =E2=80=A2 =E2=80=9CWe must tag this commit for the build so we can nam=
e the build=E2=80=9D (you
>   can just use the hash or use part-of-the-hash with git-describe(1))
>
>> +The only problem is that if you create new commits while in detached
>> +HEAD state, those commits won't be on a branch. This makes those new
>> +commits much harder to find later. Also, Git considers commits that
>> +aren't on any branch (or a tag or other reference) to be garbage.
>> +Git will eventually permanently delete those "garbage" commits during
>> +garbage collection.
>
> Maybe this is where you should mention git-reflog(1) (and git-log(1)
> maybe (see later)).
>
> Maybe this about garbage collection could be tempered with a mention of
> the however-many default days for reflog expiry. It=E2=80=99s such a l=
ong time
> that if any of my commits get garbage collected... I probably didn=E2=80=
=99t
> need them.

Good idea, will mention it's 90 days by default.

>> +
>> +There are 3 main ways you can end up in detached HEAD state
>> +unintentionally:
>
> I would say =E2=80=9Ctypical=E2=80=9D instead of =E2=80=9Cmain=E2=80=9D=
. As in these things are the
> typical gateways to this state (unintentionally).

Style comment

>> +
>> +The easiest way to avoid accidentally ending up in detached HEAD sta=
te
>> +is to use linkgit:git-switch[1] instead of linkgit:git-checkout[1] to
>> +switch branches. `git switch` won't let you detach unless you
>> explicitly
>> +pass the `--detach` argument.
>> +
>> +To get back onto a branch, you can:
>> +
>> +1. Switch to the branch you want to be on, with `git switch BRANCHNA=
ME`.
>> +2. Create a new branch at the current commit, with `git switch -c BR=
ANCHNAME`.
>> +   You might want to do this if you've created new commits, so that =
you can
>> +   find the commit later and so that it won't be garbage collected.
>> +
>> +If you create commits in detached HEAD state that aren't on a branch,
>> +you can find them later using linkgit:git-reflog[1].
>
> Okay, but it=E2=80=99s more immediate and obvious to use `git log`. Sa=
y you
> created three commits by accident while not on a branch. Then they will
> be immediately um logged.
>
> git-reflog(1) is excellent too of course, mostly because you are likely
> to find all of them if you did a lot of weird checkouts in one session.

Going to deal with this another way
