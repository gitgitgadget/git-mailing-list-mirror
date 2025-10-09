Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018672E1EE1
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012966; cv=none; b=Wq2C15X9FqflZWAJOzEGGJWoFW+H5eJD3U4FZPWcdCozct3UkhA5XEghpG5h8PNoyg/18Tnusm3lwnmWYSczXGvnCmlcSKzeYy9GQHgc5i2IcHmTlqCMqaZEOcmP18+6/jw3Yoh6UmjK1K6kXgM3DJv0LRwFmF06qkaUUa54/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012966; c=relaxed/simple;
	bh=3i8EeJMhi3hZMgwHL1FBe+Jd+EwZ0NuSu5U/6nHxhfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciCvYYVLXd+sfpYDjV7yNgC/j4IQEgZOqqLKlBanxdYc2jqFheHhR/VAoz70Jq5mL5/8hvwqnSQjV/wAc6AYAepS0J8m3tH6KJ0bh4GtbK0D2mzwtIBKA8ZKIhEhyEomIniJ+8XObxmiXNt3Gp67TtqY4+vG+mlLfx0DE9LBp+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6W3Egsr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6W3Egsr"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so1708319a12.2
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012962; x=1760617762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf1OFL6MOpAKXwBqK4L2A6oYnW/3xzE4V72kZnRqXFE=;
        b=A6W3Egsrh82pc2iLk4IQsBdXJD9u44B361IyqrD0ux+JAvnkemWYkE+skTdczh1lBq
         k24VMB5zWKZpxClx9W0FHK60D/Cj+TC0AMb7YVGdn3pC8P3tgykIyZkd5/KYZwY4eusS
         PcD6BwvzUzN2xY4CzQV8kLS1RQU7pVg/DBDNQRh3mOaiO/JbW/xdBI27yR0rcOfHrraq
         IPUyoW15H3m9RcUk6vbcsa5M4BzLb1csJsc3ie791Uabn33u9jDUY/DWk6zf3W1T0mdK
         v1WJq0q+eRg6sevoPuX5OMOLR40WVCvLz6SYrwFTgTdIb7DXYHb7zJPbQDnke5prMz6I
         9vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012962; x=1760617762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf1OFL6MOpAKXwBqK4L2A6oYnW/3xzE4V72kZnRqXFE=;
        b=UqRrDjtWh7vVt7IdwxZ/slkQkztigfH3BkJU3bEXdTbplj8ourqbl0i2ufG+aVUxr9
         5v2HzBNZO6ssHai7A+Z99TU3bs6BfJXEkElXxKfMEbyzj5PT5D46LKtTSn0L//TKlGp1
         tdx16KE2vw+d/E7G84nZz8CE3noTzYp2DaPd/ZVm9PpBXSmuUGDoPiQi+X6ZW0L3tSOe
         7m6Z3pwEnCAX8v4NenX0ZlGVBVe80pADIdwiyMrgCyrlnNB7sSJDUC/+T/umSfZmzfmw
         92WpjPgzowzBunEOftDGu+Dl4QK3TeenjDFmUT7g4edxz4r1Fv1fSYVxudzAHqVquWY1
         G4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbx690QT70Dp9p2W/cMgc4Mzz19+ksx+e2TZJjqslPbUI4vpSjxfSbUFdjL1Vma0r+mE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGH0iFPCTgnTwLD5GNqoVxPfR0nja6TUxUB1GpjHVRUPSPB1G4
	iENeUZshgg+/qPlB5VtzbXudH5nV+Y9vLyVs+f8H8a4Z1T5lFTYgZe8KPGkYjwdGVSbdwPG5ifa
	p5Rt08HCrVOm5rc9qgHpbSmeYQUprfa0=
X-Gm-Gg: ASbGncuzWUL8zaZcFbqkFFDwAtDPtx4ffadO53m3HMQYoJX59zPprydu1Q5PuFG0pPx
	vUwqMqlLGEtOPnWeSrhCHtllhvVAVr+SgsamOAct1Latk4n4JwvKZYdmPwu2Z8yRktJAdDg0LEe
	gmx27i44WqvDy5EfEkm27lzo2LSGI/LqhxxVSTHfBkak/OWKc/cCknmgGVDPjhOiZLEyV6GvD+E
	hSjbpNMRjnFm1ZOiAJHWUc7FHfCUDE=
X-Google-Smtp-Source: AGHT+IFzpsH/16Glmzk2XFxexs90Vy2aQ8rxr/j+AVmOXAoOUEfoRaLuT8vMJ0NgYjfITpqVTBJ0qdV2F2HVdZXGLwU=
X-Received: by 2002:a17:906:eec7:b0:b46:8bad:6960 with SMTP id
 a640c23a62f3a-b50abfd69e0mr787376166b.31.1760012961678; Thu, 09 Oct 2025
 05:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-3-christian.couder@gmail.com> <aOYPTKG9t4ZB_Mbi@pks.im>
 <CAP8UFD2VRfZuaycCdWt4kpVpRv_UhNHdzqJ2vL8uyKJusUttnA@mail.gmail.com>
 <871pncdfrw.fsf@gmail.com> <aOcfzgxOwGemReNm@teonanacatl.net>
In-Reply-To: <aOcfzgxOwGemReNm@teonanacatl.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 9 Oct 2025 14:29:09 +0200
X-Gm-Features: AS18NWBBiBHMJmC7M1ZNp6kJYDlh9OEnhtvffz-Won313ncb2cL8_PvVesABXk0
Message-ID: <CAP8UFD1RKL0PgkghQstNA=o2TzgATXWcqzfEwEs-KadyLKSK-g@mail.gmail.com>
Subject: Re: [PATCH 2/5] lib-gpg: allow tests with the GPGSM prereq first
To: Todd Zullinger <tmz@pobox.com>
Cc: Collin Funk <collin.funk1@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 4:37=E2=80=AFAM Todd Zullinger <tmz@pobox.com> wrote=
:

> I sent a series long ago to fix this issue=C5=A1, but it wasn't
> picked up.
>
> Fixing the issue exposes broken tests which use the gpg2
> prereq.  That breakage turns up in our CI and other build
> environments, like Fedora's, but I was never able to
> reliably trigger it locally and track down what was broken
> about those test.
>
> I believe I asked about it again a few months later and it
> did not gain any attention.
>
> I simply apply the patches locally and then disable those
> tests -- tests which don't run reliably are not worth
> running IMO. :)
>
> =C5=A1 <20240703153738.916469-1-tmz@pobox.com>

Thanks for mentioning it and sorry that your series didn't get more attenti=
on.

I have just sent a v2 of my series with a patch based on your first
patch. About the GPG2 prereq I added a NEEDSWORK comment but didn't
change the actual code to not trigger the test failures.
