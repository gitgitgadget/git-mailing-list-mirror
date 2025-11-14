Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F602D73A3
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113970; cv=none; b=DTsTS4NRkTlMVOcNUq7uqs/Opk5/a8DmbACs7gFOwhYR1GofqpVtw4UCvGZXM+Hzkfu/kadBiGbkU3+TOX8NHNsWrcbmiWK+A4ASvtEWfdOchRvEoIqocPFZAL1QeSBt2uuctCixJR1hPYqGBEmKtoRThRbiAExhFoNnyU3XKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113970; c=relaxed/simple;
	bh=roXB/3Wlvk/RBOGssd95DjUhe3r/1t0U+dTUYK4Vo7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqGvrZc61ODVJCfDEeZ9eogN7Q0pSiaIJ9l7Rn7bfy3rIvkCPifgs8snSctLdSMK2dCo1bgnVcejwiGX2ldS3fOEivkrgl1ogmuUX3M/gCe8ntRY9oKBGTVbMLL6/Xj/8DqC69HxcUz08kIJzCxIoxO8yOo7/g93TulLU7nykPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/ga6CHx; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/ga6CHx"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-640f88b8613so1518447d50.2
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 01:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763113966; x=1763718766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqbfGgXgglXmPzBc4OArbyixbaDd+qNQnDrLoH0YsDc=;
        b=l/ga6CHxAi7uxzikWXwkdiW2VRDzjCXM/mZsifMeGJSBvWR3N8gtDEQZgZkuJeJkXh
         yzsFaVdIrEhUOq94QsSJ8DnTH8HS5b3qKXqOIcDAI5IXtdcOEDHbcmnHBghZble0RvBo
         MooiHZIpH05gKgCr5eXmLhwCw0YVnqZsdnreyYJkogFGt7ATcRtK1xXirpeQ2CibbUzz
         WP4ayR6J6/ajLV8V4XyP23gYy03d7MRrLBifh8sxcqwdGA9m1qxGLa1iuo3rxJ07lyT2
         PiUfq61y4klN05dd+ehjn19sZb7OihChCblUFFJj5XyPvUFrwJpgjxe/RxeDsxMBqE3u
         D4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763113966; x=1763718766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqbfGgXgglXmPzBc4OArbyixbaDd+qNQnDrLoH0YsDc=;
        b=Q1EEwmTIsTZgjMVi8D6oalYaHdYOIgPKMwm6Ni36CZ0ZR6HjBiDx37cQZRODLezqfF
         dVOZFE5M3Z/SG6V/HPoh8KhGQkB1Qvd7LzRzVmpAbLaOJh1kVdrw5XVCI7w9tmi1jLX0
         BHKAcbHmohe1Cows0dirokVV/FtkXUg+DCPHvUPb7bK0wmswFZQhOzJWkmJklnnEpxO9
         znN2jj9cJYftIEqoSyWgBLaL4uj0gxbYT8XqZFxYJohayzOBM6wTZyKfz65nNnCmElKO
         r8VZahXGe5PtEY19azm/GqlF9O1+ISGV+VsTTDeGF0V6TaHIAIuZBHUU04UfWsxTc5+H
         qRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdeCEN/onFSlMsqcd6JUWGfQkFulAzmkSjqtGAaYWUjaC9evw3aO+kzo2ZWyv9jPpvlBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQE1IGHy+JlZlrfi5oFO0NWzavQbul+vKk5MZ0qVu5EDtX8jg
	Xz+8wqYTEThT5SiME2fzJLAWnG9ubgvNa2SIcwBP6zs4VZCzZqkAyykgBwwOoyVRz1GbFBHtOso
	0OieZ2Y9L0jsPq8PlHNA/2W2X60Q1/5k=
