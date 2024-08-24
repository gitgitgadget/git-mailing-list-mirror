Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531F80B
	for <git@vger.kernel.org>; Sat, 24 Aug 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724518834; cv=none; b=ioqk2RgEtzBElEj5ofq3EI1YTea3g+cIz+Q9lcQWEKS0AWufKMZV4hYDoRhbZIbrjWb8vDXQwNQP0ulPed1JYmGjCQLyRmQ8HtllYlC0bjR/GVF0bpxev0TFMywu9EZ7/bnXvH1TwhHuIPX5lCvwMlurA5BV5OQXnD3eHO1+cc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724518834; c=relaxed/simple;
	bh=lPTFyB2/8HFRp12vBuZwqQXkydhNmT76UCasGGpBEHA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ksp5vpD5DEzJR1E+kxikSsAeN7KRfjsqHcmgkejHnnWu+5QUrFCqFU+3W9nDfcaiWce0FKwZXVQZK7S6ZrHc18uOvSqdUycmjYEStWZtXrlD+ILtpev4XEr9xLpPgE5zJO9qSK6IuHs0CERxcb14sJnbO4eRj1CDhl5aPYHxpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4Enxfbr; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4Enxfbr"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d5f9d68805so2154479eaf.3
        for <git@vger.kernel.org>; Sat, 24 Aug 2024 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724518832; x=1725123632; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3N53SgnZpIu5+1DIgBerhg5+AlNLclvQmUWiiaDWoY=;
        b=k4Enxfbrr32S+HbpCDvLE2X5VgSZz7kl50Thc6bLQorI6yyfOHnXUEg+0+FRE1gdVZ
         AgpSlXFSlNhY910y6tIftNeD7rJ1F1jljWY01Ohv3eW4JqhF8OxUlcjtA+X2aVe+u1o8
         EuTSMeeL0uRZZduAw1d3JzAOrecKyMqUvn0b4JuYKEVPn52D1634XhQAnRzxYpXcUC9V
         rGIN7n16SUTYdGBA2OjBlR25qncRafjsy+cLiJU329VPFnF7t8YnpBb7+k7xx1juibw+
         lmb6pGA+FhmHDukZyl1lYn+9IrXMYDq94EvOwdYx6piKRjzI8Ive8bNon0VkJGtcYJ+4
         FYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724518832; x=1725123632;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L3N53SgnZpIu5+1DIgBerhg5+AlNLclvQmUWiiaDWoY=;
        b=cwkpoguRDL4bOgGs1Csn6VuTemte+T3zn62FWSgsuAfm/yp5aDeU4OKHen0KLSwnq6
         KZYVYsKljptcKHh+/Bpt21eBqMPVHY1YxG5QAyDP0sDQT7GAASEVixmwMKeyWAvpSyGH
         hGbeQZBur1SYTfnCISFk2wV++eZcdTszu0veSMixg4AcM8scfZXDN5QUdhBoIBcf9FG/
         srlDvkJWdNMqmAjtodDRnhpZr3BoIhyxSz65MEjjB5DUWr+GePqiyVpizUHfIZSo9m/W
         n1hg9Tdg0aCK3HyfKmbaVhMg1c+lPljjQS4RkZ3WuCCdY7i17z1fqkqrXjqoKBaOgvd/
         10WA==
X-Gm-Message-State: AOJu0Yy1GF/7RIo8Yh023uxbUC+O0/4BZK7ZIbKqjUmYLzYHXYI/Gucq
	oHLYJpcl0pHDkRGiO7UNFcVp7sskJXPoQkhw9qtyDSxesVZfvyQEGFUrTDLe7FdE6w==
X-Google-Smtp-Source: AGHT+IGi8ydWd/T38h36sxUa850uTamQnqAjA2PXxtmlvij+lQbs86Y0qbVnlPKd6sbPY+RxiA7YbA==
X-Received: by 2002:a05:6808:1524:b0:3db:ae5:9bf3 with SMTP id 5614622812f47-3de2a882c2amr6280553b6e.15.1724518831693;
        Sat, 24 Aug 2024 10:00:31 -0700 (PDT)
