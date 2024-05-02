Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8656773
	for <git@vger.kernel.org>; Thu,  2 May 2024 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644219; cv=none; b=LumpQtGGZz27Gw9HVT9ezIUGCC3E4CL6MRNoVO99uzBKlNooqRH2bx6TUh/Q5INVdZbhyWPApmRTVbx8tL08hACBX6KwSFBi5DWYhsWAHbcs/J8D4WJsPWfI/IK5EmIJCgaOcUSKkai9YHzmdbuB0VmmGxEAgSXvUWK3q5WK4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644219; c=relaxed/simple;
	bh=rwiVWd80mKOymNTr7CdL1vcpNTJ8luag5cwyB/bIU2Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QF2dlBacfQZtsq/gO03rTqPEWUHX+gEkm5t4FQo338azIOATMjnRhAYICuKYgH/azyWN0DMPeVCY0KceasA+Yo945D/16+CutDm5o6aBCglyUt4Hf/Vq6Z5o6HqgO5ezmkMuZBh121cd/V8BK3D49xA+ktK7o/Yt3LfdaaDRXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cc67bCcy; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc67bCcy"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23d5df2d600so893875fac.3
        for <git@vger.kernel.org>; Thu, 02 May 2024 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714644217; x=1715249017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=340zH7JoHbya+u3kB9BW6l+u5iSCI2wi4stiO2k0BxQ=;
        b=Cc67bCcyKL6vrDQt6/SU1DIaUU67/9x64sfVH1Hsk4VrNOm7adPwT6J3t1/DR/sOuh
         yyNoXqtNlJIWDeauYD3H9pkNaiaXaB3+SXvnPRUbkGZRYVzqyj2b18Pl1iAJN94ZYiVc
         /YRtf72ZhOQGYGyxdV1ZEGT++OzYpC+2D6XO250dE0hi4oSJ5BQI/okKjDvBRBAJH6Dn
         or1Qz1BVZk3ZVWKv5rluf/jDvE17xRDuRa1k0Crcw63xF8xGnxKJZwARQ99fSWizAr0D
         wZpp0/oN7pZRPglrOagfZvabKlOxxcqmK2+x372/it/EMb9BTBhgMMFRb6xgLUS8LOlp
         SrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714644217; x=1715249017;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=340zH7JoHbya+u3kB9BW6l+u5iSCI2wi4stiO2k0BxQ=;
        b=L29bdoiTonFCAhh+IKxd2UYy6tORUB0f59h4NS/j80ZvQrON95WL65HNi77ZRhznba
         CLRzZs46j+6WLjSDJu+4lJALFZVnFfpdab5GadfPKCkUszgWmD5WCEYbQyT0P4A0L4fy
         gbsm7haZZwdMmBKCeFVHmhtxosOJ17pWim2ZrSgLOvvm32nw0qMvgpd8WVK0EL9DPV0K
         Mr78hgyuVbe+jSMGsIdYrwByz+gGm9eK5a1v61xQjqAklCxuIhJbUYBcC/Jv4oFDlE8a
         JL1rlfEyDfI7JvY6Fc66YWqT2TjAP0rYvk/zrUEjKtujHLl9aQ/tMxiC5Nxqc8JV1ERq
         bYlg==
X-Gm-Message-State: AOJu0YxzcfaZwVZ7KqC93Gwv5cI7+fSCF8O9c/OeKfaPVtWwef6OGiQp
	iA0SIjHcoKiTzEvnETnl18OdIOTuDD0SxiWmr5UU9GKLtOcsbtlnH9QNY4WEQqNUVCjgDWh/yqY
	UV0pm3qkhDNa3OPYaesg8IIwNFHM=
X-Google-Smtp-Source: AGHT+IGSSrqjEY+dH+x56EFP1UcZy7nuTW1N3gU/lRDHqXoHbKM7mRbCSrK1i3w/wUGpD+Kdk0tn0lJ9sZUR4KsA7Mo=
X-Received: by 2002:a05:6870:b520:b0:23c:8265:8542 with SMTP id
 v32-20020a056870b52000b0023c82658542mr5610423oap.27.1714644217224; Thu, 02
 May 2024 03:03:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 May 2024 03:03:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZjNJ5EPMYxLi1QR0@tanuki>
References: <cover.1714398019.git.ps@pks.im> <cover.1714479928.git.ps@pks.im>
 <95d7547b2e8c5305e76888f7dc0a41d2b9e2f558.1714479928.git.ps@pks.im>
 <CAOLa=ZQY5rdUqcy0yTB0haduf9EK7KVLeoAYLyaST4fMn6UyFw@mail.gmail.com> <ZjNJ5EPMYxLi1QR0@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 May 2024 03:03:36 -0700
Message-ID: <CAOLa=ZTB70QJfX2YSdqRtA+5WaWz9+qRXqw76u36ouZ-vC_qZA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ref-filter: properly distinuish pseudo and root refs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000007bf78d061775b7cf"

