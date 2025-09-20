Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F71FF7B3
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758390119; cv=none; b=V2+SEEIaGhvFaQP3NScDgMvx+Jwm/FqdW9TO7JhawymcTa5uL2ub7ZQLKzzlHU8ofXazycF/ZZPsINDNbVKKelFfUb0Rf6Rz52UOlvkQie/ntwFup6+RJG4njUlCcjZUwsvqKyTOPXoB9dBJCbeE5U6fr66DYJjp8zDF7+pZQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758390119; c=relaxed/simple;
	bh=4RU4xyMwPpBaBNsjiB3z+zA0GVpte8XbsgTUueptXuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRPsyAYgNG3lVrI8ywPgPHt7NqbuHrMhqNCWQV/A0vQ1YWoFdJ8Lrt/LS+uQsH5pcykWAoJYapsoeLbgtq7QPd99H+Kr8IamNfnAlMS3qbTsZE+o+3t+LBCNB7yTd3Ih2rNp1VVyVi3UrYtmGn72yTQwTj1F1+g1bpojuPxXwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bonq1Knm; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bonq1Knm"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36585c3211cso11600011fa.2
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758390116; x=1758994916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5W2QujraEPTBYphj7gpqpOi+umcSwXLIhSS1mixhl4=;
        b=bonq1KnmGmGvRK8Itg8G+qtOMavUhFxO1I5f0IVpoo9XS60QQHfXEFowmM1ypzzfrh
         OfbyQt2iMvJT/ktdjpvnWCr/uq63QKA2eFi+KxarPsjmYKKypXPEeFB+/yocoeFbYO47
         xwns9ektlyE84oQW9O6wylfY285npxn/QqEXSX4STtp6Ve8vCbYGUMRNBLYqRpKoObbG
         X2oBUWbIeN1N2BdcpmjP0ylmbbF6qGpFVCzFkl3ePD3cperc7AZfI2mFxPq3s6WHNEWU
         zJCvXgqJWrH76IVfPbdK+VXBivyqt+ErjwDGUWq1k0Gzv/2qg/b92HeFOzAOXU1LrH55
         /jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758390116; x=1758994916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5W2QujraEPTBYphj7gpqpOi+umcSwXLIhSS1mixhl4=;
        b=CokHec2rYiYN+BsLyfrt3PrAmbOtf0PbDVGTUImTgX/FBNYT10aVaAdUQQDSWsp5Zw
         6GH2PidKxQUyGptnTlKRp4Vun+qZIgjlFi7Cpbws3ZqZ+aQur7ZgGRGCVv42Xa+sXjO5
         21aXzQSUFWEj8w0owSOh/sdLLeYlWZbEDsdTG1Kz+ZDAODf1TbjQgsfPf/NVEW8rYZk6
         bNeTEn3mzeycv70jb84GqCcO5f/GkiAqptDmhzL55Wn1rzKyxW1gWXpApTJi07qARVnl
         Jhr+MoYRW7Mp5FAGB0hsLIEBhEdBZ2i7KIsWGbiCbayP/gCarC3KzJdK7nElxFpP7dfN
         r9LA==
X-Forwarded-Encrypted: i=1; AJvYcCUtwSDn5J19D9p4+8sl/OzdCLpyQlhKduGfsKilndU7D2Ugred2i7I/4Ycm2d6qfnim3Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9iSIEsxoKXjZMgzOr0Wpmd5+jp2D1vscbQRnMnO9Pcnyokh6
	emmUX8cibRPaUhZgZtbAmVV9roN1Vi07cVgwfF38nJzBKiWIm8CyI31P1dA8keKNd0UJyPkktqO
	OJPaKmUHnZeYDMA4H4oKMXUQeRq3CXAU=
X-Gm-Gg: ASbGncsiBe5UQTtnZMPSCfyDoDVWz01wGefl5dnWn7mqEwyR60+m8D3ey/1wqllxG7X
	T3I3AG0dYODiDXOberpuBpyIfv3pfZ3UaJdU0TqloBckgH6Qp5EphuyPWUtlVMBlZKE6AnExex9
	dm4pF1uFvY1rQT0MIxeXYzCd2rDgvTJtTBbMS7OaPnki8URZl0bXOHTzS6+32RQVWA8wNq4MEXm
	HmFDM9a
X-Google-Smtp-Source: AGHT+IFb/1lkIGRFnUQ/1hCUkOP4Sxo0+4qaKRfj+8vGbj8xTq3jUc5Y0YOUnLteMfYlSOH+a8hv+QofgZoHGfLRoVM=
X-Received: by 2002:a2e:bc06:0:b0:336:ba05:b07f with SMTP id
 38308e7fff4ca-3641afb9821mr22765841fa.21.1758390116069; Sat, 20 Sep 2025
 10:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com> <784cffcef564b31a32c401b35f33610b85126f7b.1758294992.git.gitgitgadget@gmail.com>
 <xmqqh5wxxcwq.fsf@gitster.g>
In-Reply-To: <xmqqh5wxxcwq.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 20 Sep 2025 11:41:43 -0600
X-Gm-Features: AS18NWCCqcmcLWk_xP3DOo6ft9SgCfSKzg38LCVibjsJfbbemaXwecfidps2Vrw
Message-ID: <CAH=ZcbDzBvmzE75-7-BresWG0tYW05-1G-cnT+FLeuJe6JStcA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in xprepare
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 11:16=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> > Best-viewed-with: --color-moved
>
> Two comments.
>
>  - This is a bit unusual to see in the trailer.

I'm still not sure what the etiquette is for including those kinds of
flags in a commit message. Could you show me my full commit message as
a response with your preferred way of adding those flags in a commit
message? please.

>  - It turned out that it was a very effective way to spot a typo for
>    me.  You should try it yourself before you send out your patches
>    ;-).

Huh, I have viewed this patch with --color-moved dozens of times. I
think CLion (My IDE of choice for C) "fixed" that for me, and I didn't
notice until you pointed it out. Elijah missed it too. Maybe my
terminal needs a more extreme contrast, so it's easier for me to spot
things like that.

> If I do not spot any other issues in the series, I may just "rebase
> -i" to correct this single line to reduce the risk of mistakes,
> instead of asking you to send an update.  We'll see.

If that is the only problem then I would prefer that you fix that
single mistake, so I don't flood the mailing list.
