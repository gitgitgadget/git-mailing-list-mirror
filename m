Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD332BF3D
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604523; cv=none; b=iYJgq1zdEG15AdKsxeP3ZiX4paomphPZSMxBEi9viFwx2wsDZakZgkRI1TyHo0Epk1JfZyAsVViebbqLJjIvsZgvo0WH8XJlNrI548+jOkBDzoomWj/NqOFxl2pvw0YBzwd+MvotzwD8MjYwFLlCN6bbp++KYV7iXRgbdcwfkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604523; c=relaxed/simple;
	bh=U0R3l+GS6VTZwomRxnEhZJlsYjYPYvuu/83fwZ+jQJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpI8Z8EJPpuDPIEFAjKVIvcoTTtS6GkCn3oWwWg6gcypioLPzxGQawLHCQByhvJvToQPQy3NgWAwZlTy7znKJsCDJJIo+r8v1299vMewHWmi4MgVhYRHT2ahAIwYbDUci24sFaWttFnDT9YDo2NfpR4XusN8AaUFreKRb51oYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKGf0Esq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKGf0Esq"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59583505988so2749906e87.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 01:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767604519; x=1768209319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3fxd/zMBSd4dzK3M4vsj/Cwo3gIcTbhcA5j9GfStAQ=;
        b=TKGf0Esq4a4Ca/mbz68nFDUqs97OONhYBi2G6q23hXkVXopR95geWpMN8lRI9OUrZG
         l0sEa/VPPrMb0XpaJ8nqE7I/lsD2syenu9aJE7bP7TnHWs++9rN6p9UEto/ma0ahvOI7
         iYctQIJ6ipEjAzv8n0+8mksyw+Frpum97w/oEcdW6W+vZnEz/TuS9Pf1ISSm39JXVqi6
         yrQNAl10idqC1XwBL4EC9MNrq+g9m3u/iMBZUWeKRI9tcgVZr8lAXfwgIjFUb8DQ0qkA
         uhSbIX1x6QaxuAA/DOfkBVSt9U5sAcKLZk/KUPyY5ZMNrZHfQYh7ZByN4eH6+cPUhUiS
         g4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767604520; x=1768209320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b3fxd/zMBSd4dzK3M4vsj/Cwo3gIcTbhcA5j9GfStAQ=;
        b=vTO9BkKcVLo6jLt/exfNGhoZW63ZPlRKiWoUe7OK51GGpxRGVKssrIVeYCcCFw/he0
         OyxDHCmF36BQXUBEiJwFx1xF1iFXHdTSsSUmYVbOCvu+Ru31N7Gaw2LetjNp0RuNGhUA
         L+ZBPsBPswsRiNM4na30Df/kAuP95olWceCjqJnKigNJYq3tPA1OXr4/oLI5kWqdsgmF
         Lr2EuVKgNUsvN2G9MKVw/3cizKQxXVd53I7GENtCcNGFSvl4Ev9KpJ/fpGnbGqVG2EC8
         AcaZebzRd+rMTvwTkBAQuecCZDHnd0m/5k2vIE+/j9YJF2n8ZrugQJPbgydxX8gy7BdL
         PP0g==
X-Gm-Message-State: AOJu0YzD7GCKA4F8XV62CRG7NKM8QZCRx8gxeJsmWHHToaz1ZgiQrw8m
	tJoRhQBAMdik9P18NGaLZWeVp2bE9wA9yqVH7zkWMldDy5UUdiRgup5OB+HmNA==
X-Gm-Gg: AY/fxX41jBL12TUDXhriKzGxx9+Kzh12vlDqFGUMEB9ytUu75ZdNDobV1SFhdkGSByp
	gQ4ZPEccqRBTl3hoDzn0PQOQyuWbvv+MFCrEhMWdMxm1cShyCM1HB9GYS252nX1h/g+i6UUkSyR
	MQiEzE43WylczBcPDVBX2L6hsLwwrCawJQ+XfY2p4jVcYDAQIc7gOCccbCSvCHV2JvmpnR42pLK
	w+nBq9LUB5ohOKDZBl52txzoy0I4IsTvxb+c6bnheAGC4BAR5zZ59Bwt/LzO7DS7ir40dKUJ/WY
	wRgKo0SHFC9xAheN+hnd0sDAHOtxweerwFmP++RHSTx7Is9fYzRV0co1MmDT6LPvSHBG3qTok0T
	j42y0AH0PiMhwXENQRq3Jj1J4fhcaHtfQJnEm4H2LiywA62QYM78CHqe9uW/rejoh40rPdPbuPR
	IALM4qlCHSZwtsv9kkl+p0aM8yrnLp5zSqox0fkvQR6q6ga+oWIvNJsh0lzo9i8K5LZigaOgRwB
	U5KqmcQZwPmpBY=
X-Google-Smtp-Source: AGHT+IFkXLS3fcEL6+p13ofaKP1lecBaotEAz3MIYYubDdAtpOJr1xc1wwCT7o7yVWV2XXdUYWD7jQ==
X-Received: by 2002:a05:6512:3a92:b0:59b:2086:2c with SMTP id 2adb3069b0e04-59b56586939mr1935959e87.8.1767604519278;
        Mon, 05 Jan 2026 01:15:19 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812264c8e9sm131078411fa.33.2026.01.05.01.15.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Jan 2026 01:15:18 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Another look?
Date: Mon,  5 Jan 2026 10:15:17 +0100
Message-Id: <20260105091517.86301-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqa4ysn7a5.fsf@gitster.g>
References: <xmqqa4ysn7a5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > -     } else if (!sti) {
> > -             strbuf_addf(sb,
> > -                     _("Your branch is up to date with '%s'.\n"),
> > -                     base);
> > -     } else if (abf == AHEAD_BEHIND_QUICK) {
> > +     if (abf == AHEAD_BEHIND_QUICK) {
> >               strbuf_addf(sb,
> >                           _("Your branch and '%s' refer to different commits.\n"),
> > -                         base);
> > +                         branch_name);
> >               if (advice_enabled(ADVICE_STATUS_HINTS))
> >                       strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
> >                                   "git status --ahead-behind");
> > +     } else if (!ours && !theirs) {
> > +             strbuf_addf(sb,
> > +                     _("Your branch is up to date with '%s'.\n"),
> > +                     branch_name);
>
> We used to check if there is nothing to report (i.e., !sti is a
> signal from stat_tracking_info() that there are no differences
> between the branches) and reported that first, so when abf was
> checked, we knew that there are some differences.  Now, your patch
> reverses the order so whether there is or is not a change, abf
> codepath will always report "you have differences!".

Agreed! This change was done to get rid of sti as a parameter. Maybe I
misunderstood your previous comment around the sti.

I will bring back sti as a parameter to ’format_branch_comparison’ now,
I don’t see any other way to solve this.


Harald
