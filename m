Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C17225762
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347376; cv=none; b=gMLtA951aqSniOMLfc0OB1apqTEnCZMTvVhlRiB8PChkrOfVr30TMtCb2W0rue5VXzGgKHmVi7m5d1aff2/BI84pqrIFiQXpGXp+j6RO9m6oBkYSGHSBgTgeMGIMns+ZmDfQvzkgo4wGMMSzScb6nR4YOU8JYkArmKbXZhKTALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347376; c=relaxed/simple;
	bh=bWhxgEe5nYqjMWvm0ETeyFuLjj/SBJ7NZ2UkwBg0qjg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cAWX4CPccpZMDT8l+qJaKkKrYA5Hrx1UnW04FuhtKfdtnjpg0q44CAr7c7qOuDPyQsuH72XS/I83nwrYOjPmEiIr7Euh7zJKCBDDHxf68hb011SaN11grOepahNPp0zbwh7byx5ij33uStDv+dbI7ElTIGHfjVgJF3iBhtS9PHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=t6r7c9Vq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CcVSlncZ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="t6r7c9Vq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CcVSlncZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D61D7A009C;
	Fri,  2 Jan 2026 04:49:32 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 02 Jan 2026 04:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767347372;
	 x=1767433772; bh=YwLBQD6Oc/veDUUtJzDRQPCwBQZghXkUxeVe58ggAVY=; b=
	t6r7c9VqiTNUDyi4O08k/89e02tbUebEr86IH+sCCISfemuxi1r9vbvKglbLxuOF
	iirLdd6JNcR5KO1WXaUDy8xQsQRcJR/HlvMU1EINtPNIBfFr83ShufPBmVs6E+h7
	N+nO143yITWGIroCZrQEEzeFOw1mms1mlX4wmS/P4TnbQWjBtiZUAKehOv/yUtGN
	Ml9cj1dwqS3O7YNhlvKQ2YR9pCgn60afE8aPoq/IV+3ARlZodIOv/E/8mwJyiA0V
	uw0yisSw5IK0SzxpLAnw39l3PjfV3lVpPtc9hva6jRr/fBxLKbMjVI+oHrxjslHs
	srt5GRGTUyEzW1GV00EAeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767347372; x=
	1767433772; bh=YwLBQD6Oc/veDUUtJzDRQPCwBQZghXkUxeVe58ggAVY=; b=C
	cVSlncZEWNR2VK54jF3TsnhTLnj6wMhlLbBbXrgAXSkGjj59vQAQdsWZxozKdhCh
	cx2pHbvv3U3A/lCDfF0U056w+wW29sF3T3KcJ4d2FrSMWJ6aRrugmrfD40MFr5oG
	r6PIYRxqn3+ws3UjNGEXaCfv0gNstjUi1YIgjM0ZskXgETdeth5aQc2ckkBmz2t+
	osIZjU9grSsZbuq61Ni8V2AiILOPC4vUY0MTE56Q6qFy6v+klZm8uacsPfL+44oa
	80/6WpXkhmAo5baImvjCmsj2HlAhqkMLA21V1RAwywdFd6cD3vnqZIJH+FnFS8ec
	q9vum76EP/xHuqG2U3aNw==
X-ME-Sender: <xms:rJRXaSoQnYllrqR7xbP902z0YVXrbg1Vo_FIEeTswTiC6iKCOhqbxA8>
    <xme:rJRXabdxrOLwvRIMaIAh4lUCfl2H973fOfX7PTSqxpkTb3QaJEiVPADtj3rjdRTrw
    h3ze37qv01CezxKRXZ73w5rSPD-LHnJ2PqAMCfF9kMm_7FPdoerQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rJRXaTQk7OPljEVlY2OYNvG3d-iuNjSHZVCDpVpKXDtIuTdf4ZszvQ>
    <xmx:rJRXaSkwIoXDkmzIfC5jbBAvInYA29KT6lvwwgN6fI0kUBOs42eTAA>
    <xmx:rJRXaTSN4Ad0zVdW51X7MyNPym8Cie5BcXfFodIT-UKs5rQhE2TOtA>
    <xmx:rJRXaQMl_6uGQ1EwRllj-sIkEEKwJ0zPRImp6bM30_UOdaDDN7KAug>
    <xmx:rJRXaTUFJP5Oe7mQ4Vl-aMikJFe4Cjl8DqMQgpMeIOazEqSqqG7xW0xP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3732E1EA0068; Fri,  2 Jan 2026 04:49:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFA_5TjvXxjF
Date: Fri, 02 Jan 2026 10:48:46 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Josh Soref" <gitgitgadget@gmail.com>
Message-Id: <757d6df5-7834-4ff2-8302-8edd8e990970@app.fastmail.com>
In-Reply-To: <20260101233839.17639-1-haraldnordgren@gmail.com>
References: <xmqqh5t5c4lj.fsf@gitster.g>
 <20260101233839.17639-1-haraldnordgren@gmail.com>