Received: from localhost ([106.222.205.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac99502sm4982241a12.14.2024.08.24.10.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 10:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Aug 2024 22:30:25 +0530
Message-Id: <D3OAWJKG9PX9.6MOABOQ77MOB@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: port helper/test-oid-array.c to
 unit-tests/t-oid-array.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Christian Couder" <christian.couder@gmail.com>
Cc: <git@vger.kernel.org>, "Christian Couder" <chriscool@tuxfamily.org>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Phillip Wood"
 <phillip.wood123@gmail.com>
References: <20240703034638.8019-2-shyamthakkar001@gmail.com>
 <20240803132206.72166-1-shyamthakkar001@gmail.com>
 <CAP8UFD3E2idN6mUYzEyh11Fzmj07q+BQuyVCtUkPP=cuxsUODw@mail.gmail.com>
In-Reply-To: <CAP8UFD3E2idN6mUYzEyh11Fzmj07q+BQuyVCtUkPP=cuxsUODw@mail.gmail.com>

Christian Couder <christian.couder@gmail.com> wrote:
> On Sat, Aug 3, 2024 at 3:22 PM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
> > Migrate them to the unit testing framework for better runtime
> > performance and efficiency. Also 'the_hash_algo' is used internally in
>
> It doesn't seem to me that a variable called 'the_hash_algo' is used
> internally in oid_array_lookup() anymore.

It is. oid_array_lookup() uses oid_pos():hash-lookup.c, which uses
'the_hash_algo'.

> > +static void t_enumeration(const char **input_args, size_t input_sz,
> > +                         const char **result, size_t result_sz)
> > +{
> > +       struct oid_array input =3D OID_ARRAY_INIT, expect =3D OID_ARRAY=
_INIT,
> > +                        actual =3D OID_ARRAY_INIT;
> > +       size_t i;
> > +
> > +       if (fill_array(&input, input_args, input_sz))
> > +               return;
> > +       if (fill_array(&expect, result, result_sz))
> > +               return;
>
> It would have been nice if the arguments were called 'expect_args' and
> 'expect_sz' in the same way as for 'input'. Is there a reason why we
> couldn't just use 'expect' (or maybe 'expected') everywhere instead of
> 'result'?

I have changed them to 'expect' in v3.

> Also after the above 'input.nr' is equal to 'input_sz' and 'expect.nr'
> is equal to 'result_sz' otherwise we would have already returned fron
> the current function.
>
> > +       oid_array_for_each_unique(&input, add_to_oid_array, &actual);
> > +       check_uint(actual.nr, =3D=3D, expect.nr);
>
> I think it might be better to return if this check fails. Otherwise it
> means that we likely messed something up in the 'input_args' or
> 'result' arguments we passed to the function, and then...
>
> > +       for (i =3D 0; i < test_min(actual.nr, expect.nr); i++) {
> > +               if (!check(oideq(&actual.oid[i], &expect.oid[i])))
>
> ...we might not compare here the input oid with the corresponding
> result oid we intended to compare it to. This might result in a lot of
> not very relevant output.
>
> Returning if check_uint(actual.nr, =3D=3D, expect.nr) fails would avoid
> such output and also enable us to just use 'actual.nr' instead of
> 'test_min(actual.nr, expect.nr)' in the 'for' loop above.

Changed this in v3.

>
> > +                       test_msg("expected: %s\n       got: %s\n     in=
dex: %" PRIuMAX,
> > +                                oid_to_hex(&expect.oid[i]), oid_to_hex=
(&actual.oid[i]),
> > +                                (uintmax_t)i);
> > +       }
> > +       check_uint(i, =3D=3D, result_sz);
>
> As we saw above that 'expect.nr' is equal to 'result_sz', this check
> can fail only if 'actual.nr' is different from 'expect.nr' which we
> already checked above. So I think this check is redundant and we might
> want to get rid of it.

Removed in v3.

>
> In fill_array() above, we use check_int() to check the result of
> get_oid_arbitrary_hex() like this:
>
> if (!check_int(get_oid_arbitrary_hex(hexes[i], &oid), =3D=3D, 0))
>
> It doesn't look consistent to not use check_int() to check the result
> of get_oid_arbitrary_hex() here. Or is there a specific reason to do
> it in one place but not in another?

Not in particular. Added check_int() in v3.

Thanks for the review.
