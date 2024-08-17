Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D528005B
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723880000; cv=none; b=pL/weqg74WHpYPe+2ZERJLoiJi/XVwTMysy1Vq8TgicbLmU+AtKojq6/ViuvcgEgBcXmme/nlUkp//hpRNV+Q27cvr+hqTtxmlQJsSqfWhYQ4FAkoAzn1GIPULOT7EOmB+clYzUIbU3rIsSn6Ks48zcHZyQdDbBgSlbOTYbZUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723880000; c=relaxed/simple;
	bh=L6KF23yqESjhHGDIueUEi5P4oEqkbJ8fY5cy9cJisFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqjyD/g4XSwDi5k8J/ttWfn8aEWS5e2BSMcTjmyML3aUinc2dBeR33bCk0h935biuH8pf3CFxf0t+MeHwhlJQ/9rjj6hGqdPGXcCCBTrOZ66QaBUzugmvdljQhEx7pc4YPvfjWzi3X2uYbdCpc1b1byvP87dH7NdLoGkixP86ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf7707dbb6so18310566d6.0
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 00:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723879997; x=1724484797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6KF23yqESjhHGDIueUEi5P4oEqkbJ8fY5cy9cJisFU=;
        b=L/J228MRukSrqOIkXYSHX1UfeKzYrUblR/3+Z9oqHKmlQZ5Gi75FcB3DQjWcDy+mQv
         Ar95S0X8+BWa+O3+ShAYN41FGRasnX5jSOC9RSZHVNIeOeF3QejEJoqgU6MDL2waQMcy
         ZJmUczdTCGvCQpzFvHJdlO0gdX9Fuk6kB5NTOrbIMalxooWQlqgOL+SIAy3aTl2RlYDV
         x0tPbxZEnSETAJ4MSCd1F4X3UhL/0zEyKjEXl/TJ6qsIgWKN0H7bwIsGXdr1vnyBvGI6
         ogZNBunm8y+AD2qeSoOYV0YiMp4D0lsPWW/zXWByKH1h88dzgXUbEHdM6Hyjkq6xXR9u
         77UA==
X-Gm-Message-State: AOJu0YwbwBIa0p8uc0RJvRtr9a1CvcVsYWe7Ae9pSaJigFKSsbJvOY6U
	kdLhJQvOSPvonLz9UEmTu5K7eRy6Jsz9HWz2wC1DRSfaTRTnaFMfyPJ38dQKoBOWC+V6FxcL9J4
	aStBEQrqF4ljbuo/d8jMTMHPBq9s=
X-Google-Smtp-Source: AGHT+IE24CUps5v4cDix1pYAGNzRwYXw9yk+xgmToIQ9omKaM5sugzgSZ7MQavL+Bjo7qkDREpORZAkH8vhIzPCUZFY=
X-Received: by 2002:a05:6214:5001:b0:6b5:1d2f:1d3 with SMTP id
 6a1803df08f44-6bf6da5e665mr156386206d6.0.1723879997418; Sat, 17 Aug 2024
 00:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817072621.GA1535666@coredump.intra.peff.net> <20240817072653.GB1535915@coredump.intra.peff.net>
In-Reply-To: <20240817072653.GB1535915@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 17 Aug 2024 03:33:06 -0400
Message-ID: <CAPig+cRgJkXxESSL4h+LO5FKcxKf6pt5VBWpjfUAZrrB5b0Kww@mail.gmail.com>
Subject: Re: [PATCH 2/5] pack-bitmap: load writer config from repository parameter
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 3:27=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> In bitmap_writer_init(), we take a repository parameter but ever look at

s/ever/never/

> it. Most of the initialization here is independent of the repository,
> but we do load some config. So let's pass the repo we get down to
> load_pseudo_merges_from_config(), which in turn can use repo_config(),
> rather than depending on the_repository via git_config().
>
> The outcome is the same, since all callers pass in the_repository
> anyway. But it takes us a step closer to getting rid of the global, and
> as a bonus it silences an unused parameter warning.
>
> Signed-off-by: Jeff King <peff@peff.net>
