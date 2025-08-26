Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67ED17A303
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212929; cv=none; b=RaRBK8b24Sqphqz2GBa8OgmgrzuWmdM3WAd/CTEzTQC+ovHy2JuQ7qHYXzaQ0NJ/jZmAxtoR6OZ9xSQBU6RmiFV+tYJ3EFKXHCfR/5GBPKUq2hGlSLs1bRduRINyFJN3oTOH4j7j2Jibg69oq+0Ogu+hUHy5f4qle9mBCS/F5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212929; c=relaxed/simple;
	bh=r8ReVI/51FCVpL/h8OXh93CFBbwDqFDOvfokAPgIWsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=im9pf+/qk4DZHMzCErcPyv/vQIKewLQF9pXD5uTVXnK3IwsjwBzp9yCRtyApzNdomKcemHDk52D9gQcvB3BJGCZLZyJRnKH6uVYT2Oqmdtav1mR9PdM6jtZEGT74IqlTdrWO03T5dY1aq5+HjJsAHsnl5+vDiOcc/7vHYg6OqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IASVqdss; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IASVqdss"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afe6fe7c89bso370447066b.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756212926; x=1756817726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ThQtpoiwYPseBbjXwV+Hixhgri2+WpMnjZjtzVIIQY=;
        b=IASVqdssDzHBJO00+cNBddjm8nmscxg3O9+7XCwtDM+2Lr93iOIFazTelb0nexQRR9
         oePG4z0PWDxl7x7GVoF6XFqWifKj8nXUvA8ugGXMEgbxCZAJlUduorVPyA9zEXnLbGQw
         oXIddm3jQ8oFEH/76s1JFWvARvHr8rAnO0tHXFHGlFvgO/SQGPXmdBWMNQWSLU1Z+qFY
         I32V3Q5NhunAFPSM/AOULkFhfVo8izoG/pMXlRSYDkZQ0mmJWx/v+FMh3bT/yOVFNaIH
         bYfdzzvIz91sDdUPjNJKmtlgbjNYW2ZY2MgywKURBC5M3Rn7jJoE1xICUiH4M9Xk1GQJ
         XHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212926; x=1756817726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ThQtpoiwYPseBbjXwV+Hixhgri2+WpMnjZjtzVIIQY=;
        b=BDAlyPkGXbg2mlCVQKaewhrvu8MThKpNGQ7Ne+gvEX5i6NA2VMhK56KH1gnQ/yS413
         wI13tYDwN9Pmb/3GtkUr2wH9LZY7MWy2s4dYxashKhrzdbUk5CfjQ3R0P8YCObd6zk6D
         Kr2FACBTFTCs1pnJTRwQf3lhQ9LQ4ZZw0pAFDkH75/fU7vnfpBj2pk1AaevUqkKUgaoW
         qWcswok57Yv3Lh7FK/QA/oi+PShtJYZ1b9JdLUUEb280ArVGye/PNcqVpqhQIXiR7r9h
         RIONf4TrknjCcGuB7+7RfzYtyLTLHDL9kUnXl2C9rlzXLCYsY9MaXTp/8pay5i7FglDF
         migA==
X-Gm-Message-State: AOJu0YzNpT3vKYnNRXnoc+9EASL2IxeZ+uTesAIqjmDmWBhHIGi08xgv
	4yZAmZtyUhex0rLuWYAFYZ7gvJlN5L+jR24UkW36smndAZmOxUK+V8nqk6mEfItRwLLZ74Z1GGw
	IPSa8x9fsc5XeJYjlSY4sAjrYNaUsEUg=
X-Gm-Gg: ASbGnctiVxxVQQIZp2V7Q0yMVTte+MmKHG5aigeDrAyV9k7nXRwSH2VRw0avvgkFT8C
	KRbRC9EQkiTH0jkeeSqDJG6l6g+jP4LWfxoiDnnQTCcAHtVGjCdDXvv87ZrUy4xox4q8ivzlUim
	4a+Owjc4vgyo1Vfw9+TdC80AQReYWBCz8mBdAI6sjvwEqorIH2GkkXRAVdQ9Cthwymq0aoz4dms
	7Ppovmh5nQj9kKKdKPKewF7VvTuoYFA6VIAsRIzvUGpJSqSpnNs
X-Google-Smtp-Source: AGHT+IGtAsJ8SeDl/DvP+mco/3dJf0TCKlSriZ8hZvR4vj203ymvGqOMsESFqWJ8Ajv0hvD8+BfOtTW4FPHutuNw8Mc=
X-Received: by 2002:a17:906:c104:b0:afe:82d3:4499 with SMTP id
 a640c23a62f3a-afeafec64c5mr139110066b.25.1756212926022; Tue, 26 Aug 2025
 05:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im> <20250824-b4-pks-history-builtin-v2-3-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-3-964ac12f65bd@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 26 Aug 2025 08:55:13 -0400
X-Gm-Features: Ac12FXzakNfIjUhGs0AqclKlByY4024L_jsAm9e2q8LzW20p_KfjMb_zM4HjSmA
Message-ID: <CALnO6CBgGNdD7eRsseXVmTCkfi9TU6S46MckC6her0FzJNa=Wg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 03/16] sequencer: introduce new history editing mode
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 1:42=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> diff --git a/sequencer.c b/sequencer.c
> index bff181df76..898ac1a2a8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3052,17 +3087,29 @@ static int read_populate_todo(struct repository *=
r,
>                 return error(_("no commits parsed."));
>
>         if (!is_rebase_i(opts)) {
> -               enum todo_command valid =3D
> -                       opts->action =3D=3D REPLAY_PICK ? TODO_PICK : TOD=
O_REVERT;
> +               enum todo_command valid;
>                 int i;
>
> -               for (i =3D 0; i < todo_list->nr; i++)
> +               switch (opts->action) {
> +               case REPLAY_PICK:
> +               case REPLAY_HISTORY_EDIT:
> +                       valid =3D TODO_PICK;
> +                       break;
> +               default:
> +                       valid =3D TODO_REVERT;
> +                       break;
> +               }

I think I see this hunk repeated in a few places=E2=80=94maybe some
leftoverbits for a refactor?

--=20
D. Ben Knoble
