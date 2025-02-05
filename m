Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B517F7
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773386; cv=none; b=lxsKnzdEPz8cYwbhPNu9S3x+ZWdSDa/qMZ1TeyAs+oz1H21PyGoPgN+uhP5olI6diJqiMbPLBmmShSuNdKcskB8xs36X3tgzHLN4LROFi5sjjK/CGG6A1XH7zv4zB9m6JccbezIt1pRqaWlOiOOsTqvNvAQS/fxWbFQKqodO/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773386; c=relaxed/simple;
	bh=rdRUGJvpdY4ocpDRIha36twPGgoiOgTTy+qKYYMqD7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5UuM+b6slUNzptQg4YZxcNc/KjXzBrvBb+mVdyN2GRyE3zILSgBky3V7gOSfxdeiQMIiY6IpqJt6prKaFl3G93KT61PvINlQekqbwvY73Ly3tsVfus0yeY6yXsSx5vrnAQ9HWzFKSu2lsjLjTAZITYwHuZDK4/1xsZU/YgXWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQPl0yCl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQPl0yCl"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso7557836f8f.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 08:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738773382; x=1739378182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7bISNqHTV/qJaUfOAPzBntcVeG25wvz9Styl1ITdHI=;
        b=JQPl0yClWFDS1LPJ9zlYSK7CJ0l9tuUrZ3RRIVO30dDBZcBKwwYCDnvtLaCmN4sg3m
         T2okEVjVmg02Kka/92k3Nvkb2hlp4mqLzk0hIUKJ0qwoebwoKSVFEqY2usn0oVmDVnLv
         AiO6feO1XZmq6QsXLTvNGYKfNpDgzb76KWxFuhCE7HGZI0NjglguaqpKxtV41r25efKJ
         mFht1fJ28rBoEewIdcag/iD4V/8p6kXumCAhaGhJ90+1HhLn/gWumg8upiob/baIE/G0
         exVjEV1hEBh+PgGO29DPYJasX14FlMFd52yvVfxd6xAmhyRPDbakcvUrTrU04ObxVWEI
         4g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738773382; x=1739378182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7bISNqHTV/qJaUfOAPzBntcVeG25wvz9Styl1ITdHI=;
        b=STq7kFxzUVZ04xXIqqNJnm+0ev+njL3hlvWVxG0pvJ49yNrhj6Qnd09jd84VJzLwJ5
         bQ0fSKSxVq68UYQxZqWtBLtjw69FXIzsOZf3O02XMpSeYFtgNwyLcZliB7jCUJ1WX+c2
         oHjS83ihvunlI14u84hP8185NVmtTaMR4lDPbS5zhXxHAw/3GAoY9zCLI+djH3XEKArY
         t64F2/vKnJUCXlvPQDpwae7BKqsbBquMVajTHQDKqc3EOwtfHAZ8O+wopwNv+1lHdXvj
         A4u2+p/aR4dpOx/BU6iaMit0rHYnEdDdEi3LjFEiUIV8rNziAP1ba2Je5L+2dP474cHm
         fQ1A==
X-Gm-Message-State: AOJu0Yx+HmZX0ezIBmBryST7xG+9wUaowZFzt+4AYd7HuoyTUckIsgJL
	5mlMJq8N5JGSwvZnd4NDZQSyNAe5+2hHk2Zse7ZwChU6ixnCc4fafPXd4NISuv8Q76OFDzxmfT0
	PCXKdKalUE33QwtzyxYGW+ivjqFI=
X-Gm-Gg: ASbGncvu0877rKJcSN/JQxi3raktbanAiWWHAhKb08EM4RpVTmBVbk+nLX1yieIz6tm
	PjX3SEhdHZrtQk5k/gWLSqwlgGkibIcah2ICkODiIqlLRP0DXP8u+5D7Ez8lSMGx3HCrdEw061y
	LZwTlRf73POpgh+7Ozm0Pip1AkzQY=
X-Google-Smtp-Source: AGHT+IGTRbmv6mXCpjmHJO3gEMbn8yloumE3oB3j2/nBJ2Oa43QMSl7qx9l+tZv7XfbRdqowUfcGYjipujWGizTYQUQ=
X-Received: by 2002:a05:6000:1889:b0:385:f909:eb2c with SMTP id
 ffacd0b85a97d-38db49005f5mr3283829f8f.38.1738773382126; Wed, 05 Feb 2025
 08:36:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205030642.95252-1-ben.knoble+github@gmail.com> <xmqqbjvgr11y.fsf@gitster.g>
