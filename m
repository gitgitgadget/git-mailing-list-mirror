Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027329405
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759520934; cv=none; b=bQ7mWZ0MFhz3dMxizDwoo4Z5Gnvgb6c+c86R4FtfBjMK/I0FnuPSPotqlQRlvrJ7aMwtvaK/Oo4vzv0zwg6ecgN22KLAsl7002MSn9wbsYJkfrgW/nnwN0XJ36lrtYjTWTtEt0DhbyB3Z/Mbkk85xFjiZwo0mml5KsuO/bgiHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759520934; c=relaxed/simple;
	bh=laKhM8K01eoiE0g98ai+Giw6u/IyHgMjUYMElWzFCcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plXha4x/oqkpHQ+t4iVH1W4DkJOPjLQVUR+pzay2cPeydTvSdInkkCemQew91dnU/an5Vt4j86MReOm6DHm957UD1Zh+i6BHkm/QQfV04T2fcV2sQrQJjKZ9BWWHO37DpuVVT0kjy5P60PffhSo6KznM4ktt3uuitO7atEPPVcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUFP0ob/; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUFP0ob/"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-42e726431bdso9297895ab.1
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759520932; x=1760125732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF5YbIaktbcaSRmTiSgy+tvYy6nzqi2ADvzcZyWm+io=;
        b=KUFP0ob/5wqSinwqRRQc7tcH+gkiEWoxPhD8Jt2TeUCK3xdEl9DH7ScNuWIYaUXu38
         98DxWDh3Wveu2yfxSExQwGagN2rLHR7ofcWDlotJeKvCs8b5hEWIG1+iIKrq9FIkAnnz
         XVPr1kx8PU1KfIt1O513khbUmQWpyLJrsFgZ0Eoz4bfNXRl8FhbbRM9nPOuWv87VLan4
         YnsNujmSLgkYEacrtYK23GiViUHhmD4/pqiC4RKPGwLniCY4U9IeHgjWaUjhoOhYpQVu
         mZCJnWfXCk7j4/9yQnwnGwNPTEoJHzjO5pae+ANGQCzZb8z2cEKhV94amAiU1Bab7xgG
         aMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759520932; x=1760125732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF5YbIaktbcaSRmTiSgy+tvYy6nzqi2ADvzcZyWm+io=;
        b=rHQlfuF9rVARY3L4DsZkb/09C6vcWq12oLQPqAikkwDPCSIAw9GesLOBsK3wjFCM/1
         dHgA+jwMmPYCWjpsO8q8yLCgyNAioKZZfap+vxg+8AW/qqX+6B4Sx1P7ESxVLyVH//2T
         MIGUvPEQNF9LQkf39RZ41DqVvTEl5B+21vs1c4xXTLu9vto9bCSfxWyM9mV7JoEKAawo
         pSEHcClALwFYSFXbd7Ym4GwKZaJs/F2l9wHNU9HtAyK9nCke58XoRHQAJ6V/BpPrHbaG
         +PxUuqdIB1Ceb4rkqijpKKW18Xj99nCFEr/oLpZVpXXe+5RrhxoFFpwuqActmlBlBTfg
         i/lg==
X-Gm-Message-State: AOJu0YytCBFcb7Nd94uxi3xx5xP797WK3IWkFcTbnrYTQpER0ZY8K228
	Wu8k/kGmXDpZ5bM4qS3H6MoOpYWMUl5/TvgfK4jpBF7ixsCM7VJddIvVOzX5UTpv6jXHQEZq9R4
	cVSgZl3AcQ+OkIPfscI7LrcpNczlPb5Y=
X-Gm-Gg: ASbGncsrq68+Ah4p2dLhozioJuRVgU2+gNnuC4tC+vy7TudDpwqS1DpTiWTy/vKqb5e
	vjGtS6VPkF/n4kLsf7LVUXnunm0bLsL6m7B4V01pLU9ye+1RcfzC9Ve/8iZCGNX/whmMAdxduGk
	vJuRCT4JM+DuiGLiWYAsFsLiCLJPLUSLaUW2wU0wUPF6XcDvMZ6Oyt/LzzvuTOsLwAVDGpH3iLe
	/sfqrroXk4xqGfuwGyth0aGSCG/OzdQOcgISKOsPhwTFSNbz6bxaEaTpoEa9Po=
X-Google-Smtp-Source: AGHT+IGKeuPt/29hO4yMaN1c2G2nws4FScdBm2/ee0uTv4N4XNDvkQQ8pFv1DCsYue/3uewAzxfj/tRoiKsjQdjhCi8=
X-Received: by 2002:a05:6e02:3e8b:b0:405:d8c4:ab8f with SMTP id
 e9e14a558f8ab-42d8b234b7emr89939245ab.14.1759520932062; Fri, 03 Oct 2025
 12:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com> <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
