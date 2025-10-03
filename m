Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076C11CA9
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501544; cv=none; b=UIGC5g7wMYFaHu2xe0UJDMJ4uYv82nPHlnCg3n+gpkle50oOJ7T06tw8f+i9pHix3DQPuXAwBhd9XLe+RyZ4K88+GB0qPncABopfbmuyzx9QF4Ci1WgF3DG6tgAWdpTMyoBwVSJm0+RmyLI51kM4iqypAtn7JqoehFWmKplR+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501544; c=relaxed/simple;
	bh=rZb142CR/ZjMPv70YL2n8UPx+e+xs6kCPKKot7soHh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=B8yh1wWUG8OmjXKlOMq0vsS0lm+SYnrqXsOY1xkO3JQFkzqxtMspW8/JAPKcSDI5fbwOBLjPTYNs7AdJq7Gbk/QYsJOA9tJlhePSKPWaes5nBJCZ+fooZ0HCM746aJMhIoos1U88SgvfkpIw7pUHE/8vLppgbGBMZntxFqCem7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzUtRfNA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzUtRfNA"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso5412220a12.3
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 07:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759501541; x=1760106341; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9Au/18oakqHurcsRtPQXCvdWYO+1oFw/EaGZ4rnXOE=;
        b=NzUtRfNAE3RtfqYIbERMap8Z9/yhaSwGt2TVoeoxafV7atKG8PSM9I9aHjjQEz8LcG
         uaR0M6CUqC/TUuLfvPWnsfPrMQmHGj1OwE1gHv3zlfOGHiXIe5FvIFQdphpWwBqFydnb
         DGfHGcbgJ/WN0ceb7uWs77gfXQAGIHHm4GzfRX3lmdxq0quwv0VnZg2zxWzeln3UjxXX
         o/XMSFoVNkEgVaQuKay9tNyIGODDmIV8VXX+ty9VhETrR/+4zP7E2geIGU7Av3eK5+kR
         y+ReEATRgFbh3uLvO8AvdWlV241gwJD04tqHJP+gUfhchENurYni3rE+Vn/czT+4ZUtI
         DAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501541; x=1760106341;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9Au/18oakqHurcsRtPQXCvdWYO+1oFw/EaGZ4rnXOE=;
        b=APYhnhJ/Jh6Zc5AxmnwCRe/HgW/KOvudS0i67gx3QbVsSXwQeiIrh6de2dHIzt32gT
         B4D1NbLmOqpwGhJftzO2K08mpL+EzgDFnEVW1ZPcf5qqrNB6sHBsp641D/Ym2AuJk7Ga
         LDh+KhaRwSR/bGX9GvWVa3AxGs7p5DTEc3ZceMBw8otiF6oWKKotpShPxV9acaiaPtPz
         6mjJ5lNZkahR7YcMEiWa6ra+c2gR00KoeezADLVvGKQOv+cktqM8gtP+4JYyw4XslLtj
         XKnWeJ84rUKcNB435vosqWJRynME1VknCL43qrMBO3cXESMt1BLbkQBHncCQec8ybLJs
         MvHw==
X-Forwarded-Encrypted: i=1; AJvYcCVw6qH693gqlHSgBQuGK5CRL5bGgSQ61AiKl4vNIID/A/Tt9dkYCksq2ByxTB/vLUzDR+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/Ra9onXDxxehlCaqiL84R+LBhs2NKG39AspKA30/qsauGM4B
	w7F7OgbTp4EGQySh/rsAERtDkPlQ8ZKvYWU9UfNDcCyxh/Oh+Ixuo9I4kPwDkff89ZMxTEC0xHb
	58fmAMsiM2oToKittKIWMh17nmAV46DQ=
X-Gm-Gg: ASbGncshBAzPV8USNCFJq+SO6s4ILUMix8Ahqc8pkpDDquBw14b/75y+WHvuYUSDOiK
	Hywq1VaStj9wbjZnntRcy3dwm0BiixrDwl96mBwN+jHBRmrz2BGXo+yT8cwxt2+UFnTXH3q50sR
	MQrwd9qz/kfsczR9joC2ehw4c3sgWyj6IcAfB6U80yoYjqxj6Wo8DfNtnS3NQNEpg3eEYrnGBef
	sezhmTNQ5fmc2WBSqdKZF2WJbZ0irs=
X-Google-Smtp-Source: AGHT+IE5px+ePQEzIQQ+fjHM1SDKAFH3m+xeD910yT2lyiLNLk6zqDcplMTQCJXsWgn63VdkfhY+j5aWxilYJK4ScHw=
X-Received: by 2002:a17:907:724e:b0:b48:29ce:5dd6 with SMTP id
 a640c23a62f3a-b49c39330d6mr426579366b.40.1759501540583; Fri, 03 Oct 2025
 07:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
