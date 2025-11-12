Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AD3C465
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974828; cv=none; b=h0UfNwB6pTSFJbA1te2UXT4Bq0Zfxt+EI1NfYbTKcO6h7d0zXZ+wBfikQJpC6bYC/fbPrh5mvmRdH+cSS4skfiG3+vsMB9T3x+suwQ4MnngILLZJD9gb88fUELC2F/ocU7IoUszfWNNo5UJuJh5Qf6daDEcOpdVhutuSDF8iXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974828; c=relaxed/simple;
	bh=B+phqC6OF63JWq4xvc8g8NDT/mp8pEZcnx+NhPZ5G5I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FZLBqqjSp0P1wBFYOGbnatzpnRYLlgUPoYQcWLkjFQeIa/4YOc/Q534d3GeNM+yjymYIDIF5hLpVRs1PE7DIun5gO4i16vNMyfQk4s6QzXonPi55vx9+BaHNajDOTeN9vzZNo4Hfh++ZOK7OxHW+In5TRAUyxDc4KH6ZrpC5bYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6miW0mJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6miW0mJ"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594476f218fso893304e87.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 11:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762974824; x=1763579624; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Le8DLrUN6MGSUwEzlgN9R6HVaUlJla0W334TqIFMHW4=;
        b=X6miW0mJXpEBby+q9X5bBAd2zMLygKj/XFvTyjR8EUah61YJBwhwwPWOkYrN9FZ1d0
         DUVoSA6FkV4UrXSHUUtWqQMg1qCHlbrAabGULr2ie5TfF5FO80XSW9llUeA2qca2Y0Zi
         OOo2IGFsW2Pumm542/4wHF1EsyMXLBHqO0tCqc9Wg5SvJ1zgOPs128ybf+6R9z+ZXHSR
         kWdEWHC1QcEQTeoMIs9zC/M2zR3LkCbhsI18VDrXU/EuKRdvAWDHyQtDfaqvsu5BPuwU
         jzMwvc70FBoPyvdnsxAIX1S+YpIemkApvm9tkle/NhWFsy3hXQjmHk3zpgvtKWq3BXED
         mb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762974824; x=1763579624;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Le8DLrUN6MGSUwEzlgN9R6HVaUlJla0W334TqIFMHW4=;
        b=iqww9foFE5uuQPzMjmcX4y+7kXi4WtN5PgQzvlPMqKoetophIrHfQUGzA4KNjmhlA1
         c5q5TSZYfSowiAIi9g1cAM+xzI5/+JHg0CHHFIYw74b/wiJ7DBa7DdB9D9X2U2CCUU2h
         T8b5Hl0IgCPh4MSyFIfEHUgizpLDvE5QfAa1Uw9WMZsPjWroXUHGyiYTbiqkuRSHQBI+
         Bsqx0Rbfb0uHqbzZ5Et5ZcFiwaM1Yuq/b2Gs+jpnjVY4TicZJb8hJcc4Lu4U/DooWFWE
         eahtBjg+6pUxeb9UjN1RElqBLVSZABtRa+OKxDj2aySJze2LYDZmdS5eTMXhMFk0ljVf
         x80Q==
X-Gm-Message-State: AOJu0YwUGd8t99Uf1V79I58uZ+NtIoYjF0jdILOIt6dbJtybgcyc2NVD
	4UTAkGp203wopQSVAqVyG9UWrFxryKl4c4l3bgUnqLUSiC7EJnYW8n4r
X-Gm-Gg: ASbGnct5Y9G5SVE/Xs2W28OX47pvFjQYamAdG5IUUd8hMJy2rEJavMecTT631mRGALV
	JPQHBoJgu1W2MudHULNO89Oo1MwQVcai43g3yiB0gZBZkkQHTr76hwF+amRdF1l2QiqSI8SDrdl
	BE6LfoFU+tlrAaVuUYgA7cwqGk72JUzjdOYt5Xh2/Xb29I/FQL+wQMIJnfGxKUS55PldHGuUWCJ
	ROyaroKE1joW4wxBrawBnJZaK8FbmFgEe+qUS7HPxAylvA1DMsjyJfcfM0+Mu/UoSG0s5pltooj
	ClyN4gp99KjXB9Ttm4j6tXGLrXtfrtTNlmYGBVeAaS2z2QU23OE1qB1AVQ+FZxpElqlFj2MPO4o
	t/k41ICqS62QUUgedXl5tQ+6Vy0l7ak8E2ekD0wCf2hDosxw8LyNWk/OTen0EULJFj72Mwo01XT
	ZlCOo=
X-Google-Smtp-Source: AGHT+IGLJ6gR9DU4Hr7bmzWFM3ntQqFOddiCesntm2Dk2PPWg+HbSTWvaEoyy1Y/TxfZkxZY50BqQw==
X-Received: by 2002:a05:6512:114e:b0:594:49ed:3cf1 with SMTP id 2adb3069b0e04-59576e02b22mr1775633e87.10.1762974824173;
        Wed, 12 Nov 2025 11:13:44 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a5a0b7esm6077606e87.109.2025.11.12.11.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:13:43 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Junio C
 Hamano <gitster@pobox.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
Date: Wed, 12 Nov 2025 22:13:42 +0300
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
	(Patrick Steinhardt's message of "Mon, 27 Oct 2025 12:33:48 +0100")
Message-ID: <87tsyzm5cp.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Patrick,

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> over recent months I've been playing around with Jujutsu quite
> frequently. While I still prefer using Git, there's been a couple
> features in it that I really like and that I'd like to have in Git, as
> well.

[disclaimer: I didn't follow all the discussions closely enough, so
excuse me if these things below have been already addressed]

Are you aware of 'git revise', I wonder?

https://github.com/mystor/git-revise

In particular, its 

 git revise --interactive --edit

feature helps a lot in massive editing of commit messages. It creates
single file with all the commit messages (similar to todo list), and
then applies all the changes you make to the file as it revises
particular commits. Very handy.

It'd be nice to have something like this in the mainstream Git.

BTW, it has commit split feature as well, though I didn't use it myself.

Thanks,
-- Sergey Organov
