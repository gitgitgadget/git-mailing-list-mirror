Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279023A6
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791053; cv=none; b=uGL6fMJmZkUTmzVxkpoT/v0F1zHVUkiwO04l1uDynWKCnvFqhgsczvhH5oIMUgfDlhn0uemIzHEf2BtF9fXfuDnWnO7XncAnRNHHXOJmVev2GefN8ejARahU3whW+zdfmvBgVsjn3xcFMkEcq2LFYyA8ij2mpPD1aqIhfMwmgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791053; c=relaxed/simple;
	bh=Y+bojvseISA7ryM8g4sqXz2Jz4NYpDDSZIgDf1MRXfI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KAbr5gBvrCwdFi8WklfurHch84U6NdVVLpSickuIKgcm9JTpBAMjgzP0DqSFI+y/fYempiFn1ZzvAgGl7W40eMBbJiZVybS82ejAO4Q5CKRbGV6ILf8u7ulOH1uxlK+1MagzrAduLjD0LjpJD3/+2AsQeygq/wKp+gVsjhyPoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgTGqt0m; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgTGqt0m"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b46d905cb67so42473a12.1
        for <git@vger.kernel.org>; Sat, 09 Aug 2025 18:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754791052; x=1755395852; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYB9rbnnPYJBqCOKgfbYe8oQ/5IzXgip0bt/VTZqhcE=;
        b=XgTGqt0mSfdD+I0L3mXg24GNPRZDL5u74lavwhi43R1MVWo1XVJE/SUYozdpwwSNTr
         fhJzm60M9JQ+nscbWFK/XaoKcD0wsrqHq9PDbuuxSa1igsZCaaSItjGqtUQaSdONWssb
         CP9oS6wBMZVv46oRRM0u0Dee7Awu6bjl7q1aXxX/lCQDER3/mC960pnG6RdOzLA1i6Q8
         yvPYZ7zEV6QUSScLalqmltholVk3/W+Wcon4Gk3KNWOQBZgOYM8HjzIN1QqKaBsxK1zq
         b7NdqJGcf2OSVYqhiF44Pne93stgJZqVxy9ysSkudKyGg9DzPq8Yai4UObHU9+MM1aD9
         GhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754791052; x=1755395852;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYB9rbnnPYJBqCOKgfbYe8oQ/5IzXgip0bt/VTZqhcE=;
        b=am4NU+7wKpWAQsai9ZDRh0CM82Qz/uCC/yqSVYctRVI7XLmuTvQzZy24HFexj5knaa
         n17d6GFqYCPFDqd/VjKlZS+Tv48X8r+28x9dcQWJ95dtJvxYk7sV+1iusEMUQr2YXrlc
         S0EfWyB1QpVtPYyRFCoj3uSu+l0FiQeK2NH4Wqx/mxTDH86uAgwGu4nszSSO0sY9UDmL
         a2cPGu7dXDF5DkdrOAKE12q+Efajhnz3lJjmU9XhAozNjuGh+2W4dWHPflS66HfWDpxg
         E6qanDjhVFfVUw0a8lkKwjjFv503O39Nx1gd+HnlRjCDAEeDie/w3VbCRYdgyFrNtzC9
         ZSUA==
X-Gm-Message-State: AOJu0YzYfSf0+wL+rrKVeOKuw1spt2NpjwmZSaKCXNhO4PtarK7S8Fou
	jdld+baznYJxmV0s0H877PIZP2Ldk7nuj3kDxamJwuWQDJ4+Uhskon+cZhF4lhe4MFMKcA==
X-Gm-Gg: ASbGncvar9qzduX8u+nYdW6RK0BRNv4xO8qocGqkNi7C7ZyqXPwwi655KfKLHvHoG4C
	5R4LeKX0QI1EsJIK8BCyFx4X538XsNtbVquek9PpwJr5tcSYgfYVVokJ8xDIYcGPkKUf80t4Rob
	LEI2gPoFbjF13/Y+mYBOvWY1ziX6H32GVTXyROhb0CFfkOO38PJbRxkq13rgzLuGEurE6HG/0j4
	Jzr2B1HWMjdmm0wVT2WdINZ6Hm9rhwHRxl1HAYiNLOJNbXQZfkEBBI9+tIr4W1adGAXuR+/sjkJ
	WFVr+GOa0NLYO15LvRLxt/I8G36Kh53kcrkCcBGXCsLzYdSWDNr/V3m1yPenKYsxGfF6w2NUR7k
	mWV87hK480r0o25xNO3uZBYKM4ZRZrm3GTNdL5T5sCQ8gR+bJGKSTJoY/zg==
