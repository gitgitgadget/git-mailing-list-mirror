Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538E29ACF0
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014101; cv=none; b=XdKOMgj7kfpYwYLwQLyPkQvxGHEc/tnuzFDCz6CSxTZWSvFFYamKAzIqlKkfDcef2hyImhy2hlkSwcNUGVSKgnB+edCv8vc7pbxuwJz7dUC/Uet86tKt7S8WW2zEymIsY2JMgtKkCHvImiDkavLyN8w2KWNJcezuYp5VSsM9MWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014101; c=relaxed/simple;
	bh=NWTCWCRrIiOqBBZ3iptnAlHr4bCuT6wbSSnQyRIEu/U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmdqVsmFRBk2tjOlIBuCr/OWexqWzPNVd+txtVSxx+zgR+I182vFw/Di268NZI410cf2/vUN7ZmW+2aA2/tQwvr6QPwIYCSt6xcpn1xiesjyk2R48Dul6RkU9S+xXM7mE8fpxgfinaUU0nUo0TDj7dBWNm21mpDt4e2Suz4Lmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT5cR5EE; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT5cR5EE"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-529858dc690so1623207137.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014098; x=1758618898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=47iCAej9coVjRBx9oxXNPm3yZAvSDUaDXzHFWiqb8Dc=;
        b=FT5cR5EEAo87p66NCi2BJXL1tt6eG4xah0A2NDmepmT3hSCt9hOzMS4Wy+2GfiZ1Hk
         PkAAqLForgwzhi1Hi2upXpymx4Ts7A8C5N8k65qSO+OiC4262xce5AHunpYMbhvIVwnj
         JKOLwpTeRxmWf4rAboHTs+/BXQmjSTDse+RTMq6DA4zjIukyqMBBwihzTkuWHHIjYuTl
         +MC9d3BkBDU5rg3tK4iaekKqvwGevFW0hooGmuAtvQr+qsa4nggy4RA2o2NBm6ZDtmXx
         4lJt3PpCgNfOYNfeDFzUkarl27P2objSxlGIVItyZCz/3XthZY9+NyFN9meOs79o+Sbj
         mwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014098; x=1758618898;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47iCAej9coVjRBx9oxXNPm3yZAvSDUaDXzHFWiqb8Dc=;
        b=fVubgm/srqkX0CQOfm4yYuiI9m7IPKXT0fto9L0uSX7OQfvEGYjgktKrAcsYt0Fbb6
         ynEHxFvAgsgBpq8P0XAhpC+3y9yiQ927p0DCmRTTaBU47DnoVwvxsBk+qkk0T5qK4VB0
         NZgetByz4oGo5D8tDfFxTg6iNDMafq4LumSl2iS95Y2nsluVPYCfpuPB7Yeel/0PJKid
         P3uOe7Kb8eI35qTVrT+HvUM1JbTuat0ETchJ777JIqdgYFRCk9Vl6QCTeTv5X+z7Cvnz
         DmVeAPDiL/3LiMse3RVogZdP9rWM08BMQ6PksDLaSBPQrNm6XXJD881ePfUIS3dvEhDy
         2vPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQvhezFmRZLUc0zMthZlzJEnZqb3t70ECNCOMUnTTZ7wTMn8Ovb20mmKaV6WN+Qe211nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIUjSo1e0F5gTc7Ibe0FnwJfrs1gUkqlVVf6ijdmFtEYR43MR2
	cbwO1FW9+PV7SqmWsJlOpYqCQRUTj60ohYlG+AMgCEVVnAw8R/UcagGD5HSnCTs33PpPYKgmwc8
	rDbTVkc/9v5UmVXHJmj+UvDAFLj4gr4c=
X-Gm-Gg: ASbGnctlxeSFkujQjRsctTDDTn3pwkrwZzCsmKT5dhoMEkuZX03yLaizDRmojElzC7y
	JYyV6RvDnQ9/iGkR3NyoTpcnuLbtbCzpCd7Rrp04thrHgGI1Fc3z++g3y1OSCZpZCZ7tf6HnTtX
	ValM1tcvj8Z8LJlp/hpiYo1la821+9AKoWDpxfSFTs9mF/1E1nuABR1xhT2rctFX9WOGNZhZ6Xg
	nC/ZJUpdF9lWjuNeS3g5jJFXO23CYJOYA4JQFpFjg==
