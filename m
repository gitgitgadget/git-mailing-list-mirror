Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C7156669
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098121; cv=none; b=hwyvuuAvJdL9Jx5pcE5DWf+fSSBiz4pF/awQ6mfyhZKwF1+i3fx8zCxgO98LDEethvqRJcBZfJiKQM8qEtvqKI+WMdHoJUcYfLIoboUcLHB2Y3Sud2Hz//V1PM82xSXTkth9vqsRb2NVQO+kSMBfLilwyvh0w6uLEFhIIkR3oeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098121; c=relaxed/simple;
	bh=lF1skujXfCqfdqo9jXayVS2lif50bLbZoUoLseXjXrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp9Obmuw1YKXzWSyPbRoRkkHn+7x5s0T89Gwx/rLI8x8PZR5YKA4QStuxEwa9lQTF3i5FhLdhnvEVEkGXUPpzaIvONfW3dqU9nHaYHSIXIFI/B3jv/qyq+seS4QEifDy5mj3Mv0PNTDa3WZHq5BHUdZIcyjQvKFP5Rji6SWZY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig+LgkjP; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig+LgkjP"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ff3232ee75so21997741fa.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 02:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732098118; x=1732702918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwgH1JBcQKC5FXupYzFVXjGyOYG7m7mOtsWK68A4POQ=;
        b=ig+LgkjPhCV/K0fcbefdmaMFAUXqbZWfVNqXorh2H40CQaS64MlXWN/tBSoxZ6+dnD
         hWphY09bvqcfke6JOYencSEsBSY4n0RIZYGZlzjjssiu+maFtPy/ZIBfNKF7xSNKLaXu
         ohwdhFjr/QnpbLexFcfACgd3PL2qKuk8/S1ED35P5RgFZ8iDOc8Nb4M/U28cJcIfPeap
         U2ewIXgrbjufGLH3uLbgnMgHwrzPkx6ZKNRzuJJ+1BPGtz/HyUNA6kMNeGhGqQ7CO2Jn
         RIRc++tpAEYST+xxGEWkkSO4FEV/DoI2ciSVH3ZbE+1z2cITrJDfFFjijV3a5vin8CiX
         UJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732098118; x=1732702918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwgH1JBcQKC5FXupYzFVXjGyOYG7m7mOtsWK68A4POQ=;
        b=su09sOYKIHlWKP0eaP5kLowTUP610dXNYidKK5jXKUyJKRlvDq/J6qEwppINU/B40W
         Yelhvg1qj9ryQl1oWzzwC4IHhs4rholDrkm7XKgVcufZKQww0v7b1pPnrhOgdhA3YQSW
         RElNAGIX0Rzt3po1pEEdCoaO3cJCqJNORSPs60bMCr0czVUFAd12hUNKOtBpBsFPCtyZ
         E+nRrWeCGlmbb3EM/SrYlPKLY9OfBZ1/LAU2CmE9NKU0sD9zXUYnw/B++rVZNywIVRV6
         zNVhqhoKvxCoyuEdugAHfyMNbKr60Weszz2UZqT0TjNDy7qNsYNDPIKR2qva0QoUVPto
         yRrw==
X-Gm-Message-State: AOJu0YzFzLJwlgMDlkpDgK+FWsEDXE9GprQ8RagviBQyKMUHFU3g4Kbo
	4mpSiGPPDHROYl0mpKp22kXBWmWjeWc/FPYm7rZwDPm1MLd/zNmGAG1WZgfDntQDj/W80igRKe8
	t4xUO6iw2SCUlM2d2aw2GnQ+6m90=
X-Gm-Gg: ASbGnctu8WkQoZMAWEHuwQrHqhMdSA/EfM/PE9wLbCFShLs+3RUOnQcUexUqPs1f6zP
	CmOnKAuwsfl/0YFpK0HjawDdAka+LNoBQ+g==
X-Google-Smtp-Source: AGHT+IGctNDnjH60/Z534ztZJU5zimjBZBUydf3nUA4PVw4joSQPu0LV+Bu5FfPfcdoNzh2C7dyJdaXMewWxAgmafF8=
X-Received: by 2002:a05:651c:98f:b0:2ff:6236:a06a with SMTP id
 38308e7fff4ca-2ff8dcf54c5mr11375131fa.38.1732098117579; Wed, 20 Nov 2024
 02:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im> <20241120-pks-refs-optimize-migrations-v2-6-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-6-a233374b7452@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Nov 2024 11:21:44 +0100
Message-ID: <CAP8UFD0i+ayKYwEitf7DYA-Hxo16d89LtHv2i89rHh9cPWR4LA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] refs: skip collision checks in initial transactions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:54=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> diff --git a/refs.c b/refs.c
> index 0f10c565bbb4e0d91210c52a3221a224e4264d28..d690eb19b3fd7083a5309deb9=
8738547e4f48040 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2324,6 +2324,7 @@ int refs_verify_refname_available(struct ref_store =
*refs,
>                                   const char *refname,
>                                   const struct string_list *extras,
>                                   const struct string_list *skip,
> +                                 int initial_transaction,

Nit: Using 'unsigned int' instead of 'int' might be slightly better as
the type would be the same as "transaction->flags &
REF_TRANSACTION_FLAG_INITIAL" we pass as an argument below. It might
also make it slightly simpler to convert "int initial_transaction" to
"int flags" if we add more flags and need to do that in the future.
(Other functions add an 'int initial_transaction' argument which could
be an 'unsigned int' instead.)

>                                   struct strbuf *err)
