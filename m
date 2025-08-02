Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D644A01
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754122721; cv=none; b=Ta+Y1GuPgZE+rHkuAJJ33nP1wv6Oc1Jibfg/jqklFN7NWm/bHXkDxEXnknViuOtrxDYqEOzlYp4t+Pof0tEUubih3Y/bV4ppZy9MD2eJStk1zZikOEaxNeDC5kQf6VzcHsH9hVpZS9utlTBmb/tVx7zkMp9M/PKdeoKvEhxgzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754122721; c=relaxed/simple;
	bh=JmxkCh17LjB49CgPqrRVwy6AOYu6b0gOZKfTMzhDuE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvKZMQzTcX1P/cHH7UqJ0oYABBAlsaxrOSDPzDfQZ00Gn0sQOZ1B3WcLyAWuj738XwbwBoXdPpdvTo3B/3I36EEmSo4Tv78AkNdTxtcGYay4DtJIFosi1QX8WBk0ELIIiRdzWia74AQallToPYCNHpfbkvC4MpU9nP4NFNozA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQej3mGK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQej3mGK"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af93bcaf678so137248566b.0
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754122717; x=1754727517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GhcHfNO1tsguG5zVYlYsxs1GQNieXvuM1NCPy9+ajY=;
        b=BQej3mGKRxU8d4IssfSzIisve3AMsDolq85PDLxH62Yvva530k9u+d6WjeRhvcouTu
         AqmMGAu/GnOr9P4T311oVu+B8uwq39PcuTrDwlMNBY0iD2uynIoemSIprUqIRHIdby+p
         i2pEtirDjS3JwOqFFffMNi6ik+mBnPo7ymKBI+NAus7gi3Dd1tlx247ma4Fu2B2qmqSl
         eCUrQIOzkJBMM4N8gV1Wx2HkKG/Q+hgJNHksfv53f+4/fQEri5GuVdURpQHsS8FGX59K
         yKhgdrFilbkH5b1YJGc9L5JRpnDJ1U/EjO+Que4oAXEcKvnAbxciFAzNCnn5GyiVpwu/
         P5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754122717; x=1754727517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GhcHfNO1tsguG5zVYlYsxs1GQNieXvuM1NCPy9+ajY=;
        b=uy51p42TYCGldKytKytar6aWH0YtB4V9AFUM2uE2+Gy7bFcFPvg633ecuV/yiJAvu7
         1mVVqa9cfIiRqjEK1I9k5xi7cQHbEtVr0CJMSxi2w3VfmR09z+/CDZEn/K0tmKXnVhea
         3jzaoPCA3q097+SwiRD01bsESqI/PPBV43VgoQFhJcTYRXcOPooXGNA/MSBopc1lbben
         kkPLO9TEQjBf5DDXYTOMK57DJLQaP6BDIz8Z5hDSAz7+Z8Al3p5T9ixoKVp7h9DKga+B
         nambvlDrA22I51JqU9LqBa8Z0mDVli//Wa/kL9qkPOyN47ufZXzddpGlaOV59phOzSjE
         1O0g==
X-Forwarded-Encrypted: i=1; AJvYcCUF7assTYwJt9aRWpGkbyZInN6qDT5A80s0IWDNKbFTaej5KIGbqZEYQCesruBRwh5QMvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwD7gzexGhU23gnBq3VmkvAdiyqlx57YCMf7LrS9UWHKV+bWMl
	Q1bBseqX7cA2CVd7HBKqgS2xqyuPpqz54AGAtU4RcMe+66kfvBOTseZzrf6+MK4Ef05+oc9QDin
	CCzazO16iGgJEoSu7jpBeizwgdZ2hSZQ=
X-Gm-Gg: ASbGncv4XjIXRUI6VVX2Q+DQz27usmEnlfxa4G2gYluRqzA5gskWugN8fqy7Q6S7F/G
	z3lgdFSKKnr2AEK17P95M8vFF9wVImzczFQaDn6FCXhBDcJxo3JkFcfITO2AFd7IMJQAt4nIqdb
	jcyrpo42kCKN/MNmJyQbqRWBiG8fHVT3EZLtBy4sUkqKL9drr45JSVdiC4pgiOf6RPhGJ6lVR/P
	pQz6dSwQawv0aWcmQR2
X-Google-Smtp-Source: AGHT+IHarWgNJhWOjyfwZRpu0tO1k2Y8kv3KJFQ9YZ9wgPeKT4ymYbg7g1nrLmLmFODMYVA/1JayyIf2W4Vr1uOaQ3o=
X-Received: by 2002:a17:907:f497:b0:af9:1c73:cefd with SMTP id
 a640c23a62f3a-af940247d01mr276300466b.52.1754122716993; Sat, 02 Aug 2025
 01:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716133206.1787549-1-toon@iotcl.com> <20250730175510.987383-2-toon@iotcl.com>
 <CAP8UFD0AEKDmvQJTanL+ZS+U66WAZz=FKSJ3LPE1QHSEyH-zNw@mail.gmail.com>
 <aIyVft9PdlorttzZ@pks.im> <xmqq7bznm0nk.fsf@gitster.g>
In-Reply-To: <xmqq7bznm0nk.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 2 Aug 2025 10:18:24 +0200
X-Gm-Features: Ac12FXwUO5X6BoHm0G2zg0rA_LfCKWHcmscFo_rddXJrC1J5yGx7Jq1nzBcmYDI
Message-ID: <CAP8UFD3rV5CmHbbmg9vQodJ3U=WxfmWHnaio+7RcBAKz=2Ar-A@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 7:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> Given that even a long-time contributor gets confused (including me,
> who needed to see where we documented this for our developers),
> perhaps a clarification patch is in order?
>
> --- >8 ---
> Subject: CodingGuidelines: clarify that S_release() does not reinitialize
>
> In the section for naming various API functions, the fact that
> S_release() only releases the resources without preparing the
> structure for immediate reuse becomes only apparent when you
> readentries for S_release() and S_clear().
>
> Clarify the description of S_release() a bit to make the entry self
> sufficient.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuideli=
nes
> index c1046abfb7..76ec6268f2 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -610,8 +610,9 @@ For C programs:
>      - `S_init()` initializes a structure without allocating the
>        structure itself.
>
> -    - `S_release()` releases a structure's contents without freeing the
> -      structure.
> +    - `S_release()` releases a structure's contents without reinitializi=
ng
> +      the structure for immediate reuse, and without freeing the structu=
re
> +      itself.
>
>      - `S_clear()` is equivalent to `S_release()` followed by `S_init()`
>        such that the structure is directly usable after clearing it. When

Yeah, I think that could help. Thanks!
