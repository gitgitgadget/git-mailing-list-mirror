Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED630100B
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409268; cv=none; b=tfCi4K8l9jYQx1991U+5210fF5/Q/m1KK40IBcsXL90FxljAqa9ad2R3Q9HIFjk8HU3zhQv6++Jga3HxHyaUv1gFiqPVrx2oHBns13T/BNk1PZuQvzXQng7FtSdOreGe89UcYhZ2cQvmox+tZ8USyvHfrSdAws4Ff78bJjKW2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409268; c=relaxed/simple;
	bh=9XcEDsBxEX3haW4o1LM54AMPcFRvtaC6mCH8ukkebLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ea2n/LugQFe8XMGJAw1BMBhHGsOvJRoyNNZjCJIy8D3GqvtBb2o0gO4WTb+RiSTdrE8O3CL8drjwnkfB5Lpj6XYy6HSGOaKsGclAlCJI9bTbDA1Q24gBy56Z4a1GvmyYiKNJLX//DD4hqkiMZ35OpyX5EhA/QNsY0wrlZFnH+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv0i5cp2; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv0i5cp2"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-948fb1f6c44so95943139f.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 11:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763409265; x=1764014065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CM/P08srGPKYohAXzNwijf/WDaB6dS+TtEv5eX36eVs=;
        b=Gv0i5cp2jrXX4sRL6Ued7adXQqukpccboIGVEhb3U0WsKC3qlxfLrjcPfiBvGNrWzT
         g/71J4rwBMYgj9AOJ6hGEJ1/8KHqqFTs+9v7yx69+re9jz9F2yAsU0cSZpDVDO7acRFu
         apu65v/a/mb9Y9m/hjIugXEdDFR5l3jNfH+hxY2dUQggFZYOBwuaqUXrCqi6k9EsLcm3
         WWRGzHk9Sg4F2iXWx+whY9DmGLHwvfBwDWyC8kUEYprtCe8SERZTOWPSIj7oAW0zvLAZ
         oFO5OQF7jNSazUMNPkD7c18K87hIsN2P3J6YVaGwpj8XzwwTAriluoURszPMLLh6xSZz
         z2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763409265; x=1764014065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CM/P08srGPKYohAXzNwijf/WDaB6dS+TtEv5eX36eVs=;
        b=tZ9jVB+W513EhBVwhTMoJrPZZ75AE+1ntD35Lwr8RHPoiwRpYf5ajztmLM8e5vYS17
         7ZBQ4ekJY0XvxJWvjSdHamZlCNI52ikdKOEtgGT9oEaNVUmqHlAcajS8kWumd8sxS8Z/
         d0/AgV4jZAkWwcBlQ3D1cyEMYCBeUUAjBc77msvcohjmpiywt7wDV7bUupQsHR+SNebm
         q7GdRL9XQuo8SOqN7gulQ5tJl6F+PjyCbmW8XcmUym0EUxtTT9cUHTesePnTpTswD34D
         BdFQ3KHg9mFXfX7Kunpqulc29iP8jETK161HjwjbdgM8FkGtCYVz6tq/0ZjHuFZABtdv
         wTrA==
X-Forwarded-Encrypted: i=1; AJvYcCUgFmQCIt5PfhTxacoWxCuaKUkZkdcAaJZrV6acw8It4SjZRG0dkpSBEC02w2tvwIoZKZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/nPPD7noZqCAfpTJiS+DQGOv+5I0CXfPt5L9odmgA0jGE2+f
	T1kExriLi1fRV+Q/4ZmezauJH05Lo2jchD2ZSXLBMPcE7cgPGnS1uLCN0PAaF8vXfYXIpveWnHu
	bVT6VJz5Cm3feitC0Zp6uB8IcijgYjzo=
X-Gm-Gg: ASbGncsw0i4DXzSqaG0du/9NdHvlJzx+elHBSOKOPMispnJ+kbLA7fDi/yX+iOp/9b/
	rWBhzL1GM0RghTRvFarac/9mz/99eb2qeksq+Vzyi93mVui3vW4HS7YCLYd6FyWlCg+UPo5yw0C
	uv5vMiyGLo8Gsovmurz8ENofD6TT9IXA/UmGT2lgdLcTYuhwBcMt/wQZe4OtpstiSMrkqeRev++
	8ux9+Yd11YLhAPL1YBbv7t5lmKq8MFpCqdfUwkafRLgsgzFTqBb7rvrznM4ZTK2x9ECBs+jic7c
	eMCgpn0EoNruFcDIh8Y/qRv+pd2BbGX1GbNqvT8=
X-Google-Smtp-Source: AGHT+IH87btLjF1qnWUfsXCGJesxE5yYlBkgILL5iojjYuP03IZ7eCsndqAnyaWjuoGqdZuZOHoF3OWJb+7xncuuBAY=
X-Received: by 2002:a05:6638:35a7:b0:5b7:ba93:6821 with SMTP id
 8926c6da1cb9f-5b7c9d8e23cmr10185907173.9.1763409265104; Mon, 17 Nov 2025
 11:54:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
 <950236f0f812197e260159a688fc6f6fa61046c7.1762192908.git.gitgitgadget@gmail.com>
 <2983385e-daeb-40c0-a8bc-fb8bd3b744a6@app.fastmail.com> <CABPp-BGchyC6BB2p7p-6qHvwcu5AV+VCAdTeR247F0VamsJkbQ@mail.gmail.com>
 <xmqqfradbhgi.fsf@gitster.g>
In-Reply-To: <xmqqfradbhgi.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Nov 2025 11:54:13 -0800
X-Gm-Features: AWmQ_bnQ9lkPGSsw1365-jS13QEXILIQng3MG5twoo_Iy0k16M5OrHC_hXfCFfA
Message-ID: <CABPp-BGhU7KfRo9pS-PzRQea3YpU4qxG9iuJzxmWK=mvdhZrsw@mail.gmail.com>
Subject: Re: [PATCH 1/3] t6429: update comment to mention correct tool
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 5:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> > We could potentially just strike this second comment, since git repl=
ay
> >> > is a bonified built-in, but perhaps the explanation about why it foc=
uses
> >>
> >> s/bonified/bona fide/ ?
> >
> > Yep, good catch.  Got it fixed locally; will wait to see if any other
> > feedback comes in.
>
> And nothing seems to have happened since then.  I can amend the typo
> away if you want after the release before starting to merge topics
> down to 'next' again.

If it's easier for you to amend locally, that's great, but if it's
easier for you to have me send a re-rolled series, I've got it all
queued up and ready to go -- it's just this one typofix.  Sorry for
not getting it sent out a little sooner.
