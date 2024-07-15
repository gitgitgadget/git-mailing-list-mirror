Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F434D8A3
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082068; cv=none; b=po/w1NFKjvSRHPx/4m7g/pvRsLjEJTBblbjHzp5J6GZfMRZeJWrb+YBRkFcjiczIYs1mcwaKjayMzNiA1Yp9J6UBxAlsx4uc5GC6voVtND4UJ496OYfsQ+NbjltVHWfthI+mk6ic5p7PIbgkTOAWSdhOswIj0w4/IhWeztaeLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082068; c=relaxed/simple;
	bh=uq0zcXHzJDQxsgTjfyT87FobYEpjSPjHK5uf3AR4gCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXO/WELaMvqRyS23Lygg5qyzSgxMk3uRfLozZtKdSJmR5d+ui142+dP52vUIiB7xG5JB8rDEC6jZWB0neB6iYJrqOVNNYYPxGm7YlAIngJLrTqPX/CjDW8ZtLp5gWLzB2WOrAFA8q9sZAL3wRg8Q4JmEVVgScVDsLTmn0zm8eOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRo50DIw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRo50DIw"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44a8b140a1bso122321cf.0
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721082066; x=1721686866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7zQSnGCGNAM9RdkFjSVOszYk1DSXEhzJ0QYX306buM=;
        b=sRo50DIwPj3t2ccHIai4O55owbKnFNGqrpzQJRKpbOJDgv7kBUi42DnBybNvLcOA2G
         DIs+76AUjiU5/xqKEdgfj33H7WLMAK2HB0IxoqVvcpbAPhYqgKcyu/QGn2SIyMD751f0
         3gNCY94TCLNhEQjOYMFQrVeCEoVGeYwlulwlfVitMGl4cx23TMRNzRQEZengLpjJvftx
         PCNkx/Ty1hkKJ61tGLPzZSTrV0qjgxaufRxl8Zxc+v17yx+mIxYMtYg05Tfj6K0HpRaE
         boGYppjasTEHSGWLBzsCB3IGEvv7X6jOGMzORqdyKC1KYTZqElokPqmA5LmAXDzlyihh
         hDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082066; x=1721686866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7zQSnGCGNAM9RdkFjSVOszYk1DSXEhzJ0QYX306buM=;
        b=FYyhtLmd4f9E8InRGS1N+BjCefP/Yv2PQzA+90keJj9wKvPf7n2LXHGpazJ8fxd5ZE
         p8yPrcB/0ngHmcUst1V7aw+b3fFoSd+zYV6GPBt6XcLF4NHgkpxHVR5+W4tAI0amtwrj
         3SglXOI7+wYuU1w97xm4GDNwCVD/iolu+AoF+exZDeV/xT8k6Zk3m3XCqR3QJi1AQ563
         SaQVybi2CmgaYB1whpQ6QGLRvWBRP4U1BT6GsW9QbXtFyBXiyKRSmmzyW3mnXKqwvXTK
         tT4nEzfOhL/OK7uszwnDlCQrU9ZWpt2Xy7vt50ZKp+MqZJp1l5BPr23sWiis80giYnS/
         dxrQ==
X-Gm-Message-State: AOJu0YzRFVJuysK6d+RYEPrIg//FxQ6RePfpK5Owbdb91+hBoGAbChg1
	1KmMhN2jB8VpjoujmFWFOOrByOaImpxhUDuGXupa2/jeji6j+c5Rxo0M5fjHnxsg1ZzyUoDc1lq
	Sp6YiyvmNfgrjARRaf27Lo9lq2NwticKJIFd2
X-Google-Smtp-Source: AGHT+IESfuwvgRNnKxYTsUPjfuI2/RC5xOmSghqRS2ERumlF0wml5DFKKlQ8Nbn3uRuMQTcVxPyMHauP6QdBx9FG5s4=
X-Received: by 2002:a05:622a:1b05:b0:447:e0e1:2a7b with SMTP id
 d75a77b69052e-44f7b93f7d6mr448951cf.23.1721082065302; Mon, 15 Jul 2024
 15:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711232413.693444-1-emilyshaffer@google.com> <xmqqed7ylbna.fsf@gitster.g>
