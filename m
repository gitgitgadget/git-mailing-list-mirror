Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06D139D
	for <git@vger.kernel.org>; Sat, 31 May 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748726762; cv=none; b=vDbw/ZhsWgJOL4kRrfTUafQ3tW5Bz/U26r6osl/DQape53F580tIatXekB8nKkGTQ9nNQCS+vnuQX6rkQsoHtuOMNPSr3fjVWkNZKIl8cJnQF7bMbmFVFq/QLgArSbPNRlWKPJ54iWRCN+CyRK04oeghHk9xHpz95HhQlCCgVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748726762; c=relaxed/simple;
	bh=n3NNq7m3AxCCIUlr3Jal0ogNzdPfpnh89d3hYGcAPss=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cgdo84NOt5eWE4WATSfhJvzWzSsewOViyNJrOHq71qnxmKrplrl+GPHTiBjDJmFxAXK+w4bgxBR3d2S+rKGuekNKHahVnWNuL6zeVxWHYAlUkOxZoZryugTCrSiEH/B29DAYGBgpk1BNJw25NWGVBoG0NwQ0zxJibSKkAAS4SJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cziy9KTB; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cziy9KTB"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52f298abd9eso2076403e0c.3
        for <git@vger.kernel.org>; Sat, 31 May 2025 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748726760; x=1749331560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3NNq7m3AxCCIUlr3Jal0ogNzdPfpnh89d3hYGcAPss=;
        b=Cziy9KTBGtjY1swRaibBXiLRSlbspz+ZM7A9upQRdHU7U9oaL5qjjopOAczvLMn6kI
         O2xhj4ElG+l4o5rrgHx/piD+NKOqCWjn2a+prslSwAGOVyCzDjVpE0vnSCOBztmVBUmn
         H77Oi1ucIF8xrIOmT7QTxoCwe6KVXx1QUbV/TtknqhAOQFd7nzId2IkuDYJpGRq0n+aj
         gmQ/+BJHQWrxdyKckrKzPGICQQ2flGNmfSXXmKogTNRwh2kz3g353wkjTbsfOBcJ3v46
         gA3Zq9lUNbgVpkfEEOIwWHZNFbFKSEBKP+A3ibK/Y+jkcQUlUEfthltSak13TmJCzccO
         t8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748726760; x=1749331560;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3NNq7m3AxCCIUlr3Jal0ogNzdPfpnh89d3hYGcAPss=;
        b=J3lxx7TXI+aip8PZN0pFc0LGIQ9qb174CRJ8qQqoElwSo0TF6QgO0FtM8qg3gYNOxA
         2qUf44v4Hf0MwwnwYpxt82+vvlAdJrp8dKtxJVJufYB58hHJAf7uDgOLzsRCTykQClfn
         OYPeO3zI/35GjGx9hu16RnMbgmBvLL4NhJUNWig838sMLXktBILFaV5j49fbUUJJQjy1
         Ls3IiSVfh4ABS1zf/+tzCRwR8nq6EQcUeRvJ+Vkf26wjp/ChATeiFr3lvh21/5gb2bGa
         urhCAjXL6L4R9osR+8FwlLLEH+bYydietUDGG8zBTaDJ6d7RO3AZN21VklnMQLV+0TNZ
         LPFg==
X-Forwarded-Encrypted: i=1; AJvYcCWuvzj3uEaNb18dtmF1ri+y0ThDDF8GYUWybHYItlZevprqInwO/Z+Pyx4kj60vKygCt/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YytbP6KXHbsJxIwgHDezCqVV2wz22Bw7aASY2QfHBHtdY3IDqqD
	UdX2CV6/rYeq5NW1W/wKfgR6OMJATaGBJUO/Ju2fRnxsrk+81g9omidqTkmPQlRJxoGrzn5+c0/
	BoMGG5iKPRee084H6h4q1rQnLQ0M7vpg=
