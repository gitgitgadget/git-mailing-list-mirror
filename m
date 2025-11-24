Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574431987D
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009652; cv=none; b=pKFz/y6Rm2fuKPdZJXBWi40swV52E57DguTi6PsQS8T8Z6fuwH74OCVzQflStAtIU+EN13UlL6IhYKuYSHBHCfGlmu2z5JqqjSgrYp92+xu2SX5yQDrH0l8f60OIPXXfr3k9BddMvh/22yrTQl2Mozlc5Leh3PPVAf2LzZD6U7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009652; c=relaxed/simple;
	bh=D+cAmwyQkyyCuHM/P9VuxavzKh7SmDLxHo5vYfqJ38M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZmDvfxn9YJuU58XwJ1auSIB4Pev1wqRsBvz/JfcjcDXBsERkwa3WtIFNM+9W4pJ04Pk/oT6XixDVSg3f8qDq+dOj2H4dQwxo7NSImltU0q6t3WXXMJvwpscFgcK+Bf4TrbAjW8U67qDaScD20yuxGop73Q8lyjlV7AXuXrwsAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQdhnOPz; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQdhnOPz"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso2829842a12.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 10:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764009650; x=1764614450; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+cAmwyQkyyCuHM/P9VuxavzKh7SmDLxHo5vYfqJ38M=;
        b=HQdhnOPzAGtWa7ZNxEwoVNBoMnftJNIlhxwV1L8IYaTIh70S7OpUCkovUoIX9pbFI6
         X+YSdI748aVeN3RyqDtd81MbXN8+RglyMtJomC2wcDAyMGDahLxSqRf/Ro5xqYH3/Qfx
         2OlA6MNr2Cd636UbLD14HhNLM4gsBm1FlSufrqG39tXYSjuR1XyJL3M7ET2Bg4yUtT3A
         trnbQzJe3IJe/Xx9g0BlcPI9Ryj/r+SgQ3ybVOV9USywv+c5WNnhZ0OzIGZRCxRwnBi6
         v6maW4PJBfQQcL6hOZ1dKgvRmJ1jD8xuZjOUOhaUcw0TYUrcZrX/j+ZNkuWjtDFI29Xj
         Yzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764009650; x=1764614450;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+cAmwyQkyyCuHM/P9VuxavzKh7SmDLxHo5vYfqJ38M=;
        b=aq53fnuclt+TGCyTGG6UHM4CqSWQgsQWDiqorE8z69ULLlbnUnMwHeziuVniPMQMVo
         1DWYFhQLnDVAez6PmwfTIbMnRHFAcAy4KxuewiMBo63wv01i7HN0rL5gccCxisPXaQEU
         aUBjLRDf6pXbOLlIYOgAT/RKqnXT9bqSmtBtI2/ls+nJM6cmYp5XAz/M3kKpj2x0s8Ux
         /0KpyT0kInZqlTsPnRIt+43iUbY3NWy7zJ9ZzWm58Un0kUfge9+H4mdvpxeDpv339xrW
         toykDiC1GNvBE3hORynB4dWzHlw9SHAEYLjmu4WNEDYO+DyLj4wUTntVfyIp8VpCdwVz
         uFgw==
X-Forwarded-Encrypted: i=1; AJvYcCUSuC1/OLrJVRegL7XU045OCwVO21fmkoAWdfslX/BKaHqF9TXLeS5Dn2m5OtmVkaN4Flo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7WavtEiNbOKankfmnc7E7qZCeAxWP4UkuIpDvolj5kbknM+bb
	9yZjx6fBJvhgifGPErEHUapL5CHcCDV2YmtzGTt4RUiPB4ha0VOmT+fK
X-Gm-Gg: ASbGnct1fpDZ2QTyGGWsdnUvUfG95HGeKuQvC8btKUYqXqxy4Qsqu47A0H/brNGfB/R
	vfYpJZN3IsTSHUjGKZgFc5lFNxEohNUfAbGENMcWFrwjjR5BDfk+T41EOFSq+uGodByDwhF224G
	gqNhWDfxC6jCMR2NdSeJ9rh2H/DSX81/EDaMkDPjvRiRq57IsY9ZMq9gp7XBKeJCpshMTYwkysG
	EeC6NzH5yNOinW8KkCfr79BpCDglj7/IdJfXQ6n/ujttiUWgDxiLooD3BpgbrnFtLSA6Ra7oWOH
	fNhCKN0VWW+z84mUwokB/uxGNx+303TGBpHvjrjspJMF2yGG4OPe9OVqQveYEy7Gg4qsDwgLvZ4
	vE7bjTFw1Vs9zO4QxPad/h/FsSNIFrWZrJA2tKtvZS+/pPmHi1ADYhRUw1CulPBlYyxQmYBpUOq
	aWQ0Ty6gUe+S8GpeNRv3OOOyGPMZCmVtmzE2HY+LtHd5+U
