Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2D23A9AD
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083011; cv=none; b=Y6Butw81pwR955qBvbkZpdQZNvcH4Xa+A0vLz8lj6/OFAFxW7aEoFXuo2Uz7l0U6qjFekpi1Tx9UWU1jHHwaNk5EvHtYlNN4ZCz7S/8V4fgeGeKPhAvL2i/w7AmRNpzGERmwxp//vD5e3sdzUXNWR70VMqR7p1B61G9w+97lJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083011; c=relaxed/simple;
	bh=ROZkAmTlv1WXOE67FGC6ia9Asz2IyTi4LyHSONteg+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQKvu5MZI46AXLo7Waclg0cGrF35LBoudVrO27cdyxOPOdEsHXCn0xV7xSwAhpJ17AYOq4xK5qO/er8SPzeEPb5uJdwurqpnAXdDpb3xrYM2c1oO8FQ8WZTEtw/v10/CcVR00lrqKDjRKqAhzOrw4cT2WcN5oCytARn63jMcTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0GjjODf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0GjjODf"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso8515344a12.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761083007; x=1761687807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1mak9a3KVVwAJzRCmL5A7CL2yXHwcbeR94rkcirbFI=;
        b=a0GjjODfvL6JEkbzF9rETQiX+GuK6LAEdpcSlfv/BZ/0Ph9eDxhFlEhu4hwKzZVy39
         CtUE3f0deDSFCO3ZP2Hnq5q4KT1gt+MvG+XZS24P4pFZ+IX70zaIGN8yZ3E4WZvP7iQo
         VgvQWNbKa9RJpKyq5tmFc8PBR8IhUiKfda62eWJ8rDcVZz7Mk+ETe5x9qWpduXnjQtgq
         dMT/Ld9HOsAJEdrnPQiNkiKjWA4xAsv+qjJzQxapbNifsfRDvRqWk2LnmyxkKVSjDACO
         bWIzg6LM428Ga8azyWZdnhL7s8DG8IiAFwCOH6cU/CjbTY0OdOrwCLeabALo8MyW21Dh
         xoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083007; x=1761687807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1mak9a3KVVwAJzRCmL5A7CL2yXHwcbeR94rkcirbFI=;
        b=BnNABx8fTWevoRB20YNNjkhdGymj7NAL44Wd1WgDvolaHPB9WHrvj05JtIQdZBtyTG
         kVJYkTU+yJyfKAcpeQBM+9lP44LhwvmIj1chnaStUjfxfXwsTamL+SE6XOnusnwfb+kF
         fzEhj5WIdJm52Yx8eQE9b1Ve6Uj+QUezBuPlP+2qh7xyzXTcLLWxnDmNk4Rhzr+fB2uw
         PsqpsM9Ke0KYHFRrrW5xy6ayjGcYGE2ms+ibK3PSCrQWMCiZhHqpCjFTbxdDUPW9guDY
         MHLuIcth1d9s7C9X7oKzJFfapeOe5eToURPwfR8teVbMCJY5ZJNZoDjYYrZQO6MzFjVZ
         3F5w==
X-Forwarded-Encrypted: i=1; AJvYcCUIJNZkaO2zJgxvZjTg6dyJ8N1L9m+APTgffIbFbKP8KpnrHhQ+rPSwK58PNmKoXo4enIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxIFLFG0wEeqVXCnEv91wpurDebL0hZWKWFC/SZkuZnujekhL
	/2b0Ixn3FDm3lDJj+g3xu9aa77ayG93jUdxpXYyOS06rNZ93FpvuSwVKp5idhdosAFm6495JxPp
	hBCvgpeOW2UeKThqSKLkB2UdCD3GQxC0MxMEx
