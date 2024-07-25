Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A751DFF7
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939492; cv=none; b=EIZuKAjR57ZmD6Rd0iO8r/zVXiBA/BoLmZj58E955Cs4ecVFIKdcG5HsI4bf2Wfidy0MnzakuE8+DnWWV826zLZx6KACJKXhAveLM4XN2tApvnaUysDuIYbnlEncz9tz2Ab2yKzrHznlGzByv9/pYmyjs/LJZPSbVhZX4MF3K/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939492; c=relaxed/simple;
	bh=EvvYQsgYdmxE9ewwkVkGf1y4fL12Rl6rofY3A77BQYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uGAyVU38j1eoIlZp98/Pj1sKjj7aSgAf8lWzXN+44twrnIesLxJUAwaGpinAC5YXozoeQp88Jx6NG3GPHxU/xLI2ydvfcJ9XPGaj4ekbKo5XFCHmp99KHSXmpfq6SvzOaXmW+97kPz0dcEDXuHgqBACc8rlNwpXhBVBD8gQtSvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIKXDEc3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIKXDEc3"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44e534a1fbeso17251cf.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721939489; x=1722544289; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtFDetXyTMNm++gSIf6AVeuUyT43IbTYsRDXF8180fQ=;
        b=OIKXDEc358XxFhTpeobbLt47ETXIqiODrzDrPlh0oSB3BM4Jgup+eRUEg7dKgbPBs5
         rt8lf8VzaDVWTH5tgD6n2cvaP0iGE5OXpNkcx4S0TI7bKyHh+1EJSSCTO+UoiQOSG33Z
         sKuG2yA8aMSKk2RfQ3ITTyyqfUltYIRRJwWhHIjwLxaUfRBnQoqI5jV81yn38sxyXbte
         vXREi7Z+xIP1LPKl5Q/vuUt17/v73elI+Q4PXt7gK9u/84LVYt8hyoccTlmTlbJ9N9rQ
         U1lmpOm2G1B1g75czLPZ3XxWvyWPxLPtJsJDlpqcxFTHVinbOc4j4trXaB6yBujVf9Jp
         10og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939489; x=1722544289;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtFDetXyTMNm++gSIf6AVeuUyT43IbTYsRDXF8180fQ=;
        b=FoP3XTYye6iPuteD4D4InkMntvjWjdmoe+0y30wHjA/ixhAp2KeEjOprHm3lHzEeZG
         +yj6Eh7KCFoDrxCSvbve8wD/nhCOtK1LL2SGyWXkWe9mRvrP7Zw/mRYQzmQMeeUFTvV0
         t66nMFzka9/j+vtlHsD/dXSSk236L9cZHYTzJIuwRm89M1kEewzr++BE2GkC+SiLrIgO
         MwYpEm4vT80UsT80ykIZwEXFUbFVZRx6jtsG1p0d18f+N8dKwUMqNd9yhmICYbPeqffS
         eEjhMsQQQC92BSaBQxM84KoNPXtiFRErkQ6Z0wLeaLGKESRCrslV1N6c2Y7A8hXjTeAa
         baUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFutFBqFVY9CxijQrj5TdwYOo5UUy7idMEObIR887ZFywADMwVB073JXDzhpBi5SBW5xGV7C0X4pcJRNGHrWDGz8XI
X-Gm-Message-State: AOJu0Yx2E24frLj6nnlKSOAuzDT9be/zmF4gLrLimV6rr98QPBg0VBhH
	XCwi75GVRWUtw98s5IqrfiQMt6SCL6X3f9rHpWfHqPU7F+hqiahCeQKM1YsamMUMsMohKAsX/5U
	rwf4rp28uJTpdHi2OLRdALgSCgPszwLRBr0LP
X-Google-Smtp-Source: AGHT+IGipVdaoa8O71KFgNBPoecc385RUK+Vvuzbqbo21ZZKgvTJ9eHWD/r+n4F307VlPhyXPjH7Vxd3E/dGMpubaxM=
X-Received: by 2002:a05:622a:14ca:b0:447:e0a6:9163 with SMTP id
 d75a77b69052e-44ff3a910e1mr756421cf.14.1721939488869; Thu, 25 Jul 2024
 13:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711232413.693444-1-emilyshaffer@google.com>
 <20240718173843.2411415-1-emilyshaffer@google.com> <o35snkortbqg3gexrwwsxyo4ixfqrk6cifdykfr2ujliiqr4he@fnkjehuaqukn>
In-Reply-To: <o35snkortbqg3gexrwwsxyo4ixfqrk6cifdykfr2ujliiqr4he@fnkjehuaqukn>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 25 Jul 2024 13:31:17 -0700
Message-ID: <CAJoAoZ=xT8kF1sBfKa530beftVLH-jQmJAT13bTHSBKLfXaAtg@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
To: Josh Steadmon <steadmon@google.com>, Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 2:49=E2=80=AFPM Josh Steadmon <steadmon@google.com>=
 wrote:
