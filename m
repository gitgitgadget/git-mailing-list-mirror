Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC50261B70
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177154; cv=none; b=OZZFmaB9O4bDZ4ZRC/Ooopfp3xhJhsWpcuV3tTxpi3ieJG3QmwHYELrHA5KITpitPrCs6GPgMkpxon7eGy1wxgxJ0mtYYLQqTC64BarmqSOWZvUWZb3sWfPxJQc4sunhynyk47bt8rqXXGGOkSxlyv7ZxxzpFpGJ1GkFg8hJt60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177154; c=relaxed/simple;
	bh=Vqmo4xYhyMbR1xkAr8rSNYXjm89mHerATpbcre2R3tw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kriC5ciUFjemRzWyNCL1uxWZPNURCf73mqM6h60SpIO3BPuqbzkUk9pLuFDYz4qzV9zNc3H4jF3CJodxXQxrrmHg0utWQVra1LJFWeSBcDPUM/Xkfz259Uwxb5Vye8SdILe96q8joYP+3geRB1n9VMS50mct1RilTZojvqYofUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXGQicg6; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXGQicg6"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ce093debf6so4903465137.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762177150; x=1762781950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yikK3qi21rnxsc2ielfGKwF3JQytSGfgHAac5xUw51U=;
        b=cXGQicg6BhTHoBP0y9vEROrCWU1H5RmqGNIwwaUsKZxdHJyx+7BKRCNrFHS6c3rHWM
         1FxV1Htanuj5/5FpNJubeiQO6S6i7cDsW+OBiW2bff6hs1rtzG9382/qsKwbzoHcPgA5
         AWXswjm4DBcHABb2L2ntV8taa3W9svn3Bshf7hXrf2uE+mRQFStRubg4xeMVD6+UdAUz
         iP7q75uS8czj8oYFXs35nZnL8B2jYxiQz/2rGXRA8zgkLuN164OzOWGzy/hA/Dt8a/Lp
         pds40IpPhF5iJvLvch32guzLRQHfGkgGGD/c3kB6tlLggPanCsvR8lDP/MF6NoNcLqtl
         jcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177150; x=1762781950;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yikK3qi21rnxsc2ielfGKwF3JQytSGfgHAac5xUw51U=;
        b=fdak+rm3V5zqJI9GQ6GJi+HlSMhTadplLXuktlqP3ExwxEAdqwGN2Dp1YlfbKSZfo5
         NSeZVMeqo8s2VmyV4gCuxvLnNF0NrBirgfrECrAfb1soFCfQ4NoIOGtlkaMEp58YYGWE
         zhwXFNhAAQzDdiOfrH7m3PrvPv/sZrHShSqS54d4dYAMOw23caOHa8pIGdZThfJ2eT2/
         FtjF/CZwSnUgkBvcl6QKGktrESypOoQrXIGgSF25rUBUQDaD9gaVqSyeeAdWk/vpeM/A
         hLlUAzBmnx7R68D2hDI3xI6HikFFMAFYZY2G2yMWZ32dVlRxgWBSKmr1BUf0xE6lYNEQ
         gLyw==
X-Forwarded-Encrypted: i=1; AJvYcCWkWmfdzNe+SSY0HpIxwYAVArjFNg9g34Lhh1u7nlrw0NnbNQM+Xii+fG1mlvqwsM439OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfctMG+f45TsqlFCqUgTwMOSBX/OHR/gNNqqvFWo5tPpS88d7W
	TbIu8+xCFdpyRohdsHlnONa3eccSnY/URlCDJOnFTm4ReyCwTuZxo2m0sNbRvW2n0/xVXV+s9WU
	LDKhLjc3pUmAsC9iHJYpQObX/qvhc8iI=
X-Gm-Gg: ASbGncuKgqq4ZX9DtX3pqY7YVK2qpqQkehbFMkeyRxFaPFlV0JAVj8J9qgXAhow8yXx
	2yZ6OGl6LwcftK7IaRzGYy+HgtRSo080NLahTpwoiGQ2mZw4g/7IaddA1VgU0juBpeAipikZCFx
	GtVqpk1ZNwym/PbNKR4XvxNm6IN9PiinR91rlQpjbRm2/c39kLx38aUURpsVVVPTsFPFqZUQCPu
	OtXgorvA8W/WFBKY6UccIpyM3SdGWQHdHR2O2tYn0vFEUFkD7IKjriI4/VZFJyaVhraQsWBe97P
	LSY1s1FPO5QqFvuQbdhJVR61qg==
