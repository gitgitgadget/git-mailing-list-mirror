Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD827CB25
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112397; cv=none; b=enkBVnKLdLIU2XP+r+3T6PMB/jS1UD/LmKDD2lZSMy1ktSOS4NdOfE2d8jcH4XD0mU02fDARPSx3ITYc1mzGifnKB6Kp9RHYxuqvWl1ahNjGn3qyqkRDRq+K55OBxKbKS67FomGUHe+zsZ4BUUh+JWgIIN3PxtbX/DuLX1KGsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112397; c=relaxed/simple;
	bh=bGqKTEU7TVtTgcph86rcsktGlNPceZoP6IS+ACresew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mS2r4+0VlCkqOB7eXDzqkp9rdVhJxvZ8/x7Ek5CzcDUl9MpFNJNBd5t7c6eyZDKclMKiwB9Uk00tLhQw+D5ahG6edvpX/8VPWedNR/RSemrQHStRZUzxD83BaYU6JAW8x3vJxSAAwc9c1Mr35K9zzxP5V9vsAncgSHaB2k89L6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMzCB053; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMzCB053"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54298ec925bso8920249e87.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 10:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741112393; x=1741717193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKpchshf5e1KYZYJPeFreCAAruyQd+l17j1kcyjWbM8=;
        b=FMzCB053R3gtTVaee3X/CEQB/6+f25hAAL4b+mXSuwoV2gLg3jfiIGt+RyAsKRNnKx
         stxFqR11MpuPSoV6A8+0nLH7aBxaFnMAlnywVl3j4tKnFwwHXjjmVVMCfB96+tUKBiCS
         wAAaTUWbgLtDXRGNOsPzcjJ3wPWe8GHoJ8DTGi1T3Koa8iFxgWT46LCOe7h64CmM1DPD
         LT2h+cKTeYPmZTEWRdZAS24oVPWFHCK/DnKFRibhDTuQ0Tf9rJmVrtNR2eoNdIlKI10s
         VmnoEn/s/oTLkxJSAAvMyAPv0P+asF93/mVQ3ujRHNP/Wf87UMeDlt0mVxm3y3Ky4DUj
         EGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741112393; x=1741717193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKpchshf5e1KYZYJPeFreCAAruyQd+l17j1kcyjWbM8=;
        b=dGUTx1J84elqDqpoVxmWWtt7n/e+vOFHQqfpjBri4TWx90OE3kudKOoQ2hb/tgrWHt
         a07ORxLaHCuohTNJf/bBLih+Ad6ztiaxZyQ1p/fWmcxiKoIFXL5FHEPuLMY89mvctIKJ
         AU2/lKMXhpRH3rnZuUUFqtZ7WieEkU2lAphHayYO+gBiiXRNdjV5rcsU5eTNYB715/xN
         thZ4WOOimrpwDbtxvghdCWM1a5HI4t7U4uIxA+WW5g5XQMBWzbGiGQMgQqiJJdOp7GPA
         Q4mCV7XV+TvazVf4Vnd5nqCr7WT1JulIKZY+M7Y5HDaJrUZr32a7nwNFGESudthDBTej
         KmZw==
X-Gm-Message-State: AOJu0YxD3dOCs38jbdbUVM/WT8ZKWU/iKDqfUjoUI/S5Ari3IK7P94Z8
	K4eGT23pyNl08YPQid5jq9FWI9HWvRiIpdZ6uaoE+LBZse/TTMe4cBY17O+Zx8TqDyEokMOcW3A
	tLdI/ryuzTKpUaCWc+mkuLVlpSNWxU3QZANI=
X-Gm-Gg: ASbGnctIw46oNL9cE5ezc6KNIz3EaNW67b76cneiApU7Y5pZjspC+BtEyKXb2d4FuBf
	fRcwiO708m0kVV6oZWGHkpNlBQWjP7bpOfsQD5H9I31Ch3tKWMZTH3Jd9Uk2e5Mu0ZKhxGYvlOh
	Qewe2i31088V2PpwyVwuatCfPEJI0s7jcS1K2e1njuN2M7RA6nQ240RbD/jg==
X-Google-Smtp-Source: AGHT+IHiy333QIjDI8lRhfWO24+Y5VreIj74PRcEhrIQUUGI21TH7eMONTN/vmT6df83hAp8bJ7ITuS8xAQ4+H022Go=
X-Received: by 2002:a05:6512:3086:b0:545:2c86:17d6 with SMTP id
 2adb3069b0e04-5497d32f8eamr53282e87.6.1741112393075; Tue, 04 Mar 2025
 10:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304094153.28959-1-danimahendra0904@gmail.com>
 <20250304112728.41228-1-danimahendra0904@gmail.com> <20250304112728.41228-2-danimahendra0904@gmail.com>
 <xmqq5xkopsti.fsf@gitster.g>
In-Reply-To: <xmqq5xkopsti.fsf@gitster.g>
From: Mahendra Dani <danimahendra0904@gmail.com>
Date: Tue, 4 Mar 2025 23:49:40 +0530
X-Gm-Features: AQ5f1JrhNWTQ_odMrD9d_xky7UoDb7aHcQdwI6kDTAsA8-wQqOY-VVAsNRmF_pA
Message-ID: <CABGrwBAhjSkodUe-SGxJsZLRE2zgfqr+3W8U-Op+jG5iKBK80g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] t1403: verify that path exists and is a file
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 11:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Mahendra Dani <danimahendra0904@gmail.com> writes:
>
> > Verify that if the path exists then it is a file using test_path_is_fil=
e().
> >
> > Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
> > ---
> >  t/t1403-show-ref.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> > index 9d698b3cc3..9da3650e91 100755
> > --- a/t/t1403-show-ref.sh
> > +++ b/t/t1403-show-ref.sh
> > @@ -196,7 +196,7 @@ test_expect_success 'show-ref --verify with danglin=
g ref' '
> >
> >       remove_object() {
> >               file=3D$(sha1_file "$*") &&
> > -             test -e "$file" &&
> > +             test_path_is_file "$file" &&
> >               rm -f "$file"
> >       } &&
>
> Yup, this makes perfect sense.  I would have explained it a bit
> differently, perhaps like
>
>     The original uses 'test -e' to ensure that the file exists, but
>     (1) it fails silently if the expectation is not met, and (2) we
>     expect the loose object file not just to exist but to be a file
>     (in other words, the original should have been 'test -f' in the
>     first place).
>
>     Use test_path_is_file to improve on both points.
>
> or something, but the proposed commit log message is sufficiently
> readable.

I will take more care while writing commit messages and cover letter
from now onwards.
>
> Will queue.

Thanks.

>
> Thanks.

Thanks,
Mahendra
