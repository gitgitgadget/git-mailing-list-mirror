Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C242C2FB
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 02:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754705182; cv=none; b=kupF10dDN1DtfQEAqqtr8bKbwzOQ72Ym5XE08Fg/JJQRB3dJMqHBbDvdhghatvks6e+wdZOncw8opdDgU9C9y6wwUzyY9sK4MPqVXLFe8oe3fhmGc/02EU6NE88FiJ9PJXi+Z20uY6rXwXDyYdB9ipnNolRPVHgQUXKJj9zlAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754705182; c=relaxed/simple;
	bh=CdhlrtK2u1UzkKXgYJ5OG6o4/6HfmTDTkQ8owZmbGVA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HrXWR+kHsCD9KL/1PB1gltxwD1UFnTmMT6+07gLIwSIoKIca1KCJCymecRJeSAqXecv+klUsYZkWZ764BFk66jGfNLxUwV+TavK0SZEiJGZJDMF3ptGlcN9USSgwYWOPyTRef1s0BNP8C3mACe9keb7ELKTNBhkojq7402NW2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZFOl1e0; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZFOl1e0"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76bfd457607so2978230b3a.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 19:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754705180; x=1755309980; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdhlrtK2u1UzkKXgYJ5OG6o4/6HfmTDTkQ8owZmbGVA=;
        b=aZFOl1e0D1Rr5/lUtdididWUCiZrWggdsYJlTJizQWy19VuVhzLJ3cfqCZwFtasl/l
         xb8ox5mBt50F9IMRMThZmsxCI8uzYBxHlvSGJsCJO1/VJnN9Ctu0k9whBtAmIY5qzRyc
         /gxwZgw3x6CuthdC4Y//LAw9dEXLOMgb/dg/l5NSOAXIqGqbIszOnSYKJOWQEX6Yod2k
         HSMfDlFgSHTRFdUtRS97xx03dew3yiNT4joV20W+Xx2DJMuIRYRt8A2znu7K0jKEQ8fG
         l0X2/iXE/42GZS+ADVcM62Y+bXhshm0iCGL44cSIDDtBpl56B1Wcpq068QpuCxZ/rhR/
         ST5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754705180; x=1755309980;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdhlrtK2u1UzkKXgYJ5OG6o4/6HfmTDTkQ8owZmbGVA=;
        b=JScbE5y06MmRVQPIbxT+g/N1DlZU7aQs3Itjq3C7qVf4ngURYBrS5fj60DsSJ41MVn
         l+5j8oQi4I/y141UUCdAzU0EG1lzBbtOAFsYlpObMrAiTI9hTGPVZ5bjykg5pJDxdvfq
         HoIGej/b9xY6DAlRdiWPzZD7xTmjdfgcYDpMIi+uA8UJ8Dj7BVgoKcHmgG4Ag8Zq3pmi
         jwMJW37f9tvJYMtWpZAJVIuBembp1yech/VUYT9ti5Euetxq+L8QhgrFYtPtBXUxkmHm
         NBYYQah4/rRPrlvvZAMdWpIJKGDJcJGVDMDVnPc8NP7wPgCgxUau0IHwz9lPGqG8oQR9
         lsjQ==
X-Gm-Message-State: AOJu0Yywp40KgPEtPhabBwT/sKopQFr/nDHZYyWZrs81e8Kcvm8uxzhq
	44hjtXnMj03agJbE5Km5QMDqUrbj5o0OqXaa5OqNOc/Hi2PZVFg1Ltok
