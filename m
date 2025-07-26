Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D419309E
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545773; cv=none; b=cOwu+4SQoqfZqH3T+Zg/oRkgIdq1vZV8Gk54UZRRoByV80MAIeDFgMkHXbuqgeU3WCXmJQw+FZYeC8nQBn5Acjb9ALC5TIwcTw+lcKNbN/K/xdG7nuFMq1eHWhz9NwF0zZMU4KBLkvWipqv8+TIl+fwG/1O9WJ15q/61w/kTCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545773; c=relaxed/simple;
	bh=LjW7FjYYHgr/6wncLjOhDKdAX5l/UtwVROq7wBV5XGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGRsohO6wrjOKTqrW5X9l309pSX7mvq+trv2ZjDbDq7c2PrBcqJVcDmlb87LsJHz8bMEaVIXJxpmzCQffz/wbHU4zKxI3XqVJ3qaLWZekvymrvTZqkb4QDKLF1skQBLCyv4b3UMyX/1ojZnf7F/LY3+n8wZ4tBQkELjg+s9dB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThS+qaHZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThS+qaHZ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so594127766b.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753545770; x=1754150570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNCREAr84JqHeQ9VFqyAsJTmdox1BaRMr1/vu4+yjsM=;
        b=ThS+qaHZIaFAOEP/gffrwZRFpMt9pb3teUYmXQ99VlqWYo/Mdch1jRtGtve5Vlfpdm
         dz7xWy7m2lYNsxDzNrPI5Z+wsdVyVbbiQaA4pg6E8xRk1de59t+x5JRQD5saTJgbnWfv
         Sz0T/LqyGbhju6WED9Ct5USmQqrYW+p8HbbS/mrE0j0JmblFhEdc+oYBfZnlamvgQEAP
         nlDr80J2DgU1/XuMwcmrKxAzG9AGI8nK6tHKZUVJj8efdWMpUJNjB03USHW/Si1OklMr
         qC/lJFv+yxiUfvIbvPAche9rNTBsfwusAygCubjBlgknt9wFhkdaTzcFsfzlyu/HkNJW
         6C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753545770; x=1754150570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNCREAr84JqHeQ9VFqyAsJTmdox1BaRMr1/vu4+yjsM=;
        b=CG8P9+WKnyMdnN0bXSa83bJHrbAFGR3mWNL13C6LAfMUsILnETSdu6QQfHprIsekqf
         u/cShe0sLgU2YKkh1tUDxALuDXg3u+bx2uPJWvbzmilpnFwCpJukf0s4M2rXmzqMdbAJ
         a8RBuNYDbNVXj4WIXD0wgo0xWi87wxEder4Tzs2nZ3cspALMRSFJ8QcACy30sLEpTD4t
         5OqRmU1F9YdezYSgP5Air+XYbcN0jSTVnEYHrvMBlr0mkTHP1mFwiPwiM0UYpgtH5dvP
         1nq1NCybHamA3sJye2Ze+wftcb3a3G+ULLvMvxx1AWnXsTeavM10W6C8+njci2ai3OVk
         3NAg==
X-Gm-Message-State: AOJu0YxTVkJF19AwKoM9o+5uZXvaKc9+ffN8Z/h5JseS4iC87NGEqDl3
	/ELhSHIwZQJJDUUaLRfkxy8iFmJPyvVu65H1lZ4QMq9zLWiPGN115ZEu+L6TnnodZ2GbT+Alb7X
	D5CjwzSR62VrCHymxS8nEo2ojT39f5X4=
X-Gm-Gg: ASbGncssqMnKoBuiKJBm6R1LTfE8wQ5pAJgreE9d3p3Rj16ZO3Ac9nLFS6naYQNbkSE
	GEOEb80qdYagUm1Bdsq1YDkyraV83pT34YSHUA9tI8+27ISkkqcdzJoziUrQPQq2HnV/CUVYVxa
	rrKn4nIC9f49A0+YVTxeC5+67h9dzkktHsRIjMF+RHFHPDk8rNyzyzoPAduq1XbbLtPh+4IK2S4
	mxX2KPR8JNWaJ/6km5UXMbaG68aKe7ogvJ7dOCtZA==
X-Google-Smtp-Source: AGHT+IG/xR+ldm6SZZzLVsxWNAStaA7tc2h5y6vu6oX6uz5p6zwIRDnrsYiLoYZLrCl93jyYW61/wBtRZZilNuId1e0=
X-Received: by 2002:a17:906:7315:b0:aec:4f33:e7db with SMTP id
 a640c23a62f3a-af61a0ef054mr715237166b.56.1753545770000; Sat, 26 Jul 2025
 09:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-3-usmanakinyemi202@gmail.com>
In-Reply-To: <20250721115519.140361-3-usmanakinyemi202@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Jul 2025 12:02:38 -0400
X-Gm-Features: Ac12FXydYrYEkiY7UyIT_sG9QN9vb37HeQ82uaUE3iIaoWLg8PQtxQY8wg8oI4s
Message-ID: <CALnO6CDvwbMK_GRdLOBFVdW1XZ5JTuB+Uo5JVPY3Pw_noNBYzA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] t5200: move `update-server-info -h` test from t1517
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 7:55=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> t1517 is now focused on testing subcommands outside a repository.
> Move the in-repo `-h` test for `update-server-info` to t5200,
> which covers this command.
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t1517-outside-repo.sh       | 5 -----
>  t/t5200-update-server-info.sh | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 9fcebb7d94..a1c644dffa 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -107,11 +107,6 @@ test_expect_success LIBCURL 'remote-http outside rep=
ository' '
>         test_grep "^error: remote-curl" actual
>  '
>
> -test_expect_success 'update-server-info does not crash with -h' '
> -       test_expect_code 129 git update-server-info -h >usage &&
> -       test_grep "[Uu]sage: git update-server-info " usage &&
> -'
> -
>  for cmd in $(git --list-cmds=3Dmain)
>  do
>         cmd=3D${cmd%.*} # strip .sh, .perl, etc.
> diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.s=
h
> index 8365907055..a1f129db4e 100755
> --- a/t/t5200-update-server-info.sh
> +++ b/t/t5200-update-server-info.sh
> @@ -46,4 +46,9 @@ test_expect_success 'midx does not create duplicate pac=
k entries' '
>         test_must_be_empty dups
>  '
>
> +test_expect_success 'update-server-info does not crash with -h' '
> +       test_expect_code 129 git update-server-info -h >usage &&
> +       test_grep "[Uu]sage: git update-server-info " usage &&

One other fix I needed locally: in neither the preimage nor postimage
should this have a trailing "&&"

> +'
> +
>  test_done
> --
> 2.50.0
>
>


--=20
D. Ben Knoble
