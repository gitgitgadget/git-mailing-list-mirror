Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA718DF62
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372106; cv=none; b=bivrM9nSqJ5+Kr9I/BESmDSkDCkLRDVyiPYUJ4ttA2oUame67WC2UrbAZj0p/7PriMLAXt8DCaT0iIbJqpcoteTX7v5RM5r4Tf2jeCpbs8ivM1Zke0P4S4mtaSqXM7xdZdP9uSnRL1mu0e/Dy+DWCkxr4PZlrJ2DTm9iTJVnlDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372106; c=relaxed/simple;
	bh=Qf/V3Xfc912Mp6BkNSk/ZVap0AJ/gMGJdGvD9787Otw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRFUAIQP/ogukoZ2Tq7b78VyAYD3wiHK4W1ZWZslsGY9wUDaPUgQx+f1+sW6GGE3+2nOmITXqIZYPrc7bapSjILBbdGSUu6XOzKvGyHHodyEh5Ni7w7N4tfCofQDXPWi62agI+XojgOTyC2MIBNr7ndForTNsxgcuy9p7s2jzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3x1oedh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3x1oedh"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe76fa0b8so77461cf.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722372104; x=1722976904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAU/TK34KzzvVCiGeBAn+LLn1hmo5cImHm2RB+n93EM=;
        b=U3x1oedhC9A9yoy/Fx9xmXno5cYQAs+I4psd07JGxhQxASc/hz40ZLNz6qKzDuzPz6
         XQVc2OnoYUxj50hdvFfhrWhxpieRMRFHOx0w9RSIkrHfNlm8jla1SD0ekI+10RUBnPNR
         XB0bhnz6wDKO309L4b9SlX+hQrrRM/VdH//XUr9qEQyLSylgARKnS8wqBYzBh5dVv2iI
         B8cotdKKRzQd+FboiBB5+pdCwTJSuQg+XWB25KxEJPgPjuIWN+boPfDTp5gEIkEUsv4z
         xpXOIzpPhX/bXWU2crtzbet0XqkZW/1qiavQSDAVEW5Vk/8vGtYG+R5D+2jQe3wkqUrS
         gsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722372104; x=1722976904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAU/TK34KzzvVCiGeBAn+LLn1hmo5cImHm2RB+n93EM=;
        b=K7w3lNFfzdaCo39o5S1J6qvn5FlVJWLKWU4WSg7B3T8Xqq2gc2og6SfZM8N3NpN+ZJ
         OAqtuxfQOFjSy67CLjQLxSUXowhSfNtFxEnZT4gY8cxI37rqAS9YZAmWriSzWLwcuLND
         B3j6kPr2MXQ2OTCmCYsxB1VfoOp/i7GIwnZJmytvdiW6d2/hokpTs3llQYjekXEDU3OZ
         Yo66NCkarLaifEp4m1cahvr5pnVnCHOcPkwuWkTrECpzfssR+MmHlAdPIIYSbdfDyVIu
         OaASmklw8Ts/0pRVxksC5K5V4A+fQuVaqp1CoFATWtk8R44LQVWqgtM1Vr5HFobbrU6t
         mrjQ==
X-Gm-Message-State: AOJu0YzLaPwzk3Z8pIcTVTMXjI1olBEZLuo/kCNOi8dskfsyZEkB9j0d
	Lc9BlHqkTg2t5J3yJFgrjU6gNJBUzhzn3MF6Jy4bcUIUPvBLoYBjGJi3i/r9O5FEcRNaI5ZqAV1
	JzxFPlpMB4kvuwbZPyyVVIS0E7blqSUctZV7ww+uEzF4YYEiUyg==
