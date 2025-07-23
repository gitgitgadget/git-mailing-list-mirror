Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51926D4CD
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307865; cv=none; b=hWR99PSOMF/d0FZr4Po0Rb8GLl3ua03pE2OGFoBn3u2dy/jQvl33tLZoG6jGfhSbrpaz1HVjxF/Ds3ocq+gWTX55ySsNk2BXo1/rlwbhMP34hJiTN8s/6rFauvFzqhHyYbCPguLU/T38hVzO57xlW72Ic2qoJpoPHjjnWRYyG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307865; c=relaxed/simple;
	bh=hI7Vilt35bv/QPUnkUVKMsru2UOyPfamNnKH6/9sAYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehGtcvMt/wnv+vxwfL0/uEBeViFA/p0gQlQXUDVca/2asnnOJvJj3Q9gxe7sekBNt6JOCk9IEiS0T57IKsAX3xPklST1uOW8kpwSTQ4s+1CEKn1JOFyVj7tl2vr0LmUHw/PQOEJGVlGFNu3R63PfuB5+q9VEaWAclc9Mag0sh2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHwfRxkk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHwfRxkk"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab6416496dso5549801cf.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753307862; x=1753912662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elh9s+o4+VWHCaYYXGOwo1Ja01QwMehEYHjNqlOLxYk=;
        b=fHwfRxkk33gbmjjY+JhKQg48O7ITOv3F1OKEaBypM9dqZX8Ph2M8DGtknRlb6sQt1A
         yHc7M3hS89BYCKQJfRq8/gqJ8GWbDb7kv7pqIsHBBmhAMHq5Cka4QgPNI0U3FPZaC+pm
         jLhc1kkWNYgLveVyUUSAFFkJb7GlJzbM2yTJLgsThJ4E0DiLENywtRf2dGbbQPO2YiP9
         IRwJajxnv+hmLiPx6fVlXUrWM1L5XdMLfllcxHWMjf2klDTLIyT3mVY5AJaNdOYVsVcm
         q6LSDFs03zF5APDM418u6lzz1zIWjrYy696zZ7d5e+FVLjvBh6AYrGe4qYiNDXhbaZfE
         yRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753307862; x=1753912662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elh9s+o4+VWHCaYYXGOwo1Ja01QwMehEYHjNqlOLxYk=;
        b=VnsgTWujPq7wSywM5scp2MhBuJQ0JBDWiOpJrAX/6/Dtr9Po6c0YFgAEuAqVaOWDQg
         SWRmFuqkHHBbDgTyMh82S6nHGgmii4mQB478oHhztW91fWRpdugJni0kV2xyDACxtwtC
         7eSVcBlXJMjVwJkD/cvhlAD2yKV22SBSbf7i2ICN62c7z9smagcLUAf1ugt4EKErVXUx
         wc9A7aTHvAVccc1ziPZNLXbHzP187AWOuTEnbnZU62r74DiYR5fEkpSX0NSRkk/PBk7F
         TCZa1obigs9d5wwnbav/Bd9Jp9pDXgM34ucg0GcyiWmsC76tjmmZGEgP4PAcpKf5DzVN
         vGwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs3DMOTEs+BpDp5HKD6zKDeJPjLZ1XN2Vb5aLvPdMqK9wQ2xlN11bBDYmfDsLAc74Ue5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZ1pv9NPZmgb80XkxqngKt+QsRKXby7PzlAt/qYd5MyOeoq3p
	GOlZlBCN1DxZTkDUrAwzrW1ZL7rEHXBvUiKlLNw4ovMFz7d/PqgiQ/X4Eou/z78ljUg7SLjYKNU
	2bBoz5kHj5Yaa7AyWReJfHEflHDXqgbNvRI/ydeMQ
X-Gm-Gg: ASbGnctFo912OM6MiKAK0BEzD6lbcmWc2IyVlWXT70SXUW7bMWgMMKRQsEyAa9JV5jR
	jbCvgxw02fOMxoqqnMKx62oBNo7jpuNTvAEzlLLUeFH9s3zSJj5LzYFGbs/VwoLEgdXTJTaGcKW
	CDZhYbC6C/j60LSrI/F8sexCOGX+BTNPWi2Ao8oHkOQlpsTvZ01WXEFDKoxJv+c0xZhaijyeNrX
	FSU6jkrCWRIsWIinF0p5wykCd4BANL82V4skA==
X-Google-Smtp-Source: AGHT+IFOMe7gXqwQ120DD3yfCG0LxgyDsUqI8l2jfNPA+H49z6Z3aJRSFweZi0S4XOvEdNdllNfIbLu1fotyaEO9uE4=
X-Received: by 2002:a05:622a:8c:b0:4a6:f492:674f with SMTP id
 d75a77b69052e-4ae6df70adcmr64958831cf.41.1753307862333; Wed, 23 Jul 2025
 14:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com> <xmqqldoelgnd.fsf_-_@gitster.g>
In-Reply-To: <xmqqldoelgnd.fsf_-_@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 23 Jul 2025 14:57:29 -0700
X-Gm-Features: Ac12FXwIex6T_Wn9cV0paTPj5jQmkilXOv8LOMR6mR8wNOq0DIr1XThRBi65Vvw
Message-ID: <CAO_smVjUyOit66LaseHd=0dt6KgnTrCHbrO+oWU1L5Wd1z8Y7A@mail.gmail.com>
Subject: Re: [PATCH] ref-iterator-seek: correctly initialize the prefix_state
 for a new level
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	schwab@linux-m68k.org, phillip.wood123@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 2:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> When cache_ref_iterator_seek() "jumps" to a middle of the sorted ref
> list, it forgets to set the .prefix_state member of the new
> (i.e. deeper) level it just initialized.  This later causes
> cache_ref_iterator_advance() to look at this uninitialized member
> to base its decision on what to do next.
>
> Kyle Lippincott [*] and Jeff King noticed this with MSAN and
> Valgrind, and Karthik Nayak as the original author located exactly
> where the missing initialization is.
>
> [*] <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=3DMDbnZKvkwN2=3DkN2RRw@mail.gmail.c=
om>
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks good to me, thanks!

> ---
>  refs/ref-cache.c | 1 +
>  1 file changed, 1 insertion(+)
>
>  * I had this as "fixup!" on top of your topic for quite a while and
>    forgot to ask you to send in an official fix.  As Kyle's
>    discovery was after the topic hit 'next' (understandable, as
>    their internal edition of Git is based on 'next'), we need a
>    separate fix on top.
>
>    To prepare for merging down the whole thing to 'master', I wrote
>    the proposed log message to help expedite the process.  Comments?
>
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 1d95b56d40..ceef3a2008 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -527,6 +527,7 @@ static int cache_ref_iterator_seek(struct ref_iterato=
r *ref_iterator,
>                                 level =3D &iter->levels[iter->levels_nr++=
];
>                                 level->dir =3D dir;
>                                 level->index =3D -1;
> +                               level->prefix_state =3D PREFIX_CONTAINS_D=
IR;
>                         } else {
>                                 /* reduce the index so the leaf node is i=
terated over */
>                                 if (cmp <=3D 0 && !slash)
> --
> 2.50.1-521-gf11ee0bd80
>