X-Gm-Gg: ASbGnctADeN06eBEiGAJNAXRHDpdAvh2C4M4rnB+brToOmwduXwuKXV8q0DxMsTGQyp
	oq7kaUCVs1EcwkuVKNbYZoTX8GlA/ZhFghyHQBo22Gp3SDKQYXObJaAI5RNCZiaUPZpa8AcaK+H
	PuvgChML0yKgiSNWus4JaaaWqSWt287g8dWy0DeLxTrl8/tPE/rR1nGWdajLzQeVkTZqib8j5mE
	o4p+67maT7bgNDG7tjNArgnscBhQYccLPGQgoZzB39FIkt8UrJvXvzfN6aaxE7uPmpUoFT5m3HC
	qSqflIzZcDrPpq5+W1WW9uXrZ7FHPboVjk5dlpflvwMAZ+XBILtMRGUvREJ9glO0WdXWX6Hf2oh
	UbZsA2VxvEGyeMUwQMXcKYpw4INQ+h53bQXj6Rk3+iXg+dt2TTAA9WcDN1xEZokLV7/iFng==
X-Google-Smtp-Source: AGHT+IEzuj21IXw+gBl4uQPv7XVhkPhvCbDE+qLyXMJtCVxMR6yawtTsQLJ/dXgpSB0eWQHx1r9RYw==
X-Received: by 2002:a05:6300:210f:b0:23d:9fd5:9231 with SMTP id adf61e73a8af0-240551fa3f3mr9747135637.46.1754705180246;
        Fri, 08 Aug 2025 19:06:20 -0700 (PDT)
Received: from smtpclient.apple (n058152109064.netvigator.com. [58.152.109.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd1d8csm21446279b3a.101.2025.08.08.19.06.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2025 19:06:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqsei1izhs.fsf@gitster.g>
Date: Sat, 9 Aug 2025 10:06:06 +0800
Cc: git@vger.kernel.org,
 stolee@gmail.com,
 ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2F0FE14-AA88-490D-989C-3D93BF972DCF@gmail.com>
References: <20250807051243.96884-1-yldhome2d2@gmail.com>
 <20250808065834.22743-1-yldhome2d2@gmail.com> <xmqqsei1izhs.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
>> @@ -693,9 +698,22 @@ static int =
convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
>> size_t len;
>> int res =3D 0;
>>=20
>> + len =3D pi->nowildcard_len;
>> + if (len !=3D pi->len) {
>> + /*
>> + * for path like "/dir/file*", nowildcard part would be
>> + * "/dir/file", but only "/dir" should be used for the
>=20
> Leading "/" makes it look as if the pathspec element can begin with
> a slash, but it can not, can it?

Yes, seems like if we pass a absolute path =
"/path/to/repository/dir/file=E2=80=9D, git
will automatically move "/path/to/repository=E2=80=9D (in setup.c =
abspath_part_inside_repo())
So I should remove leading slash in my comment.

> Taking what I suggested above, here is a possible improvement.
>=20
> revision.c | 18 ++++++++----------
> 1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git i/revision.c w/revision.c
> index 2a5b98390e..2a92bdda84 100644
> --- i/revision.c
> +++ w/revision.c
> @@ -696,14 +696,14 @@ static int =
convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
> char *path_alloc =3D NULL;
> const char *path;
> size_t len;
> - int res =3D 0;
> + int res =3D -1; /* be pessimistic */
>=20
> len =3D pi->nowildcard_len;
> if (len !=3D pi->len) {
> /*
> - * for path like "/dir/file*", nowildcard part would be
> - * "/dir/file", but only "/dir" should be used for the
> - * bloom filter
> + * for path like "dir/file*", nowildcard part would be
> + * "dir/file", but only "dir" should be used for the
> + * bloom filter.
> */
> while (len > 0 && pi->match[len - 1] !=3D '/')
> len--;
> @@ -712,19 +712,17 @@ static int =
convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
> if (len > 0 && pi->match[len - 1] =3D=3D '/')
> len--;
>=20
> + if (!len)
> + goto cleanup;
> +
> if (len !=3D pi->len) {
> path_alloc =3D xmemdupz(pi->match, len);
> path =3D path_alloc;
> } else
> path =3D pi->match;
>=20
> - len =3D strlen(path);
> - if (!len) {
> - res =3D -1;
> - goto cleanup;
> - }
> -
> *out =3D bloom_keyvec_new(path, len, settings);
> + res =3D 0;
>=20
> cleanup:
> free(path_alloc);

Thanks, I will apply this and add your signed-off.
Lidong=
