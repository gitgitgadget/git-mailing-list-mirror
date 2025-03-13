Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2326988F
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879807; cv=none; b=QYBW3RXtekuMuN4hrDF6ZI5jHOcHPVlZpYpHrx9YTtraDjWITAqFD87uGWR0PsoEZJlT9izEdlNQby+dtHwnmrPzFUaEF4C2t9YCjuo0oCoqP3SZdcejdSyGgHKyqXRzBdp3qOQ0YMAH3R1l2lvQadx1rG41ClFUgfc5Lg4fO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879807; c=relaxed/simple;
	bh=JhMwZVbysePSglg2r38UkSxypmNMIyH5VquKmu0uJig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNvWzxNWc9clCK37KfcCifFvXIoMFR3V/JqSLQGXLGqZk4sZ0QSqvN30qykPNOk8j9g0OBYk7Q6jDM48S0hw8GL/rYXT7xYZurPTBYzV/BFrTN+pQKVwQp6KsONmudPexItti8nByw8s0helknw/q0gK3LVPy5VVBEWfW+EM7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs5PpgDc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs5PpgDc"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-549644ae382so1263672e87.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741879804; x=1742484604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vmOc29W/KQ8GV7fEEPDHqrQj0PGtjLUiSwr7hcTVkWQ=;
        b=Bs5PpgDcrzU4kBfV38Ya1vJOkx6sbIyj2KMv2jcM5XXdm7DnKdZVi7P9/rQGedV7Is
         I2EfjbKTF3D6IYlc/Jan8Tgewy9f9t/NdL2aumiwsOcSwF9RNTpyfIob1WhpZeeHuqwK
         srfk8SrZGyjfMTYWt1LAhTbdjDzeCLb+s3XGncEQQ/Rikr5H8bxYyxuCx+DiLks/j7KU
         n+Xr1JEP3yO53/GLfdoLrp2MnJYGPvcF55/Rm1Fjcw/qC4elNwPEvpUwi6F+sAC6oLEB
         2ddcHv8x7NPMLkvLm8Zgmm3usGmwUvSC9oh2Wobls7gNEIygXnEn30+lXrWbbZqGC9a2
         X80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741879804; x=1742484604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmOc29W/KQ8GV7fEEPDHqrQj0PGtjLUiSwr7hcTVkWQ=;
        b=Vqkj8+OaM2c0gfdfdywTKirDHpbJ5YRWOgjEmU7upSyV4TuTRiiI/fbtMn7pIH8s6o
         6HC2bfnLIRw7Y3T8o238YORTwwSTBzZ5L7yB8WaqmfGtbFVlG6sLZepIVPq7/ddVDCDV
         zcRQJuinqiV2qOSoqpi8jukhVBW0nw5kdye5RMDed2DOiRu9qxIQ0nMzqeBh6iHaCeFq
         EC3w9XvELT2RUBAWzng7AAXMmDZEULPR2tZI+BHJN/77vm0vHr8D8NWpvfKqFA++AqG4
         7N0ME4r/ZoNCVpoZ6yKwkpZ+OeBrueN8AWQhL5A/XbFLV37q7a6BvO7UePyq0h1pC4t0
         O/1w==
X-Gm-Message-State: AOJu0YzfkOUEP5lrdUvtdBvRdgTOLtz6/akt0vVBS4E18JEKAm0MMTaH
	518Dp/7swpRxhKYm6dTTP2u9p5SEDI5zrHck0FtOtAjxdoAjb25C2LbaQFBfYgH7RAE/lCGmBZi
	FmpCFQcMrEKH7oDZeZDn43wYf1Xg=
X-Gm-Gg: ASbGncuaOS9plkj8M23ulaJZT/dRSR/fVPs+VytZEoa//KwBqTOG3Eff1K4XhImwe1R
	hSJigycuaV4FYcuWBpcT1nNU7vB3EJMUExcwnD2echkClMDdmPQ2dujl9ufGxcLF6COZfDuvljE
	IOgKU+Bmruiwcq1J1DV17zFCh1Cm7Gqhw84x3h
X-Google-Smtp-Source: AGHT+IEyJtvEZYcmNqbh9VyMRIHV5thrgdhbcwauOhJXZlX9onaU/QURPsxzvhKatnPireEsFzRd0cSkC6fdrU3BBhA=
X-Received: by 2002:a05:6512:4004:b0:549:8f15:db18 with SMTP id
 2adb3069b0e04-549c09f5849mr24413e87.28.1741879803728; Thu, 13 Mar 2025
 08:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308133349.1591331-1-meetsoni3017@gmail.com>
 <20250312121148.1879604-1-meetsoni3017@gmail.com> <20250312121148.1879604-3-meetsoni3017@gmail.com>
 <Z9GC400L-XV3SFyj@pks.im>
In-Reply-To: <Z9GC400L-XV3SFyj@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Thu, 13 Mar 2025 20:59:51 +0530
X-Gm-Features: AQ5f1JqbbYjAiIB5Ism3AYi5oYeLVDQ2j1DRm-wfEY6b1VBCKFuQsTuefpzxHPg
Message-ID: <CAPhwyn3rAaFZ0UYniJWUswAWyyPkDNgvKSvRpV6_H9v__txVog@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] reftable: adapt writer code to propagate
 block_writer_add() errors
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Mar 2025 at 18:19, Patrick Steinhardt <ps@pks.im> wrote:
>
> > +     /*
> > +      * The current block is full, so we need to flush and reinitialize the
> > +      * writer to start writing the next block.
> > +      */
> >       arg->err = writer_flush_block(arg->w);
> >       if (arg->err < 0)
> >               goto done;
>
> But there is another case further down where we do `block_writer_add()`
> and then re-try in case the write fails. This one is a bit more curious:
> if the write fails, we don't create a new block -- after all we have
> just created one. Instead, we reset the record's offset length to zero
> before retrying.
>
> I _think_ that this is done because we know that when resetting the
> offset we would write less data to the block, as can be seen in
> `reftable_obj_record_encode()`. But I'm honestly not quite sure here as
> I haven't yet done a deep dive into object records -- after all, we
> don't even really use them in Git.
>
> In any case, I think that this callsite also needs adjustment and
> warrants a comment. And if so, all changes to `write_object_record()`
> should probably go into a separate commit, as well.
>

Regarding the callsite in write_object_record() where we reset the
record's offset length to zero before retrying: my changes currently
follow the same principle.

    - If block_writer_add() returns an error other than
      REFTABLE_ENTRY_TOO_BIG_ERROR, we simply return.

    - For REFTABLE_ENTRY_TOO_BIG_ERROR, we flush the block and retry.

    - If that fails, we reset the record's offset length to zero and
      then retry.

I'm not sure what adjustments or additional comments you are referring to.
Could you please clarify what changes you expect at this callsite?

Thanks!
Meet
