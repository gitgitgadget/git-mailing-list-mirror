Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760871A2C2B
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522366; cv=none; b=gta5prwfts5ma0OWnF9e+m+1KcfS0ugsNC6r9XaxJAnq8vS5ple6YDIvUzcADZZOrV7BlAE1x/oRQ1BAXd8vEG3yh42/+oZgOVfLp3+MgXY6UVF5R4Pb8rPCARs25Q6gDnnivNlFbvDKUILPi18G/pR6pKd+qugf0H9Wi57tA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522366; c=relaxed/simple;
	bh=fRQLZ2PrnnbdJmChcK60D0M8idA4vEBy9lCP5lrUGQE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gWp9aJipW4a5Fc2EZ7O88Ib+JEWTj7EuIIADlO7SgWhSylDTMJ0GIR7jF7/fUHiMQOMR2ga3vleRijkYcUSrBeo++gsLJP+13/FcZNDUfZl+XtWZ3DO4DNNtLlsxjxmR6T/ioYXVnJ23LFeySWBfiFxtBUA0ZN9O7TynTgVgjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyl5nCRl; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyl5nCRl"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-66ca536621cso55709837b3.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722522364; x=1723127164; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fRQLZ2PrnnbdJmChcK60D0M8idA4vEBy9lCP5lrUGQE=;
        b=cyl5nCRlCHaGs6AfQyJ4JJuhUAAzYLLwUL/533k8X0wdhQ6PV+jS2fWUFoX8noltWM
         G+5T6TazcVvQx3Ouz6cO68GPHkxJ+oQYYE6asDSJwEgLtm8NS2bhpJe3bSyysiEfunOe
         rDdfH+VG/w6NIOwUVyQacbIBdKCYVP3IIbS7/4RgMHuL8/M9fxiES3FomQ3Sp1tG8rlP
         uQEyTpdVo4bBEGW1hyTeyXGf1ouanJo4mM0A12+qtpSrY6QTQgb46I+XGNCl923wY9Xe
         ZeLyp8qPIIGrFEEK2/1HeH1V4x32OPWsDsFTX3LzkVK4hy0thZpFGbq0VXtxjuWkudo6
         Pzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522364; x=1723127164;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRQLZ2PrnnbdJmChcK60D0M8idA4vEBy9lCP5lrUGQE=;
        b=BqBr9rHiAcAkc407lLFY70P56LGxoAFtR+XGFVPaKkdmUAieZwvz76LUMbnhxOBezv
         4q14xBR/htL3VhrjyYYhezGr+rqKdfUDnNX/7zDHYq3aHWkartRHNlzzVsU8MpozUu1r
         XsdQcBhjSA17Zfdt8W1Ba3OGGAthrAxIjNdyfBck/bNM14YcygJCULMoz5Cq4nGu4FVn
         69szvQvjkwGO0hee5K+3MnvOaaOgztJ7Pc4rn3Nq1ERa5X+JNr20GWyMFjEI/ruQacAs
         rur1WTlJivgP2epMakEZe/b3EPFbaIKUnM34eCwIY1a4OJj6ACWbCd6JS3RKmKE+/O5K
         bIgg==
X-Gm-Message-State: AOJu0Yzi4GXf0zm3+WZA7X84yMb+exE5ZpOScRi2Hxx8sG0KXgiWejGD
	J90AD0bHvh8L1YT7zPKGj/3End9/Su/S9YStOZPTtx6vUgxE/2HZQVVxGDtIDR/lywKmnGQUNIG
	Na7o9n8JW6WVfSFaxE6Aj30P1eGc1ddPGOBw0h18=
X-Google-Smtp-Source: AGHT+IEFwpc8aFU6g6UHvpPsbKZ4/eILZlWqn5/BROseqywRWw9y+JOVwYK+8tklulK22U8vdEjQG0P/sd0EmZ5hN7E=
X-Received: by 2002:a81:9c44:0:b0:64a:d5fd:f19e with SMTP id
 00721157ae682-6895fbd77bamr1979077b3.3.1722522364421; Thu, 01 Aug 2024
 07:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steinar Sturlaugsson <costeinar@gmail.com>
Date: Thu, 1 Aug 2024 16:25:54 +0200
Message-ID: <CAAWdfG6yprY_uFOQq5wK20EgwNrUcnmVpnBz3ejfBXcs-i_aZg@mail.gmail.com>
Subject: Feature request: Stats in git log
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Long time lurker sending my first mail to the list. I hope I'm doing this right.

I'm interested in getting the stats that are shown with `git log
--shortstat` based on the format string provided with the `--pretty`
flag.

Example:

```
git log --oneline --pretty=format:%ad,%H --date=iso --shortstat
```

This returns something like:

```
2021-01-07 09:56:48 +0100,<SHA>
 58 files changed, 21 insertions(+), 50 deletions(-)
```

I will now have to parse the input for my purposes of reporting it in
a CSV file.

I wonder if (A) it's possible to specify this already with e.g.

```
git log --oneline
--pretty=format:%ad,%H,<changedflag>,<insertedflag>,<deletedflag>
--date=iso
```

where the result for the same commit would become:

```
2021-01-07 09:56:48 +0100,<SHA>,58,21,50
```

I'm aware that commits sometimes don't have stats. In that case, I
would expect e.g. `NaN` or `null` instead of a number.

(B) If this is not available, is there any interest in a PR providing it?

Best,
Steinar
