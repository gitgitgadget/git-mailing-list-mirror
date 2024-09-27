Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4318C1F
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427472; cv=none; b=g1HyPIJyF4lXSU/CAEoU83HrEYUGhBoBhFNJKNVygjQuns2ugEIGdvkj2OiKiH0nUNDmau+GevP71+NuJuQbPJzd1dBgaj/CL2VrQ4uk7YpBoRMwt2q7JlARbYWUjPKLQrdcso9vB763+X8tC1N2hx7DwUSV354vq3vwxyuwbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427472; c=relaxed/simple;
	bh=8yXIEx9yWs0D5S7UXjLRuzJsKm53vWI7gm3Gf9BTzvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8SVX5jUijbpONk4wS+TzwdY+eFq6XesuB6E5OtZqOcLIrGZ2TObZbdHxaqWNGQqSFd34tFxJQYaPN232FcrEnneLoll2PmpxiDaSfvxS/2pp0PyAvm2OhOSzPLqle1L5DODcFHQQJ0sXpcwYDAf48B3zmHP3NuEzUJVQz+OrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoK9TAe6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoK9TAe6"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aa086b077so251190866b.0
        for <git@vger.kernel.org>; Fri, 27 Sep 2024 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727427469; x=1728032269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg7+P6HRc/uVzGK4jv5DbGEMUnJ21GaTsL4y3YXyPgU=;
        b=GoK9TAe6cgRNcFkabVtLyYmz4Zrimf5ey4sQdktTvoRZghgcJeTAF6LOSx6yH/IrdP
         O6tQJ+Gp2jJCPj9AkrvpJSUK5DiALUASiU3bY4Kk7Qq5sMTFxYPXvmxISujAEGLtnOB4
         i3nt/Hd2e3f/S7TCcqA/5F7xX98NsB3C14jkf3gHhOqlukodIU51qskn9DS/3iEaZAXq
         CRyxn8yG9LdVURPlVR5icQGyayLes2Xf50GzJQuiL5PL4nqsS1akYS1djrwwheKZimYD
         ljz7hqTt3DE5mRKxwhG56/+l5cQjMl+BNUJ2bJ94ifRafwo6xXGw7MqtfUOJ7ALM3r/o
         exag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727427469; x=1728032269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sg7+P6HRc/uVzGK4jv5DbGEMUnJ21GaTsL4y3YXyPgU=;
        b=EiIgOV8CQ+Ydi9QAlj5Ucjetazm6QqebFUNqG6HYv7ukjacZKlBfWpoNf9Hg6fmO/k
         1CruTMGL/gYz0lKfTvRUAio1LjLDIre6zjFmk1S8b0W97Zf2r5KkqtgX0uHP4vRWIoXv
         owcvcr9MQnmrA0XFytLmiWHszj6r8WUHNw8bL+IcBLu9m/FY6gCsnPO1JeXI1NXN4r/u
         spV/L3aCzGa4+q4QsRdbOh8llZGGp14fWGKMqllqrgELensBoDHG7+I4rjVuhvuLBLJP
         lmjHKq/mtG/rIgbOovE74+n8aaaXdnIyUWmaBWugBZvQk+j70I4UfQaKUM8DbxGJIEB1
         NgrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk5djNMwuUupoCy/gisrM6t09bdSqC906HebyCW6KGYxRBBNRjHX5nfiwXxemm4PCDtE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQX88KdCabOoKKS1AA7JfVOrE9QOIGks7R5bvcWd8U0u09xQ17
	8+uf9us5P8FlyyNuA+vqBE+wTiZCWEfiYE6W9NewXPnEmDFRUWDPkZQp86tUiwlazIymYvTeM+X
	BVw5C9Awx0Ksvms2yqE9Shtvi104=
X-Google-Smtp-Source: AGHT+IFK84H6aTAhqC/dTU4urOMIxP4gVI1kxVoC5zGEhVd+13LFwMdidJu73R30XQvKtZAq6yk+t9ZOd6YS46GWgCk=
X-Received: by 2002:a17:907:9718:b0:a7a:9144:e256 with SMTP id
 a640c23a62f3a-a93c48f1ecfmr222795866b.6.1727427468655; Fri, 27 Sep 2024
 01:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824172028.39419-1-shyamthakkar001@gmail.com>
 <CAP8UFD2yTMNmx0n1jhOu7dz_4XeOyTy1iLmRWYmuf9QJf75hsQ@mail.gmail.com> <xmqqy13ei819.fsf@gitster.g>
In-Reply-To: <xmqqy13ei819.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Sep 2024 10:57:36 +0200
Message-ID: <CAP8UFD3JzYCJf4+JLvfW_8m6kp=O0NMKi1dF1Fof9=DmvZ4u2w@mail.gmail.com>
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
To: Junio C Hamano <gitster@pobox.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 8:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> I'll discard this one by the end of this week unless the topic sees
> any activity.  It looks to me that the project decided that a longer
> term direction to adopt "clar" as the unit-tests framework, so this
> patch would need to be written even if it were perfect in the old
> world order anyway.

Yeah, unless Ghanshyam or someone else wants to continue working on
it, I think finishing this work should be part of the "Convert unit
tests to use the clar testing framework" Outreachy project that
Patrick and Phillip agreed to co-mentor. This project will only start
next December though (supposing a good Outreachy intern is selected),
so it's fine to discard it in the meantime.

Thanks.
