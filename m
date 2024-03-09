Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FACF2033A
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709954930; cv=none; b=nFu6r0IzaLTVHG68oRh0abduF9XJmokpQDhZ2v97I54Ykd9Ml4WxadJmoK1JIL/2FeJim+fSNfx9taKBzCnTJS8AVBMos9DvXfJWUiaIigzyQPAo3wiZJdnloLdU4dJXIGM5ECrNF3w5LnPMWJMYXHXue0tfspAPt10lAhf7M4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709954930; c=relaxed/simple;
	bh=8h8j3aK+DZh6n/Nl3Crh9Gf09B3UKeqbJfSWo05vxvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/KL4DWtfu6QZUK/pWpTJ+V3bGWC5lCF4GqTqVmrsEyra5Bq2exz+cR7t5DyH/okvUYXbXCLUktroj80rhFMPDo57gxmxwt4OatxuADNgktyUjMo3jGRdrV9YgyrNejLdrRymxQODHyPTzwg5O9YJOGmrONRHGeYVY5gEwwJ3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnRLkh1E; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnRLkh1E"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513173e8191so2144203e87.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 19:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709954927; x=1710559727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv3RSbJy8OfjvJ4Sq5BnZWFq16sgRxQvgvbAxeV//3c=;
        b=UnRLkh1EVCIz9xn3/3bGx/AU8291LFfqumuDS+GQ/t/k+SVFlct3ghNYmvV6wGdxc2
         1Vuc131xDcTTdpFuqAvsgX5jhYBLvNTTs9+6NxfLBnKOZoeIFBbdFBc04S9N5nFG9FPg
         9GmBTIi6k31yODw3XxlNBWovr4bZECuDWOgHWCy3gfqO7MA5nmwDhoHdfO7vwqAi1gxH
         8wgm7I4I9uuTnl30sn0kviZwAuikIWFeVLQ9OmUzyHyIOSsNxh8u+4iy3+SaQMm6XhJD
         qyoqCEU8fetmTiVmPbx1+6UVM4wBTsBTSD/l7FTHE5ajaAO52rg3QRzLRwAY9H/dtbO2
         3zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709954927; x=1710559727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv3RSbJy8OfjvJ4Sq5BnZWFq16sgRxQvgvbAxeV//3c=;
        b=fs9wpQ+3y3RRwQ8nlqfX+lw73a/QCKxmLBQn0gSIctmiZ19tD1gipfxDcJJPkTau8w
         6tFBDQAje9YH0dMV0wUwKLdE3+lH2+PoAWaPTw9u7tB4cht5cwru2drddUFhBUxxftjR
         MSn8sMJ1ikAQdehVn/6FeHORtXVw1so2VKolHIJ4SFDDCoL6XbW6u0EVM98MTH6mKnoZ
         XrXbE8C1RYvp8SMU0189iItPMuwxn4xuBN86QePBKsXGRN8QaOLEg7165lJ6LTolH0LH
         BrwUcF2gqutHxw58X+gWh0geEeFWhOF3QRX4q42HnMFl+PNyuDv6sCrNUpQhjy2ro19u
         D6TA==
X-Forwarded-Encrypted: i=1; AJvYcCUoGhMKpoHWzyNmhcjCeb/uG8dmGykDsnFRZV/U2daN8lZuT5pH+Uhw1yI8oALjYRbAdYeZV8i+IlBXM2aC1GzJ7Nwj
X-Gm-Message-State: AOJu0YzaVfE81aeAvnyqTcc2JxWMgB1MqAnHOGXlGY8a6LGT4mn1rgdV
	+oc05uV3OxFuN69k37OT4K85dE01tQRbivFKd9dRs/Q4j1Qef3AiZ5qjetVpEIjYemVcGYZ0lL1
	v4iMwxqkVAFBRweg7YZTiTzWTWuY=
X-Google-Smtp-Source: AGHT+IGaw4SNenMafi4s6ROYZ+p2kcnVw7cb4PBTMD3N/Ujmrc9EgheCobGM875hpeBdbcYcj4IwcwBgW3FPnJrGPjo=
X-Received: by 2002:a05:6512:ac7:b0:513:49f7:70f with SMTP id
 n7-20020a0565120ac700b0051349f7070fmr647625lfu.57.1709954926386; Fri, 08 Mar
 2024 19:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de> <xmqqsf144pi7.fsf@gitster.g>
 <CABPp-BGO2ftEMHJDrf6yg3J4AfpKn=rpf_5Wt_WAS+Hi70KqPQ@mail.gmail.com>
 <845ced9a-1f35-4100-a1ff-4243db2ba34f@haller-berlin.de> <CABPp-BE36Zhacdumd1JSc+7NXYpxZ=CQ1=ieebze=mDewpEUGA@mail.gmail.com>
 <42426c93-84fe-47d2-a41c-16284a86f003@haller-berlin.de>