--0000000000007bf78d061775b7cf
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Apr 30, 2024 at 06:11:05AM -0700, Karthik Nayak wrote:
>> In the subject: s/distinuish/distinguish
>>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > The ref-filter interfaces currently define root refs as either a
>> > detached HEAD or a pseudo ref. Pseudo refs aren't root refs though, so
>> > let's properly distinguish those ref types.
>> >
>> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> > ---
>> >  builtin/for-each-ref.c |  2 +-
>> >  ref-filter.c           | 16 +++++++++-------
>> >  ref-filter.h           |  4 ++--
>> >  refs.c                 | 18 +-----------------
>> >  refs.h                 | 18 ++++++++++++++++++
>> >  5 files changed, 31 insertions(+), 27 deletions(-)
>> >
>> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> > index 919282e12a..5517a4a1c0 100644
>> > --- a/builtin/for-each-ref.c
>> > +++ b/builtin/for-each-ref.c
>> > @@ -98,7 +98,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>> >  	}
>> >
>> >  	if (include_root_refs)
>> > -		flags |= FILTER_REFS_ROOT_REFS;
>> > +		flags |= FILTER_REFS_ROOT_REFS | FILTER_REFS_DETACHED_HEAD;
>>
>> The only issue I see with this patch is that it makes me think that HEAD
>> is not a root ref anymore. I get that this is the best way to define the
>> directives because otherwise you'd need a new flag something like
>> `FILTER_REFS_ROOT_REFS_WITHOUT_HEAD` and `FILTER_REFS_ROOT_REFS` would
>> be the summation of that and the HEAD flag.
>>
>> Apart from this, the patch looks good.
>
> Well, it is a root ref, but we treat it differently in the ref-filter
> interface because it's rendered differently than any other root ref.
> Furthermore, the ref-filter interfaces allow you to _only_ list the HEAD
> ref, which is another reason why it's singled out.
>
> Renaming this to FILTER_REFS_ROOT_REFS_WITHOUT_HEAD ould be quite
> misleading, too, because we have the following snippet:
>
> @@ -2794,11 +2796,11 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
>         /*
>          * Generally HEAD refs are printed with special description denoting a rebase,
>          * detached state and so forth. This is useful when only printing the HEAD ref
>          * But when it is being printed along with other root refs, it makes sense to
>          * keep the formatting consistent. So we mask the type to act like a root ref.
>          */
>         if (filter->kind & FILTER_REFS_ROOT_REFS && kind == FILTER_REFS_DETACHED_HEAD)
>                 kind = FILTER_REFS_ROOT_REFS;
>         else if (!(kind & filter->kind))
>                 return NULL;
>

Right..

> If we named this FILTER_REFS_ROOT_REFS_WITHOUT_HEAD then the above code
> would be even more surprising.
>
> So yeah, it's a bit weird, but I think it's more sensible to retain the
> code as proposed.

Agreed. Let's keep it as is!

--0000000000007bf78d061775b7cf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1f6b99f51e37f803_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZelpQWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGZZQy80bDRYS2I3Yit4YS9OWG9NMHFYWGZOUlo5bgovbnNFVkJGa2Nl
YXQwbVZ1UlJIN0UvaHZhbVlTTktHc0RtNVltTmJUazFPVWovUFBXWTM0UnhOaDlwRFJ6cHVHCkdz
ZTJ4d2R6SXJSMEI0aXBlZWZreVYxeVRIS3NseEU4VWo2REk3aDl2eDZuQkN4clB3MXI4bFM5MGNJ
Q1VjSUQKOEhrZ25LZ3hWZUptQW5QWmQvbmZGL2MvZDVQcEtrT2g0QWgyNDlnY3pCY0V3Mlg3ckpW
a05VVXA3WDBtWGVLNApKYmNyc0l5WTlkWWlGV3NpWmx6ZjNtd3dDTk0wdUo4bGIya3pvWXpISW00
TkpqRVUwR09rL2JrVjhIRitpNjd4ClJWbGY0Y2NHTlVyemVYN3cxMFNOUWtYaWJsaXlid1l0ekEw
ZXNHZ1dOZXpHNmVHZ2N0NS9CaFdsS0JlS2FpbmYKR2xac1FhQXBqekF2WFhzQlg3bnFhb2NYdU1q
cUoyd09wcVpMYUk2blphVm94QnExQzd0VTBGNGthTURzN1lkagprbW9oMFZkbm0xWnNUVDVmaExx
UUJYbHdySVVVTEczWVV0bjRLUWdTcElsVStyQWZxRTFSSUdscTZvc0xadndqCm1HZjFnR29KZjF0
S2pockR0cStWanlUbDBCMlVSMk1JMnpjRm9zcz0KPVZnUlMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007bf78d061775b7cf--
