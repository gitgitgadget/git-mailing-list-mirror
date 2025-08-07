Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC24C259CB3
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557204; cv=none; b=dKeUQVVa0dMDoT5RjuOhRSM8rbuTV0mL7M+i0D5LPRUMD9AL8V3hA4AucuKTp2pqQ3nK34YyJ+4ZwQ1i4bKvU2CYlkbc67MMH8xZ7WAWvpUmPrz+jAyPCLNApK8e1opz9YR1taGZfUyfeh+fNSUqR03lv7VOS46bLwsJbYm6lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557204; c=relaxed/simple;
	bh=e5OvEUj3128S/jFRbbKtfNA26+9WhC2V9vfeL50To/Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aSeEVX2b4NiEoel51956a+J0NiLufYV/M36dqkxhgqJhZ9y2BoII9UTubT2+2ly5Dv+vaf4D2v91V8nxL1r4HstmXhqppKwgK5FKIxaY6S1sZAIP6q9xxnyA3w6AhIgfJS+SQ6jhEsXzRpEuNVBs6MtbCl9GeI0/q7+At/Ug6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOMPzjgZ; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOMPzjgZ"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b4209a0d426so706143a12.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754557202; x=1755162002; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BMSLUG6kspne3zKP34SHhZSBmoLKV9njpT/D1p4kLk=;
        b=HOMPzjgZ4VHC78CO4WQC7D5DF3CfYxrCpBH7o6NoFYw9774IeN8tYIyGdjG1acbaTl
         GH8h0CvgyukCPB0C87HiUaxY2hEx364JdGEP8aSEkD/AYm9n2KdWp5RGCcHKROycKXa9
         YFcQE2kEyElCESW+3nwgAW2Aa7YEp4Mk2stgkIOia4BAcLiIJEQeABFwp1DkklOk98Be
         1/c6/krw0m6AwQcHQlzkb/HSrmmMrTxGHja5zlilwgM86HL8ib9+okPoxVpWiWhR20OM
         0QrslhsIilA1UgSNRHGQzr2G4rrLpPy6znY9nskeDmWdnUIfs0qn8MDzA/2K7hsvKPA/
         JYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754557202; x=1755162002;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BMSLUG6kspne3zKP34SHhZSBmoLKV9njpT/D1p4kLk=;
        b=cvhibf0u+MaB8piJOOHsl/4qU3u1MGYU2tg+yH6Rl/wk1ao859Mvo8Lxk1Rnd97CNU
         8nigOrAZMAmxeSneK2G70/vfU7PpyMuzTkg7eHyt02P9Nkoa652GW4bK1Uq5ussE3V6T
         mSGhjeLurXb2SjXDNAGiHZ/lfQGqNCMsXYhfV37ANFyDm2Cy5ZZL0CEhFeq0lq9n4B6T
         /nnM8aZvjJM5/Zz8dzL+xmOKrUiXvC0AxZYRTfUCQFl95rt7VOkyndBaJtwqbqI0s0fA
         QcUjb5YkNR8jRU3KSPQrJlW3YV2ppWhYfzBnNp/nK326tapsCvhMJn1Lx+0KCGnnMKDz
         UAOg==
X-Gm-Message-State: AOJu0YwXwDwW28t4QIW7wTV43vsPAH0AUWSVlUsnSegK+jPzg16jRMV0
	Iy7R42DJvwsXLL+qB1ufb/eu5i1Ck5McwE9I8jA9BjVuIiUFcuqfKwJ+JiXDovdl2Do=
X-Gm-Gg: ASbGncs5WvhrhBEu5gLGq08+hosKqa7jf33sdckArxi3vuhncL7ramD9mknAaInMgUq
	fvMcyfgUDnOP/MdtprWlccirhPB/eiQhsW0A2ORgrh7irwNTW6yyxATKyP4ROI3h50kGiAjPJa3
	SRK5lIr6vBMpaN09K5MEFGQVopWVHB0Jzj0hcRLap7Y4XbiaK5X857XVLjvHLBjNjvImBvCwgvE
	MsvqtagMbnDzORUjkkNUH1cd3rd3b5lQzlCTEEEmeFY//uQ5bPaNR1IhfAItggE0jPKwXrJ7qrx
	HdTmKE+p+FWIcob2Y2XiYCliAsj/WGob1IGNWfDp1/TC1xIJAPo6nEclSc4/iK3xBzLF1qiIB8T
	0rx4hoT5WQ3Zd3/rYMvGBH3oxqbk/tRLxZb1jrqjKnvJ7EAGpTDBrCnqEM4E=
