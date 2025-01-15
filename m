Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AE22F83F
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928549; cv=none; b=Jm6OqCcIshW4pdDpqWS/1l7C6oMpomjK4dyIW4ZF/U5kVG4uSq8JwDICM4GJhzSc0SmsLPTMIEK/fZi2ftI4MI2+9fpewW8d1fi+u3aXF/3XhNyTQWdxwFQJYew140liBawhFeKd1lE0Vc9KU5Mh7DRG60dHc0w9M7P/6N998yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928549; c=relaxed/simple;
	bh=gGbaXQb9SNWaLLvwvtlTKEVg+JkzmW/HhFLwbcD8D2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKSqe31F2n/nuEehthzvD680Sf7W1SdeTYmqpt9oG+zO6UTYPrPhQFCLNjiLXceTJChvdqxHnE51e7Q+JLTJF3oHX//XLz1rHWo0PLm4G0ExsK8ispQ1m17yPNoeJluMi6j/xGnrIM1RCtKQ1Vd7jdc4oTwCfp8FsZR+6MW1apM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxgRDyEd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxgRDyEd"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso12959250a12.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 00:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736928546; x=1737533346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ADhts+nHDH5aT7PFzKZ2oVxNr33FvVbqsPlFB3Pr+rM=;
        b=CxgRDyEdz/UasH7STr7BLlWd19A3uYjs7yxYbq9Xcd/yd4NoC5idLBz1asvRqjiEyV
         eht16xlPfk6xdNShCM/DKTm7DEtAJ+4G2kSzk9y4QnbbJd040he//5RqBkJQLDO81pnf
         qooeKOl4HJXCvx744b1DO1YQpG8pJnw73JJEl1U1lxPcqajb0N4ZZz8z0OlqSM2HpyTE
         gU69W98IJcgZ1hBI9ROWZNXP9ttqGfthXFDz5oynj9u/jlw8wPMljG9rAwNQIQlo7IPb
         Mz7MxPG4Z/zcTFqZofMbie6ExfaAxLMQP1RflTzxWmdotD3ZBBiIo6iMTqG7b1gcsqk4
         Se8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736928546; x=1737533346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADhts+nHDH5aT7PFzKZ2oVxNr33FvVbqsPlFB3Pr+rM=;
        b=AtZ/o2HILVEImRGmjyuqJJzekkpX3HGCPZRK+pbpGhaxd/RwSxfga7K8pD/2FyqzON
         wni3cF4YvtaPlO9J4YbhNSXqfa7iTkah4MhDrBhFAf6tgHjqXaL4muWGedtvHd6d2qUV
         yrPkvjbVKsLEi7ZmKEJ59ia9NJw23bh7CJhFA5805VpQkDRA1Sblv8dQ5vEnNKuF1lAb
         2jPnX9bfRhGThdhu9hN5430tQBJQMHqPUrIEwnPURgVvZl0B5HXsP4LKa6TlYtsxiS9R
         NOn3H9rGmB+r+M5jNjw8J7nHsjgQTcChrMypVnT17naKBpTlWLSJFQVqi9oJNlOssl5u
         kzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqIAw323aVMPbTnWd4hRd5MRelb+bLPkSx3jKuVY3WhCQy0vuWHbnLqVCX3JOhx1omTsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkTBmQJghesQ6osXJu9G9aSk+NNV6mDLMrhREisk2AlgfLP4f
	X0OdNcr0GlZWoQ6z5W8W1hmk42wXGnOsXM7KNF1hjdDu60GOm5FFcTt7AxW0JB7QSHY4K15OoUB
	PntnUvuWjbQv6JwH9gUle8Hc4LwI=
X-Gm-Gg: ASbGncuhSNqjPLtg6MNsbJe8592ApUX+2VrAvTF2eYF6vm3XZDsyz8ztVC5KA6PXzy5
	6h3QVeRA3vfyVoSgySvcsrTf4zfgDtjVuFvlyKw==
X-Google-Smtp-Source: AGHT+IF3SGTK5M8L7sbet9jkdYQ6bw8Th/FnEs5Qf5xE6iOM4IBVkyXZniSQMmYydoSgto+do/b5Q02VfYISdp3VAGE=
X-Received: by 2002:a05:6402:194c:b0:5d4:3105:c929 with SMTP id
 4fb4d7f45d1cf-5d972e4786fmr23931425a12.23.1736928545702; Wed, 15 Jan 2025
 00:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48438876fb42a889110e100a6c42ca84e93aac49.1733011259.git.me@ttaylorr.com>
 <20241201213439.GA145938@coredump.intra.peff.net>
In-Reply-To: <20241201213439.GA145938@coredump.intra.peff.net>
From: ZheNing Hu <adlternative@gmail.com>
Date: Wed, 15 Jan 2025 16:08:54 +0800
X-Gm-Features: AbW1kvbGcmH6C5Y3PVC2dueW8AUYRFEr4cstGz-296RHTxFULcLzTdTJeoSXuHY
Message-ID: <CAOLTT8R3UULA9xrv8FZcTsTE1qvsToU=WgOEWMfuO0vq5ztUAw@mail.gmail.com>
Subject: Re: [PATCH] builtin/repack.c: prune unreachable objects with `--expire-to`
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

> OK, so we are adding the containing directory as an alternate. That
> gives me two concerns:
>
>   1. The expire-to string is something like "path/to/objects/pack/pack",
>      and we'll have created "path/to/objects/pack/pack-<hash>.pack"
>      Using dirname() strips that down to "path/to/objects/pack". OK. And
>      then we manually strip "pack/" off the end, which we have to do to
>      get the "base" objects/ directory.
>
>      But what if the path given by the user via --expire-to doesn't look
>      like an object directory? I.e., does not end in "pack/"? Then this
>      feature would not work at all.
>
>      Should we be mentioning this in the git-repack docs?
>
>      As an aside, I think the current --expire-to docs are misleading.
>      They say:
>
>        --expire-to=<dir>
>            Write a cruft pack containing pruned objects (if any) to the
>            directory <dir>. [...]
>
>      But that isn't right. It is not a <dir> but a <base-name> similar
>      to the one that pack-objects takes. If you do --expire-to=some/dir,
>      then you'll get some/dir-<hash>.pack.
>

I agree. The `--expire-to=<dir>` option can easily cause confusion for users.
For example, using `--expire-to=xxx.git/objects/pack` will actually generate
files like xxx.git/objects/pack-*.{mtimes,idx,pack} instead of placing them
in xxx.git/objects/pack/pack-*.{mtimes,idx,pack}.

--
ZheNing Hu
