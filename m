Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3726E14F
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894181; cv=none; b=XFcZX9cV4FCAq4tGOCYy2fRTuFw/CEvVrw61GHqdU82PajWMU8S+ruyJuHwreBe1VLbhf6ToVQFnqIw98E9AM3paUHRO4rE/tfXnKt/RGsYd+LoBk6NYAypcDkQBebC6B+VVk172eS7GIGnO6nin/pAIv+NpwGXFJmY303YJkUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894181; c=relaxed/simple;
	bh=akO7vNAcpxXDbeipt88G80EcGdqzhjbVeGkYpxJCj0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9kwSpvey5R4sj7+zPAy48zM72rZbZwkkvmuVULr+IdgV3ZNLXVxk9/QJS5Wmkb27qvmykhnF8w7V2bYFfSe5hsTz2UpAAsRF/vf0NyM5EhfM1YSoEBB9HXve7EzBmByiYFNoUAqevKFTtxwmLi66dobOHicsaeA3ceHCokcw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4fMo6K+; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4fMo6K+"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-84a012f7232so192155239f.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739894178; x=1740498978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPgxzhqf5AH2s21Ig/KeAU7ooQCcZ8kHDT6mHq3QAMQ=;
        b=S4fMo6K+nuuEoy3b/SUC2qveEKCDQfB6CSiv+PiDkeqA6sbfKV3pde2nM8oLVVQ15e
         9P/yDISrZJPu897mzWLkyu1QdgjVxhKxWeffMZ5o6wmyNmqmt4MP+/lEr+SC1Aa44GOZ
         iTZvz4xXSYiXhXQeoSnKgxatMzml8K5ksRKygJ1Ac2DKenut/JIUFz0xr35W6k2riKYz
         EtzEE3eazfGUMLH892K9Coq0sd2WZ9W7GwnW/ksRrTPJN0MivhN5kAe84vpaC5lp2ZBV
         739Z7+lcElqRUklno+FeLu2YDtK+BvxdJyjvxJMrAxNh/B9mFSp46Ps+zTi+/MbXpb7e
         sHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894178; x=1740498978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPgxzhqf5AH2s21Ig/KeAU7ooQCcZ8kHDT6mHq3QAMQ=;
        b=K5mRxWUweHkJUqqDuBWn77K1W/5TpjgH/YUUhje8ThEK9SlUHh/NuPH5o+8l85GVhU
         GtXWN7lnznYIzhsSs0//sILUskIJeG4Bx656jRc/KS7F7x31/3fuxayT+dAiVv6m3wVV
         ki2+px/5WqhmiXg/DvpyOhiqlToTEN3ZnwrVGP0mrDJxy/Qy+nYRcVWzVShVvcdjQRvo
         7UyQAN/qIjYKqBuvx4PZKR3dgLfTVJGfnoS2b4OCFfEHKlW1Um8lZfoeZoxTVKwl8VLM
         bA+1ieYl54Mu48DP63l9cqMVtAb6Nrs1L10hEg/Ul8DFzIDH7fDCdrPb6h8Mh4qvs8W5
         Blew==
X-Forwarded-Encrypted: i=1; AJvYcCXIJNo5G7PHYNIJOTO/DDfVvv/1WvxU95fvFG9yuBs3bKrHa6OIgsEHw2KCFC0AZpMtPEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQ/X9FkVi8C5hj86rzla+5PCmy5uq9IZodxFqKXQy0GrYWb6S
	HBlMbBLAiqdXaR1nPdfVIyUTRUAILBlN/iCoLAdrUiRvVT9G+AMtRvToLAoRgszFyaC28GGpftQ
	DVQQV8vrOZp8dCdB0ecAowVxlLEE=
X-Gm-Gg: ASbGncuwFgfN9q1hbLvPPdOt0OADVjhPjTivzSSW8yHB9yuvEERzgLx7h99+zdgdntk
	FvvcQoqpjTPf+r+SiXm6oqeH9ojdiUl2JLGNYxMIQNhoK+6V+vIHuoFBbUxqDLGeXFdqTzNegqt
	BCZbB6yyPhXthe3BcoNYxbMsRt/ARKOQ==
X-Google-Smtp-Source: AGHT+IHZsRnvfIsyB2Kinv8fZne/CCOkX24ZQ64bHG1YhCioxsvNY/Nek/WhhvZk1jClThuvQh+Fo3Jg+/GGbRK+Prs=
X-Received: by 2002:a92:c8c4:0:b0:3d1:9bca:cf28 with SMTP id
 e9e14a558f8ab-3d2b4ba787emr2194375ab.8.1739894178553; Tue, 18 Feb 2025
 07:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
 <4c4168506346fa3eed3d01445980044bce6c14ab.1739723830.git.gitgitgadget@gmail.com>
 <CABPp-BG13wHuUKLZ6xAJn7z44HbNoO=4D71cY48vmBUnpfoiTg@mail.gmail.com> <1b6ba7c4-56e2-4892-93d3-d57c7193432d@gmail.com>
In-Reply-To: <1b6ba7c4-56e2-4892-93d3-d57c7193432d@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 18 Feb 2025 07:56:07 -0800
X-Gm-Features: AWEUYZnlgFFnqbQATK52QjC92x326FZ3-I0goS6nzgLdBM3lWopmDY1-dmhyTMw
Message-ID: <CABPp-BHqg45=yo4EPmYc9bFpB-wt8vaR1BCqksX1wgEQyq999w@mail.gmail.com>
Subject: Re: [PATCH 4/5] merge-tree: improve docs for --stdin
To: phillip.wood@dunelm.org.uk
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:02=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Elijah
>
> On 17/02/2025 20:26, Elijah Newren wrote:
> > On Sun, Feb 16, 2025 at 8:37=E2=80=AFAM Phillip Wood via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> Also correct the
> >> merge status documentation for --stdin as if the status is less than
> >> zero "git merge-tree" dies before printing it.
> >
> > This also makes sense, but...die'ing still has an exit status
> > associated with it right?
>
> It does, but that is documented in a separate section which says that if
> there is an error it exits with a code that isn't 0 or 1. The section
> I've altered is documenting what "git merge-tree --stdin" prints to
> stdout and if result.clean is less than zero then it dies it does not
> print anything to stdout.
>
> Best Wishes
>
> Phillip

Oh, right, so your patch is good then.  Thanks for pointing out what I miss=
ed.