In-Reply-To: <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 3 Oct 2025 12:48:39 -0700
X-Gm-Features: AS18NWDfUG2ChytoUSdPBIaYOV7AOGBx76PWAG_4LAQtK3DI2lQ4kRM2zSGRFq8
Message-ID: <CABPp-BE9TV58duojhF_+R6bKDF6-L0md6j+1VeRFd8CJWF++LQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	ps@pks.im, code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 4:27=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> >> For users needing the traditional pipeline workflow, --output-commands
> >> preserves the original behavior:
> >>
> >>      git replay --output-commands --onto main topic1..topic2 | git upd=
ate-ref --stdin
> > This is good.  Did you also add a config option so that someone can
> > just set that option once and use the old behavior?  (as per the
> > suggestion at https://lore.kernel.org/git/xmqq5xdrvand.fsf@gitster.g/
> > ?)
>
>
> I didn't, but I should have. I will add a config option for v3.
>
> For naming, I am thinking either:
>    - replay.updateRefs (boolean: true =3D update, false =3D output-comman=
ds)
>    - replay.defaultOutput (string: "update" | "commands")
>
> The boolean feels simpler, but the string might be more extensible if we
> add other output modes later. Which pattern feels more consistent with
> existing Git config conventions? Looking at rebase.* they're mostly
> boolean toggles, but am I missing a better example to follow?

replay.updateRefs sounds better to me.  defaultOutput with "update"
doesn't make sense to me.

> You are right - I don't have a concrete use case. I was trying to
> anticipate potential needs but ended up adding unjustified complexity.
>
> I will remove --allow-partial entirely from v3. This simplifies to exactl=
y
> two modes with clear purposes:
>    1. Default: atomic ref updates (all-or-nothing)
>    2. --output-commands: traditional pipeline for special cases
>
> Much cleaner design.

Note that once you add a config option, you'll also need an additional
command line flag (or make it possible to invert an existing one), so
that users can override the config and get the default behavior.
Maybe --[no-]update-refs would make sense after all, where
--update-refs is the default and --no-update-refs is your current
--output-commands?

(I know you all talked elsewhere in this thread about "avoiding a name
collision" with rebase, but I don't quite see it as a collision.  When
Stolee suggested the flag for rebase, I pointed out it's roughly what
I'm doing in replay, so it doesn't feel like a conflict to me.  I'm
also open to an alternative flag name if it makes sense, but we
probably want whatever the command line flag is to be similar to the
config name and "defaultOutput"/--default-output don't make sense as a
name to me.)

> >> @@ -330,9 +361,12 @@ int cmd_replay(int argc,
> >>                  usage_with_options(replay_usage, replay_options);
> >>          }
> >>
> >> -       if (advance_name_opt && contained)
> >> -               die(_("options '%s' and '%s' cannot be used together")=
,
> >> -                   "--advance", "--contained");
> >> +       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
> >> +                                 contained, "--contained");
> > Broken indentation.  Also, should this have been done as a preparatory
> > cleanup patch?
>
>
> Good catches. I will fix the indentation.
>
> On making it a preparatory patch: should I split it out as a separate
> cleanup commit, or is it minor enough to fold into the main change? I am
> leaning toward folding it in since it's directly related to the option
> handling changes

Given that it was directly adjacent to the other
die_for_incompatible_opt2() call, if that were still the case, I could
see making it part of the same commit.  However, dropping the
--allow-partial flag means you don't need to add that other call
anymore, so it makes this remaining die_for_incompataible_opt2() call
an entirely orthogonal change to the rest of your patch.  As such, I
think it belongs in a separate patch; it could either be a preparatory
patch or a follow-up.

> >> @@ -407,6 +452,8 @@ int cmd_replay(int argc,
> >>                  khint_t pos;
> >>                  int hr;
> >>
> >> +               commits_processed =3D 1;
> >> +
> >>                  if (!commit->parents)
> >>                          die(_("replaying down to root commit is not s=
upported yet!"));
> >>                  if (commit->parents->next)
> >> @@ -457,9 +535,17 @@ int cmd_replay(int argc,
> >>                  strset_clear(update_refs);
> >>                  free(update_refs);
> >>          }
> >> -       ret =3D result.clean;
> >> +
> >> +       /* Handle empty ranges: if no commits were processed, treat as=
 success */
> >> +       if (!commits_processed)
> >> +               ret =3D 1; /* Success - no commits to replay is not an=
 error */
> >> +       else
> >> +               ret =3D result.clean;
> > The change to treat empty ranges as success is an orthogonal change
> > that I think at a minimum belongs in a separate patch.  Out of
> > curiosity, how did you discover the exit status with an empty commit
> > range?  Why does someone specify such a range, and what form or forms
> > might it come in?  And is merely returning a successful result enough,
> > or is there more that needs to be done for correctness?
>
>
> I was thinking about automated scripts that compute ranges dynamically -
> they might generate A..B where it turns out A=3D=3DB, and treating that a=
s
> "no work needed, success" seemed reasonable for scripting.
>
> But you raise a good point: A..A seems like obvious user error (why would
> anyone do that intentionally?), and B..A where B contains A is likely a
> mistake that maybe should error rather than silently succeed.
>
> I am inclined to drop it entirely from this series. If there's real deman=
d
> for specific empty-range handling, we can add it later with proper
> discussion of the actual use cases. Does that sound reasonable?

Yep, dropping it makes sense to me.  Alternatively, documenting what
happens in the case of empty ranges, as Christian suggests, also makes
sense to me though I might suggest that it be done in an entirely
separate series rather than just a separate patch of this series.
