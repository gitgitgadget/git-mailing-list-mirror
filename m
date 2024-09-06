Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5798BFF
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615767; cv=none; b=WM5mKgO/m9klNYyLzistgzwM9QsVaenjDgBURHDobQYriOFF+ygvPx6duukYTzAF1RddHIVbvKsQdauiekzh1KrjogRcuDC+kdYYzVof/UDb+T8CjvmiTu5XXK2jvgQ1liDRxEJJMTNjERLhqg4L0ZGWkUaovztQlMwP08cWrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615767; c=relaxed/simple;
	bh=nKrNTIF4KWyeBSuNPGSip0N+6JmpChJoo2sG2rKhoPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqKrEoXm7q0lL1BnilBN1owbkWFx4dHhSDpZG28IcaC8S4JaGHag9yyOvVqoscUYVGRHN6BZLXdvaJg939/z3s/t84t/f5APSs7/rPCKF6VnNJVxhmFBRHUaGQS/ywcSgWs6Mr6S0lYKRklzReisqtEt4UUFUbJpdiUHtgtXtoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Usj2TrOq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Usj2TrOq"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso1287884a91.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725615765; x=1726220565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BOpx1aQ+MQz/gICz1IvgQZyqaCT1GessOHxkhaaZLE=;
        b=Usj2TrOqjYz97zz87Nf+DAPPHFP4N+UFkah71aoYSeh1fFPVdReqrzOgIj+9Wvs9Eb
         66GJK4vjIAVc98jS5td9DJkK9Lj+ELft9L4+W1OEupEb+34EHWMmY2Kj0w3pVtFqEPwc
         DPJaJZPHGXQ8QYSFAlrXQznUpAsM4nGAj2u+mq69XcWtfljmBITL+nkWRuxiuPh365ih
         d12KIO9LbZMW/DNQClLpE+p5zI7GKUjDF+u6FYG0E1lDcvvIAQGlfnhW0UIV2Rn4Q3oz
         7VsTzhWX3P99rlmr20P7an82LZT5TOn7p5hbMl8H3ul2mqaUl3AEWNQWM1vt9AYUsO+c
         SPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725615765; x=1726220565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BOpx1aQ+MQz/gICz1IvgQZyqaCT1GessOHxkhaaZLE=;
        b=xFsPHWBy3we6nlWNfn+hC2jLuUnfVzHbvZma4pPs6+BG50oMFOYqzgW18/NHTYQfKC
         ZV6LJSRLHF2FEsJhnGecrPt9KYfDFNCIcWeZkD6yk2BmG9ACKR4ms3ACtNfnR4upiChz
         jR2o+sEYHBzPnYFybRFuQcc1OZP0THSLzHXhUC3pqMjMgzM0Swewsz/kjeR59cQh19km
         2w4BzDXV0SmHRqvq7NImh5A6G8zDfMr4Y1ZJaYUk3DtJPleEphwuUfe/jXnqUOgGH0cA
         xuVnyTsP+HkRfamvTV73fidkLk+U6yVVkGh1IMErtNGhBJYQqHgHT3CTd/h6Ndsks9yE
         XnDw==
X-Forwarded-Encrypted: i=1; AJvYcCUcnJQRCugvVVyOup1CCgDXxZ3xMm/gxddHtXYuBXm6AvhINBl0TmDq92L4739B1wfpv/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/CvStW+8TmGBs3wvAAHZLq8b2gvMwDy02pxknNd45tS6Y05k
	+ExGtbmdP1+3ebp1ldu3FG7PPQMpWfqL9WqNB8chjunlCqF1CKrco8Di0uqHKSNpb3AAsfLJ72C
	03JpmE2X8tUJlEvhIhuYQcEJmMrQ=
X-Google-Smtp-Source: AGHT+IGaCBFMi73ixcqjrluicTM7af3goP+bXN7vduSHvfa2+xFdSZ0Qm/hgCyeuhN6ZxX1DRJRu/VIk3u7CUFoCJrk=
X-Received: by 2002:a17:90a:cf0b:b0:2d4:6ef:cb14 with SMTP id
 98e67ed59e1d1-2d8563916e5mr27288175a91.28.1725615764954; Fri, 06 Sep 2024
 02:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1779.v3.git.1725554758463.gitgitgadget@gmail.com>
 <pull.1779.v4.git.1725565398681.gitgitgadget@gmail.com> <xmqqwmjpzull.fsf@gitster.g>
In-Reply-To: <xmqqwmjpzull.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Fri, 6 Sep 2024 15:12:08 +0530
Message-ID: <CAG=Um+2EjRGJ_XTqHDuP3y+3BRK6SV_Wt9LNvjaBHGzrkVJibQ@mail.gmail.com>
Subject: Re: [PATCH v4] remote: prefetch config
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 2:28=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Shubham Kanodia <shubham.kanodia10@gmail.com>
> > ...
> > In a future change, we could also allow restricting the refs that are
> > prefetched per remote using the `prefetchref` config option per remote.
> >
> > Both of these options in unison would allow users to optimize their
> > prefetch operations, reducing network traffic and disk usage.
> >
> > Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
> > ---
>
> Looking good.  Thanks.

How long do you reckon changes like this typically remain in "seen"
until merged upstream?
I'm preparing part-2 of this change separately =E2=80=94 so would be good t=
o
know when I can submit that.