X-Google-Smtp-Source: AGHT+IEKanRVccmEGeY7V7MvJ8d8UTRK3oYDLEEG+vXFKy0qFwDUxX+rzFcmpDOrty/tbZOwWDOo2Q==
X-Received: by 2002:a05:7300:3c1e:b0:2a4:3593:ddf0 with SMTP id 5a478bee46e88-2a719fbd09bmr7694101eec.29.1764009650212;
        Mon, 24 Nov 2025 10:40:50 -0800 (PST)
Received: from localhost (c-73-71-230-225.hsd1.ca.comcast.net. [73.71.230.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc5b122dsm54067520eec.5.2025.11.24.10.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 10:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Nov 2025 10:40:49 -0800
Message-Id: <DEH58DEF5MGO.2CFIKCM2CAQY2@gmail.com>
Cc: "Kache Hit" <kache.hit@gmail.com>, <git@vger.kernel.org>
Subject: Re: Filter smudge for secret restoration: no disk access?
From: "Kache Hit" <kache.hit@gmail.com>
To: "Chris Torek" <chris.torek@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>
X-Mailer: aerc 0.21.0
References: <DEGR5XSM0EVG.27IMOKOK1O98Y@gmail.com>
 <9aa7cfdb-fc50-4ceb-936c-2ed441c462a3@kdbg.org>
 <CAPx1GvcXkXMpWgOyMWdfHXGEDJQY4wJrJV0p7LHBMeQFPMDHnQ@mail.gmail.com>
In-Reply-To: <CAPx1GvcXkXMpWgOyMWdfHXGEDJQY4wJrJV0p7LHBMeQFPMDHnQ@mail.gmail.com>

On Mon Nov 24, 2025 at 1:01 AM PST, Johannes Sixt wrote:
> A smudge filter must read its stdin and write the result to stdout. The
> presence of %f in the configuration does not change this.
>
> The filter can inspect the file name it receives via the %f token (note:
> the *name* of the file, not the file itself) to draw additional hints
> how to process the data, but it still has to read stdin and write to stdo=
ut.

Yes, I underststand. I'm asking why it's necessary that smudge not read
from disk, even as it properly satisfies that stdin/stdout operation, as
in my Python implementation of `smudge()`

On Mon Nov 24, 2025 at 1:49 AM PST, Chris Torek wrote:
> For sanity purposes, if no other reasons, it might be wise to store a
> "file with secrets" under a file with a name such that it is **never**
> controlled by Git (i.e., always listed in a .gitignore or equivalent,
> or outside the working tree entirely), and to store instead, in Git, a
> "template file with secrets that are replaced". That way, the secrets
> either exist on disk (and are secret because Git is blind to them), or
> do not exist at all (and are therefore secret to Git). The template
> file controls the template and nothing else; the secret-data file has
> both secrets and, perhaps, data that are extracted from the
> Git-controlled file as well.
>
> In this manner, a "to-be-smudged" file named foo.template might
> control some external-to-Git manipulation of an invisible-to-Gt file
> named foo.secret, and no clean filter would be required at all, though
> one could inspect and strip secrets accidentally copied into a
> foo.template.

I'm familiar with this practice, e.g. committing an `.env.template`
which is used to create an `.env` file with secrets within.

However, this is my dotfiles repo that includes `~/.config`. There are
config files that store credentials right next to configuration, managed
by software that I don't control.

Although I could still apply that pattern by ignoring `foo.yml` and
committing a redacted `foo.template.yml`, I'd have to manually upstream
changes back to the template as the config file changes.

Another use case is to ignore changes to a specific line without losing
the working copy. Some software saves a volatile "last_updated_at" or
"last_opened" field into config that doesn't need to be committed. This
could also be useful for https://stackoverflow.com/questions/16244969
and https://stackoverflow.com/questions/61091219

- Kache
