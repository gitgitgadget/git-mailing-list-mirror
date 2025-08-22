Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3A28750C
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836847; cv=none; b=KBizz+dAFR8uh25Mvbvyy8xaPlY/8YUCgYkBxBxVlVVKdjAv+gb7zJxL2vmqMEHilPFE1zLN07lOfSanBlR9yXkQf7BtB2ZxUM2LRFXaFIO0iLGwu0dlPyuCw/w9T3B/XUKSugwSi5H7E5J0U1lrtgmB8NL/+BpDakWBzNLeadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836847; c=relaxed/simple;
	bh=L8kJDvR3oVALvX+VVW66bs+vLBgYrssgWr8YGfn9Qxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcv2gpj3eN4b5XtdOWzNKDZcdGkdLdxJe5evV5MYdcMRnb4DM9aC5ap2z6ZKDgWfjv9WL6OvDi4puNGjxJOVpLy6hRMUcO5S6lBECW/ZeH28fmAa1TVHAFrMDLuK59IfEWgrmFD6JULRGnYcD6pUHC7v2VSMw4qCDmarINYrz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu98WGx5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu98WGx5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244581c3b43so16029065ad.2
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755836845; x=1756441645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awnx6zWwfyvOkS7f37C7xamr0vdVB/6W9WX25jVWyec=;
        b=mu98WGx57DOKlkq9FPyjZz6E33+7nJjpMpz4Eof2Sf9riXmeJhiw+AH6cbHKkqDiMy
         u3iU0OAJCjZjVsr4nTDW6lOMh+O3Cn1/MSgoFxx+mLAWAyYtf+2f5e5M/2h9nWjtkaii
         iyUAXVGonAsFukny6o7Mh2ch86YwWwdhd4lbl0WwtpGlx/4rjiG36lW94uSrx1SHKN5D
         Y7vETj79+7bKrEFdN+0zK7mGGkwfvsYUtlnwzHcGLSayftVWTjnhXEWLavwOCb77fiHr
         JvQ0/lqA6bzfT+49I9VwdwfchKvfSekFqCU4f7Q2PdPauFC+G2p4WSpGBv60uTNcqBIC
         jMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836845; x=1756441645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awnx6zWwfyvOkS7f37C7xamr0vdVB/6W9WX25jVWyec=;
        b=vcCQd4aoox+MonDYDGq/MYexVYJylWfQiF8ICF9GqfOeLky0YY7RmQI0U6e5KuGfeI
         Lxrdhyspnt/x31xtHwAmSAabFTQzxRUgdL5LW9giUfXl3wEngHawQj0fs5kBMd51Sv/G
         tTtwb54a9lr4iXBseHqktE0we+7yEBpmB+ORs5ouvHKe8/BlkdvzbPvt2I28mNaUxufr
         dJwHi6wPsmtmmU+3dFggnvA4+I6b79i8zIloS45HlIQ4mGP9BYMEpCByGSINupYhYJ7+
         sQ5Avy7vUyIhj0H+lCVHCB9hd+HY4CShzbv2+xoEd9so5yS4X3UBjhqYIkPLdHFZwpfS
         evHA==
X-Gm-Message-State: AOJu0Ywz4LR8YHxnknehUO+3fFOPPiBjCIxoKoB5rQV6BFcQ8Omj7266
	g/cLwR6qVVIExhU+VHFHtVNLku9w/bc38f9vfPS/DJKVbywkNFjwwOwFPolS7UMACjJRdSO0c9N
	+BxcsRIbN9vJcFZtZV8e0zsZqN9/q9A0xhRjn
X-Gm-Gg: ASbGnct5tKCaYNc2UkOJ/D7qGFS8AG3NPc+HUB7JESBElq/ns713SGzlWEZ7YMXEdh1
	lWjIr3Vmq9H5EG8cAKAEi8Vq+FEVeH49PbKM19yrDgmwEexcRzj+PkBF5SnvGNrwSZ2Gxsv3JHc
	mhm8UZMRSbPnlPbinj/U+cQFsX7CCG/+wDoRqVr48zw4ECPSINRK9PXQRQ+n2roBBbYZY0oX7h+
	+cEX4BG
X-Google-Smtp-Source: AGHT+IEkjpioiqn+yLqFH3WYmeP7J5TSTcX7p6gCXBEeFggvIQoFV7uRfwPd5dDpSbgJqbk/FhayftuhFmqIH21mR8k=
X-Received: by 2002:a17:903:3c2b:b0:240:3e72:efb3 with SMTP id
 d9443c01a7336-2462ef6ad6fmr26912185ad.43.1755836844760; Thu, 21 Aug 2025
 21:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821085246.929307-1-meetsoni3017@gmail.com> <xmqq7byw4qbl.fsf@gitster.g>
In-Reply-To: <xmqq7byw4qbl.fsf@gitster.g>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Fri, 22 Aug 2025 09:57:13 +0530
X-Gm-Features: Ac12FXzEXpV-K8Y5zeKvgiDvtsJOR58Z6OX8JUuleam7fXNSwvs6ROzn9sXt4Ik
Message-ID: <CAPhwyn2jW4p+_004OHYjtcScGFBEx3zXi50F2TYTDBjsUHFxgw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/2] Add refs exists subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 at 21:31, Junio C Hamano <gitster@pobox.com> wrote:
>
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> > base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
> > prerequisite-patch-id: 235cc677f372e9571dade4313f8cfed4eab65f7f
> > ... (~100 lines of crap omitted)
> > prerequisite-patch-id: 553adfe23223a427db3f93e23dfb603c55cc5aae
>
> Please don't force others to go hunt to find so many patches before
> being able to even recreate what you based your changes on.
>
I was a bit confused between cherry-picking and basing my series on next, a=
nd I
ended up doing the latter. I=E2=80=99ll fix it.

> Learn the way how it is usually done by looking at:
>
> https://lore.kernel.org/git/20250106-b4-pks-object-file-racy-collision-ch=
eck-v2-0-8b3984ecbb18@pks.im/
>
> Basically you would want to say
>
>     This is built on top of <commit> with <topic*> merged into it.
>
> where <commit> is a commit on 'master' (or 'maint' or an even older
> maintenance track, if the topic is about fixing a bug in a released
> version of Git), and <topic*> are topic branches in flight that can
> be merged to the same integration target ('master', or an older
> maintenance tracks you chose <commit> from).  And keep the number of
> <topic*> to an absolute minimum in order for your changes to work.
>
> Thanks.

Thanks.
