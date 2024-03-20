Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A96A01A
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710973378; cv=none; b=AtoT2Sz2l+NN95xRfJPeiJeinVCsk+sFPabKWva7PA4mkMBo5XacUnxx0DEQxALoC2CYvdE3GyC6HY4H06KKY7uCoV07FCHJYpupKn//+/3p0yKLUX4oSihCAzh6VDyJIfCCMKWwqmCzNb5c/NyYdUd55Pd9KbSntb61N0NZ2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710973378; c=relaxed/simple;
	bh=NFifHq6BAUFpbuhFlm2mbrI/arI9Mf5ggjJAGLCiXrc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX37VBgpmjFoytX17wGxGGj6aHLqL8g9AcwAV4fpyJx94rIhjM4dTuPNNOqc5mZKDy+bjF6gJCvy339xr8vzdz8YBk9di+PPaiqOJ6aADdcGxxysmI1w7guksYpJYXxgExgUsktGV72r5J3shBaPkB6hglxq2TDR6ajTB04lOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aadrhdvk; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aadrhdvk"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22215ccbafeso172493fac.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710973376; x=1711578176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zljc8JXSJeUQVxXWjotE4KiyuBloCs06aB9l59IX+ow=;
        b=AadrhdvkVHjbEnkdo75wvIKCNFfB0BrPg4gvBuNN8qjtfgMhht87CF9J6zC1p6//WK
         If9XoUHq8TOqF9h0Ngw7+WENVIqMJNosiXEq9QrnNrOoNJSiw8utixxWc5NwklUuEfS9
         fnIiOXMeGRKOIEcZNtwgXkPJ7fAmdlx91EnsRnDRUjowcQA1bB5j1TeJLnX9o6aTZIrD
         68uFJr4RogETkdzjCfzgiC1ir34htsbjYcFvwoFkDTVbaZ6+SrsCHO/UBByHuImbJ/5T
         KNCihA12AOgmh+wqlZ8K0jW7PPmFMlrnqugRaHkGkAp/BuEJuC7/EnVSFiMOj8EgUA4L
         JhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710973376; x=1711578176;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zljc8JXSJeUQVxXWjotE4KiyuBloCs06aB9l59IX+ow=;
        b=qurSk68wU8lFS0wnqz7TgbiekTSwJoD9tih3+VMrJyTVhtn3fZa+Gie99H8PRbaK7j
         gGzOk/QK1hmoiNLbxYsivaqyQlEZKb8d07d4Tj58NN4GPr2WgZzjAOEbz0mr59aCvPHI
         LIOvXmLzIoiKvZ9XPeSeqczg0CGXohsxb/b0CHIefCADT6Cr5OmfoCriHwP3HkaH7QQ4
         QSO8xhaf92vIgPCmKbYcANgN78QUHlhnoAiiLPGnsmJ5oLvkb/90bzD/oyJgiQ2aEelD
         Rrmp7x6XeOT0cHNGaaVA4WIPPjEo8j2NRkGKKTv18pUo/HKnoHYcGrCWH+o8pEfW/7LD
         fOWA==
X-Forwarded-Encrypted: i=1; AJvYcCWart6Lpi2YpUa9/gnu0pYoY9UyxYaFhVvC/pHynEoEyMazxhu791aJ0EZIkKRq2OIWO3MnBdmbLVKpqUFVL601cRJI
X-Gm-Message-State: AOJu0YzOBC5CjXiv7ZprlGYTAVbLCxCcB+a6ZIzfFpSwYVExIHXNf7DF
	p5pOTW4FdpOIhEvAePUS+K08Pv2i4zj2uZpBuqWyMXc4Upi65cLmexjm2lWUr+m6gh63l8zlvb5
	TCpBYwVo/MQztVKAhK8D8G5yC9+o=
X-Google-Smtp-Source: AGHT+IGlWc6jEPMzJdMuiaCQ2MV8dg5JLGzhYkC6ySOoiBqXZspALjSCloOqLCqDVD2eXoUZ8b34oR9NoWMf6fhnHIk=
X-Received: by 2002:a05:6871:2891:b0:221:141:1ef0 with SMTP id
 bq17-20020a056871289100b0022101411ef0mr21047232oac.53.1710973376280; Wed, 20
 Mar 2024 15:22:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Mar 2024 15:22:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <37a18b91ca998ca5ad27d17e86d286040b6e6ee1.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im> <37a18b91ca998ca5ad27d17e86d286040b6e6ee1.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Mar 2024 15:22:55 -0700
