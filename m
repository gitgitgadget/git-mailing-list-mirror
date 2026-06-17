Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4162DB7A3
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725565; cv=none; b=qSAzq418GtjCfcM0FSlo/1f5b8myRODfDWJ+gGn1mml4UWb60oTtXC5tFvdx07OVgvlMiSwvkRl+tcWcttph2I+m7K6O65Y05gG5FoRuxrvhGJpiDnANkuHquR9N6T3HwYMUsGqRDVE07/tCgerZjGcjXJq0DeZG/P9HaOuthYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725565; c=relaxed/simple;
	bh=ektDdHBWMeeZLquavRHxtDzsbd4gw96tayUqdzJBbaU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F2ZMIfXoUCJB++hl7eHGaySzo6ol+7XEn7vFvGfCqz5TdTslxeX8lYqlkhpDF1WKEafraxg+Vn3W2ANHipSE/aya7Pqo6neDc2Q0wGFnemFyZhTp9B5gzpEQYGR0c+qXMP30QfmWqK+c8/l+9Hfr1eUZnCD+RhM86JBxYbra9Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sw07Pwc9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XlIUd+dw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sw07Pwc9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XlIUd+dw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E5D4F1D0008B;
	Wed, 17 Jun 2026 15:46:02 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 15:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781725562;
	 x=1781811962; bh=brtdCat4XxYlIjZhZjBQECcYxY4H2G2qnKNQVrN4FOc=; b=
	sw07Pwc9wICmGXcxYNhPsjZrCjXAAFoUgx/E8ML59T7ywnVOPiqUYO9I59nTqTDM
	lnISP/dnWdMA+334gBTm39xjPpBIZUZcQepgyzwksQvco5J17G3cv7Y5sPq3bf4w
	EmaB6DGfrCL5jnMQY+65imelqlc6y1PfbUhaBDz3Mr6kUVhFzB7Ew/UP71P9ByR1
	fMWy0L9uIgWIaYEzLRIg7pJYYJ59QxPO69qBz8992c3FHoLMMPCBjh1XdS3Y3cF4
	T8Pghin8BYgoj5slHKbl1QaIHvBtdHQEOrJj1XTJsG3bSWiOZ13N3XjCx4gnf5Om
	KEbqBSppojgGziN9zFM7yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781725562; x=
	1781811962; bh=brtdCat4XxYlIjZhZjBQECcYxY4H2G2qnKNQVrN4FOc=; b=X
	lIUd+dwuxXZSBLASfNhi9HxvAZpQRQW9hT8zdSD18DDBfbqAWWandGKLE9GiY8Vw
	914F448Dlj5rKMNYj6lhKekB/Gu3nZXdiuQ+5ffiU6tKr3XdR7VvqF0sVAE0OvP6
	F2ZH4iQq5uSGetsWow/mUOqoAp4amfAaIpgwZBWUDT9mAYkq3L8heG/N7URNlzJV
	Gc8C3ihG4iqhXqSuGZr4e2ldfFPJqQA7dOZhdVv0/vNOUVLZRVs1XxqD6T0gkPTd
	baXhEQtzUGcYHGgJhcWWpHolSKVJuMwySIR7RaTZGRqv5f/Lsx5Ltc54+vnPFoK7
	pewgzPUafJpPqC0Nzs5ZQ==
X-ME-Sender: <xms:evkyaisN18bLTljruDciCOkpb3q1X0PS-T7QRO2n1reqolQPV9W_Tjk>
    <xme:evkyaiQRmChr3_coPxUbIRhnhxp15pdcKPur0KQHlzIRAzDJC1aCu8z3F4QbsnpfF
    c1Vr9MJQ_kCqS_Ir4HhaWcZLkMykasDJk6PP61Z1LskpPUchSG_kg>
