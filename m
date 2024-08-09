Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C746167D98
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233003; cv=none; b=BrhCKm3YGCLJ/wfWHITtKUBp9q3P/BAgYIml4APPQVQIRO/TWlRvE9X9yjVGDQfQq/9TVQiHR+yfxbDNINQJxivMVZ7D4KxtI2td/A/Rpy8CMgIn0e3k0/4A20BddQmz87N8g9BcRhQ99aDq4qpQBTsmGkTP3Q84+rg7rXFnYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233003; c=relaxed/simple;
	bh=TqYgABhKJZXLO01v2pfU00wLNwsJMUxSl5+sty2iiOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEJq2xkubGWeCAHPAtZoD9HYvL3PazIfoMqi3MNL0c9JW6eM7XZJqIeq3C/9Bl53s9j3LO+OLzmYlFG2THHpr4EbTlZGsfeO2G+v/PMse51QhcFwLQtrV5n17GEjs0/2s/3fElw44gpYvswIFWBAUWRErYhNbYghC0TjAGfX7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3gi3zmV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3gi3zmV"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fee2bfd28so8451cf.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 12:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723233001; x=1723837801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2Q/nFkctRLXEUvHe3PlANmydthd8J4bVnQu9L5iXCA=;
        b=w3gi3zmVXcdOph75euBs6elWpG/aUt6A0M82a1E2U8HUuLEGjC896sZvQLxX1HQFzH
         50aEfgGYci5DaEWUa0HGRGnJfvwZl2uacpQbVhVQCrm6dRummv2mdc2GQA5nv1SQcrcv
         RtcKeUbfbqbXdSDWg3vVbNLMvGoY6lqiuLlzb2hzkrWyXG0Lm1oUwJKa6rABhCWb+zan
         D0/5QczsPFAvHOQ3CAM5Ry76Mo2r56riq4UVxKkNCfRxgEIIeTzrTzfdYBbzEPfYT4qe
         K73oH6J0UZF93uVTdMmF2tGo/6w2pYXEpk/bZysd34m9exYWzeUm5SNj0kIb9wz7Wl6d
         CU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723233001; x=1723837801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2Q/nFkctRLXEUvHe3PlANmydthd8J4bVnQu9L5iXCA=;
        b=WKSzrg0sDS8Mpe6FFM6cmO0dxhsEPvDGG2IvphUIUjpgDkDcygRJpff7wDFQIux2Wv
         euBMSXGHcVWwEjCZ6Yqk+482EQjLqQ4RwYCmXLj+mjEWI8y8ulgwJJaoklSVxs4nvMWj
         Wpg/mbeg7JW5I79Qxxk9x3N8ehmrjGspr5jl0Kxi6Wv6aDQK71DsdT30zbPCFnq8bD9g
         OLBSDTyrnH6wrrtGW4ZamOSODB0VXYwAjjkQ6BHs+G/pBzPVadPxKZeeb4cLR8nTJYKF
         zJ+iXd/P3fe3A4v9H8h6/bgKR/Fc/Oq00zKkf6gulPFgns4kfRHJQNV082Ksk3PIT7hY
         W+aA==
X-Gm-Message-State: AOJu0YyZUz7eNCelZP2H8HGMjRZSix7L4fNQxsYU3Jj2eiQey1Mz2DYL
	33U9OzjM5Ca50KwpqvJMSil05Nh5asM3mXGQUmNGlpozu3lDVNXQUZRB+TxtIqKtl+vuEFg4nf0
	tcrnSHh7iVl1fXpyb8HvFNr4R2WRoHhP7NuRvZeA6JMb+TXTdw7A5
X-Google-Smtp-Source: AGHT+IFSsMvfG6RmzOQ0Fe2txRtVqrLGKgnJycG7lD+tdNc24l2y93CIzSbFDVl9Arj8W9QGZkIjoSpGgilO5TYksCw=
X-Received: by 2002:a05:622a:7b89:b0:446:64ad:ee91 with SMTP id
 d75a77b69052e-4531c0186f2mr491131cf.20.1723233000452; Fri, 09 Aug 2024
 12:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo762frkz.fsf@gitster.g>
In-Reply-To: <xmqqo762frkz.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 9 Aug 2024 12:49:47 -0700
Message-ID: <CAJoAoZk15_O=qasf1RspWfECFX1gQLTXZVMCeP3=RMC14K=2sg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2024, #03; Thu, 8)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 5:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> [Cooking]
> [...]
> * es/doc-platform-support-policy (2024-08-02) 1 commit
>  - Documentation: add platform support policy
>
>  A policy document that describes platform support levels and
>  expectation on platform stakeholders has been introduced.
>
>  Will merge to 'next'?
>  source: <20240802221948.2367124-1-emilyshaffer@google.com>

I haven't heard back much on v5, just a few "I will review this soon"
and no update since then. Does that mean it's ready? Maybe other
what's cooking readers missed this series and want to take a look? :)

 - Emily
