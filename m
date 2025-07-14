Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3EE2494D8
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510913; cv=none; b=UCwFhRzZzQivalTXR+aNUGhWhKy0iZyxEOWXMFuTkc7w9aQp9Xi0lkZKnRZEQB0TtldcYbEw0L7e8YwyGuS9D0FblkrDHeE8LdabfFxP9yZdcC/du933ZfS5nUpQViTAHkW+ykKAufCRbayKL3rNn2fsf16IjPN3Be4XsAoZj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510913; c=relaxed/simple;
	bh=CF2/KkKWP6xFfoTG4is1OKbbIk+Z9K80Ypjz8SgR1zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdqWWwELMM9OSspWG0G3m0xBwFKYjYfhOw/bjwn4lOcGKDcG4gg6HdVECE2cITmGhKExRscfbA7v+fv7zCgXirok3/3myVvCk9cMt2D9HI8nG9N5JgC0/svyY19nvK2n9EwnZwG6tFy8ariRbAT78yveaFcyEuM1xhTqJHujoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCCX+r3D; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCCX+r3D"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3b336e936so898944666b.3
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752510911; x=1753115711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqz8LOUGTUk/eeVkLYwjW2SgcBC1N4YzUSZ2SlFyzH0=;
        b=HCCX+r3DYPzgf2M+S7pb5CR5GDL944S8xItwztpYb798dVQek9fwlwNTV2FOkQjIhK
         0gMzcC9ersDyYuCZTRlE2+k5Q3k6TWXTXVUrNC0hdSNR5u3bLnYBJpp3SKnH/cBet0+h
         M6s1eqd97R0Bo18IfIRkSI8wzW+M6MsFxNn2clindAovRjao4wzN6u5j0pad1iMQclRi
         wgCNP/UA9v1ehcIpZGsh8nfIXiPwJqHgXE63pWJS9AaypFtNgpIK/xD2K3HuUs/9BEjw
         karCPTKt9dseoPjtavJFKwbwVogOrRNpM5X+r6yC6+d1mLdUZQcYk8PGgxYSnSuwoL/E
         q5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752510911; x=1753115711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqz8LOUGTUk/eeVkLYwjW2SgcBC1N4YzUSZ2SlFyzH0=;
        b=T3X8xf6ia7knl4/jh3tnfLcWoRcA12Ibk2gtpQE5le5XaUt8OHdmq+K2rDn7mY869Z
         YEYRFKRYE+jXr/8IVgj7NRNC4PHHEX8h7QUAohTfFBbgFAlKad118Lp4m0qJTe+jsslY
         TrMOQWWcdhk3ZL6hErZqUFpD4xoOpye2cdfG/J/tlJP8lN72nImvVDKE6iGLgKol6z24
         5MNoomiEtK+WEFTsCks+miPGyyOqrX5z1gilMoKGEJ1jzX2mCkxZNogmLTa2KtShoyIP
         kfo9NdIlc1YzO862Jr65IsNWjOwYZiNTNFnQgT9z6Vuo9Oz5MC/CnNt/roHpBiEZrMw3
         hD+w==
X-Gm-Message-State: AOJu0YzWa8NtPK2iJPk8Ytc9SAQjKYCgQXkTqPbQf9b618cvF9WJGlaj
	xivavQt//tKDUH8vJ94ehj7ksftZiZjpp7yPqSNJ8N8D4VsXvl3FIDKZ0Uxm9oZCzDw2tj9eVVt
	WOV21QiHhwsYTZycMppUN8/NX2Yy7ZbwBnr7+
X-Gm-Gg: ASbGncuk2gxpVdWZJk9PxBha8NpcpvrHeRZ5nggU2e9Y3/4yKsawlCOE4duOeXRq8x1
	Oy+/gKnNDZOPBc0swMAEwArGseaSPb/yD/A4tzfL4KB7bDJ2bn/NuRUPD/tiiVPCD/cphnjTzdv
	+MofczJgaXgaujnRFTxlmhR/oJDzjHs54eFJi9ViArc5pujDluiXN/UjteQsXxU8l5RFjNeZAJm
	3mmphh/NpUF95WHeMR+3YmYLaBFurdcctNatQ==
X-Google-Smtp-Source: AGHT+IELYguYPQphicNz1g4df+TCYomYoeP1YCIiqxMc9z3LO804JYvM2WtZ1dtp7H5MutaS2I3HKWSw/SwibWDgNjg=
X-Received: by 2002:a17:907:c8a8:b0:ae8:e6f9:7cf with SMTP id
 a640c23a62f3a-ae8e6f909camr942812166b.23.1752510910358; Mon, 14 Jul 2025
 09:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
In-Reply-To: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 14 Jul 2025 18:34:58 +0200
X-Gm-Features: Ac12FXyJ21EjY9ETMFlaArVHm80xPxgre0aOjMuDD80MTFSd04OZCq8LOrVKvgM
Message-ID: <CAP8UFD0anB4dPDf99-w6dyZNNGuOKU-b30_k322D0EsWE0cKPQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] for-each-ref: introduce seeking functionality via '--start-after'
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 6:20=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:

> Initially I was also planning to cleanup all the `refs_for_each...()`
> functions in 'refs.h' by simply using the iterator, but this bloated the
> series. So I've left that for another day.

I wonder if there is a plan to add the '--start-after' option to `git
branch` and `git tag` too?

> Karthik Nayak (4):
>       refs: expose `ref_iterator` via 'refs.h'
>       ref-cache: remove unused function 'find_ref_entry()'
>       refs: selectively set prefix in the seek functions
>       for-each-ref: introduce a '--start-after' option

Except for the few small comments I left on the two last patches and
one below, this looks good to me.

[ ... ]

> Range-diff versus v3:

[ ... ]

>      +  struct cache_ref_iterator *iter =3D
>      +          (struct cache_ref_iterator *)ref_iterator;
>      +
>      +  if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
>     -+          return cache_ref_iterator_set_prefix(iter, seek);
>     -+  } else if (seek && *seek) {
>     ++          return cache_ref_iterator_set_prefix(iter, refname);
>     ++  } else if (refname && *refname) {

Nit: the `else` here could be removed, but yeah it might be better to
do that in a preparatory patch.

>      +          struct cache_ref_iterator_level *level;
>     -+          const char *slash =3D seek;
>     ++          const char *slash =3D refname;
>      +          struct ref_dir *dir;
