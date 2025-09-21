Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9D34BA28
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758470601; cv=none; b=QjBBkcw48wjMGRHhrb1LuAGTq5olLAXWn8//lDa3DsiIe6EFVK/LryLRxirfqHEtqqVYk96I3zK5pHlYR4i5J+elASpGdbsoGRbfylzNRwjnEgLBv/sMYNlD330itY9Nig24Hg7bfjE2U1TwCTPCG0D6xJhBiOCAbMGQivMVG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758470601; c=relaxed/simple;
	bh=qlrd4uudteI1Q4m0/C6p8DuZRKSkx9PMeOcoRsulcy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MztIMTFabjGG+EmrpCsYRjUaQDrlick7wHevCdYE4LtQxCq5u8wKenXAG2r7wV207o+o+Aj7kBaQ9z1KkPg1ddJnmp2Vy6JU7Z2dqqVse3u1dH/DSuUpW7/1lMA03qNtWwEngtQ86joUeAl6sBJt1h5Qaf3K7soSmDJKmV1qJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGHk29vi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGHk29vi"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-571a58b385aso4384240e87.2
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758470598; x=1759075398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2Y1ZyI7bETlqLNwSfVBgRwdS2i9sz4sWFL05OAS1vg=;
        b=CGHk29viOtNd9reJ/dl7A1bibf1Dorjdw/tZfoMyFFgoPkJsiWqgf7F8xa7JrrWlr/
         Ep2/2YL+jbx7/rR7KMqQ3yNkv2jZdzz/ZP0PwX5RLD5C5UT5yfiBQFpcWAObKBBsEnyi
         d0eJqNhxcMzTtQSl6HvrQvKaoBuTQnd9fMBbGkwUPV3uCvp9duomnqJmejQzSwRr1dwm
         eGJuMpmllLa+dUUbTXjo4YYaUJBu7NkOcnwUYoGucbLg1EnWQYlzVWNrcj1qR0sr8FxC
         AAlJ890vSIfQlalKyP+qqJqzOSFRWnUCFXt16lxTYZAu+eMnf4Pcc1agoll9NsCE/Y7a
         3ScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758470598; x=1759075398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2Y1ZyI7bETlqLNwSfVBgRwdS2i9sz4sWFL05OAS1vg=;
        b=e0P5wcaG3XLZxhX70c8VVd4zOiNsZeLEbrIyUVnStbk/QDL1XJeLqh8Y0pkrIJJN2g
         oAl6LCOCmU/1w/l013nwmAbfS/m3iaZQ199V5/4oFwKlSj8rbDNpkM9fxn1EfAnpMlrJ
         /dNX/Wzf4gyrwp1UPu9arzovYj0X3DwAlp05j3CeW9+bQbEP/ljyrhEcfZ8s5d850e44
         Av8EOded9kgSn9J+hVczLHE/2kNtwfw4bmeUr5SYq3BNWIfknV8VZmMszYK4fG49glGH
         VM4EuwwSGiNSiml9l77D3koD7stT+wrtJlz1ZaWRdU4t0uLIHcarJ+tCQ5ezJsdpOA4I
         GGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDaaNOcCsB/uURloqN51KrRMiKZErQpSgYy3SPsTBMvkOiR+5VsuZIQnP4t5tWaMQhT8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXl9PpAUbR8nta1c6Yw+3nrfpEp5k4EdwIYkGHRcqqu95OOMc1
	PWIb8jkg1FeBjbJP1MCQTnQc04lVKBe/vQBOvzrqY9wtGbdL3/Ov6nrcLFRmpqruK1LPm86m0Ud
	vINig8GhBzE/6vEmAFijizDDlH3RqwwI=
X-Gm-Gg: ASbGncuXLG40Vu2FBGF2WrAvWNyWaR6utQKzuacCSdF7+aECLJBlb7Dmi64JaGDanmF
	XlasqtVHrRl0hzZtOVEPGDXfDGiz8cO7frdtwY7Mz6vxlUexwu+0mzjfHauneWSxNFsmSXClkRX
	8FPEs5ysQuEh7IzrttoUrQ5LRqTKjhMcVII0RDAL9Y/BRwaBNI97GYe3z27XviuUcDIhQ8yA46f
	Tm1KKqY
X-Google-Smtp-Source: AGHT+IHNbrRV6K9dGwH/p3kjQGPDF6eKZ8tfWqNpqCmTqWHHSk0AOkJ1I2RzjCa4zSNLl2B8BtyFHO6ize+8gVvhotk=
X-Received: by 2002:a05:6512:e9e:b0:579:eda8:6086 with SMTP id
 2adb3069b0e04-579eda861d9mr3291295e87.8.1758470597704; Sun, 21 Sep 2025
 09:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com> <807ce3e5aae0253dd58c7a4d0bd04ca341b070c8.1758294992.git.gitgitgadget@gmail.com>
 <7979d8f5-1e97-4429-891a-678adb3ba54f@gmail.com>
In-Reply-To: <7979d8f5-1e97-4429-891a-678adb3ba54f@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sun, 21 Sep 2025 10:03:06 -0600
X-Gm-Features: AS18NWAcJVBzhP9D_q9oq2RBaGef_eBzes26a-Dv6ns4HXYch1_IDXBDjOEXj9g
Message-ID: <CAH=ZcbC1+cTP0Gah8tuz9-kKxJKx+TghTMvLPQ=8E_2wRUK8FA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] xdiff: delete struct diffdata_t
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 7:06=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> > Every field in this struct is an alias for a certain field in xdfile_t.
> >
> > diffdata_t.nrec   -> xdfile_t.nreff
> > diffdata_t.ha     -> xdfile_t.ha
> > diffdata_t.rindex -> xdfile_t.rindex
> > diffdata_t.rchg   -> xdfile_t.rchg
>
> That explains some of the changes here (so long as one assumes the
> aliasing is a bad thing) but it does not explain why it is a good idea
> to remove the local variables rchg[12] and rindex[12] and instead
> dereference xdf[12] inside the loops

I removed the struct and local variable aliases to make it easier for
usage-tracking tools to follow where fields are actually used. Whether
someone relies on grep, ctags/etags, or more modern tooling, aliases
hide the true field accesses and make it harder to track or refactor
those fields consistently. By using the fields directly, every
reference is literal and unambiguous. Also the local variable names
don't add any meaning and only barely shorten the lines where they are
used.
