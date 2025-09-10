Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA772C2368
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489758; cv=none; b=YJPODTsOuf+ZX6hsML+HqNqh+7ZIi7tme3vsuLxiP0JF3AW8MKG7iL87am8A6RbISkmiEHMu/ndN5UbvpZeuiyj73C5FZImuCgsCh7n0kIEv/5VnGSlo9nJtIcaFPjT4lGEgKLCudyJqlVtEfV9d3bH5FIAyLfWQjZyLXVijeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489758; c=relaxed/simple;
	bh=P5puuT2YLRcV73X/0nE1XSS6bFv+oOan2EvQcyTAe3w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0w3JixbBHTFQWDsaW135Y6pDVyLwJHY4zfaVfw5qiNMySrUd0frv1DE1zE1HazHT3bXLkD8cCq1CCly8hPcZIH+zumfxL8bfNo20nfl7theujtthWA0r+RGoI29Vy/S0wNHMQcaAmRyMcLqpfXVe9nCbuQrBRZYWV9g0QQcEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US50beZD; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US50beZD"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5448c576e3bso2428933e0c.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757489755; x=1758094555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=60jG1+GMl9okfXtuPTi8srFLKqMTkjbXKtrnlELqvgU=;
        b=US50beZDcfD5mCcExCSeRoYzr295Tiq59LD1PwtpX3W0v2BhufmOnRimKqnPPNOT0T
         DwgO5MejbO94Pwv1rtaCxXnmyNzfEeVfzJa/K/KQCdIbt+jVliBikeW8xT+zI2pY3mxq
         kjrlX51svi4tHUfMHDObqZV0Pq8EEKlsp5F6oFZmfAyyBz2P/3CYgbYxeQOhz7uuTw9g
         O0Fj2D/Fooj/StKwE9EvWBRHa/CD97/xGF7ScftwwhyuFUak+2eQ/c8i+l11d4FMg5+v
         co9hniRwcRSVpe6NHhqjJv2ViKhIi1cvZNBTtopkzxxggjJ/LtG0VGgD6PBveISdJsfr
         Bg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489755; x=1758094555;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60jG1+GMl9okfXtuPTi8srFLKqMTkjbXKtrnlELqvgU=;
        b=jlin2I1QqLXKSz45/joQPMBbEkYc71iMSbfl7cOrs/+A+gIduVe7FU61Urng09Jmow
         TxmuQ5WnTa7GsZRHYHU60JWnxPFW0qjwlatbXhFyrnKkwV37lnHgdOgoO99bwK6ld4rq
         CKfJ6/XKyqFj2pLKU2aFh51iglP733auPcy1RyPGpgn02TjsJ2tvR2tU9/+W1uuDMaYa
         EiOaPbjgKdeyPxqDunNbCWHR8ORhYK6ERLA3IvvAYSnLAHLIjc/djk04qpDB/LRL4a9e
         okRI7yJ8rzEfYNLdAi0bBg/wQpO4phdfqYlWuCLEOcTYOiMiodP81DeaGesa65do5JCC
         GCLg==
X-Forwarded-Encrypted: i=1; AJvYcCVj7STkt+4YoRhDrhKivbC+xp3IyPhcS15MvoKRrMh0wBxst75z1MmTpB5bKkkoVZ8mbAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjv7kZdCBs0PnQqNk2Qll+Qzs/ATSgMXdh2wnp8KG5Ncy6Hzc
	H+pM2MsbqsicGh299aalycQpr+gRkFyrgg/wrWU54zrP6nQ+8/+BFVnDTezE98+dbLMFBlKMHjJ
	cnkYgctA8UcDKehwit4d1InttmPJkap0=
X-Gm-Gg: ASbGncvpyo1YBjNqRy6tv2vGzWCBJ6CCRKWM9GU9TFt/4oRJkuZGI+cNV5ItYc4KbKu
	aFD6UlF/Kb/h4Erq0xZIgbeyg1YgP8Oxy+2TbP8G4oTrBlJY1a09wiCyJfvlau0iMOMAnny1j1P
	NoY3YI+b1ft9Rnxl8XE+ud/hs/lB2tZWvzZ2v9AWQx+tpBAX95K8+qVRPG3N8sw1T65AU6HPKkQ
	bEbKqWZEruT66jLKEXMm/8TCupmeiXJZP6qCkSZgE3sPigKmk7byKk/e3lvGhQ=
X-Google-Smtp-Source: AGHT+IEJH6Mhr3RC8cnNr0lRJyjb/y006+8JESjSesd2ZoUPIQofhnWKB9R6M5e0+QV4SS4ZeH+7BWjVZMwTMlGjrLc=
X-Received: by 2002:a05:6122:3d05:b0:53c:6d68:1cce with SMTP id
 71dfb90a1353d-5473d47bf22mr4647657e0c.16.1757489755433; Wed, 10 Sep 2025
 00:35:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Sep 2025 03:35:54 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Sep 2025 03:35:54 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Sep 2025 03:35:54 -0400
