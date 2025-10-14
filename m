Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA029E0E5
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433303; cv=none; b=A8z0DkZ/gpjWERrjLqhRe9DOkhexNRxI4hYUP505X6wbGnVPoxijcEUuYBouquhq525dbDkGGCXeEhCCzrbrsoUVDfMszXp9oAVlO4ii5E5T1BdIAezpaBy5yI30LorC0GWqfToFTj7aQaBQeS1qVZftnySxkTsIGr7HMo0fSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433303; c=relaxed/simple;
	bh=rEvo6pb4gxReeLn6kMhCgwqWXh+Ta5PEXXYTvdpyYT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rV29sKZ9eE88UrM0Ya5Le7Oc+uijRhfvZh5RbGIDI9/kW/kO0o37zedbwdie4tArNlMvWU9QLQyMElys6TPg1L4igzPBh9wBY/kjbSxpYb5icG8B9CLa75Xw7JM3yYLp6s91t0zzOhgWopCFbJfwsoB35SJXzwhDgsLQE+AN8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQhtKhrN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQhtKhrN"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3b27b50090so946890366b.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760433300; x=1761038100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEvo6pb4gxReeLn6kMhCgwqWXh+Ta5PEXXYTvdpyYT0=;
        b=WQhtKhrN2vqOeMtaOYw20nBC5MLZHW+I493n1fhW2TKmGJnTxZAg3zX1MYFEyFhIDK
         NNQCvaVn7trQaF+zdS5lPqLnTc0OG+Fn27lQOp0Z6e2MiWJy6sjxlytTAER+2SAxjU5j
         jc1D0PsPeKvGBgyqNZtWYqiYOQVrCebIiwLw6wlE3KL5bpWtnG+3vJnZBiIKPV4gE5dv
         X2SANq58z1Sa1j6XprSUue88DOuyV4Rh2B0YKZECRE4tbp1C4D/ET1Ibs4g+EtGzAIJA
         Pw+VEqUhioYeMf+0xab92EWwCtblnoQ1OFqHx7/CnrCfj0bglRer7krywH2m2wnsVNUr
         nY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433300; x=1761038100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEvo6pb4gxReeLn6kMhCgwqWXh+Ta5PEXXYTvdpyYT0=;
        b=EXAitO5J8n9fqz3z4W/ZsnUadFHyAEsr4MGzOlTWDM415Mhn68wvdo4IpuGdkP73je
         wyd3RLDeHqHC/FLU86DgAFlneU6N2J89l7fa652mUwB1gt60MbddOtO0ydvoj5Wrc8+4
         axMGt+Lip7LQsSPtVnez3bU9N8oM6pi816iD2Tc46uq0QP/617pjfHocoG3e3+KD3SS8
         gtq3rqXUwRfAifjzdcoPHqaKnrc5IC4HxGWDjiQKD0NbmHH2IoAq83zOX6ENSLGLtTcU
         dcSK68Gwc3HObQwSizujnq8XyvihIyyBTuud/J3gKm2+e4iWCxW3N4es8NaJNADHzjUW
         lE6A==
X-Gm-Message-State: AOJu0Yw9erJWmpPWSowqagyRwFf1gD3EBB4xAgmvtOHzJh0DHx56lonk
	8l7d028UrEbCTqyQwaqjemR69bb0xIkVuAY8zgrqwrfAR4/cLbRBNlzUA1lZ7DWyGPIaEXpOWWq
	udaMmp7EFPEY4BylmQJStIGkPxJUlnHA=
X-Gm-Gg: ASbGncvWW+gnPNVtVyALUGkSeo+Y6bh29ayEc05lWDyHaK/YLQ70lbPl7Why8gkgcos
	bgBJ7tC2SUDx2Sb/xAY8cR7DFSlANjFhZ+U45Kxrpf6oYYh3S97rj7GtJ3kbVFMQBQRJ68KQRSJ
	d3CQwAunMndczVgjESG/TqtbLuOZ/8uxol8lqjJQ1unXwF1dIVtNz5dE8z+me+yswee81SnNsvO
	OA64KWfQpeGNuyXNUtXtKnO0u4LLC9MNOPN
X-Google-Smtp-Source: AGHT+IFyZUO81szFWiGMZXqneDBllDAah+7s9p7WLpBF4c3+WJRudjuhdRNFfk5Zt2dQzraqGbl1xugubf9IbYwNMck=
X-Received: by 2002:a17:907:1c0d:b0:b3d:b8c3:768d with SMTP id
 a640c23a62f3a-b50aa490851mr2440833266b.7.1760433299595; Tue, 14 Oct 2025
 02:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
In-Reply-To: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 14 Oct 2025 11:14:47 +0200
X-Gm-Features: AS18NWBv8ia0FXMiK1dGpr-OEr5fhyYGHIrLmnjZz2r8aEFqFq7Labo5vqUNfwY
Message-ID: <CAP8UFD136SoQn-Tip_MQ4zxfs5a060MTOU_Hgj34ppjes+Rogw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtPdXRyZWFjaHldIEludHJvZHVjdGlvbiAow4FnYXRoYSk=?=
To: Agatha <code@agatha.dev>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Agatha,

On Fri, Oct 10, 2025 at 12:09=E2=80=AFAM Agatha <code@agatha.dev> wrote:
> I think this would be of actual significance for several groups of
> individuals, especially for transgender software developers who face a
> lot of challenges to get in the tech industry, even when they have years
> of experience. While in some places linking their current names to their
> former names might even be dangerous, or at least lead to embarrassment,
> losing credit for their contributions to avoid exposing deadnames could
> also be a limiting factor towards obtaining employment in tech.
>
> I=E2=80=99d be happy to discuss whether similar ideas have been explored =
before,
> or hear pointers to related prior discussions.

One recent related discussion was about the following commit:

1f0fed312a (SubmittingPatches: allow non-real name contributions, 2025-07-1=
6)

(See https://lore.kernel.org/git/20250706163009.335780-1-sandals@crustytoot=
hpaste.net/#r)

I think there were previous related discussions about the mailmap
file, but I don't remember about any specific one.

Thanks for your interest in contributing to Git.
