Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF41E1C1A
	for <git@vger.kernel.org>; Wed,  7 May 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642549; cv=none; b=u0+wX4pAvmSQgFFuAelZ4Pr2qA/xdRh/McdQq43jiEzxEvfZh6u8SlCNfOXkCQAfc0mmANTFU3sUGXgrNNjlx4e0qoXUB6pUrfTy3sqkMKlApvhbNJDwNqxLndkVQa676lcxovJpVOdfds2lUOEB1rw3601u60+UlV2gS/DKQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642549; c=relaxed/simple;
	bh=U2+qtKXIkeG7v4Tu/A3y1bXkeUcAtdJV7YXlksR3stI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9cCr31J0G886o+lUqCw4W9QVdWXBIAU3RoNx7M6xmCs2y2j3jai+ISHnncm2PdYN9c6rndrTFV+MMeZgH7Wotu5MHlnKcqfSiGSpSQkDbiNEibH2ibSws1NIs8vXogMMCaTjaXMDGZIipIGr8CiWPtmdoMYoAhRhmAjJcU9jv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPThuxpk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPThuxpk"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-549967c72bcso180197e87.3
        for <git@vger.kernel.org>; Wed, 07 May 2025 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746642546; x=1747247346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2+qtKXIkeG7v4Tu/A3y1bXkeUcAtdJV7YXlksR3stI=;
        b=MPThuxpkQvOC5NC1cESNoK+ZLa6gYXb9hr1MQb5E03OjcDgOsSO7ARQb2/W/Ih+/KW
         7CZxPdjv1VPb2vnTxg1eO3QKlM0lGCNsPwyHdiBANsG99RA6rii9D+TGAijgpB3hAUfi
         KUmCh9mf3w5N18hgmRPGRQ/dzvxcZVjHpxqZnUoAYo/ASmFgulsd4slMo/5aHdqCP4hj
         LDv/wSq+x4TEmPDxLhI60GL/8/bmxc+QLQr1qnVdLcBtpbaRKUbiRe0Z2WLfPQ0Jxoei
         MkEU2lvgC5XXwiFHzbVNyEMIE0F+H4o+1cAFZAFJsqDT28V3p9H0D9SRQ7mOkhxDh7ad
         S7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746642546; x=1747247346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2+qtKXIkeG7v4Tu/A3y1bXkeUcAtdJV7YXlksR3stI=;
        b=xP/DJg3V6Blw41BfXcFkLb8ncpm3+qbsya1aufe9q06kVq4HyASniHu0DFsiPhsVmf
         J0FDdBTFbBWdV4x6j7bzsG6f9WnNYOygZAdizMJJP/P4p+ZoLYrCg2iIG86SU7hNzuuk
         ADDl0lVbxhFflBy425461iy8pOY4dC14hOnhIUiHNu6JneOCwrA+gc2fCL9sA0SbkR8x
         zoCWGVcHLTO5tEnueXhyVCVpm3lNLpqLcLkpL3eBbCzVbNprClRyI5e0eZlZo1r8/LGH
         vvuW9p7tRnmLT6Dd+PXMiKXAACPBJeq+cUo7BdAWALVsYZdTmlDSWdh/htRqwNP9nk2b
         Yd1w==
X-Forwarded-Encrypted: i=1; AJvYcCV7UUHxb3Wf8imd8tEe8IbokCSGEtd8UTUnbPmCp5OYuUrw16kEgf27LWhjV/vuPUNuDnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyai1CseOY42QA3nPtMJyacxp+A97niVpcLuJfUj7ytDyayZJn4
	AizZJ7JrO6KmJplIDvC6Uj5GZxsKC4WZvkUPDcDKHTzTQCc5QdtJMRzTl95vPAxRfgjc40iNgjU
	J6FEgkOBiu8pkuv7UxcN72VxdsG8=
X-Gm-Gg: ASbGnctBrgm43vDkz9sn8+yfTRsO+V84ArPtdIiFpOz6u1qO3FMK1UcoT0Ry3xun4tm
	9tip0crx+8e0Sp0uA9iWJzTzXTSzZ/N9bGDO0/7EtKm8zEkcPVFcmkLg7UxqjSgPwqCpaEfWJuN
	imtAbb80/j35anO7MiRXlUUILHF9g=
X-Google-Smtp-Source: AGHT+IHuFMbNwGcg0NvbtMU5QxSRE7f1KuGKYVlh2Zx52BqylNOl+sfqN6cNw0HxRPiwKwQ97P2FoPmShT0JXIrE96k=
X-Received: by 2002:a05:6512:130b:b0:54e:8172:fb6e with SMTP id
 2adb3069b0e04-54fbfc53716mr78870e87.54.1746642545671; Wed, 07 May 2025
 11:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <7700eb173e73bb240852dc1c7ce26f3d1f95d8ca.1746436719.git.gitgitgadget@gmail.com>
 <61fe7690-87af-4159-be87-cd39c09475fe@gmail.com> <xmqq8qn8cn0q.fsf@gitster.g>
In-Reply-To: <xmqq8qn8cn0q.fsf@gitster.g>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Wed, 7 May 2025 19:28:54 +0100
X-Gm-Features: ATxdqUE_tnghpkDyLpjNovqZdGGzQJbzncF6WwNv8_rTsGjHcQ0GsP90kJObQoA
Message-ID: <CAP9jKjGEDY78MSrZVS2FxAoikPZpGazqem2XHDVmXqMjcox6yg@mail.gmail.com>
Subject: Re: [PATCH 2/3] add-patch: add diff.context command line overrides
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I think I may be misunderstanding, so I'll elaborate on what I
personally intended my documentation to mean.

When I put in the documentation "implies --interactive/--patch" it
reads to me as "this assumes you are also using either --interactive
or --patch and that if you don't specify one or the other it will do
nothing or possibly error (which is what I chose in the end, based on
the initial discussion in a separate thread)". I didn't think it would
read as "you must have both settings" or "if you don't specify these
the command will assume it as if you had and effectively act as if you
had".

I'm not sure if the wording was confusing or it generally has
different meanings to others so perhaps that might clarify at least
what I intended :)