X-Gm-Gg: ASbGncvqV8JIsEIGLO9uJfubwqQmaUdzYUXhLJcZnv9U93RCJ1mU1frMggZIv8yhVv9
	R83dWlrpyBLWZwhaLMx/HhFGkkN9EldXmfh+zWQQz5hMlK3gFIutwdT5J1Pzpm+NLOd19ZVBfmp
	jBOq4u6aByKWIvkSXj7JcE9BAkTq8CGNdK1aA6D/l1n3U+70DRkl0KPmPjuBxdkKr9GWo=
X-Google-Smtp-Source: AGHT+IGS8YmbYorCiPfgUW6sLikIMkHLYnT118QrEbqf4dF3So1Dt5unRzFW+gThwa1RhfL3/LbGXOa2csq8WkPJKSE=
X-Received: by 2002:a05:6122:1da7:b0:530:7e05:3836 with SMTP id
 71dfb90a1353d-5309378fc36mr2163747e0c.9.1748726759702; Sat, 31 May 2025
 14:25:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:25:59 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:25:58 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250530-pks-meson-tap-v3-6-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im> <20250530-pks-meson-tap-v3-6-676f5e41f2e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 31 May 2025 14:25:58 -0700
X-Gm-Features: AX0GCFuwZICL7MmFBjWI0p38KozwTBmFLzu5t5BJwSQUwnXaEyF1mDxnG4n8xcQ
Message-ID: <CAOLa=ZTgUbfdtb+R_kLps-=75=euzoMDi1OSM9O5XL_3irAZxg@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] t/test-lib: fix TAP format for BASH_XTRACEFD warning
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Todd Zullinger <tmz@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000526a760636752da2"

--000000000000526a760636752da2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When the Bash version is too old to support BASH_XTRACEFD we print a
> warning to stderr. This warning breaks the TAP format because it is not
> prefixed with a "#". Fix this.
>

Nit: The important bit here is that TAP treats anything that starts with a
'#' as a comment. Everything else is parsed. Since this is warning which
shouldn't be parsed, we add the '#'. Perhaps worthwhile adding this
extra context to the commit. Anyways not worth a re-roll.

[snip]

--000000000000526a760636752da2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ce61db665f4651f6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nN2MrVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLytVQy80M2dnZVlVU083cmRadnlHYUcyMFloVmdkMQpsZUhrUVU4cWxI
NTBFekdlUVZzTSt0ZFplK2ZTdTFseXorMTZEU0pSOWN0TGhzU0hLMG9EM2svbmsxY0JEcnJsClNY
UHk1U2dGSUZCM1pZM2l4K0I4UDdkQ2ZTVGgzRFZHNHdoUHF6bnRYSTlnYW5jTDgyeHVYdnZ3alBV
SVJ5QWQKTVRnODY3UmNhYWdWVHVUYUcwcjFOUDcrZXNweU4zaDF4eFo4blZiVlpkM3RWU29xdjhi
VmoyVmJFckVFSnVvdQoyQ243Q0Z6M0dNSkNNUEg0VWlvRUhtazR4OGdoNUo0bG15SUlYZzgxQXdn
SVlGNllkU1JnNXBxSERjM25PZmdQClFHSzkwN01RY0hwT0NHUTVzQ1FjenZ5cUdUVnM4TmZUc3M3
b0VUSG5jOTI2Mnk1S3NoWldPdjMrZ3FNZDdVcUsKTjE2YXo2SFIwanpISnVVNEQ3M0RCdVI1aExn
SDJFY3VIWUVZUjJmelBRdUJ5aTJvZjlicXNHYjlMQnM1b1JtRQpXRkVuSS9tOFlIWHFjOTc3UmJm
UUZkMlRScy9IeEYwRjRuemlwdUxFZmNGQlpJUU9nZEdZY3ZWdEpTeGJhU3l6Ckd2VWg4SzNrdXNy
UGFTd25rMHYrb3pYNVVGU085YkNiRldPQWVVUT0KPVNUYk0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000526a760636752da2--
