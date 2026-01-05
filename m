Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E130F545
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605750; cv=none; b=i8WEPxXCjckfQ36ZdOhioL4IY8RsmuGqrokH9XztB6CKBxxWToroYWk+37l4w1jxw2p9Uf5AA0M7nmplNYzx9hefsLuZVa/sIs+XXUdW+8fk3DmrLyW7/iEkUSSOdy7hjjbH7cDYSWrMklYacHpDtN6w/aMG5OT995nHBwCSukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605750; c=relaxed/simple;
	bh=ft/3ilv0eTMuxENk7wAEltZ8CfOAsdhUvvMQpVXpJ18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOO8hZ9prEpbPlFsjv8O16ZhRgbjmkL3l2bKTqLl7o7QoOq/Lk33DhwZFP3TrmqA8UiEgnvJVFkBsdbYJN0hV+wAu1J/eSYo/oh92JlnYWxxhE76I5RN3IvxO72vAuxX4rwfvvS//ysGVjTAjJjv67z9OzJmbirpNTSSw1Fm4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJt0A/nj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJt0A/nj"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b8b5410a1so16055338a12.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 01:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767605743; x=1768210543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft/3ilv0eTMuxENk7wAEltZ8CfOAsdhUvvMQpVXpJ18=;
        b=NJt0A/njfNLdf+p3lzmK3KlHFpSxj1lFjhHVgbtyfw13i6hV4i6uhsg115Vj0ZhNh1
         qMhwRAEzjK6ZCeGc6Yjf5mWAiR1RMgDKi5qSg5ZkGK0NZkP6kAvdCWaCYehjmQ7jGVuj
         hfWrwtnpEDpR5uwVFdpez6TQjTDiUt5SJJZWsBwOgvM4EV3hW3ufoDi+HitVX33/Lr6J
         skUzMS5GRYL3tGoswo4LcA7KABJYQ2w+LhOnj6OsnrULaWNrjQ3A7x01SJo9f1PIz/4/
         7EFrAP6ookrhXv3XC5DTVuRpZnvcm9fEELkClX9nwet0SRXZ9ZZfUojlvxRaGsWHsYMF
         3noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767605743; x=1768210543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft/3ilv0eTMuxENk7wAEltZ8CfOAsdhUvvMQpVXpJ18=;
        b=ZGxFjXOlEoqsplp0COJEkjGCZUW0ldrKg+XmqRmIuIjBbHV+v7mAZ0MVU0zRqebh0S
         ziSMbWbLKWtZdh2CEMHirW9ocywsiV+nhef+2KDyp7Zk0R2+8RbTJvSvRuFRWmOj2+Xz
         jw8QQ8il2gPEjLsoyx858RtmW2fvs2HwHFX8M572oi4qeKbjyYtfuUlcvorzPGNtC5yC
         c2c3DbTZzu3fp9ZGoH7a0tFRIm7SvEACsKw3ZMDv5CFa3VOjE7k2isW68lswnCMQZDBP
         67MKY5Vus7/Pi6ZL4RbN35pgETr3+l0kKfm5H+bCpcPt8C/t7f/qUvGedrLcluT47HI5
         qGBw==
X-Gm-Message-State: AOJu0Yy8+qgo+TErohUfpCV/wxhIEuViyimgP1vrc4jnL5MEMWSnKkRp
	PSwanXhyLHpEj+5GsCV4dtJ7y5RuNgVEUbDPlVFaCviH0Dcqz5fHWQzXsY1kFQ4pDRdom2BADBZ
	BMxqltjpmiXsCILxkkzA8HIVV5qZ9Bxp4BOTw
X-Gm-Gg: AY/fxX7Npwvw/gJnEbQGoH82B/01cadnHE17CCvEqaMQ4Kdv3YwqVnARfSEENpviY0C
	7o2hEliWemv75VBVN0lkdTdRSrDRYimRL8oqLMLu+25S5ntLdIjVbbDEj6tQmQFheHGfEBLlGiy
	xnO+InKWQpa7/Vy9+RLWNsnhPpSW/Z5ayovnxbjFgeq6fdn360H9QQrAlU81cRv3seCVIVWm2Zj
	dEmltmCAtPCaEjcY4ixJArLJRup9ZayMpvujtk85svRe8EoiYqwiCw7d39okiGMN/m4MNq49LDL
	J6xh17iBKfAmsOfz0Fr35ukaobcRITAxpAydZu+MTgnI8y02DxbfDwGnzIraNkLcXU0=
X-Google-Smtp-Source: AGHT+IHCiwokleKTJyST9CB10uqSuXqjI+S8FO0FMWWIhjxzYBIPABcruP1iejHL+eLUxoaH2CtTy/h1Wmx2p8fOVSc=
X-Received: by 2002:a05:6402:535b:20b0:64c:62f7:1ac4 with SMTP id
 4fb4d7f45d1cf-64c62f71cb9mr35397479a12.32.1767605743372; Mon, 05 Jan 2026
 01:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYq+fa1BB2DzDFj4+GLqtDPg55JCi9VGCv0pgj2C8y_PaM5rA@mail.gmail.com>
 <CADYq+fZ2gempytBwUKUMaV29mdHStueuMYMdqwM-7W_eyQ6znQ@mail.gmail.com>
In-Reply-To: <CADYq+fZ2gempytBwUKUMaV29mdHStueuMYMdqwM-7W_eyQ6znQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 5 Jan 2026 10:35:31 +0100
X-Gm-Features: AQt7F2pf3xItU0sflJpDS7iDFX6l9fTwKXFnR5UuRu9UJXFwKZZWsM2jxBbVUnI
Message-ID: <CAP8UFD0pEjjfiPSrXDnTwNbS5MFaRaEfWvnOUja2A5x2vtBuAA@mail.gmail.com>
Subject: Re: [Gsoc] Early Introduction
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Thu, Jan 1, 2026 at 10:19=E2=80=AFAM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> On Mon, Dec 29, 2025 at 10:43=E2=80=AFAM Samuel Abraham
> <abrahamadekunle50@gmail.com> wrote:
> >
> > Hello Git Community,
> >
> > My name is Abraham Samuel Adekunle and I am excited to introduce myself=
 to you.
> > I have a strong interest in low level systems development and I have pr=
eviously
> > contributed minimally to a couple of open source organizations and I wo=
uld
> > love to start contributing to Git for the upcoming GSOC 2026 program.
> >
> > As suggested by Christian and Lucas in previous responses, I have read
> > [1] and [2].

Great! Thanks for your interest in Git and welcome to the community!

> I forgot to mention that I had started working on this #leftoverbit
> and had sent the initial patch
> below.
>
> https://lore.kernel.org/git/aSxQhqwzT34hIjV8@Adekunles-MacBook-Air.local/
> I will continue working on this after receiving feedback from Junio.

Thanks for starting right away!

Best,
Christian.