X-Google-Smtp-Source: AGHT+IF77oZ/2qPvAsWBZU2X8L+0TsKdH4V6+dMXm5axyxpM7pu1U2ItH7tzi44s2gzQ/H9fhQPmaw==
X-Received: by 2002:a17:90b:4d8a:b0:31f:252:e765 with SMTP id 98e67ed59e1d1-3218439cfacmr11649566a91.6.1754791051468;
        Sat, 09 Aug 2025 18:57:31 -0700 (PDT)
Received: from smtpclient.apple (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da5719sm28174649a91.6.2025.08.09.18.57.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2025 18:57:31 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqpld45a0h.fsf@gitster.g>
Date: Sun, 10 Aug 2025 09:57:15 +0800
Cc: git@vger.kernel.org,
 stolee@gmail.com,
 ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C87ACC0-DFC0-4941-9611-1325911A92BE@gmail.com>
References: <xmqqsei1izhs.fsf@gitster.g>
 <20250809021642.22195-1-yldhome2d2@gmail.com> <xmqqpld45a0h.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> [jc: avoid allocating zero length path in
>> convert_pathspec_to_bloom_keyvec()]
>=20
> This is different from what I did, though.

Sorry, I don=E2=80=99t fully understand what you mean =E2=80=94 should I =
remove
this line or rewrite it?

>=20
>> @@ -693,19 +698,31 @@ static int =
convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
>> size_t len;
>> int res =3D 0;
>>=20
>> + len =3D pi->nowildcard_len;
>> + if (len !=3D pi->len) {
>> + /*
>> + * for path like "dir/file*", nowildcard part would be
>> + * "dir/file", but only "dir" should be used for the
>> + * bloom filter
>> + */
>=20
> A missing full-stop.

Will fix.

>=20
>> + while (len > 0 && pi->match[len - 1] !=3D '/')
>> + len--;
>> + }
>> /* remove single trailing slash from path, if needed */
>> - if (pi->len > 0 && pi->match[pi->len - 1] =3D=3D '/') {
>> - path_alloc =3D xmemdupz(pi->match, pi->len - 1);
>> - path =3D path_alloc;
>> - } else
>> - path =3D pi->match;
>> + if (len > 0 && pi->match[len - 1] =3D=3D '/')
>> + len--;
>>=20
>> - len =3D strlen(path);
>> if (!len) {
>> res =3D -1;
>> goto cleanup;
>> }
>>=20
>> + if (len !=3D pi->len) {
>> + path_alloc =3D xmemdupz(pi->match, len);
>> + path =3D path_alloc;
>> + } else
>> + path =3D pi->match;
>> +
>> *out =3D bloom_keyvec_new(path, len, settings);
>>=20
>> cleanup:
>=20
> Two comments.
>=20
> * For a function that finds an error condition in the middle and
>   jumps to the "cleanup:" label at the end, it is more future-proof
>   to start pessimistic (i.e. initialize 'res' to error(-1)) and
>   flip 'res' to success(0) at the very end when everything went
>   well.  It would simplify the change necessary when we need to add
>   _more_ early error return code paths to the function in the
>   future.
>=20
>   But this flip from "assume success" to "assume failure" is
>   something that should be not be done as part of this patch;
>   perhaps doing it a separate preliminary clean-up patch is a
>   better way to do so.

Ah, I=E2=80=99ve always thought that `ret =3D -1; goto cleanup;` was a =
kind of the
everybody-should-use pattern. So when I saw you write `int ret =3D -1;` =
first,
I was a bit puzzled. Now I understand what you mean, and I=E2=80=99ll =
add a
cleanup patch.

>=20
> * I think the change from v3 (this one) to v4 makes the function
>   worse; we found that it is a good practice to have a single place
>   to release any resources we temporarily acquired and arrange
>   exception handling code to just jump there during the course of
>   this project.
>=20
>   The current implementation may happen to have only one such early
>   return (i.e. "len has become 0; we realize that we cannot use the
>   Bloom filter"), but adding a new early return in the future would
>   be easier if you kept the original arrangement.  The new early
>   return condition may have to be computed after we have acquired
>   resources we need to release, so it may need more than a simple
>   "return -1=E2=80=9D.

Understand. I was thinking about less code is better. I will add the =
cleanup
part back.

Thanks,
Lidong=
