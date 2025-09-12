Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63282E8B90
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680824; cv=none; b=Y9dgvCX1obXc6NSQdyZj8LZssvSzTFifQFcD1cfWDgOTezJLzlzw25hjcEpRH59omJl9QdV7kBaQT3RI3yqeTRqLP0E6Xdkv/KjGIGwWB6ZzhADHNvZ/q6QyPhXITXSZ7InKlJ1b6sNMuzod4tH7IGPrxN6eymxfAkDcOQSTZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680824; c=relaxed/simple;
	bh=6z5CQh9tVKJ3yySfGAgX9HLijwefN1REVMLdh/GnTuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0J1j+6+rWOWVGEiUY0xOS8VzvsPzbOM2l3/0JoTE4NQRVgnMl85+ijsBopXOQCx43hx4zFADenuPG1qdxgTrAAEb+zrGEzv2CFu9Rsg4rpbrksC2Y/cRkV1KRgrtJeRCQOMcYBZl4l1bgq72W1v4NjmlhioTs8DWc2e6v+7Ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhcdXqtc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhcdXqtc"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso245909a12.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680821; x=1758285621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEpM4JbQdZRPh6w2pBJOZn/0NVW0QuNyAHonu6uhslE=;
        b=lhcdXqtcbHBaweWG9UlG2TMmKmVkweHoM3zBplDmuIw20T3kyKjeZRG7pcye2OyGtU
         LsEu4XlLnM7jnPD9FSKLUUVj2fIPltnZONwZGYYBhFgILLO0azUtm996IZFN2SC+uNFI
         vHwfhkC+Xx1nnNzU89CLeX7wFOll2oa1ugM5IaYxgLEruY2LKxyVaLuSt0N6s7i/Jhok
         AuOCUdofd+PRLrTTVTcs4qr+bN08vr+Gv5HqBR53Rb3anh8eZw9OEyZvKVOQ1H4UzabW
         CMTAeU4ibvIyKzLrlylIF6E3fxVuWnXvkxOatTLLPiEBf0ka5ybRzO8JnrpWi0CqcTSh
         w5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680821; x=1758285621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEpM4JbQdZRPh6w2pBJOZn/0NVW0QuNyAHonu6uhslE=;
        b=MgkTZp/sy7t+rLIUC6SnqP6QOZvzz3DW1JNhXtUzKx5yiuv/K1GdHTFcSoicMAf5p+
         Ggw3CyhP0O43VCky1jDFLkZkPsEezVfPLqlj11iDa6bCVCJ3nQfLcogkbjS2l2G1R9zj
         GHYMWwhtSdFX9nOMVoCuJEziJlkrm2F0SjqKBaYpcmItcR2D3rnJcKdkcOOlbRknL4LI
         NLXA5NeGzrTPmV7efkNkNArLInIdO5ta44GIB4wld+pxXuFMLTAJ/SzoIGRr7IwLX1CH
         Iz2/ScP6Ak/1z/xopGx3UKz4V6nc54zkbj5KUu0McDoGFayjP7bhV4Ygi+sf6jjhtQtu
         5Otw==
X-Forwarded-Encrypted: i=1; AJvYcCXWJdF8Un+nPmvF59JwhoTCaQqP3OzortFHmQvE5RjHDzXxpe6COsFl/QiyeD/NnZwsWbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsjzZqt+pOAACllIW/7ui/tDyt1EnKM2NpNrXCND7SucpQfC9
	WBFEG+NKkKDmt4pPJO1TANvwpWhB/kFQJmC3plgVeNRsgw//XC7zWN6FkSSBioBdHTZkwknQvmq
	j4z2rY0neAUMZS/BMu3Pv2lpqQXj3RVA=
X-Gm-Gg: ASbGnctzDrNWQAvkOr+hkBEG2sXUFUAi1ATHhH4Rag0ee2rMK2qbrMfnIqezkr50Ert
	hs69KXcbDyY5IIMKGd+pEObn8pa4/j8Rq6b6zJ4cK7cRG5Rbj+gr4ANMhQ8gOxxnjn4l1zMwqRQ
	6MKxappH73t33mIUQMRLwOBS/5c9apyTnX9aP48G9ZLC6pWsIP2GwkSUYXPkI0G2OciJ63mI2oL
	Cc40Td8r+dMw/C5GLcs
X-Google-Smtp-Source: AGHT+IGKnO0ywSPqxvqhUtjwmwS/q7tz445t2vYKl7kh7tNU/6/zrSUwnKOOSmpPJGpyrZNSSdh8JJrKtyO5thtgpu4=
X-Received: by 2002:a05:6402:42ce:b0:626:d96d:c0bb with SMTP id
 4fb4d7f45d1cf-62ed822bec7mr3035081a12.9.1757680820766; Fri, 12 Sep 2025
 05:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-2-christian.couder@gmail.com> <aMJm57VmWb3h167z@pks.im>
 <xmqqcy7xosu8.fsf@gitster.g>
In-Reply-To: <xmqqcy7xosu8.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Sep 2025 14:40:08 +0200
X-Gm-Features: AS18NWAevdFaIS8qLBY68MbWWHvksHdo_Hj-TM3PBwEcK3LZC8KNys7fvsNyUcs
Message-ID: <CAP8UFD13RvAD1d588onpv88LW73M_YPJ2aaAHeoveFtcCOAhTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpg-interface: refactor 'enum sign_mode' parsing
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 6:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> >> +    if (!parse_sign_mode(arg, val))
> >> +            return 0;
> >> +
> >> +    return error("Unknown %s mode: %s", opt->long_name, arg);
> >
> > Would it make sense to maybe reverse the error handling and say
> > something like:
> >
> >     if (parse_sign_mode(arg, val) < 0)
> >         return error("Unknown %s mode: %s", opt->long_name, arg);
> >
> >     return 0;
> >
> > That reads a bit more natural to me at least.

Before the above part of the code, there is:

    if (unset)
        return 0;

So it felt natural to me to have a flow where we continue to return 0
(success) if we can and go on otherwise.

> I also thought that the original had a "Huh?" factor, but my
> reaction was more like "wouldn't it be easier to see if these are
> both sides of if/else?", i.e.
>
>         if (parse_sign_mode(...))
>                 return error(...);
>         else
>                 return 0;
>
> which made me think that the differences were mostly subjective and
> refrained from commenting.

I agree that the difference is very subjective. If there was something
like for example:

```
if (A)
       return 0;

if (B)
       return 0;

...

if (F)
       return 0;

return -1
```

It would feel strange if the function ended instead with:

```
if (!F)
       return -1;

return 0;
```

> But after I see your version, I tend to agree that it is easier to
> see the flow if the most-straightforward success case ran through to
> the end, while exceptional cases (i.e. an error return, or the
> initial "unset" case) did early returns.  I have to add, however,
> that I feel that this is mostly subjective and falls into "once it
> is in the tree, it's not really worth the patch noise to go and fix
> it up" category.  If we will have v2 of this series, I do prefer to
> see it written more in your way, though.

Fine, I have written it in the way Patrick suggested in V2.

Thanks.
