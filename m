Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B11CF7AC
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447829; cv=none; b=fjf0jRAHWKOe21cM0TBe/9JvP8+Paw4qzPT+gIW+CaSJkO6IXXspc0yO1g45p4nTf6NML6y+kH65altgzfJBgIM7gf325NjYRUofI40Q4EU6aDgFpR6fPluYGTdB5gVcRVsj7F3YKrfwSiV5Rjaexx9CKCXZJ5RCo7XsYSuCD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447829; c=relaxed/simple;
	bh=9FaMep6HuHosPbOw/yj8i80P1qMK3f8zOg6JasbzowY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYGe4JjSfXtJwASRnOeuq6k50Jk9KVp3x/By4UgEkG/Z/zX++RDfpAcG2X64fLBuhoib3BtAodt4zxOV6A/3qEQiGGfosjmxp4MC2pwFTtd0Hl1Z6/pd0HFruZag60rMb6tNfIztqdgSFjqxPt2E+rDQLDSmx63m+fEf++n2HtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d12Oqas+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d12Oqas+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a81bd549eso584818466b.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725447826; x=1726052626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/04u7w9R1bDQYpHcOt/n4zoFDahhEsoWxqH3E3sTYc=;
        b=d12Oqas+JnN31WFKN4OMtNBhaTpxmndJxrj74GgHNXLUuMLlbA1bOk0kRcIwiKiKBx
         Vam1bxC7mOxYOdvRH2+UoPdhdONA/wJycy5Pjc7Ri+ktVdW8ot0GEdSrBmGXjGAMjAJr
         z59RUhlgAG/Yk79dlfHxxQ/bJDGI7W4Ansu7okn97siTJ0KXzjVY0ux8EokNhC0O3FUa
         DWuJd65zlKXHLOjmQGglHW9U4E1sj9/4RgUsSJ4L1B4zou6RDDpfZl7X0v94a9QH7bgd
         hBBdcTlSDFfdnMs31+vtDT+j/90zYWjZAMbVIXk74K1FC6zHy7m8IWa44lbd4UGzWQo1
         ramQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725447826; x=1726052626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/04u7w9R1bDQYpHcOt/n4zoFDahhEsoWxqH3E3sTYc=;
        b=aqTQAyhFF11DUDzkPiXg1p6NfUPB5w8iDHFOwKTtErWKQh3XDv7BvFcMfn7cQFPK7F
         bPRT8nmYd2ua68khIB0Rm06ydZKQTfGzEGkLzHXlhwdAxGKsV+5PLkhjoaECAamix57p
         qtbaV716X1QNAIR9LCuR7kVZuHLRO/n0lBXq3LMXVvZ9TGL6tMMhXJC0gfJEWByW4Zxw
         OYWjAk/rlfuNUAESE6QJFeDKyosOWVdu0Wredt9WgbzNJijwEIqz5z3xMyrlpobQ6Ykr
         oRZMvCsWy4bPozuOw5dSr0ZWxdmY/AkAC4DoX0bZbnUnvHtiq+SAKiKMl3z6+toP5nuu
         8elA==
X-Gm-Message-State: AOJu0YyuGbvZCaYSNMpkqtBnFq7t5wwsPZmtpyPEL2osxeTecP152HRs
	R7bUUK+RmcdoYbyfFeR/OlfQ09TY81283+m7rSfcYfKPmmWjVzxZszRskcspEz2uwPjqUCl8Gw8
	B/0iCZVx+GS9/zik0b2G7apQGqL8=
X-Google-Smtp-Source: AGHT+IFFOlZucDz/rnTa0daQwcEZkPGTVHPtWlTlBC97KEH6ichayD61ruJ9Xc4MmQBLe9Tbcn/jjGem913nZ+A3kBM=
X-Received: by 2002:a17:907:94c5:b0:a86:aa57:57b8 with SMTP id
 a640c23a62f3a-a8a1d5726eamr468649366b.63.1725447826125; Wed, 04 Sep 2024
 04:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmRvtz=WOPpv54-22aEFsCPi_vwpFo_Q08vq31NjggOVsw@mail.gmail.com>
 <CABPp-BEwLYhfBN6esMdeTcby4=12zhFeSqrih-WPy8D+pW3sxQ@mail.gmail.com>
In-Reply-To: <CABPp-BEwLYhfBN6esMdeTcby4=12zhFeSqrih-WPy8D+pW3sxQ@mail.gmail.com>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Wed, 4 Sep 2024 23:03:34 +1200
Message-ID: <CANrWfmQpUFCkDrdC7k7pMVSY+jow6hePNcd0324PH=T9-WwHsA@mail.gmail.com>
Subject: Re: `git merge --no-overwrite-ignore` overwrites ignored files when
 merge (i.e. not fast-forward)
To: Elijah Newren <newren@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(https://lore.kernel.org/git/CABPp-BEg6vxiUp/ says: Message-ID
<CABPp-BEg6vxiUp> not found)
Many thanks to your leading me to the "Precious Files Design Document"
and all the other links!
The document reveals that untracked files would better be further
subdivided and explains the meaning of each category. Really clear and
understandable! Turns out that the support of --[no-]overwrite-ignore
is not enough (only works with the fast-forwarding backend), so maybe
users have to wait until they deal with all those issues in a unified
way.

On Wed, Sep 4, 2024 at 11:19=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Sun, Sep 1, 2024, 03:49 Han Jiang <jhcarl0814@gmail.com> wrote:
> >
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> > (`git merge --no-overwrite-ignore` overwrites ignored files when merge
> > with conflict.)
> >
> > (`git merge --no-overwrite-ignore` overwrites ignored files when merge
> > without conflict.)
>
>
> Yep, well-known issue that I've mentioned multiple times.  Somewhat
> related to the "precious" concept that has come up on the list a few
> times.  See e.g.
>
>   * the "merge backends" section of
> https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget@gmai=
l.com/
>   * C2-C7 of https://lore.kernel.org/git/CABPp-BEg6vxiUp
>   * affects cherry-pick too, with discussion of how merge is affected:
> https://lore.kernel.org/git/CABPp-BG=3Dpm8gfRZNW8Rk1V77s40Do1FZy0mxH6epub=
HbzF8U5w@mail.gmail.com/
>   * merge and other shortcomings mentioned when fixing up default
> handling of ignored files:
> https://lore.kernel.org/git/b7fe354effff8da3de53bd9cc40a03b5fd455f67.1632=
760428.git.gitgitgadget@gmail.com/
>   * wider discussion of correctly removing or keeping files (also
> discussing merge), in a series fixing lots of bugs in the area:
> https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmai=
l.com/
