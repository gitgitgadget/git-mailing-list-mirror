Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA11487FE
	for <git@vger.kernel.org>; Tue, 13 May 2025 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150264; cv=none; b=rJxKe5YwGyF3ofP9iUIwcFBtff1F8LQOdOry+qageGFwlcdC0wIPoj2jzEC4IqI57n+nUwWP/ouIfIS/oP8AM/TFhLFftZLUk4hBxiy+gxEIBgwDsAWuIQPWw8iAzd0rf8q/Q9kiNtRz1Y0KKrstFeyaXQ8g/tcHDFZzwO/keKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150264; c=relaxed/simple;
	bh=2dsyRVAN0m22Z0E3JtaYQPbzwgIGRCc7nun1pNkagFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SztN32B9UMtcKuTq6s8xCi9Iu1Gfz8AhFS8at54YQJtWzCZBPyTraHQ6MyV8DAuGqCHV/e5Bk4kn0GaF7DA6nurUmn8W3fOefTRL1ufbKxTiRfwrHk5z8VVTQkFQlEjdgE7hSLy4WyiWY7nEmVqQOeXkqkcZ0hGWooSOFucbSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwmL2X1M; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwmL2X1M"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85db3475637so216896239f.1
        for <git@vger.kernel.org>; Tue, 13 May 2025 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747150262; x=1747755062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ina1ruXeyqPaRzzJynDqDgJ09nA0PqJxobYPFXiQ5s=;
        b=gwmL2X1MRpgbaFvYJPXqaf1o1UKmvTZuuO2jECp9vjkgQO59ikiGovz4cTyj7MeX9T
         5wTD0jvhS1qwSGeU1R32zj0mSiZH0jHuMpCyYIG8mDpfghwd9pHShBWUHeQcnRTQDcyF
         fxsh+RpzYLRSL1DNcXG7wIiFilO6zyhNRSPP7Bknebec3II4M9kcSXsEbQ4RiRwrcaFO
         xq0oEk04bFnwbOG6dkbsg/vQfBwStHLto8Gf+XZXvYOonvDho/MtvYm7c1wdmVQdsdR+
         auIpkzhw5MRl4BicUfh6yYKsrT6LE6JVfvkLFGmRhFpyXkEaXJLRsLWJvRdyftR820qc
         ouhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150262; x=1747755062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ina1ruXeyqPaRzzJynDqDgJ09nA0PqJxobYPFXiQ5s=;
        b=OYudWGatodUk9bpootE86X6ajcqY1mNLI9I4vB1MHpNVURsCIojlfkhn16rv3lfAb/
         CEGEq9ETrOvP31qQLZqx5ORd7PuhtCodfyez6dZNhQdgz9Hcj/37jmuz9WpdX3xkamu1
         7iiGpYUlnl8gFIdFBlzM8lhEYVbybDlKZEX3B/A+5z6krM4b9td4dinjpC4BDu8gN0wm
         WwT4E8DynieihN5BdxRHEbyIJODKVFwbCCNOnnHIlCObgPXNm8cZX0NocemyXmAebHuN
         vFGTPCkamNh91dhCRM2HRejKWrxaUJCazYnRJc7ssuFiWXXjFRuTnViatOBx3XpWgOZb
         3DVw==
X-Forwarded-Encrypted: i=1; AJvYcCW6EBxC/31Ljhkd0gXPY9K9e9effbfjCO3zf/TYWB31hQwF8Gy40o4YSXpLmN5qpYSaNnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQCq3hRDdmbKIHCSeXF3FBu3Pw4pJqJNdqYy8q+Ok8kc2pNHk
	fKtXV0v363dTaNORq8Gc5UA01N/wmLPwYSnIxN2i5uDKnkkaYR+sT/Rb85hVfUqxHaebcZy1CNj
	udtwpyf4vUQ4nsD9g0We5sv7apPg4UbTx
X-Gm-Gg: ASbGncvWWtGZYMSy+cVJTpPKzMmxYBd/hoGmjiSe6MeEClB8Pehb4gzPw0iCWfPvU7Z
	QTpjk/O8v7BgUJvmawvCnHqoYN+uvb8iEAWqILmJ2kZKxOErcY0zcXmKHaDfYIi+BWVyJYBRzQ9
	6tB7Fy4/qhGN6eCEFmhBKQSFnITbI0MNk12eN9bBYr9TF6IymW5DkcXV4j3ROAWjVzlA==
X-Google-Smtp-Source: AGHT+IEQ/8AooMjfXig6AZeBvsCkHc/RiwH+OWSfMw1MAMrVWIu8IHPJNsoVrD72l1hQABzl5B/pBm1JIitOrFYySFg=
X-Received: by 2002:a05:6e02:1290:b0:3d9:668c:a6b9 with SMTP id
 e9e14a558f8ab-3db663ba420mr38662095ab.7.1747150262091; Tue, 13 May 2025
 08:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
 <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com> <1d18ab7feb877a4173ac55814177aefe88cee658.1747093322.git.gitgitgadget@gmail.com>
 <xmqqa57giqyi.fsf@gitster.g>
In-Reply-To: <xmqqa57giqyi.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 13 May 2025 08:30:51 -0700
X-Gm-Features: AX0GCFs6wqEQSzFbpHkKOOpPSi_yCWeoJqohQOSBxv8xVvmJaG06pxJ0ZLGsm0k
Message-ID: <CABPp-BHp7RXHFy18=fr1dqQgKiO3PNjXQkL2VX-cjSGsHp48aw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] merge-tree: add a new --dry-run flag
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 6:24=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Git Forges may be interested in whether two branches can be merged whil=
e
> > not being interested in what the resulting merge tree is nor which file=
s
> > conflicted.  For such cases, add a new --dry-run flag which
> > will make use of the new mergeability_only flag added to merge-ort in
> > the previous commit.  This option allows the merge machinery to, in the
>
> The first three lines are almost identical to [1/2] here, modulo the
> internal name still being mergeability-only while the external name
> is now dry-run, which is perfectly fine as long as that is done
> consistently.
>
> > diff --git a/Documentation/git-merge-tree.adoc b/Documentation/git-merg=
e-tree.adoc
> > index cf0578f9b5e8..7dcc17806191 100644
> > --- a/Documentation/git-merge-tree.adoc
> > +++ b/Documentation/git-merge-tree.adoc
> > @@ -65,6 +65,12 @@ OPTIONS
> >       default is to include these messages if there are merge
> >       conflicts, and to omit them otherwise.
> >
> > +--mergeability-only::
>
> But is this internal or external name?

external; Kristoffer caught this oversight too.  I'll send a re-roll
with this fixed.  (I apparently also missed it in the
die-if-incompatible-options too, not sure how I missed all of these,
but I'll ensure they're all fixed up).