In-Reply-To: <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Oct 2025 16:25:28 +0200
X-Gm-Features: AS18NWDldX3chEVcIu2WTl1SIM-nUmoD-RBxmiyXE-0POYd0sSIpA3Gf9SfATGU
Message-ID: <CAP8UFD0=W3Mn8FQBmWFPN+3G9V73iorK-Y9Hs-LQ69hWCBeDOw@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-10-01 at 14:02:50, Christian Couder wrote:
> > +[[ai]]
> > +=3D=3D=3D Use of Artificial Intelligence (AI)
> > +
> > +The Developer's Certificate of Origin requires contributors to certify
> > +that they know the origin of their contributions to the project and
> > +that they have the right to submit it under the project's license.
> > +It's not yet clear that this can be legally satisfied when submitting
> > +significant amount of content that has been generated by AI tools.
>
> Perhaps we'd like to write this:
>
>   It's not yet clear that this can be legally satisfied when submitting
>   significant amount of content that has been generated by AI tools,
>   so we cannot accept this content in our project.
>
> If we're going to have a policy, we need to be direct about it and not
> let people draw their own conclusions.  Many people don't have English
> as a first language and we don't want people trying to language lawyer.

I understand why you want to be direct, but unfortunately (or
fortunately depending on your point of view) some generated content is
acceptable if it is not too big, or if it is specific enough or if a
human has been involved enough. In a number of cases like for example
translated or reworded content, wrapping lines, refactored code, or
renamed variables, it is likely that a significant amount of content
is acceptable because a human has already been involved and the
content is specific enough. If we say right away that we cannot accept
it, we might prevent interesting and useful use cases.

> We could say something like this:
>
>   Please do not sign off your work if you=E2=80=99re using an LLM to cont=
ribute
>   unless you have included copyright and license information for all the
>   code used in that LLM.

For now I don't think we want or need to be involved in checking or
trying to check what code and/or training data has been/is used in an
LLM, what LLM(s) are used in which AI tools, all the AI tools that a
user might have used, etc. See my reply to Chuck Wolber's review
related to declare-ai.org.

> This allows the possibility that, say, Google trains an LLM entirely on
> their own code, such that there is only one copyright holder and they
> can license it as they see fit.  I don't think we _need_ to consider
> that case if we don't want to allow that (say, for code quality
> reasons), but we could if we wanted to.

I agree it would be nice if some LLMs were trained only on specific
code (or on no existing code at all) so that we could alleviate the
legal issue with them, but for now I don't think they exist. We can
always adapt later if/when they ever appear.

> > +Another issue with AI generated content is that AIs still often
> > +hallucinate or just produce bad code, commit messages, documentation
> > +or output, even when you point out their mistakes.
> > +
> > +To avoid these issues, we will reject anything that looks AI
> > +generated, that sounds overly formal or bloated, that looks like AI
> > +slop, that looks good on the surface but makes no sense, or that
> > +senders don=E2=80=99t understand or cannot explain.
>
> I've definitely seen this.  LLMs also typically do not write nice,
> logical, bisectable commits, which I personally dislike as a reviewer.
>
> > +We strongly recommend using AI tools carefully and responsibly.
>
> I think this is maybe not definitive enough.  If we don't believe it's
> possible to sign-off when code is generated using LLMs, then we should
> say definitively, "Contributors may not use AI to write contributions to
> Git," or something similarly clear.

I think it's far too restrictive for no good reason. See above and see
my discussion about this with Junio on the first version of this patch
he sent last July.

> Right now, this sounds too ambiguous and it might allow someone to write
> substantial code that they think is of good quality using an LLM because
> in their view that's careful and responsible, when we don't think that
> users can sign off on that and therefore that's not possible.  Telling
> people to use tools "carefully and responsibly" is like telling people
> to drive "a reasonable and prudent speed" without further qualification
> and then being surprised when they go 200 km/hr down the road.

The sentence ("We strongly recommend using AI tools carefully and
responsibly.") is designed to make people pause and think a bit when
they are reading machinally or just skimming the doc. It's not
designed to set a clear limit on what is acceptable and what is not.
And in fact it couldn't do so because there is no such clear limit.

> I'd like to see the language be more like our code of conduct in that it
> is broad and covers a wide variety of behaviour but also explicitly
> states what is and is not acceptable to avoid ambiguity, confusion, or
> argument.

Feel free to make more suggestions. I don't think your goal is easy to
achieve though.

> > +Contributors would often benefit more from AI by using it to guide and
> > +help them step by step towards producing a solution by themselves
> > +rather than by asking for a full solution that they would then mostly
> > +copy-paste. They can also use AI to help with debugging, or with
> > +checking for obvious mistakes, things that can be improved, things
> > +that don=E2=80=99t match our style, guidelines or our feedback, before=
 sending
> > +it to us.
>
> This kind of use I feel is less objectionable.  I think it might be
> acceptable to use an LLM as a guide, a linter, or a first-pass code
> review.

Yeah, it looks like we all agree on that. The issue is that the limit
between these acceptable kinds of use and other problematic ones is
fuzzy.

Thanks.
