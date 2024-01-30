Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC7C86AE7
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633789; cv=none; b=LQVYptA3UrbmRTiiUcxYT9wXcwp4nGu16GeiuYqqfxkMgvIq0HhZJxG2K9u2xH5I5XKjaM0DTShqKbFEbBeHwKXvm5JJ3Cs11mxpkiSYfXeGzoFX4uMXpTtQr1nGt3s9+dh/+uLW6FvkZXouRmkpOGyOpvCeWQeok6lBFbAYNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633789; c=relaxed/simple;
	bh=hNB6MPmy+h9Xnx1D/Z5nASsbHVVA4r+etADuRhdOs5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxJgReq6Fob1rqu9e3IlbBDL/Dd7D5r1qEwwhUC//UtBF6J0L4g2ApMKI9GV1ulvclJ1pifZzlF2FJIGlGZfs3wP2veUBTUnS6PMWPp3n85/j3h2klO02itoT7u8o2r5hpNxOHvF3M4dg1KfcW9hBXNK1X4yOtP8uOoPE6ogAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvDccGGI; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvDccGGI"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so2179984a12.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706633787; x=1707238587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgbpM3rClbdciPjoHKZYCbmjzzbjdMICRXHXsLaBZjs=;
        b=TvDccGGIGY0FmUnZ1+6zjDLj9lqyleR+RYE3h6Ma+TAM8IADoZN/22T2TLLWDKwxam
         3HmfYKO6qsry0Wrx0YR2TwvA1kONR4IXu9ZWMnVRIi90gfLji2kZcCZoumHoEmo54xN+
         Sh6PH3ATYueds+BzImno8mYf+IeBjNFsXqQyi8b+8tQDUS38ojVn6DE4EBVa536RjL/p
         l10NVfr1Y2dZqsKztT5J5fk663f8ktlWe2S95McPGsYk6nz79jJEdMJBJanxELQZhwst
         FMSXHZvXdNoy/mmhtX644y7Ret1JC/FGof3kQiWJqB7wIpv6qu4nqQSDNCgVB0w39bcE
         7c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706633787; x=1707238587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgbpM3rClbdciPjoHKZYCbmjzzbjdMICRXHXsLaBZjs=;
        b=ceTdzOx2V3ZQYYLPSHhxHxuxpJeK9+yOy08dc34/3QC42v0vq2PkiVlbopWKEdTovx
         AmxBAElSHsHV4Im0ZkASP2pT1o0sC/9T5MD8iu74TR7UlNkfGxojAbTzmrjNrHy1/nzJ
         LujinpC+lW0TDfgs78GqjMEPVTADJpCxGAWjljwZNTwSK8bAZYTR40kDa4XtsNdW3cjY
         AQAeq1BmtkxpeUilSmFhPyab3hjg2rCLUdCkzdnSkmZ3xGfTytQolqVgR3QQGM4uU5r7
         uZ6MStG2QwQc1ZPCqyqv36/sqRnSHa+biJgF53kPzQKQ+LgmSboc7JHiUeC9y6VOxJZ4
         zUQQ==
X-Gm-Message-State: AOJu0Yx/1TsH0TM6T8IBnMjBahKvOeGbTSbbhwwYKR7yEJse/1+/P0ec
	ePdWcskpeu8uoGiS7c6WXBitNLRsm8L8NJbG6tDjTrNvxUmGoOG88JH9SIMSkRc6wcSPiN3R91m
	6hk28HD85vp7JtlanfDfYpL2/YoE=
X-Google-Smtp-Source: AGHT+IEFOHrHW5KSiBQocN6kagYzTHN/Gt3TZHOBnI9VDZexdrna/d8Ac1JKfdeREfgnGv5hAicdtRCmJ/FCmAWfruM=
X-Received: by 2002:a05:6a20:c706:b0:19c:9d22:a6bb with SMTP id
 hi6-20020a056a20c70600b0019c9d22a6bbmr4919320pzb.30.1706633787453; Tue, 30
 Jan 2024 08:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706099090.git.ps@pks.im> <a211818108053754aca002726d0206623a347952.1706263589.git.ps@pks.im>
In-Reply-To: <a211818108053754aca002726d0206623a347952.1706263589.git.ps@pks.im>
From: Justin Tobler <jltobler@gmail.com>
Date: Tue, 30 Jan 2024 10:56:13 -0600
Message-ID: <CAGAWz+7enErUf9apL9nE13=bWSHL=Sz6PdUQ_DRH7-9NCvQ8Fw@mail.gmail.com>
Subject: Re: [PATCH v3] reftable/stack: adjust permissions of compacted tables
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 4:09=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> When creating a new compacted table from a range of preexisting ones we
> don't set the default permissions on the resulting table when specified
> by the user. This has the effect that the "core.sharedRepository" config
> will not be honored correctly.
>
> Fix this bug and add a test to catch this issue. Note that we only test
> on non-Windows platforms because Windows does not use POSIX permissions
> natively.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> Changes compared to v2:
>
>   - Extended the commit message to say why we don't test on Windows
>     systems.
>
>   - Renamed the `scratch` variable to `path`.

Thanks Patrick! This version looks good to me. I have nothing else to add

-Justin
