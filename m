Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D8192B71
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737361209; cv=none; b=a2O5w3wfm098A3+pUpn4i2bxduL1as7ficIhD3fYs/0a4jEs+5ubx6ZCS72ieN08V4c/SAaRkiATP1f1s0u64EO2ZSdFltovQaX1836ytNmbrAnP7+lPDXmjZEKiuappnEkuoGt8Xi185DfmJP49meKwVQVY8jImZD/ZeV5Bp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737361209; c=relaxed/simple;
	bh=dOQ88rBLfnqbFu2WoFQSbgS5ZAInm9hIAapsHYMwWtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8+4SD4ouB0gbflaTZb8mFf9krZ5jKCzaDNq0bVbCAqDfAi4t2hSy1n5zi7thU+oMlU6ycImv+F6noNNfh/iLsbbMje0GNK1ALl6T6ubcnb+lLYDuvondfLRAiUFOehsIUmPVEotKYMEgo28RoOU7wuIgTVM1PytynV6dvK6Bn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKhnTLNA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKhnTLNA"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5da135d3162so7115446a12.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 00:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737361206; x=1737966006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOQ88rBLfnqbFu2WoFQSbgS5ZAInm9hIAapsHYMwWtY=;
        b=BKhnTLNAriKJ8Qs5HRu6hUk95uf96pPP+TGILInST6Nwne1eM8efDJYpsiyMf18yI1
         Rm6YplpYElSJZUWxRr5QqfvKzONyZ/fFmdHZx4yLFalvf3FC68PtGYrx7b/kyDF6+0w9
         PtyGCM52xZHGi4cQNFokAs8xaEOwkMkK7nED1cczbnCbOpjlGWJ652fPTpZ57DvNhx0E
         byY6Vy+JGCkkZjtCIk5UUBx5SOs9GxEVlCF+2cKCezYQp5Qyhqm4Ke4+/x39+mzEZr8H
         Krod5cVQeWh/zhUoIi8MqdDTLSzmi3L7j6yC8NeSIdrOmqtdJ2NlS7ZuqIB9f+P2l6Px
         KCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737361206; x=1737966006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOQ88rBLfnqbFu2WoFQSbgS5ZAInm9hIAapsHYMwWtY=;
        b=SCKSM5ECABlWPxqVCkg9WxtMbYX7AgYplrlEL25ClnwOMiNYqZmzkfq5umUsN9dzRE
         cqsuAJ+PJE8BjHHzXNmdZrf0btNIZTkponUM8wsDQmliTGNzXKtvzIM4HNRUGqfIXNOx
         yEZH8B5wJGuoOBFl2psyJva0zCa4aVMAVjr7cslapckj9AxBHLuSD9xtIMFcdM4mtZVp
         iAn6H3JmqZmsKPyd/k7Mtlp4G9SvVSlBnPRcTzGO5JYdw5fG5Bv3cO2jYZ6rq3w1T+ay
         dj+vgTL2TZN+02eXtpZSXdwbGWSGFWFm66EeLcEN26v2FEaRd3mjJJLtKzBJsl8Y8ku9
         EL4g==
X-Gm-Message-State: AOJu0YzZ69TvAytWKI5ZFRUmqoudVxF4AlKZgudosi86Dv+YRG1TieBj
	6HWGCCzOPUHXGeSSY1zuNwqrFEC4YUfF3bzheGj/BEmWve0L0hC4cTtXysRePArLitGITNMq2rN
	6NdZHIZvJd11M0FIxGzqxpluKfdU=
X-Gm-Gg: ASbGncvHupav3r/QGdzteenjWkoxiIw3w7SKFWRUDqVyes0S85uJXiZ+t7DIIk1rNRq
	7t+YRMb8Y1dsF4HoP1hQ+H0N1Pe0XLaZ7G6LMpQ3kTnOXtJREIARyyQ==
X-Google-Smtp-Source: AGHT+IFS5FvVduWhJD8/1/LE2eaXALUQia15Wr5E4D93ptqh2115sIKnm5JIT3CZugL+7zy2dku1kvxJ0mzks/YpWB0=
X-Received: by 2002:a05:6402:849:b0:5d4:75b:8ced with SMTP id
 4fb4d7f45d1cf-5db7db2c371mr10302259a12.32.1737361205882; Mon, 20 Jan 2025
 00:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
In-Reply-To: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 20 Jan 2025 09:19:53 +0100
X-Gm-Features: AbW1kvbvqJHnHxmmvocnKa880ViWuWcoQmDvOaXz5zcZNq3nx6A70YNNFH9T2WU
Message-ID: <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 19, 2025 at 11:13=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hello everyone,
>
> It is that time of year. GSoC Org Applications for 2025 are open now[1].
> They are due before Tuesday, February 11 at 1800 UTC. It's good to see
> that few contributors have already started working on microprojects this
> year :-)
>
> I could help as an Org Admin like previous years. I prefer not to
> volunteer as a mentor this time owing to other commitments, though.

Thanks for volunteering as an Org Admin and for this message!

> There are no noticeable changes to the program this year.
>
> The GSoC contributor application period is March 24 - April 8, so
> (co-)mentors and org admins are already welcome to volunteer.

I am happy to mentor and to be Org Admin this year again.

> As usual,
> we also need project ideas to refresh our idea page from last year
> (https://git.github.io/SoC-2024-Ideas/). Feel free to share your
> thoughts and discuss. It would be great if we could come up with a good
> mix of small, medium and large projects.

It might be nice if we could refresh our microproject idea list too.
Maybe we could add ideas related to removing the_repository or
compiling with -Wsign-compare?

> Do feel free to ask if there's anything that needs to be clarified.
>
> Just like previous year, there will be a GSoC Meetup in Brussels during
> FOSDEM weekend on Saturday, February 1st in the evening. If you are
> around, interested and haven't received the link to register directly
> from Google, let me know so I can send it to you.

Yeah, there might also be a GSoC Meetup in Madrid, Spain on Wednesday,
January 29th. People interested should let us know so we can send them
a link to an interest form they would have to complete.

Best,
Christian.
