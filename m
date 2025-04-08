Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77773218587
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100409; cv=none; b=UTkMrjnv6/255Ckw3cIycZKPtY0TXJzKa1/bKXqVeC3l6caXWfdFfW8me0YJ05QHJG/p6msrv2oj2EqdUi7i/hXn8eNhJSdmZqv+bgYyiNaXikH8lQeoeFy/4+gNkPPquuJGEEvS8N0zM482aVsHjZppkjJd9KJ6a5xjxY7YYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100409; c=relaxed/simple;
	bh=EISbjQLHUz+Zet7TFiF3qrrvDdemBs50/o7EyOLXltg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=hP7XsXrU8EfcSI6TsjSRVkz+AkeEf7ZXjqj5+goQ3fY0yGBhzAi9xjGFiFJCy58XVPQhp0FkN05y54sFqzdbq0PBEaKwdc7Gi2RyF7KA9GrdGDPEiKQu2dKw3Yn8q3LFdRFZvtDrAIj+94Xgxo/Jddms/B4bogmexxIz00U7ZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZZg6HfT; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZZg6HfT"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52410fb2afeso4535996e0c.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744100406; x=1744705206; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZz+GBpxMmuB6XcpK1egflOqjjxq4zgno+C6XcEjBwM=;
        b=VZZg6HfTK1/cU47Gpw5j62YnOft3ZtMsCy3vkAzN/eCH/58ZRWDB88S02XRUPsiE2F
         ooxJKdn69ThgHqVV20IPldcaOXy2r96qnOU+MhtJTrjTYOAvruFh4ZSRLcpIqbRvFplT
         klxYXoe2iy8zYw/sbXW4pdlwGIP4vFLgh1qU+oyd1WLD/YhRrQxXfAr+gFMD3+Zs6Iqx
         uQkJ/E7bwPTovmYqOi/IMfLxk2vHgAz11+EM0vpTwC0YvvuuKQn91Ue2w1cTNeM4wp8E
         5S9vxRnyBavYWtcEjh4jyUI/Xg1uBnsFk38BjZRjaEWIdYw9d5phP/n51xdOXVtRPgfg
         JWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744100406; x=1744705206;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZz+GBpxMmuB6XcpK1egflOqjjxq4zgno+C6XcEjBwM=;
        b=FliQbrPfOmzcKNyAZO9T2vqz5J3eBQRsqTN/Sim5AW1R4Z2WrP63eFsK7inJ5IO0s/
         cBBMLtGTnDagFjtXe4jcp3BGpio3kOMxLNVZ49ef6pi3B94Y+bVRUl9wfqt00w38LLDS
         Wnd9vvTrOLW5o9zj1FG4d6gArC/4m1O3g03RqPJ20pIAkv2Hv+b9OAblgomA+xelnE9I
         TV4t2DK3a3a55uWTtVKPb1spQfhk1icufIAo+mQNLMEhQSbQaJY6J20g51nkpVzW1VGx
         sv1W1o41vx8NInAlrjz3aH5yojiPGTy/8gl+FRQcFCa3QRDJyfFC+cU93nRnYlEE8XjY
         n6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUWU+ShwDCX6b2lHDamZcCJo/kEWg97mH7gEl2Nc6+AgXcPrE+75hdyacD+cTazKt2lgEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyivSh1SoU5pQCqRcJsnBDREsjCzeRKTGILq5l3os0QKHwYfwCk
	jLy1a8/B2f6A8kVV0cowkngbRiE+S8NaNNdSzX8rte/0fnYciKPMHJYWyTwobzvd2HN4VJHfzGi
	jyC71frCbxSUn3g+FDgHC3FZbVFU=
X-Gm-Gg: ASbGncv0XN4n/CN9MuECVPyfQY+R/hP8kn8shsLy1c0jDRNjrtCtn3M43U3gpYbC8S4
	d24Y2fVyZjIovKiw66zmkRhivlwWiBdcjxLQacVOoW3EeIfCSS+Y5ABlRGXw678Wg7lb/py8MgI
	FYg8whbgTw41qjCwhJKrWUGFgU
