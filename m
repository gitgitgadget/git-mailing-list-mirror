Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAD1632D3
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414699; cv=none; b=LeZmn9OKIovVHeOvQusC59K5GMlEhchzi5zPO56LmtQETarUDHxKfwVLKoemthiexoAFQT+h2vxyKb36ISMl66NhykadeFW9W0V6hQsk7WYNCXHoNIutGA1mlK/TKIz4fDvqDo5PBS2CkG6DnCnlnBnuC7V7LamE2tq4AVSrUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414699; c=relaxed/simple;
	bh=AcHCLfdTRj0iaIYH0zrcvocj3fJF3FfDSK4rKp8Wmx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUbFxCDcr3AHdiRIEKVHIxZMzoUI7sdK2tMFVVNPwO2toRiureHyZQ3pPNz55ERVv/PGgNX37u4dxwzuL+IbHugy02vdBCUtBfO28tcVyVaYAVW7F1QFoxgMLQUR7NsPpEQ2F5rj9OyUbkSwu7gDk4Q5bXzUU6N7+poGNHKR4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJu5RwQd; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJu5RwQd"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-855b09fca35so383355239f.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 08:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740414697; x=1741019497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJKOYAyjQ5AwjgfMQTX8F3MzqZSJ48eipcNQwyMhUjA=;
        b=jJu5RwQd8QZHwC7zsOqIGk5yqvqD3oavIs3zwpMkQcxLKW3PkXksCesJ5Q3uqj5PKs
         7P97TpKgV4Vxs1KbuakkG19Gr0mBZ5JwBUakzfQ2khUDbwC46zJ9S6cnYa6biUYz75zd
         hbO/Rh7G2C6mEGRrt3j+b80aDp/CaWiF5Vd/YkEVTn44bcqbyas61GVGhP5pqOqqV/9q
         wHLtOFn8qGlg2hNnNg/ss3rYvgzcCwtXnixuXne/MkUQaiknLq/Kn3geFj5W+F3SjfIq
         EJyi7XniJg5/IO93WoXOe/ywbSYc7+Im9p2JdaM6R+fqpve91miu0JnFSJD40UD/GrMG
         AL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414697; x=1741019497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJKOYAyjQ5AwjgfMQTX8F3MzqZSJ48eipcNQwyMhUjA=;
        b=RnqNjTz7JxDcvN4Ov1emj40GsQpHNAPW8p5hx8heAtAO2YAc/cXy0qBDhmkY9myKLb
         2PRY5zACtpMByHLDqE+bZk/e6Vpuk6xFBu37Lhr8x73V5F0BU/BRExhUYikKKOtryT+v
         KPn27a62cScAQeAP92u3cYLOS42WIc2+zcPntNTEpRki7YiUM19qULrKN1cU/9dmf7gJ
         b24QUQMKcVj/qEgOeeRlezij8IZYuCv1FA7tuuLkPb58VnjByeIHkt+rUAoD4lIus1ei
         bZUZvIvEIyH2rj84X+srY5gKzX+zGgM6bRhsorX5mYCfOGk7A+UCWeX+aT7f7A3cWG4D
         4IZw==
X-Gm-Message-State: AOJu0YyAoGMHdsVkObW7T92/tN+FHzN1B7jpz1+IDJH5xyg8gQZvhsCI
	119jC3JVfo8Owtwsco2aEMk2RTdvkSTYtgg4ah6xSnO0MGZDrXFuI9e8B5zVSie52Et0vcAqgzZ
	dykXiPpwZwr0NFenf4gd2qHWbfRPqcg==
X-Gm-Gg: ASbGncvFtqbPnie2Ts/VgFXzK6MBBKmizoSIhqy7lTssSPErxlFvtB0ymJmPh3JiUBp
	4+EvL9KWu7k6yzfsutq4EyJRGlPQXOUpziFoodnzDCUbMhQflA6ArDmFwp/Fhgs3wUMQwLTJ0uA
	pzfQ10kImA8yHdF8e31ZTo/6UMMSE6pyrYm3XPaTo=
X-Google-Smtp-Source: AGHT+IG9z2/86EPqIzlTwxu14aYAcCPPU8ui5+i2F2mRWzCnDv66fEWmAcTh8EgJab6Z5DDqUGB6g78akpKshQ67OBQ=
X-Received: by 2002:a05:6602:1347:b0:855:bf2b:adb7 with SMTP id
 ca18e2360f4ac-855daca8705mr1375237339f.12.1740414696784; Mon, 24 Feb 2025
 08:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV2XOTQ2Mna1B_sX0EF0ffohcrexh1EO5d4G0=sqdmxQtA@mail.gmail.com>
