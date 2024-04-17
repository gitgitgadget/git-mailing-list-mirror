Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F1130A4A
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372650; cv=none; b=iaVYIbjRVLY5tVEZh2e91hIxJuOcqhpkIAvt1KxgypvtzbmFsOhPbTAS2V7fC6Et5KPL5vq9/FKy8eygDxYB3iNE5FgRAGz2RHh2AwAR/tWAGZo9U3RF10yMyoosfvBF6J8TBWOjCSEjM4zMpVkqzS0zcYlAjmM0f9jZjLtOW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372650; c=relaxed/simple;
	bh=Liq6NtjExWCStqP0K6jCHS4rKOfxfX2HXzVK8h3BiFc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/NNHqTHIIzN9gLKsh4EXntdvshaOm/vNcXLlTkuzK3wPdGRo33wkaHXJW7MuWnwvonFbe/lbQVwVooCJMfsAtTBuOlfOLLDSlrzuiBY2wZrD1WrDFGTHyC9Hz8vmFifEHu9oLghGu5hQg5giEjBV69R6x7h6NoqjNCT5tpNQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtSJ2h20; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtSJ2h20"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22f746c56a2so1442fac.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713372648; x=1713977448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Liq6NtjExWCStqP0K6jCHS4rKOfxfX2HXzVK8h3BiFc=;
        b=BtSJ2h20asOZF7MXpu24Njf+GTxVBLofP1EMfuDO8WTBXICA42vXZQMSV4T0i5kfld
         ZF9VUrC6YJ4St4gKAfdzdBve30oPJ1t9667psojEC2ry+3SClb2WCSI+bQo+EYkbQWD6
         yHy/Ci0jJAA3MpTWPFZTe91ihvpElF71d0kZG80hLGkQ4lG5BbZAEJCV3sbkqF1D1yrg
         MNWFVSLw4Gx6HfzhrZlT5/+hi9cB3DgX4NBxg85qBvP9LtBW21qA71D5o9WXnkxIZlU7
         1VOzrqPiib27QmbuJ9tLXL4oXt3SSjE+QUcSOVVpnt+ZdvLXPLycY4Y2uHkgswXiEzjx
         UIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372648; x=1713977448;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Liq6NtjExWCStqP0K6jCHS4rKOfxfX2HXzVK8h3BiFc=;
        b=ClKTNwyhr1/Jlw9leoWQRqLtvN9tV63Bbfa8nsSIYdXb7ReOKFGhYIEEOmeV9XeOtW
         LwMgA2jYJDCKp50tFXKzV0t6p/e7rKVtojUTF7Jy4h0SSfmrfflAb0SzThbX18cVfZWk
         tClJ2Lw0gPBmaPJhgZyht0E1n75EnnUJRl6YmAJ5bRf4jBTR6H/srjS2jkB0zzDuWKj7
         4fXRx6z55lql1T8uLSI5Z3y9QYBNxB0d4BvwPeA0KMv8utmp8Owxxn9PGdggMBY1/eE3
         t4PiX0DmGzb1r4RfON8wMxpDJIBGBeNTrgEcht0JWEdwD1/JEiBaw2WIeuvofaT6x6q5
         Nkyw==
X-Forwarded-Encrypted: i=1; AJvYcCUiVxmo2HKqzeFlSMOhHPXTmVTdYj7oisjQb8Kx+k5+MDcqrW1/0s0/Akv1vuScKRb27cF17uGmupI4foX5THxBPjrk
X-Gm-Message-State: AOJu0YzLFyLjlxs70ouyjvFD+L0yNeypMNdIcqRLZXFzYGCE9kCTAM2M
	jpjRguDuw4je55JiZ+94lr2ScBmGu2sUjCWzZxKlv8sOis+Xq1GPkURpEO/B/pBgUTNX0SHamHz
	DD4UimHfkR9RNQRYRF8UbX3JGX8o9iQ==
