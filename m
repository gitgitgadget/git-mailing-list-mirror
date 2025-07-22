Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF725A2C7
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197586; cv=none; b=kZE+D8S4K/jfON6jSwlTf3paWo51aZB0GmYgl5onQQLhRF7/T9C6d+wOK4zqZ5JpSdvrtWQ2nEK87qD/sFs0Ktc6p9M1MiuWyKsAkOMbDtzfWpNptUcagtYp61YoqwkvtvMzH1zanc7D7+VKybN+BE+lPM5FUU8jNK46Ee2iYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197586; c=relaxed/simple;
	bh=CHmZnGpMrriU+fV0Wym9LBCHNO839AbdgxCfHa+6QnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VC5Uc4VQMPZul4MXP9mfRPDZ2lRzGUAhQG2ptqXJJ3m9jV5bVHta2OxjWwfAiyQilow6SVkSdtggQheTaPv14t9ssl/t9CkaEReu419rrEvApvzv4nVrytJ1vAEEfqb6HPpWuChdDRlmdC6JTy/n4SprYvr2acwkRcrPCCts7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASOz5ENv; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASOz5ENv"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e28bf4a350so29526875ab.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753197584; x=1753802384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqSQdl5IiIxr1mxk1BlzrNlSglQb08bhF3ESql5HZqI=;
        b=ASOz5ENvSLVSPS1YY6wmipc6DRWK/j2m0JDTRmBmin2mj26dvD0pB7gC8KJinyVbGN
         ixO4HTpSraKioGD77Jwg6ufipQX5E6IOmhCKRksAyI8buD28WHEGCTsZG/kwXPdY1IQF
         Aop4qvPw5hS5zEKGuoyOUX+2t/6q7accfIZEpOu8Ohnj/qicuqpAhtwMflapr/viz8JD
         rkFiyjYppV2kA+K9YiGO8PPW08jqaQPBLibYxd5n0lIihgEhjdARIGGHDGpABItx4Xdr
         otsg5VMaVt0Hk/g+xRZDMtpDtWQKFRrOSeN3+wFemc7sWXcqNIUR2q43ympiYpEAYtY4
         Rzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197584; x=1753802384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqSQdl5IiIxr1mxk1BlzrNlSglQb08bhF3ESql5HZqI=;
        b=aRIN7CWoUBbuJIQbv06E+y4xUTU84OAzP+mVErgQmdne8n8JOm8+/CVVbJM/6FMjjo
         rl8K1wzQoGVyo2cfeCEoRNhPG1i9JCh17MoimHWqaqq8pNLdBFs++eHtdIDuZN9GCUYF
         cNLOpGKsTJi2GnpW8FmsnA01mLfAXG0f91uZKgVwPK1CuW2hWt6sWBvqWZ5JaY5/PFgy
         usIbYjBc7Mg2gKvvX+Nt1tTsd1+hlgM+GLbE3zshnYB+t+N14LBhwlebhDHQX7HMkE55
         djLSQauvhLGSLqPoY/y0uFR7mvk0kDP9wR7/5F7aFgax7tmal1s0x5WernJUZYJ7VFnl
         pNXg==
X-Gm-Message-State: AOJu0YzOg2a9PltKqJeaitDth1uO05YTRpKzhj7biIP57z+YAzWZ9ihT
	v2SiRAC7bkGxakYtxJRikiM8lahximwjOtA/rUy/eb25ht1nrB/r2mn+4SR1BSJhEn7BkGjzG60
	CV3worlIF8F2hxNYAXSzrs7eWxd0GLjdz5w==
X-Gm-Gg: ASbGncsgm9tAKs91srZqyr7KPD2ho6qaj4b6Deg94koX/fjzrNcgPFqNsfqB69MJrXZ
	ZdhFxD2n3aDaEzaRhZdd8q00dXmE01XOY/NWuR3Pe14FXyhF4lLBDGpzLBNKvcP/e9EUkyZfpvv
	bNtwunwPFLebEepCxEOgAax9TyIklty6xRcs9hYa+CzMFoKCpcHPuzkkUHwpg1Ve/hKuQeNLI6c
	5z0NEkM2Dhl7ydv8pKHK25GpkKXTeHZ7BETO3FKswK0vignPSo=
X-Google-Smtp-Source: AGHT+IF/q/+dSpA/B+f+oMMBYO7AiXs9wnoXXIk66WrgBch5faZAiC3nfAd44MBjluEXT2/Ic3D7rL+cQgGr62ZwoF8=
X-Received: by 2002:a05:6e02:188d:b0:3e2:9f44:11ac with SMTP id
 e9e14a558f8ab-3e29f441654mr186106775ab.3.1753197583506; Tue, 22 Jul 2025
 08:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFA9we_yDs9SPL2pJU_WiUz8CqvQ8ZPHwXBfTzHHbt-QGV34qA@mail.gmail.com>
