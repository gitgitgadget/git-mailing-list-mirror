Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85710E1
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9wf9Yiz"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e766937ddso5472429e87.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704933249; x=1705538049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZFUUFdysbjrpm8q8vuNaggfCdfUVfNRWHXZurTrmwg=;
        b=d9wf9Yizrss/0m+bxjW9C3xqKEi4VLPnUkHTDldjdN9D7IDiyjDTTopZ2hTednFswC
         kcQBqEDQaP8vFUY6OsLSsD2tCkCXdmFif06glqeuzDSVuLznXw5EK4fbYbS4hJFx44wz
         nuN8p/f53PnN1v1pwS0qf6eOPF6xM8wRyBNAmkluEqZ+gZpGVadClMuK9nWsAWIbZgZu
         oJ2drWoljDdCwcepFODkl2EgnZeXBkWcPR+K3rhYbyZzcKROkMzXbz0fU8c8bttGCwPz
         TGfLKfTqR50cjGY3KKNLeUsoa00vv1X/efztt14N/5ZLNKGote6EEG9/yO3ElqhCar6Y
         Spjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704933249; x=1705538049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZFUUFdysbjrpm8q8vuNaggfCdfUVfNRWHXZurTrmwg=;
        b=bTncfN55seb2Qfdo65Pk0DIuwdO+B9JF50+zxmUj01P5dOadfdZv79rwMcUEFkQCNi
         eyaZSumKJEiGNdWjvydp7lveCyosddFAe0N+nhZ8GbjqQFS0xGR+tezsmYLARLAWnPcp
         ZZ3F9md+CogTJE9E6lIeViq4GXLsnGKK0cno8qk7FxFRSAP1+1enV+aa8hm4dxjQCl/j
         op/Nl70nFOYYgsAH8B3AVoH5bPw+kbD47eR4ksEEoNkYyOFO5rQNHCnrHOL90yuofhoD
         e9Sr2NLUpkLegd1bGCuMX+245HLiLzMAQEi9AyX/mokF5PegfSx2PPNPfVJAw5s5DbWj
         UUGw==
X-Gm-Message-State: AOJu0Yxhyn+EBe80kZ4eMSukThsw2Y8jZ3o5EEVnHI5Znt0VaFfOVqGw
	ekxlxOkathymJYK3KKUWbjMnLbJTNWSFWxstsbfn4R4q
X-Google-Smtp-Source: AGHT+IEwriJ+QtRkp+VxKNAz+nKhzyuqG3KkNZM+uP2prDe5Wwtm3/9qF5d/HixLVfamm6AmlbhKGAImHbuum+M+J5o=
X-Received: by 2002:a05:6512:20ce:b0:50e:6ee0:8678 with SMTP id
 u14-20020a05651220ce00b0050e6ee08678mr85296lfr.65.1704933248560; Wed, 10 Jan
 2024 16:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
In-Reply-To: <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 10 Jan 2024 16:33:56 -0800
Message-ID: <CABPp-BH3sva=CNtx8YFGP4Egyau-hR+7njZPFEd-DRTw91BK2w@mail.gmail.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
To: Dragan Simic <dsimic@manjaro.org>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:57=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Thus, Git should probably follow the same approach of not converting the
> already existing code

I disagree with this.  I saw significant performance improvements
through converting some existing Git code to Rust.  Granted, it was
only a small amount of code, but the performance benefits I saw
suggested we'd see more by also doing similar conversions elsewhere.
(Note that I kept the old C code and then conditionally compiled
either Rust or C versions of what I was converting.)

Further, I found a really old bug from this effort as well[1], and I
find it extremely unlikely that I would have found that bug otherwise.
So, converting to Rust can even improve our existing C code.

>, but frankly, I don't see what would actually be
> the "new leafs" written in Rust.

In addition to some of the examples Junio mentioned elsewhere, I think
new toplevel commands, like git-replay, would qualify.


[1] Yeah, I really need to dig the patch out and send it in.  I'll do
so shortly.
