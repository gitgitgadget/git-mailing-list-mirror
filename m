Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F5187332
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498409; cv=none; b=rS4q0kySGbpbRpmnlUNIP6m118J0hziajPEIzIpc5/6owo4tCS8zpBfwGcUSQ3KsiAkk341mTdHMM1VwDSnrlIIXpbBqrD6SM8qm0HtDcwU3TmMXBQWOsqIdwKzRgUqC/0DCxzI+9WzXtARqcCteo9xsaw5zaOW5RkJ3LMkM0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498409; c=relaxed/simple;
	bh=nxA9DQRGbmChYqlCIJG12lR5+EDGUQqSnCEWaojarCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akwmT+K5J0C9qTbuTF/1FMpfTmPqY0jPzf2AFKYsZDcL3k3zbM1Wz6t3L51FmmDoAzm7JOHeXi+kz9bdVzVmFTPl+S6T6ptGGsngK0BrStKlqqHtGFbJPC5kxhfyW3/UC39ssPy6PnKvolZ3oXUJnygHY9kqf1J0UrRNItkZ2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIfIP/eL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIfIP/eL"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso5280772a12.3
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759498405; x=1760103205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxA9DQRGbmChYqlCIJG12lR5+EDGUQqSnCEWaojarCw=;
        b=kIfIP/eLNJkYxFHFKH5TIpqczIrFafN7rkagyRWsiHqbK8EvKXhjx0b7HTiM8l5HzW
         b5+NFV0uFhkQPKA7JuB6TALp7nRlGg6snFpBQA/lfD3vcXhEoznsk+PUDJROiGZkhRvM
         Zfan+B+FTA1uP7fSViMgEs5NJNYMItkLGqeM/zExKQ6De4PQBnELBBEmrALSCJNaz3sM
         gXvMWl8nL6W8HD70637GBhWM8mqsiw1WNvI+AiEjQtEsMoVAuJLLXcNX7K+zBiEWBHou
         +cLW1OMx77PHoHRAYonihwt+yM2TOtNV6jctwBBlQFludcgN7cYp5rrATjv1PbBESlj7
         VYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498405; x=1760103205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxA9DQRGbmChYqlCIJG12lR5+EDGUQqSnCEWaojarCw=;
        b=sBIermC3HUn2JBwT7YlS3WjkwHDt/QYQl7yNaIAPs/b1pJmFK3zfBv8tjhmuf4D1p0
         S2mKZJ+DInbmbhjl8WCCjgEvbBoF5zWO9WSv/o74UGAJXjj2n5h6GQged3g7JfDPJyH/
         Ngr8dQyatpnWUTb1reROq1oeWsifxrohdkZCSX129ZrU9lKFZfsR33XwsFrflEir2N9D
         fbtCzMgyE3LD+2OAtjIjDGOah+B8diAecxJLJEhptofWsp4yDKIFU/ZmdbEaCs+s1G4o
         Q+qNpiuIoSiyIV5cakskfeB13YTL8wYPCqhgFZ7h0tgiS+IxMnJPEc843ihsL3WU+IM+
         jj6Q==
X-Gm-Message-State: AOJu0YwqV3YITDHmZKZiCppm0IVj6b820Dzb/47XrAEwZlSbu0E0WQeH
	K0WhwZ6GMNc1WpwwSXb7H80bAn5zZK7val9uqAB3Oxu6MS1juf724Z7n9l+mIIi69Xkvs37f3NX
	9aPflc8UWqEi6oVa+TKrwF5o/FAMDhy0=
X-Gm-Gg: ASbGncvcZHgJS0RXYvlzDCgej/uC2N/ZtBUrZw+DG/9ifUNSHQaEfaT+czxIFB1sTMN
	+jZnHjCh5v0SP5nS0awgLsOf6hkLELWCqKGJh8iAqtRFupw9wzL3J35dxYZ/zGRzOEjh3OOzZm0
	RYhri4GbWtAiXyupwjEz5Uw9gMKHQoFWmiYu/6OgRT898igqaojb7xAAh7zaJ7wWTq6RQyfj5+8
	2tiGblFyLALtkZTvlMOM/WG0O9vwZ8=
