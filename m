Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40781B14E2
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028446; cv=none; b=pLWXureFJN1xbv4p/49Gt6udrKRgLkGdhP/N7+SnyqtRvVy5QjCcrTG4+AFeSpQ3lN0+C13+dAzRTbMGKO0cWGfR7aWlnCWJmbwySj12Sy7j9podQoRxHMRXBaQhwWy6xDUtZEOi5aWhwG3RrOY+l8iO5YnqNdGJ5lZIfE8L56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028446; c=relaxed/simple;
	bh=DG+r3ZWyR0ewyth7TvuNphJvCaQEHa01Pcnkm5sBev4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ss4i8LtiP0UcehZ64ZyHpZ7YZn4Vw+LZrfkKlF+mtGL07oP0BzdHdLmzzwOzMFwklzUDiZLSeETxh4+4wg2SHVAyXpu8Nuy2sXkGDTrkAVptGThcoL6FlnN//XvwRiZw6AzdRnR1QXivdGyEzqx513Tq+sKVW5o227hdpZXyVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRge8XzK; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRge8XzK"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a32294b27so3712339f.0
        for <git@vger.kernel.org>; Fri, 30 Aug 2024 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725028444; x=1725633244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLppzRUj863q+RCuv2Rdhp6T2TsL17dyk3lMkIWb+sQ=;
        b=dRge8XzKn7fD3GHk4p7XcjJMtgDqz0fdHq7Jm7UNpRNRlf3lNMi//Uq0Sv+06a2gOH
         h2QGd2+zmr45XhW7k6b+bLF6v7zjg10yt2CJCC4x3/zkROPN2a72Uo80/qrnGPBMeDdI
         0vcmxfcr1wb8G584QJcloGlkT62+4oyI5QkX9cpTCEA6eTGRX19IHIAezj6Dx4ft+udU
         J3c+++iQ624xk3pvIu/H7lAWuw48wZhqt6aBWAGRCRb/DSQ0RnKBXJHlEAv93KvTQK/u
         1qTSgnjteSPdU626+qwqlcm7YRBTQgnNaoLvf1E1tbhwzdaFtvwDXrGkr9uDoWhpvlMH
         giaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725028444; x=1725633244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLppzRUj863q+RCuv2Rdhp6T2TsL17dyk3lMkIWb+sQ=;
        b=O7/LKGeyB7LGX76HZb7pbd8RoWMiue9ibAd208GOpsESlmB/dYYwJWNceFpE00z4Qg
         xGnrb3+dbS7LnXQZegrikZ/wZ03usU0iFvHktR2YPUWN8voDqEdiWRcBmuk+ycaSEuwO
         Tfjy086mk7pVpEiBTUcHfo73HvsDG2a8dnDdhX6Fq6T+iFAYbsitEFfdiYnS+okHh2/e
         oUYbad1qazeIZUy/C/kHou8jDHbKT9ERfOnf87dkiD5OauRlGDd26N9B2BxAzPNUxaa0
         /4Iz36NbWbvfk3qQ7wtDZZ0WB85Rg3sUFUCYvQz5lJ+hozPij9upft+ZO3XreSsv9TMH
         B5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUl+DzUe30ufncxlqMLQpSRMUs2R7vbYpuG5bd3qLHyestgdWFS5dWOxf1C5ivvMIiv6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxq/5RXMfZZPO3ZCmtHJZyVpKLrUesPglYApyPdJdRV2+0b4+1
	zDjiFY1QcjVppqaCWn691dp4p71wSeXVl2mDTlzfv0LOgjKpYE4ONY//5lYo5hXkGGg2j1S5f7/
	6KJl2op0MPh7hWYK71UxmbvwE6fo=
X-Google-Smtp-Source: AGHT+IEXcBK1w3pjAicJUtmxLsbTU/T/lYsB8joCPmfA/kC3GZtl6Nd8Uzg5U/7qk9Sm9tbjAAyrgnY+tHfEK1JSzPc=
X-Received: by 2002:a05:6e02:13ad:b0:39d:2795:2dfb with SMTP id
 e9e14a558f8ab-39f38b7908bmr42848825ab.12.1725028443458; Fri, 30 Aug 2024
 07:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
 <CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com>
 <20240829214336.GA440013@coredump.intra.peff.net> <CAChcVukzk=-1JNAoffWQEEv4Ne1FozGEwzGuaUWuiwhoHkcUng@mail.gmail.com>
 <20240830003147.GA450797@coredump.intra.peff.net>
