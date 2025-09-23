Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEE2797B1
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646264; cv=none; b=Q77U2FWLHRCEgjMAi+7mb7VLE76g5878jtxLQy6ZzH6Vjyb9IRebdi7bo73t7A17UP3/6VI2HckOIm8vmfqI67KuD7ZxauQ9Qrr1sI9ZP2CQE7sjEjT8kV790pmfFle72j3YEsVUxoEsjwM/pLB63iatnwFtMWXS0806Y+CC48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646264; c=relaxed/simple;
	bh=NaadDQINS2NBBOujFIfR3+DoTD2Lksvp26ZIoOwtme0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4xzpmhpY6RXOCngXQlOUyDOzN7QqYlWUjsPtQ1qH9CsLFfp4xKsGZ1vThLm1IREaWQaswH0qYEZ3DGA2dGUhIMgchka+JUdP2hUN9gUWcpqvkDki3pV5Io5G89TrlouJqfBfhlqlP8YGvKMFAa3oiVMrXYtxmsEl1mTFo4Rc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yqot9dsM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqot9dsM"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-36453927ffaso38779111fa.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758646260; x=1759251060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVDIdaRyzdXIn1qlVR7PZGxkpcyomrHI5M2PBPszvJo=;
        b=Yqot9dsMB3UNmBhyZYWuovmoXGG3juDJZK+SWg5IaBuUxPYkfrVj1P9CD5NGxu/URo
         jrlRzrOkndlRsyoO6mzIjAhG+CiTf17sRP4w3XVb69Qokctz3+Wzyq1yNmLLbxpPU056
         eSgG09oApfm8x/eLXziP1E4IxwVbolVSWVJE//Za47ozdn2wKP88A1bBbSPiu39BIaTA
         arSQ9ZnGOfXJS84PKCaJ0/kWppxERmrz5kTzU4taG2c2hlaSXuhqwoloBVbGn4HLFRiv
         zw0tRUoGI0UeCQDV0rVjeJrCQJ5wuvR1wHB1NpmCSfpk+x0mBKfLhj8drMmmJnRVY289
         MmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758646260; x=1759251060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVDIdaRyzdXIn1qlVR7PZGxkpcyomrHI5M2PBPszvJo=;
        b=eNVs5DWq7V84VHn+6AG4IZUFKtPoOCCbnqEgLeSNNWBOm4V6Ox2cxp0E2F20zcuFbP
         CwltcZg0S9osV/w26LoZcL0hlE2M7cnamfgWEWtU/QTAIHzr2Jo1pEElgeOPakJhhuKS
         qFc9eRQC2n0kjNohxTgCBaYpcyBPqpBMmFcbjmwkZOcdaIBRBDjTnEtEHrTltxgaZuez
         QSnPPaniQvcWZrvtEWmP3/jAAgdqnC0Rzdl4qwjw9NXIq5cD1XDhZSI4VlZlZJ3CDNvs
         81W4HJvhc8OynGFnC23nHTBQPSLY34t32EQwWT7V4wlgx6676SzpL6TdB+GZ7DYOJnqZ
         aH8g==
X-Forwarded-Encrypted: i=1; AJvYcCVYVR0U1zvi5I+ADVo7o7oINUttq/D7zdB0jw8Zc8PMKmWq4dyZ2BY+PxcpF3+5/Ysqq78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkrOdg2VpHteI8eH0wQtPU0JA17wFiVtxLRyDHERlV/54WxY9
	Tn1WyVOggEldupXf6PuY7WGJSyugpmQuv3WHi0n7h6P0AGaTzkdEJoy1etUftSp0uk9lkNhhXUw
	/n/fuAIs8gMc2wdmq/7HG+M5FH72i+vE=
X-Gm-Gg: ASbGnctbd5VkyEQ3/w4KCqfRMQ85SnLyuxsZ6GkMYHeHhGzIt+tjObKE/grNIaGAFuE
	yuJ5rx1NI3DJb3W6oy6jM7U/P3mIwFOIfIv9OuzIvqm8hEePa9DoOSQ/GD6/FsqBkvQLfmQ7bx3
	4i4I4gb7xADD3oT41PFlCbP97NQr6SfAoPaDEBk1C1HSE63zP6amfJivoo1ij11RyxtaoVp69nw
	c9XsrtA
X-Google-Smtp-Source: AGHT+IGPG1t+s+dTc6i4/k9q4zlCeiUEW2Nvq2VXdOeCKwI4YypNm8K/asjpEEBGbTXKZSjgj/j7WQZkdZOzGlzM4v8=
X-Received: by 2002:a2e:a9a6:0:b0:36e:1962:1ed6 with SMTP id
 38308e7fff4ca-36e19623e29mr1375461fa.40.1758646260203; Tue, 23 Sep 2025
 09:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
 <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com> <xmqq1pnyru1f.fsf@gitster.g>
 <CAH=ZcbC5Y04D4bGjfH3rZ8GKabDttFez5qb9i8mXVsfE3LF26w@mail.gmail.com>
 <xmqqecryq8o9.fsf@gitster.g> <CAH=ZcbAHgCLjpLMzditOg8CW-L1RPohGuQjst=h-rATTSoio3Q@mail.gmail.com>
 <xmqqa52lqmup.fsf@gitster.g>
In-Reply-To: <xmqqa52lqmup.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 23 Sep 2025 10:50:49 -0600
X-Gm-Features: AS18NWAmNX4h9kr6KtEx5Qktqsc-ma3sCzRc3MI4_RSKDSDROMyX_HuIAVBfK8U
Message-ID: <CAH=ZcbBWjzHcQMX3_fjp4a0gSgOv-yHqZEK4T2+jaWp1nMmoHw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Cleanup xdfile_t and xrecord_t in xdiff.
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 8:12=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>
> > I apologize for my previous phrasing. I was not very tactful. Yes, I
> > think your suggestion is a good idea. I'll incorporate that into my
> > patches.
>
> I didn't get an impression that you were _not_ tactful at all.  If
> the arrangement is like what I outlined in the message you are
> responding to, I am perfectly fine if the type of changed[] is an
> array of bool.  The only thing I found was disturbing was the idea
> to assign 2 into a _Bool.  Comparing a _Bool, which can be either 0
> oor 1, and find it is different from litral 2 (or MAYBE that is
> defined to be 2) is perfectly fine.

I'm going to reroll this to make it much easier to see that the enum
macros are separate from rchg/changed. After carefully re-reading
those 2 functions, I think the macros NONE(0), SOME(1), TOO_MANY(2)
make more sense. I think what dis1 and dis2 (which I'll rename to
matches1, matches2) was doing is setting a state value based on the
question "How many times does this line in file 1 show up in file 2,
and vice versa". My guess is that if the line in file 1 doesn't show
up in file 2 then it's obviously different. But if the number of
matches is greater than some threshold and isn't minimal then TOO_MANY
otherwise set it to SOME. So I think dis1, dis2 are meant as "Here is
how we deal with the number of matches found in the other file."

Is this explanation congruent with the classic diff (myers/minimal)?
