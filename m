Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12621DD9D3
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557115; cv=none; b=SgclCzvgQLboQlVEWMuPzoNc3OcdpLrJxuCEL3G3I5m1MhCsP5+hzaYBrIhxWgsjvCzIbPMpF8jJjYA5YDiWmsBvb7T8bb3h6jxr9710BNQYxolPHQBb7XnRqXCHVTEF9w1xFnM/1FOAOPDAbJWWY1exFJlNgKaAa/IneRd7LnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557115; c=relaxed/simple;
	bh=BMz8X1jmFNCMEkLoSOtZKvSo84kR0deZ4ORPGma25pg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqIccNHluBNym4H2bJIwpd4w10XrZVvmsM0kSz6CcUCQKrmMX/i/7lWYPkr01cTrvu+3RG30Tc8JhODRW0NRCIoa0k6b4ElrntKvFYMjHLRZ1nZSO+/spK0rU+CvaiVXyqtslSQIU1lMRvjMo/ahpiZ0pq7FwU5Fd447AiOwvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myVO8mA0; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myVO8mA0"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4fd6c638f20so404046137.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754557113; x=1755161913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3xKBPcLnbfCMFWxV93Ht2tC0bnhkvjxWeO38MQO8sY=;
        b=myVO8mA0SjhQdQfFDmhTI0eDKXLTbNt7/y2OTR0Aq0ZUw4Ge5+Oddy4iPQQhOREUH8
         pLmVSDpiemnUhDt4kzz+YT6Y49e8lftUeSIbTc4vMBuP2q0p0dr0x4kLB+y0KgDugz1m
         H1iXT3vnDh7YmJEuc5mlXAEah9CNnMM2kyzUyuRS40aY78URawrkZf54teClIuLaVoZb
         8eMMtPkipJtqVzeuJ6GVEZrvnxR4gA+Lu7FE17nyb41IoZyQVKwMo3KV6YopXSOZMTbM
         mjrB0k+rdiJL3ZWs1tXmfeIMy/lqMjIPcdJ/d/Nf9Uve05nmpHs6ypoF2JhW/DngqbcN
         IYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754557113; x=1755161913;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3xKBPcLnbfCMFWxV93Ht2tC0bnhkvjxWeO38MQO8sY=;
        b=e3ipIzfaYNcFGsmaCcSn1wWHIG8fjY57FYVPRlNYgVM6kNUuvBhHoOU0+C15hdOxlJ
         qXMLFRUFg9Tbc7XuVR9UQGxitocmWjEK4hUT8bRjDp3VNb/fVbnZr/1arh9N+A98+ogJ
         PV/xgwPkPBLaoG+M+WEsHLtdU8u5tA/wz7CBTfMD33+ThzunPW1426EkKhR8zZwEiMHc
         psFy6MNDZDqWkezOwD7KWKm+FWKJm9tqVZaxIfxiLjM2zdufUUxlfzNT0w4pVmUSUIy2
         zta3RkEx17TKj6hK3rUetEGXGsZoLaKL1LA6QaGtqKoRsz+NpIEN4wNfRUDbhlf8Fx3E
         c34A==
X-Forwarded-Encrypted: i=1; AJvYcCUSVYpOJiHLWEvoncaw1sNBwgpDzJwiMNdio/fXpCM9U67A3FnBqGoAuSfTzi+j7pdFAhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0RdEBm1EaHuKvSi1TVgFMlXAqfSkswMcnZh667vEhNQ4BcA6A
	WoTeXzwab82lAywhgAOYZvu7eioBlrc3LIRtp1yHs/LW19wCZx1cF2PY1zOmbqDAsR6mIy1TJI6
	mJIARQFOZAuTY2i8afHOMKczN5/Wl/Um040q0