X-Gm-Gg: ASbGnctoOJ8Nns45ufxm14ZwMWGsQpk13XXlW4gH7LfaMIHjHvUrKFpfEbRXudte0ir
	5sFAZ68x1ySAKcfYHhPzUTCrg1fHM4C1AmwB1dHOcm2rsYr772lvF4sWa2RwaWnpBsE49TXFbsN
	k2YvPixi/gG6jfRqk8Y9f0cSw0lgM91EzOf4MoWER82tI+Qdy0qCCk7dXh5Qnted/QHCCR2oIqy
	bHowVnGy6MUJ3PIAfWdqFG8eJhCPbTIScsZjYduExfKPAeWXaA0yvPBOqbkOJ8cgD3Wcr84VIUL
	+79+q0zEDJBWLHGWUSGnYmucti85Eg==
X-Google-Smtp-Source: AGHT+IGMooAarxT/ovwliupl/ERlSc3FCaVn8ptMDNJgcYh27DCcs0oYcvzWsjKyJUmX6BSw2ZHV+jOyN/xQoSJuk7U=
X-Received: by 2002:a05:6402:358a:b0:61c:9852:bb9f with SMTP id
 4fb4d7f45d1cf-63c1f630745mr17418592a12.1.1761083007442; Tue, 21 Oct 2025
 14:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
 <20251021-b4-pks-history-builtin-v5-6-78d23f578fe6@pks.im> <xmqqa51kszvc.fsf@gitster.g>
In-Reply-To: <xmqqa51kszvc.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 21 Oct 2025 17:43:16 -0400
X-Gm-Features: AS18NWAQ0Y1XLCMzboTAaQgoUdzJz0domjIN-ueDSdbkaA5pQfpasJk8QI3D6_8
Message-ID: <CALnO6CBT+5i==AtF-_xEgp9nEUEZY2G4DSAsSL9dysxr8A-WfA@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] builtin/history: implement "reword" subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > Implement a new "reword" subcommand for git-history(1). This subcommand
> > is essentially the same as if a user performed an interactive rebase
> > with a single commit changed to use the "reword" verb.
>
> Oy.  I've always wanted something like this in "rebase -i" myself.
>
> It is a bit sad that I have to learn a new command to do something
> obvious and trivial like this, but that's life ;-)
>
> Maybe "git history" becomes powerful enough and can replace my
> every-day use of "rebase -i".
>
> > @@ -9,6 +9,7 @@ SYNOPSIS
> >  --------
> >  [synopsis]
> >  git history [<options>]
> > +git history reword [<options>] <commit>
>
> It is curious that a command-less form is still listed here,
> especially since this command "requires" a subcommand.  I would have
> expected that there will be a single line here after implementing a
> single subcommand.
>
> > +`reword <commit> [--message=3D<message>]`::
>
> That should be `reword [--message=3D<message>] <commit>` no?
>
> > +     Rewrite the commit message of the specified commit. All the other
> > +     details of this commit remain unchanged. If no commit message is
> > +     provided, then this command will spawn an editor with the current
> > +     message of that commit.
>
> As long as it takes more than one -m and concatenates them just like
> "git commit -m <message1> -m <message2>" does, I would not complain
> too much that a command line option to give message encourages sloppy
> log messages.
>
> > +             if (!onto) {
> > +                     onto =3D commit;
> > +                     result.clean =3D 1;
> > +                     result.tree =3D repo_get_commit_tree(repo, commit=
);
> > +             } else {
> > +                     onto =3D replay_pick_regular_commit(repo, commit,=
 replayed_commits,
> > +                                                       onto, &merge_op=
ts, &result);
> > +                     if (!onto)
> > +                             break;
> > +             }
>
> Hmph, I would have expected that the overall flow of this command
> would be
>
>  * find the commits above and including the <commit> in question,
>    making sure there is no merge.

I don't remember offhand if the implementation supports merges, so
this might not answer the question=E2=80=A6

> without having to touch any "pick" machinery.  Why do we need to go
> down to the merge machinery for a mere "reword" operation?

=E2=80=A6but it would be nice to not overly restrict the commits that can b=
e
reworded (IIRC, jj permits the equivalent).

--=20
D. Ben Knoble
