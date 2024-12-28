Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303602111
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735403117; cv=none; b=AONtm0S3plpfrFjmIh+bryEGzqFKZkQuvWDwy9x5jHtJrlBNn+hmYRTxg4FAVkt43XfP8vkbWySOvQ6opqdlXpA6OKvJAX9xhfkHYZ1cgWlyrRfgayJ6EJBFdMDPL3FgVdOpZbcs+B8OIufpOgtEvJ/j8QWsyuiTGqwuCKMf6wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735403117; c=relaxed/simple;
	bh=OrCdNnVcw1/z/IKT4Kn92jcF77pFaLnpIJvAnXrg6tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZ+jh/fllTVQqXNrNK+roMnp4eD+wj0mnWNPvzPTAJpMhvm4J2rKIImcG8ZbUWFRJRsjWYLfseJKA6/Z/7ee7O4X+s/Ws/4iQ8imQsZOm8zxP1gJHXsxmPaYVgIb7qVtgxLcGydxsyI8c9zRaBETmF6s1j1uuzs77MZNAyAJ7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuGgWbrA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuGgWbrA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so10193044a91.3
        for <git@vger.kernel.org>; Sat, 28 Dec 2024 08:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735403115; x=1736007915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19S3lRK0+5J0KIwMfUc267JgIKBvcw/tCC/V1fuewBQ=;
        b=SuGgWbrA8o3A5kYw6JSRWjbkuz81oc3NVOb/r6ucfn1VOfbaijtkjTQ47C3AJLHCSA
         IBc1am+4Vne5Rd9aEAGdaOKmZ7dnqq4QMmMDGBox66bLsEInumjJFLG1IriTKgz2+Ouq
         cm//LZKYTIWhfz715lRL+9WB167JYpg7wKPZ2ctmiPDm5WcNRFZOiMCA8lvv1xZO6WCy
         fJ+VoH7z3IJEj0YLA90ZwDBWX+A0a48WXAa+2yg8McptP8vfyB5hjLZmEllm8jippXGy
         hnBxmjVhR8LOQMc2UpDg4rNd7xoYBDn/mYs4FCtt0yMhnBocRD9m4PAvMCRihs27w00W
         gJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735403115; x=1736007915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19S3lRK0+5J0KIwMfUc267JgIKBvcw/tCC/V1fuewBQ=;
        b=T7Z5an+era6ylCu6D7JPebPsY/CvIZOlBuz6ttKdkPCqZCwK6l/jEEwMM4UxHAvksb
         0GM6haGCtw9swdxt6izTCIra1ZbFTdyCOnNIb9O+YEeULPTh33weXO0k302yVE/zvWR+
         5KE1Xye0XoCKlHzrJnsIEJYA8gwyC0oJ3yDwp3B9sZC62F1LhOhtJGh8i6zi9fockKra
         H5l0lTZmBTc3p4fvmdJrigNfh5zAaaZP0qZedUPZBCmudCp0q0S9u4ne/E6qFBHvUiRB
         /fx0v+qaRZepqhu38h7uQS0FAodihcB2x3tQFPI7NB969JN/pcGdrxUCBnmAzx/zzlfH
         uDvg==
X-Forwarded-Encrypted: i=1; AJvYcCW4EbrThv1S74Am9sStEgqsnQ1eHbEpNaqWQcncl5b60o3au1I0HXd3dWXR+lT2h36GYqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEyTrKQPl0WZd/VzSAbwL6lRWw2f3bakLmrwuwBW7HhJOM+1E
	CCvKteX+1yQhRFLSsy/bPqgW4Qgz+O013R/5GRZJ65lU6cvwrhIKDudVCRPyAl1PKOqxq3i2ZZw
	gLgN0zcklhwJTL53sAj1/sN/2Kh8=
X-Gm-Gg: ASbGncs8sLqfLFl/ClC4HkreJ+sEEqCTNfO4k0b3hw3snfFipOR4ZqlgjSiHvhxwlOI
	IMA8IN4W+tFm0OQSJzPh43EIqZn0YOrLw0IqsnpWoX1lXcLzOeq1qeHFVLqrJBdsxwvJkE38=
X-Google-Smtp-Source: AGHT+IEId8HtgmHVHpaildquaovjApzLJbVuKguJw5HtgjLS2bwSeR2rddDqSkgEr/jlsNFadjI7Cugr1GQPdLpzvkQ=
X-Received: by 2002:a17:90b:2c83:b0:2ee:48bf:7dc9 with SMTP id
 98e67ed59e1d1-2f452e14ad7mr49985638a91.15.1735403115526; Sat, 28 Dec 2024
 08:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
 <xmqqed1tv6hu.fsf@gitster.g> <CAG=Um+0a+ugf+gWUDS3htj3u2tewzOrH+xGbF+2A+w4ofjQfKg@mail.gmail.com>
 <xmqqr05r4wu5.fsf@gitster.g>
In-Reply-To: <xmqqr05r4wu5.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Sat, 28 Dec 2024 21:54:39 +0530
Message-ID: <CAG=Um+0rnj3B3QoTZFCZWNCcYMtoiLnn=nov7GuHRH-aDydARQ@mail.gmail.com>
Subject: Re: [PATCH] maintenance: add prune-remote-refs task
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 9:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
>
> >> Hmph, is there a reason why you need two loops, instead of
> >> for-each-remote calling a function that does the run_command()
> >> thing?
> >
> > It can be collapsed into one.
>
> Sorry, but that is not an answer, as my question was not a
> suggestion to change anything.
>
> It was a question asking you if there was a specific reason why the
> code was structured the way it was written.  If there is another way
> to write it, you need to answer why the alternative wasn't picked.

There wasn't a good reason for doing it that way. I guess I was trying
to understand the second argument for `for_each_remote` would be best
used if the command was called directly (while avoiding a compilation
warning), but looking at a few other usages of `for_each_remote` I
realised that it could just be marked unused in this case (since we
aren't doing anything with it).

I should've probably looked deeper and learnt from existing patterns
(e.g. `maintenance_task_prefetch`) =E2=80=94 which I have in my last patch.

> >> This loop does not stop at the first error, but returns a non-zero
> >> error after noticing even a single remote fail to run prune, which
> >> sounds like a seneible design.  Would an error percolate up the same
> >> way when two different tasks run and one of them fails in the
> >> control folow in "git maintenance"?  Just want to see if we are
> >> being consistent with the surrounding code.
> >
> > Fair point. I'll make the process flow identical to the prefetch refs
> > task that works similarly across remotes.
> > It returns as soon as the first remote fails (without necessarily
> > affecting other tasks).
>
> ... and the first failure signals the caller a failure?  That would
> match what you did in your new feature, which is perfect.

Exactly =E2=80=94 the first failing remote will signal that the
`prune-remote-refs` task has failed via an immediate `return 1`.
The maintenance command uses this to register the exit code of the top
level command to 1, while continuing to execute all other tasks
anyway.

Thanks,
Shubham K
