Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3B31326B
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793836; cv=none; b=AXmdklPT3GKJ3gsqRF109XsII8ujPMwKuVkaSdmMGiacPsSFsswMxl4H/0JkZt+Babk+K72aM85DSx/FU2yN1IQ6nOXi/JPVHR6zvVRjMcNyg6LotIfkGwmrvBsdupy5sPtcrnjHC1Vd2zG+hjj2V1sOZu2ca9+N7X++Qwr9MSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793836; c=relaxed/simple;
	bh=vF43Veu6eEUGPjZeW2t7l0Una760Kd0qmP34B/J3icI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tCvU7WphD8FR5i6rRK5QVCOXKobmo+0z5eKJz13wXObowiBPZEzzCnL2H4HNW9JTq9t5Vye0dQUgUMD2aAMxatfUhwTCuGPNM+6Vf6pebnca/O1/oJk33QWVTuKqliuvpSVvXP66FZOve8hX0MlR4r5A5WlTj9Yv0/5Er0sltwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QJi5oS6M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lej4PzcH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QJi5oS6M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lej4PzcH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EADC14000B2;
	Thu, 18 Jun 2026 10:43:53 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 18 Jun 2026 10:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781793833;
	 x=1781880233; bh=3oK7VF0TW6ZrEGytZo+H6pcF6mCXPfEeVpZeRd2ahEM=; b=
	QJi5oS6MVU2a4pVvT870l32FC8Qt8YQEhidxJPb5DDcHrXlaTo4/8rAzCkCpONMF
	+6mvp3idngElqvnJN4+dmfI1+d8eagtb/iaZIKG7VipSLrPr5wZyrTTu7WwWOedo
	9vNmoXS265fjuE1I7P4RO6jbVO6Y1GBBTWBW1aNbUrXkZXWAl1LGZhtzzq+D9vhD
	+SDwRCHw55X8z3hT2IKsqPqQP6gHgRWmHwFoLPvyuukm7ijkNfafLfXcl2lTM3ld
	Is3DFs/nPehFJjHqcQwjjKjUKPjmiBnOeQ4GOP/8y4I9o62t8dBKq7lc290UjhfY
	o+PHDGLVb6t2kZaBA7dUwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781793833; x=1781880233; bh=3
	oK7VF0TW6ZrEGytZo+H6pcF6mCXPfEeVpZeRd2ahEM=; b=Lej4PzcHWqOXuSiCu
	j84nkdmFAszeUfuxdHssAD3tO9w33XEFvIuRgDuelRJI05UfTkUFF9U26BtCARf8
	arH36dZoyVzs8o+OgxQBpeRuFZqipe/iGmbhM1vSSdsKnXEM7qlb59+LUnHstXSa
	LoJWL/jV+YOyO+5xM/ySjIabLDr0cPp/E3n1D3Xy8o8ETAhChdaNp9/csN18qjIe
	UDBoyxIewQc08PXJIwo50UQZGWSpeAkaDudy/X6QMiKtmyg0o5pNKOQ89QVyl/1K
	+3qJl9vHLg1b79tfTWHEwRjxDXiuFWJ+tDCKMY95zSzdDJ+ZXjDE5LwPWKyg8cDo
	hQ4Sg==
X-ME-Sender: <xms:KQQ0ailY41UzWRBFPkacT2y-SQ53SLTtef_H5KyM5sPTMK2MD4diqJA>
    <xme:KQQ0akozXILV172SFoD5krJ1y2IY0jguCb6YLbs-Yro_OErdXAsTS45pT7tmqE9XA
    Gn8qEbfob-BP7iRjYiIffXQrwyoTvbuvqTTMKz5NKD1Kex0V0O76AU>
