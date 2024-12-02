Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DEA61FD7
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733183338; cv=none; b=A8fCp+vdM3gcb2IpSTdbSZMBBlW91432OULkEd2BoXXj3LcH6Dj01YoBp8kXxlnNy0WSN1pETAF3kLkqfCaX5nN9EvM27cxIW7+Sbpnqotc91g7Mzv5esdLb8Kzkak0x6tLEVBf3+m+uDLSHDdbQY27qkdFQbG5ZEQIOFlSFFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733183338; c=relaxed/simple;
	bh=tutPZASWlic0m0tIbiWpYgbZa0i9wWbJ3dLWKan6t0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyrcTfBzKPBPgZZQtL2VnXZsgGapl4HJAxFVrCSlb9B097egOsEsnixiqxCHIApCJC5PaRYO3Tbby9PxNBuzlIDEbLWXSPSbCAX2KQqagrHL7oEAp9Kl7JbC21vcj00BRfFsaItNNEv43MxhqtjG7xbuCj/rtKvCzFpcoQlwqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrSh81No; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrSh81No"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-843d7f16827so152019239f.0
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 15:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733183336; x=1733788136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0DpfZqHOP5qdW6mWtSwWkubPfIZvBIoNUg+ebwuqSY=;
        b=BrSh81Noi8tHUGGWTH3eZPMkeoxFZEDKAe1B0O2UYPdgSFFLRUBcwWKm6vzCgycELp
         4KkEHOAcksCd95j9harN5JCeUwp62RUAFDT2o95I7x+WSQwCG605BvHvXvOW46S8pChu
         2e464jaGLr+tmH7C8W2mfdcZFe88+1G7U70Q8HNbk9O3iaXCuCU7SqhHJ5aB0/yNcKSG
         a83Dw1qS5T4MyaTf3mT55IMUBv5v53zSuG1bf5b4KGBEFuawmsOMHWcmzudVeEfvKaU9
         UtCHOxlTZwkIyluVi1odtJtmRSZ7Z1kCM1+82pHVTKggwId1kS5JBlg4NEV4Oea6jEX3
         y5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733183336; x=1733788136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0DpfZqHOP5qdW6mWtSwWkubPfIZvBIoNUg+ebwuqSY=;
        b=ow+MsN7Q6ZOd1Fvt2267FolEhWo8OD9jeGSZrMPP5gWoTZrTChqEQOPyIeSr+3he4V
         zS+Cst4IwiSB5wFRV54NWO7J9LKmZ38Z8c6KeINqTuGOVmIDPC5zBxNmITW1xDBvTodu
         k45reIDoRh5tqSg3qhlg8CrFQNKD7pJcTHDxaCHFn+TSWHvCkaSJh1U8iWbnzIvlgaOR
         nDYP1Y7twbMtS5PMwr2PuQA3kjEIk7WeizMgoY/cH6ll273qCzKWN+2AkEHiCCIPiFq1
         iC0+sOgmWkZAaj1goNbsW+YWMd0DEuRCKV9tKlCNYSn4mLU5+bijwzULnuC1ajqZaBqL
         tbPQ==
X-Gm-Message-State: AOJu0YxW0fV+kty02zkGwac1ehIUyMVqhsJTK5nMVa9n+sDCIE4V2Yib
	2AAEsSh287V76V4GyRpdnxvkL9xZSuYUUYN6LO92vKNmHj43UW3DvTbIu3x/85I62CfMhm+jAaU
	xwmBI/2E6qp/IiSyx3OkprOLkKt7tRw==
X-Gm-Gg: ASbGncta0UsO9H68hgalZjv8Zawt1R2uYHcwm4zAtCTN3XXM8m4AehgY0NN1mXPih3T
	iZ1qi08pqf9uoyIQSl+0mEE6ca4pvN4CIPOY/hyDmRgTeI1rnXWsk2HzgtHnMD9rA
X-Google-Smtp-Source: AGHT+IFc1aQYThscbcJ17w/EPTIylmp9R2HUnsX1Xz7PEY1Jgk1VU6J/mxhHKLb4uufJlyLJb4j67PETrHQVvPk3L+I=
X-Received: by 2002:a05:6602:2d81:b0:835:4d27:edf6 with SMTP id
 ca18e2360f4ac-8445b577027mr61929239f.7.1733183336170; Mon, 02 Dec 2024
 15:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
 <CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com> <CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
In-Reply-To: <CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 2 Dec 2024 15:48:45 -0800
Message-ID: <CABPp-BFzaf3K=LDk+Yp271M6hxdoPdW0G_T3OeNzfUEfkSCxuw@mail.gmail.com>
Subject: Re: rev-list --ancestry-path with arg - bug or undocumented requirement
To: Kai Koponen <kaikoponen@google.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:45=E2=80=AFAM Kai Koponen <kaikoponen@google.com>=
 wrote:
>
> From 447a2367f8d3318e69adccc1b011b0d04792e438 Mon Sep 17 00:00:00 2001
> From: Kai Koponen <kaikoponen@google.com>
> Date: Mon, 2 Dec 2024 19:32:25 +0000
> Subject: [PATCH] doc: mention rev-list --ancestry-path restrictions
>
> Signed-off-by: Kai Koponen <kaikopone@google.com>
> ---
>  Documentation/rev-list-options.txt | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt
> b/Documentation/rev-list-options.txt
> index 00ccf68744..1c678294af 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -412,12 +412,13 @@ Default mode::
>
>  --ancestry-path[=3D<commit>]::
>   When given a range of commits to display (e.g. 'commit1..commit2'
> - or 'commit2 {caret}commit1'), only display commits in that range
> - that are ancestors of <commit>, descendants of <commit>, or
> - <commit> itself.  If no commit is specified, use 'commit1' (the
> - excluded part of the range) as <commit>.  Can be passed multiple
> - times; if so, a commit is included if it is any of the commits
> - given or if it is an ancestor or descendant of one of them.
> + or 'commit2 {caret}commit1'), and a commit <commit> in that range,
> + only display commits in that range that are ancestors of <commit>,
> + descendants of <commit>, or <commit> itself. If no commit is
> + specified, use 'commit1' (the excluded part of the range) as
> + <commit>.  Can be passed multiple times; if so, a commit is
> + included if it is any of the commits given or if it is an ancestor
> + or descendant of one of them.

where the changes are the insertion of the phrase "and a commit
<commit> in that range,", which nicely captures the restriction.

This patch looks good to me, thanks.

>
>  A more detailed explanation follows.
>
> --
> 2.47.0.338.g60cca15819-goog
