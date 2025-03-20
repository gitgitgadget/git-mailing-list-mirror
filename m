Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A163597C
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487124; cv=none; b=j3ErZzusVg5vxV7Bw4JkK3TRtuq4OgA+z+G+O2hzkOB0xaW8PnLtVR/GYW3C21HXzHFUi2qdD1vQo1Fb0mi30cp4y7Pffc92b0poD/XBPMLjuTv6O17NauGyaQhlvICBGczcgnv1eM2O+yN0sECESwPu6c5zIghDAn5d1EcT6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487124; c=relaxed/simple;
	bh=Qmm7803SCPAhJlm2Sdv9ktidl52AjN9laEJXWbRzgSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROHHauhbtr41LRWSPex+d6QOPVr/ceEwL4h7n7PZTx/tkOo31DGuUTYiWLtGgALz5TrxAH/sdd9Q2Fig3L4Hu9TO8Olcg/KMTXTG7SIrJ1SFRwY5lpmAXmudfDAhz4USKDmpNGJHIMNg6vcZn7H9JozIKtmXU+k3+kOMIO3QvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHA/MqwZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHA/MqwZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso1359181a91.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742487122; x=1743091922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCV+SQm0D31bKQIfjCtTdytAjyFIinY4LjBiakMzUrY=;
        b=ZHA/MqwZalnFpTZK49FDApqEfWvcpZphkrNlsIDxy5xKG6iQU4zkpSXJ5muLcWngSq
         +m74/3/Guj7k65QQxVyV5r0Xix+H0yw1OPeBa0uMb64Vz2TYwH3qs79Jt8b20ydN+W7d
         NXzWQogxVNuDZyV+wTwOp/qWWa9nviZ/eRs0ZVPqrz45isJUT1AuhMjZyMoOp0qJtpjU
         iiAQlVI07tWlisd1sifQ5SsiGYD0O9DGOQXrXoNFyqxJpsrlFdAJC5WBkhoZrWg6HlJ/
         y2uiu8bOSYUST8siVuLaxlfXgem1Mm3BpJM243CoD+nhciwc4MnNh4a+ZXibBbgusiti
         tI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487122; x=1743091922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCV+SQm0D31bKQIfjCtTdytAjyFIinY4LjBiakMzUrY=;
        b=mRPEy8PrJbJLsraotNgeRbJ2UWf1aRoIKdKvg/UeMHHK+WsDBK7DMlLms/XwrQEIuH
         REAyUMFtqvesfM0GnHuAVtYwvYAcp7j3vCvObaSBtG8CnzK3wB2cQVvnwVvH3v4NfGAx
         kA7tQ1C0JabfHDOVbuUSR/VgrBFXFfeIri6biHTT2T/TPGUD7w8lWvwL5mpM0mzjtx8T
         gjW4vC7qvBvRiUZtTrNJqnYndfEjZl7HtmYi1mLhvCbSgIixc7y9XPI8SQoi3b76T63a
         +SPfQafSk4zYuwtQwnVP94bvAsj1TB5SGR8mIZE72O6YsNb498+hx6ez7C5hjm7T2OXC
         aOQQ==
X-Gm-Message-State: AOJu0YwszXO6I8Nm6btwY9HhaZLdDA0DFytee+NUvBDw6ZnkmXLctPBu
	4KOqH2Ds2GjoxO3s/+s3IrrUFGGqk1CdahbfDEJKxWk3wFa4CqA6/slLAFYbrEsdTdR/fdhoF2X
	XQw8eMNyMSQeFSRXMBBWpf/4icfPDDw==
X-Gm-Gg: ASbGncvzuMjryzjwSwG73A82lTZN/F2B/zyiWI/ieVIpACBnM+kqxMrbcnyMvXpIDsl
	9DFnDpJn38R2tHR7shSQhk9EfG+Cn2TBwsjASxdjzIKztICSpQqQIZvl0aHZ3xFrm2F2Nrsnhgb
	yK6ohxgvyJvCBfzLx6ZzyLvNVPKeJo
X-Google-Smtp-Source: AGHT+IGloWvD9CUnywgS7zIotIFAE/2B0ZVpp7m+x6mU47LbvW4m/vmdlDrOPgfi7JJD4On5ambzQT80DB1m/hKu4YE=
X-Received: by 2002:a17:90a:e7ca:b0:2fe:ac91:4667 with SMTP id
 98e67ed59e1d1-301be21fe92mr10437881a91.29.1742487122310; Thu, 20 Mar 2025
 09:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742367347.git.martin.agren@gmail.com> <e34ae37982e76179aee780c70b48aaaf959a307b.1742367347.git.martin.agren@gmail.com>
 <Z9vdTmVbIJLa9PGO@pks.im>
In-Reply-To: <Z9vdTmVbIJLa9PGO@pks.im>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 20 Mar 2025 17:11:31 +0100
X-Gm-Features: AQ5f1JqWF31cWCqQ-2sHnQ9IH_2BT3EfLXx4waSRDytmILTCRx-KcvBUJQOqwko
Message-ID: <CAN0heSovtPNpyHEUC8m48zyJkRxGQNwp5u6x=WDMdd+aNJnwjw@mail.gmail.com>
Subject: Re: [PATCH 5/8] pretty: after padding, reset padding info
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Mar 2025 at 10:18, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Mar 19, 2025 at 08:23:38AM +0100, Martin =C3=85gren wrote:

> Yeah, I agree. It's very surprising that we retain only a subset of
> state, and that does feel like a bug to me.
>
> >       c->pad.flush_type =3D no_flush;
> > +     c->pad.truncate =3D trunc_none;
> > +     c->pad.padding =3D 0;
> >       return total_consumed;
> >  }
>
> This is using the same default values now as you started to use in the
> preceding commit. It might make sense to introduce a macro or function
> to initialize the structure so that we don't duplicate initialization.

Good point. I'll make the preceding commit use a new
`padding_args_clear()`, then reuse it here.

BTW, we rely on initializing the struct with all-zeroes to put it in
this cleared state. Which is true, since the "none"/"no" enum members
are indeed zero. That's not explicit though. I'm thinking of adding a
preparatory patch to make `no_flush` and `trunc_none` be explicitly
zero, and see if there are other such enum values in this file.


Martin
