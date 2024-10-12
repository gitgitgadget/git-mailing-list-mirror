Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341328370
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728760252; cv=none; b=uLyKCctLK9J++aOjv2OHroNLLUdwjeinhEl1HabCrYA30MMmFZNy6Gq9/If4YeYyqKD6Y3aQMMbTJDsi9aawlUWjRvUn6KraVuRyJhAOxNRBw/SAJkGmjdiE3yEat/S+vKC1dCwfNf9hWGj1eEpcgnUXpQ264DidSADXPWVUwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728760252; c=relaxed/simple;
	bh=BbwEcx3SqulTkZ3Xksv3ArN76rU6y3eTHX+0ZAudqQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hX0bB0jrcNXrysYE9Bwuy5dQSbZmkvyZ/ZQia+jgxg2GZCQjx0XnNSo7FP/uuPI/vnaguhG2wPVYJxWuzmQ1Mr9mbPnapL38pm3X6XL+A+Wtm4b6Hv2EHmLQ0+YZ8ICyaFblA1+KrVoYEWF9r1QzumB/TUOp7ExuIu8rvignJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=willfris.nl; spf=pass smtp.mailfrom=willfris.nl; dkim=pass (1024-bit key) header.d=willfris.nl header.i=@willfris.nl header.b=EmR3XbMt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=willfris.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willfris.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=willfris.nl header.i=@willfris.nl header.b="EmR3XbMt"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so1545469a91.3
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 12:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=willfris.nl; s=auth; t=1728760247; x=1729365047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZUsVAn+3gLJEwrJjbJGZCrwjdy/RlstXaSWFalLxEc=;
        b=EmR3XbMtrQnfpNbOLQBf6n5zvW4umjJdDtt7/Bzid73MAKNcKAC+Iv63iYvyU7gtHr
         /8MtNp+S5ZG93bMnc6EVKP1E5z9Z7xnSsD6j9yVifcdYc5bQLKVvMQRs0c/+O5WuMaki
         wAjOrcG11i/K826cmTe3/Gtl/ioepAmtTLFQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728760247; x=1729365047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZUsVAn+3gLJEwrJjbJGZCrwjdy/RlstXaSWFalLxEc=;
        b=srOOwo+hc+XP+0FTqdUrTQDjvAh0eSw7xVM9iduH/MRnv/ALwrKZGfoKPN5QyMQuTA
         h9/lwYEsO92et+/GE3dO5LPybauXCEPLFbjQOMEtsB/MbyT5rRiOWom8d8dA65mXU7LN
         m37HdnVomjaWqfENhTuy4OrdzlHktVEEuLRHH7yeH4i1by3sYsYAb9TA9Bh+5WEIbyYK
         QRXRwC4E/8IViRJrsZXroxgkeH/2RsFe7gKA1fxcARg09yrRiFIzbfCgddDpVMG+iISB
         5u+Hk5OetzYYI3g4DQPChHH2ar5liiLiGDSE2KInGzWY/pSdsduPrpMC/3kmtZR6+sZD
         SIRg==
X-Forwarded-Encrypted: i=1; AJvYcCVZn4xDDwT2iwTAIcJM1i+AxHQtsETfDRGncsrKYNQoKrEDtqh5Soy57kkp++ttUnyI4PE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CfxhrFEVpOa6neC0r8xw3dr9O2mFc84A1gchLg+T6+vdf7Mg
	y5a08qV20p390RjQJ8pRea6QsNybSmHIs94CQk+yq+10k0YR8uR8q9oMc6mbh4ajlz8CZl8fVfK
	JW5xiaYuWsT0wO5sne/lYs00VoUxbnJHX57whHA==
X-Google-Smtp-Source: AGHT+IGgmgv9dNiIKTItV+hNBKeFIDTcGaVP/zO9/1X+ZvUfKapA+7AkUklPi49WGLm7Iw04An2Dl57afMIbYnxZVvc=
X-Received: by 2002:a17:90b:617:b0:2e2:991c:d7a6 with SMTP id
 98e67ed59e1d1-2e3152eb736mr4315044a91.19.1728760247138; Sat, 12 Oct 2024
 12:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.938.git.git.1728745399993.gitgitgadget@gmail.com>
 <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com> <d2aeda41-84fe-4ddb-89e2-5cafbbb213fc@app.fastmail.com>
In-Reply-To: <d2aeda41-84fe-4ddb-89e2-5cafbbb213fc@app.fastmail.com>
From: =?UTF-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>
Date: Sat, 12 Oct 2024 21:10:09 +0200
Message-ID: <CABOUa4aY6GdoBH+XZFCRknpiOP-F=SE_b=B3RLjO-WdS_Quikw@mail.gmail.com>
Subject: Re: [PATCH v2] diff-highlight: make install link into DESTDIR #Makefile
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Oct 2024, 20:35 Kristoffer Haugsbakk,
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sat, Oct 12, 2024, at 19:30, imme=C3=ABmosol via GitGitGadget wrote:
> > [PATCH v2] diff-highlight: make install link into DESTDIR #Makefile
>
> What does `#Makefile` mean?  [=E2=80=A6]

not much.
It is an attempt to signify what the commit relates to.
In this case it might hint at the commit not impacting the sources of
what is built, but the build process itself.
Maybe #=F0=9F=8F=97=EF=B8=8F would be more clear.