X-ME-Proxy-Cause: dmFkZTFo3WbRxc6OOImxmaedIjZCf2qyMWTrTnFvGVRaDQtQA2FMF60yuApfuIh58l1hsD
    rT8ud9HNhIPJwOV8pXQcZV+SbLQVnKNPhgMbo7nftUD2S+mCWouAgEEjdDKyEdB2icZaYK
    GdjXYSWx0hI6495BvsRemAygR+/v+G0juESVy2teMk8zdF7pE67M6oG4/VQ4rzWP396rhS
    B4SEIWLguL7y53ndEv3MeUCP0bjxu8Hk8+rjYjZz7Uu9c+eDDLIaAV583Kc23rK6ktRfmF
    XZGW6xoHTVEPSMpTd45ukKgiomsdMEM9mVIr+D17Y0Vv0beHVY1jIkzdVxNFCdQOpNAgHJ
    GDofjJBZJkVOdXjbC3FL/UFFclfqcL33oA8v8RUdPnw4VuE6Ja9joQwx9zubfUWnru9oEu
    Oh3qzjiG2VYlTCMFDzEmfpiZXGhMbnuKcjqU2i4WLGxgAuFhIZ3VXngA9zpb64bPAHj7Tp
    mtwnRSXxTDZSUOGUYi/EqTX78DuOxKpXvxuZCvsSI8U7n28kxioOwS/eF196dsZqKBHIk2
    nHdh4pr8YnP1iAk/hw0GkFyHyPeqXNnlC8BWwVEd1jIE7l43MwDBJIpv79tQ7vzJVrKM2z
    9coTUg3Qi4jdR9ppDdvmE2Z6eq6uVa8Kx8W1iir6m6E6TAmxx/mESQgH6vfA
X-ME-Proxy: <xmx:evkyasatsmP9POTM7olEChpZwpSZA1PRRrDM6fUy6c9jc4Hwwlotsg>
    <xmx:evkyagtRqcWIwj5l4AptaZK-CV0zIdQSJzCGiD01Tl9Z7cK0sHWBKg>
    <xmx:evkyauMyge7B6a711CDsHuSKuMJho1BSnQhuVxCMkci0rrwdWc7fSA>
    <xmx:evkyan67LvPO0hTYqz8_y5OBVbgmxPsGWyySIZtVSaSLMw1gVEqh7Q>
    <xmx:evkyalupTfJn8z37iSRHeWxInpy94zHLyqsJ7GlJoNeHcpg_DCnGSPuR>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 893E23021A92; Wed, 17 Jun 2026 15:46:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Wed, 17 Jun 2026 21:45:31 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <729baf6b-53ea-4e8d-95ab-5935667e66c2@app.fastmail.com>
In-Reply-To: <xmqqcxxyt4op.fsf@gitster.g>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz> <xmqqcxxyt4op.fsf@gitster.g>
Subject: Re: [PATCH v3 00/11] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 00:24, Junio C Hamano wrote:
>[snip]
>> +A trailer block will be created with only that trailer if a trailer
>> +block does not already exist. Recall that a trailer block needs to be
>> +preceded by a blank line, so a blank line (specifically an empty lin=
e)
>> +will be inserted before the new trailer block in that case.
>
> If you want to stress that a line with only whitespaces on it does
> not count as a blank line for the purpose of this paragraph, you can
> consistently say "an empty line" withotu saying "a blank line", and
> you do not need to have "(specifically an empty lline)" there.

Okay, I=E2=80=99ll make it shorter.

It felt too long for a simple concept indeed.

>
>> +More concretely, this is how the new trailer is added: a `<key>=3D<v=
alue>`
>> +or `<key>:<value>` argument given using `--trailer` will be appended
>> +after the existing trailers. The _<key>_ and _<value>_ parts will be
>> +trimmed to remove starting and trailing whitespace, and the resulting
>> +trimmed _<key>_ and _<value>_ will appear in the output like this:
>
> "More concretely" here feels a bit out of place, as the three paragrap=
hs
> we saw so far aren't really progression of the same thing.  First we
> saw when a new trailer line is added, second we learned that an
> extra empty line may be added in addition to the new trailer line.
> What we are about to mention is orthogonal: how each trailer line
> would look like.  There is no more or less concrete about it.

Yeah, I think I see. I thought this would be continuation into the more
nuts and bolts of it, where we move from discussing the concepts to the
concrete placeholders, so to speak.

I thought I needed a phrase to connect the paragraphs. But now I don=E2=80=
=99t
think I do. Just dropping that phrase:

    Let's consider new trailers added with `--trailer`.
    By default, the new trailer will appear at the end of the trailer bl=
