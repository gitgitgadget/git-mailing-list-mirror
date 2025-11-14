Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C562AE89
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763090606; cv=none; b=bbJVmiSVx/JNm9cjEpwVont2wtIbXahjoSm5EkVomlu8EZXrt/+9XxHeV0OSTeO7ANriYUY6eNzIW0yfzQ9mEhJwF+ELvigsxVTJQxoFU4Sgkx412OU/hAW8lOqE4zyGAaVtIhRGplSdyHRag6JBVs0/P7ErlXyk3bYO0YYn2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763090606; c=relaxed/simple;
	bh=qBIJstP2Pq6rga7HCLD+fFVtTUhEGPi9hq9GsBouXPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brPfGSLkTsSeiKviYvCd3Mi5lLQirRXttg08CYK+zZKYDrK4ThDiO1w4fhlDQ8MtHGsV6F2AEeo//gQuIcHQ/dVFpzq9Hcx0u9PO3HGRIDlOCFzOd/wYPcDP2R1H/2/5bZsq+lU4Uarf9s5Vp7ZSW0ZHyPMFKrb1kxI2AvdxXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=kGqr0woI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="kGqr0woI"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so1020410b3a.2
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 19:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1763090604; x=1763695404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTIk5GpF7IgpG9V/ybT3udyeitXV287Fj8IxEn+/iSw=;
        b=kGqr0woIUzxJybijKlqn3RqlpayLCev+7BLwQjT8Wpg6kxM/B5OMXIUjhD4FQZ3Txw
         C2nWjwENnOHIn8tzotDQljMbQyh7LA6dBtvszhwcugD1cXRzOEyAjRaPbjBSFuzKngCw
         keP2F3/jnndSbUWKczrYwn9TtzJPx2323rXCLNpvcjsgX1q42errdkcVX+93OKqfB+E8
         Zr4yr4QLe7r5Dw9GUfjbRgykV7jGkyrnaVgC6iF7eFfBwnEXvmioMidMEKY6WuezY7XZ
         FR8KD+NK116O1kvSrY6PY9gKFfsUoxkXTW//MJ0ICNDH/Uf3pWw8bVyLKrlL1d5Sua7C
         jZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763090604; x=1763695404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GTIk5GpF7IgpG9V/ybT3udyeitXV287Fj8IxEn+/iSw=;
        b=LufxIJZ4HN4RD4/9jO2v9tEVrkAfxE+0QMc7EvM19Z6+RzsjrlGCvpMgFRYPZY8Khh
         meUBVpQPdG5S0JTvJHbHh7e3hKsf2fb0MF7SxfYLmIBDL4Ei7IsCn73BKY0AZy+f0RdD
         2P/YgbZpjPV7JugEF+qG3DHcknYXQkNvSh1FzsZy3n7bOjw7UsNfhHmQ7Onr7j523lTr
         /WUGwPEAuDn0K8NpnZO9HSfZswbRH+roPFsmcPw+uNCZV8EqpjtEz2Js7udTYgy+CfYb
         zPiH5mVNK6ISq6s31/1NhDjLnZNdJySHMxKoIHbp9vClhlswieuDdLPsywXPnB0qnOCW
         +uFw==
X-Forwarded-Encrypted: i=1; AJvYcCXTkD7CEs1O5Ia7f1Wq+B2PiCrYCxfLwAvha7hMwVj8pfLBT7/enp00l+WPsxlVzh0i1gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEp/P5ExTsqoCv903Q7T4Hk5FgUpGuubzmH8HQ6rpr6qdSS83J
	MQ9gSYTygCteI2ISavevDVMGEFxszx/V/N4qGREwEFVjY6Q6nj0seC0JJSw8Ovh1Ou7HwRhfKZb
	9rb/VsPUE5I12FypsbVC9cWo/HQVv+PAwIJQPB+zXVNFkhXy/sEArSLF/300qO5P878e5AFwf8U
	LCUkMxcAvmiBs3bzseSNUj0niiRJnGpjHdvYRRnMraI+glvlmWcX5x2CYY1bO7LT4CwyvsYqu1K
	uPKXaGH4OcMhGbqRWLdsy1ZFxGwr9kEUZqtIGD0KBY/gpE36vk5EaZwQZQiOAxLyU08HJLcf/Ay
	gMezyErkjCzusBo=