In-Reply-To: <20240830003147.GA450797@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 30 Aug 2024 07:33:51 -0700
Message-ID: <CABPp-BG-Nx6SCxxkGXn_Fwd2wseifMFND8eddvWxiZVZk0zRaA@mail.gmail.com>
Subject: Re: How to turn off rename detection for cherry-pick?
To: Jeff King <peff@peff.net>
Cc: Pavel Rappo <pavel.rappo@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:31=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 30, 2024 at 12:12:07AM +0100, Pavel Rappo wrote:
>
> > You seem to have confirmed my understanding that I described in my
> > initial email (you replied to my second email in this thread).
>
> Heh, I did not even see the first message in the thread. But since we
> independently arrived at the same conclusions, I guess we can consider
> everything there accurate. :)
>
> I do think it's a bug that ort doesn't respect -Xno-renames.

I'm kind of splitting hairs, but doesn't "bug" imply it was
overlooked?  Documentation/merge-strategies.txt makes it clear it
wasn't.  ;-)

However, I agree that it makes sense to start supporting.  I didn't at
first because (a) I could find no evidence at the time that anyone
actually ever used the option in conjunction with merges for
behavioral reasons (this thread from Pavel is the first counterexample
I've seen), and (b) there was lots of evidence that the related config
option was in widespread use as a workaround to the unnecessary
performance problems of rename handling with the recursive merge
algorithm.  In particular, I wanted to hear about any performance
issues with renames in merges, and it was far easier to make the new
(then-experimental) algorithm just ignore these options than attempt
to do widespread convincing of folks to switch the relevant config
back on.  I think that a few years has given us more than ample time
to hear about potential remaining performance issues with renames in
merges, and this thread is a good example of why to support this
option.

> The fix is probably something like this:

The fix probably starts with something like this...

> diff --git a/merge-ort.c b/merge-ort.c
> index 3752c7e595..94b3ce734c 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3338,7 +3338,7 @@ static int detect_regular_renames(struct merge_opti=
ons *opt,
>         repo_diff_setup(opt->repo, &diff_opts);
>         diff_opts.flags.recursive =3D 1;
>         diff_opts.flags.rename_empty =3D 0;
> -       diff_opts.detect_rename =3D DIFF_DETECT_RENAME;
> +       diff_opts.detect_rename =3D opts->detect_rename;
>         diff_opts.rename_limit =3D opt->rename_limit;
>         if (opt->rename_limit <=3D 0)
>                 diff_opts.rename_limit =3D 7000;
>
> though I'm not sure how DIFF_DETECT_COPIES should be handled
> ("recursive" silently downgrades it to DIFF_DETECT_RENAME).

Not downgrading DIFF_DETECT_COPIES for merging would break both
"recursive" and "ort" in all kinds of interesting ways.  I once spent
a little time thinking how copy detection might affect things (long
before working on ort), and noted that under such a scenario,
"recursive" would have multiple logic bugs (mostly in the form of
missing additional needed logic rather than existing logic being
incorrect, but in places that aren't necessarily obvious at first).
Someone would have to very carefully audit the whole file containing
either recursive or ort's algorithms if they wanted to make either
somehow support copy detection.  "ort" would be even more problematic
than "recursive" for such a case -- I took full advantage of the
differences between rename detection and copy detection while
optimizing ort and I think it was intrinsic to every one of the major
optimizations I did.  So, if you really wanted to support copy
detection in ort, the very first step would be adding code to turn off
every single one of its major optimizations (including tree-level
merging, which didn't sound like a rename or copy detection like
thing, but hinged on how rename detection works to make sure it didn't
miss important halfs of renames).

But, the bigger issue with copies is how exactly could a merge
algorithm use them in any way that would make any logical sense?  What
are you going to do, take the modifications that one side of history
made to some source file, and apply those modifications to all the
copies of the file that the other side of history made?  That sounds
crazy and counter-intuitive to me.  (...and incidentally, like a
factory for creating all kinds of crazy corner case issues; we could
probably make things even messier than the mod6 testcases in the
testsuite.)

> I've added ort's author to the thread, so hopefully he should have a
> more clueful response.

Yeah, not so straightforward.  Even with the downgrading of copy
detection to rename detection in this area (like "recursive" does),
this isn't sufficient.  IIRC (I looked at this about 2 years ago or so
when some others asked off-list), at least one of the optimizations
managed to bake in an assumption about having gone through the rename
detection codepaths.  As best I remember, when you attempt to turn
rename detection off, it triggers an assertion failure in a
non-obvious place far removed from the original issue, and I only ever
got a slightly hacky workaround or two for the issue.  I didn't have
good motivation or rationale to pursue very far at the time, though,
so after some hours of looking at it, I just decided to move on to
something else.

Anyway, I'll add support for no-renames to my list of things needed
before we can delete merge-recursive.[ch] and make requests for
"recursive" just map to "ort".