In-Reply-To: <xmqqed7ylbna.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 15 Jul 2024 15:20:51 -0700
Message-ID: <CAJoAoZnUbgX1MpisdS+TkGLFrBUyX_x_M_Q6iZ2n_AhP8r4mNA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: add platform support policy
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 11:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > +Platform Support Policy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Paraphrasing a bit for my understanding (read: not suggestions to
> rewrite), with some comments (read: might suggest rewrites).
>
> > +Git has a history of providing broad "support" for exotic platforms an=
d older
> > +platforms, without an explicit commitment.
>
>     There currently is no level of guarantees given.
>
> > +This support becomes easier to
> > +maintain (and possible to commit to)
>
>     We want to give better support and certain levels of guarantees?
>     (this is left unsaid, though).

I guess? Really the way I think of it is: we don't care if we aren't
guaranteeing your platform, but if you want us to care, you need to
make it easy for us. We will not do frustrating support work (post a
patch, wait 2 weeks for someone to notice it broke, try to fix it with
no repro and limited info, wait another 2 weeks to find out the "fix"
still didn't work, etc). I think that's a distinction without much
difference, though :)

> If we don't want that, then we would not care what would make
> the support easier to maintain, so that's implied.  Do we want
> to make it more explicit?  Perhaps
>
>     Stakeholders of such platforms, however, may want to have a more
>     predictable support commitments.  It would require ...
>
> > when Git developers are provided with
> > +adequate tooling to test for compatibility.
>
>     ... platform stakeholders to supply Git developers adequate
>     tooling to test for compatibility and to develop workarounds for
>     platform specific quirks, which may be hard to find for such
>     exotic and/or older platforms without platform stakeholders'
>     involvement.

If I fudge with the rewrite a little, I get:

"""
Git has a history of providing broad "support" for exotic platforms
and older
platforms, without an explicit commitment. Stakeholders of these platforms =
may
want a more predictable support commitment. This is only possible when plat=
form
stakeholders supply Git developers with adequate tooling, so we can
test for
compatibility or develop workarounds for platform-specific quirks on
our own.
Various levels of tooling will allow us to make more solid commitments arou=
nd
Git's compatibility with your platform.
"""

Trying to capture:
* our current "support" is implicit and could break whenever, doesn't
that scare you?
* if you want something better, we need tooling from you
* generally, the tooling needs to let us self-test things against your plat=
form
* you don't have to do it all, but you get less if you do less

I left out the part about platform-specific things being hard to find
without having access to the platform; that seemed to go without
saying. But maybe I'm wrong there.

>
> > Various levels of tooling will
> > +allow us to make more solid commitments around Git's compatibility wit=
h your
> > +platform.
>
> Good.
>
> All of this document assumes that a working port of Git once existed
> in the near past for a platform, and we outline the levels of
> investment platform stakeholders can make in order to keep it
> working, and expected outcome depending on the level of their
> investment.  The document does not cover "I now have this exotic
> box---could you port Git to it?"
>
> Is it something we want to clarify in this part of the document?

Clarified like so in my local copy, we can nitpick it a little before
I send v3 though:

"""
Note that this document is about maintaining existing support for a platfor=
m
that has generally worked in the past; for adding support to a
platform which
doesn't generally work with Git, the stakeholders for that platform are exp=
ected
to do the bulk of that work themselves. We will consider such patches
if they
don't make life harder for other supported platforms, and you may well find=
 a
contributor interested in working on that support, but the Git
community as a
whole doesn't feel an obligation to perform such work.
"""

Trying to capture:
* This is only for maintenance
* If you want to bring up a new platform, that's on you
* of course, individuals do what they want, so you MIGHT find someone
to help, but no promises

