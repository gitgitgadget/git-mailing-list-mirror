Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A41E532
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325385; cv=none; b=VmsE+5TL1amfX0L/ACEHDgw/YaMmDAhcNs3XtjoVayt8XugxzCwzhWv1P/cdJPGZMTdQo7mUhiWKk4vmAF2WQmtXs5fYxxJWpOqZvbcLuq7TIzGHa/EYbs4tRUDRHFM3A5J8o1XPeLPHKBP8icsjrMNQg0DrPlyvKb1U7F+u7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325385; c=relaxed/simple;
	bh=7q9cj75nkOaImX05BkJFJx1jRZDF9unNCgZkpcIlGiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTchvD9aGx3XOrcXsD69DA37zt5Fm3q0j49FlpZLASRq2Fe68QLCvNkPH2Y6FQy55J+EVd186+JJQBmxzTRGef7rn64IbAVQG91NpjLy2bYhe225hTIw5d3OtNnpS13YSQRFA/FamwNC5osGxedX4mYpYDBeOfWEQipW8j4ra5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8jPpB7E; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8jPpB7E"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ddf26eba3cso615175a34.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 09:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707325383; x=1707930183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdyrsYC2fF0xSv7M8u1Ynu0ZfBB+FcmROyYWGIIRZXg=;
        b=N8jPpB7EjqbO5fXtJ5sXwOFmzcJ8gAgpEPBTmmapINlbL3Akn+jYRjj5elezjbpazp
         +i/nYAfP8b7F53eMUh+Xwv0kTs0PgZOYnDzT5NsqnEgFRMjRt3L3IQNaWAjqs8O3W2g1
         9D+q7AopE94Am8dNYjTu20uS4my+ocVaizge4566nzxEkBaeh9AUrFeWvR2EePOfSqyi
         sGmzbJaH4vvZROfaL1q2pvAyqpF3Vd7kHLHaEv3vl5hMy+X6mKqHsxA3zGi2fBZ0uLsn
         uq7t8pN/4IxYCVPmQKukKjsL+Na7C8fADnc/sZjdfUiaB96KILOePZ8GotSPGQjJisyi
         Z0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325383; x=1707930183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdyrsYC2fF0xSv7M8u1Ynu0ZfBB+FcmROyYWGIIRZXg=;
        b=QsRjpoZUKCi0beawsvOLxgjl6Hj9Wsd4IEMVCt8tRxmkPmJEmo3nxdnKlREiCXvpd4
         7m7BrtitO3kO9oZlLnxSXdPdsqPDW2FuD6Ld/72TZy1VsHrfMG3QVlgzzo8BNe8mXSU5
         +0Ud6i7/YjYxUv3RU3Q9AG2nSsrbvh/+KzGMECk6SmrtsFIUegVR2fpIgqxTCtsCLMy+
         wFLiecp6xlzTSbnOHkIRjcH9sCOALOreggMbiOoK4nxcaBk7MZIzMSe3TobHunkJIP7O
         MVthtUG8rtIb6SwsthprkYkbWyJh8xU09gQKcL1fugkWSTGUtIhiCyXV75Iw4ZI+Ko8d
         rNAg==
X-Forwarded-Encrypted: i=1; AJvYcCXmSLpAL3zXeE9P3k7qTE7NY55ebt+3q9Y7OcrxNYIFPF3Axd+kkBuM7qDnrqr10cG3oy5lxYy8rD65gTdsRpWReeKT
X-Gm-Message-State: AOJu0YwRdcRqo3yuNWt1v7G08h1wl8RRP0ymH0P3xFYrEzQBz726wsdb
	E9nXEDOVIaAvFBTnqTmiCBm89VfDz3sv2UbLRXjyr1iaKpzBSfya/8OzUFmP0hcsST5crqykbd9
	9WFPeAVfYCh76F/yPoNQOwfFTNME=
X-Google-Smtp-Source: AGHT+IHvt1zsXhF2dgDD4+nKV8owq/X1oUxxnbhEQGYUWNZ+2gFw56lQDl0mUvSo8I745QLQRyGvpMQQGChogyhjjlk=
X-Received: by 2002:a05:6870:3325:b0:214:a08c:5220 with SMTP id
 x37-20020a056870332500b00214a08c5220mr7194001oae.20.1707325382921; Wed, 07
 Feb 2024 09:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com> <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com> <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
 <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com> <xmqqle7xjzic.fsf@gitster.g>
 <xmqqr0hph1ku.fsf@gitster.g> <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
 <xmqqcyt9fdc7.fsf@gitster.g> <CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
 <xmqq1q9oe029.fsf@gitster.g> <CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
 <xmqq1q9ocje3.fsf@gitster.g>
In-Reply-To: <xmqq1q9ocje3.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 7 Feb 2024 18:02:34 +0100
Message-ID: <CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > This is a bit of a grey area, what I mean is that we do allow users to =
create
> > non "refs/" prefixed refs:
> >
> >     $ git update-ref foo @~1
> >
> >     $ cat .git/foo
> >     2b52187cd2930931c6d34436371f470bb26eef4f
> >
> > What I mean to say is that, by saying "--include-root-refs" it seems to=
 imply
> > that any such refs should be included too, but this simply is not the c=
ase.
>
> But isn't that a quality of implementation issue?  I'd consider it a
> bug once we have and enforce the definition of what pseudorefs are.

Yeah, that makes sense. I'll use "--include-root-refs" then.

Thanks
