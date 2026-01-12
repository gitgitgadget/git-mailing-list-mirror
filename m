Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361F2D061C
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229580; cv=none; b=AOd0VeNEFYxYRGiyYuY3Mc8wFRfXoOx90VVAiysvXkF/dUguFAt9aZuJIClHqJmHTU1XwLwxx9MFg1Y24AtucT+TArDkrgUT5C1+evWjS/dDJxY/eRlVCqNz1MSmS/7XtugKHLK8hKDU+zHVEkEiZHvFKMyI93qVtcdMR/rxe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229580; c=relaxed/simple;
	bh=N6gJ14ZSeonQ0oEvZOqPecAtnHwR2DWQwL2STd/Qsxw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldm4a4SS8y8kJ1TwlQ5y7TGeWw0+2mmvL8gVNeGXqMegjwJ01oTbtDicXM0d4BwXhh6OKpKvGD43I44lU2b30+6Np0Ee6APT54FxbMdX7ljolqBJe66Ak3Qj6d9dldpZYQ1YRj5pBqd9cjvqDo9kb79+Jtt2ph+/7/pN0BZqR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+LfMS+k; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+LfMS+k"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5eea2b345fbso1384511137.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 06:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768229578; x=1768834378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SRF/0hWHO3ib/07OsFApHEIvBZ2GYRaJYmP1gmbRAgk=;
        b=b+LfMS+kR6thFwsxugtaNaGBMPraS+IJZLK9TfOw00IeD1PvxK1Il1feCo1Atqa+6d
         btAmJcWuuTvjrmH2fYb0iMvk8eo2v5lxjEWXEiZv4KG17xMM7c97VqwCDNJJZoWExA3Q
         Yi/GqsDE62wd2cobr0GwE2cmMHaZcNFoeEWBfYABL3TVYgEGgbquvPeoO2EulxmdOLK1
         wQrYxZ6PQIXu5U8UB+w9KH1kAkCdAm1DPP5OG+o1YJZdzQFQ9rZ3gRFJlvsOWocvXYDN
         H5SMzIjxazOMKsH/enH1F/oALPm4fFieK/6n/Lx5Lm/PynKCLZ4llxKBDwRBCXg21Dpk
         0pGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229578; x=1768834378;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRF/0hWHO3ib/07OsFApHEIvBZ2GYRaJYmP1gmbRAgk=;
        b=SuRwmICCuPZajm38RF4U09anHi+4gwM1YCsQVuD0Q1lFGpMgWvCYP+acLWSk0pnKon
         AjV6q/5C85xL87LOUjFPBqrQ80tMhnSrBvV+/7g5lm9ZICY9t8u5quvl9zJkK2hHyRH3
         Btrn8FckclfXxq2uQrvtPwelhQX5vAaIbxBrNb0R9QheQJmafjH/QqxE9EKasRexDsT8
         WV60/HLVYJyRQ+ahNbrVdiqxDRh8vNL0COUssZkWbXKWbAk6hko4B/Cr2mIKPKmmTbwj
         9xvZz5/1u0NzOXFrPqhekp/8VEGqt9uhy6PmJO60uQOqdNfmV3sEvQ9nnYOgY9DhqU68
         YCOw==
X-Forwarded-Encrypted: i=1; AJvYcCWMs24kW/12RIFLv3w1sVqqxNC3A3ZnhHoYqDrw6vNveYrJjFZknlEH5K3TX/217YARzW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypNtL7tWFibKjTk+l/1Q/lV9jU72KWbjHrMEV51lQcyLFfSNBv
	O+kDeMCzpTs+vEqVGl5NC5IW/CIA/u0IqTWPI36jEWfYmPo0Dqcl+E88kmPKMD6r+Z8obxEkUcH
	JHdEG85zvGTceLrw2gznU5OclmMcqL9k=
X-Gm-Gg: AY/fxX6KOQuA/IeksSjJwFvx1Bm1ks8RS1OuEXvQu3RQIKLsheUNVtl0hbwGM3tahab
	H9Qi3xK+9k/g2xPYqkb4f5/Y3//PvWtNHWeBAtxQheCobq0UZ+SXR3cMwljRdE1vuJ9a6HBrtpE
	A0/CyTQt8tU2GxWES5yWCwD9Yvtnj6JXOKUJ5F9+8EbREYZfM/hgzYxg8bdTkoh1UDiDPJkJrAt
	9+3C3N2vAzM+19l2CbkSJ3gdn/IiklTFgg+YGXjlph6Q7QGw1kRACAITcF4hABNiSG42CDVfUuW
	EbwiWreALsMwygBzFR4ecAN8U0yBzXqPJGIZFUj+
X-Google-Smtp-Source: AGHT+IHGeYOpO/D3neFb7uKMa5s9LDYOFLWpGbl92RIp2lsrjtBZcyaOrbIxQbuVHPCktALE0gpaczMUvENXsWF3Knc=
X-Received: by 2002:a05:6102:3908:b0:5ee:a6f8:f925 with SMTP id
 ada2fe7eead31-5eea6f90e16mr4636242137.8.1768229577657; Mon, 12 Jan 2026
 06:52:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:52:56 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:52:56 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-4-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im> <20260109-b4-pks-pack-store-via-source-v3-4-877fd7b7bf81@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Jan 2026 06:52:56 -0800
