Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E974A07
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271245; cv=none; b=pKXIn+3wvPbtPLNorUwZpFSKpli3PpNVRGhh35uDPv7Hr2e+gB0fdU/aTY2y89msnNwR61dVk/AykFzVGz1bgWZlWeZ529p6TABC4mvFExNDBqy7pfQIBJ9KuQrY8voEKyhkUBGJFftv6GtkbomERndMYJQIyfImyxXLmA1GPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271245; c=relaxed/simple;
	bh=LT3an9LTtMBBYjBPUr/m/bDO7wBc2Dw4m3K5yQMmXVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdlKHBsDpApu662XQRMmaULj6F7Mns1MlWYDHkg7lYmk4Tpn+4qFMGq3qQlCCC2OYtLJl3EwwrC5WR8V8vFeqcZ8ns06FfgqILFlkXw4lHPXAo0FxA2EC+d6ruZPxeGRR+cnFDqgaZkJX0dOldN84oV7CXR0Pkn+a/D5RvA6o+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHA0O2Ob; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHA0O2Ob"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b58d26336so421545139f.2
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 21:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742271243; x=1742876043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WubeqoaUEkXN46kPLq9wD+oWt10HJN0oJmrfD2luuwY=;
        b=mHA0O2Obq4r/qG4Pifgc2LA3WeImU66+7mQaLI92Q1RY1SY3xdNP7KgKbOr9nxQUeM
         0FUHD/o0pRV5eQ7z35ALQK8JEUEtYyn3DP4ELxvLLP7lNGH1hMSJb/9L1TTQKndgIrqn
         go6HPVOUTPy3r1Qq9xPnNJOgl9SltYhK3/g7KBw849SyXrdBJ+rIYJK82Zmcmc1LUu0F
         IRpmleDH5v4KXrBtgiBMyAl7AVORd6rPgEExRMbBetfePR+5dVg4ZiXSPR7d7zYv2klY
         VcxCvR42tXRSypavxxVIx1jQiqRd30dB1x1BmPKfR6kCp79ZE6W+d553+MxxaDhA9o4z
         hc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271243; x=1742876043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WubeqoaUEkXN46kPLq9wD+oWt10HJN0oJmrfD2luuwY=;
        b=Yv4E1nFhi0FKIIMc4AvHg/if+kZsXXgFun/tSYKvj0zZGcsRHQLum8kh2Izzl8IvDn
         jKQevaOjPI4L7QXwFj09o82A2vpffO2dv9MFzKm4VJFU8S1kTMNwMY6S5wBk5eGpbylA
         RkV5lCqBuWJjngTsdFID7zlnvLRk3N3VETRHuvxwl1elFL7Ik6jTo5JutuHvIszsV5t5
         SvrIQBkWmkqucbfdh5cAfTVitxvtjjMQCEQLSP7TVnSM5iR4DObM9UFg3nKzfaWq91wW
         zp4PA7tDf3kbCH5ibRHk0kEwWwsJOXLHYOsGy5cujvGD0d0IvXSxju89IU0DWfCOmX8R
         Rbqw==
X-Gm-Message-State: AOJu0Yw+xYpa4K2O7+akQoJb1CurUK9icp50yAi2rbJD1OdMjxZVcFaY
	Rvuf+jTYhqyGwfLqjYLVm6WeTqPqLngKelo71RHd6NUbvhaIQDPip7JjnkSjbDPl8XN/+LT1KdG
	qI4aR6n62HMiz0qM69otBWjONok0=
X-Gm-Gg: ASbGncv6HYhmGUQvSVJeRDWZM+4j/817wdJjcRGVlhv6/prpUHlj7I72CEFG3LehyqN
	g8qlYt3lEV+Z1bOptGifwafuQtA3hCyP2OABYAOk8En3JYQ5EBw2SlavpNoHsFCWnYQKgHkD669
	wKHuHSsP0zQR9e9s2KytwDL4fZVAEmYut/+7eNg1BT0Ie35xQUGMWbM5Stwuk=
X-Google-Smtp-Source: AGHT+IEnRlx82HsC9oqKHW/Dq2YXatfPE/LCBCJFD0jq8JZarRRiHTdKxSePzPK6zGUXzaT0LmV1w7sxyAIg/FCscI4=
X-Received: by 2002:a05:6602:15d6:b0:85b:43a3:66ad with SMTP id
 ca18e2360f4ac-85dc4816288mr1729954239f.8.1742271243335; Mon, 17 Mar 2025
 21:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723755667.git.me@ttaylorr.com> <cover.1741983492.git.me@ttaylorr.com>
 <14d3d80c3d301233048004fe9de18154aa597782.1741983492.git.me@ttaylorr.com>
In-Reply-To: <14d3d80c3d301233048004fe9de18154aa597782.1741983492.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Mar 2025 21:13:52 -0700
X-Gm-Features: AQ5f1JoAnrt4jPEURwdk8Yla2aDqeIi2oUFIZhYFEeUK8ac2h6T3MG6qvHDBuUo
Message-ID: <CABPp-BH3h_XY-+K1uB5SWWKrr7UrN1JHpQX+fxgJ=pTaLwPZ9Q@mail.gmail.com>
Subject: Re: [PATCH v4 06/13] pack-bitmap.c: support bitmap pack-reuse with
 incremental MIDXs
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> In a similar fashion as previous commits in the first phase of
> incremental MIDXs, enumerate not just the packs in the current
> incremental MIDX layer, but previous ones as well.
>
> Likewise, in reuse_partial_packfile_from_bitmap(), when reusing only a
> single pack from a MIDX, use the oldest layer's preferred pack as it is
> likely to contain the most amount of reusable sections.

"most amount" =3D> "largest number" or "largest size" ?


>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 1b4fec0033..7a41535425 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -2333,7 +2333,8 @@ void reuse_partial_packfile_from_bitmap(struct bitm=
ap_index *bitmap_git,
>                 multi_pack_reuse =3D 0;
>
>         if (multi_pack_reuse) {
> -               for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
> +               struct multi_pack_index *m =3D bitmap_git->midx;
> +               for (i =3D 0; i < m->num_packs + m->num_packs_in_base; i+=
+) {
>                         struct bitmapped_pack pack;
>                         if (nth_bitmapped_pack(r, bitmap_git->midx, &pack=
, i) < 0) {
>                                 warning(_("unable to load pack: '%s', dis=
abling pack-reuse"),
> @@ -2359,14 +2360,18 @@ void reuse_partial_packfile_from_bitmap(struct bi=
tmap_index *bitmap_git,
>                 uint32_t pack_int_id;
>
>                 if (bitmap_is_midx(bitmap_git)) {
> +                       struct multi_pack_index *m =3D bitmap_git->midx;
>                         uint32_t preferred_pack_pos;
>
> -                       if (midx_preferred_pack(bitmap_git->midx, &prefer=
red_pack_pos) < 0) {
> +                       while (m->base_midx)
> +                               m =3D m->base_midx;
> +
> +                       if (midx_preferred_pack(m, &preferred_pack_pos) <=
 0) {
>                                 warning(_("unable to compute preferred pa=
ck, disabling pack-reuse"));
>                                 return;
>                         }
>
> -                       pack =3D bitmap_git->midx->packs[preferred_pack_p=
os];
> +                       pack =3D nth_midxed_pack(m, preferred_pack_pos);
>                         pack_int_id =3D preferred_pack_pos;
>                 } else {
>                         pack =3D bitmap_git->pack;
> --
> 2.49.0.13.gd0d564685b
>
