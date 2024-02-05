Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA132C89
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148124; cv=none; b=J5uwbCSLPykY3ihkPUSzCJkyfghN0COk4uiAR5erFLcd9UGysRgY7A8Zkur8OzUNErw3MRaH02NmjpgVQQIrqzjaah9xjRKPCGMcAPsDvvcPFb4LKhoKa9Toh5raiZbelsuTwgOmobWVOtnaI1M5Y6um43zSSPL4/MBI/9Ece/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148124; c=relaxed/simple;
	bh=WPCN5tToR+CjWvGxacF5uitP+zGtn7TG6736qYX5mVs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar9bWCQXzvxW39WRrrlLgeuXKd7X4BKBwyYLVD75FDYm7/12/pyYmQ3ukuGbsfZijQ3NWW11GkEKkGZDzm8HGi5TdGvEWZAeioWIxOrECcw5LjQF0NdBymnjI54h345dOPFqzd6HayUncbl/Au9mLC3xIMR1GHuqgtCwMgRBdL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To9BhXDe; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To9BhXDe"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-210c535a19bso2823422fac.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707148122; x=1707752922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPCN5tToR+CjWvGxacF5uitP+zGtn7TG6736qYX5mVs=;
        b=To9BhXDeKMvU4Uu8UMynLeY0JteJTiH71PiS98s/QBfyfQkXq491vVhKRyWDpKV2Yd
         m+az4e6AFdsLsHrgSsJNoYIa6UGsiMkv5eCR9osyqt1IVhkVEH/GmeCOTSYnA/8XkwVi
         cxsj39SKqGuzTpKiBiSaTRXnvcafuya8sEW+FdxLF73ML8iIOSoAZ7TzTaQRSLC434Ju
         OVMOSSrRRO9wxdeQ++twJgMfg8JwaMGQCiVitNGsbH4QKvgCLZoi6dDarEMtFA5uxB7J
         rGBgyxOEmn3EW8kdSfekxczmhSkM7XE2aNnYRXx+BBCAUiGbicJGHudu65BbNXfEyFzi
         hL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148122; x=1707752922;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPCN5tToR+CjWvGxacF5uitP+zGtn7TG6736qYX5mVs=;
        b=H3c68dZFbVw8jrlAIeupaG4CotqJU/SmugR+lociB8NLlb7WltYOKNnAQ/I8dicMsg
         yvlPqyObjv32pvZ2ljGYLRsLTNChscWGGLQbvi0j5Cahwh8bI9qReSHjKaHleFiHY8fC
         xSiQd+lENp6gJ1mEav8djF2qcsicXR8V3v7C4+7pEFRq/TWsDKFjloc4atBaGQD33mMM
         PRgZkivT+COeFYsvqCApEGzbkpuKEEA/DLIV3ABiM2YeGUqKcvAKNK5oIhSyIXH+ErqL
         iajI4K/C0r1G9TIVyROFTP4SfT2lhbGRiQXQ6lM/Q6qfrfnAOYzEWxo9gvMxnBs1AKAE
         N1gA==
X-Gm-Message-State: AOJu0Yyu4j/A+ratCKhwII9MjVRs1NiU4/cxkZi7VeO1eAu5RnkjPmLn
	1R+uc3m90Q0/Mmx/NOpbFQlJ+1aUaxq4NOkCQof6+Y6jlg3lt/dnJ3yELAACZbhPKcObkY+xAIJ
	hOMQ9qCph6F0p0WSdyeHjzp+wzRI8XW5H
X-Google-Smtp-Source: AGHT+IHiPAfdLCwVR/g3QbHLjDp+PKhYZrUVCVRO/JWvnN7Q9UA3m7y/fgLCSfG4NUKyHcRM/ZueBZNg2jsU4UuI33g=
X-Received: by 2002:a05:6870:1712:b0:210:d385:e497 with SMTP id
 h18-20020a056870171200b00210d385e497mr85651oae.17.1707148122333; Mon, 05 Feb
 2024 07:48:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Feb 2024 07:48:41 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <2dde581a0256e4634ca4a64f313a98204763906a.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im> <cover.1706772591.git.ps@pks.im> <2dde581a0256e4634ca4a64f313a98204763906a.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Feb 2024 07:48:41 -0800
Message-ID: <CAOLa=ZSDz4PMqFGp3MHr7Ls2xOUs+NEnG-y09J9knNd_eGpZUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] reftable: introduce macros to allocate arrays
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000694a1c0610a4657c"

--000000000000694a1c0610a4657c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Similar to the preceding commit, let's carry over macros to allocate
> arrays with `REFTABLE_ALLOC_ARRAY()` and `REFTABLE_CALLOC_ARRAY()`. This
> requires us to change the signature of `reftable_calloc()`, which only
> takes a single argument right now and thus puts the burden on the caller
> to calculate the final array's size. This is a net improvement though as
> it means that we can now provide proper overflow checks when multiplying
> the array size with the member size.
>
> Convert callsites of `reftable_calloc()` to the new signature, using the
> new macros where possible.

What about converting users of `reftable_malloc()` to use
`REFTABLE_ALLOC_ARRAY()`. This means currently `REFTABLE_ALLOC_ARRAY()`
is defined and never used in this patch series.

--000000000000694a1c0610a4657c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 82365805e05b82e1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YQkExY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVlFQy85Vy84RHZRNmw4OVpKZi93aUlRR3ZWSHN0QgpUbzFuVjVGUVg3
dy9NVFNNbmNyR0tKNFB6NC9FSER3dnNjVTBFSThKVGJuQk4zVGxyVU5vNUpTU2FjUGxzMlNPCkdi
YXVlQ0lrZStzVXVDMy9JQm9Hd0FvaEFzYXRNUUV6RGV1TEFKNmZYSWpBRmk4bzUvYXAwcUQzZ3Bn
a1BYVDIKczM2UjEzakx6VVdHVkVtR1BIL3RObDFIc2Y0VzJmOVdhYjlIOGZXNlQ2V3BvaUtlcWdG
NWZ6NW1TYXdXRzFZZwo0Y1FPNVhWVnEvaDR6Z0lWNWpoZExyMUhxUDBHbk9ub00yRnZ2ZklxdEtk
Zi9ISW41QjBOREFUUVo0MEJJckw2CnV0T3RialdEVUlZVFpjZGlTV25XZmYzcHJVVWhOeEZFdnQv
SFVzT0J5b1I5VW5yWlMzTTVROUNHRGZiVXNCL3EKUnZRVDZJZVA3SmZxU1FpMUwyYVhRTDNMQjJU
eENvcXJUTVl2eVhKdUhLTnAvVUsvc2FHUExwendTTFp2NEVxVgpXRGtCYnNHTk1pMDlMQ1RFWm1i
Z0kvN1NPSmg4d21Cck5SZjltOHJGYzkwRGoweFVJNUZ5MExqckV1NjlHK3BqCjFVcXptdnF1V0t1
aHV0eW1jbmhXVHg1Mk5MZDRQNjU1MURDU3oxTT0KPTRHaksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000694a1c0610a4657c--
