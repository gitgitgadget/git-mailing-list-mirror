Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0E154BE2
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116629; cv=none; b=nP+ykK0ytmxqxC+TJMiplQo/ElXxv+dE3RQiGStc9FmEr+OfolPzZdxqjYHiJcyZ5/9E74gYxk62pH9jc7RgToY+4d7AVZbVKaumA7EOTRynnX5VYeELoPN/BZsKK++otY+vJdPZH/wjF6SLEEa60p69xas9XVoPAxYRAW0ndTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116629; c=relaxed/simple;
	bh=tHSqsDnDIR7eSxgNooOpcEu3lECPc+/6lYi3cAqXKp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jI2luM3222AEhhqJ0PRzw930lwek3+eKQFI4oTx4OSZILaMk2HE3G2HaInDBlyBiwuhwcS4ncE7/5DTbrvX2ICnhZdy90zTHxzO0o03USlEP8h0/kV9NgaJoJ51S87QwGMhgdzHDVYDyf0m1ARq10LzUGSu37PjQalpBAJrPOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK+ffUN5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK+ffUN5"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so30297716d6.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760116627; x=1760721427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CmIRRi3072iJT9L4FpHzhG3MQuRl8BC1hz0L5M5CoA=;
        b=kK+ffUN57jBL+c2siotWrWBcYLHvWhJbwHtH8rWjG/c4j095SpYB9PsLGXgYrNtTzD
         uuSTjtxjmo6N8XfBF17adL1HOetk88Un2L3APtW4YJYYAWvCeoMIdLCdVv2I21/9ikz0
         3XWgVbo7XpxzEE7JLRl4aaplk0PakF7G+LsqzAfAM/6eUMI3D8syz9ro2YyE4e4qPo2e
         4qAsrFBzrTokt7x93E5F4wr2Xb/a0UCwvMHmdFiMQ2uPt1IQ8g4wR3v8IZN5sEDAPOIw
         5DT0RUdBguyZO9RvStHf1Vr/oZIN2LSAch4ZIbTMY9QEKtyFnZWJ8x9U7gvDbplH8qrI
         8c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760116627; x=1760721427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CmIRRi3072iJT9L4FpHzhG3MQuRl8BC1hz0L5M5CoA=;
        b=IpXp+ilGvg5kMCLgcRwAElrR3qwqL+Rcl4V0Slq22J9TNFkP4+FjeMykYIR1nBWF6i
         meY3H0SkNpGqCON3Nhevaa2E1PiCzjvH5rxkU8a9Pj4oEqGXvyKSrzugfNqQZFZaGC/A
         OEVlJopMk5k7tz6Vanf4EjavMNCMuK2IPId5JCfr8CLevH7I2jFkX6xJTvpnYNDLVR9c
         AXEIzL2op/2E45trZ/EWL/PlLCwGViqb77zuLAqlKBqBcainFJC2mCmspzqabRQuluaX
         IO3LTNDPVe/G+c/RLhEBeuyf/J98GquhEEhFmskAOUUEe0JA5aMO+lx8RUMhoZL6VN2u
         uZvA==
X-Forwarded-Encrypted: i=1; AJvYcCUf4SZNnVKNgG8c8i6buPMGFvsqexEa9W9HIjNpu9fg3xXZWgKrTtWH6qt/VcUK+lia9X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlO1aYARBxijN2cIGVKrTOO44OcEltH5liSXQLLZhwnWsDTPIi
	nefsXLk3wqnOk8nB7V75lz0IajyzeyCg2NF/rjFTt+UGfHj4RBA9fEK+dvGLLd8C3HYYNzgthQB
	JMjFxYEzFjzsTBB0NDZikjE3sWO6OawY=
X-Gm-Gg: ASbGncvbLbhEdUA7itm+zummwX5QdY/zFT0Psg5zLJ9zTVo/ej1mhAAYBZi6Wr5D1u7
	xib1dxd0aoMqEeugQ2fq/Y2dNnnlzSu/iXoNZ2TmgEGMEPVtHgeOi8cVSeF/n+IsAbgGgTEakOS
	huUk6JtCeQ3QgiXHWy/r/BX6HiwXF2MrAsA9McfXlNXn2ipqOISFaITBPxeEyXtOqMx2ls+Sxje
	aSzRJ8iVhk/7u4Pp4HP4QSlVaitQnlPgsFNgzECM1DEvOa0a9PgBzS3qJBjn2nGhqX8LkiP