In-Reply-To: <CANM0SV2XOTQ2Mna1B_sX0EF0ffohcrexh1EO5d4G0=sqdmxQtA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Feb 2025 08:30:00 -0800
X-Gm-Features: AWEUYZlWGEcZ1s-hysuz7wJF-sfFbEB9gmfF5fyN8VyTddr3FlxBUn4UGf7ztKw
Message-ID: <CABPp-BHObCVqxWuBLgeiWghy5gM8-f_qjwYFdBL+=j1bwtPg_A@mail.gmail.com>
Subject: Re: Diff rename detection performance issues
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 2:30=E2=80=AFAM Devste Devste <devstemail@gmail.com=
> wrote:
>
> I have a merge commit that includes 2 modified (!) files:

What do you mean that it only includes 2 modified files?  Modified
relative to what?  Modified relative to the merge base of its parents?
 Modified relative to its first parent?  to its second parent?
Modified relative to an automatic merge?

Also, by "modified" here do you mean the change type is 'M' in
--name-status output or could the change type also be 'A' (added) or
'D'(deleted) or something else?

> hello/foo/stubs/example.php
> hello/world.php
>
> I want to only get the changes introduced by the merge commit and
> exclude any changes in /foo/stubs/:
> git diff -l0 --name-status --find-renames "$sha"^'!' -- ':!*/foo/stubs/*'

It's not clear to me from your example what the output of say

   git diff --name-status --no-renames "$sha"^'!' | wc -l

would be, though I would find that very interesting.  I'm also curious
what you'd get from each of

  git diff --diff-filter=3DD --name-status --no-renames "$sha"^'!' | wc -l
  git diff --diff-filter=3DA --name-status --no-renames "$sha"^'!' | wc -l
  git diff --diff-filter=3DM --name-status --no-renames "$sha"^'!' | wc -l

(and yes, I am very intentionally leaving off the ':!*/foo/stubs/*'
negative refspec; I want the output without that.)

> Git takes more than 4 minutes to generate this diff, since
> hello/foo/stubs/example.php is a huge file.

How do you know that is the reason?  Especially since...

> When using --no-renames (instead of --find-renames) it's much, much faste=
r.

...this seems to contradict your statement that the reason for the
slow diff is that hello/foo/stubs/example.php is a huge file.

> And without the example.php file, the diff takes less than 1 second
> instead of 4+ minutes.

What do you mean without the example.php file?  Did you rewind
history, remove that file, and then redo the merge so that it is no
longer included?  Or do you mean something else entirely?  What
exactly?

> Funnily enough, when I have a merge commit that contains only that 1
> excluded file, it's the same behavior.
>
> 1) if there's only a single file in a commit, why does --find-renames
> cause a slowdown? There's nothing that could have been renamed in that
> case (probably the same for --find-copies)

I'm not sure what this has to do with the above; you seem to have
switched tracks.  If you have a commit whose toplevel tree has exactly
1 file, and you're diffing it against some other commit with an
unspecified number of files, then if that other commit with N files
happens to have a file with the same name as the commit with exactly 1
file, then --find-renames can't really cause a slowdown.  It'd only
cause a slowdown when the N files in the other commit were all
different filenames than the 1 file in your commit you are diffing
against (but of mostly similar filesize).  But I suspect you meant
something other than what you said here.  Could you clarify the actual
setup?

> 2) could rename detection be "delayed" to only run/check if there are
> actually additions/deletions (and possibly only check those)? If a
> commit only contains modifications (unlike in a really, really 0.0001%
> edge case) but no additions+deletions it's extremely unlikely that
> there's a rename, so detection could be skipped altogether?

Rename detection already does this; in fact, it does better.  Not only
can you exit early when additions + deletions are empty, you can also
exit early when either of the two are empty.

(In fact, there's some other optimizations as well, such as exiting
early if either additions or deletions become empty after removing any
paths involved in exact rename detection, or removing any paths
involved in basename-driven rename matching.)

If you want to see where this is handled; see the "if
(!num_destinations || !num_sources)" check in diffcore-rename.c.


Now, all that said, I suspect you're getting at something with the
negative refspecs that is similar to the optimization idea I had for a
real --follow-renames, but before I jump into that, I'd need you to
clarify your setup a fair amount to make sure we're on the same page.