In-Reply-To: <42426c93-84fe-47d2-a41c-16284a86f003@haller-berlin.de>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 8 Mar 2024 19:28:33 -0800
Message-ID: <CABPp-BF_hWGynLm8FwjWWVYc=7wc6iBr_f79=h==thkzJVoRzw@mail.gmail.com>
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
To: Stefan Haller <lists@haller-berlin.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Derrick Stolee <derrickstolee@github.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:16=E2=80=AFPM Stefan Haller <lists@haller-berlin.=
de> wrote:
>
> Elijah, thanks for your patience with this. I appreciate the time and
> energy you put into understanding what I want to achieve. The questions
> you are asking help me understand my proposal better myself.
>
> It seems that I didn't do a very good job at getting my point across so
> far, so I'll try again in a more structured way.

I think I fell short on communication on a few points as well; sorry about =
that.

> Let's begin by describing two very different user scenarios:
>
> 1) Stacked branches. Git supports these reasonably well for simple cases
> through the "rebase --update-refs" command (and the "rebase.updateRefs"
> config), but since they are not a first-class concept, git needs to rely
> on heuristics to determine which branches are part of a stack. For
> simple cases this works very well, but more esoteric cases can have
> problems (e.g. a non-linear topology of multiple stacks that may share
> common base branches and then diverge, in which case rebasing one of
> them destroys the others; or degenerate stacks involving "empty"
> branches either in the middle or at the top, in which case there's no
> way to tell what the order of the branches is supposed to be).
>
> 2) Copying a branch, and rebasing it away from the original one (for
> non-stacked branches, see below). The use case is that you have a branch
> called topic-1 (branched off main), which is pushed and in review
> already, with CI running on it, and you want to test whether it works on
> devel, so you make a new branch called topic-1-on-devel off of topic-1,
> and rebase it onto devel. You want to make a draft PR of that new branch
> to have CI run on it, too, and of course you want to keep the original
> branch untouched. For me and most of my co-worker that I have observed
> in pairing sessions, the natural way to achieve this is as described
> above: checkout a new branch, and rebase it where you want it to go.
>
> Next I'll describe my goals, and my non-goals. I know I can easily
> achieve 2) by simply not using --update-refs, but I like to have
> "rebase.updateRefs" set to true by default because it is so useful, and
> having to remember to use --no-update-refs whenever I do 2) is annoying.
>
> So my goal is to make 2) work well (in the simple, non-stacked case)
> even when "rebase.updateRefs" is true, while not making 1) work any
> worse in the "normal", non-degenerate case.

Thanks, this is helpful background.

> I'm _not_ trying to fix the problems that --update-refs has today (I
> briefly mentioned some of them above, but there are more), and I'm not
> trying to make 2) work well with stacked branches. It would certainly be
> nice if that would work too, but I don't think it can without
> introducing branch stacks as a first-class feature in git, so I'll have
> to live with not supporting that case well. It would still be a big
> improvement for me without that.

> >> When I create a copy of a
> >> branch, I do that only to rebase the copy somewhere else _immediately_=
,
> >> leaving the original branch where it was.
> >
> > If it is inherently tied like this, why not create the new branch
> > immediately after the rebase (with active_branch@{1} as the start
> > point), instead of creating it immediately before?
>
> That would be the wrong way round. I want to leave the original branch
> untouched, make a new branch and rebase that away from the original.

Ah, sorry for misunderstanding.  Still, though, what's wrong with running
    git branch -f original_branch original_branch@{1}
after the operation?  That'll make the original branch point to where
it was before the rebase operation.  Since there's no separation in
time between when you create the new copy branch and do this rebase
operation, it's not a matter of forgetting that there was this
original branch that you wanted to reflect its own pre-rebase state,
right?

Also, since you're not using the git cli directly but going through
lazygit, isn't this something you can just include in lazygit as part
of whatever overall operation is creating the new copy branch and
rebasing it?

> >> Which means that I encounter
> >> copied branches only at the top of the stack, not in the middle. Which
> >> means that I'm fine with keeping the current behavior of "rebase
> >> --update-ref" to update both copies of that middle-of-the-stack branch=
,
> >> because it never happens in practice for me.
> >
> > You've really lost me here; are you saying you're fine changing the
> > design to add inherent edgecase bugs to the code because those edge
> > cases "never happen in practice for me"?
>
> Wait, now you are really turning things around. You make it sound like
> my proposal is responsible for what you call a "bug" here. It's not, git
> already behaves like this (and you may or may not consider that a
> problem), and my proposal doesn't change anything about it. It doesn't
> "fix" it, that's right (and this is what I referred to when I said "I'm
> fine with it"), but it doesn't make it any worse either.

Ah, I see where I was unclear as well, and my lack of clarity stemmed
from not understanding your proposal.  To try to close the loop, allow
me to re-translate your "This is a good point, but..it never happens
in practice for me." paragraph, the way I _erroneously_ read it at the
time:

"""
For my new proposal, the case you bring up is a good point.  But it
doesn't happen for me, so I propose to leave it as undefined behavior.
[As undefined behavior, anyone that triggers it is likely to get
behavior they deem buggy and not like it, but that won't affect me.]
"""

