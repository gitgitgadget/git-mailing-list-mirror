Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910F3FEC
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386376; cv=none; b=KCpR7NcNlLDFYRzltmEdT+PcmO4sCj0pL7rzfIOrm1/vg/ZJJqgXpGjmbEy2ESgge3vE1c8CJpoB/aDmS70DeiFhsZm6MBywJQj8nb3JGiJHHMEXpWJkB68qCJ2hQY3tVr8mpVXzyf1w6i4NMzkq/xgvajhOelA0qHjYCzKbYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386376; c=relaxed/simple;
	bh=BlGbV1nz5A1xFxr67JBLo1KPB0v75S8hkXkt69VS7vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyj6SE/trU+XeHzBvcmTctwKrHh+1CndFyXX8NZk6ZBKjm+g8LHfkaC70X+OgfzUQRPuyycS3UDpSBEVs1LiQf07ddYQkuem1dA7V2l+nJQxkYCOwEnlMq448PCvJXbaoPG/MK/dTdDXCV8ByYhx4JxWgy/55SGhhqduQWtkOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yf0xPGO1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yf0xPGO1"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a470d7f77eeso581934166b.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711386372; x=1711991172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08NOqBLykdBy1LoiwEuyF9HpU8AEDqL7VhCGqNH415Y=;
        b=yf0xPGO1vUg+nKL0/HIadQiBVOkLyxDce6A8R6y2xRzQwmr68+5j8U5EMifLDZVneG
         HrsQG3yPnlOehlLq9YaY6LHO1fl2JWMbRYmqz5zUlXKcZsYnGFaN33oXdcuv+Oio12UM
         wt7ZqY1XrKDAq+6AMyxgF/V64fAWL6uaO8t+O7BQ6/8FBAF9cJfSDSsv1d/ACK1vUWY4
         EO/n6He38x6Wb4kwPUpO3eW5DmIhWHMFSoJy7NfdBtOZ08Jfu2yXFuCwYHUEF5lq5B4y
         AJJthmjDBz51Flx4SoNSVfZpz2NBG8rE+lMbZcbJnpQRamsyFmMA1ue2Q1f1RmLxK+vx
         9mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386372; x=1711991172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08NOqBLykdBy1LoiwEuyF9HpU8AEDqL7VhCGqNH415Y=;
        b=BiLdWrtwAjO454x3vsInC7h0IGBSTCSDYjkgA3eE+J2N6ASB4KDLqdXS+Xy8p0wTbK
         Z1di5KgfdGqeRdUvmt4S8ajye+f6egIB7a9XCS/wu49/8rrpNhz2CHRegbWZuCXOxFxV
         NqaodvUiXGluTA0EljNQHJD8A8N0AIDBBcJXQdDOIE1cM4CoikmLAlws+TG/J2A/ndCE
         cqJmslSjpqjOYsuoTxxVySAT2jPKaHPxQPgQLLOlsFCtfTi+vxQyr3RmkM63sf3QefVJ
         p+7K0OP8NL3i+CKsKYl7OU+dctzRCy8jnPT70o1hN23RH8bkm2zcJtBzmzGqOoqT4qKI
         mPnQ==
X-Gm-Message-State: AOJu0YwQ87udNpO2o/3TJCkR/1zZyyODMzHmjXpuI+yiMBC3c/phOdB7
	nv6pKZir54SRdJpULYO7hMCIU25ZnrrU99ty8mqXZm8HCcHwbM9x6yuStQsuARCwELN/zzXA/6k
	d5g1jTrRxsRFIsqFgnxJSJQ1zcHShf/SePztjBzVl0dME+O3CTQ==
X-Google-Smtp-Source: AGHT+IGAwV/iie1YXgxbgBN2LuCA+DxqtdUYYClQ1gh5/O7w/5tngq9YHig48ViDS9BYupqg3Lxny+nQA4tisfihqlI=
X-Received: by 2002:a17:907:9722:b0:a47:48b0:922e with SMTP id
 jg34-20020a170907972200b00a4748b0922emr5685702ejc.23.1711386372325; Mon, 25
 Mar 2024 10:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710840596.git.dirk@gouders.net> <cover.1711368498.git.dirk@gouders.net>
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 25 Mar 2024 10:05:55 -0700
Message-ID: <CAO_smVgb4uWZQGv9bKUEL1AGC2DXBb8xL6KeYOkvHgMCXSAhow@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:19=E2=80=AFAM Dirk Gouders <dirk@gouders.net> wro=
te:
>
> The 3rd iteration for this series.
>
> I tried to credit Kyle's suggestions for 4 and 5 with Helped-by tags and
> hope it was adequate to do so.  Actually, at least #4 was a lot more
> than a Helped-by, I would say...
> ---
> Changes in v3:
> * Reword the description in [4/5]
> * Add a missing slash in [5/5]
>
> Changes in v2:
> * Added Emily to Cc in the hope for a review
> * Remove superfluous tags from [1/5] and [3/5]
> * Replace bashism `|&` by `2>&1 |` in [5/5]
> ---
> Dirk Gouders (5):
>   MyFirstObjectWalk: use additional arg in config_fn_t
>   MyFirstObjectWalk: fix misspelled "builtins/"
>   MyFirstObjectWalk: fix filtered object walk
>   MyFirstObjectWalk: fix description for counting omitted objects
>   MyFirstObjectWalk: add stderr to pipe processing
>
>  Documentation/MyFirstObjectWalk.txt | 36 ++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> Range-diff against v2:
> -:  ---------- > 1:  0eeb4b78ac MyFirstObjectWalk: use additional arg in =
config_fn_t
> -:  ---------- > 2:  3122ae2472 MyFirstObjectWalk: fix misspelled "builti=
ns/"
> -:  ---------- > 3:  f21348ab80 MyFirstObjectWalk: fix filtered object wa=
lk

Looks good, thanks again!
