Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917132E1EEE
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060928; cv=none; b=jYydowfceIKj6iDPV2HMucYR5OnuPl1r0f1a9v/TXKuRd+GI+NIY7aSrX7HwZjpghkaLtpIbXNdKgYq6wbrMMdTTBNkhaLnnc1O9XkFeShxiuSjLFVpghcOKH4YgwSkLQvHtXRM71d5js06vEnjjWFBq93guDyT6s8h9VFIbqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060928; c=relaxed/simple;
	bh=OQSPlCF6zB26f6h9RY0br6f8WH9h2SitF5G4nS0jVb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT26+1bOYaC4e3IY5z/zC2n8u3VbwGi68Fe+VIRS31NbZTbkF6bioypMO45DY8jpmnv+lp9jbBTHHPVFNRGnHmdQcUHE4TIk0raJ+ylpAzatOKerW0i3nJLLvSaNsyBKxCAMGrc85hlwI2taY+SYfbZRRFBZstZQXm56RFhpzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5U+dLCJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5U+dLCJ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b999d0c81so37204931fa.2
        for <git@vger.kernel.org>; Tue, 25 Nov 2025 00:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764060925; x=1764665725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQSPlCF6zB26f6h9RY0br6f8WH9h2SitF5G4nS0jVb8=;
        b=L5U+dLCJRGmae3W7f6fY7xJRfaEOnweXnOutp6yVOqOLKEm89mlCRhuvB2Uqdurw5D
         Q2pyzFt2ygqMfxmdRJWKcjcDYPu2M/3NiQ4r+5ljNfLiBxM54ZjxPF54dMWhygADPvFv
         /LOseLTGatrHbVGFC+Qc9IOOZU5QncLZpCVzzYGT8//O88fXGFn1AoMPDvjyhSAc69BG
         FDhnxe8qU5UL1LLUIXJIa2RAbe8koxlA0z4RgQwmVX35zOaOkZ2UP+P/dLwju5rIylmU
         9U8NOpjrC8AE9k335Ac6Tmi0FYK0eDuuTtKB5Fc6euHjQHsR5JpEc1VKjJt44gB8KBsp
         +trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764060925; x=1764665725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQSPlCF6zB26f6h9RY0br6f8WH9h2SitF5G4nS0jVb8=;
        b=JYdhcDe6bfo35HXrKvoa26ORzpGAyCLT21kOpbeHeyot1qIZFZ5FPXJWLnqBuwUttq
         ybIfiwgpug77IQQaFGjYTCGzATQ4YHpYYnCJLChuZ5wKdLjnE63KiIT/Romzyb5p/gN6
         yQ/E8pOD9wEMluXHbW9S7LSl2+WrL/Zt70UhNqV5NlL9bg6zKkIxnw9MOMsYM6z7seZd
         WNBiYuJ2NRz8d3aFH5B/5w5epHYdvgaQC4l+/TGYl8OhZOaBCtCZlzByME+vWSmbm3nb
         MZlkDKfYCSNZt+3BP0JVhPRQNfXggVpjM5qxp2PH75IdZQxgMujGcNRFcShBLeOKiIJy
         JnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa4Z4+1n+jmCz3TVXU1AcuKSMHgPmE5zxtugSptzCXZ8zo8jBnqQmaCJeHkLIj+EEEEqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTbBtJ6/+3ZBDen+85kka+MvFlIzpE8cnbQnj0kZMUByWQhce
	i+4EdLjPdH/aRQnq/tGYh5dJ9zBBYSYrP2UOqoJZpR8/3VQRIsHdi1LRo3/FSzUOqzZrdqyeQpz
	z01TeaQCwMfZO9lXXouAj3D2+Iy5LavA=
X-Gm-Gg: ASbGncvTHTQ3t4SFhOW0A0D5IcklfFQYjKKZYHTs3KJFUaRnHlbPPyMh09z5GSeuqsf
	Cmyln2+QiHbv/FJDf9pK15wbZdxIpURylPu66azoUZphLJddhoZFQfI16Uljpo90JCIKCjaZHKz
	vK7PCPhWgVG6plRej/Okpp7RqRmZCsN3gYJQg3hXBBall9D94haWVpQfvSQOgTru3tjhsMiFElI
	pLTpdCUaE74UVMKM4IgmKRiY+CBhjo3g+m1wJgWZqK4hVm7n9TfgFv10/ujWmt0ZMKY1YuY9Fph
	0jjTe5E=
X-Google-Smtp-Source: AGHT+IGbENq6ssYZe9p8G91uODGkR+9rqVbHjQSIntU07Ay+JPQy4Lbqi8lCuu22kL03ayd1SqqRZr24EG65EZ+qYUg=
X-Received: by 2002:a05:6512:3e1b:b0:594:25e6:8a61 with SMTP id
 2adb3069b0e04-596b4e58cd7mr889439e87.16.1764060924369; Tue, 25 Nov 2025
 00:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DEGR5XSM0EVG.27IMOKOK1O98Y@gmail.com> <9aa7cfdb-fc50-4ceb-936c-2ed441c462a3@kdbg.org>
 <CAPx1GvcXkXMpWgOyMWdfHXGEDJQY4wJrJV0p7LHBMeQFPMDHnQ@mail.gmail.com> <DEH58DEF5MGO.2CFIKCM2CAQY2@gmail.com>
In-Reply-To: <DEH58DEF5MGO.2CFIKCM2CAQY2@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 25 Nov 2025 00:55:12 -0800
X-Gm-Features: AWmQ_bnGSMNWO3DJNUtv3ZCQ1oHvYFogKjymSatZPn4lEMFjQMyK3kd8DKiWWcE
Message-ID: <CAPx1GveYzEs_iAo2oV2OgoGbJJfw4Q0VVzRApEwCOMUAAY_v1Q@mail.gmail.com>
Subject: Re: Filter smudge for secret restoration: no disk access?
To: Kache Hit <kache.hit@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 10:40=E2=80=AFAM Kache Hit <kache.hit@gmail.com> wr=
ote:
> I'm familiar with this practice, e.g. committing an `.env.template`
> which is used to create an `.env` file with secrets within.
>
> However, this is my dotfiles repo that includes `~/.config`. There are
> config files that store credentials right next to configuration, managed
> by software that I don't control.

My technique for this is that my dotfiles are in a repository where
they are named "profile", "bashrc", "gitconfig", and so on. These
get installed by my dotfiles-installer as $HOME/.profile, etc. The
installer (my own creation, tuned to my personal needs and not really
suitable for anyone else) builds the target files as needed.

(The thing probably needs a redesign and rewrite since newer
software messes with these files more dynamically at this point,
but I have not had to do that yet. So far I haven't needed to
do the "update repository from active files" part, which would
be harder.)

The reason for naming them without the leading dot is to
make it abundantly obvious during editing whether I'm on the
template or the actual config file.

As you've seen, there are more issues with going back in
history (to points where various files didn't exist yet). This
sidesteps most of these.

Chris
