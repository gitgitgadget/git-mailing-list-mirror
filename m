Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF66264F99
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771253; cv=none; b=BomJ0P89M+0NS8MYcGl5Cx2s9TtlQW8cBSqaCwtsI/beoJoDfPmJQZ0DtzHPP5tiRuzfMTVwZFylCB7+ANeofZwc/2/468ABFSoVGBnwXnq/+M8VdvNTpd62mwIfxb92mIZgQTQA16H64iZpVfQgHAbqE/LPgUpAWCI2yuXnHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771253; c=relaxed/simple;
	bh=zPahBjiuy3ddS8ecclaaDaTTXvbMa8+KhcraJNIS/8M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJ1dkqILoI9P39OWKOcn6gTkv/OyTcxtP75jWp/xy6vY6YmBbMk9nLHsGyc4j42pStivCGj9ZuoDRVpc78Mt2lpgNJdC+51nVp0h0GS2jCIDGKTjSsb/fjAbkgxJRxy0YdMhg0A+sU1kMG4EkUDMAYB2RGYXoeq7m71h7TsRCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCQTckXz; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCQTckXz"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8902ee514deso584278241.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755771251; x=1756376051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jwjw6fxvbgqn8utbjupo3ht5s6BN2/pcLh8EXCgGYI=;
        b=MCQTckXz0ulzmFKSR95UF6N/D/voHDRTx4uk8U19d+EodeH+lLQyRn+6OGuxmI5RoK
         nk5/BxAvWUfyOknGAjlVvzJ+0Urhj+BVB0c/Z3NhwLvghDclNuL8ltonA0uCuKFuEgfP
         u0Mnn8H9fCaz0vjTxP/t7nM431YENU8l97oZrFyMssZE5HY8JthNRAkoHErc3vwxt/Bi
         8PIncI89dNWqC2sq3JQZ4UjrzMCaMgqsx4m9En88/1kdx4T/JvQqbGoGFQ5GzMuqWKa1
         j8d4REKD5lwLtQ0cZVKpvue3K4gOUsL+ciYCGcvo7HW+/ULSJpY06+KXmd5PidQRZAl5
         UtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755771251; x=1756376051;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jwjw6fxvbgqn8utbjupo3ht5s6BN2/pcLh8EXCgGYI=;
        b=mN/7qxVM43uSXRTLwogKdBXXYNGF5dhUuGnPetiaIyMw8IiT+Cpd1KM9vksvgggmMH
         u3ufF3R2zXqzpIChkq9+Y0CO4+uSqk9fk47aWAHndXccm4rJah74CgesRcs6ViOFS/je
         DZH5uD66kCauqNehUaV9lbxTEixx9kBTq5cgksnVgV5pXl8KtKsVm6herZMDzZilYOam
         40hI6KKh40zZi6YgU/7ZfeLHz+qyvgJ2JH5HApetznoyiLVo5wuk0B9+VdYBHJmEsehX
         Srt4Q/adkflPhRtnKxvWHGi7IrGVutKrGWd5gn8tqys1qGob6eY1efno3/jw74UBnTMZ
         CpoA==
X-Forwarded-Encrypted: i=1; AJvYcCU8LSy38r18fduFRWOxlDbCfKVLBfF5ChBNNnQ+mlk/FT2a6hdsIAnbiPtpAyy1Ua427ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQTcmm3GAgsHpMHcPfQg7v7FASC6tRzipr0176xNpZ5nwdQSE
	fNVhqaSWmWS+FxNhrHCShTi/2SLnIeV/zN91CbzBLtSuti50NpMn/so3jT2OTcAMPXh0Y94dCyc
	53WMuGtwWSa7wQItlasfdLygMyJGg7iY=