X-Google-Smtp-Source: AGHT+IHItzPjO1JNlJ5iGIWL52yJdZhU3hUM0pPxXJ61W2p7gqN2DcMeJffwIux6UeS8rDNhK+HWIc/ddD35Qas103Q=
X-Received: by 2002:a05:6870:2308:b0:233:1027:af37 with SMTP id
 w8-20020a056870230800b002331027af37mr89890oao.45.1713372647767; Wed, 17 Apr
 2024 09:50:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Apr 2024 18:50:46 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <c7bcc83d3a96b613db4fba9edfbb6d964b338ed5.1713334241.git.ps@pks.im>
References: <cover.1713334241.git.ps@pks.im> <c7bcc83d3a96b613db4fba9edfbb6d964b338ed5.1713334241.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Apr 2024 18:50:46 +0200
Message-ID: <CAOLa=ZQhv5m4RPwsQg1F2zLU86qjE9Ew6FhCpOsPWWM3FoHATw@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/receive-pack: convert to use git-maintenance(1)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000009e0c406164da859"

--00000000000009e0c406164da859
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In 850b6edefa (auto-gc: extract a reusable helper from "git fetch",
> 2020-05-06), we have introduced a helper function `run_auto_gc()` that
> kicks off `git gc --auto`. The intent of this function was to pass down
> the "--quiet" flag to git-gc(1) as required without duplicating this at
> all callsites. In 7c3e9e8cfb (auto-gc: pass --quiet down from am,
> commit, merge and rebase, 2020-05-06) we then converted callsites that
> need to pass down this flag to use the new helper function. This has the
> notable omission of git-receive-pack(1), which is the only remaining
> user of `git gc --auto` that sets up the proccess manually. This is
> probably because it unconditionally passes down the `--quiet` flag and
> thus didn't benefit much from the new helper function.
>
> In a95ce12430 (maintenance: replace run_auto_gc(), 2020-09-17) we then
> replaced `run_auto_gc()` with `run_auto_maintenance()` which invokes
> git-maintenance(1) instead of git-gc(1). This command is the modern
> replacement for git-gc(1) and is both more thorough and also more
> flexible because administrators can configure which tasks exactly to run
> during maintenance.
>
> But due to git-receive-pack(1) not using `run_auto_gc()` in the first
> place it did not get converted to use git-maintenance(1) like we do
> everywhere else now. Address this oversight and start to use the newly
> introduced function `prepare_auto_maintenance()`. This will also make it
> easier for us to adapt this code together with all the other callsites
> that invoke auto-maintenance in the future.

This commit explains my earlier question. Thanks.

--00000000000009e0c406164da859
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9175d75d470474cc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZZi9lUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXZ3Qy85Q2ROa3lCUmY3MElkYjUvbmhJZFdjNFRsdQpPcDFKZjdnd2Zh
emJ2bzE2dldTMXV1b2M4a0lHVUJsYW1XN0UrS1RzSld3Zy9iQjBORHBmdkNoS29abDJxazJtCllU
TnFxcVJmZmowc2NkK3BjMW9VZlAraWZhVHNLd3hFdzhkMG1laTZzZVJicXlCVWw3end1d1NpWUxp
SkdMcGoKbjJTRGZoSk5vMCtqN3ltOGlKTTEva01obk5zcncxbWljMC91c3FWOWEySzI4clB4b25C
eHlJM0JwejZxNGhhSQpJL3dtTTJSMHVpU25ZdmxCcHpoNkxkV2hUc3BxL2gxejlRRVRkbGgwRExl
QXBTVGxOaDBta0t2SnFFRmlQU1l0ClBkbnFyVzduRkpPK1FwTjRLejRJdWNKbG1ZcGFrSWNFdlBl
YTFBc0Z2UzgxdnNtY09DaDMwZnYvZkJwUEdsdzAKU2t6YVlsMkRqK1B4eG9yOTNCdVpYenlkekV2
UEdSejd1MzltbWloTWx3ZjNYT2p1dHhDY2s0WTBJbnFHaGhmbgo3UTNEM2lPUEY5MXFUUlNoMitQ
K09SL0JwRW1GMmdZVnFEbFFNdEwvYnRnK3FuUno1c0loZDVLMCt3NGJMUDhZCnpWay9ONXhRUzJt
UWkyekhqT3RCaWJJUmJRWjE0WlFoUTRGK2R4ND0KPXMwUnoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000009e0c406164da859--