X-Google-Smtp-Source: AGHT+IHw7m6r3OA3BPQfFVwU8aU7l37HxcPU6M4oaBK47QI4BzjIYiiljpBW8Lx4/hi1vJsrdyjibA==
X-Received: by 2002:a17:902:c94b:b0:23f:c8db:231f with SMTP id d9443c01a7336-2429f2f5022mr83938265ad.8.1754557201516;
        Thu, 07 Aug 2025 02:00:01 -0700 (PDT)
Received: from smtpclient.apple (n058152109064.netvigator.com. [58.152.109.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976ca5sm179410865ad.100.2025.08.07.01.59.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Aug 2025 02:00:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <aJRMaYfMd3PlRtoz@pks.im>
Date: Thu, 7 Aug 2025 16:59:42 +0800
Cc: git@vger.kernel.org,
 stolee@gmail.com,
 gitster@pobox.com,
 ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B24EAB9-6D52-4D97-A3D8-FF72A12701C7@gmail.com>
References: <20250807051243.96884-1-yldhome2d2@gmail.com>
 <aJRMaYfMd3PlRtoz@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.700.81)

Patrick Steinhardt <ps@pks.im> wrote:
>=20
> On Thu, Aug 07, 2025 at 01:12:43PM +0800, Lidong Yan wrote:
>=20
> In the subject it should be s/enable bloom/enable Bloom.
>=20
>> When traversing commits, a pathspec item can be used to limit the
>> traversal to commits that modify the specified paths. And the
>> commit-graph includes a Bloom filter to exclude commits that =
definitely
>> did not modify a given pathspec item. During commit traversal, the
>> Bloom filter can significantly improve performance. However, it is
>> disabled if the specified pathspec item contains wildcard characters
>> or magic signatures.
>=20
> Let's add a paragraph here, as we now switch into the "what is being
> done mode".
>=20
>> Enable Bloom filter even if a pathspec item contains wildcard
>> characters by filter only the non-wildcard part of the pathspec item.
>=20
> s/by filter/by filtering/
>=20
>> With this optimization, we get some improvements for pathspec with
>> wildcard and magic signature. First, in the Git repository we see =
these
>=20
> "for pathspecs with wildcards or magic signatures".

Will fix all the grammatical errors in next version.


>> Also Enable Bloom filter if magic signature is not "exclude" or
>> "icase".
>=20
> This explains what is done, but not why this is safe to do.

I forgot to mention this =E2=80=94 I=E2=80=99ll make sure to include it =
in the next commit message.=20

>=20
>> diff --git a/revision.c b/revision.c
>> index 18f300d455..ef8c0b6eca 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -671,12 +671,13 @@ static void =
trace2_bloom_filter_statistics_atexit(void)
>>=20
>> static int forbid_bloom_filters(struct pathspec *spec)
>> {
>> - if (spec->has_wildcard)
>> - return 1;
>> - if (spec->magic & ~PATHSPEC_LITERAL)
>> + int forbid_mask =3D
>=20
> The mask should be `unsigned`.
>=20
>> + PATHSPEC_EXCLUDE | PATHSPEC_ICASE;
>=20
> I think instead of a forbid-mask we should use an allow-mask. =
Otherwise
> it can happen quite easily that we add new magic that isn't compatible
> with Bloom filters but forget to update this part here. I'd rather be
> slow but correct than fast but incorrect.

Interesting and reasonable point =E2=80=94 will fix.

>=20
> One thing I did wonder though: what happens if the first component
> contains the wildcard? We cannot really make any use of the Bloom =
filter
> in that case as the path we match against becomes empty. I expect that
> we'll handle this just fine. But is it still more performant than not
> even trying Bloom filters in the first place?

If the first component contains the wildcard, =
convert_pathspec_to_bloom_keyvec()
failed and returns -1, which lead to prepare_to_use_bloom_filter() =
cleanup (free and NULLing)
all bloom filter related field. So the performant would be as same as =
bloom filter is
not even tried.

I actually find a bug in my code and I will add test and fix it, the =
code should be

	if (len !=3D pi->len)
		while (len > 0 && pi->match[len - 1])
			len=E2=80=94;
	if (len > 0 && pi->match[len - 1] =3D=3D =E2=80=98/=E2=80=98)
		len=E2=80=94;

> We typically indent the heredoc text to the same level as the command.

Got it, will fix.

>=20
>> + EOF
>> + test_bloom_filters_used "-- \:\(attr\:text\)A" &&
>> + rm .gitattributes
>=20
> You can use `test_when_finished" instead to clean up after yourself =
even
> in case the test fails.

I see =E2=80=94 I never knew how to deal with the issue where one =
failing test case
causes all subsequent tests to fail.

Thanks,
Lidong