ock.
    Also by default, this new trailer will only be added
    if the last trailer is different to it.
    A trailer block will be created with only that trailer if a trailer
    block does not already exist. Recall that a trailer block needs to be
    preceded by a blank line, so a blank line (specifically an empty lin=
e)
    will be inserted before the new trailer block in that case.

    This is how the new trailer is added: a `<key>=3D<value>`
    or `<key>:<value>` argument given using `--trailer` will be appended
    after the existing trailers. The _<key>_ and _<value>_ parts will be
    trimmed to remove starting and trailing whitespace, and the resulting
    trimmed _<key>_ and _<value>_ will appear in the output like this:

And it still flows.

>
>>  ------------------------------------------------
>>  key: value
>> @@ -74,6 +82,16 @@ key: value
>>  This means that the trimmed _<key>_ and _<value>_ will be separated =
by
>>  "`:`{nbsp}" (one colon followed by one space).
>>
>> +Existing trailers are extracted from the input by looking for the
>> +trailer block. Concretely, that is a group of one or more lines that=
 (i)
>
> "Concretely, that is a" -> "A trailer block is a".

Yeah. That seems simpler.

Replacing =E2=80=9Cthat=E2=80=9D with what it represents, namely =E2=80=9C=
A trailer block=E2=80=9D.

Sometimes just repeating the noun can feel stuttery, like the sentences
don=E2=80=99t flow. But there is enough variation here; the previous sen=
tence
ends with =E2=80=9Cthe trailer block=E2=80=9D (definitive), and the next=
 sentence takes
a step back and talks about the indefinitive (a trailer block).

>
>> +is all trailers, or (ii) contains at least one Git-generated or
>> +user-configured trailer and consists of at
>> +least 25% trailers.
>
> Hmph, isn't (i) a narrow subset of (ii)?

Well, this text modulo a grammatical fix goes back all the way to the
implementation of the 25% rule in 14624506 (trailer: allow non-trailers
in trailer block, 2016-10-21).

But I don=E2=80=99t see how either one is a subset of the other. With (i=
) I just
need valid trailers. With (ii) I need at least one =E2=80=9CGit-generate=
d=E2=80=9D
trailer (or `(cherry picked from` I think), i.e. as soon as a
non-trailer line has infected the prospective block.

You could have respectively:

i.  Only trailers but none are configured
ii. One configured trailer and one comment line

I don=E2=80=99t see how one can subsume the other.

>
>> +The trailer block is by definition at the end the the message. The e=
nd
>> +of the message in turn is either (i) at the end of the input, or (ii)
>
> "at the end the the message" -> "at the end of the commit log
> message", and "the input" -> "the message", probably.

Okay, there is both a =E2=80=9Cthe the=E2=80=9D as well as missing =E2=80=
=9Cof=E2=80=9D.

As to =E2=80=9C*commit* message=E2=80=9D: my first instinct was that the=
 text might as
well talk about just =E2=80=9Cmessage=E2=80=9D throughout, since we esta=
blish at the
beginning that a commit message is *one* application (and the main one)
but isn=E2=80=99t necessarily the only one (tag messages these days, in
fact). But now I see that we already use =E2=80=9Ccommit message=E2=80=9D=
 throughout, so
it is indeed best to stick with that here.

> The latter is because not everybody is "parsing" the message to futz
> with trailers, using the message as "input", and some are "writing
> out" the message, using it as "output".

I don=E2=80=99t understand this part. This is supposed to be prosaic. Th=
e input
is the data on the standard input. And of that data the message is a
subset, for example and probably most notably with the
git-format-patch(1) format.

Now, we could define what =E2=80=9Cthe commit message=E2=80=9D is in ter=
ms of =E2=80=9Cthe
message=E2=80=9D. But those terms are so close, it might look like you a=
re
restating =E2=80=9Ccommit message=E2=80=9D but just dropping =E2=80=9Cco=
mmit=E2=80=9D because it is
clear from context now.

For comparison this is the paragraph on `master` (commit 0fae78c9).

    Existing trailers are extracted from the input by looking for
    a group of one or more lines that (i) is all trailers, or (ii) conta=
ins at
    least one Git-generated or user-configured trailer and consists of at
    least 25% trailers.
    The group must be preceded by one or more empty (or whitespace-only)=
 lines.
    The group must either be at the end of the input or be the last
    non-whitespace lines before a line that starts with `---` (followed =
by a
    space or the end of the line).

>> +the last non-whitespace lines before a line that starts with `---`
>> +(followed by a space or the end of the line).
>
> OK.
