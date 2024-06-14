Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A119D8A2
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399347; cv=none; b=BTXlaoR1zcbWjnRTKlsP5R6qph+K8h75o5IPaRvh9BV7s++HxKTM5jxiCVemOeQ6dWqp+d6p9Pxmve6A4GMiO3C5xcIN8Hax6xHKNeaU9ckrwbDs96YlgGWpqexEcw9WyuP4m1qfRASEAB13xnCgck7kNiDjzi555KsrZ2M3smc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399347; c=relaxed/simple;
	bh=PdX2FEUpBxejqie266KA5Rks0N2p0U9Rnknm/s2i+dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ou4xZoc65AFG5a9JW88FBm6ewNj3DGCR9aTMR/kl+AbOGwIm1MNqms0yBFoO/YQoRIBrvUBFjMV+MDMLnp+p1kc3hVlq9QEwv1nA2pINYvIg6oqM1ngBNZ3BajUxOfaTjP58Pzn0FumkzNcLBfxS4Uu9uT9yOhp2f/4MbA45MuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Te0bPU5A; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te0bPU5A"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7eba486df76so85203339f.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718399345; x=1719004145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZfIUHIyH5W2BBYApTmn7CUIat/m/Qa5jy2hOVRo1RE=;
        b=Te0bPU5APY3P6u9pCfQUtEs+Cf51A1m2//go0DybbfPFoSMbiH71Rb0C8SczdUuaDv
         ORmxQXNCaDdERMU9Zh6YT0QXi3EMjE1H/Qeqt6igtElTWyq70kmA6WDLK+70UKmCi0Pi
         34pwhIlIudArq8RiQlHwwex7HEJRDLzUZPlrD8kRm4e/fUYQaqpVQfpjuo1IQWoMaz3t
         jAjAW5YdzmjXrqhutPwHpVd8oeEIvp4zLotje7B9PHd8PTNyHE9DxnmolZ+3yz9jt3Hs
         tAhhfBg6L4VgCPt8TwGtGZ1+r2TXHwtoc1bp0Mzr8Xbx0OcmCi689lv82No3C4PUvvfk
         qq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718399345; x=1719004145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZfIUHIyH5W2BBYApTmn7CUIat/m/Qa5jy2hOVRo1RE=;
        b=xQ+CFJEywpfQ2ZSYcW1aBCpevBl3t2Im3c4igRJCuYFKZTDOM4J+q0L2GGIuy6sSY7
         0hIFPRNe1TDKyushlGMc0PlAtnqnLH+6EkKe6zPCwLS5eYOZRD4zyvwbBpqdUqubYH6C
         AE+rguYL329lb8+o9ypI+KxO9DSB/Ji4eHGQsFQN8PL//Plc6fGa/xCrSzLNB4q2PBvR
         IFMoaoBoIyfV4HafnGrI1etjVTpyMbNSRBwRbmI7CEE2o7hLURw2E5vXRmq0Xln4nO7C
         QwsL3Ucbr8KOIx+lzbqh8wBTkzYALLi/CfSaWW4ER11+Go0Vls0gRrcx69BjETl3Nqc8
         Q6AA==
X-Gm-Message-State: AOJu0Yw8w+IoxnmorOXJxko2sJFwnoO/bLWrIcpB/1KJjmhXrf9xH/44
	BFWAuoDN7Su2kpkL59XLg1Q/o2bHz1c6TqTw38+cQuuPQhIbjemg6Qo03ptRiy2GQxhBA6tqJFu
	0zmi/j86drWYfTGWQHD1wzRkPtWs=
X-Google-Smtp-Source: AGHT+IEDG66BdyD/cbSb7S9Siq0rFDlL/8IN/R5sOFnWwKCvOmpJErecAmsUEi6Sl2xXw49beCZbLhvMdEzkwCDEnrc=
X-Received: by 2002:a6b:ed18:0:b0:7eb:ba07:2d3d with SMTP id
 ca18e2360f4ac-7ebd8ef060amr393057839f.8.1718399344875; Fri, 14 Jun 2024
 14:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
 <cover.1718392943.git.me@ttaylorr.com>
In-Reply-To: <cover.1718392943.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Jun 2024 21:08:53 +0000
Message-ID: <CABPp-BF71VWMmSHNx7-dbs8ek+dK0kPTUnSv2OJmM9VYq-LOkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pseudo-merge: various small fixes
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 7:23=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Here is a small reroll of a couple of patches I wrote to fix various
> small issues with the tb/pseudo-merge-reachability-bitmaps topic.
>
> The only change since last time is replacing:
>
>     if (st_mult(index->pseudo_merges.nr, sizeof(uint64_t)) > table_size -=
 24)
>
> with:
>
>     if (st_add(st_mult(index->pseudo_merges.nr, sizeof(uint64_t)), 24) > =
table_size)
>
> based on helpful review from Junio. For convenience, a range-diff is
> below. Thanks in advance for any final review on this topic :-).
>
> Taylor Blau (2):
>   Documentation/technical/bitmap-format.txt: add missing position table
>   pack-bitmap.c: ensure pseudo-merge offset reads are bounded
>
>  Documentation/technical/bitmap-format.txt | 9 +++++++++
>  pack-bitmap.c                             | 5 +++++
>  2 files changed, 14 insertions(+)
>
> Range-diff against v1:
> -:  ---------- > 1:  a71ec05e5d Documentation/technical/bitmap-format.txt=
: add missing position table
> 1:  0a16399d14 ! 2:  8abd564e7c pack-bitmap.c: ensure pseudo-merge offset=
 reads are bounded
>     @@ Commit message
>          end of the mmap'd region.
>
>          Prevent this by ensuring that we have at least `table_size - 24`=
 many
>     -    bytes available to read (subtracting 24 as the length of the met=
adata
>     -    component).
>     +    bytes available to read (adding 24 to the left-hand side of our
>     +    inequality to account for the length of the metadata component).
>
>          This is sufficient to prevent us from reading off the end of the
>          pseudo-merge extension, and ensures that all of the get_be64() c=
alls
>     @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *=
index)
>                                 index->pseudo_merges.commits_nr =3D get_b=
e32(index_end - 20);
>                                 index->pseudo_merges.nr =3D get_be32(inde=
x_end - 24);
>
>     -+                          if (st_mult(index->pseudo_merges.nr, size=
of(uint64_t)) > table_size - 24)
>     ++                          if (st_add(st_mult(index->pseudo_merges.n=
r,
>     ++                                             sizeof(uint64_t)),
>     ++                                     24) > table_size)
>      +                                  return error(_("corrupted bitmap =
index file, pseudo-merge table too short"));
>      +
>                                 CALLOC_ARRAY(index->pseudo_merges.v,
>
> base-commit: 0b7500dc66ffcb6b1ccc3332715936a59c6b5ce4
> --
> 2.45.0.33.g0a16399d14.dirty

Series looks good to me.
