Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A51DFE12
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916151; cv=none; b=BX5KVdd+5hsLK1WQKjyOWHE/WOoEk/FF9BANVZYVfirMf7GeYrfcG6ndZHhCIuGcXbNtwF7rgzz84KLs8gTVhZJL7CicDD3m/vuY1zf9vmFlz7q+ohwZu+g3HeH20pomCcCnpW2NEB5UWDt6QxlMK7NRjVSvB3rF9FnN9pHFPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916151; c=relaxed/simple;
	bh=qvEe6x88QLdWxS0ZDvVyipFySjd75XAqwK7pLpxKjD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKjIOFerYPfGAHxWqbIIMVAQbwAX6aBExDyDWNOD02EhjnYrgDbXG4p45qBFbDSrwbMLCKBw8+tl5PCiVJdm/T0XYTFBlh9nqklLm7yatLaOX1eADdwTQVTny8cRNOvYlbWNG26ydEJ+Pbg0OHAjzMRnMqB1+Nvdyh/gH7ATHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiSG+l0p; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiSG+l0p"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4aed12cea3so787835766b.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759916148; x=1760520948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvEe6x88QLdWxS0ZDvVyipFySjd75XAqwK7pLpxKjD8=;
        b=AiSG+l0pekGKNPYZjT7BTWF8q1ruLTPXOHQsjQ2CNSy10fnVCP0+No/plywl/TXblP
         hpI3S3/O17q/Gfa+12G3jJyivWTk5Cw2XZdYCjtq/IASNR8je/4tXGa92c9oMuG1Q5QL
         +GvZ2dgjbrbrHd31A3npQMTP9SBJWpwNzmcqtp87LszKpzXSZFd+gl4YJRf8bzkKKt/I
         7RPrCLVYIvvyI8QuviVuuoxtw0LK6EHrgLdlyXa2RHlxnR+Fw6ZNQqLpr4zIyX1l9FVx
         6wlGUt83KWLil8YqEnKKtCApPtupHEK3fuFBPKGR3kSxJjMj834Cz6cmLZwhkAiuSrnu
         yD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759916148; x=1760520948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvEe6x88QLdWxS0ZDvVyipFySjd75XAqwK7pLpxKjD8=;
        b=e1AiPt2dXGBshSmwnr29bEhEUgHTAZR4m8R5Hr6+anuXhj7xRjNSDw56pcnwdN4Xja
         4Dvu2fgDz8/33TxHJ8cPEVPSRd7EVJM+2qYE61YZYFH4zAAukhoJGxijDUS/0hXKY/4/
         4X5HJee/coV0xqvPI0AcUpzpyWEnU/k8XHYIFw8NBCVGqrE2Fim8qOOfN2HVOwooVLoa
         gG+pv884D2RoPCLZPl+P7JGOtUcHw7HmRlFoFjMGjrFp5zoKvggdsCepB31vEcDsiO30
         Uv+dazMzHQUxutX0xxOVSKovqrRaFJPjJV/6PB9JGnXi3R5iEOitA9jtLgUqTCzw+Hqm
         wKAA==
X-Forwarded-Encrypted: i=1; AJvYcCUueIuBFkmnVkZJ70Cg8FGkkTWenGKf6wrvPLnVbtKNRG8lCNCc/sRxd+97mjGEn9sVcFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4nGwy+gn5SQMsjrQTywLVTpmIaIeW6wvF4y0pSfFhKKkK7fVe
	csbTajyd8d42+ebGzLTCBeLyVMFwbosuO25Y9gaiYR6yq8knB8tpKgl0EcZfvZ15ByRtw0E0fd/
	Aw2fhXU8WigSd6WXChaCVT0cXSyXeT8M=
X-Gm-Gg: ASbGncvg/42m/oUmOZ+Bb2MZOMP2b7WgzM9wanMQ22lwM9Kv1UDY+U8bxuokscU9DaE
	zvQGezDatyEC8x3DHz/iVhLQjuiuyqOZCWMFbDYCmeiP1nf9MNCtir7EOVyNSkXCULDc3GxGF3F
	4C6A0FodwBprKkeWmkRiGjgGyO+ibgfIJIa4QuBNOMhmUsYjkr+/88C0SXpgbLdvdPHK86lo/c2
	kYEDLqEnYRQxlA0WbCGwP/FOqJThnA=
X-Google-Smtp-Source: AGHT+IGHvPapIVZU8Znj2o8+pFGGSJ7rO9vpdMwew/qQ7PMFj0v3m6GTSIX2OvgPfj/YHvfurfhq3MNG65HJMP4vA2o=
X-Received: by 2002:a17:907:980f:b0:b3e:c99b:c78a with SMTP id
 a640c23a62f3a-b50ac5d07e0mr336112466b.54.1759916147722; Wed, 08 Oct 2025
 02:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net> <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
 <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net> <CAP8UFD34TrBa-GV1wUpvhO9K+qjHpXF4gr=afY2nsXiNL_-S+Q@mail.gmail.com>
 <aOYuvGkQglLOEu-V@kitsune.suse.cz>
In-Reply-To: <aOYuvGkQglLOEu-V@kitsune.suse.cz>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 11:35:35 +0200
X-Gm-Features: AS18NWDlBFZ_Gm7x9S8zJkjKrdQq0acy-XI9a_vlgkg1E537kkSrTBBLie6BCAM
Message-ID: <CAP8UFD3cg1W+LEgDrs77prdFvKHhUBsT1d0P7zpYswBfMXpWVA@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 8, 2025 at 11:28=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:

> > I don't think it's very relevant for your position on this. On the
> > contrary, if LLMs have been trained mostly with open source code, then
> > if they produce copyrighted output, that output is more likely to be
> > compatible with the GPL. It has even been suggested (and discussed in
> > this thread) that some AIs should be trained only with open source
> > material (for example MIT licensed material?) so that we could stop
> > worrying about including it. If that happens, there would be no reason
> > to outright ban AI generated content, right?
>
> even MIT license requires attribution. As most current day LLMs fail to
> provide that their output is legally dubious even when trained on fairly
> permissively licensed code.

Fair enough, but then if an AI is ever trained with the particular
purpose of producing code that can be included into MIT compatible
code bases, then hopefully people training it will make sure it can
help with properly attributing that code.