X-Google-Smtp-Source: AGHT+IH0Ehf/nOhschjT3jvLJdZ9cjFhQjBjQ7nWXw3RcFDgQ+Cnc3CZ0/tJ5zjrUVmIO47by6DQgdhfN0or1eDgYms=
X-Received: by 2002:a05:6402:84e:b0:638:3f72:25b5 with SMTP id
 4fb4d7f45d1cf-639348ccbecmr3224601a12.13.1759498405052; Fri, 03 Oct 2025
 06:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <DD77TA1H1OOO.351R9WDH93UZ5@wolber.net>
In-Reply-To: <DD77TA1H1OOO.351R9WDH93UZ5@wolber.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Oct 2025 15:33:12 +0200
X-Gm-Features: AS18NWBuJ4L33qOX9BWkgSneIansP9kk7x3lLuAqgLSGn6b6n73AGoODgVhoJKY
Message-ID: <CAP8UFD1Yso0NnwOVyy5bRA1ufgrjSjTXHOPeQ6us5pUX--P3rw@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: Chuck Wolber <chuck@wolber.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:59=E2=80=AFPM Chuck Wolber <chuck@wolber.net> wrot=
e:
>
> On Wed Oct 1, 2025 at 2:03 PM UTC, Christian Couder wrote:
>
> > To mitigate both risks, let's add an "Use of Artificial Intelligence"
> > section to "Documentation/SubmittingPatches" with the goal of
> > discouraging its blind use to generate content that is submitted to
> > the project, while still allowing us to benefit from its help in some
> > innovative, useful and less risky ways.
>
> I love the intent here, but it does not seem like that came through in th=
e
> proposed patch.
>
> I think this patch opens the door to some concerning issues, including th=
e
> potential for false accusations and inconsistent treatment of human (non-=
AI)
> generated contributions.

I don't think the patch changes anything regarding false accusation
and inconsistent treatment of human generated contributions.

> Sticking to a message of self-reliance (e.g. responsible AI use) and maki=
ng
> some technical changes to mark AI content might be a better approach.

I don't think we want to mark AI content. It would be too much of a
burden managing this especially knowing the limit of what should be
marked or not.

> > +The Developer's Certificate of Origin requires contributors to certify
> > +that they know the origin of their contributions to the project and
> > +that they have the right to submit it under the project's license.
> > +It's not yet clear that this can be legally satisfied when submitting
> > +significant amount of content that has been generated by AI tools.
>
> The legal issues around AI will be resolved in time, but the future will =
not
> stop bringing us a steady stream of things that create legal ambiguity.
>
> Creating one-off sections that cover _multiple_ topics _including_ legal
> ambiguity seems like it risks reducing clarity. To get the full picture, =
this
> patch (and patches like it in the future) require me to navigate multiple
> sections to understand all of the project's relevant legal concerns.

I don't think having this section on top of the rest is a big burden
for developers in general. Perhaps you are very concerned about the
legal issues in the project you contribute to, but on the other hand
there weren't a lot of concerns when we added the similar AI
guidelines in https://git.github.io/General-Application-Information/.

> I also have two specific concerns with the wording:
>
> 1. It repeats what is said just a few paragraphs earlier in the document.=
 I
> understand _why_ it does this, but moving the essence of this topic up to=
 the
> DCO section avoids the repetition and avoids diluting the project's legal
> guidance.

Being able to refer people to a single section about AI has some
benefits. If you have a wording that reduces the repetition while
still making the AI section easily understandable on its own, I am
willing to consider it for a v3 version of this patch.

> 2. What am I supposed to do with "It's not yet clear"? This is worse than
> telling me nothing. It introduces a vague question with no clear guidance=
. It
> is _true_ that no clear guidance exists, but what are the consequences wh=
en it
> _does_ exist? The worst case scenario is that we have to go back and
> rework/remove AI generated patches.

When guidance will exist, we might have to change our "AI use"
section, but we can deal with that then. It's better to adapt now to
the current situation as well as we can rather than try to anticipate
the future while we can't really know what it will look like.

And if we have done our best to avoid accepting too much AI generated
content now, then hopefully we won't have to go back and rework/remove
many AI generated patches.

> So why not just require something like a
> declaration of AI content like the one proposed at declare-ai.org?

I think this could add a lot of complexity to the process. For example
people could be using many different AI tools in every contribution,
like:

