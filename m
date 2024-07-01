Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F528F1
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846677; cv=none; b=sAQ04tXnDpjT6xo9XpbvA/GzvAN3zR886uS6WvORx6Ra3JjyIFhPAezwIGFNXidi5LZ3G3GCgythXlzMQ2MuqzydrdOfQSwOwsD04SFg1Rk1pLlOsyhY+6Kbo+ap9NLAlC4YxSQ25IaBPIDzXarl6AscMN9XgYvxoeQtahW/4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846677; c=relaxed/simple;
	bh=F+ewZ+jOVEWnryC2OdMaB+dAKofhIQ5n+f+AGOjGyPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DE4ncWIh9V0sKflIjKDJ/CHPj/TKWg4MUx3xcyanVEINWDI/tnbbupfNpZj2Zgro49hX62kQ/ZhbdSexXiDCzHogrlkkaf0TnKTCBT4Nxp2mPE+qJaWYg3PluSBUwmMFrtrO+a6lJzRYtkowxY5QlDl6TIeppspvtXFgmTbgLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKcXD68S; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKcXD68S"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-376208fbe7bso14239835ab.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719846675; x=1720451475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMozPIT9XHJCN1yrgt1Q1UHawFLRfLFy5k+Xv93HNSU=;
        b=XKcXD68SEVHk4aaGeVb95OVFTn5TURdJphTjc2a7qZt48RL89/n9qGlwxQqvPnZpE/
         NfYUXYsmtmXmWApYVYP5sxBsrNGrdyMENYrndloFHkSjbH/zxawlS5Y2ut/c9VXq6+bc
         yZtu3ThpCggFjJn3mi5o1LjDwuc9WBP9PNvod50FaN1N5DT3iAWHcZpgDcmPpQ3cGLKC
         N8kHNYWShCDODA4ctljtq1l+6WbFk9Vzb4Q/w8Zjs4fGNgtg3G+Xzd8Vqkm7Yvw/Sh9G
         ImbfKJHPHlwcGkjrcy6fX6da8vl8QRT52oJMZbF3NLhq+w9BNpz+PFapbHOoDQs5zJJG
         uHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846675; x=1720451475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMozPIT9XHJCN1yrgt1Q1UHawFLRfLFy5k+Xv93HNSU=;
        b=jkaj1GTxai0fI9m1IO3fJ6xdC8JRfbTYSEQG98RQZx6iVOMp81tyrC+GEmv6khbOlN
         kdLTTgWSCcJ7DQiLlqOyPcTluQMmtTqk2vqchMHbR1+bENN5gKcF2Ptz1UXYZDHsozKL
         Z9uD1/dcp5CcF7kd5qMI16fnVIFEfGUN36IkYU+VooRoOcYsmNH/yB7TjjEZI1lS7vDk
         Ig2/Gd4Y83dpHyCb+m689WI0ZBU2HJYfW7+py9N1JfFMyGAyhdsbaRbVjosuA/9dGp+6
         hc4dRlicVZKnHGzbExOlOCGaxwhcnNTy33r6pT8+sWEhgssZ0d7vc+SYM9z3dOdh7A3R
         9X9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOWfZ0zsuYKKJO9IOYQE/kDQKPUWhCQ8rXlSiSUVtIQAnSh5BrQLuObp0EJwMOiBIk7KlYb1mxsR72Bx5et+oeOcNu
X-Gm-Message-State: AOJu0YxaTy3MUP4178esFFjmFmObV1BwzRW+Fbbj7KgZeYiIhlqDXYJc
	ftnvW32oAK5o9kIn4kVP8Eh1HRPdfxlFBsQ6Aq/UAUKMrw+kc36zjYYXxL9Mt3eOE0Oxp/jWwlX
	bsE+Y6sOJb3CYad1buIaRgvtXsBQ=
X-Google-Smtp-Source: AGHT+IEWUYfHcIKJCszK+8WAjav3VrfvOlTYt52lfYcJoWdgw8Js2XxhzSpzRjVPa3/OkBR6Ao9BPgDMzC5GAg/ejp8=
X-Received: by 2002:a05:6602:178b:b0:7eb:776f:d963 with SMTP id
 ca18e2360f4ac-7f62ee1db5cmr726190139f.8.1719846674576; Mon, 01 Jul 2024
 08:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
 <CANiSa6hVbrCpPtBCL_W8+43uWGL0LFJkFhSJYGtfFgxX75zE8w@mail.gmail.com> <CANiSa6g9L8PM8wLhrH_3TYFBh7FwgGXXAk9qVpFkSM3zdcKqKw@mail.gmail.com>
