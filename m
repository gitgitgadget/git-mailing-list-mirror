Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A924C06A
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470846; cv=none; b=V4HAP+oXAMTHn2h2We8i5QttKzXtNndbW2sVqTl4Wr4QV5GUxMDgjiLKBW6KlNr4GzfJKNNkyHI4j/MkJTsKpmZzBePUx22C5niN4RqQRFAXv5+iFSEFh/F/dBzWc98JnK/X5Tg+bBtXj+QAu8kiWa+6IxcEoCtwqyKiGwzCRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470846; c=relaxed/simple;
	bh=bIge+rlPuwdoEEn3KTXVmiNFVa1RpB/wPUrFtlyspfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E08SlRDtRHGmgugDdFZ50DqAsKlMKiAzJbPRgDi2UJZsn25Ee3yaGkB4HOP2Qr8RuBaLX75E0WjC70Gvdeo/tEjMHpHl/A/lbceLP9OdoOnaZG0+sg16U2KGYBSScWu2s5ujb9PVbYl3YsHxqeRGnIS+7o4/vcKIbeLyJmbvs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVfn6knr; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVfn6knr"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4331e9cb748so604005ab.1
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 15:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762470844; x=1763075644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m2GuEz0GzcqrjqcUtdq7muJcjidIIPSDSkw8rQJcck=;
        b=eVfn6knrWsedMvsTwVDfrUl1U2eTUi8tCU/NNBzqV1k5iEsop3M4wxyl488JYJzFdJ
         wa3VATfZGXWSaM4sgE0k/gVqLf1ETXDTZsLDlbWi70VymHyUm1b72muaFQaU42MeHXie
         ahHWaRytU2W+smzzduzrNS2/56kHvj7zah5YyHBbqqV8leexPng+dFDkvU1ycWWqLPtt
         KNGyTA553l8T0SzJxrU/tbkXZ6I4RRUXMfbXAaormBof6KbF7FYm4kFBv+oH+YPiYzY3
         s2vTEuvGRvQYGppCG0elb3KnfZtdXlJscr0t6jXYqSlk3IOJQwjga2N40AZlt9rC6QIl
         MpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470844; x=1763075644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5m2GuEz0GzcqrjqcUtdq7muJcjidIIPSDSkw8rQJcck=;
        b=Cl7ggL3ip1QqFDJATehUk7vU+EMXv00XAXldA6uUfTLABY/1X27u8y07OcD3jHZ3pG
         ArY4Tvn2+hYmM3Yoi3g1AE2cbT8imzyW/nM08KC+J6VgXVGYuUBC4kPh5lRxcgJTl8c9
         w9+HDceXGvgxInS3/YWBdCrRbmU+vCYxAztC0eEKaQuKy79CX6vO7FNNarEzYTSepdY0
         xLI5S+R8kqNOfotPMgSIP6sZO2HCz3ypKqPNEjdzb9CB5tZOCrRMMoUMK+frMfZGpXIp
         OlIvVa+dVcKPq+A1LA12oRHK5fkUrqgXHs/1P1eu2PI/t2/Z0NIrXH3UI5QDoIrMtrSX
         pE3A==
X-Forwarded-Encrypted: i=1; AJvYcCXKDxIkRYGXFXUOlXs1SEf53tS3DboYhSNUwW518/nKl5snGYTWTuJfI2a2zQsip4if/iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKfSoPlorSYZxxxSs/9ehVZ75yrjDTEiweBIc7SiVGWn/IOiO
	PjwH5+CDJOYRJmZK3MIwTOQMQqBCygG7ne2WI6fsbVNzm1v4O3kvyfcA9OPppUc4NcT3g7G3VwP
	vqNwK+QeEgViWc2hNpepeylrlJdX41gg=