X-Gm-Gg: ASbGnct735K9smAmpayK0DW1b0U5C7f6BKvE61GF7yy8hs57KueNHdNHW/i2pUleDEh
	V+mFvq4pmSPmb+cxCj2UqbS7l5G8lbVUEZmu8yrmudqXvpphaxheMX1WCHXQzyrhP4DvWdaigzn
	Zj9X/y/a7GAwzAXz734GAmCAtzIkhD0+Cn1vQqb+0XBGr5NIcgTyKnI9hBlN046CexTELB/FwyD
	SVyAX4DAVzYHde8RT6PI563erKUDA414uvC0dECEsIDLZLHtPJfr01NNxdhFoD7hMqGjVsRVU6k
	6zQpbXQ=
X-Google-Smtp-Source: AGHT+IFnPUwu2LRe3ilRSBhhS7y5rNXKcxyPiUtQl2PAoOvUCYjepEvFnD3dCvSXQBeMxmHSxdCsoNB0ihggu9fWa5Q=
X-Received: by 2002:a53:d058:0:10b0:63f:3194:16e4 with SMTP id
 956f58d0204a3-641e75b4e82mr1770673d50.24.1763113966447; Fri, 14 Nov 2025
 01:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763098804.git.worldhello.net@gmail.com> <8cb5d668-783f-4400-89b4-35054a6cbea0@app.fastmail.com>
In-Reply-To: <8cb5d668-783f-4400-89b4-35054a6cbea0@app.fastmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Fri, 14 Nov 2025 17:52:34 +0800
X-Gm-Features: AWmQ_bkBgbIP-PWx594H5YA-FaY38vKOeupbUEeN2_Xf3375ec8nRRLx_i4rk5g
Message-ID: <CANYiYbGyGKy=S6a3NJFyrv-bOZos+BXdR=nPXDT3W_dGxeiNPA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix misaligned output of git repo structure
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
	Justin Tobler <jltobler@gmail.com>, Alexander Shopov <ash@kambanaria.org>, 
	Mikel Forcada <mikel.forcada@gmail.com>, Ralf Thielow <ralf.thielow@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 3:41=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Fri, Nov 14, 2025, at 06:52, Jiang Xin wrote:
> > While localizing Git 2.52.0, I noticed that the output table from git
> > repo structure becomes misaligned when displaying UTF-8 characters. For
> > example:
> >
> >[snip]
> >
> > BTW, I used two AI coding tools (Claude Code and Gemini-CLI) to generat=
e
> > the commits, and added the "Co-developed-by" trailers in the commit
> > messages by using one of my opensource project:
>
> Is `Co-developed-by` supposed to have a different meaning than the more
> common `Co-authored-by`?

This is a very good question.

**Background**

At Alibaba Cloud, our development team uses a variety of AI coding tools,
including Cursor, Claude Code, Gemini-CLI, Lingma, and Qoder, etc. To
measure adoption=E2=80=94specifically, how many developers are using AI cod=
ing
tools and how much code is AI-generated=E2=80=94we needed a unified trackin=
g
mechanism compatible with all these tools. I chose to implement a git
commit-msg hook that automatically detects the AI coding tool responsible
for a commit based on environment variables at commit time.

**Why choose the Co-developed-by trailer for AI developer?**

Git repositories already use the Co-authored-by trailer to credit human
collaborators. Since any human developer, including co-authors, may use
AI coding tools to assist their work, introducing a distinct trailer
like Co-developed-by allows us to clearly differentiate between human
contributors and the AI tools they used. For example, the following
commit trailers indicate two human engineers and the respective AI
coding tools they employed:

    Co-developed-by: Cursor <noreply@cursor.com>
    Co-authored-by: Real Person <real.person@example.com>
    Co-developed-by: Gemini <noreply@developers.google.com>
    Signed-off-by: Me <me@example.com>

I noticed that Sasha Levin (NVIDIA) previously proposed adopting
the Co-developed-by trailer for the Linux kernel as well.

 - https://ostechnix.com/linux-kernel-ai-coding-assistants-rules-proposal/

--
Jiang Xin
