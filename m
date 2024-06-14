Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272D3D66
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386883; cv=none; b=cv3GiHdwrvI0qq57+vQJUYxmbeXyq/FuLdyRJRcUhmCumDbYpehuErT+1xsFbcrD4GI9pXVWZEgvIFTKSgZoFsZJ/xC5Do35HjitE+1bzcPyfs2Kf4imfNC7JI06ttpW+HDZiNcfusO/8FNv4OB3KGPtX/eqwG2cz/g5ZDgTG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386883; c=relaxed/simple;
	bh=SSYBsavZS6O5elN5ZKaHq3+3tgQI5EJMkGlrAvpXsp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxDFRlzAH3+UZmIqrkLOLunl+5INWa5hp03eysk3+wYCRux2i3F1hHeWmpapZxZP3NSPxFA9jX0EUN5RPcGp0qDeoYJifvkbPk3Re6dhD9E2/s2a6jPMXKTjzEdp1+ZvsfYdRk//BmuvIOLnRhAIpgR0gB1bOCmERj4MGPudWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4IIgAw8; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4IIgAw8"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7eb895539e3so96333539f.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718386881; x=1718991681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brSvAq6m5bJHoxG/YxzMmw7sKpLdTL3q7ZESGbWrmNw=;
        b=H4IIgAw8vMvf9CVggAxL4lufHDFffnW+GS1+9ZjTsj2027Dx7KOz/yZQKEDYEn+LbG
         dRPY2edGGU8juyyx5gB5mPgZ/les0bEggsqx2kFOQaf97GakAGyQyqJXV+WHla8stig3
         VhZh+Do8J/cL8qAulLva4Ou/B5GzXpZ1IZDNSuyGo1sVms4zn8eYlz1WP2d2yxVmB7xl
         DaiVXGgAZ6iV/m6fWtzpQUYRgZk+e56sCzokOI9fJFnBCfUXFXnF7MZOMIYgts3Qhkwb
         UTLl+YxpxrZ7pAtbqNq1JsUkqotnMlxLed8tPymKCHJ9AgB9vk+RpSgLKlGmXYBMNqIU
         t5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718386881; x=1718991681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brSvAq6m5bJHoxG/YxzMmw7sKpLdTL3q7ZESGbWrmNw=;
        b=h0evMvtVGCwC5mtWeSzRlUHw7c3J/mUn8q4xYrimrfJ7iWVXSwbeMEcfsKvtda8aA6
         DiK0I/3IPJPoYoaeQfJ0t2a5K7AcGihzEx/ozGipEhg6Jb4D3UTJzUbb5Lgx4b9JuEog
         cUZfvIe3olLfMAYGJD3LzyGp4N+9mBAuafdgO1p2wN5hhNxFxl7TXCpFO3kew0mhb/H5
         WXRSutc167oNq7EJfYinH2C+Jk4nY+r8da3XHSQ3WUfhJRZ33eAsXoQNRobMLXBCeDVf
         D5q08q4FxOCqlgrJNuXEYXvQ+SbiBT8vmg0LwX7W0aJbrpY82jqFwi8ewRfRhIPtNVpq
         cQow==
X-Forwarded-Encrypted: i=1; AJvYcCXI2N4qZSdUc+5GMadFOj14wjpdBSZmzkwNAhV4TkNCR2s5JD+rgGq5JEpbzZm7ZdpxJ4ERuVSkiK3gCYIMeIzhdraZ
X-Gm-Message-State: AOJu0YyYkhH0vOZIucW35A1BzLJuIet8ABEpUo5i/FnP1Q+Gdexj6dUE
	b07DCMKI0pdotr0FvwCOIcbV0RgwsJsSaEVl7NVd5m6q+I8P70BMnhH4CS6U4h2iedYqIyOCy2M
	54AKjbOYYDoAGAufgr2oNLTX6FerItg==
X-Google-Smtp-Source: AGHT+IHNSulsYzaflud/o3oz9ffoVHGGu+47s/CbE95Rj7/o7lGlyk2mxe7UOs/78WbjQRba/kUYJFCjJERLRqKT/Ks=
X-Received: by 2002:a05:6602:3426:b0:7eb:8afa:ecf8 with SMTP id
 ca18e2360f4ac-7ebeb4d5eb9mr360400939f.11.1718386881197; Fri, 14 Jun 2024
 10:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717712358.git.me@ttaylorr.com> <20240608104821.GF2659849@coredump.intra.peff.net>
In-Reply-To: <20240608104821.GF2659849@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Jun 2024 17:41:09 +0000
Message-ID: <CABPp-BFvGa5KhoBs6n+mzka9LoHe3-Gx0JeAYjDQjaB=TyXGkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] commit-graph/server-info: use tempfile.h in more places
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 3:48=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jun 06, 2024 at 06:19:21PM -0400, Taylor Blau wrote:
>
> > Looking at the remaining uses of mkstemp(), the remaining class of
> > callers that don't use the tempfile.h API are for creating temporary
> > .idx, .rev files, and similar. My personal feeling is that we should
> > apply similar treatment there, since these files are generated based on
> > .pack data, and thus keeping around temporary copies is unnecessary whe=
n
> > they can be regenerated.
>
> And actual loose object and pack files themselves, I think.
[...]
> So I'd argue that we should just treat object/pack tempfiles like the
> rest, and delete them if they don't make it all the way to the rename
> step. If we really want to support debugging, we could perhaps provide
> a run-time knob to leave them in place (and maybe even have it apply to
> _all_ tempfiles).
>
> But that is all way beyond your series, and I don't think there is any
> urgent need to tackle it.

Regardless, it provides more context around the exact questions I had
while reading the series.  Everything in the series looked fine to me,
but I wondered about packs and loose objects and why those are
different.  Anyway, I like your suggestions as a long term goal.
(Perhaps handling packs and loose objects with tempfiles could serve
as good microprojects?)