X-Gm-Gg: ASbGncv8ZPU5yWiulVguJPLzMsTuGD2CYzDF5lOSm4TH9ClM54SYWeJQZ8QpTzMkdG/
	QmzDPyl//wZhuxwWmpnyuczWpsuEwjjLJpWEuLN6sdvxZv0U3xzfNgQ/FJ8gzLtsOObu98a5wA1
	WwalKK7W0MI4vnAAIhTwKd/ClNrNkZFz8WGN81aj/ctZsGEXFdKqW7fsrv0BgBp5h6s0BrpELp0
	zhmeqjgSMiIEF81FuFlyLdjjwRq6aa8doK2Z+ioGGCr/pnNq6dm+UnO4V3Y+Q==
X-Google-Smtp-Source: AGHT+IG8y/9fyeIq2/6+f0f7ISeK2ESVsq8TJyacvSUvMJAZnNjzVA0RYPrB5ZTp84ybohe4xk4L+RoCmOSvPTsgRek=
X-Received: by 2002:a05:7300:a98f:b0:2a4:809d:9a8b with SMTP id
 5a478bee46e88-2a4abb2752dmr686228eec.20.1763090603372; Thu, 13 Nov 2025
 19:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1999.git.1763047599254.gitgitgadget@gmail.com>
 <xmqqo6p5llsw.fsf@gitster.g> <xmqqecq1llgj.fsf@gitster.g>
In-Reply-To: <xmqqecq1llgj.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Fri, 14 Nov 2025 12:23:12 +0900
X-Gm-Features: AWmQ_bmXjGdVvH9k9uUEgTyD0Xp0KuuTwW-xI4MNTUDQ_7ipeLdr0B4R4KbeImg
Message-ID: <CAOTNsDwSUCqrGW1A4LvGYCseFZ6=XZ16C0OS85s27SyzrrfYPw@mail.gmail.com>
Subject: Re: [PATCH] osxkeychain: avoid incorrectly skipping store operation
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> +/*
> >> + * NOTE: We could use functions in strbuf.h and/or wrapper.h, but tho=
se
> >> + * introduce significant dependencies. Therefore, we define simplifie=
d
> >> + * versions here to keep this code self-contained.
> >> + */
> >
> > Sorry, but I do not quite understand this comment.  The program is
> > shipped as a part of Git, and using these functions and linking with
> > libgit.a may pull strbuf.o and some other *.o files out of libgit.a
> > to link with git-credential-osxkeychain.o to produce the executable,
> > but how can that be "significant dependencies"?  For anybody who is
> > building git-credential-osxkeychain, the necessary sources come for
> > free.
> >
> > It is not like we are forcing git-credential-osxkeychain to link
> > with a shared object libgit.so and making git-credential-osxkeychain
> > depend on it, or anything like that, which may require consumers of
> > binary distribution of git-credential-osxkeychain to also install
> > another package that has libgit.so in it (which is likely to be the
> > "git" package).  Even if it were the case (which is not), what good
> > would it be to have git-credential-osxkeychain on your system
> > without having git on the same system?

I see your point. I was following the current implementation's approach
(it has its own xmalloc() and die()) and thought the comment would be
appropriate if we continued that approach. I will refactor the code to
use libgit instead.

> The rest of the patch, excluding the poor-man's reimplementation of
> helper functions, looked like they match what the proposed log
> message described.
>
> It seems that credential material like username and password are
> included in plaintext as part of the state[], but is this a safe
> thing to do?  The keychain will give out the credential material in
> a way the requestor with sufficient priviledges can read, and this
> state[] is stored in the same place, so I am guessing that this is
> not adding any extra security concerns, but I just wanted to make
> sure you've considered any security implications.

Yes, that was considered. The credential helper protocol already
passes credentials in plaintext between helpers via the "store"
operation. Since the data in state[] is handled in the same
manner, it doesn't introduce an additional security risk beyond
what the existing protocol already entails.

--
Koji Nakamaru