X-Gm-Features: AZwV_QjNoRpzNmcM9b7qnbWc9CgdY96Ozonvz4s6Qbdvr3M7AlythUaVMjJ5pUI
Message-ID: <CAOLa=ZR0sM21dpS5cfhhPQZLHOq5L1KXM5h0jXaK1+m17CV5xg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] packfile: refactor misleading code when unusing
 pack windows
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: multipart/mixed; boundary="000000000000dbaab10648320772"

--000000000000dbaab10648320772
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `unuse_one_window()` is responsible for unmapping one of
> the packfile windows, which is done when we have exceeded the allowed
> number of window.
>

For my understanding, when dealing with packfiles, we mmap windows of
the packfile onto memory. If this is above a threshold, we need to evict
one of these mappings, this is done on LRU basis via the
`unuse_one_window()`.

> The function receives a `struct packed_git` as input, which serves as an
> additional packfile that should be considered to be closed. If not
> given, we seemingly skip that and instead go through all of the
> repository's packfiles. The conditional that checks whether we have a
> packfile though does not make much sense anymore, as we dereference the
> packfile regardless of whether or not it is a `NULL` pointer to derive
> the repository's packfile store.

Yup reading the function for the first time, that struck me immediately
too.

> The function was originally introduced via f0e17e86e1 (pack: move
> release_pack_memory(), 2017-08-18), and here we indeed had a caller that
> passed a `NULL` pointer. That caller was later removed via 9827d4c185
> (packfile: drop release_pack_memory(), 2019-08-12), so starting with
> that commit we always pass a `struct packed_git`. In 9c5ce06d74
> (packfile: use `repository` from `packed_git` directly, 2024-12-03) we
> then inadvertently started to rely on the fact that the pointer is never
> `NULL` because we use it now to identify the repository.
>

Nice investigation, that explains.

> Arguably, it didn't really make sense in the first place that the caller
> provides a packfile, as the selected window would have been overridden
> anyway by the subsequent loop over all packfiles if there was an older
> window. So the overall logic is quite misleading overall. The only case
> where it _could_ make a difference is when there were two packfiles with
> the same `last_used` value, but that case doesn't ever happen because
> the `pack_used_ctr` is strictly increasing.
>
> Refactor the code so that we instead pass in the object database to
> help make the code less misleading.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  packfile.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 191344eb1c..3700612465 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -355,16 +355,15 @@ static void scan_windows(struct packed_git *p,
>  	}
>  }
>
> -static int unuse_one_window(struct packed_git *current)
> +static int unuse_one_window(struct object_database *odb)
>  {
>  	struct packfile_list_entry *e;
>  	struct packed_git *lru_p = NULL;
>  	struct pack_window *lru_w = NULL, *lru_l = NULL;
>
> -	if (current)
> -		scan_windows(current, &lru_p, &lru_w, &lru_l);
> -	for (e = current->repo->objects->packfiles->packs.head; e; e = e->next)
> +	for (e = odb->packfiles->packs.head; e; e = e->next)
>  		scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
> +
>

This is much nicer indeed.

>  	if (lru_p) {
>  		munmap(lru_w->base, lru_w->len);
>  		pack_mapped -= lru_w->len;
> @@ -740,8 +739,8 @@ unsigned char *use_pack(struct packed_git *p,
>  			win->len = (size_t)len;
>  			pack_mapped += win->len;
>
> -			while (settings->packed_git_limit < pack_mapped
> -				&& unuse_one_window(p))
> +			while (settings->packed_git_limit < pack_mapped &&
> +			       unuse_one_window(p->repo->objects))
>  				; /* nothing */
>  			win->base = xmmap_gently(NULL, win->len,
>  				PROT_READ, MAP_PRIVATE,
>
> --
> 2.52.0.542.g9473a8513b.dirty

--000000000000dbaab10648320772
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c1b5535eb987db70_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sbENzY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjdWQy85TlNzK1h3U05ORjN6OEFQamtqTXk3ZEdVNAowR1lua1NMN0px
aGw3bHdEbFNPSGYyM2VQaUhwWkpQWUNYdWd5d043b2dNRjYwZTZUeEFGVXpFdXJWaHBpUTJaCjVF
b1pHVldmU1Q0Wm5SL2x4MXZDZXhvcUc0Y1MzOTU0T1Z0RnFDQ3VNQ3NwVmhMYW81dEVmdk9BT0Iy
ejI0QVIKcldtdG05WEpsQWlnOFdyc2x6WXB3S0FmVjVvZWhoTGRMRm5aR1VrUWNSakVMQjdqTS9Z
bFhLWHhIN013NkxZWApHVXJVeStPV0l2ZWV6bGd1aHJWeXcyREQyRmZJV0pHYmlLbHQ2dlhtV2xh
Qk1NYUgwcVEyN1dBb01xak1maUJFCnI1RWcxczF6OExIMnRwb1ZFZk03R1lIMisyZGZmOElPbXpU
d1BjQTVuNGpZRUxRVm5ETFV5OFNyTlprdnRUNmoKWmdqa01oeFNLc0xpeE5jbWVtS1RXSWlQQ3VE
cnl2TkhEbUVwekJINXJzVjFEa3licjBwbk5UUmVNTEdHWSszdwpRd2xGd1NNVjNvaHhzRnBFMzVQ
SUE1Ulc0Y2ZYZ3JHalJXYUdkbW9HeHFyWWM1VXZrOVJoR1VYVEJEUklWaTRsCnZONit0Y3ZFekJQ
dlFuNUptd0pWQWpUWWxOR0RmRk15WENPM0d2OD0KPVRidEcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dbaab10648320772--
