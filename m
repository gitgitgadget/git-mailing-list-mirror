Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1141C3C11
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406156; cv=none; b=eBAIu1wjVrq6oUHfXIb4vK8J6wXz3pzR5ryyNusunnbQ5JgzWVx9sB9c4pk8Fqh7wKNARs93dsCaDSdyWo5EQzED2EEeq5w7qnlZG4M8ErKw6lH/sz4L3JUiUSD67jmzECJB0YDnWMM+fVNhbmMds9enTAf/VPx8v+48sBrnEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406156; c=relaxed/simple;
	bh=q6NZSi41QSu8kCagPyRB6rRQtofCqt58Jc6zQ4xHSsE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+XkTDoFRdAGCzmRv3qIxF9GitVz2DY16AdatPrSIEIDxKPiTBIfo5ZNeaX7yCajJUp7pMSXl9qorOOIMzTA7VJaOnxFypJtLItYGNZNLOEb3CirpdGmSCpb8vOEL2lRAbrGC+WxeaxqW8DhnqswUDBcsiuGT9yWxyd0ae6F+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6er+/QK; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6er+/QK"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-52e231e3d48so1926347137.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757406154; x=1758010954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6NZSi41QSu8kCagPyRB6rRQtofCqt58Jc6zQ4xHSsE=;
        b=C6er+/QKozeDjX7JrWtQCY33zFBanRIYVMlRG2vYFrt7A6Msq6Fp3cIXOqFqdpebYv
         G35kqHD4HSh5BrkWYq05re+yVa+D8jIEdyyHLEJSUeropdJDpc6ilmp4qeP6vNdZeQcW
         Y4F/OlZImRzVOBrbjihxA9XjM4c3sIqUBfKaypn6anh3D4FcaYEOL222rGQjFm4alvaG
         VPrHxzms++H9UJZUP0Qo8yGysndlJF/2wuIgR1MoOZjCCoobIQvd1kYdLhxRie/wPkaJ
         heigRtkX2vsCzOceq9Tge+WW5WzvnRgrAF3w1ILUj4ZCaobAUyHF3QpYPleOCMgUXGEX
         KBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406154; x=1758010954;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6NZSi41QSu8kCagPyRB6rRQtofCqt58Jc6zQ4xHSsE=;
        b=ipFaqoSOpcvvDKG11w18IC6moYUGkTBY72Ih8/M4HYIdHu9cyfF3nA2BC7I9lGVHWX
         e2kojohAO4+H/bIfyPRNIbagALCauhql0uN04u27pMlHeVRmgNxNuY+cDxPgocaPRdGz
         oyHyHkvrhFa1FZU7cN4bDxsLbmwfGZQzbbnt4CIUSnuT4fJQ259/tcHOe8Mga2qiJLLF
         Q5W4tSqJkiIRpJRaeByf3u/LV9u47H/DzzER9QA4Ab/v9Dcx848mCz+nIdvNOVdjeon5
         HoT6kUDnCU8VnBKHAxAGPbq+ZR1so/k+R/3TuiGqyVwPCzFYoeW+zEOXne3fdW19LYkF
         /oww==
X-Forwarded-Encrypted: i=1; AJvYcCX4GblY4JjpwRd4Rn+VQ+4mohP4ypXaNqoJl7FU4KRPN3uVu2va0SF9IQYhSThSTzD3eD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqahXcSWAL5TjoQMZLHvwQDv2EEHMFatVl7q8HjHeNlldtVVB/
	j1JuDUQifoORV2CblbK7eRmXkhy1u+TWm0mR53I5LwIm3wS0A1kDegO/3CePujESZiqzs/6DZ6i
	K5Pi4mN6RV6GapoelafJywNQJXXAFUYg=