In-Reply-To: <CANiSa6g9L8PM8wLhrH_3TYFBh7FwgGXXAk9qVpFkSM3zdcKqKw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 1 Jul 2024 08:11:03 -0700
Message-ID: <CABPp-BG2p=0US9t-3DzPn8oCbPUXAg6HPciona8x8NNVyyowbw@mail.gmail.com>
Subject: Re: Determining if a merge was produced automatically
To: Martin von Zweigbergk <martinvonz@gmail.com>
Cc: Pavel Rappo <pavel.rappo@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 30, 2024 at 5:45=E2=80=AFPM Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>
> Forwarding to the list without HTML so others can correct me if I was wro=
ng.
>
> On Sun, Jun 30, 2024 at 3:32=E2=80=AFPM Martin von Zweigbergk
> <martinvonz@gmail.com> wrote:
> >
> >
> >
> > On Sun, Jun 30, 2024, 11:06 Pavel Rappo <pavel.rappo@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> I'm looking for a robust way to determine if a given merge commit
> >> could've been produced automatically by `git merge`, without any
> >> manual intervention or tampering, such as:
> >>
> >>   - resolving conflicts,
> >>   - stopping (`--no-commit`) and modifying,
> >>   - amending the commit.
> >>
> >> My initial idea was to re-enact the merge. If the merge failed, I
> >> would conclude that the original merge couldn't have been produced
> >> automatically. If the merge succeeded, I would compare it with the
> >> original merge. Any differences would indicate that the original merge
> >> couldn't have been produced automatically. Otherwise, I would conclude
> >> that it could've been. This approach is simple, but involves multiple
> >> steps and requires clean-up.

Further, your strategy has some blind spots.  What if the original
person creating the merge used special flags, such as changing the
rename threshold, ignoring space changes, or a different underlying
diff algorithm?  It may be that the merge was clean for the original
merger, but if you don't use the same options it doesn't look clean to
you -- or vice versa.  (In short, this method has both false positives
and false negatives.)

(The odds that someone used specialized options and then had the merge
succeed, when it wouldn't have otherwise, is pretty low.  So your
strategy is probably good enough, but it's good to be aware of other
possibilities.)

> >> My second idea was to use `git show --diff-merges=3Ddense-combined`,
> >> which only prints hunks that come from neither parent. If nothing is
> >> printed, I would conclude that the merge could've been produced
> >> automatically. This approach is simple, single-step, but seems to have
> >> an issue. In my experiments, I found that if some hunks from different
> >> parents were located closely enough, output was produced. So, checking
> >> if nothing is output could lead to false negatives: a merge that
> >> could've been produced automatically might look like it was tampered
> >> with.
> >>
> >> My third idea was to use a recently added feature, `git show
> >> --remerge-diff`, which seemingly embodies my first idea and is immune
> >> to the issue of the second. It is also single-step and requires no
> >> clean-up:
> >>
> >> > Remerge two-parent merge commits to create a temporary tree object=
=E2=80=94potentially containing files with conflict markers and such. A dif=
f is then shown between that temporary tree and the actual merge commit.

Yes, this is exactly your strategy, except that instead of checking
whether it "completes" you are checking whether the output is empty,
and it avoids messing up the working tree and index and thus also
avoids the need for clean-up.

> >> However, this bit means that I shouldn't entirely trust its output:
> >>
> >> > The output emitted when this option is used is subject to change, an=
d so is its interaction with other options (unless explicitly documented).

--remerge-diff output uses diff headers a bit inventively.  And, being
a somewhat new option, I didn't want a repeat of issues like we had
with --cc (where the output format is documented in detail and was for
a few years before we realized that showing diff headers for exactly
two files when there are at least three files is kinda dumb when
renames or mode changes are involved).  So, we needed the flexibility
to change the output in the future.

However, this wording was not intended to detract from the main point
that "empty output means clean merge and non-empty output means
conflicted merge" (it never even occurred to me that someone might
read that part of the documentation and assume that it presents a
problem for checking-if-diff-is-empty).  I use it for the same
purpose, and that's absolutely a guarantee we want to provide.  If you
want to guarantee output format beyond that, though, then I object.

Anyway, in summary...

> > There's basically only one way to display an empty diff, so I suspect t=
hat checking that the diff is empty is still going to be enough for your pu=
rposes.
> >
> > Note that you can specify e.g. the rename detection threshold to use wh=
ile merging, and the person doing the merge might have used a different thr=
eshold than you're using when you're trying to check if they added other ch=
anges. There are also different merge strategies and diff algorithms to cho=
ose. That means that you might get false positives and false negatives. May=
be that's still good enough for you.

Yes, Martin has it exactly right.  And it has possible false positives
and false negatives precisely because your original strategy did too.
