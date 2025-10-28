Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550034F24D
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678915; cv=none; b=KUqUWu3p35x5Yv1vhfkgTBHkOsIGFk/xFRJtyaohn0BeIPMsFhqz9B1DmjlAH0bwALcBHCsUCNNmUti5qdlF51f/6fdURkcto3aGlUd6BspHE/bkN9E8HGQ7ldsLKdwW3o+gB0xTalLFjMQWtCUTDspZKBhoDUUZah1qjKdVSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678915; c=relaxed/simple;
	bh=/9XGs0mWBs1XWv/LAt8G9W3EqopaZj9y8zzj84TEdYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKEZD23pUi1lNOBb5YmGznWeEhQoCA54rXBN8sebFqJY6Fg5Wv0ZP56bdUwsUqRBhn565KshjqVuVKZVI++nmJUMDNwKG+uFfHDpKgjV9KQgVhaxbN6mWQuGfaMqTOq99kDHbgf6lkULWaW4UvppISivRwzSYa61vwwCqkwWsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osm13PM/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osm13PM/"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-592fdbeb7b2so6478088e87.0
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761678912; x=1762283712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+ScT3L7TqVtwwXY7i3I+9wOgMLHZZ+pROfhb89eCag=;
        b=Osm13PM/roHVz6bM2cx75WE9/uDQFk637tzVeTdH2dqZMf+fz3Sv0sGnoaGgPI0Ihd
         AZZ9s/lyvA4evJu1Mn9YDyLASmbUlL0cHBid2k9AlQGVZTzDRLPQ+Y4bYrlXZTh9i6b4
         5PNeL6N4UaO8phl+faxsWm9MDU5JzS6xp7b59zl5Qb5VcAGHdrVpZFu+WzsxQg9eUjnZ
         9seZriHUEo6KrHHsddaRaNQpHZqA+HU1yrhm50ctE/st3QSaVdRI8g1IZv81B8CH4y/n
         2m4otOLhaMAI56DgW0YJb32/IPq6u7zBcGZqedKRpN9iVugod3U8iPG2LxS2envPynZd
         rNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678912; x=1762283712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+ScT3L7TqVtwwXY7i3I+9wOgMLHZZ+pROfhb89eCag=;
        b=JC7rwhIAChmFR/BSxgs0dPxtRvzhcq2g8OMwwWkeaJZyFjJRV/xA0KbN9rruphl+Iu
         NkQNRZfzl87SrQi3buX7BtyqSiB9+qCd6d17NEZkV/Mocoo5c4sU5JSqm2U+XmRtj9bG
         F594bT2KvgfarE4iw5cLzTVG+aq+RTxY+YcyOIBpRSQlrYxvwFWIoVzT/Nb75pTGOsJn
         JuFHKjKvIgJubsOz4gBwWZ4Q4YSPKzfHv9N1d2rfHoSzKT3DGUtinn7w8rr/RBOnnLC3
         CRqsc8fgedepnKIUw71DalYjfKGO+wwfJEgOqS14nGJeCaIR3u7OXEOUUK7VutJ+Gbdz
         aMBw==
X-Gm-Message-State: AOJu0YzfSz2YYKtw5NtxAy59rFUtSSH1CM8Fi/uxNjVH3DWBtZlxpVeT
	PT8P+7LFbcHgHEGLEI4gEU3mSbn7TO/6EtkZhMrAm5Jt6Iv/1csTDQGzfiYx9hnebQThKF8Nrkt
	ieNuwCoYSVEu7lr7USZj0iG4PnkRriIY=
X-Gm-Gg: ASbGncujqxrOr4TNU4P5tAr/3u/8nkCJMcCWbYu0PweXyJ6Er6l9XKt1qc57O5cOftm
	6deeVP9mMz46TkHwpbzSExqg0jaArVTZAD9iDv76jbDlN3juP6pqULcvTNPPzZVvx6CwZcSTkt6
	o+PvYO2jFV918ZIctPY8OoNontUAxmWmRtVA8S2RlA8jFXrQCKpGBG1MV6vWj2Uv3dU4Utt3s0A
	bpPY+8y8PUB3bcsluXBAEtAOfG2nKU7/PDm0nwJRtKAWCkk7QDP8epeBYCaWEgMyfnKxb+U
X-Google-Smtp-Source: AGHT+IEeNActzeQ3Znhx7QK3m+0apLjYlOiup0sDSjUmmvgG5R3KycWW54px0ZmRvi6NnYKR/k/6X0K79Rrp3jrXHlM=
X-Received: by 2002:a05:6512:3d90:b0:591:c8d7:c047 with SMTP id
 2adb3069b0e04-594128657a2mr186130e87.2.1761678911588; Tue, 28 Oct 2025
 12:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im> <20251024-b4-pks-rust-cbindgen-v2-1-4b4bd4f18490@pks.im>
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-1-4b4bd4f18490@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 13:14:59 -0600
X-Gm-Features: AWmQ_blM9f_uEC5vR5hoTuGBq66XCwjzi_Sag2PTCwyIUkQMXrb_LbxSsw1mk0Y
Message-ID: <CAH=ZcbAEBbDkAqp9cc908SgkM5BQOD_=52e6Y=EVd=cwyPU0Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gitlab-ci: reorder Linux job matrix to match
 GitHub's order
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 3:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> We have mostly the exact same CI configuration as GitHub has for our
> Linux jobs. It's harder than necessary though to compare them with one
> another as the ordering is different between both.
>
> Reorder the job matrix in GitLab CI to match GitHub's order.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitlab-ci.yml | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b419a84e2c..1dbf236b2c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -42,15 +42,15 @@ test:linux:
>        - jobname: linux-reftable
>          image: ubuntu:rolling
>          CC: clang
> +      - jobname: linux-TEST-vars
> +        image: ubuntu:20.04
> +        CC: gcc
> +        CC_PACKAGE: gcc-8
>        - jobname: linux-breaking-changes
>          image: ubuntu:20.04
>          CC: gcc
>        - jobname: fedora-breaking-changes-meson
>          image: fedora:latest
> -      - jobname: linux-TEST-vars
> -        image: ubuntu:20.04
> -        CC: gcc
> -        CC_PACKAGE: gcc-8
>        - jobname: linux-leaks
>          image: ubuntu:rolling
>          CC: gcc
> @@ -60,13 +60,13 @@ test:linux:
>        - jobname: linux-asan-ubsan
>          image: ubuntu:rolling
>          CC: clang
> +      - jobname: linux-meson
> +        image: ubuntu:rolling
> +        CC: gcc
>        - jobname: linux-musl-meson
>          image: alpine:latest
>        - jobname: linux32
>          image: i386/ubuntu:20.04
> -      - jobname: linux-meson
> -        image: ubuntu:rolling
> -        CC: gcc
>    artifacts:
>      paths:
>        - t/failed-test-artifacts
>
> --
> 2.51.1.930.gacf6e81ea2.dirty
>

Looks good.