Message-ID: <CAOLa=ZRxt7rwmU4UJAZra605zyqk5QJD5OD1oM_BidRpJbZP1w@mail.gmail.com>
Subject: Re: [PATCH 04/15] reftable/stack: gracefully handle failed
 auto-compaction due to locks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005055ea06141f0819"

--0000000000005055ea06141f0819
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Whenever we commit a new table to the reftable stack we will end up
> invoking auto-compaction of the stack to keep the total number of tables
> at bay. This auto-compaction may fail though in case at least one of the
> tables which we are about to compact is locked. This is indicated by the
> compaction function returning a positive value. We do not handle this

We no longer return a positive value, do we?

> case though, and thus bubble that return value up the calling chain,
> which will ultimately cause a failure.
>
> Fix this bug by handling positive return values.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c           | 13 ++++++++++++-
>  t/t0610-reftable-basics.sh | 20 ++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index ba15c48ddd..dd5160d751 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -680,8 +680,19 @@ int reftable_addition_commit(struct reftable_addition *add)
>  	if (err)
>  		goto done;
>
> -	if (!add->stack->disable_auto_compact)
> +	if (!add->stack->disable_auto_compact) {
> +		/*
> +		 * Auto-compact the stack to keep the number of tables in
> +		 * control. Note that we explicitly ignore locking issues which
> +		 * may indicate that a concurrent process is already trying to
> +		 * compact tables. This is fine, so we simply ignore that error
> +		 * condition.
> +		 */
>

Nit: The last two sentences are somewhat the same, it'd be perhaps nicer
to explain why "this is fine".

>  		err = reftable_stack_auto_compact(add->stack);
> +		if (err < 0 && err != REFTABLE_LOCK_ERROR)
> +			goto done;
> +		err = 0;
> +	}
>
>  done:
>  	reftable_addition_close(add);
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 686781192e..5f2f9baa9b 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -340,6 +340,26 @@ test_expect_success 'ref transaction: empty transaction in empty repo' '
>  	EOF
>  '
>
> +test_expect_success 'ref transaction: fails gracefully when auto compaction fails' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		test_commit A &&
> +		for i in $(test_seq 10)
> +		do
> +			git branch branch-$i &&
> +			for table in .git/reftable/*.ref
> +			do
> +				touch "$table.lock" || exit 1
> +			done ||
> +			exit 1
> +		done &&
> +		test_line_count = 13 .git/reftable/tables.list
> +	)
> +'

I'm not sure about the testing setup for reftables, but maybe if we
moved this to the unit tests, we could've also checked the
`reftable_stack_compaction_stats(st)->failures` value. This is fine, but
it doesn't really tell us if the compaction was even attempted.

--0000000000005055ea06141f0819
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fa361ed9bf5332c9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YN1liNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEtzQy85d3I2dndIeWFDNXkvMWVsaHQwNUN4ZUswRgpibU03aTFYcUhO
K2pSWngyaElnZ1lFTHh3QWxSQ1liREFVRHpsaHc1K2phNGNWQ2dJTG12MHYxNGtJcGV1RHhMCm15
VkNCb2xPYkJqb0JYb1hYTDFTbWtSRE42b2h4V0RYa2pwNmdvaG1vWHkvUk9yZzRrdDVNYzkwbDhy
R0x2TW0KM1p5UzFldXRmczVBSzM3bEVnckF4ZUdhS1djVVVRRkM5ZUEvZ2hUbFVJUEhJMXJjZ2JH
S0EvRmxTRTR1ODJCdgpoNkJaY242b01BYU1acit0akFtejRVSW95anN3OEM4S09SOThLQkxidjFN
OWN1MzJCWE43RGVId2JiYUNKZTVzCjZqeHp0SG9qNjFPVzg4bVZnTzdDWWJRcHUyVURnR0c2enQz
YnZSckNyMFdwTzRhOUpIcGJiVlBCMUI3c2NCREIKcmtlQ0tVamw3WkhwWGNCY3ZSckNmZ1MwYTBh
cGNKWlQyRTk1SHgrdWp0MlBsRlEzb1RoS1JCZUUrSFh4U1VTNgpSUm43ZFkyQjR2RklqMWJKbTFZ
YXc5NGgwN2JFdjJYM2JkS1J1Y1E3QVRCSTJ1VnR5NEhjcWRvQlg0L3puVWF5CnBQSFdoOHZPUHc5
enNtNVUvMjYvOEl0dUxreVkrdlhnK0E1RWFJdz0KPUp0TXUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005055ea06141f0819--
