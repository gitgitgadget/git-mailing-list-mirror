Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB39299A90
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892525; cv=none; b=RSYwsb2b+ebQtIRPj1bhfPDAyvyvPmLh2RS4riTo/G9G5HYwGOTcFwV8D2/b0ESNclDmio9IK7ZeWif5ABN7AuOTh4yH41Ez6Q3OwyRkxY3pUFtiKAX9GVWLEZl1E380ZRCTnd2fQIHNumqhrw/bBuHQsbjB5tQEndf7bnAUjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892525; c=relaxed/simple;
	bh=wrKt8zo5U9YwylHbiNU2BmBZJeQbH/bFCehHKa5gmqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1I5g1qMwxL6xpxE3NlrcSTk2GODMS6KZ0C+TdftOW88JuLwHHp+FYYhHYRzUr3MP2Ty2wceElxcakuH4KVjHB4CVe0yFIl3kT8EEWf5CBQvvUfQmgCrFjyQUjYOmDeGjt9u14kxO6RIFmPj/lYwK7Jz1roGQNra0XXCO5GcyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn1Pe6AN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn1Pe6AN"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce5253adcso2572520e87.2
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892522; x=1756497322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF1IEgJDlqFgHl+HWuqpNSahierxIyAtKmqE1iAn0lQ=;
        b=dn1Pe6AN3Wsmi3Ztazuf3IFinpMitvmjWg9seBFeJ2u26kZBvxsOOK+G4VbLuyWQSE
         JNuIQXqSqNV3Xf2GdaqslSLt1BlEor0QyseoMkQrV2z1EFLyvMz0qF7R5XDmwcvCW8/L
         kvK1BMUwWrFRlcBtljK3YYs71XVIP9GRBWzSeJGOulWBnBQwwCeo1COLQyzalBoPFJVo
         cpDuxS64mfZQJJNJOPBkXSTv3gVYzck8Y8OUzsW3L+J1sX5CD58r1XqBhSYbdNkRT1eT
         LE2ZNox2T1MxrUCd2KQlMJ0NoG2GlHsinOeweOqDvj05KTnIaxxPtyYgL/kQCp5EKkj1
         2pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892522; x=1756497322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oF1IEgJDlqFgHl+HWuqpNSahierxIyAtKmqE1iAn0lQ=;
        b=nQfjJ126D2vAW5z4A1fAzVkfSvW8Fp7cDVIsGZPKRLS0d+2puMecSRbCpiWplQg0ja
         bZQxkdSXrQlHIwWkYyImGYPzzHpDSAN50ANgd0+FlbDatq+FvVBBT+eZuCfKKEXwXpY+
         BsovyS/44NgM1QtJK2MZxpvi4vgzHAeQa9gP5WjNMyZRrz9ty15M+mbM0j2icQhThwQQ
         +y7on8biTUi9f6lcXONpdpehTePjeYIBJKLUuLUHAO3wBKsTNmc0LKfPfsQ9MSaKSTgF
         osjTnIyGa1ZOATfqRD47UjDUEIr/Ah9mercQnF9vt45xMFaAyxS5/Ag6i+i76ohw2kda
         j7lA==
X-Gm-Message-State: AOJu0Yy6YWDWEYTw8NqytCNv9DZ3x1WK7mIZvlQaWWqBfYqMKm/5Gjrn
	WbUMCj7dXpxNdDFL0dpuocUM1iwY5AUMmzE+nhppuUWjECXgE4GFLmaykkLcGVpyGgrdRfPTIv6
	efws6M4ouhNjrHeBR9d/k2NYv4heygJcMTwDY
X-Gm-Gg: ASbGncuzAsikwiZM3t+TF/HAEPnuwiyMdHVIaNpbxfdJcx/BryhJZQhH7sifvll2E36
	+tBiGUlm5+Hpnfhrk7B4raWBXHRugrPLqKt15bs+sCbDmZ5SJICeh197bFWJM+ZAK77JkEBhrPT
	KWmmMMZJCzvUEObCWuI1lLNiqYMpNFIbTLqVfyRV7OCFYYxozX2zeiLsaZgY5HlRGVJOOoazYN6
	2n7sAA=
X-Google-Smtp-Source: AGHT+IGQ2VS3vtdb3kXf5wTTik+cUV46QN0B6+NOkCjXprXiU3Ht38tU7WsdGazupw6is4NrtlCheMHtrYnCRaamO8A=
X-Received: by 2002:a2e:be8d:0:b0:332:4fd9:c58c with SMTP id
 38308e7fff4ca-33650f35e60mr15893461fa.27.1755892521478; Fri, 22 Aug 2025
 12:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821222605.3993-1-rappazzo@gmail.com> <cef6487f-aab4-421e-ba04-a5613c12e552@kdbg.org>
In-Reply-To: <cef6487f-aab4-421e-ba04-a5613c12e552@kdbg.org>
From: Mike Rappazzo <rappazzo@gmail.com>
Date: Fri, 22 Aug 2025 15:55:10 -0400
X-Gm-Features: Ac12FXwerTXMspoad1HQmnik45ZrTRRc58_OEp5tjbsw1J0nSORC7Bnk45sQC0s
Message-ID: <CANoM8SW_3dLtQBEcK=NgQWCezj2PNbokDyeaUvVMTN1ufYav_w@mail.gmail.com>
Subject: Re: [PATCH v2] gitk: add README with usage, build, and contributing details
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:27=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
> > +
> > +### Installation
> > +To install system-wide, you can use either `make` or `meson`:
> > +
> > +```bash
> > +# Using Make
> > +make install
>
> This doesn't install system-wide, but in $HOME/bin. I am unsure whether
> we should encourage this. AFAIC, I would be upset if this works without
> sudo *and* clutters my $HOME. (I pull Gitk into the Git repository,
> which I have patched to install in /usr/local.)
>
> How do Gitk contributors handle `make install`?

Maybe I should expand on this section and add details:
```
# Install to default location ($HOME/bin)
make install

# Install to system-wide location
sudo make install prefix=3D/usr/local

# Install to custom location
make install prefix=3D/opt/gitk
```


>
> > +
> > +# Using Meson
> > +meson setup builddir
> > +meson compile -C builddir
> > +meson install -C builddir
> > +```
>
> I haven't used the Meson infrastructure ever. I trust this procedure work=
s.
>

Yes, I installed `meson` and ran these steps.  It replaced my
previously installed version


I'll send a new revision in a day or two.

Thanks for the look,
_Mike
