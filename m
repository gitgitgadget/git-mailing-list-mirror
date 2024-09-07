Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5B18030
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725737656; cv=none; b=fEdK9N0zs8aZl4P2xCAfNss4LTvIDGPlt7v79kMLYSUwMide0gUiK8u4DjDXz9cw6xY3DioVSkjU/7SyxUKo+t6/nCzRLF/nyR9Cud7r2/lViYXXEX789y5pF5ZP//06Jid/OEHCFrQHJit06d/Q3uzq6wzzIS30V6f3pHCilMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725737656; c=relaxed/simple;
	bh=X/ZzDs88UdiTrfCXyi/t38IHQ7++yvNuXRRTt1Zt98w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIQ5P1n91UKB37phSsCd5r8XNQk+IcEM6gJW81hvshRjEsMnkzqn7ajwJXR4bbJldquHU6E+cpuvG6jp1l2y8urGc43U6spEXIndSnS6bi0SxJl7mPKitHj6NZAWXOCsWE2E0EARpZ4rE094vsuDt0nw8b2yAe0Z5vBFESzwEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGBqBBPH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGBqBBPH"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7163489149eso2509587a12.1
        for <git@vger.kernel.org>; Sat, 07 Sep 2024 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725737654; x=1726342454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27Mq/7tkG3b6aVMyKgCDolYM/IMMZOIQeQ1T+728UCo=;
        b=fGBqBBPHw4iVp+ADnodfwgVl84GRGCdRUKtH7gEJJJfoAFkCO7wJMylxb9sfQxPHtp
         ZiwTL7p56Fo46/iP9gfuouwIlFS/fxfoP/OICofKnDYFjeKxWHikglAK8QecKBtXXsKX
         xGNWIZ3LuBqpSkya3V0S+gkzp7mKhEA9AfXsdF3B9xDSlcay4e7m/IQVg2Njwa+Is3Wf
         JZiEOc8JxRyBvMIE2sBZuqR8kF9j6ankaD03tMOOC+fdHp7+ejgZGGFAgMqdlaUvJiaw
         A/jLaFMT83tWtWTv/o8dXrjuPhopkwlV7GNHPsbc8jaJBPYuYPozQGfbuoa1AibQyoDJ
         Dt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725737654; x=1726342454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27Mq/7tkG3b6aVMyKgCDolYM/IMMZOIQeQ1T+728UCo=;
        b=V3kxASdDdxbr5O5PpbykdLqtP+jZ9LoxCyzayLRxMMccByE19YH1gxrItcPoyxZ+/p
         9+YnkEhrmBM+qJBC9qJlCAyMPsDmvRFhNmpvla9VjPknEcbqSq4gqnIwN+f0ClrAlJLN
         QDqtSUynJm0/n/IrSM3eVaKvWlDiH9whOyZH1CsV0gEfO5zD6CHqig7SPcBLgm3165Y4
         5vDlNJ++46VvNWDTZDZzTgyDyMMMC0r1Luc6c16bkeviM0buqUOCbit3g1fi8dCeyM+L
         SmWaHG78GT7h3BQ2bphDf7JJuCacNyo2S5Dpo/ITId8UVmw3CTrI+xXTesWRq4BXS9vJ
         LwZA==
X-Forwarded-Encrypted: i=1; AJvYcCWJEBbZCOGCUfKpcAPmV6UAmyCyGQI7AZFvszh1vzHuXJ8xxHoOtTnB1jOmNj6A0fPYlwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7SSvoulMLXOxeUX7XzcN7McIwJFhF0n2yPWkU5Uvvf0BNWrn
	X4wQ2vFLUs1UXlmkhnw676EFnssDttbgEOnV5vnALU1TvOr8QBiCkRBaGCyAFpRDW+cBieRDRqO
	bks0bAXfE1GmzggkXXprVJJSGbSg=
X-Google-Smtp-Source: AGHT+IEEKE0PpgL+jxZTn3oEnm6V5e3Fo/8xEF4TSK8ADU5DMnkYc0c+tMss6V+sbtDjYbxQG3IyIbJbEwYlZ+RZ+qI=
X-Received: by 2002:a17:90a:9a7:b0:2d3:bd6f:a31e with SMTP id
 98e67ed59e1d1-2dad50cb6e5mr6763716a91.28.1725737654116; Sat, 07 Sep 2024
 12:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq7cboyq9s.fsf@gitster.g> <899eb2c2-bb18-4666-98d8-9255dedfac53@gmail.com>
 <xmqq8qw3xvob.fsf_-_@gitster.g>
In-Reply-To: <xmqq8qw3xvob.fsf_-_@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Sun, 8 Sep 2024 01:03:37 +0530
Message-ID: <CAG=Um+0X3Umt-2TQ-BGeefqdGxfVoy2Ug0tGKLycrX=_pj=oJw@mail.gmail.com>
Subject: Re: Re*: What's cooking draft as of 2024-09-06 late night
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 10:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Hi Junio and Shubham
> >
> > On 07/09/2024 06:41, Junio C Hamano wrote:
> >> Will merge to 'next'?
> >>   - sk/enable-prefetch-per-remote                                09-05=
          #1