X-Google-Smtp-Source: AGHT+IEMYT+OofmuMSYzAUogaeFUNelg3tcDXq877hRsX3d4CNkprb+SlN5HsfI4HGyMX79+4lW0p7uNDo4xDaKtxVo=
X-Received: by 2002:ac8:5851:0:b0:447:f44d:d0ed with SMTP id
 d75a77b69052e-450430b8e0amr78991cf.1.1722372103789; Tue, 30 Jul 2024 13:41:43
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730175448.1727373-1-emilyshaffer@google.com> <xmqq7cd2bs0q.fsf@gitster.g>
In-Reply-To: <xmqq7cd2bs0q.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Tue, 30 Jul 2024 13:41:30 -0700
Message-ID: <CAJoAoZn57LMCz9dmU3u+2HS1urOcoY1HQA6axh0cWoGchS_KFA@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: add platform support policy
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 12:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > My sense is that this doc is quite close, with the only open concern
> > being around the "Minimum Requirements" section and what they should
> > contain[1]. Would it be valuable for me to trim that part out and send
> > it as a follow-on patch for us to discuss in isolation, and merge the
> > rest of the document as it is now?
>
> Hopefully just resolving a few remaining "huh?" and it would be good.

Makes sense, but I wish that we had heard back from Randall again
about that section. I'm not sure what to do if we know he is unhappy
with that part but haven't heard back from him again. (And I haven't
heard overwhelming support from other contribs on that section, which
would make it more appealing to accept the unhappiness if the rest of
the community is in favor of the text as written.)

>
> > diff --git a/Documentation/technical/platform-support.txt b/Documentati=
on/technical/platform-support.txt
> > new file mode 100644
> > index 0000000000..e0e7a3c2d8
> > --- /dev/null
> > +++ b/Documentation/technical/platform-support.txt
> > @@ -0,0 +1,187 @@
> > +Platform Support Policy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Git has a history of providing broad "support" for exotic platforms an=
d older
> > +platforms, without an explicit commitment. Stakeholders of these platf=
orms may
> > +want a more predictable support commitment. This is only possible when=
 platform
> > +stakeholders supply Git developers with adequate tooling, so we can te=
st for
> > +compatibility or develop workarounds for platform-specific quirks on o=
ur own.
> > +Various levels of tooling will allow us to make more solid commitments=
 around
> > +Git's compatibility with your platform.
>
> Most of this paragraph is about "stakeholders' platform" where the
> stakeholders are third-person, but the last sentence suddenly makes
> it "your" platform, which left a jarring sensation at least to me.
>
> "your platform" -> "platforms"?  That does not sound like a huge
> improvement.  "various platforms"?  That is not all that better,
> either.  All I can say is "your platform" sounded wrong, sorry.

Yeah, it is weird. I probably take this colloquial "you" in a bunch of
places, so I'll skim through the whole doc again to see if I can find
somewhere it feels unnatural, now that it's been a few weeks since I
wrote it at first.

For this one in specific, maybe "Various levels of platform-specific
tooling will allow us to make more solid commitments around Git's
compatibility with that platform"? To establish that we mean tooling
_for the one platform the reader cares about_, not just tooling for
any platform in general?

Or maybe this sentence isn't that useful. I was trying to use it to
warn the reader "in this doc there are tiers, you need to meet a tier
if you want the level of support it provides", but that's also quite
obvious just reading the tiers, right?

>
> > +Note that this document is about maintaining existing support for a pl=
atform
> > +that has generally worked in the past; for adding support to a platfor=
m which
> > +doesn't generally work with Git, the stakeholders for that platform ar=
e expected
> > +to do the bulk of that work themselves. We will consider such patches =
if they
> > +don't make life harder for other supported platforms, and you may well=
 find a
> > +contributor interested in working on that support, but the Git communi=
ty as a
> > +whole doesn't feel an obligation to perform such work.
>
> The part after "... and you may well find" reads a bit muddy.  I
> couldn't tell if it is talking about the initial port, or continued
> support, or both.
>
>  - The rest of this document is about continued support
>
>  - You are expected to come up with the initial porting
>
>  - If it will make the codebase too ugly with #ifdefs scattered all
>    over the place in order to provide compatibility with your
>    platform, we won't accept such an initial port.
>
>  - It is even true if some contributors are willing to give support
>    to such a platform.  We won't promise that we will bend over
>    backwards to support unreasonably exotic platforms.
>
> is what I read out of the paragraph.  Is that the message we want to
> give them?

