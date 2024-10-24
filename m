Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7079CD
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729440; cv=none; b=o91p+JNxp1w98KXM50CiU+b4VnS4nuYgOSsNqC78tAbvlOPtNQR6/nX7sYNTZVB3dm2HPw8J5EIkmPs8rXCe6H2qlOcC1/+mU2UoDr01WnYsIaDrsWJxwKg+Sueb8UHEN9K+1JIND8GKQZ+Db9KEG/f+/DCGxSbnQpZa82ACvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729440; c=relaxed/simple;
	bh=b6C1zYZxJgMSYfhanDzmqU5U85Mu2bvvJr7TvF/eMGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAX8dA9PLueqyGwUAOwK6YCJXbauXmQmnchOZ+1zXJygj3q4RmHyfQfCWFldoNr1rUGe2eP6pTU7LkNE2dgVOtwkhmNFZB+4GTJB9iU/lTLB1ve+T70lMHwa5yX91frHzWxgNLJz2myC4TfZB9oRqxG+pQ6tE2ryjRm04BE4Kt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWcb4iMO; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWcb4iMO"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d399891d6so89790e0c.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729729437; x=1730334237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeZirLupDqpUQZszC43mbC4A9hoytFJKFaY7eLzUucU=;
        b=JWcb4iMOgVCqEUfPaztDTcO1ivfhtnf/WyjVrgloVhgj+TUA/KO7xn2WQGKPVy1dSb
         Yxmo/cPN2N4jOIfN8c7StrqIZDzjGF8nef2ATNm7ArtQYeu/ob05ARd+dNxQowIgw75d
         huZ7SUQ2Gnm4X/np8xNH9wW3ZqHFIb1xFSmMTGTbT6PocKVY1qc9m2uEqyqslQeiohle
         wMx0OuoBTilsxuvRyS4VpuYRLqLcwQWbzAGVpG89gAkz/BoJJaXqvjn0+iWhwd9MDYY4
         +2ReCvEaKVA726Xjglu1CWS3KZw+Xl0Tdk2fGvcZS5i5qjqPHnQjo/pgxtnsIcN4tIGi
         6Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729729437; x=1730334237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeZirLupDqpUQZszC43mbC4A9hoytFJKFaY7eLzUucU=;
        b=CMKzKDbSYCyTGH6lTShl6Es8U4YQo5WZsaQ64f65V4xFSYg/ttl6lru8pTOdHnwlNJ
         pnCLFOfl/yZCMqsOkkt6/a8BPuWwC+6Adx7Nv+cy6xtDme0tzG/yQGB12BZISIouqaqs
         gIzNabzyeSeruQQAQ9ufTN4L/WQDeZXbXN3rBvXD34GfE8nszS42nyomqTzxxZZntgKN
         ZEj8cnil2gEPH6LO4/vHhHuSkkTkGSNG/IdLxzeoxeU+t0kvDts/1myQE+gZvLV0IQ5c
         XIzM8sv15vSDAjlI3hLKVc0imOBR/NC6gWMy7+UpbgRAr8PkxECehmVYpmNEey5bOBNg
         FnEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7+S0VTZycKw8c5u4kRwSbPqNL8nMfAue8q2NQXyYvyXRqbHtQvRUN0btRDvBSSyos3nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKHdsuNMCjJ5oJA6GUOl/pclHMp6KRdNG5Qisqi52AxlmSAOl
	fAIKXiLNcSSaN5o5zJAku1l2mZEtvlFlXhvklw5n41WSl2ucMjoWjNUyzefsueZ1ipdMGJvkHGL
	FJ5qW803A2/ZQSdmBJbvZ03H7beo=
X-Google-Smtp-Source: AGHT+IFrc82zF8qhKnWqAHROhLUxXNkveTKz8oVFrTup4qeTsmsUVUM6Knh+Zpi+wte2IIxRCTysCcVAph/oh/pzjJo=
X-Received: by 2002:a05:6122:2a41:b0:50d:160e:de73 with SMTP id
 71dfb90a1353d-50fd0222e08mr4850491e0c.6.1729729437392; Wed, 23 Oct 2024
 17:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
 <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com> <da9ea10e4e115777c16b32f1cde96a3df8c5cbb1.1729669221.git.gitgitgadget@gmail.com>
 <ZxldXMfsCuiyeIE8@nand.local>
In-Reply-To: <ZxldXMfsCuiyeIE8@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 24 Oct 2024 00:23:46 +0000
Message-ID: <CAPSxiM_itN9gHJzP4Zg6MKfLJKjgLW_o1jp0OqcAEcvn7ZcR+A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: Taylor Blau <me@ttaylorr.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:32=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Oct 23, 2024 at 07:40:19AM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
> > index 9bf95249347..c2a9cf03808 100755
> > --- a/t/t6406-merge-attr.sh
> > +++ b/t/t6406-merge-attr.sh
> > @@ -118,6 +118,12 @@ test_expect_success 'retry the merge with longer c=
ontext' '
> >       grep "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" actual
> >  '
> >
> > +test_expect_success 'invalid conflict-marker-size 3a' '
> > +    echo "text conflict-marker-size=3D3a" >>.gitattributes &&
> > +    git checkout -m text 2>error &&
> > +    test_grep "warning: invalid marker-size ${SQ}3a${SQ}, expecting an=
 integer" error
> > +'
> > +
>
> Do subsequent tests further down in this script depend on .gitattributes
> not having invalid lines? If so, you may want to instead write:
>
>     cp .gitattributes .gitattributes.bak &&
>     echo "text conflict-marker-size=3D3a" >>.gitattributes &&
>     test_when_finished "mv .gitattributes.bak .gitattributes" &&
>
> instead.
Thanks for the review.
Usman
>
> Thanks,
> Taylor