> >>     <pull.1779.v4.git.1725565398681.gitgitgadget@gmail.com>
> >
> > I've just taken a look at this and I'm left wondering why one would
> > want to skip prefetching from a remote but still fetch from it with
> > "git fetch --all". I set remote.<remote>.skipFetchAll for the remotes
> > I don't want to prefetch.
>
> It is nice to see a review from somebody who fetches from multiple
> remotes in real life.  Very much appreciated.  I have a few
> repositories to pull from, but I never do "fetch --all", so
> skipFetchAll was totally outside my awareness.
>
> > We also have remote.<remote>.skipDefaultUpdate I don't know
> > offhand if that prevents a remote from being prefetched as well.
>
> Yuck.  And this one is described with an identical text as the
> previous one.  What is going on?
>
>     ... goes and looks ...
>
> Ah, yes, they internally update the same .skip_default_update member
> in the struct remote; the only bug is that the documentation does
> not make it clear that they are synonyms to each other.
>
> What is curious is that 7cc91a2f (Add the configuration option
> skipFetchAll, 2009-11-09) added for the sole purpose of adding this
> one, without explaining anything about the reason why it was needed,
> and my quick browsing did not find any discussion on the topic in
> the era.
>
> In any case, a remote that has .skip_default_update member set
> indeed is exempt from prefetch since 32f67888 (maintenance: respect
> remote.*.skipFetchAll, 2021-04-16), so it is a viable alternative
> (assuming that nobody would want to omit prefetching from a remote
> even if they want to fetch from the remote with "fetch --all" or
> "remote update", which is a sensible assumption) to just document
> this existing behaviour to help the users.
>
> > I think being able to specify which refs are prefectched would be
> > useful.
>
> Yes, that is what we said it is OK to punt in the first step, which
> is fine to be done in the follow-up step.
>
> --- >8 ---
> Subject: doc: remote.*.skip{DefaultUpdate,FetchAll} stops prefetch
>
> Back when 7cc91a2f (Add the configuration option skipFetchAll,
> 2009-11-09) added for the sole purpose of adding skipFetchAll as a
> synonym to skipDefaultUpdate, there was no explanation about the
> reason why it was needed., but these two configuration variables
> mean exactly the same thing.
>
> Also, when we taught the "prefetch" task to "git maintenance" later,
> we did make it pay attention to the setting, but we forgot to
> document it.
>
> Document these variables as synonyms that collectively implements
> the last-one-wins semantics, and also clarify that the prefetch task
> is also controlled by this variable.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * Note that "skipped by default" in the original has been rewritten
>    to "skipped" (unconditional), and this is deliberate.  When there
>    is no conditionality and the behaviour is the only available one,
>    it is *not* "by default".
>
>  Documentation/config/remote.txt   | 13 +++++++------
>  Documentation/git-maintenance.txt |  3 +++
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git c/Documentation/config/remote.txt w/Documentation/config/remot=
e.txt
> index 8efc53e836..36e771556c 100644
> --- c/Documentation/config/remote.txt
> +++ w/Documentation/config/remote.txt
> @@ -42,14 +42,15 @@ remote.<name>.mirror::
>         as if the `--mirror` option was given on the command line.
>
>  remote.<name>.skipDefaultUpdate::
> -       If true, this remote will be skipped by default when updating
> -       using linkgit:git-fetch[1] or the `update` subcommand of
> -       linkgit:git-remote[1].
> +       A deprecated synonym to `remote.<name>.skipFetchAll` (if
> +       both are set in the configuration files with different
> +       values, the value of the last occurrence will be used).
>
>  remote.<name>.skipFetchAll::
> -       If true, this remote will be skipped by default when updating
> -       using linkgit:git-fetch[1] or the `update` subcommand of
> -       linkgit:git-remote[1].
> +       If true, this remote will be skipped when updating
> +       using linkgit:git-fetch[1], the `update` subcommand of
> +       linkgit:git-remote[1], and ignored by the prefetch task
> +       of `git maitenance`.
>
>  remote.<name>.receivepack::
>         The default program to execute on the remote side when pushing.  =
See
> diff --git c/Documentation/git-maintenance.txt w/Documentation/git-mainte=
nance.txt
> index 51d0f7e94b..9d96819133 100644
> --- c/Documentation/git-maintenance.txt
> +++ w/Documentation/git-maintenance.txt
> @@ -107,6 +107,9 @@ with the prefetch task, the objects necessary to comp=
lete a later real fetch
>  would already be obtained, making the real fetch faster.  In the ideal c=
ase,
>  it will just become an update to a bunch of remote-tracking branches wit=
hout
>  any object transfer.
> ++
> +The `remote.<name>.skipFetchAll` configuration can be used to
> +exclude a particular remote from getting prefetched.
>
>  gc::
>         Clean up unnecessary files and optimize the local repository. "GC=
"

I agree =E2=80=94 there are rarely reasons to keep a different fetch behavi=
or
for prefetch vs. fetch all, and `skipFetchAll` should
do the trick for most use cases. My original goal was to restrict refs
anyway, I don't work with multiple remotes either.

I'd have perhaps expected these properties to be documented (or at
least referenced) in the documentation for `git-fetch`.
The only place `skipFetchAll` is currently documented is in this large
master list of configs that are easy to miss =E2=80=94
https://git-scm.com/docs/git-config.

If there's a consensus, I'll switch to submitting a patch for
`prefetchref` instead.

`