- for code completion,
- for checking for memory leaks,
- for checking for possible refactorings,
- for commit message translation from their native language to English,
- for email translation from their native language to English,
- for better understanding the feedback they received,
- for helping with the forge they are using (what if it performs
interactive rebases for example),
- etc

They might not know where to stop and might not even know if their
email software (like GMail for example) is already using AI to help
them write messages.

It's also possible to ask different AIs to do the same job, for
example checking for errors in the patches that are about to be sent.
What if some AIs find no improvements and others find some? Shoud what
every AI found be mentioned?

What if AIs start debating between themselves whether something is an
error or not and cannot come to a conclusion? Should that debate be
kept somehow?

And no, this is not pure speculation. I talked recently to someone
working on an IDE and thinking about saving into Git all the AI
context (including such AI debates) around some contributions to make
sure it's available for other AIs and humans working down the road on
further work based on those contributions.

In short if we now ask people to declare, then those who try to do the
right thing will spend a lot of time figuring things out and being
burdened for perhaps no good reason while those who won't care and
will do the worst on that will have the most benefits as they will not
be burdened and save a lot of time.

If automated processes are one day easily available to record some AI
context, then I don't think we would be against them, and maybe we can
decide then to ask people to use them. But we are not there yet, we
don't know what they will look like and require, and it's just not our
role to push on this.

> > +To avoid these issues, we will reject anything that looks AI
> > +generated, that sounds overly formal or bloated, that looks like AI
> > +slop, that looks good on the surface but makes no sense, or that
> > +senders don=E2=80=99t understand or cannot explain.
>
> That reads like a full stop rejection of all AI generated patch content.

In a reply to Junio, I have suggested changing "we will reject
anything that looks AI generated" to "we will reject anything that
looks significantly AI generated". I am open to tweaking that even
more, but we need to say somehow that submitting a lot of AI generated
content as-is is not welcome. Otherwise we just don't mitigate the
risks we want to mitigate. (See my reply to Junio.)

> What if AI were to generate a great patch whose technical quality is exem=
plary
> in every way? How is that any different from a great patch of exemplary
> technical quality submitted by a person who is unambiguosly evil?

If an AI were to generate a great patch no different than what a human
would generate, then we cannot say that it looks AI generated, and
then the only issue is "Do we trust the person sending the patch?". If
the person has sent a lot of patches that looked AI generated in the
past, we might reject the patch based on that. Otherwise, the issue is
the same as if someone sends some proprietary code. Yeah, we could
accept code that is proprietary if someone sends it to us and we don't
realize it's proprietary code, but then if they signed off the patch,
they are responsible for that according to the DCO.

> But perhaps you intended it to mean a full stop rejection of content that
> _looks_ like it was generated by the primitive AI we have _today_? Even g=
oing
> with the interpretation you likely intended opens up a concerning double
> standard.
>
> What if a patch "looks" AI generated, but in reality was wholly geneated =
by a
> human?

Mistakes happen. We could indeed be wrong to reject the patch based on
that. See my reply to Junio about this.

The thing is that we cannot eat our cake and have it too. If we want
to protect the project from risks related to too much AI generated
content, we need to be able to reject such content based on some
criteria that are unlikely to be perfect.

> Does this mean that patches generated by humans that fit the declared
> criteria would be treated as if they were AI generated?

Patches generated by humans that look like AI generated patches will
probably be treated as if they were AI generated. That's unfortunate,
but hopefully soon the few people who would generate patches that look
like AI generated patches will learn and will soon make their patches
look different than AI generated ones.

> What about a non-native speaker who uses AI in an attempt to bridge a lan=
guage
> barrier? By definition they would lack the ability to judge the degree to=
 which
> their patch suddenly meets your criteria.

This is one of the reasons why this v2 is different from the previous
v1. We don't outright reject any use of generative AI in this v2, we
want to say that the result shouldn't look like a lot of AI generated
content sent as-is. If an AI was used to translate something that was
initially human generated, it will hopefully not sound like it was
fully AI generated.

And yeah mistakes can happen, but hopefully the community and the
maintainer will be able to learn and adapt from them and the process
will be relatively smooth after some time.

> How is any of that fair, and how could you even tell the difference?