X-Google-Smtp-Source: AGHT+IGUhYHp27O2acexkc9LM1uQJk4vxc0rE4QrDUlnXPUmgqCsLsARdTwWAqaS9M+WdnfverHw55Tur35L7U0MPLA=
X-Received: by 2002:a05:6102:2ac5:b0:538:f3d5:fbf5 with SMTP id
 ada2fe7eead31-5561119ff88mr4719703137.30.1758014098504; Tue, 16 Sep 2025
 02:14:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 04:14:56 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 04:14:56 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250911-b4-pks-meson-docs-target-v1-1-a92c666ecef9@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im> <20250911-b4-pks-meson-docs-target-v1-1-a92c666ecef9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Sep 2025 04:14:56 -0500
X-Gm-Features: AS18NWBh1NzlIoai3ytQDV4W_lPkS7d-5ObrzPExgzXPqIJbpkgIneWXY9nkqFI
Message-ID: <CAOLa=ZRVaBp6DAM4gYXFjCRORYxObvWn5egrPAOcGZ42mxnsgg@mail.gmail.com>
Subject: Re: [PATCH 1/3] meson: introduce a "docs" alias to compile
 documentation only
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000da22e5063ee78d93"

--000000000000da22e5063ee78d93
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Meson does not currently provide a target to compile documentation,
> only. Instead, users needs to compile the whole project, which may be
> way more than they really intend to do.
>
> Introduce a new "docs" alias to plug this gap. This alias can be invoked
> e.g. with `meson compile docs`.
>

So earlier we would compile the documentation always (while the
dependencies are met). Now we move this to a "docs" subcommand...

[snip]

> diff --git a/meson.build b/meson.build
> index b3dfcc0497..40b2a2dc54 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2101,11 +2101,18 @@ endif
>
>  subdir('bin-wrappers')
>  if get_option('docs') != []
> +  doc_targets = []
>    subdir('Documentation')
>  endif
>
>  subdir('contrib')
>
> +# Note that the target is intentionally configured after including the
> +# 'contrib' directory, as some tool there also have their own manpages.
> +if get_option('docs') != []
> +  alias_target('docs', doc_targets)
> +endif
> +

Shouldn't we also add it to 'meson_options.txt' with default set to
true? That would ensure that `meson compile` would also build the docs.

>  exclude_from_check_headers = [
>    'compat/',
>    'unicode-width.h',
>
> --
> 2.51.0.450.g87641ccf93.dirty

--000000000000da22e5063ee78d93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 121d7e83b2bea914_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSktvNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0hvQy93TStzcUJxL3VRZ0M5bGozdU5sQjhSOE9KKwpubDhxejgrc2tu
QXltbVU4dGczU0VjNXRxL3JsOFN4anlhVkQ2YU9ZUkhhWGJWVlpnTkprUlJobCtCdXhDUzVyCmU4
dmtyVm9EUW9sM3VlVEkrcU95bUZyQUdsWUduRVdwSFB6Q3J1RjZjcFA5QXBJNEdXOCtkSndPY25k
SGJyMVoKT1BtV0daYlNVSWJWejNTeWV4bjNmSjZjWnhTd1VVTzUxQlBIOGJzdXp2a0J6V0d6dG9n
dHRQRFpzK2tsWnV5SAp5R1Y5V2pmVXJMQVplMVJPc3VMRS9aSFFTdHRFUm8zbnd2Q1BYWThFbkhm
RThRU3dZL2xXWENxa1Q0dzhHUzFICjhOWFZlSEZOOW5FaG41MzBtcWZmWVZqL3cxQTZ2bEFmS3px
M2FTYnd3bm5FalpRRjRjZS9NL0hWd00rVmk4cW0KR3pMRWtJMnpUUWd5VkVQZGJaRkhTSVN0Wk4y
OE5wZ1B4WHczUTNSMk5IQUw2OW9VVkQ3TnpRNXZzZHpEY0VXagoybndOczBsTDYvOExMMDM2RUY5
U1lCaXdoRWIvL0I0bENsc3I4SGszNWpENVFVamJ3d2pkdjlPTHJ0eTVzbnE2ClZLQUVnRTdJNGkr
UUNJRGF2cW8wdUJ0OE9kemhJL3JKMHRUN1lWQT0KPVhMNmUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000da22e5063ee78d93--
