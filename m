Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273816A959
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434533; cv=none; b=f5/y11aCvZqRpiaYPa09BWbJNiX+d745455yldR3xVweVBK00aqtg2mlj/usu1nG6TVJcrVxVWyNOiVdPCZMO79DVTtY7ZwVNudyKjKlCUtFDOnUEBnoRLE3PolpEUSPPjXqRHQNEKjjUaV28N94rQZHkTH0HyIh0lhS/5nSQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434533; c=relaxed/simple;
	bh=mxR1ywrfMk0XeJDb7r4+bf57rZly/uGbIb1cUCX+pjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgIT3rI6GgGAsr9MG266iKZMgY68JZ+XTzaYo5cRCFyJnJTBkurq3hvpfZtK8f9gk5pl20cz0h9jkJHKh0L1ZLQ5XNdJGsP7CTghExIYHOjDWxGq/3E8AfIuFhtATUglKuq2tIoPTLYVyR7qDJAQoz9CboWLxVZH1SZLcN58RHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rf0px8JS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf0px8JS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725ee27e905so6611051b3a.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 03:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734434529; x=1735039329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh/8HTV0BoW6Y4sqqENjuX9dWHG+clI49nCz9LAE9+0=;
        b=Rf0px8JSNO87hqtfZ7qVXbgPIP9fwg27zZ3qXCbmyG20YqcIRhGp00SbWl40ILDRJm
         SfrdyRT0UQK6mLwFzZanZutLxVDjYwqB4endIJk+aC7tAN8iHQYR36m8nLJxl/iKGTJV
         VHJXgPKhB8i+dIeL49p7g0H50eODfhnOtm9X/Fvb7YqFoT3IRFf2q04XHR0c1Umpq5cV
         9U/aXusl2hogCsICyqdjUYhYujRyNV1XL8mUpgNgVTDYIhSKweMemPft++RfouIJ8Hs6
         dUv/gZycoyq1jlr+U6gtRDNN0cqIuDydxOwqy+4b5bn9wqWba9eAlZSKWNFm/v69LM+0
         aGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434529; x=1735039329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh/8HTV0BoW6Y4sqqENjuX9dWHG+clI49nCz9LAE9+0=;
        b=M9rCdcMbB1MW2AG6F5V0BYlOKoDr3CtLsUMAydSiFMmZtpe8Gb/uCuSEYJRkvydnUw
         JO4FeupGNrt5oBN4dmpkvm/SbopdPk5bxG7DEtkYGV7kmwOEq7xd69xc9+zF8Fms0bWD
         rZLA0Z1VVv9eY7nnY6oc5Byig22dXOTCVNrrPLCf+qLMRpYNRocMOJ5TXFB7j43230uQ
         yO4HO4PuraxXRgiJ3/BvWdgNgFaUihZ6ctBqo/VbkB++1N3dyM/OuZAeJx0OZQyuY8Mc
         vbRj0b+DiaqS5GtCOd0lhSpeRvZ7Nh66YrL8GxQTVqeFYaiVBmlpudvTTlyZuE9rwRRP
         HL6w==
X-Forwarded-Encrypted: i=1; AJvYcCUQg2bjdH2GimDhwyw0o+SogzXuWhEFJKS550Hva+8KTL7LtRSO18080sMBtYFvdjrdYr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMrbc3oh6EzzrsbKL+XyJ2DzuZC3H2pKAKnKUMEx7sVbAdvCc
	B81m3+d3ILQHeNdX6bi6cz3Z34yI59PIpdf3crhOZrm6bPH5vEGFnZnwAWgJgCXIaLyAeFxg55I
	074EKjnVmCTcgw94h77a7tEFIm1Q=
X-Gm-Gg: ASbGncuIxd8rSUbuUOtF9ApSC37xEbDuXDyfF6FMm1PiG5JbEUq4z3md/ATcjNWfjpK
	wNPNtO3t5ER8Dsf03dx/nTvz3GiKIKiFA+Vo=
X-Google-Smtp-Source: AGHT+IE9QJdVzsp8YW+f1mzQpuItKV05wmCmVaquY85Tuna52x+IB8zL+lSUGOclY0p9/7RKCDgN3kXtYd1mnE41xv0=
X-Received: by 2002:a17:90b:164c:b0:2ee:8c98:a965 with SMTP id
 98e67ed59e1d1-2f2901b809bmr20922257a91.34.1734434529035; Tue, 17 Dec 2024
 03:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
 <Z2Emh42DJkHFGWq7@pks.im> <xmqqcyhq3ge7.fsf@gitster.g>
In-Reply-To: <xmqqcyhq3ge7.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Tue, 17 Dec 2024 16:51:32 +0530
Message-ID: <CAG=Um+1NwB=ymwg+oM62f_W8G=3Gt14UFGe+S2MM3gTOdUcuHg@mail.gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 1:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > If we want to have such a feature I'd thus claim that it would be most
> > sensible to make it opt-in rather than opt-out. I wouldn't want to be
> > surprised by remote refs vanishing after going to bed, but may be okay
> > with it when I explicitly ask for it.
> >
> > At that point one has to raise the question whether it is still all tha=
t
> > useful compared to running `git remote prune` manually every now and
> > then. Mostly because explicitly configuring maintenance is probably
> > something that only power users would do, and those power users would
> > likely know to prune manually.
>
> I am 100% in agreement with your reasoning.  If this thing is to
> exist, it has to be opt-in.  We also need to add ample warning why
> doing this asynchronously behind user's back while the user could be
> working in the same repository is prone to cause surprises in the
> documentation in big red letters.
>
> I however am OK with the idea of having it as an optional "task"
> that is disabled by default in "git maintenance".  "git maintenance"
> can be viewed as a platform-neutral way to set up scheduled tasks.
>
> A user may be a Git expert who knows what `git remote prune` does,
> and understands and accepts the risk of confusion doing so without
> explicit "do it now" from the end-user, but may not be a Linux or a
> macOS or a Windows expert to know how to write crontab or its
> equivalents on various schemes to define scheduled tasks.
>
> Thanks.

Thanks for sharing your thoughts here. For some context =E2=80=94 I current=
ly
look after git performance for a very large repository (60k+ refs)
with a lot of active developers.
I've observed that while power git users keep their repository tidy
even without runnining maintenance, the majority of users infact don't
know (or execute these), and
run into performance issues. Easier fleet management was perhaps was
one of the motivations behind adding this to `git-maintenance`.

While its pretty rare that someone relies on a `refs/remote/*`
reference (without creating a local copy of it in `refs/heads`), I can
see why it can be surprising and an opt-in
should be okay for me.

Thanks,
Shubham K
