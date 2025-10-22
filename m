Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E1274B2E
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167276; cv=none; b=jxouqJ+PpAPSh744l91VEr/55tQxnisbP71i7056SmlNzh3AoD9YNmCfLLriv7+IUN5PM16NXi/gdb4HruA3fA25GtrrpSfJZZWHksPt/NqPU5o/t5wL+fvDMJ1PrE704/yMhsnCREtzoROkN8GD1JQboXlwoWW+ST3FtMMJ3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167276; c=relaxed/simple;
	bh=to6L6lhPB2yIldNnSfRzXB6zL9NYJDZXGExFJ5Zr68w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUf+s9pIg82IJbuOLd+rzFNfibA9MkDVTugutHgJpEEoloXhBxFGepGV7irAvqy+RK8iVi4Y4NkmsSvLXX504b5MKDkUi/3TsDHnzrsxUAk1b9d948STW9cOriyuc53iBUh1DyqGwv7fGZW0kBn+Rny4/vCXwjjJ1/FQ6sC0cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddvbdmkt; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddvbdmkt"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430e182727dso608125ab.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761167274; x=1761772074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to6L6lhPB2yIldNnSfRzXB6zL9NYJDZXGExFJ5Zr68w=;
        b=Ddvbdmkt3LEbqCxhCjJxsHznJths7FStAhnpwUYfoHRbTcgPX44fqzOpcY7IcL4Yh8
         884844ymlNBa4ZHmLCdPSA3/3bVbAdFbodVrC5uTg1/K5N0s511itySdFH3LJNPP634q
         b7vpmqnAK5naKKlMoYRLrhL59NxRq7PzA9+6fhaqYYbtc0kc86KpKfdN5T7hY6k9a9Nr
         1OTVcCwvzQzJEwrxg74VFTGhi/mQptEQqaJw4wrIYgGxEig/C8r9QmjcjrlYejFQMU0y
         C5RZl1RCXQrD9qXASQl4p9x93fgaLgWh79eADzYETu10uljjz4eL8lasXuvIL+M/5Lpd
         U34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167274; x=1761772074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to6L6lhPB2yIldNnSfRzXB6zL9NYJDZXGExFJ5Zr68w=;
        b=Tpx8HNf7FF7aXmo+JMJoEMsbwRpH46CxOuFurOzwtLkjZ5OKBRPrBtU/Bpe4IeOZqH
         onTxP8AnDNNYrAtObgtlCdiPE/QIipPbaEx4iTa/rGkU4+RpfBlY5zsnG7cnvmXIg2/p
         9Su7T9gFDazWdVg2GrOh/tYQh6BVYy1KcuIblRW49I8qkAZDHNKZBGvZqttZ831kpL1m
         A/pEYNDPbbHLv9KDfQs+KEzVMEwU63SxQjgKLJU0UNkgKC1gkUt9f+jLNRayTuL7ibMb
         +6h7/XeKr7+X1k0wdbLiTQgnBPJTqf4PM2wmPdox8LdDgdPuTVDk5gQHK/vlpaVnGZ3X
         q4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUUKhDzMSX4I0loq0r51yjp6fX8XhGHTQXMnOJV8D4jRQ6ix/dyOtn0yYhBauKGDjUxcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqjv4leH+FBiiOwGQheMEIcXOWCu76j1RtEtWvWDVFDlo1Z5i
	NXlp1pwToawWTpd9UyY39g7bjH9/RXuINfV3kf1n/CXhNusJ6N7oL+1l1UdNTQNNXrXxtHO6iST
	h3ACZ4UsllS6SK1vhVoxoxOPcucKgyOc=
X-Gm-Gg: ASbGncseinUqTaZn6CIqxFGM6KSVIupTNzYDXFskgq4Micf9D6n5ct8RVUyXd3PbSOP
	Vy8NUHmincwH4ExcSoEzd7Mfo/Ko2k3vjwCQNuWH95fLB1oYcwV6yenucvbimaXp8U0CYS70uhX
	hvHcEiJ1HDg2Bl5++fO+odRJuLYl2SrmZw4/V8OoTOu9qRQZKdHxAd1OX5yVJ8z+T1XSqI2vuQe
	u/quHXkTHdVphpXzFo0xAjgODeRKb8MWBy8tOnxt9fYhbqFxGhr5qXvMrrbQESspAouRZ8l
X-Google-Smtp-Source: AGHT+IE2ClwP+lwG+nms20yYSbooNFv9+G0lJPiaPzO987CefPW2CZbowuxjVvfhoqcZXJ/YB6v6T1AACMbPW+O9gUQ=
X-Received: by 2002:a05:6e02:3303:b0:431:d8ce:fa1d with SMTP id
 e9e14a558f8ab-431d8cefcc9mr35250545ab.4.1761167273895; Wed, 22 Oct 2025
 14:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <1fa9a7d7d1c309f2f651da351ba7bc0b36272d91.1760563101.git.gitgitgadget@gmail.com>
 <9eafee4d-ea94-4382-ada0-58000d229d2e@gmail.com> <xmqqecqww4u7.fsf@gitster.g>
In-Reply-To: <xmqqecqww4u7.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 22 Oct 2025 15:07:40 -0600
X-Gm-Features: AS18NWDD2Ma1gZC0ziWgMh8J8uX4eTLlvChH0GAQ-nthQXSoKJg7lw_U4k-iJwo
Message-ID: <CAH=ZcbBmdWCBh9zH1Y1JxcnNS-E9AU6Q4rRXPhMOtDBmkxLd8g@mail.gmail.com>
Subject: Re: [PATCH 1/9] xdiff: use ssize_t for dstart/dend, make them last in xdfile_t
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:18=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 15/10/2025 22:18, Ezekiel Newren via GitGitGadget wrote:
> >> From: Ezekiel Newren <ezekielnewren@gmail.com>
> >>
> >> ssize_t is appropriate for dstart and dend because they both describe
> >> positive or negative offsets relative to a pointer.
> >
> > Isn't ptrdiff_t the appropriate type for an offset to a pointer? ssize_=
t
> > is not guaranteed to be the same width as size_t (this has caused
> > problems in the past[1]) and is only defined by POSIX, not the C standa=
rd.
> >
> > Thanks
> >
> > Phillip
> >
> > [1] https://lore.kernel.org/git/loom.20150207T174514-727@post.gmane.org=
/
>
> Thanks for bringing up a very good point.
>
> We often consider that a function that yields what we would normally
> put in a size_t variable, when we _know_ that the return value would
> not be so big to exceed half the range of size_t, can instead return
> ssize_t and use the negative half of the range to signal error
> conditions, but as the cited incident shows that it is an easy
> mistake to make.

In my compat/rust_types.h file (which was dropped) I defined isize
using ptrdiff_t rather than ssize_t. Maybe that file should be revived
so that we don't have confusion in code reviews when structs are being
expressly converted for the purpose of Rust FFI? I'd really like to
bring that file back so that everyone has a clear reference for how C
types map to Rust, but no one seemed to like it except me. Maybe it
should be an adoc file rather than a header?

[1] compat/rust_types.h
https://lore.kernel.org/git/2a7d5b05c18d4a96f1905b7043d47c62d367cd2a.175727=
4320.git.gitgitgadget@gmail.com/