X-ME-Proxy-Cause: dmFkZTEObN2rrd6QSCqBU2d8OTgAGnk7t4PYTlgYSP/RXnOyFX3ZUiw5RI4PByAIIUcym2
    KOwq0KirC8QWweZV8gK9v3fthWz/C8zxX1PS6qGbFGUv7dZLKw87TszHfbFcOTpE72vcxt
    YFkiiDCN7toHllL4MxXdVZXREM/U5BcyNfIKBAMxfQ1FbTT3U6k4qc+DlTi7jWdtmmNs85
    QGkzWBR/Eg1Uf2AK6B2AKqMD1fLIyKZ06BZiHZ+5193dhJBQmSvH5M/9pB6h3Pwx7xFtBQ
    2Hpqf4QuZ/zIpNMDrgPiKC3eK6DSLuVoO0rsKtNiH7xVvDXySTvAtiVoBDXNkzEEDLq3cp
    bcO86Tfm1yZDVRj27dPN2ZyqtWpOa0IX6CCP0elk9Z+IiR+8JjHQ4k70BLsUpUd+8WKVKl
    kYr6DFifDPig3OnETCBnODwp3AXqlqWxbUXaAzn2r3dGAiCRh1gYkoWmbQT7Lb5+BSP5IC
    rMqS9lbEHtCRs1oW9N9kSRMrkgzzAs1hsT0OD5+P24IEZgG3C3cnWWk4JzIwhIsRBtmtOK
    6xfnLlNyUj/VypnpAKsn7/GF9GB5S6FEYJtZtti1TInf2tafpP4FCoV1EofBSVnNr2zCsG
    P+mA2w4jZpcH9mNQLWyA44+JjoVQt04soy0BpBcCizh8Yx74MdEr31f05I2w
X-ME-Proxy: <xmx:KQQ0apQbSOMW_NUK-WSZ5h4e43y7kC2yg2rgjNFv4eosb6Tan9tb6Q>
    <xmx:KQQ0agv_xHr4R7VqXuRmESgeHUPJyzu-mRC4c0aE_HMf46ZUcPsBJQ>
    <xmx:KQQ0amb37tT0i_k_SVDGOO2jLUBnuiz7J8zB5CdCtyK64SsTjF4KYg>
    <xmx:KQQ0atvlpH8h5AdJXnYng0iGdLvqdIT1J0zq-W9-YBc3zT9v6siH5g>
    <xmx:KQQ0aobQtbYk9r8aI9QF-nRnblug7-4scN-hOzdESUcqZs9R9l90_U3q>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0585F3021B5E; Thu, 18 Jun 2026 10:43:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aql5imKZl43V
Date: Thu, 18 Jun 2026 16:43:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <95cd81dc-baea-4318-9f01-6a795f8eb5bb@app.fastmail.com>
In-Reply-To: <xmqqpl1oteoi.fsf@gitster.g>
References: <xmqqv7bhxiby.fsf@gitster.g> <xmqqpl1oteoi.fsf@gitster.g>
Subject: Re: [PATCH v2] SubmittingPatches: address design critiques
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026, at 10:50, Junio C Hamano wrote:
> Contributors sometimes fail to answer fundamental design or
> viability comments from reviewers and submit subsequent rounds
> without addressing them.  When design decisions are resolved on the
> mailing list, the final justification should be recorded in the
> commit messages.

It=E2=80=99s useful to explain design decisions etc. that were not commi=
tted to
in the commit message. It=E2=80=99s yet another thing that might be far =
from
obvious during review, but when the message is written only the option
that was landed on is explained.

>[snip]
> diff --git a/Documentation/SubmittingPatches b/Documentation/Submittin=
gPatches
> index f042bb5aaf..bbe759f3d9 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -51,6 +51,21 @@ area.
>    respond to them with "Reply-All" on the mailing list, while taking
>    them into account while preparing an updated set of patches.
>  +
> +You should be particularly mindful of critiques regarding the
> +high-level design or viability of your proposal (e.g., questioning
> +whether the feature is worth implementing, or if the chosen approach
> +is appropriate).  Defend your design decisions on the list first, to
> +avoid wasting effort on an implementation whose design is not yet
> +solid.