X-Gm-Gg: ASbGncv9j7DjRyPACS4W9k2ubPlaxqoaCDXdeUWd+qHixDewXe0+QjKtL/Ln5VtruiG
	nTe22svJ82IVATJWfP/7Py/IvB9WYhJ4OIH21aniSF6On9sTjFqiM+7uzy12V/j3Al6aNKlqml2
	6MwhAEPGclEUpuBQkcHbA4ZxIcAQ6n9q60Rfc3+mH9OUM3um+LBTUsUgvTuPp9FZrc2xnBFo1He
	82EEjTUIcUWhkZaTMzvPUjIXCUBbhf7VOMgJgqX6Q1b0i7bfaEnP69KMeYtHG3h2PHAfDTGYkp1
	yypc0y8=
X-Google-Smtp-Source: AGHT+IGv5Tg7mSQNqJGGvucoYIL6UXPRQ2qfNKvYmjkaa6/vsQShHwjvxgUrpvdMIqXFob8hZAbFbuSWtL496ebEkCE=
X-Received: by 2002:a05:6e02:339b:b0:433:1d5a:5157 with SMTP id
 e9e14a558f8ab-4335efdc175mr21221835ab.6.1762470843852; Thu, 06 Nov 2025
 15:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com> <46bc1b3e25885fbd324a6428ee7ac3b5d272c4ce.1761776388.git.gitgitgadget@gmail.com>
 <299e25d6-caaf-4672-8160-53fdafe96134@gmail.com>
In-Reply-To: <299e25d6-caaf-4672-8160-53fdafe96134@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 6 Nov 2025 16:13:51 -0700
X-Gm-Features: AWmQ_bnVdWZdcnZN7bSy4QZHulS74C90XSjfIUmniYx30FPkByD1Gc-K_OOFgaQ
Message-ID: <CAH=ZcbA7d5Z7d=VT2_o=+M8pYrGzO7TgAaLisk2k0p7CuQuSPQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of char
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 3:49=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Ezekiel
>
> On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > Rust uses u8 to refer to bytes in memory. Since xrecord_t.ptr is also
> > referring to bytes in memory, rather than Unicode code points, use
> > uint8_t instead of char.
>
> The reference to unicode code points here still makes no sense to me. I
> thought the reason for the conversion was to match rust's u8.

It is to match Rust's u8 type, but I was also trying to convey that
ptr is referring to bytes and not characters _because_ xdiff performs
textual differences. It's not spelled out anywhere in Xdiff that it
does or doesn't take Unicode into consideration. Would comparing
Unicode code points change how Xdiff behaves? Should it behave
differently? I don't know. My understanding is that whether the bytes
are utf-8, utf-16le, utf-16be, or some other encoding of Unicode.
Xdiff doesn't care and treats the lines in a file as raw byte strings.

There's also the question of "Should the Rust side of Xdiff treat
lines in a file as &[u8] or &str?" The reason why this matters is
because in order to get a &str from &[u8] in Rust you need to call a
function like:

```
let raw_bytes =3D b"abc\n";
let result =3D std::str::from_utf8(raw_bytes);
if let Ok(line) =3D result {
    // do something
}
```

What happens if it's not utf8 encoded? What if it's malformed utf8? To
avoid these problems I only use &[u8] in xdiff and perform differences
on raw byte strings rather than considering Unicode at all like how
Xdiff already does.

Does that explain my comment about Unicode or does it still seem out
of place to you? I can remove the mention of Unicode from the commit
message if this still doesn't make any sense to you.

> > Every usage of this field was inspected and cast to char*, or similar,
> > to avoid signedness warnings/errors from the compiler. Casting was used
> > so that the whole of xdiff doesn't need to be refactored in order to
> > change the type of this field.
>
> Thanks for adding this. Having played a little with changing some
> function parameters to avoid adding these casts I agree this patch is a
> good place to stop as the number of changes required quickly spiraled
> out of control.

I'm not excited about the casts either, but these 2 structs are
fundamental to how Xdiff passes data around, and so they need to be
FFI friendly. I don't plan on converting other structs or function
signatures in Xdiff unless I really have to.