>
> On 2024.07.18 10:38, Emily Shaffer wrote:
> > Supporting many platforms is only easy when we have the right tools to
> > ensure that support.
> >
> > Teach platform maintainers how they can help us to help them, by
> > explaining what kind of tooling support we would like to have, and what
> > level of support becomes available as a result. Provide examples so tha=
t
> > platform maintainers can see what we're asking for in practice.
> >
> > With this policy in place, we can make changes with stronger assurance
> > that we are not breaking anybody we promised not to. Instead, we can
> > feel confident that our existing testing and integration practices
> > protect those who care from breakage.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> >
> > ---
> >
> > New in v3:
> >
> > - Made language to platform maintainers a little clearer (hopefully)
> >   about this allowing us to provide more predictable support levels.
> >
> > - Clarified that this covers maintaining previous functionality, not
> >   adding support for something new.
> >
> > - Made the bullet point formatting a little less eye-bleedy.
> >
> > - Asked reporters to make sure that bugs are really a platform
> >   compatibility bug, and not a regular bug.
> >
> > - Rephrased section intros to emphasize what the platform maintainer
> >   gets, rather than emphasize the Git project patch lifecycle.
> >
> > - Clarified alternatives to GitHub Actions CI: GitLab or list scraping.
> >   Made some notes about avoiding noise.
> >
> > - Small fixes to formatting, spacing, etc
> >
> > Thanks,
> >
> >  - Emily
> >
> > v1 description at
> > https://lore.kernel.org/git/20240709225042.2005233-1-emilyshaffer@googl=
e.com/
> > ---
> >  Documentation/Makefile                       |   1 +
> >  Documentation/technical/platform-support.txt | 177 +++++++++++++++++++
> >  2 files changed, 178 insertions(+)
> >  create mode 100644 Documentation/technical/platform-support.txt
> >
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index dc65759cb1..462af0311f 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -118,6 +118,7 @@ TECH_DOCS +=3D technical/multi-pack-index
> >  TECH_DOCS +=3D technical/pack-heuristics
> >  TECH_DOCS +=3D technical/parallel-checkout
> >  TECH_DOCS +=3D technical/partial-clone
> > +TECH_DOCS +=3D technical/platform-support
> >  TECH_DOCS +=3D technical/racy-git
> >  TECH_DOCS +=3D technical/reftable
> >  TECH_DOCS +=3D technical/scalar
> > diff --git a/Documentation/technical/platform-support.txt b/Documentati=
on/technical/platform-support.txt
> > new file mode 100644
> > index 0000000000..981997e635
> > --- /dev/null
> > +++ b/Documentation/technical/platform-support.txt
> > @@ -0,0 +1,177 @@
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
> > +
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
> > +
> > +Compatible by next release
> > +--------------------------
> > +
> > +To increase probability that compatibility issues introduced in a rele=
ase
> > +will be fixed in a later release:
> > +
> > +* You should send a bug report as soon as you notice the breakage on y=
our
> > +  platform. The sooner you notice, the better; watching `seen` means y=
ou can
> > +  notice problems before they are considered "done with review"; where=
as
> > +  watching `master` means the stable branch could break for your platf=
orm, but
> > +  you have a decent chance of avoiding a tagged release breaking you. =
See "The
> > +  Policy" in the link:../howto/maintain-git.txt[maintainer's guide] fo=
r an
> > +  overview of which branches are used in git.git, and how.
> > +
> > +* The bug report should include information about what platform you ar=
e using.
> > +
> > +* You should also use linkgit:git-bisect[1] and determine which commit
> > +  introduced the breakage.
> > +
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
> > +   for a maintstream platform, and make sure the problem you noticed a=
ppears
>
> Typo: "maintstream"

Oop, thanks :)

>
>
> > +   only on your platform. If the problem appears in both, then it's no=
t a
> > +   compatibility issue, but we of course appreciate hearing about it i=
n a bug
> > +   report anyway, to benefit users of every platform.
> > +
> > +* Once we begin to fix the issue, please work closely with the contrib=
utor
> > +  working on it to test the proposed fix against your platform.
> > +
> > +Example: NonStop
> > +https://lore.kernel.org/git/01bd01da681a$b8d70a70$2a851f50$@nexbridge.=
com/[reports
> > +problems] when they're noticed.
> > +
> > +Compatible on `master` and releases
> > +-----------------------------------------
> > +
> > +To make sure all stable builds and regular releases work for your plat=
form the
> > +first time, you can make sure `master` doesn't break for your platform=
:
> > +
> > +* You should run nightly tests against the `next` branch and publish b=
reakage
> > +  reports to the mailing list immediately when they happen.
> > +
> > +** You may want to ask to join the mailto:git-security@googlegroups.co=
m[security
> > +   mailing list] in order to run tests against the fixes proposed ther=
e, too.
> > +
> > +* It may make sense to automate these; if you do, make sure they are n=
ot noisy
> > +  (you don't need to send a report when everything works, only when so=
mething
> > +  breaks; you don't need to send repeated reports for the same breakag=
e night
> > +  after night).
> > +
> > +* Breakage reports should be actionable - include clear error messages=
 that can