It's a judgment call, like when we decide if a patch is technically
good enough to be accepted. In practice I think we will often
recommend rewriting parts that look AI generated in the same way we
ask to rewrite bad code or bad commit messages. We might sometimes not
even mention that it seems to us like it was AI generated.

You might say that it might then not be worth having an "Use of AI"
section in our SubmittingPatches document, but we think it's still
useful for different reasons like:

- it shows that we are trying to do something against the AI related
risks, especially the legal one,
- it might save us from reviewing AI generated content in the first
place if contributors read our SubmittingPatches document before
working on patches,
- it could give contributors good ideas about how to use AI in acceptable w=
ays,
- it signals to our reviewers that they should speak up against, or
just reject, what looks like a lot of AI generated content,
- it gives reviewers the possibility to refer contributors to some
documentation about the subject.

> And on a personal note, the subjective wording gives me a "walking on
> eggshells" feeling. It opens the door for false accusations, and gets us =
away
> from judging things _purely_ on their technical merit.

If we see content in some patches that looks copyrighted by a company,
and we are not confident that the company agreed to release it under a
compatible license, we can already reject it on non technical merit.
We could even already say something like:

"Your code looks obviously AI generated for such and such a reason. We
are not sure that so much AI generated code is compatible with the DCO
as the AI could have copy-pasted proprietary code it saw during its
training. So we are going to reject it."

So things don't fundamentally change. In this regard, this patch just
clarifies things for contributors and reviewers.

In some ways, the section that this patch adds is not different from
other sections like for example "Make separate commits for logically
separate changes." Yeah, perhaps many developers are unfortunately not
used to making separate commits for logically separate changes, and
they put a lot of different things into a single commit, and they
don't want to spend time reworking their working commits. So they
might feel that their contributions are going to be judged on baseless
red tape merit instead of the real thing. But anyway we state our
standards clearly, so they should know in advance how their
contributions are going to be judged.

> Would it not be more _consistent_ to continue saying what is already true=
? That
> your patches _must_ be remarkably high quality regardless of how they wer=
e
> created?

The issue is that quality might not be defined in the same way by
everyone. Some aspects of what we consider quality might be considered
otherwise (maybe "useless red tape") by some. So it's better to be
explicit as much as we can.

> With the addition of a required AI declaration (again, check out declare-=
ai.org
> for an example of what that might look like), I think you cover all of th=
e
> necessary bases. And sure, someone could lie. But they can lie about meet=
ing
> the DCO as well. The consequences are the same - remove/rework.
>
> > +We strongly recommend using AI tools carefully and responsibly.
>
> Agreed, but I think you lost me here.
>
> Taking your words at face value, the prior paragraph reads as if the Git
> project is declaring an outright ban on _all_ AI generated content (and I=
 am
> nearly certain that is _not_ what you intended to say).

Yeah, we don't intend to ban _all_ AI generated content. Please
suggest other wordings if some sentences read like that.

What we don't want is a lot of AI generated content that no human was
involved in creating. If a human was involved in creating some
content, then the human has at least some copyright and some
responsibility on it.

> If so, why bother
> continuing on with a PSA (Public Safety Announcement)? It reads like a
> non-alcoholic drink that has the words, "Drink Responsibly" printed on th=
e side
> of the can.

On prescription and over-the-counter drug packaging there are
sometimes "Boxed Warning" (or warnings along with a red warning
triangle pictogram in Europe) designed to alert people to potential
side effects that could impair their ability to drive or operate heavy
machinery safely. This sentence ("We strongly recommend using AI tools
carefully and responsibly.") is a bit similar. It is intended to make
people who would machinally read or look at the document pause and
think for a bit. It's a good thing when used sparingly and for good
reason which I think is the case here.

[...]

> Overall, I feel like an addition to the documentation is warranted, but t=
his
> version makes me uncomfortable if not a little unwelcome. Making a technc=
ial
> change to the required declarations and expanding on the theme of self-re=
liance
> and responsible use feels like a more productive way to address this issu=
e.
>
> Putting my "money where my mouth is", I am more than happy to suggest a
> revision to this patch if you would like. I wanted to avoid that right no=
w
> because it seemed like a dialog was warranted first.

Thanks for the review and for the offer of a revision to this patch. I
would prefer not a full new version of the patch though, but rather
some suggestions for alternative wordings of some sentences.