In-Reply-To: <CAFA9we_yDs9SPL2pJU_WiUz8CqvQ8ZPHwXBfTzHHbt-QGV34qA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 22 Jul 2025 08:19:32 -0700
X-Gm-Features: Ac12FXzPwXUUxejC9qpKoNqAMf2uaMGzyZIYx4ShAOM1rIyEB8r-y8kBeH3Sh2g
Message-ID: <CABPp-BH-bVrX+w7ZtQie_kJ4vaD9subtqsAG5+WHYCmG408xNw@mail.gmail.com>
Subject: Re: Precious files and the .jj directory
To: Jade Lovelace <lists@jade.fyi>
Cc: git@vger.kernel.org, sebastian.thiel@icloud.com, josh@joshtriplett.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:31=E2=80=AFAM Jade Lovelace <lists@jade.fyi> wro=
te:
>
> I'm aware of the many discussions about precious files [1] [2] [3],
> but I wanted to highlight a particularly pernicious category of
> precious files that are really hard to do the right thing about with
> Git: namely, other version control systems. In particular, as I
> learned in [4], `git clean -ixd` will of course list `.jj` to delete
> and delete it if you have it in gitignore. But yet having it untracked
> results in it possibly accidentally getting added and also clutters up
> `git status`.
>
> It's my understanding that git has more file deletion edge cases of
> gitignored files than of untracked ones so the latter is theoretically
> safer. Is that correct?

I'm not sure what you mean here.  What I can say is that ignored files
are treated as expendable; thus, for example, if another branch has a
file with the same name as an ignored file and you try to switch to
that branch, git will silently remove the ignored file in the way and
replace it with the file from the other branch.  However, I wouldn't
consider that an edge case.  I'd consider edge cases to be e.g. `git
stash` is implemented via forking a number of other git commands, and
one of those wasn't careful to avoid deleting files when our intention
was to avoid deleting them.  But, in the case of ignored files,
removing files in the way of the operation is not accidental; it's
documented as intended whenever that ignored file is in the way.

Untracked files are generally not treated as expendable, meaning we do
not intend to delete them.  The main caveat is that you can request
they be removed as needed by specifying a forcing flag (e.g. git
checkout --force, or git reset --hard) for git to delete those.  There
are a few edge cases, where commands invoke subcommands that might not
have been careful about flags they specify, resulting in the files
being deleted when they shouldn't be.  Most of these cases were fixed
a few years ago, though I documented a few extra cases.  Link [6] from
your Link [1] will lead you to those.

The precious file proposal is about splitting ignored files into two
categories -- trashable (what all ignored files currently fall under),
and precious (ignored but not expendable).  Until someone pushes that
effort, you have to decide whether it's more important to you that the
files aren't deleted (in which case I'd leave them as untracked) or
that they don't show up in `git status` and that you don't
accidentally add them when you're not careful about which files you
are adding (in which case you can mark them as ignored).

>
> [1]: https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget=
@gmail.com/
> [2]: https://lore.kernel.org/git/871s7r4wuv.fsf@evledraar.gmail.com/
> [3]: https://lore.kernel.org/git/7v4oepaup7.fsf@alter.siamese.dyndns.org/
> [4]: https://maddie.wtf/posts/2025-07-21-jujutsu-for-busy-devs
>
> The part about these that is especially pernicious is that git does
> the right thing to `.git`, there are not that many of *these*
> particular file patterns, and they generally merit the same treatment
> as .git as deleting them results in somewhere between frustrating and
> catastrophic loss of work.

I can see that'd be pretty bad.  This probably arises in practice when
folks collectively put the files in all three categories, right?  In
other words, they start off as untracked, but someone accidentally
commits them (making them be tracked in some commits or branches), and
someone else decides to ignore them, and then when the person who
ignored these files tries to switch branches or bisect or rebase to or
on top of the other developer's accidental commit, then their files
are nuked.

If the files had only been in the combination of {untracked, ignored}
or {untracked, tracked} then you'd likely be fine.  You'd also be fine
if they were always ignored from the beginning, since that'd cause
everyone to be unlikely to commit them and make them be tracked.  It's
only when you end up with files that are both tracked in some commits
and ignored by some developers that you significantly risk running
into problems.

Or am I missing some case where this comes up?  Is one of the edge
cases for the handling of untracked files biting you?

> The one other example of one I've seen
> other than .jj is .sl, though that's only colocated with git if you
> are up to serious shimming shenanigans with broken tools (nix flakes
> etc) as AFAIK it is not supposed to be used colocated normally.
>
> Should these be special cased somehow? Should they be simply caught by
> the precious-files work when it eventually gets done?

I'd rather avoid the special-casing and instead have it be solved by
implementing precious files.  It is an interesting case where it gives
more motivation to the need for precious files; thanks for passing it
along.