>
> > +Compatible by next release
> > +--------------------------
> > +
> > +To increase probability that compatibility issues introduced in a rele=
ase
> > +will be fixed in a later release:
> > +
> > +* You should send a bug report as soon as you notice the breakage on y=
our
> > +platform. The sooner you notice, the better; watching `seen` means you=
 can
> > +notice problems before they are considered "done with review"; whereas=
 watching
> > +`master` means the stable branch could break for your platform, but yo=
u have a
> > +decent chance of avoiding a tagged release breaking you. See "The Poli=
cy" in the
> > +link:../howto/maintain-git.txt[maintainer's guide] for an overview of =
which
> > +branches are used in git.git, and how.
> > +* The bug report should include information about what platform you ar=
e using.
> > +* You should also use linkgit:git-bisect[1] and determine which commit
> > +introduced the breakage.
> > +* Please include any information you have about the nature of the brea=
kage: is
> > +it a memory alignment issue? Is an underlying library missing or broke=
n for
> > +your platform? Is there some quirk about your platform which means typ=
ical
> > +practices (like malloc) behave strangely?
> > +* Once we begin to fix the issue, please work closely with the contrib=
utor
> > +working on it to test the proposed fix against your platform.
>
> This is a source to be reformatted by AsciiDoc so it _should not_
> matter [*], but I find it utterly unreadable if a bulletted list of
> paragraphs are formatted like the above
>
>     Side note: ... but it does matter because what we look at while
>                editing is this .txt source file.
>
> I locally reformatted the above like so:
>
>         To increase probability that compatibility issues introduced in a=
 release
>         will be fixed in a later release:
>
>         * You should send a bug report as soon as you notice the breakage=
 on
>           your platform. The sooner you notice, the better; watching `see=
n`
>           means you can notice problems before they are considered "done
>           with review"; whereas watching `master` means the stable branch
>           could break for your platform, but you have a decent chance of
>           avoiding a tagged release breaking you. See "The Policy" in the
>           link:../howto/maintain-git.txt[maintainer's guide] for an overv=
iew
>           of which branches are used in git.git, and how.
>
>         * The bug report should include information about what platform y=
ou are using.
>
>         * You should also use linkgit:git-bisect[1] and determine which
>           commit introduced the breakage.
>
> to have the second and subsequent lines indented to begin at the
> same column as the first line, and have a blank line between
> bulletted list entries, which made it easier to scan the source text.
> Such a reformatting did not appear to make any changes when the
> resulting HTML file was rendered (via "lynx -dump").
>
> This might be my personal preference, and if other people prefer the
> more dense form used inthe patch, then I wouldn't complain.

Nah, I prefer it too, this is just what `<ESC>gq` gave me at first. Will fi=
x.

The way the nested bullets work in asciidoc they are still justified
all the way to the left, which means when I align to the space after
the last * I only get a one-space indent. Is this readable, or should
I indent more?

"""
* You should run nightly tests against the `next` branch and publish breaka=
ge
  reports to the mailing list immediately when they happen.

** You may want to ask to join the
mailto:git-security@googlegroups.com[security
   mailing list] in order to run tests against the fixes proposed there, to=
o.
"""

>
> Regarding this point.
>
> > +* Please include any information you have about the nature of the brea=
kage: is
> > +it a memory alignment issue? Is an underlying library missing or broke=
n for
> > +your platform? Is there some quirk about your platform which means typ=
ical
> > +practices (like malloc) behave strangely?
>
> How deep do we expect platform stakeholders to dig in their initial
> contact to us?  In order to make a firm "It is a memory alignment
> issue" would be helped by having otherwise identical version of Git
> built from the same source on a more mainstream platform (say,
> Debian GNU/Linux running on x86_64) and the exotic platform in
> question, to be able to say "Ahh, x86 is lenient to unaligned access
> and that is why this problem wasn't noticed by developers, but on my
> platform this matters".  Is such a comparison something we may want
> to hint here?  Perhaps at the end of "use git-bisect to find the
> exact commit", add something like
>
>     Build Git from exactly the same source files on your platform
>     and one of the mainstream platforms and see if the problem you
>     noticed appears on both, or only on your platform.  If the
>     former, the suggestions in this document does not apply, but of
>     course we do greatly appreciate such a bug report that will help
>     users of every platform.
>
> Note that the above would apply equally for any compatibility
> levels, not limited to those who expect "by next release".

Captured a paraphrasing of that. I like that your suggestion doesn't
get into "how to diagnose that it's *actually* a memory alignment
problem", but instead is a general reminder to make sure it really is
a platform-specific issue; it seems to me that that should be common
sense, but I don't mind calling it out anyway here :)

>
> > +Example: NonStop
> > +https://lore.kernel.org/git/01bd01da681a$b8d70a70$2a851f50$@nexbridge.=
com/[reports
> > +problems] when they're noticed.
> > +
> > +Compatible on `master` and point releases
> > +-----------------------------------------
> > +
> > +To guarantee that `master` and all point releases work for your platfo=
rm the
> > +first time:
> > +
> > +* You should run nightly tests against the `next` branch and publish b=
reakage
> > +reports to the mailing list immediately when they happen.
> > +** You may want to ask to join the mailto:git-security@googlegroups.co=
m[security
> > +mailing list] in order to run tests against the fixes proposed there, =
too.
> > +* It may make sense to automate these; if you do, make sure they are n=
ot noisy
> > +(you don't need to send a report when everything works, only when some=
thing
> > +breaks).
>
> Also, the same problem that was reported yesterday for yesterday's
> 'next' does not have to be reported for today's 'next', even if they
> are different, as long as the breakage is the same.

Called out, thanks.

>
> > +Compatible on `next`
> > +--------------------
> > +
> > +To guarantee that `next` will work for your platform, avoiding reactiv=
e
> > +debugging and fixing:
>
> Applies to the phrasing at the beginning of the previous section as
> well, but I found it easier to read if you flipped the order from
> "do Y and you get X" from "you want X, so do Y", e.g.

Clarified, and tried to clarify in previous couple sections too,
although I think they were not so bad as this one.

>
>     We can avoid reactive debugging and fixing, if you make sure
>     'next' keeps working for your platform.
>
> Do we assume that readers are familiar with the way how `master` and
> `next` are used?  Otherwise
>
>     We can avoid reactive debugging and fixing, if you make sure the
>     'next' branch keeps working for your platform.  The changes in
>     this branch are what the developers finished reviewing and are
>     expected to appear in the next tagged release.  Unless you stop
>     them, that is.

We linked to how-to-maintain-git earlier in the doc, I linked it again
here for people who are skimming. Thanks.

>
> > +* You should add a runner for your platform to the GitHub Actions CI s=
uite.
> > +This suite is run when any Git developer proposes a new patch, and hav=
ing a
> > +runner for your platform/configuration means every developer will know=
 if they
> > +break you, immediately.
>
> I am a bit surprised that nobody from GitLab complained so far, but
> the contents of the ci/ hierarchy has been reorganized and it is my
> understanding that we now consider both GitLab CI and GitHub Actions
> first-class citizens.

Added GitLab too and generalized the text referring to GitHub
specifically further down in the doc. We already have a point about
"if the existing CI doesn't work, you can roll your own" so I didn't
try to expand on it more than I already did below, though.

>
> > +** If adding it to GitHub Actions is infeasible (due to architecture c=
onstraints
> > +or for performance reasons), any other method which runs as automatica=
lly and
> > +quickly as possible works, too. For example, a service which snoops on=
 the
> > +mailing list and automatically runs tests on new [PATCH] emails, reply=
ing to the
> > +author with the results, would also be within the spirit of this requi=
rement.
>
> Again, "do not be too noisy" principle should be stressed, no?  If
> it breaks only on the exotic platform in question, please do notify,
> but if the breakage is shared with all the other platforms, then...?

I am not sure if I mind, if it's going to individual and not to the
entire list. I get redundant breakages in GitHub Actions runner review
if I left off a semicolon, too, right? Maybe I should stress more that
these don't belong on the list, though?
