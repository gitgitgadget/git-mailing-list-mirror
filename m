Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0C27702
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784799; cv=none; b=LvOR19xyuMF2xFzGlNX/FKl4al6GW7xKEZVo521fT4nFqg45ZEkOu84YaRXHehxKVnWrIhVeZ3a033fS+v1OL/xS/hE0Kl2jovGuUtP7b6ac51wU4EWK14l5N9mBUWP7uj1Uw8pBaWOiO4cjF+INlvwKQsQmvgDSz3oFHEJhFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784799; c=relaxed/simple;
	bh=Sf206h3VISxlNt77hmN+UjE+ssizHtBSnnazJEpmd+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZKNV9FmL3meJ8q18WkTypp2hsRdvOxEyydfqMRcYLe61oehQyx6uuiMbncTtWQooazLvXLbT75DcCg6h4aPfDB03Ubf8belxIo388fD23HyqUkuSxLsqquaAZHiWo57oil354dsV3wordzNgrsslq40vjwhRXDFbjMwFPjM3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyggkPyf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyggkPyf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso11173085e9.3
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743784796; x=1744389596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reqocsY9zdX919DfQcB/AFW98o5yEbsJ35UnfXEj03o=;
        b=YyggkPyf21vE0m0VBJCgHzYI3rIuXJbiP/VGN5w7DjfRQvJli17RStlLh4t+VlZ2JA
         4No9m+mhvNIskr9UePt72GRbYGZ5PLJKmY6AUjCS4WBn81v83qKzgdSvWKLNf9NOAJwN
         ZLF4kNSMWJx9ugE3kuPV0BQVlIhtE7DnBk9zDEyraq6hpV2aPT0yaLNzpEYS3Tble0dc
         M1eU8EOE0qAxhBrg3bmIfPUdvKqwl0/yprsOD0ZcayQd0lyGCl+Aui8xpkSvA9CFqoPv
         sP6xxgAyFO4Os1RoD174GSmT+c7Nz5KFh8Cs2mgv1l/kfJwNbXzwjXPLNNx3fFJg7gh/
         8+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743784796; x=1744389596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reqocsY9zdX919DfQcB/AFW98o5yEbsJ35UnfXEj03o=;
        b=GSi7Trl5hfmsefMPhvK0zhdv13+v4skzjqPHmfCqFnTTznjfa3Ks/eGAvHupBlZdWA
         oVFj+uLgm7nlInJbn8pwYVCRzzELIJVXZHr1buvCget2Is1pObzVN8mFo9WoNFfD5Jsc
         kTDfNnbHCU4PxdisetiDwwgfoFq8c7tleha05k9iuGrJDUhzZ0Y38wcFzEQcMJ+5MApZ
         RSYRYAHGRa/Asf8TCcR1tBNKhWGUJtkPyMlJEl99II2pjKqjZ12ZqbWtSlEvRAlmeBbr
         gvH6EaIpiLRYHjwxbVwCo8z1FC3dxmre+/xq8V4cSeYXlVIwE0CboO6ghT3Q+t+B2N4T
         D8iw==
X-Gm-Message-State: AOJu0YyWhex8jOjzMG6EyHCX1jXLydq7eDdaX5KhsX+FAaoqFLPo2Sok
	4MxvXK4OBlAMgnDPfVl1/jwwvZzwDQ2cwsV35teoLR4BzzPHXi7eYlXIowIqycTvttY1Ka9Vse+
	3mIAUBALzGGrreVW42HoJXT63H5U=
X-Gm-Gg: ASbGncscF3PI+9CAfC7ga+9LHZTYdew8+jFk1sdFZSqPhO+UHibeyyjsDG16Cwie7RA
	jyBKxGDI1lZZdKV4JixQ1wmUKj4nabYmHarWIcAGTFVY91ZiH3iWaN4bNkzOWUu13Y9QhT/gcWa
	dHm19SMhvZLd0+mTuXM5K483LgHXM=
X-Google-Smtp-Source: AGHT+IFoXB75bpPOH+INmAv9C0Cg012Ie9/MrMKlBlFFYOHvr23dkjjKziaR07Kb7FBrjP4lc7bRv4of4nfYDZgg+l0=
X-Received: by 2002:a05:6000:22c7:b0:391:29c0:83f5 with SMTP id
 ffacd0b85a97d-39cba933215mr3860745f8f.44.1743784795577; Fri, 04 Apr 2025
 09:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com> <1676b5ac628fd2898c3dab1b25d6a852cedfa6ae.1743354964.git.gitgitgadget@gmail.com>
In-Reply-To: <1676b5ac628fd2898c3dab1b25d6a852cedfa6ae.1743354964.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Fri, 4 Apr 2025 18:39:42 +0200
X-Gm-Features: ATxdqUF8PPb6XsQE97Lauf7jA4blAQitOLlO3DxdyUtQzpQJtIyqLgOHWVlQIRk
Message-ID: <CAN0heSpQVWEko_=Ld1yQvduH4amB+Ei8Gf2pOjWA1Y4Pq7GSKA@mail.gmail.com>
Subject: Re: [PATCH 1/5] doc: convert git-reset to new documentation format
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-No=C3=ABl,

On Sun, 30 Mar 2025 at 19:16, Jean-No=C3=ABl Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> - Switch the synopsis to a synopsis block which will automatically
>   format placeholders in italics and keywords in monospace
> - Use _<placeholder>_ instead of <placeholder> in the description
> - Use `backticks` for keywords and more complex option
> descriptions. The new rendering engine will apply synopsis rules to
> these spans.

> ---soft::
> +`--soft`::
>         Does not touch the index file or the working tree at all (but
> -       resets the head to `<commit>`, just like all modes do). This leav=
es
> -       all your changed files "Changes to be committed", as `git status`
> +       resets the head to _<commit>_, just like all modes do). This leav=
es
> +       all your changed files "Changes to be committed", as `git status
>         would put it.

This loses the closing backtick after "git status".

> ---pathspec-from-file=3D<file>::
> -       Pathspec is passed in `<file>` instead of commandline args. If
> -       `<file>` is exactly `-` then standard input is used. Pathspec
> -       elements are separated by LF or CR/LF. Pathspec elements can be
> +`--pathspec-from-file=3D<file>`::
> +       Pathspec is passed in _<file>_ instead of commandline args. If
> +       _<file>_ is exactly `-` then standard input is used. Pathspec
> +       elements are separated by _LF_ or _CR_/_LF_. Pathspec elements ca=
n be
>         quoted as explained for the configuration variable `core.quotePat=
h`
>         (see linkgit:git-config[1]). See also `--pathspec-file-nul` and
>         global `--literal-pathspecs`.
>
> ---pathspec-file-nul::
> +`--pathspec-file-nul`::
>         Only meaningful with `--pathspec-from-file`. Pathspec elements ar=
e
> -       separated with NUL character and all other characters are taken
> +       separated with _NUL_ character and all other characters are taken
>         literally (including newlines and quotes).

I was surprised that you wrapped CR, LF, and NUL in underscores. The
commit message only talks about <placeholders>, similar to
CodingGuidelines. That said, these _CR_ and friends seem to be
consistent with similar conversions you've done before.


Martin
