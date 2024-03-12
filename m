Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B841428E4
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275973; cv=none; b=L4oVdGrjVzHQwL1nk+Xu/b5QSbsBCYtuuRADKHz+ncEiy5/DOn52fOMJdjb8Es8bTeoXxExSXz+BJ+M5whizaSrTDpFWoZ0lvnCCjdMouZ1a6Ux58CcI8vS6FrCZ25X6bc4kmUwlqAB8aaUTKV6Aqlt+Ta7hF3c2wfpB7wnnDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275973; c=relaxed/simple;
	bh=GVuy8Fc+AakjQvAlU7dyvr5L22HSGSz1j8tqmvuBmjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYKghDbbGf5tbJXch0FkIKd9QgD/l/EGyfWyfmumzPNkxd79MYi5Gej+sZR2sGkfnY6LJOoAG4mHqFQ3Cvtnn1JhKDRO0WDDpueTzFYWF7am7R1tV/+ecE4sp6dLrpqPga4Z6iG69mp5dExGVA8PN0pBiPH/yUFTBUPT3hhPQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4Ckj/D2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4Ckj/D2"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56838e00367so432781a12.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710275970; x=1710880770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6a2fcz4Ufe9DqVqFC9ksiNoc73ezB4/d3HYkh10rL3E=;
        b=B4Ckj/D2iyRQ275lpPe8VLDJN6+xV+5UVewbskUVkbkwmtmgu4QQdl98XfwkVwC/sO
         7Y+QSrktgfGEohqjQILk4eriaP0PgMmTu57PxtPVIZxn8vjXw5DBukR/9V0FPziIza1O
         7pJH6tOhSEWr4F/qshQoe0UfCxgbgsN57JV6SnxfJZARzQB8Dt4q+rHkx2UdNzRsWFCT
         DN4Jkqh7tabiaIS3yd7teM5WC08pKucxBngEt00jt4iiNo+JHQSpTYZ1E0Ow9zf1iyEd
         rYrE+g8Phi+3aMJgs7OouiOQtXVVEayFi2ZD4Sih2Sw2uw5YkCGG6Xe/lSSyq5VyJxRm
         AqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710275970; x=1710880770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a2fcz4Ufe9DqVqFC9ksiNoc73ezB4/d3HYkh10rL3E=;
        b=pFTTv6nFjLAiUryNtyWz6O0obFkAJbNe0nrPIqE2Lh2LdE98K06XwE49y1ZGj/U9da
         v2DA9txnJSvk1Gvj9TxY6qMhiKAb1p/YoQ3SNJLcsWogCd4IUgwQeQ9VVuCZs7s9GsGa
         /qQ0gPpKt2+DrzLWgPKSYRX1BZrrIvcEAX8YvJ0mjnameJFP9ZOiUnNdQq2sRip1gUWw
         0MOQ7C4RRdofxizzgeQKqkRhFvmFIzJvl8GmnlZZUPJy3/CzsFSCCjRwH++5ouOULEe+
         hmp/NZ8qWX5xiyt3xNcm18U4gbOy82QQDXxkenhxei+oJ/vYjcy5VVrjrYn+VcRFvrcE
         DxIA==
X-Gm-Message-State: AOJu0YyM7CGV+2oI3hzIZU89jHeNUbGNmt9zp0cc1tfb4I1zLRlDrMij
	sVh7xoymx7ah1TtSApbI0tmDaMm409S0zKrLUo5CL2rSO9VYL/jAheVguW372oPdzIM/cCdoe0v
	+zTaZxLVJELLNfBHBOvJ/hcoAdPuf/N4NRzdg
X-Google-Smtp-Source: AGHT+IHHtgL290HcV2lcHzo7MTmIrg6Err76qM1cwcEz09XHuN1v8J7+GhGKBxEobyPJk1duycOPIvBkWKS2dwM0s1Q=
X-Received: by 2002:a17:907:a642:b0:a46:4d76:106b with SMTP id
 vu2-20020a170907a64200b00a464d76106bmr1081026ejc.34.1710275969882; Tue, 12
 Mar 2024 13:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305012112.1598053-2-atneya@google.com> <20240305012112.1598053-3-atneya@google.com>
 <CAPig+cQvyScjiWe1ghFrv9B=v2+JxkkErdCyYFSA_8dTrWu60g@mail.gmail.com>
In-Reply-To: <CAPig+cQvyScjiWe1ghFrv9B=v2+JxkkErdCyYFSA_8dTrWu60g@mail.gmail.com>
From: Atneya Nair <atneya@google.com>
Date: Tue, 12 Mar 2024 13:38:52 -0700
Message-ID: <CA+D9mTEJFh3t_OrrNFD=EZHQO_EXa0__r5=_mqOqNfyh_uoq_w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Make read_gitfile and resolve_gitfile thread safe
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jeffhost@microsoft.com, 
	me@ttaylorr.com, nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:29=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:

> Style: Declare `resolved_gitdir_buf` along with `ret` and `gitdir`,
> then have a blank line before the actual code.

Thanks for the detailed style feedback.

>
> >         } else if (err =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
> > -               if (!(backlink =3D infer_backlink(realdotgit.buf))) {
> > +               if (!(backlink.buf =3D infer_backlink(realdotgit.buf)))=
 {
>
> Don't do this. Never modify the internal state of strbuf directly;
> consider the state read-only. Modifications should only be made via
> the API. You'll need to rewrite this code a bit to make it work
> correctly with the changes proposed by this patch.

Good catch, I should've paid more attention in the refactoring.

Fixed all of the discussed notes in v2.
