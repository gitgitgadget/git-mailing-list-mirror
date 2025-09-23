Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078A323411
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632677; cv=none; b=ahh88VTDwjVMEKv3vAIkkEhjsqlE/6csLAV2ZeAYkJrA333CoGwyK4QoZ/qXYMs0ZF7WjRD+aUU9STPd/DquNBSyAH++7FK17hzIi/pL8hSj+6AlhK32X7hYiiMViL+0rrdYSvLVzUnxLieYlLk56ycrnCEYb7Th11Z03G4ORHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632677; c=relaxed/simple;
	bh=R0YqulTTQGO9c0t3/Fkw4djM37pbGK0LoiGzYe3BNuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYu3NbOa+w13KWBcgTYxJwmMHBOyz0wco1gMdz+GFiDr/loonMpEQ3AvU2I3YR2hzMMGTsbfjQoKGWyzsKBswO6cOuuvdig+/TsuWU43en/fsxCLhtCntf+uBqIGoVYW5RT0gPwLFEPJCYF9mF+92LN45i8ydBOlb6/zjBfJv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKzf5R/T; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKzf5R/T"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f4a8dfadcso6649231a12.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758632674; x=1759237474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0YqulTTQGO9c0t3/Fkw4djM37pbGK0LoiGzYe3BNuA=;
        b=BKzf5R/Tx50WVF69ac8KCx2+B1qVtjyHa8domugbahLRv10mMboJSM8qcMAdyNOn2A
         s1FpqPowNqQlp0e20VFoFH8ZOn6KyWYpIig4p8bK5Cw/foA1mkb927b5+YzJ3IcNx3f0
         QaR4MG+gol5/dZsffNBUFhbAdLfgsDn2HqVpCkf1wC8Ib1SHyKDoqrxPawzxGKxRvkM+
         Mn3SFoQuV5IQgUNm25MvaEba2o5v66iL3bylEW0OOKdJgX4keKh5jgRYOZPdjzJj5dJb
         splAsmtbtXst1Zmp9TPb8tQOkqQIb9+4+VH37TGqLaixXbDezV8jza5PxrTpT1i589Qy
         ipgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632674; x=1759237474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0YqulTTQGO9c0t3/Fkw4djM37pbGK0LoiGzYe3BNuA=;
        b=hH/DJMxLL7/hrplPnQ2THhvuD/ugZUrOuUgSRTX62LA7yAPBTvESONKsGfyGkAGyxr
         QTB6c/7Zf73ASP8A4UsuD16/3ZqIEb9QIESA/lQdi+cdZlHhVxtURCw9cFT+Tn6OgFLR
         ae0wRbcnKDa/3J1dAP3x/GFfeNUSsliCxTu/SnxdZq8lREJUXabG2Cfy5k9zmnr5btbQ
         3Pv3Q62FPTCGUhFLszw3tEITzvTqaW9D8Uwv63GX8juwr90grR6dPBy4oXEDJo/y4uys
         JR9qvn+3PKomGxPBAgnMdoV0or8zYrXFCK8B/J+FSQatJAgiX04gOftIZj8pdFI4Lin5
         n7cg==
X-Forwarded-Encrypted: i=1; AJvYcCX6AcpwjQfFReo1KyPIy/73m1EVGQl9O+Dzsh0HddcZjZu6rldWeUDgdaUqGfRLRarVBh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ArDjPipHixgrpAdsAL89DViPEd1JCcSoaobYT2/JVBRw9yXD
	bwJ9eRBv17ruJVr0gfPCHoUxs1K9u9h1PWjmrn9bJFki+Yyp8wr5/qi9s5tdrBCXFGO1KwBbwm4
	x8cb8scm1puJ8p92DnLbbTjt+f/GFvU2cZQ==
X-Gm-Gg: ASbGncscnT2/yZ85vybudCs7putloOopypgEzX6Ty1JnvX2iFzPTGgSO1C1P7bb6q/P
	7P6mUKPdzx0sQIkR3C7mJoJx5aoE+uVIj2e6wRFq9eWOel3DMB3HXGSMlPhNnEYj4ZMnuRLfyOK
	J+UCeMaoC/8/4SK5KkQhLn18dye/U+BWSkZJNiJwvBgsAVLfUAFfo9bGOZTsucGalmMEIG3EwkN
	sWJ9W+7yZRTZcOm17blFfTQsvgS/71iPA58LutSGA==
X-Google-Smtp-Source: AGHT+IHGQLzd9Fg26ZNAjO6peJHWU1vjbrXA4CSPHWWRn0OIyHkSghaViOAchokaAPGlEXB9MBuO9ZnUCbmwQS/bL4c=
X-Received: by 2002:a05:6402:27cb:b0:62c:9c9c:fec7 with SMTP id
 4fb4d7f45d1cf-634677b4ddemr2189052a12.14.1758632673763; Tue, 23 Sep 2025
 06:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f201082-07b5-44a1-88cf-d6db551a598c@digital-mercenaries.com>
 <fd993486-069b-445a-ae91-a0f149fd3ea8@app.fastmail.com> <f2ea5a0b-278f-460a-a0c0-00477f61e19d@digital-mercenaries.com>
In-Reply-To: <f2ea5a0b-278f-460a-a0c0-00477f61e19d@digital-mercenaries.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 23 Sep 2025 09:04:22 -0400
X-Gm-Features: AS18NWAtP3KQ1AYHObCl-v0bdhYwyagqzyV23KRGtVBBPGwdTP08D68W3F1dDms
Message-ID: <CALnO6CAkyScNvARtxSadUL+fNDQmbXke=+fF=O0cnsV8Biwtww@mail.gmail.com>
Subject: Re: I still use this/these
To: S0AndS0 of Digital Mercenaries LLC <S0AndS0@digital-mercenaries.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 8:56=E2=80=AFPM S0AndS0 of Digital Mercenaries LLC
<S0AndS0@digital-mercenaries.com> wrote:
>
> If I am not miss remembering plans to remove `--since` then is there a ne=
w
> equivalent for filtering logs over time?

I don't believe "--since" is deprecated: I can find no mention of such
a thing in Documentation/RelNotes.

--=20
D. Ben Knoble