X-Google-Smtp-Source: AGHT+IEtynGDQFDeu/epGIr065GxdLYaBkCzJzUhvVBYwkCiVHph4jcME0b2cnXkqiqV5GkaKM78Iwxj4ZLd5TnV+t0=
X-Received: by 2002:a05:6102:4186:b0:4bb:cf34:3757 with SMTP id
 ada2fe7eead31-4c856a22010mr11119766137.17.1744100406228; Tue, 08 Apr 2025
 01:20:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 01:20:04 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 01:20:04 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtt6znch3.fsf@gitster.g>
References: <xmqqtt6znch3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Apr 2025 01:20:04 -0700
X-Gm-Features: ATxdqUFnFZdsYTcuLvk-_B6snanswlmGrrWkO0PyI8Yr7riXLDXrO_DqaVc4xTE
Message-ID: <CAOLa=ZSYPpA2wiB=hGkFStSZ0yu1VS+tkxZd9gew6sHmHPS2Fw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002aa2cd06324005d6"

--0000000000002aa2cd06324005d6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

Welcome back from vacation.

> * kn/non-transactional-batch-updates (2025-03-29) 10 commits
>  - SQUASH??? - <6141866.lOV4Wx5bFT@cayenne>
>  - update-ref: add --batch-updates flag for stdin mode
>  - refs: support rejection in batch updates during F/D checks
>  - refs: implement batch reference update support
>  - refs: introduce enum-based transaction error types
>  - refs/reftable: extract code from the transaction preparation
>  - refs/files: remove duplicate duplicates check
>  - refs: move duplicate refname update check to generic layer
>  - refs/files: remove redundant check in split_symref_update()
>  - Merge branch 'ps/refname-avail-check-optim' into kn/non-transactional-batch-updates
>
>  Updating multiple references have only been possible in all-or-none
>  fashion with transactions, but it can be more efficient to batch
>  multiple updates even when some of them are allowed to fail in a
>  best-effort manner.  A new "best effort batches of updates" mode
>  has been introduced.
>
>  Expecting a (small and hopefully final) reroll.
>  cf. <CAOLa=ZQDiCx_VJRbQB1K6EeuA2mDj4twEB98ByddUNLtB8rEKQ@mail.gmail.com>
>  source: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>

Apart from the squash commit you've mentioned above, there are no other
changes needed, will send in a new version.

Thanks!

--0000000000002aa2cd06324005d6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1f543eb295470bab_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mMDNERVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXgwQy85dGZ0V0hXVUd3UlQ2SDgveWNnUHZhQ2NtSQpDTk5mT0ZsVmpK
bXhwVjZxUVhJVWY1Ky94NHFWd1lkZmZ6RUdleEdieVpYM1dkV1VYSGJwek5FVE9peFJiNUh5Cm9z
Mm5NR0NKVUFHQnRVZWtDVVFWcTZMeFgzR0Vsc3VHZ0ZqSHhPQjlvUlpjUW84bzBXQUpIWk4wMVVh
ZEYwWloKak8xRmJxcDBYUlRndFAxTFZiSEh0TFJqRVE5Um1PZ0hWRlkxQXI1ajJxbkdrbVZkNWQx
S2hHdUxNd3ZlanByVgpRRjc3b0NwbmNHQTFUbnZlRGlNRnN0L0ZVK2N5eVcvalRuOXlwOWtJUEdu
UDFCZFB0ajBJVHhlL0Q5RFpSYUdnClRpYjNHKzA4ZmlUNUlMcGhXeitzN0JaMmxRK0VReFY0WXpt
R3dLbE5qTVBVdWpPenNCb3JmRlBFUjNWdTRSUW0KcVRiVWp6anY2d3dNbTlpbUtsbUxxeUtwQlVC
QmpoQlhtZXBHSzNnc2lxeC95cTBVQ1ROWkFSSUFqeThDVXdyagpDc0RFbDJaUXNtTGhnUUs4M0FQ
NkVKbVlSeUt1bXFjT3VVNkF4WWtERmRiOWdJbXo1QWlCbmlhUFNtZjhsT1VDClFPOHEyTExPanc5
dWFRSW5DUVpYYXpwMkVmK3FDR0FmeDRGNnAvWT0KPWF6eW4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002aa2cd06324005d6--