X-Gm-Features: AS18NWAWRF9RItRxCVKT5pWU7JkNW5lBwvK24NKwShXc5xScNkpLzd3eB-hIHls
Message-ID: <CAOLa=ZTBbSgenzzMHxFByXYf2BLsXs89hUNartL0=-9nZwNVLQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] packfile: carve out a new packfile store
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000091cc9d063e6d78f6"

--00000000000091cc9d063e6d78f6
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> information about a object database's packfiles is currently distributed
> across two different structures:
>
>   - `struct packed_git` contains the `next` pointer as well as the
>     `mru_head`, both of which serve to store the list of packfiles.
>
>   - `struct object_database` contains several fields that relate to the
>     packfiles.
>
> So we don't really have a central data structure that tracks our
> packfiles, and consequently responsibilities aren't always clear cut.
> A consequence for the upcoming pluggable object databases is that this
> makes it very hard to move management of packfiles from the object
> database level down into the object database source.
>
> This patch series introduces a new `struct packfile_store`, which is
> about to become the single source of truth for managing packfiles, and
> carves out the packfile store subsystem.
>
> This is the first step to make packfiles work with pluggable object
> databases. Next steps will be to:
>
>   - Move the `struct packed_git::next` and `struct packed::mru_head`
>     pointers into the packfile store so that `struct packed_git` only
>     tracks a single packfile.
>
>   - Push the `struct packfile_store` down one level so that it's not
>     hosted by the object database anymore, but instead by the object
>     database source.
>
> Changes in v2:
>   - Convert the `initialized` flag into a boolean.
>   - Polish some commit messages.
>   - Some smaller formatting changes to the layout of `struct
>     object_database`.
>   - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im
>
> Changes in v3:
>   - Rebased on top of master at 6ad8021821 (The fifth batch, 2025-08-29)
>     with ps/object-store-midx-dedup-info at 13296ac909 (midx: compute
>     paths via their source, 2025-08-11) merged into it. This fixes
>     various conflicts with "seen". There's still two conflicts: a
>     trivial one with jt/de-global-bulk-checkin. And a more complex one
>     with tb/prepare-midx-pack-cleanup. I don't think it's necessary to
>     really address the first one, but I'm unsure how to proceed with the
>     second one given that the patch series still seems to be cooking.
>   - Set `struct object_database::packfiles` to `NULL` after free'ing it.
>   - Add a comment to explain the kept cache.
>   - Fix a missing `obj_read_lock()` call.
>   - Drop the commit that always adds packfiles to the MRU. I've moved
>     this into a subsequent patch series.
>   - Avoid some overly long lines by storing the pointer to the packfile
>     store on the stack.
>   - Point out the difference between `get_all_packs()` and
>     `get_packed_git()`.
>   - Link to v2: https://lore.kernel.org/r/20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im
>
> Changes in v4:
>   - Small code style improvement as suggested by Junio.
>   - Some commit message improvements as suggested by Karthik.
>   - Link to v3: https://lore.kernel.org/r/20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im
>

The range-diff looked good to me. Thanks,

Karthik

[snip]

--00000000000091cc9d063e6d78f6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8ec184ac77e5860a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qQktsWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0FqREFDT1ZiK2tBdm1vNjU0L1lOTkdFdGhyVHhZcQpMM3lTS1B6eE1n
bzFVY1VUTjZFdGttOUkyTUgzb1QyWER0dHBYcWg0Smw2NVlQSVBKUVRXYTIyYVlXNVk2SzVCCitE
SjNoT0NTNExWUytTRm04dGFIMDRjOWErSnFzOFpIZzQrYkhVaFQrc2M4MWlWU3dxamtraW4yL3BG
ZUhTMzMKc09CUmlQTGFXZ2NZd2U1ancvbnl5TDhuNS9HUXhtWE5IZW5BZElnVUpxSHQ4SWhUUCt4
eTA1RmdTYmtudFhVUgpINldrZVZGcEVIN3hhV3dJSnpSK2RZTWw5MDF1MFEvSTdSSkxheFd1UFRJ
a2R1Mnl5UElIektKRk91Y2pUV3o0CkVWaUJyN2hVLzE4aUVXUDEyTm95cW5YODF3cFZ1UkxLZUxD
SmNzem5BSE8rWnZnT1lQTnFydU85UlE2Z2Z4Yk0KWURQMkNKbEh6U3NQSjdTaUd2OWlCUnhjZnB6
VFFiQ0tBRGxlSmVWUUM3bDN5MFQzWjBhellYOWZldGhSTW1JMQpyOHVXR0FmaG1ETkN2V1JMcW5B
ei81UmtSbklFVzNmY3JJZ2d0RzdxZUgzNlFqWk10VGlFZ2l6QUNRN3Ira1JECnVwblE0aG5DSnBl
ZTFOQVpqYnViUWJxQ3hrb3RENEZqeXBOSnBxaz0KPWhZV28KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000091cc9d063e6d78f6--