X-Google-Smtp-Source: AGHT+IEwxu6O//a1/k+jT9c72lLBn4mdj8wShMOtLU9tkdt/0/biwnq8qu3hGu4OA1rgMEswJW+hCtPIIxbHb5sVrdk=
X-Received: by 2002:a05:6214:130f:b0:790:40cb:6df0 with SMTP id
 6a1803df08f44-87b4179ee54mr178056966d6.34.1760116626647; Fri, 10 Oct 2025
 10:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009234957.1789543-1-okhuomonajayi54@gmail.com>
 <aOiZ_v3bO35oVWf-@pks.im> <xmqq1pnabw1p.fsf@gitster.g>
In-Reply-To: <xmqq1pnabw1p.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Fri, 10 Oct 2025 18:16:55 +0100
X-Gm-Features: AS18NWBdM0NuIafrZkeEHny0SyBega9f2tj9tXpy-hR1IZx-T2wz-PwFhkByT_I
Message-ID: <CAFpMFfCfLZgUDnZBWg7kmGN84Y7gTxOm6SYe7F2__t=hHhBZow@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy] patch-ids: fix NEEDSWORK timezone parsing in fast-import.c
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the detailed explanation, Junio, and also thanks Patrick
and Kristoffer for the earlier feedback.
That makes sense
 I=E2=80=99ll review whether the additional timezone checks are actually
necessary and if they improve correctness in real cases. I=E2=80=99ll also
update the commit message to better describe the motivation, and fix
the formatting issues mentioned.
Once I=E2=80=99ve clarified the behavior and possibly added a test case, I=
=E2=80=99ll
send a v2 patch.
Thanks again for the guidance!

On Fri, Oct 10, 2025 at 4:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Fri, Oct 10, 2025 at 12:49:57AM +0100, Okhuomon Ajayi wrote:
> >> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> >> ---
> >
> > For a change like this it is important to explain what the problem is,
> > why it is a problem and how your change improves the code for the
> > better. All of this needs to be patr of the commit message so that the
> > reader can understand what you're actually doing.
> >
> > Also, if this fixes a real issue, is it possible to demonstrate the
> > issue and the fix with a test?
> >
> >> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> >> index 606c6aea82..695e1a0ae1 100644
> >> --- a/builtin/fast-import.c
> >> +++ b/builtin/fast-import.c
> >> @@ -1959,14 +1959,15 @@ static int validate_raw_date(const char *src, =
struct strbuf *result, int strict)
> >>              return -1;
> >>
> >>      num =3D strtoul(src + 1, &endp, 10);
> >> -    /*
> >> -     * NEEDSWORK: check for brokenness other than num > 1400, such as
> >> -     *            (num % 100) >=3D 60, or ((num % 100) % 15) !=3D 0 ?
> >> -     */
> >> -    if (errno || endp =3D=3D src + 1 || *endp || /* did not parse */
> >> -        (strict && (1400 < num))             /* parsed a broken timez=
one */
> >> -       )
> >> +
> >> +
> >> +        unsigned int hours =3D num / 100;
> >> +        unsigned int minutes =3D num % 100;
> >> +
> >> +    if (errno || endp =3D=3D src + 1 || *endp ||
> >> +        (strict && (num > 1400 || minutes >=3D60 || minutes % 15 !=3D=
 0))){
> >>              return -1;
> >> +    }
> >
> > Despite the formatting issues I also think that this here is becoming
> > hard to read. It may make sense to split this up into multiple
> > conditions.
> >
> > Thanks!
> >
> > Patrick
>
> Thanks for a good suggestion.
>
> There is another thing we should be aware of about these NEEDSWORK
> comments.  Often, the task a NEEDSWORK comment suggests includes and
> starts from assessing if the task indeed is worth doing.  We should
> read a NEEDSWORK comment like above one as its author mumbling to
> themselves: this feels lacking, and we may want to do more here,
> like X and Y and Z.  Maybe not.
>
> Do we need to check even more precisely here?  What's the point of
> doing so, and doing so here at this point in the control flow?  Are
> there better approaches than incrementally adding more of similar
> kinds of checks?
>
> Without being able to answer these questions oneself, one shouldn't
> be blindly following what a NEEDSWORK comment like this floats as
> "ideas to do more".
>
> The current code may turn out to be good enough.  Removing the
> NEEDSWORK comment with a solid answer to the question it poses in
> the proposed log message would be a commit worth making in such a
> case.
>
> Thanks.
