Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDC1FDE37
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259668; cv=none; b=nMA3osus5M8vLYgnouNPP+p1E8zm7L3JNUCRl3mmtSEftdUWsQeC5PJB/zOUxlA9k4IrtM9sVw+yhqRqQfLXynr4SWTPywOXIWWTe9YxC4DeJPRtjw3JpwG7GP9JTqVezXDzOzuSJ4AmZcvrK+7nAK2S70jcWseM6F+vJnOibAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259668; c=relaxed/simple;
	bh=oslCe6tA3m8v79ZwOwYGnFGTXTrWJm80P7Z+Wehj3S0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=FN4Y/hsCrasSPJjLBADPdnAqcAY9l55/Eb7fi7vIcbBovdGoDRU1C4FEfC3cqYrDJTrrb+EDxcCcfqJOvANG+hgNZTvh94MlUFOBeapyKySWoa6XoVhszt+P5O8Mef7un1UOu6bwpQPq6uehI64ErhIPcJgUnfQu04ZQCp/tDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpdGpzl+; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpdGpzl+"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52384afabdeso529965e0c.3
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 03:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741259666; x=1741864466; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkIkqFvGiezhwp5VkXLd8g1/iBfIoYcq4Agqe0AZNCM=;
        b=RpdGpzl+2Y3G25HYtF0XB1ZVcYI9/c9GTaq6CkI2HxsFWztXU2Gdh8SioBuECHkaVX
         1y4bXtpB+Kz/TEZQCJncyReAFd8XFuN8tibVaipmcyWoENbzDgC13cawmeQtqDFxj/2u
         Mrw2TUSMsiqJO4AMRutT2CYor4mq0YcYyN+JNoPknZm/twIxt9vRdmEkxJUv2okgr4mI
         dxeGu/4ICCjeHxCStqVJxUSLmX5g4kvAFgvWG5+889sM8M8oT2y4jR9jdiybwew1VRDA
         EvmAmBXZDLUPrQJ0WkKKs5Yi8dnbjYLa7MVM872VlogOwz5P8ME/qYVJFxEWi5dL7glf
         rACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259666; x=1741864466;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkIkqFvGiezhwp5VkXLd8g1/iBfIoYcq4Agqe0AZNCM=;
        b=jqQcuPM20Yj+T1mlVCaySqSgQm8R8Zps9aOsxGEOegMOUxA118sdUCfmDzK8qkoQIc
         ReMfKBv8hTahA+avzcSEHpiIvyzQHXuJR8i0wXGj1Tp88cUIBsizQUxNJjkRm474/HUN
         2RNSQcydAVKnnzbupFfEB7pa1fdL7Wsnw/ALaqX7suoiRX0gt+6esuzJGGMP1VuWPGQP
         hnWgplkdjCxYTG28hPQEl/PAttLbty5ocOiRFLkFPIksWnzGA3ggtb6Z0LXwUpQjLuWx
         T+/Bo318C2ffFx+pGceKrK5gc5Y4sOmZLFR569ZWA/E6KJz20+zzeGIymHvLTwlVzDvS
         Gb3g==
X-Forwarded-Encrypted: i=1; AJvYcCVqB3g1h+mppFZ2q12iWwq+j94X6CQsIY3kgETmbI7LH8aer/So7o1dfrdUg5PGy3zmJ0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDuqHbaxzOxAsUEqarG9T8O/cSm/9DfJ8+BKfKPc2kUam09b8
	zarOY6NMQ15AfJaht0y4FL1DGjxloADgP9yCmM2uTMBxcQ35nGA+WWcDWMI9mZlHtwAMRuF31OV
	UHVkHMKyUljLwnfmTLWLW7T2KLOA+QL23
X-Gm-Gg: ASbGncu0fzjQ7BORkptBaqgv1iCSMAItGc2OwYMqCnPtvjfUvHIWqkviyhYQwlSRWXl
	GMFiR35mLtCmDueNhxJgyyweY003AO6ddv5ulJ8rv7zhznTkdrNndRXiAe9IjFvCpdv+rGEeirr
	ezZsNePf1458YgssWieOMVbmS4
X-Google-Smtp-Source: AGHT+IEXzA7C5qNn6t96Q+Q0kSSKe4uEEJFf6mBSAFPhzUxxIbgcg/Pr2mNVD8h8NeUmcfq2Ya9rdtJFRv6hulTcKZw=
X-Received: by 2002:a05:6122:4d81:b0:520:4996:7cf2 with SMTP id
 71dfb90a1353d-523c62cdb4dmr3803269e0c.10.1741259665872; Thu, 06 Mar 2025
 03:14:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 03:14:24 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-5-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-5-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 03:14:24 -0800
X-Gm-Features: AQ5f1JoTaHmAhiBy4uXCbZkEKXY-wN22QFxpFi0_InnHxLRhzMHY9eUwd9Bmc_E
Message-ID: <CAOLa=ZTMKF2qvKtVibqAw3d0TnyKrKVD87ntu6p0aKGWYzL7LA@mail.gmail.com>
Subject: Re: [PATCH 05/12] pack-check: stop depending on `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d8e535062faa9b4c"

--000000000000d8e535062faa9b4c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> There are multiple sites in "pack-check.c" where we use the global
> `the_repository` variable, either explicitly or implicitly by using
> `the_hash_algo`. In all of those cases we already have a repository
> available in the calling context though.
>
> Refactor the code to instead use the caller-provided repository and
> remove the `USE_THE_REPOSITORY_VARIABLE` define.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pack-check.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>

This was a simple and easy win. Nice.

[snip]

--000000000000d8e535062faa9b4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 57236f32de95db08_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSmc0OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0lUQy93S3RNZHR1MlZVMmhMUnNVZDh5aVk4RnJlLwoxOG1vTVpLWEpM
WDdPZjRzTUFCSXZQaEU5WFArNlRSS0hCZ3hSK0lZWkdZK01UTWxyUEV4eWVWSm5lZDVXNzN3CmNi
YUd3OHFDRndROE1PelNXM2Z6bkhDZWtYcW9sc2VYbkwxYy9yME1qd1AzNXY0cXkrZDMxOUxwSzda
dDczVkMKWURNekZ5Y2VMd1RMREVEZWNWMHZIYmpNbHE0VUx6VUdwcGdZVUxWRG1SOVBubmwzTTdq
cDRpVUtEQ2VnOXlEcwp2aEF3Z0hhOVc5Yzhic0RJbGM1WW81bUU5dWFSWDlDY21VS1IzTU0xV210
YnZEN2VNc1I1TTduc28vQ2tCTldCClNnbzVHMkI2ajhiUURxY1V6QldmRXVEbzdCSDJtODZVWVgv
LzZlc3RDSjhvN3d2alNZTlRlOFp0aXVEZVZSVHEKYUY2SVNlRTZRZDFDVVJ4S3RaRXdna3ptYUpB
WEI3ZzAwamF0ZTgrek9yMWZuUE54R3h3OWNNbkhSNGNUakxoMgozakJvcDU2eEplemx2RmVVZGpK
KzhlRUZEcnJOOE1KOFdYZzVsUHpOUjc0ZCtRSkxDM1huRVBxOFZ4OEYwNXZJCldzRW1WL0NUc2Zh
S3lWSGpQMFJpMFIvRkdZaFRoaytKVXZrbmt4az0KPVBDT1gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d8e535062faa9b4c--