X-Gm-Gg: ASbGncusrjehMgH3JDJGWmakIhe4Y996TMsk2miPDTxE00fY2jkKcS9o+zfIaaLRGfM
	FrbCx+ixwkVs1l5GcmC7HiWGZCpp0EsLSAyQtwSrwBtdDKt1Dc//6Ml8r6VzvKVKC4C3rqAGQ4V
	0n6csdsdEaikACmBVmd2XkwV67sWNIcQHWN6D3pFoeZtpX4CEseoJy9aLUTD9WnFg5pIsv6RLuS
	xyff2mXedxJtl8k
X-Google-Smtp-Source: AGHT+IG9GjfsQkOF35zM34qJnCiOnWb9bAIKL39quOA7g8uWtnFDp4AJQBNGtkHJncMlbwAyKCUdsQ/2mNEMjbZg2+k=
X-Received: by 2002:a05:6102:8025:b0:4fc:1a18:aaa2 with SMTP id
 ada2fe7eead31-53d0d61d136mr2695312137.5.1757406154020; Tue, 09 Sep 2025
 01:22:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 01:22:33 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 01:22:33 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-4-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im> <20250902-b4-pks-packfiles-store-v3-4-6925278efeda@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Sep 2025 01:22:33 -0700
X-Gm-Features: AS18NWA7r0xbLwusCFeJJXzIB42nCCD3Qn5VlRTLzWJsXeMdk-uB0oaH6_lEuF8
Message-ID: <CAOLa=ZQgC5LgVCtjVyfd8xeTajwWon2YQDkwVYbK_FRaBP2o+A@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] odb: move packfile map into `struct packfile_store`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000897c44063e5a0153"

--000000000000897c44063e5a0153
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The object database tracks a map of packfiles by their respective paths,
> which is used to figure out whether a given packfile has already been
> loaded.With the introduction of the `struct packfile_store` we have a
> better place to host this list though.
>

Nit: missing space after 'loaded.'

> Move the map accordingly. `pack_map_entry_cmp()` isn't used anywhere but
> in "packfile.c" anymore after this change, so we convert it to a static
> function, as well.
>

Nit: Okay so we move it from the header to the '.c' file, since it is
only used there. But we do loose the 'inline' hint, we don't talk about
that. Any reason for that?

--000000000000897c44063e5a0153
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: deccae2649bf9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pLzQ4Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3B4Qy8wUkV2TzFhbzdySld0UXJkM09nOVNFQ2FYVwpmQ0pVR0xMOUFy
Wkd1QUg2LzVZTjladFNnTEpzOTdGQTJLRUk3bXUyRFJpb2Z0U25WN2lvNmVsckI3S2NCMHBRCnZO
cXhrYkg3ZDdUeUxsUWpwamN5bXB2b1lvRjlSYkVscnlOcFlGN2srck5RVkVrSmQ5UU9NeG9GdUxZ
aGNmT00KTTByL1dwUmRRK2lhUE5KSExyVndua3JIb2ZLTGxDeXlkSm9BRWZXMVlFcXRiN0wvTWRW
dENpcTRNTWl0Rk9MTgpWa21DeW9ONTQrNVhocWNzbEtLOWFaQ2tjV09YTnhRMFdDVXB5TCtiUTZs
UnBDTlZqSE9qVFc3ajFnSmExZ1dqClFrRG5CVnR5OWRmZ05uU1FQOVFqdERBNXE2QVRCWmlraGFu
K3ZjQkxaSW5STWQ5L3hldlpSWVpQaDYyaGEvajkKY1VHWnFHNmxEUlFzMVVwQWw0MTRxVUtjUUNj
OXV4VVYwTlFhaFR3SE9FNUQrS2ZrdllNUjB5ZGh4RkFBa1JWSQo0Q01RMXhhS1BKRm9uNUxJeTBw
SFVLejNBYjBiQmZGY3RLRU1uTFhZU0tPdkJ6cG5OVjAvR1RyV1RMdm5KbS9mCnExTHl2RWpoL2tx
dXVuWEpSSzcweW9mZitNMDY4SUp6NEhyREJNQT0KPWE4UUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000897c44063e5a0153--
