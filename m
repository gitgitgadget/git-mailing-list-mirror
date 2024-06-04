Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE62A1C5
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489392; cv=none; b=l9IVqEkwIAEaCW1vIllCK8GzbXpqIn9hnPZLxRDxYpAF9qyeRQ4zjo3X3m1CQxgynpScXL+jmaalEvWUVZi+UMlWXDRo7umQ2tbdj8i8i7HYm6RVGzU4AL6ho7ZbZuE7M7vEbwXUPkb9HEeem2esUt44JvaOc60dRqIcTiBm9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489392; c=relaxed/simple;
	bh=ZS89N4FguIJ5RqJyjKQjPdckvECfe55Iw45X1KGtHuU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXBDv3CKHIvzUZG2jthZ1f7gZ/i2UTLT8dqmYQv4Ek+1t8l4ipP5cJVCXTQuPLlMFtbZhd0howK6TOa+auh2qTgMO4BR02bLWNPrNcyUv+VkkwenZ8GEXZDCE83Pl8fN0xJS6yQGH5ZjCwBKkJpq7lfRWV1i27iCwaEK0hLt28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7g33yOv; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7g33yOv"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d1c077b9baso2714468b6e.0
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 01:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717489390; x=1718094190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2zAtAN562jEc0G3ap4vpPyNvoPLpx8xGhRsobUWos0=;
        b=Z7g33yOvpH7tF3QQk7UE8KlxF20NwFy+MKdjr/tr8HfIwoGVWv6HX/1KFNwVXaH40s
         EzAkjL9pM6wPhlhzwKTljHbnc54zEc9DHPPXdnjGBRrSUPh8FvEabXY3dH19erOYwEGB
         F2uxaIcxaPLXO3mXLtzVIbeRdSxiM3N35gyTRVRs9cmaVgNtwgVf2GVxolWI5EaqPFTY
         XBUSrQVooHJKlgYA0ZUYqIqJCNyjvk3g52XKKws45ak/96cDKNgXfjYwM5kbRYgP5MTK
         zHAN0wvqYzOv84dCSske4HXLzVrjXtWlko+KULIDOx2ryb1L0iFGGylQebx6hMW0NcN+
         k71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717489390; x=1718094190;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2zAtAN562jEc0G3ap4vpPyNvoPLpx8xGhRsobUWos0=;
        b=BimJvQU2UT7i3OgXydMGD2HLA6k/pRBZ7ucgRVXoAVDzuVul2lH6PSxbqOHs927NZx
         KX8gzWqCm15FvpiARu9Wl9NZ5gOnuFtYfNkVEeVX2Aa6NiaxPOxge+7pVz1fD8PHE5CE
         dhu1lIAJHhiKNWCXksNxEXYRvw6DIfWcdAIPRZ40BLDLy/mLZxTw4IzaoNBu1GA5Nhmk
         jspoyeqKUHi3tolIgCk12kTuAsMVlHvoMh0INXZmNirarHwCc+yqv1Hfc/UkQGt6NH+Y
         ze39G6IFpGXW3Bcpsvo70bcV4hO6noUxreYRZOoWe096d4IL6woUwrslzFYebcANN5VA
         sHpA==
X-Forwarded-Encrypted: i=1; AJvYcCXHiro33o0cFVWS13yq6Cw5wJAGo8ZJp3hQ9xwANVjm84AJYUEOdg7cfzaG6vZ1XyIciAUaLrPJYoNudytovuPBCm4Y
X-Gm-Message-State: AOJu0YzM+8xMTq99hM4oGQuLboo6+xjHEnVghN/oJc74W5Q4YDOPKtgc
	umXZe40nlcOHzt+FOIJUt8sdOmc3GX1PLkCQeB9MU/hnu3fdP3Q45q51Eogokn3WYUTG56YBPXM
	SzARa8wXEe0h6GPaWBKPNX23G4m8=
X-Google-Smtp-Source: AGHT+IFN9Al3mMtgZ4bbnOfAJaSJGNGxqFV0NvY+Ki9rkhHm+JvzHDoM+W3QXPlAMTSbS345PQy28QN2rw9Zf/cpa7o=
X-Received: by 2002:a54:478f:0:b0:3c9:932e:5b88 with SMTP id
 5614622812f47-3d1e3492dc4mr11285680b6e.14.1717489390111; Tue, 04 Jun 2024
 01:23:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Jun 2024 08:23:09 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <7d1a86292c205bb47bffa93aa293a3575836f9fb.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im> <cover.1717402363.git.ps@pks.im> <7d1a86292c205bb47bffa93aa293a3575836f9fb.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Jun 2024 08:23:09 +0000
Message-ID: <CAOLa=ZSRR76Pjzw-S5fYq6pek_cwuhmrpH5QOTkUS4jRhUHZdA@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] refs: pass storage format to `ref_store_init()` explicitly
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000000f095061a0c29c1"

--00000000000000f095061a0c29c1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We're about to introduce logic to migrate refs from one storage format
> to another one. This will require us to initialize a ref store with a
> different format than the one used by the passed-in repository.
>
> Prepare for this by accepting the desired ref storage format as
> parameter.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index e6db85a165..7c3f4df457 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1894,13 +1894,14 @@ static struct ref_store *lookup_ref_store_map(struct strmap *map,
>   * gitdir.

Nit: Would be nice to update the documentation here, simply even
s/gitdir/gitdir and ref storage format.

[snip]

--00000000000000f095061a0c29c1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5030dd503831f4c7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aZXp1c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNk1rQy8wWjhuQ25XWnVLaFVVRXJEeDdoTG5KTUNZZApDU2FGOUpwc2hO
Z0d3RXhZaEw5Tis2M0JDa3llTXFhTVNMR0FmSkx1Q2lsQmw3MnhlUmZsU2JreXcveWs5cWRFCkhu
bThwZDlhV1YwRXNiMHpCNmFXWFZhbTNIdHQ5Rk4ySE85a29UbXY5dHhDeWxqY2JZck9ZbGhnYWdk
QTkvSlkKNHhKWDh0Z1VGcXdYRUhUL0M0U2lraEk4b3d2dDBTMzRqamNZNmhPcVUwbXJnc0NxeWtZ
cFZwNnRqM3hSdVorKwpibFlhOXdONU03QVB0aUZPdDhjUlVnSWdaUm9qb1diMnpGVGFJRFlEQ2l6
REFCTFFYbm1ISWhodXlFN3pqcDBjCmQrTWhROVh2Y2JFNmVLY285QlRRTVdaZU9QSW1odzFsbjd6
RjZGMWlBTFUzRVY1NHBUVFdyazBFanVUeWttdTAKVlgrbkcvRzc3WEdwY3FNcHB2OGtqK2lmdCtZ
N1drVU9KQnZDazRuRWNmVEVVT1I0UUVMT2lDeXFEMWhqYnMzSAp1VjBVRmZEa3JUV2tSWTlYWDg3
SWtvd2dxVEZ2dXdST1d1eC82eERoUkNHTnp4RVhYQmZVcEVvSzFEUlJVMUh4Cmp6dDFOS0Z3d3hP
WnQ1WVI1OHJ5ejdpS3BObm5SV2lwbmJVOFRZRT0KPU1aRlIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000000f095061a0c29c1--