To take it to the other extreme, there are =E2=80=9Ccontributions=E2=80=9D=
 which are
design decisions *only*, no implementation. Namely emails which sketch a
design like a new option. Those are often met with a stock response
saying:[1] submit some code, doesn=E2=80=99t have to implement it fully,=
 but we
will need some code to proceed here. I=E2=80=99ve never understood that =
stance,
and I don=E2=80=99t think it harmonizes with the sentence here of sparin=
g effort
if the design is not solid.

Many of these emails are straightforward.

1. I want this thing
2. I can implement it but I don=E2=80=99t know if *would be* accepted (a=
nd
   implementing things here would be a lot of effort for me, personally)
3. Would it be?

And the only thing I personally would change is to weaken =E2=80=9Cwould=
 be?=E2=80=9D to
=E2=80=9Ccould be?=E2=80=9D. Then with that out in the world, maybe some=
one finds this
message this day or the next week or month and reports that at least
they would like this thing.

Some people could change something small in this code base as easily as
they could propose the change idea for it (so it seems to me). They
would just have to take a walk and watch a movie to let their
subconscious process whether it was a good idea or not... But for most
people, committing to implementing something in a new codebase without
spooky assistance (...) is a task that takes a lot of effort.

To illustrate a related point, there are at least three kinds of Git
users out there:

1. Experienced C developers
2. Experienced Git developers (heavy overlap with (1))
3. Experienced and partisan Git users (knows it, believes in it)

You can imagine someone from group number 1 who is *not* in group number
3 use a weekend to implement something. But then when it is submitted it
turns out that is a very =E2=80=9Ccentralized CVS=E2=80=9D idea which do=
esn=E2=80=99t fit into
git(1) at all. That=E2=80=99s easily spotted by group number 3 by just l=
ooking
at the proposed docs or design. Now that group number 1 individual might
just have a bunch of code that is dead weight for any proper Git
workflow.

So I don=E2=80=99t understand this canned response.

There is the unofficial project idea tracker on the GitGitGadget
fork. But it seems weird to post things there and not on the mailing
list.

=E2=80=A0 1: From `git show todo:CannedResponses`:

     | [make us come to you, begging]
     |
     | I've seen from time to time people ask "I am thinking of doing th=
is;
     | will a patch be accepted?  If so, I'll work on it." before showing
     | any work, and my response always has been:
     |
     |  (1) We don't know how useful and interesting your contribution w=
ould
     |      be for our audience, until we see it; and
     |
     |  (2) If you truly believe in your work (find it useful, find writ=
ing
     |      it fun, etc.), that would be incentive enough for you to work
     |      on it, whether or not the result will land in my tree.  You
     |      should instead aim for something so brilliant that we would
     |      come to you begging for your permission to include it in our
     |      project.

    Note that point (2) is a bit more ambitious than it looks; if the
    idea is to implement your own thing for your own fork/tree and then
    maintain it yourself if upstream git.git doesn not accept it, well,
    now you need to learn how to maintain a fork for however long you
    want that feature. If you did not already know that.

> ++
> +Make sure that any new version is accompanied by a much clearer
> +explanation and justification (in the cover letter, your responses,
> +and in the revised commit messages).  Aim to make the reviewers say
> +"it is now clear why we may want to do this with the updated version".
> ++
> +Topics that fail to address fundamental design critiques without
> +resolution will not be considered ready for merging.

Nicely explained.
> ++
>  It is often beneficial to allow some time for reviewers to provide
>  feedback before sending a new version, rather than sending an updated
>  series immediately after receiving a review. This helps collect broad=
er
> @@ -323,6 +338,10 @@ The body should provide a meaningful commit messa=
ge, which:
>
>  . alternate solutions considered but discarded, if any.
>
> +. records the resolution of design or viability concerns raised by the
> +  community during the review, if any, ensuring the historical record
> +  explains why the chosen approach was accepted over alternatives.
> +

Okay.

>  [[present-tense]]
>[snip]
