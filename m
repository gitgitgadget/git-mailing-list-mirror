Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE8257D
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719728187; cv=none; b=jI9eEwGXCqs7jZPF/7BV65pRUu4BfVDPgKvG0pWeMxLIJRQRyudzGD7MMwlxJQcthhAM5ZRmacz6jZi1ZAYn5ifW8nOHTYILe+0iLaSCfsxIPs8T0FH4h7/LQsrku+YWbDQfuA4Jr1GtvTRvsBsT0bykinppSRlHvTEWds934VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719728187; c=relaxed/simple;
	bh=BgLJvWiZKKZYsv+Q64BXoDVv+04LbMWU6hGf06o+zZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJNvdb3MYX+tfhOe74cZ00mAarrS5zvndlyfU6xS9yFEEniGV+R2/t0GHy0jUVw9BfMO7MoqIMnHe7HzKQgGjhyHIX2pJBWd6sVDqRdD3fg47jdT8drPf/iEsU5pz3EHrVNMcZd2RsN2R5uMddovFfsFJJR1BMwwxwh4M0gfMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1XAU/RE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1XAU/RE"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7245453319so306917366b.1
        for <git@vger.kernel.org>; Sat, 29 Jun 2024 23:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719728184; x=1720332984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olHVxVdSVtXkhyv8wcsFRCfnWW+LZWTZvJg7FWK0GSY=;
        b=W1XAU/RE4gYWMOu275yvVG1qMMb79TM4ykDoSl8I+2lDEiQWNEC6rHCgubLAS8xFV8
         +Xqt9ZPeRjQuRae/UdJF6BbXnKqUogAJd/6u9DUUFX7NPATCs2MPQWtPX4+FvpwQK4Ao
         9zo5VsqJNuqO1rQQlHpxYlSsq9tENn7bEYDjySggeqWllT1JcbryeIIHp7JR6PfoLNMu
         uk8jUt8xzR30WGBENGbirb8stiCksQ9JCk7pj2V7BiPpfw4oP6LWw4GVlFwT8NUTEe+k
         bZAQtXqVcYEBqnnV8QS3EUjsen+DL7b8IKRA/VTXJb/wqwr2iybney7dkSXIybTS0E9q
         GbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719728184; x=1720332984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olHVxVdSVtXkhyv8wcsFRCfnWW+LZWTZvJg7FWK0GSY=;
        b=oIsfDmzyRGoYRtOpRGST0QJaHpwZnW5yLwZBE13Ize0bsdY50LUUlgsVyvpyPqBF95
         CS/XElLclKTIEeA7cDuOtlSmxAQMHf9fdZIr3Ca/LbkNKvDA8xggNznASZrUkXvDrKc+
         SGnavprAhY/otyr4YVggYXJi0k5V9/2kBe6VUIMmB+y0dwzEsGkbeZf5LSZYpEbJcw/x
         /l6E35doLHf3LDWc+EuFlOi+/09KZ0buNQZV0S5pBagTEhtmwUSzqfyFo5SVk88zTb0t
         0YgM1rHlBAqNY+jUztYnziSZRrLJcdRCDyK1yT2dGFSY1dJdywR0/rXf4LDINW9BFyPM
         9sdg==
X-Gm-Message-State: AOJu0Yy8zy3XpcYqq6DjsafnlQM2k9Y5TJv2HaBKa3O/oCa6Fs8wk5Kr
	YsWEsYQCSuowPPbx4+KhatBYCgFKIY3q0gwvzzzpxpjHPtYQfMGE6e40n/KXBLGGbGEZ41MNxYv
	DktzabXH6dSPbfyWNvU+e/we6wRE=
X-Google-Smtp-Source: AGHT+IEED4Uo/pIWYR+arFEpcEZd11rS446ttpf0bYvWWiauDzO/bfUvWHO8QwHyk8iTZfNrsMe9ZhAjuriA/Z+u3xw=
X-Received: by 2002:a17:906:71d6:b0:a72:75a5:bb42 with SMTP id
 a640c23a62f3a-a7513936891mr181079366b.29.1719728183876; Sat, 29 Jun 2024
 23:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD1eH8GXn=aER56FVvrh90f_c+VdxdtopJmDYwPend52gQ@mail.gmail.com>
 <b38543d735b2c14d82523300b8c6c84c@manjaro.org>
In-Reply-To: <b38543d735b2c14d82523300b8c6c84c@manjaro.org>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 30 Jun 2024 08:16:11 +0200
Message-ID: <CAP8UFD29quACuPBuOggPTwHvVvdii155ZnX0AWfSVzinH7mTrA@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 112
To: Dragan Simic <dsimic@manjaro.org>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jakub Narebski <jnareb@gmail.com>, Markus Jansen <mja@jansen-preisler.de>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Sun, Jun 30, 2024 at 6:57=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Christian,
>
> On 2024-06-29 23:42, Christian Couder wrote:
> > A draft of a new Git Rev News edition is available here:
> >
> > https://github.com/git/git.github.io/blob/master/rev_news/drafts/editio=
n-112.md
> >
> > Everyone is welcome to contribute in any section either by editing the
> > above page on GitHub and sending a pull request, or by commenting on
> > this GitHub issue:
> >
> >   https://github.com/git/git.github.io/issues/714
> >
> > You can also reply to this email.
>
> Thanks for the draft!  There's a small typo in it:
>
> s/who add participated/who participated/
> or maybe s/who add participated/who also participated/

Thanks for noticing! It should be fixed now.