X-Gm-Gg: ASbGncsMBhpoxvazeVI45mzs/w0HxbC0MnW+uwQwVbVxc+BcbhqIo7mZUkpRrBFYuDB
	sW/mDwFr+XJF76xY9WTE3YcCgRnNiZtkPaGiKNoUU6lBtpiJ3SitKKij/J1wiYPla781VjTfn9r
	GYI8t/iRoRqiZfdBKtASIkSexFYbz/38MPxMwYxm3yDO9rmVuc++nSXDGrf+zUWZ8S/ttmqlFLI
	2TnPQ==
X-Google-Smtp-Source: AGHT+IFh3tSirUJq+uwUammjEygmYnFY0wkM3OKvWLERVzXYaf94f6XG7xcuSCVIoKzsLUygbHM7qsY1MY32rb42N6U=
X-Received: by 2002:a05:6102:8019:b0:4eb:f003:a636 with SMTP id
 ada2fe7eead31-5036f13a979mr3423197137.0.1754557112691; Thu, 07 Aug 2025
 01:58:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:58:32 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:58:32 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 Aug 2025 04:58:32 -0400
X-Gm-Features: Ac12FXwi4H-hP9eoT5z5bXW36_fEal0yt74xpF-Vpyyw48pBeophHgApd1f0QCo
Message-ID: <CAOLa=ZRvA2kLd-EfymOTF=SvyTFR+Xw1QSvDH4BUW2rbz4FmAw@mail.gmail.com>
Subject: Re: [PATCH 0/8] midx: stop deduplicating info redundant with their sources
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="00000000000070cdd4063bc2a974"

--00000000000070cdd4063bc2a974
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series is a follow up to the recent patch series that started
> to move the MIDX into its object source. It refactors the MIDX subsystem
> so that we always read and write them via an ODB source. This ultimately
> allows us to store a pointer to  the owning ODB source in the MIDX and
> thus dedup some redundant information.
>
> This series is built on top of e813a0200a7 (The fifteenth batch,
> 2025-07-28) with ps/object-store-midx at ec865d94d46 (midx: remove
> now-unused linked list of multi-pack indices, 2025-07-15) merged into
> it.
>
> Thanks!
>
> Patrick
>

I went through the patches and while I don't have a lot of context in
this section of the codebase, the changes seemed good to me! Thanks

Karthik

--00000000000070cdd4063bc2a974
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7ba258046d85aaad_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pVWFyWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHQ4Qy85SXR3eXlvZE0reTJBVHRHUm9abDIzNnVCNApsQWhUNk02aDdF
OTJXV2dSS2RlVmtFT2dyeGdRV1VOYVdBYnlxNk5Bb0V2Zm96emFhWksvL0pTVEtWNXhmMlVxCmJH
S0lDNnhGeVNLT00xOUdTZnJMSzRjKzN0V0M1cE5qTU9wOVFWaXBpd0NNYmRDWklmVjFOQSt5K2Fa
MmtFaGQKc3VtczRwalNCMFhBejZ3T09NN0VJNDc2UVRQY0lzQ1dldFZLeXNsZGE1SHc4Yzl0RGta
TzYraDkvZUNKSG0rZApSOVY2SWtXbGZqTkROZ1NXMGtBNWpTSllFSmVPMlFBMDFyRFhCQVZoM1p0
UGZON2ZwNGRFUUFJNXI0b3BEeVB1CjhqOWdwSGFMVkNTWlVkc3kwcW5Xcks4b29CQkNGemxNSWE2
UndjODBqcHlQS01saXBucUlVT3UvR3luNHh0ancKOHFkMGlxYXkyNzdDamp2elpLN3NXMzkvcVlo
SXNWOVplT016aEVOQjFid0pLRTQvNnp2cGVPTitzVTBpcWVOdApYK2Jjd2N4ZE1QRlhvZVF2TmtN
S3NPWVdMbklpSFdQdWNzSFR2Y0hRdzVESTRSTUQwQzNNL3pBbzVWWG1QUjBYCjhNQmQ1NmJWMFRj
OCsvVlRsb05HUWNiVHZkZ1Q3MVBCaGdQb0hTcz0KPXdCT3cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000070cdd4063bc2a974--
