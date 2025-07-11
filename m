Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917562F2348
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257732; cv=none; b=UDa7pPF7iTbXzWybmGMuSb7ZJ9ErKsZLmH9Yo54f0+XxC6No4kVqJeaIXUGT0Z7J8BBBYroYyDfuCAvccAyMnRcu7mF0bGSyKz9YBgS5tmtfr0U0grDfCqfuaDQ83r4eusmTX+SrTyhRZ+vOefqfd4DHHfYdmAM4YwE1WDpVXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257732; c=relaxed/simple;
	bh=pwjyS3UJkIXR9+7ASVHXaPxOV1KNyxjIupO3Z255IAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDwYTO3dxfxM01GshLZuBBZhPIajainjhrI/d797we+zdM/FJdp0gqplUYiE8SqeUDm82v+my6qlJhL0WEhmYn6rOlMszk1JwGA4N8KAf9GCRHlLizP/8tEzUsciA6f31YlfzYF3Q0hZxQq0EI5gwjzmq3EcpSx/14k+BwkxgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sxe7wqUj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sxe7wqUj"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34c068faf8so2605775a12.2
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752257730; x=1752862530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAL7BGqv/CEPeHk9NZlEs5UgeBcITQe6g8MnKULYpXM=;
        b=Sxe7wqUj1DGT5jlAFFNC1tC+aHykM5tGRbDc6aOWIwxL/9RHu9QowemGEPjfYvfeXQ
         kMlBJUn5I/WHpaGfvsWftEM1rijLFhl3v74spACWYO13kObx86HWLaZmMR+wUDzI0gej
         eKIdIQ2nM24uqgFkB7cI47oAijbxvC9m4Tzzyc8R2r6UZxvcO2LWzvc1hBdWw2NMgcGa
         P1w2x6yNyeWPI/NZNuj1p6Swj3LFchSU6+Y7N46ZoaCAbwR5g5jCUZ7qjXbnwgJzxkeQ
         skFdi+18o9/S+IKJYDBF1O29YM9WNPF8JPuSbziMSwh0mSlYjknOnooCO3RCAYQWvA4I
         7oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257730; x=1752862530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAL7BGqv/CEPeHk9NZlEs5UgeBcITQe6g8MnKULYpXM=;
        b=H58wLUuJ1oF2l0BlR2m7RbUQdUdtO9wTe5Gbd0wkbY1zw1hAA4KBIoZyMDt3cm8JlU
         2eJKdzR2X6k1C3Vb+bKeTVbf9dZV7WlT0vI6LgLUKt+NOYBG4RwxBNgFybOh19Z8JW9v
         llFzyLqLSkGr0lb+wRrbiWx/pbcG7cVCvDLiVo7wkMQxy1ZPUlUtnwoh1TbNArSeuVok
         Nq6ge+E93e8kSA7jN3K6YzXvqxh1dN/ZPJtsGt+j5WDiYPKyskVOftp/iUmLbqG5/LB1
         uhMG9xC1ZAFALyaDjmtNyZqDTq7ZLZec7v76IZDgNLPuCd6RIY3TF3j9jhM5Uf63a1Ij
         jviQ==
X-Gm-Message-State: AOJu0YxpwK3ZFU/v8X2Wl0Uy3lr1sBVMzgvTU/NERTZG7TBF4TtMheQu
	cLLITqZZ+JJsDmEVlY6vvlTizmqmcfn1lB2yh8M/e4eaP0/jg85h8jzogpUd8KgMKyl96F06dKa
	8Eo/Qju1mJcFp14BCvuw/UEF3INnkSwI=
X-Gm-Gg: ASbGncuGxDxzG9yyGRBHWa+K8N+qLmPtkzOB2ZAp6FkEVlDlmj+m634neb/WQiuaRe+
	XoJUCC9bGZxNCdTGuX+5Az8+IBZnU+HBYf7vBLNePzc6nn6bumG87t7FoKd4nf/nSZMVGNExRQ1
	4liUxRd75BcCJeU1x4B1Z0ciMHncBmuhCnrobKX91dWHfrJyIWvAlav6YbvEU+5Rl08C1nKan3N
	NqPloB7tHk0hRvfNQuZuHihrVOjVfT8NyzKCZAYyQ==
X-Google-Smtp-Source: AGHT+IGSreUPhWrLHzpnvQ+aYyBwN6eaYL9RO0JRQwsGdne7YWRXVI0ragopxbdJFA2FaTI3bS7rqKSNSAdFkrlDPSo=
X-Received: by 2002:a17:90b:530c:b0:313:176b:3d4b with SMTP id
 98e67ed59e1d1-31c4ccea2b6mr5530711a91.22.1752257729603; Fri, 11 Jul 2025
 11:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv7o08ocn.fsf@gitster.g> <CAE7as+Ze8EHda0wMfRKC4z9jE0OLsxxSgckBLisJuoxasgzTaQ@mail.gmail.com>
 <xmqqple63eeh.fsf@gitster.g>
In-Reply-To: <xmqqple63eeh.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Fri, 11 Jul 2025 23:45:17 +0530
X-Gm-Features: Ac12FXxJ8j3IPET-dv2wZlZf_lvn04uC69XeWxjGMWFzQ8ZR0yHG5Ycwgxf6tp4
Message-ID: <CAE7as+a_q4YxPQNdD_fROZTT032_J+E1u9yi94v6XfqM7szVhQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2025, #03; Wed, 9)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 9:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>
> > Hi Junio,
> >
> > On Thu, Jul 10, 2025 at 1:36=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> > [snip]
> >
> >>
> >> * ac/deglobal-sparse-variables (2025-06-30) 3 commits
> >>  - environment: remove the global variable 'sparse_expect_files_outsid=
e_of_patterns'
> >>  - environment: move access to "core.sparsecheckoutcone" into repo_set=
tings
> >>  - environment: move access to "core.sparsecheckout" into repo_setting=
s
> >>
> >>  Two global variables related to sparse checkout have been moved to
> >>  the repository settings structure.
> >>
> >>  Expecting a response.
> >>  cf. <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com>
> >>  cf. <xmqqbjpuqkrj.fsf@gitster.g>
> >>  source: <cover.1751309770.git.ayu.chandekar@gmail.com>
> >>
> >>
> >
> > I have responded to your message about keeping the topic in 'seen' or n=
ot: [1]
>
> It is not an issue for which a response is being expected, though.
> Has the issue Phillip pointed out been resolved in the discussion?

Really sorry about that, I will address to his issue.
