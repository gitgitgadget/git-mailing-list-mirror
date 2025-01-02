Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A027715
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735825170; cv=none; b=VHzGs8rhXLesKWHi70bYIGIcQIEZ2+N6rsVI9PCz/6LreGhIkmVCssae6h7AxIp2kxYYwhf4qFKoSRMo/JITthS4MCEnyQyRsey81/X5Xygxrv7xChOcz0OkqPwPZcy5rEF2sKF5azclHDkIg3qwTWoxiB7LeqN2gMkjYYiWtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735825170; c=relaxed/simple;
	bh=I4WjBtSyyRu1s6YcFwMf/TV1bw8gNbjbAW2MTgtqPm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7SKTL08MIZTj97HbuQNKoNqDCoX8wufDAwpCISm9cX+KD7SPARKegKZ9xQzqX3Gu+LeD9L7j4sPlcXb5IhHEsaEgXu1ylUhMhJIZQ/GFNCMwT288HIAfvGiNnde6kSSEH+yxcv83SU4pN9MXmdc8WcYc+5PkssQ0girk/1+Oug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFrVthvH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFrVthvH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21675fd60feso204562025ad.2
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735825168; x=1736429968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4WjBtSyyRu1s6YcFwMf/TV1bw8gNbjbAW2MTgtqPm4=;
        b=bFrVthvHwDqvuh+knOTelhQPad6UR85Ze1iETjkmEdCpfAXncKmCTIGeFHnQnMj5of
         FzwcdogYrOzuyxpNKE28bOML6IwtAct8ATpollYQbmslGunTtgLqAeawo2MX5vYfMlM5
         c3llIKvi/QjJkkQl9uxiB2F8X36ZMlr7eejLMRlzRffJdqlUCBNg6iI+tXV5W4Qi+cw5
         C6M1tss7VOywxnYSwaus9VBNan+Aa85J7hD4HfilibZrjGRh+7Ey6/OPYz3teRXtCg7o
         YzS065HCVGAMj5lqBm2ku/h/I/OdTr9QlMT3AfLddvXxuB5qh0+2+hSySGYUXCbPZ/Qi
         RSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735825168; x=1736429968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4WjBtSyyRu1s6YcFwMf/TV1bw8gNbjbAW2MTgtqPm4=;
        b=i7U+86MMtcLqA8fJRd8FG8A0XMka/HGU+eMzXpc9AdkEsCeT/6ShzcRYmTZBQR6Gdd
         G9N/HXkJmfOjmOZL7FmCgPt4WicBeQNvAdSf7LCnhKjunJRGyOJDoK+tSLC66UppQK5E
         Q3sCZZRlsug/7LPsqRJte8CA1HiID2jq4sIX6f1YKThDDR1QkmfEpcB/GYpiO7UFDAf2
         NOXVEzXY/3IOK7V/ED3r8frc3Vc4H07mYliuqES3EzOJ72rAZ+sFawc2HNzB66VP2Ieq
         PI7h18eQDPka77azbQshI9WSBbvN4jCqCa33RC1oFwNNEJ0MXuLzNfpQRyCuN+W+xlLY
         05tQ==
X-Gm-Message-State: AOJu0Yx8Y1PyFFuV5wThgq6qKbR+XqBl53sDxZpkA0GdtPvVp8SUCbdh
	qJlkrpNAlAjBHAoXyvXK/yr13/Ae7OGD7y8AOHBbImg3xZUrUwOTfUAfE8m/7LmDqJ9uOWY5Ew5
	eTz5oHUxROC6XGDiOw9GyhDYpOQfK2N1PZmxFcg==
X-Gm-Gg: ASbGncvbRxdCF7daWJmrqh1b8SdjF9Z6yaMWWsDZF3luVt31W2y0WVkdCQBFAoxZ6h5
	StXJvxC5qXWXD02gCNiqM9SqcFB171DJVtbbD9cOq
X-Google-Smtp-Source: AGHT+IFqK903wpkzaQv+89QkZ/l/r5q46sXWrrg4TSIfOxujSTQq1udnFNAsmU9seDVWDNRjcPSSt76nswJwBdthCIo=
X-Received: by 2002:a17:903:234e:b0:216:46f4:7e3d with SMTP id
 d9443c01a7336-219e6e9fa68mr598168695ad.15.1735825166282; Thu, 02 Jan 2025
 05:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGP6POJX9GFsNkgGd7o9Pr-tFoz0sgRk51vVG4P0Kn1DPZe+3Q@mail.gmail.com>
 <D6RLU4BY374I.GQY9MLMV1AZJ@cepl.eu>
In-Reply-To: <D6RLU4BY374I.GQY9MLMV1AZJ@cepl.eu>
From: Hongyi Zhao <hongyi.zhao@gmail.com>
Date: Thu, 2 Jan 2025 21:39:13 +0800
Message-ID: <CAGP6POKLdTpwsaGo-oyGAiYJMRzwXN06rv3+V7v5QbL6xtDROw@mail.gmail.com>
Subject: Re: Change the grep command called by git with alternative tools,
 such as ug.
To: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 9:00=E2=80=AFPM Mat=C4=9Bj Cepl <mcepl@cepl.eu> wrot=
e:
>
> On Thu Jan 2, 2025 at 12:49 PM CET, Hongyi Zhao wrote:
> > $ git grep -i jobflow
> >
> > I tried to replace grep with ug, but failed as follows:
>
> AFAIK, git grep doesn=E2=80=99t use external grep(1) binary on its
> own, but rather it uses its own (and slightly different)
> algorithm. Certainly, calling git-ug (or git-rg) will do
> absolutely nothing as long as you have no git-ug binary in your
> $PATH.

Do you mean: by linking ug as git-ug will do the trick?

> Best,
>
> Mat=C4=9Bj

Zhao
