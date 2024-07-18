Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E3433BB
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721326939; cv=none; b=ViLYsGIDzUUbq5BBTn6bLlZuCNTi3f5pv/T36VYsooJd0+Vnipiq0KDsu4qCXC/dcC28KQZrzbhsx/U76gmJ1eDc569nB6ZNeq+0iD3jJ+N7FQWBYl6tDs4RMqHJ/wYtrmMz9n21dTeClcskGH8MtLZmveTGrlLdfskJRL73HIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721326939; c=relaxed/simple;
	bh=c4GmsE/yAdZZSnPGxcEtrOVU4sATEzZ3jzjpU3rlBrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyY8KiSQIXl2HrIg3yMrrJ0Zcnl1lmyjm04cgPmvH7kiEi5azGPaxCIEZPrq6WHVydHNDDaR37vZzeZ2u/JQphNoeipwlUA2IrLtUf8ko6PawZotjfeF0oHe47nNHDIlM7U0g3PK5wqHzHSMzUqOipMBgKwZ2ZfuQ1beqmZdpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zLMJKjEM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zLMJKjEM"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44e534a1fbeso33641cf.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721326936; x=1721931736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4GmsE/yAdZZSnPGxcEtrOVU4sATEzZ3jzjpU3rlBrU=;
        b=zLMJKjEM71+y9ym2OXliC+1wYJpn4nasBWpNmlX8ru0Li6BSlIAoB4wTx0dXhlHJtB
         VuUSgoZAuisPvjyYHxNGeSpsSXDpYEpI8h0/+y73bXyOawnpzdIHZE2HLiadun8cSFda
         XVyAMsB+8MsHVyc0XHtmNi9Ky0QLNed2Cz5K4lDwR4sPY5/q76fazDEZzQ5tZKUswDHx
         kuccind0hmlHcAN289cf9FMO3Mu1YuOlQ/te1XTofm90Qbs8AP/RU/PXoynk6axWIiRU
         aHltZ9+XnReZDoT4aYjFdOOio1YsbO1nQ4qteY7hXFLHhBhFnTMim+x7TGHAFsZ6OjXS
         zmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721326936; x=1721931736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4GmsE/yAdZZSnPGxcEtrOVU4sATEzZ3jzjpU3rlBrU=;
        b=ppvja3gVBRDLougddDOzdhsOrlOCwTErSwP4d3F4/tO1xkvtRtYGQ0VHYgyHv3zvmN
         P560amOkkY+kQ1pUOvuna7/NAc7HvoK6jqswaVIQEfj4uur7MStaoUgFo9Qx96EJCE3k
         1/9V2t1vN5MmxIG9PzxApQDG8c2LAjF6kAslILmbMt/cw3CWXl/kjt8Y3tjW1d6cB20+
         UY7YC5kgRQlGRskmHgxSUiKz/reC+nrEuSYtB1z0/GeP/3tngRvMLuE37aAXD+55cS5p
         DlsnVbA+k46mrveI38Zju0Kpq/gwaSBWHfd+6+KbGqAfciv7F1jt2sUS/G9Ajgl2bpLP
         4Gtw==
X-Gm-Message-State: AOJu0YyVIIvvj3k+bos1KPffcUavdo9+W231tuVxWbaDQ+gAD7g+3/T/
	PuA/bUJBO7VcbfZ+LdRJtrSTAeWCSo3lrv+xA4JvXfCiQrnrMoKiivhBDJMs9c4xPXWaVK/Pt8O
	I+EY5ckDoMQ7BNxW/QR2yvBx07kFCjhL6Wp7lWLKpXDOXYnAg+xKCBCE=
X-Google-Smtp-Source: AGHT+IHPqgFGhJLGxSf8O6mVVAPCCpgKD3P6deD0OiAaAWZOXOILbJrkj7bkwnFfOYBPEDd8RoxWW5T5N41D1aw0UuI=
X-Received: by 2002:a05:622a:1cc3:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-44f9ad59184mr321281cf.26.1721326935821; Thu, 18 Jul 2024
 11:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711232413.693444-1-emilyshaffer@google.com> <20240718173843.2411415-1-emilyshaffer@google.com>
In-Reply-To: <20240718173843.2411415-1-emilyshaffer@google.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 18 Jul 2024 11:22:03 -0700
Message-ID: <CAJoAoZk7qdDnANChseZ295RVDe9yrR75WNQDx8m5tr6MYAEB4Q@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 10:38=E2=80=AFAM Emily Shaffer <emilyshaffer@google=
.com> wrote:
>
> Supporting many platforms is only easy when we have the right tools to
> ensure that support.
>
> Teach platform maintainers how they can help us to help them, by
> explaining what kind of tooling support we would like to have, and what
> level of support becomes available as a result. Provide examples so that
> platform maintainers can see what we're asking for in practice.
>
> With this policy in place, we can make changes with stronger assurance
> that we are not breaking anybody we promised not to. Instead, we can
> feel confident that our existing testing and integration practices
> protect those who care from breakage.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>
> ---
>
> New in v3:

FYI, the asciidoctor build failed upstream. I won't have a chance to
fix it til at least the afternoon (if not tomorrow), but I'll prepare
a scissors fixup when I can, and include it into the reroll if/when
the next one is needed.

https://github.com/nasamuffin/git/actions/runs/9996112167/job/27629731071

 - Emily