In-Reply-To: <xmqqbjvgr11y.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 5 Feb 2025 11:36:10 -0500
X-Gm-Features: AWEUYZl3fKWiXyhlrbCpit7UzOYg2OjNyBaZuCNkZh9N9UB-LY-3FtX51HTOA-Q
Message-ID: <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Felipe Contreras <felipe.contreras@gmail.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > When running "git pull" with the following configuration options, we
> > fail to merge divergent branches:
> >
> > - pull.ff=3Donly
> > - pull.rebase (unset)
> > - branch.<current_branch>.rebase=3Dtrue
> >
> > Yet it seems that the user intended to make rebase the default for the
> > current branch while using --ff-only for non-rebase pulls. Since this
> > case appears uncovered by existing tests, changing the behavior here
> > might be safe: it makes what was an error into a successful rebase.
>
> Hmph, to me it looks more like with pull.ff, the user, no matter
> what other variables say and which mode between merge and rebase a
> pull consolidates the histories, wanted to make sure they will never
> accept anything other than fast-forwarding of the history, because
> the end-user expects that they will pull only after they push out
> everything, i.e., the expectation is that the other side is a strict
> fast-forward or the user wants to examine the situation before
> making further damage to the local history.

That's certainly one way to understand --ff-only, but I can't find it
supported by existing docs (though it's what current code says,
excepting lack of test for interaction with branch.name.merge). For
example, `git help pull`:

        --ff-only
           Only update to the new history if there is no divergent local
           history. This is the default when no method for reconciling dive=
rgent
           histories is provided (via the --rebase=3D* flags).

and `git help config`:

       pull.ff
           By default, Git does not create an extra merge commit when mergi=
ng a
           commit that is a descendant of the current commit. Instead, the =
tip
           of the current branch is fast-forwarded. When set to false, this
           variable tells Git to create an extra merge commit in such a cas=
e
           (equivalent to giving the --no-ff option from the command line).=
 When
           set to only, only such fast-forward merges are allowed (equivale=
nt to
           giving the --ff-only option from the command line). This setting
           overrides merge.ff when pulling.

[=E2=80=A6]

       branch.autoSetupRebase
           When a new branch is created with git branch, git switch or git
           checkout that tracks another branch, this variable tells Git to =
set
           up pull to rebase instead of merge (see "branch.<name>.rebase").=
 When
           never, rebase is never automatically set to true. When local, re=
base
           is set to true for tracked branches of other local branches. Whe=
n
           remote, rebase is set to true for tracked branches of remote-tra=
cking
           branches. When always, rebase will be set to true for all tracki=
ng
           branches. See "branch.autoSetupMerge" for details on how to set =
up a
           branch to track another branch. This option defaults to never.

[=E2=80=A6]

       branch.<name>.rebase
           When true, rebase the branch <name> on top of the fetched branch=
,
           instead of merging the default branch from the default remote wh=
en
           "git pull" is run. See "pull.rebase" for doing this in a non
           branch-specific manner.

           [snip]

           NOTE: this is a possibly dangerous operation; do not use it unle=
ss
           you understand the implications (see git-rebase(1) for details).

So I would tend to read branch.name.rebase as "you opted in to this,
you know what you're doing" and let it override --ff-only.

Granted, it's not clear just from reading the various git-config files
which sections and variables override which, so I'm perhaps
overly-reliant on the documentation to understand when those overrides
happen (see "notes" in original post).

>
> With that understanding, I am not sure "even though pull.ff tells
> us to stop unless the other side is a descendant of our history, if
> we are rebasing, it is OK if they have something we have never seen"
> is a good thing to do.
>
> So, I dunno.

Agreed that if pull.ff=3Donly is supposed to override all other options
(except those on the command-line), this might be wrong. And `git pull
--rebase` works in the scenario I described.

I think that `pull.ff=3Donly` + `branch.name.rebase=3Dtrue` is a useful
combination to say "unless I'm asking to rebase [via --rebase or
branch settings], only permit fast-forward pulls." For example, my
main or master branch is typically fast-forward only, while I want my
topic branches to be rebased; preferably, all of those things happen
for just "git pull."

But maybe the intended way to accomplish what I want is pull.ff=3Dtrue
(the default?), which doesn't prevent accidental merges in the cases I
want it to without setting branch.name.mergeOptions for each branch I
want to protect from accidental pull-merges. (I'm in the habit of
using fetch + merge as needed and mostly use pull to shortcut things
when I'm confident, and obviously I can undo the accidental merge=E2=80=A6 =
but
not having it in the first place is nice, too.)

LMK if something in my position is not clear=E2=80=94my overreliance on
parentheticals can be confusing.