X-Google-Smtp-Source: AGHT+IH4rawlDFKLAnfbxvxr8rnsMimVLvtSuaAj0NSWgizzEo26nJRW7lfeVeESlXObU4HA3YzT9bTqQJ1qXOeoGLU=
X-Received: by 2002:a05:6102:6cb:b0:5db:e6fa:f7fe with SMTP id
 ada2fe7eead31-5dbe6fafa2bmr641433137.24.1762177150236; Mon, 03 Nov 2025
 05:39:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 05:39:08 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 05:39:08 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im> <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Nov 2025 05:39:08 -0800
X-Gm-Features: AWmQ_bmMjIyrGfUN8vhL90PBtJF_xkKwW6DIijkZoqaPEihTp8qopne5domGu44
Message-ID: <CAOLa=ZToV8KvgG44Yn5QniTNYwKo2d1QS9ngfazQ63uOWrc60A@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Carve out loose object source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000001261910642b0d765"

--0000000000001261910642b0d765
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> Range-diff versus v2:
>
>  1:  330b7c17e6a =  1:  ed548a7ee4e odb: fix subtle logic to check whether an alternate is usable
>  2:  68b2e736d20 =  2:  59d5548ddfa odb: introduce `odb_source_new()`
>  3:  b6f9a3f6d26 =  3:  a417bd30153 odb: adjust naming to free object sources
>  4:  fe38c58ab20 =  4:  add2b7d112f object-file: move `fetch_if_missing`
>  5:  5fed6e7c429 !  5:  5245ba0c6a5 object-file: introduce `struct odb_loose_source`
>     @@ Metadata
>      Author: Patrick Steinhardt <ps@pks.im>
>
>       ## Commit message ##
>     -    object-file: introduce `struct odb_loose_source`
>     +    object-file: introduce `struct odb_source_loose`
>
>          Currently, all state that relates to loose objects is held directly by
>     -    the `struct odb_source`. Introduce a new `struct odb_loose_source` to
>     +    the `struct odb_source`. Introduce a new `struct odb_source_loose` to
>          hold the state instead so that it is entirely self-contained.
>
>          This structure will eventually morph into the backend for accessing
>     @@ object-file.c: void object_file_transaction_commit(struct odb_transaction *trans
>       	free(transaction);
>       }
>      +
>     -+struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
>     ++struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
>      +{
>     -+	struct odb_loose_source *loose;
>     ++	struct odb_source_loose *loose;

This is one of the points that Junio mentioned and I think the new
naming schemes flows more naturally into. Nice.

The range-diff looks good to me. Thanks.

--0000000000001261910642b0d765
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a5511af5dd994dc9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSXNIb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHVDQy8wUko2eEpQcGUwSks2L0dRK3NlOThFaE45ZApuNm81L1lsRjJy
amM0QStIZHAwbmNBeDB6WEhCSHJ1WXhhWTF4QzVMeVlpY2lNdnZaK0R1aHNkWmRSeThnQVVHCjFN
ZVpOUnFVbGsyZ1NLWkZGZDQvczhkaWxkQ2tyNklIMkhyL2Jqc0Rwa3VXc0hCNkthWnpFaml0OFZ6
OHYzZEgKVzl5ZDdLYmRjNWNLMXlZVHMzU2dWblpJNUR3R3BERy9haFlVMVY2UGdzcHBHR0F2UWR1
VXVhTjJ0YmJmU21IcwpWOEpXYlV4VmVaWGk4b3N2SlV5aGpTT3VKTmdSTmRFK2EvN2JWak9WUlFa
WW5kRUMvbTlmU1FpWHc5OVJMYlIyCkhwQUFVZVJITEtXMndHbXVOUnd3dTJjQXF0MmJ2ZTBqS2VX
WTNUUzVYaEgxeURsd2RQUkhLZzZyVXdBYnh6c08KQVhqWWVnbDZOakppQ2p6ZmpybW1EUzRsdHlN
WW5tejdjNkhCWDNLUnhFNXZveVV1eW1zRCtONkdDYzhSUnRsUwpYL0VzRk5DSmwzYnI5bGk1ZXNu
TzZzZXhHeWxoWjk0NDhvUUF0NE1XTGhZcndEUklzVm96ZWZjeTF0Mkxab3RuCmoxczJkcU94a3pq
OW1xdzJCKzVqaXg0ejRJVGwxWWpNbjFjSk4rOD0KPU9CMHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001261910642b0d765--
