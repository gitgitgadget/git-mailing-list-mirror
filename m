Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679179CE
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362714; cv=none; b=mb2ExTY9Mm578orJsRNYnybi81TLPkl+Hxt0+IllpecbvuJdScjP5pTnMSx4rSyyEiWADDvu1UEA+CfAlMxtnoE3kmRDfmQtTAH/QkqWho52goDxI4Y1I4fY5eR5WWz6Igp5iqBGhIf22O1J0bKqsk/SA4qzKhDXdGk9JVwHmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362714; c=relaxed/simple;
	bh=mghfbPmJEfIeaBm8jPvCafHvMdHNfSdYAQkL7KCt7as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmuO1DEIqdSFNQ8nZT1h2Pg/tl9o7b4iiKfDsuvhU9Iu9bjcILUm1EVVfdKH+s+ukmrI6zqJPO7LKwLIrc0pomgAEmjG82kupTJYsAdbggvC3XVcOhVnxuZEfhyMCixHWZLsJDRDboxPco2RwvwbAPYRp8CiQRF5ebT4wBDAat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drWHPZHN; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drWHPZHN"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f3cd2c0a79so12309139f.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719362712; x=1719967512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKW2IYqsulZSQk7drmnyv/LpC+G4oqQFGMx4XAbI8L4=;
        b=drWHPZHNLzToXJxYiqRA/tMuqZtlfqYwSxuCpDQhtj9tgDLUmvRFdeFemUs6+pGAn7
         7l0DG3y0cG3BqtftaigmkdflLNKzrQAKCp4twtCMITV2khmYtLIL2tWHk54wzb+zaJrV
         LL5zS6o99W8a6BFSBV0+XUQK8HA+zbFjSWfIbv2eRZrVL0WgrjPhT7XK57k2Gzw0iMbp
         89f+f5kWT7ckp6NXLuQ7dwL/dYZOoPDGHfo6dGVuMxsgQ/S2LsB8iWZp+xo1aJU5s8iM
         0Ijx+taZZAwdqIyxe9I0UtOifuiYun5dtNcarWZ/3+vxZIQq+ZEYjM2eeIfLkk9Kru+0
         fEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719362712; x=1719967512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKW2IYqsulZSQk7drmnyv/LpC+G4oqQFGMx4XAbI8L4=;
        b=uXkWJ+ovlgemdPOP925PChCj3folyPJUuc6h6I5yeH6pC/sIP/dCQGjt3+ERnSId8a
         fay5/v0Y2plwRu4TIAhG0Ajwc8OnZ2Is0jPlxYXTVMWBxOi1FxlCxslvboMgjhKkQ9iC
         /0LoKnX6bmzdhGzxk+gE21xo+QnCi+mdacII7vWJByIz8GeSuwPuPI71exwKwnWivHev
         uQkfO9w85KRMufUUDS7citD+FZu7mSd/ti6RoU5T3eyYhc/QPUzi6805LuSukqy8kBcw
         1ZTPqrZyWb8USWJBh1eYxabVY/yarib1hetDq4ZLS03MHTiKBMFYTaaC9i0rfriMD6Vs
         aFlQ==
X-Gm-Message-State: AOJu0YzCkUYp4J5oAvxQQC0Sx/P3qHy28qKyVKG6Ao/t4kxzZpldWGm/
	WcaMHoQNxdT0DcPbxjvqdA6Uf5U0HwtkUcwvZjrtCYIkNl2KXApioQvkjv2wnU9L4/OUCAAYjhw
	QuVjhtwCr/jWAkOAMp0146e2Ryic=
X-Google-Smtp-Source: AGHT+IFFBOtLH/EYol2vear1lLr3FVYOl2fc48zrvW2Sl0t4VPeNzWmnpmURawW64Pe1r0+JVX4gClIyr2jMOBNMw/E=
X-Received: by 2002:a05:6602:60cb:b0:7eb:81d6:c929 with SMTP id
 ca18e2360f4ac-7f3a74aaa75mr1118404739f.1.1719362711696; Tue, 25 Jun 2024
 17:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717715060.git.me@ttaylorr.com> <xmqq4j9g7gmx.fsf@gitster.g>
In-Reply-To: <xmqq4j9g7gmx.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Jun 2024 00:44:59 +0000
Message-ID: <CABPp-BGNXO3wZAYGz1SVCSb_yHzU3E1fynD5yDDyKxo1_55r8A@mail.gmail.com>
Subject: Re: [PATCH 00/19] midx: incremental multi-pack indexes, part one
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 4:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This series implements incremental MIDXs, which allow for storing
> > a MIDX across multiple layers, each with their own distinct set of
> > packs.
>
> So, ...  it is unfortunate that this hasn't seen any responses (not
> even a question, let alone a proper review) and almost 3 weeks have
> passed.
>
> Any takers?
>
> Thanks.

I've got it on my list, and I'll try to look at it soon.  It'll take a
bit longer since I'm not familiar with the area.