> > +  help developers who may not have access to test directly on your pla=
tform.
> > +
> > +* You should use git-bisect and determine which commit introduced the =
breakage;
> > +  if you can't do this with automation, you should do this yourself ma=
nually as
> > +  soon as you notice a breakage report was sent.
> > +
> > +* You should either:
> > +
> > +** Provide VM access on-demand to a trusted developer working to fix t=
he issue,
> > +   so they can test their fix, OR
> > +
> > +** Work closely with the developer fixing the issue; the turnaround to=
 check
> > +   that their proposed fix works for your platform should be fast enou=
gh that it
> > +   doesn't hinder the developer working on that fix. Slow testing turn=
arounds
> > +   may cause the fix to miss the next release, or the developer may lo=
se
> > +   interest in working on the fix at all.
> > +
> > +Example:
> > +https://lore.kernel.org/git/CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeL=
rqmHCJB4Q@mail.gmail.com/[AIX]
> > +provides a build farm and runs tests against release candidates.
> > +
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
> > +
> > +* You should add a runner for your platform to the GitHub Actions or G=
itLab CI
> > +  suite.  This suite is run when any Git developer proposes a new patc=
h, and
> > +  having a runner for your platform/configuration means every develope=
r will
> > +  know if they break you, immediately.
> > +
> > +** If adding it to an existing CI suite is infeasible (due to architec=
ture
> > +   constraints or for performance reasons), any other method which run=
s as
> > +   automatically and quickly as possible works, too. For example, a se=
rvice
> > +   which snoops on the mailing list and automatically runs tests on ne=
w [PATCH]
> > +   emails, replying to the author with the results, would also be with=
in the
> > +   spirit of this requirement.
> > +
> > +* If you rely on Git avoiding a specific pattern that doesn't work wel=
l with
> > +  your platform (like a certain malloc pattern), raise it on the maili=
ng list.
> > +  There are a few ways to avoid these breakages, so we'll work case-by=
-case to
> > +  find a solution that doesn't unnecessarily constrain other platforms=
 to keep
> > +  compatibility with yours.
> > +
> > +* If you rely on some configuration or behavior, add a test for it. Un=
tested
> > +  behavior is subject to breakage at any time.
> > +
> > +** Clearly label these tests as necessary for platform compatibility. =
Add them
> > +   to an isolated compatibility-related test suite, like a new t* file=
 or unit
> > +   test suite, so that they're easy to remove when compatibility is no=
 longer
> > +   required.  If the specific compatibility need is gated behind an is=
sue with
> > +   another project, link to documentation of that issue (like a bug or=
 email
> > +   thread) to make it easier to tell when that compatibility need goes=
 away.
> > +
> > +** Include a comment with an expiration date for these tests no more t=
han 1 year
> > +   from now. You can update the expiration date if your platform still=
 needs
> > +   that assurance down the road, but we need to know you still care ab=
out that
> > +   compatibility case and are working to make it unnecessary.
> > +
> > +Example: We run our
> > +https://git.kernel.org/pub/scm/git/git.git/tree/.github/workflows/main=
.yml[CI
> > +suite] on Windows, Ubuntu, Mac, and others.
> > +
> > +Getting help writing platform support patches
> > +---------------------------------------------
> > +
> > +In general, when sending patches to fix platform support problems, fol=
low
> > +these guidelines to make sure the patch is reviewed with the appropria=
te level
> > +of urgency:
> > +
> > +* Clearly state in the commit message that you are fixing a platform b=
reakage,
> > +  and for which platform.
> > +
> > +* Use the CI and test suite to ensure that the fix for your platform d=
oesn't
> > +  break other platforms.
> > +
> > +* If possible, add a test ensuring this regression doesn't happen agai=
n. If
> > +  it's not possible to add a test, explain why in the commit message.
> > +
> > +Minimum Requirements
> > +--------------------
>
> It might make more sense to move this section immediately after the
> introduction. I don't feel too strongly about it though.

Yeah, I could see it: "here's a lot of nice things you could do, oh
but just kidding at the very end we pull the rug and say actually your
ancient/weird OS is not supported because it is missing XYZ" is not as
nice as "hey, do you support XYZ? great start, these are the next
things you need to do after."

I'll move it and see about adding some clarification to make it flow
(and definitely to not promise that with those minimum quals we will
absolutely support your thing, full stop).

>
>
> > +Even if platform maintainers are willing to add tests or CI runners, w=
e will
> > +not consider helping to support platforms that do not meet these minim=
um
> > +requirements:
> > +
> > +* Has C99 or C11
> > +
> > +* Has dependencies which were released in the past 10 years
> > +
> > +* Has active security support (taking security releases of dependencie=
s, etc)
> > +
> > +Platform Maintainers
> > +--------------------
> > +
> > +If you maintain a platform, or Git for that platform, and intend to wo=
rk with
> > +the Git project to ensure compatibility, please send a patch to add yo=
urself to
> > +this list.
> > +
> > +NonStop: Randall S. Becker <rsbecker@nexbridge.com>
>
>
> Overall, looks good to me, thanks!

Thanks for taking a look.

 - Emily

>