Now, obviously, that doesn't sound quite right.  I knew it at the
time, but reading and re-reading your paragraph, it kept coming out
that way for me.  Thus I tried to ask if that's what you really meant,
and apologizing in advance if I was mis-reading.

Anyway, with the extra explanation in your latest email, I now see
that you weren't leaving it undefined, but your proposal wasn't clear
to me either in that paragraph or in combination with the rest of your
previous email.  Sorry for my misunderstanding.

> > By "leaf branches", do you mean (a) those commits explicitly mentioned
> > on the command line for being replayed, (b) only the subset of the
> > branches mentioned on the command line which aren't an ancestor of
> > another commit being replayed, or (c) something else?
>
> If I understand you right (and if I understand the user interface of
> git-replay right), then what I mean is the combination of all single
> commits that are mentioned on the command line, plus the right side of
> all A..B ranges that are mentioned on the command line. In my mental
> model those are "the things that are being rebased" (please let me know
> if that mental model is wrong), and I am proposing to exclude all
> branches from updating that point to any of those and are not mentioned
> on the command line, because they can be considered copies.
>
> > Let me re-ask my question another way.  If someone runs
> >     git replay --onto A --contained ^B ^C D E F
> > when branches G, H, & I are in the revision range of "^B ^C D E F",
> > with G in particular pointing where D does and H pointing where E
> > does, and E contains D in its history, and F contains commits that are
> > in neither D nor E, how do I figure out which of D-I should be
> > updated?
>
> D, E, F, and I are updated, G and H are not; this seems very obvious to
> me. D, E, and F because they are all mentioned explicitly; G and H are
> not updated because they point to one of the "things-to-be-rebased", so
> they are copies; I is updated because it is contained in E but does not
> point at one of the "things-to-be-rebased", so it's part of a "stack"
> (or whatever you want to call this topology).
>
> It's a heuristic; we need a way to distinguish things that are part of a
> stack from things that are copies. My heuristic for this relies on the
> assumption that the stack is not degenerate in the sense that it doesn't
> contain any "empty" branches in the middle or at the top of the stack,
> otherwise it wouldn't be possible to distinguish the two.

Ah, okay, now I understand the concrete proposal; thanks.

> However, _if_ we decide to change
> "rebase --update-ref", then I think it would make sense to change
> "replay --contains" in the same way, so that they behave more consistentl=
y.

Yep, makes sense.

> >> One last remark: whenever I describe my use case involving copies of
> >> branches, people tell me not to do that, use detached heads instead, o=
r
> >> other ways to achieve what I want. But then I don't understand why my
> >> proposal would make a difference for them. If you don't use copied
> >> branches, then why do you care whether "rebase --update-refs" or "repl=
ay
> >> --contained" moves those copies or not? I still haven't heard a good
> >> argument for why the current behavior is desirable, except for the one
> >> example of a degenerate stack that Phillip Wood described in [1].
> >
> > The current behavior is easy to describe and explain to users, and
> > generalizes nicely to cases of replaying multiple diverging and
> > converging branches.
>
> It sounds like you value the property of being easy to describe higher
> than doing the expected thing in as many cases as possible.

There's certainly some truth to that.  For example, "three-way merges"
are unsophisticated, and folks have suggested various ways of "making
them smarter" over the years (though there was more of this years
ago).  To quote someone else on that:
"""
Me _personally_, I want to have something that is very repeatable and
non-clever. Something I understand _or_ tells me that it can't do it.
"""
and
"""
I just don't like your notion that you should support the 5% problem with
ugly hacks, and then you dismiss the 95% problem with "nothing else does
it either".

In other words, we're already merging manually for the 95%. Why do you
think the 5% is so important?
"""

Three-way merging and rebase --update-refs are obviously quite
different, so this might not be a good analogy.  I'm just saying you
are right that I do sometimes tend to have the same biases as the
author of the above quotes.

But, to be more direct about this particular issue, I've actually had
the usecase Phillip described, and never run into yours.  Yes, it's
rare that I've run into Phillip's described case, but rare is still
more often than never.  That said, I totally accept that I might be an
oddball.  So, I think it's important to look at the alternatives:

* If we make no modifications to --update-refs:
  * the --update-refs behavior is very simple to describe
  * folks with your usecase immediately understand why the copied
branch was updated, even though you didn't want it to be
  * you have a trivial workaround you can run, as mentioned above (git
branch -f original_branch original_branch@{1})

* If we modify --update-refs as you suggest:
  * the --update-refs behavior is more complicated to describe to users
  * folks with Phillip's usecase probably assume a bug and report it
since it isn't going to make any sense to them (and, my guess is, many
would report a bug even if the behavior is documented)

The downsides for the latter option seem worse to me, so unless the
first usecase is predominant, I'd rather not make a change.  Granted,
you did claim the first usecase would be far more common, and you may
be right, but it's not so clear cut to me; I don't know how to
validate that.  I'd at least first like to hear why the workaround for
your usecase that looks trivial to me is too onerous for you.
