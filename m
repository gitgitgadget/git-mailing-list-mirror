Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449D2EBDE9
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916557; cv=none; b=XTMVnyTybvRxXHpR5fQ8enXfNHxUo6tJfXBqFKkfNwnCyiLVTS0Vut+yaiLObQM1fBq4bfrH6mrg13LH5EocsvRJ81guVKO/47Qgm5HZvMy6JzUmgMQLTLG7pX9BUgcdCrb9/L8G4Z9xVuGHaGPJjkJz1g2tzfQjTUUd1FHMaBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916557; c=relaxed/simple;
	bh=V1f+9ZJrk7L9QAx+aGDL9nOON4RuHOeq5OOmJdqinAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYuSqpMwof5syktZCknteemZDgciCbLDYEmFTt8fvkm4drUGn4hGldkpISDjMC97ocZciCF9ICaOnLMCE3NNVze0q85bgeL6rH8FyzmlzMwW3M+7lQxQ+PuH9Iwy++JeECHoDLfiLFF5GfMOGx3AkqWY+fvUKuC1EH+UhO4bBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAppQ1hI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAppQ1hI"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so361613a12.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759916554; x=1760521354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNZDGJxx70XTFrAmg9Fjx7KtmGnE2m4/nOLibRdHhMs=;
        b=kAppQ1hIR0HIkBFKWZqJZSNUYCLmar5d3Bgo7G6Cc/ndtFjwqijmb0QhfV1EL95uxN
         XIoqmza3yTnGmuW6MjqfYgja5K8lpEmUCuNSK3hUMO+U4D7yQSUfeQs6Ht7deoQ/1a+k
         O9Epj/3UslBduGXhtUeYwmGZ0+y0GphkIZhzSM0KnHBuGxkuBQLS1aAq889g8jnDQidX
         UYJxoKucP1CZCJvZxXNrQODN9R9U+aTTeFM3kmFVykDhZjY5eC5i1qkLiI7PFbxUSjfN
         81CA/AVRX9QpdEmLqY9GbIIwLtFPyLrLwOUeLSNIj6CHi7S3Tcl6HHvolxEatWOx5hi/
         P5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759916554; x=1760521354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNZDGJxx70XTFrAmg9Fjx7KtmGnE2m4/nOLibRdHhMs=;
        b=UoEUPOhNAhO+X4hkFjySasvWhkULewhOXC/N5zARRl9CkN5djRyImF+j0PMmxpC32E
         IN+ZDVjNgxMwGRxK1OCc20er8Vg2ktNGhN32PJkF5gl4UN85d+Ma+533f6mcqYcLTmGp
         w4oStjcL30CH55AV2tv8lNOUH/rDE+e5idRqldtPeREIwrAPrGnAO2d0lLXXQZkqgB3D
         28IbuAqZtSWdN1FJQH1vKeNaVCMvkQLIQ5BHdzEgefjQG+5OK4tc1RASxn7tBV7252cm
         wLNfwwZ2YTrTRjlv1sageyZ7aUO2lZymMq1dHVrzF881bksoYiTTCK0dXtpUay1TsC+F
         qW7A==
X-Gm-Message-State: AOJu0YzvIH6gCKZAB5+WN2mUWXQHTNKPFUwahqNhk3eblMdfY/EL6pkU
	aYxbVP+ufln/E+HdUdfayZbQzrwuWn1M/lzN4RG884dJSN2gKun6A3EjbrGPg4p5D81E0k4xElo
	OU0qwZzdzNKqaBIyYotY2XBeqDUng8lw=
X-Gm-Gg: ASbGncuQ2fFRXQCNt4H+6krujbQc4Xu/aivDmL3ldNB3h6YZQs5OSoHcbj3wCCj8eBk
	xULcFCZ5V3RxOUQnOSFZAj8ISZWiwFln/kU1vNesvMcvT1UE35xQDazqHfDsh92rnw8EDmOvhGK
	SfSmKvE6xRGUaPp2slXJNcaAZ/61YGF6rokQ4T/KVfNoGDjJuN5n83eqfGwGhM14Zq9BYnjqXdI
	aCXANQ6gYkB9jRGR1+FIMfToK4A/o8=
X-Google-Smtp-Source: AGHT+IHZnzhosD5mBLkVLa/Jb2gJro5bX5fU0dyjjl393BjPwpnljbXhksQrpXEYpIVrGaJMSZr7alV1c84F5X8BOug=
X-Received: by 2002:a17:907:9287:b0:b0a:aa7e:a191 with SMTP id
 a640c23a62f3a-b50aca0b70cmr316578466b.57.1759916554097; Wed, 08 Oct 2025
 02:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-3-christian.couder@gmail.com> <aOYPTKG9t4ZB_Mbi@pks.im>
In-Reply-To: <aOYPTKG9t4ZB_Mbi@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 11:42:20 +0200
X-Gm-Features: AS18NWC19gNOiw9SiMi0yjS_6UTzrkPbQ6hOkMFNUdtOgFgIIIGfEgXlfu0VTEk
Message-ID: <CAP8UFD2VRfZuaycCdWt4kpVpRv_UhNHdzqJ2vL8uyKJusUttnA@mail.gmail.com>
Subject: Re: [PATCH 2/5] lib-gpg: allow tests with the GPGSM prereq first
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 07, 2025 at 02:29:55PM +0200, Christian Couder wrote:
> > diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> > index 937b876bd0..743985efab 100644
> > --- a/t/lib-gpg.sh
> > +++ b/t/lib-gpg.sh
> > @@ -38,7 +38,7 @@ test_lazy_prereq GPG '
> >               # To export ownertrust:
> >               #       gpg --homedir /tmp/gpghome --export-ownertrust \
> >               #               > lib-gpg/ownertrust
> > -             mkdir "$GNUPGHOME" &&
> > +             mkdir -p "$GNUPGHOME" &&
> >               chmod 0700 "$GNUPGHOME" &&
> >               (gpgconf --kill all || : ) &&
> >               gpg --homedir "${GNUPGHOME}" --import \
>
> Okay. I wonder why we even have to create the directory manually. We
> don't do it in the GPGSM prereq either, as gpgsm seems to handle this
> for us.

Yeah, the GPGSSH prereq does `mkdir -p "$GNUPGHOME"`, but not the GPGSM pre=
req.

> Doesn't `gpg --homedir ... --import` create the home directory
> in a similar way?

I am not sure. It might depend on the gpg version. Or maybe gpgsm
 does it but not gpg. I will check.