X-Gm-Gg: ASbGncskDsNcxCkqEJoHApPgJ97vAOjXvCKyy64pvgpJsRkBBS2JQjtYyg8qx1Q3z8g
	XUU9OiHY+MgBCat9wO7wY0mvdkfvYAdMdH68dkyGcMO1xl1Uf++cF9rpMdAxXbGxpATZ0s9lInG
	+USutoLo6z4EB4iqn4EzH4tseJuDq+9SEc73TBLb5BvdsLiryI8rNWtYcaiG5aFOSSxy4RCYQcp
	otXsJuBrjYrcu1Cy4rQIFpKJsuusyFB9G+zUmvNQpNg8xZC+zJM
X-Google-Smtp-Source: AGHT+IEMFA+iVdRsWOjACCKcIr7pZsdBWEze2L0IYiJTukAVFWzd+LybZRROShXxAFlo6LMBjgJUKEGPKy4hDMA29go=
X-Received: by 2002:a05:6102:374a:b0:4e2:83c4:9298 with SMTP id
 ada2fe7eead31-51bed71f2cemr525875137.3.1755771251162; Thu, 21 Aug 2025
 03:14:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Aug 2025 03:14:10 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Aug 2025 03:14:10 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Aug 2025 03:14:10 -0700
X-Gm-Features: Ac12FXz6ltk6taUS-k2v2A5KcPdSMUTVmoJdtDbMy8xKmeZHXMaBnayjA8gEHB0
Message-ID: <CAOLa=ZQkV6FXCocVFdBoxbR_0eioQeY3hkOGOke+XWciLeZ+PA@mail.gmail.com>
Subject: Re: [GSoC PATCH 0/2] repo: add -z and objects.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000bba7a3063cdd5997"

--000000000000bba7a3063cdd5997
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hi!
>
> This patchset adds two features to `git repo info`. They are unrelated,
> but I preferred to send them together to avoid merge conflicts and
> because they are small.
>
> - The first patch adds the `-z` as an alias for `--format=null`, as
>   requested in [1]
>
> - The second patch adds `objects.format`, which retrieves the same value
>   as `git rev-parse --show-object-format`
>
> Thanks!
>

Just a tip: It would be nice to mention which base branch this is based
on top of and dependencies.

The patches themselves look good to me, just a small nit on the first
commit.

Thanks!

[snip]

--000000000000bba7a3063cdd5997
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3b8e3b58a65fba8e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbThYRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOW1FQy80N2Z6eTU2eCtqcXAxaERZalVaWVBYTXloRgpyWGtXcDRKQUd1
dkd2SEhuZUJnaWsxekJ4ODJGdDF6VXpGSUhydWI0N2kvSCtEUURRVno5MitOQUsrWmRsSUtUClpN
ZjZpb3BKenpFNFZ5L2w3K3k5NldMcEhMYXl6UmtzVjJRNUhjQ3JPT0JGYk9aS3ZPU3RGV0t2b3Vv
WEJUZEMKcWFkOFIxNGtHSnR2MWlwSXl1VXRFd0tCMU1YczZacG53M01CV2REK3VJd3owU0xEa3hR
ZXBhR3MrUXNPUzZiVApqN2ZXQU1XRnh4dEdaTk1JZjdWUmI1UDlkTk1kQnd2WWhOWXFXblRvUzJG
NW5LcTRQMWF3dHlNeVN2NVd5enpaClhONXJLM3VuaHBXYUUvRjUzQ1dnWnNQM01kdUJzZVVQN25Z
WFkyQXJLSFBSdHFUMCs1OGY4bUMxaGhGbUJTNTkKR3ErZHFUeEVWZVF6MlQza2Z2eDVVZnBHRE1k
UHhDOWI5ODE2UFNFeDJwdEF5bE1aY1oyaFZzTUpNaEJnS1MvYQpSZ0dHdnRzdW1xbzhEclNxYUZK
bnFlUFk3aFZLVklwSnpTNEloUXNlZUk5a3gzb2lScXFqK243QllWMXdXc0xFClcwdmUwd1oyaWk5
UU4wckFRa3JpVWE0dEMyVkZJU0FYa09jVWNyVT0KPU5UVi8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bba7a3063cdd5997--