I like that message, but what I was trying to say with that sentence
was "if you get lucky, some volunteer might want to help you with the
initial port". It seems worth at least pointing out that that would be
the exception, not the rule, but I probably already do that well
enough with the previous sentence ("the platform stakeholders are
expected to do the bulk of the work"). Let me reword the last
sentence, then:

"We will consider patches that port a new platform if they don't make
life harder for other support platforms or for Git contributors. Some
Git contributors may volunteer to help with the initial or continued
support, but that is not a given. Support work which is too intrusive
or difficult for the project to maintain may still not be accepted."

I think it still gets to your point... I was trying to avoid
"unreasonably exotic" because that's very subjective, and the
maintainer of that platform obviously doesn't think it's unreasonable,
or else why would they be working on it :)

>
> > +* Please include any information you have about the nature of the brea=
kage: is
> > +  it a memory alignment issue? Is an underlying library missing or bro=
ken for
> > +  your platform? Is there some quirk about your platform which means t=
ypical
> > +  practices (like malloc) behave strangely?
> > +
> > +** If possible, build Git from the exact same source both for your pla=
tform and
> > +   for a mainstream platform, and make sure the problem you noticed ap=
pears
> > +   only on your platform. If the problem appears in both, then it's no=
t a
> > +   compatibility issue, but we of course appreciate hearing about it i=
n a bug
> > +   report anyway, to benefit users of every platform.
>
> "and make sure" -> "to see if"
>
> and add something like "In your bug report, please mention clearly
> that it is a compatibility issue with your platform" at the end.
>
> In other words, we are interested in hearing both kinds of issues,
> but we do want to see your problem report marked clearly if it
> happens only on a particular platform.
>
> By the way, I do not see why this bullet item should be a subitem
> of the "nature of the breakage" item.  It probably would read better
> to keep them independent and on equal footing.

Thanks, adjusted for all these comments.

>
> > +Compatible on `master` and releases
> > +-----------------------------------
> > +
> > +To make sure all stable builds and regular releases work for your plat=
form the
> > +first time, help us avoid `master` breaking for your platform:
>
> "avoid `master` breaking" -> "avoid breaking `master`"?

Oh way better, I couldn't figure out why this sentence sounded so
awkward but that helps :)

>
> > +* You should run regular tests against the `next` branch and
> > +  publish breakage reports to the mailing list immediately when they h=
appen.
> > +
> > +** Ideally, these tests should run daily. At minimum, they should run =
weekly, as
> > +   topics generally spend at least 7 days in `next` before graduating =
to
> > +   `master`.
>
> Weekly would give an unlucky topic only 1 day, though.  A report
> comes, and it may probably take a few days to stop the train, in
> order to validate the breakage report.

Thanks. I left it less prescriptive and added more reasoning: "They
must run more often than weekly, as [... 7 days in next] ..., and it
takes time to put the brakes on a patch once it lands in `next`."

>
> > +Compatible on `next`
> > +--------------------
> > +
> > +To avoid reactive debugging and fixing when changes hit a release or s=
table, you
> > +can aim to ensure `next` works for your platform. (See "The Policy" in=
 the
> > +link:../howto/maintain-git.txt[maintainer's guide] for an overview of =
how `next`
> > +is used in the Git project.) To do that:
>
> "ensure `next` works" -> "ensure `next` always works"?

Done. Also noticed that I changed one link from "maintainer's guide"
to "How to maintain Git" but not this one, changed this too.

Will aim for a reroll around the end of the week, one way or another, I hop=
e.

 - Emily