Subject: Re: Another look?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026, at 00:38, Harald Nordgren wrote:
>> Again this seems to do a "step 1 goes in a direction, step 2 fixes
>> its mistake, step 3 changes course" drunken-man's walk.
>>
>> The same advice to restructure them into a logical incremental
>> progression that moves the codebase in one consistent direction to
>> eventually reach the goal at the end applies.
>
> Isn't programming always bit of drunken-man's walk?

We don=E2=80=99t have to present the chain of code changes as they =E2=80=
=9Creally
happened=E2=80=9D. An alternative is to present what will eventually be =
the
final version as if you had both a borderline perfect plan, foresight,
and execution. And that=E2=80=99s the convention in this project. Becaus=
e that=E2=80=99s
the natural progression of a patch series; each iteration you get help
to arrive at what looks like the perfect iteration. (Until someone finds
a off-by-one error two years later?)

What *really happened* is always fiction in any case.

> I'm very hesitant to restructure my history before I am confident I wi=
ll
> not need any of the old work later -- I would hate to lose history if I
> make a mistake.
>
> One option is to keep my code backed up on a separate branch locally, =
but
> this gets problematic as I add more work (endless cherry-picking and
> squashing) between local branches before submitting new patches. So no=
w you
> know some of my reasoning. I'm not saying I'm right, but it's a bit
> fear-based.

To make a snapshot of each version seems inevitable in my book since you
are encouraged to include a range-diff (and optionally also an
interdiff) between each iteration.

Now you of course have the backup of each version because you can
download the patches that you yourself posted. But that=E2=80=99s more w=
ork then
just snapshotting each version, for me at least.

> With that said, my idea has always been to squash everything into a si=
ngle
> commit before merging this. The whole diff is not that big. I can spli=
t it
> into code in one commit and tests in another.
>
> As a side-note: In my day job we only allow "squash and merge" on our
> GitHub. This gives devs the flexibility to treat their branches as a W=
IP
> area before merging, but still gives a pristine git history after merg=
e.
> This feels to me like a good trade-offs. But again, happy to take
> instructions on how to do better.

If that=E2=80=99s a good trade off, what are the variables involved in t=
he trade
off? So far it seems like:

1. Flexibility to iterate like you want
2. A final history without any back-and-forth noise (pristine/sober
   walk)

But a third variable here is

3. A series of logically separated commits

And you don=E2=80=99t get that with that approach. And a good final hist=
ory is
very important in many people=E2=80=99s eyes.

People call this mandatory squash strategy some word similar to *clean*
presumably because there is no back-and-forth noise. That=E2=80=99s the =
memetic
contagion. But there are other adjectives as well:

=E2=80=A2 Bloated: When the mandated squash strategy forces different co=
ncerns
  (code formatting, whitespace formatting, refactor, bug fix, ...) to be
  truncated into one commit
=E2=80=A2 Lossy: When so many commits get squashed that you cannot, with=
 any
  amount of analysis, piece together what lines in the commit message
  correspond to some part of the diff (especially likely to happen if
  (1) the squash commit message is a bullet list and (2) the commit
  messages are just things like =E2=80=9CWIP=E2=80=9D and =E2=80=9Cfix=E2=
=80=9D)

Someone might argue that the squash merges will not be large because the
pull requests are not large and the tasks are not large. Or they should
not be. But that demands more of both the project/task management and
the pull request management:

1. Better project management foresight and planning. Notice that we have
   traded the rewriting commits strategy of =E2=80=9Cperfect plan, fores=
ight,
   and execution=E2=80=9D for demanding more foresight from project
   management. Just because we have mandated no more than one commit per
   pull request or patch series.

   And =E2=80=9Cperfect plan, foresight, and execution=E2=80=9D is not e=
ven a
   requirement. Just a contrast to the one-commit requirement. A project
   could allow contributors to both present =E2=80=9Cperfect plan, fores=
ight,
   and execution=E2=80=9D series as well as messy series, with the latte=
r being
   squashed at the integrator=E2=80=99s/reviewer=E2=80=99s/mantainer=E2=80=
=99s discretion.
2. Divide changes into more pull requests or patch series. At least with
   vanilla GitHub that causes overhead as you have to manually link all
   the pull requests. You might also have to manually link the pull
   requests using URLs if the target branch of the PR does not do it for
   you.

   On the other hand you might have little or no overhead with some
   =E2=80=9Cstacked PR=E2=80=9D tool.

The one-commit rule works just as well if not better[1] than the
alternatives in theory. The problem is that the theory demands much more
from project management and pull request handling.

=E2=80=A0 1: Part of the motivation is often avoiding merge commits. And=
 if
     merge commits always cause point deductions then a perfectly
     executed squash merge strategy will always win over some strategy
     involving true merges.

     Although I would personally choose a rebase-with-trailer strategy
     over squash merges here; rebase the series/PR and add a trailer to
     each commit which links to the series/PR.

>
>>[snip]
