Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F614F61
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708132974; cv=none; b=OhGtjEZA6/M7khZZuM15Pxw25GEc2WGXa81QX8u1gbIjL00UR58Yap8/qcsvx0EzjHLwFtTpSy5eZi0vgFO9veuJvHWSQZ4Ad3BaAqqbkAB+XfFSbvV3PHHpqYnTqUmhQyKVZKZS7ymCh4JpVcTYi4uZcJPaC9F1sO5aXKUCD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708132974; c=relaxed/simple;
	bh=qe1uBPDiKJjjDnoF7zIALoeJgkAMsbNloiXZbOgHUqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLGqdJLDGzBmAMKBPH9Ie4SbEQExNltNG7uQ3ClhWo7CF806vOGm5YYZAN0qwpoJ4EF+vdKyoxaD6V6Au4jHhY9HqSES4oXs0q2dI89tqjLKckbG8V/+/5Wk9ZMabix3wdimiRLcjpF8A6DUF3cV4Ws0YgKn04CTEpKyLi6sTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMKndPHr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMKndPHr"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so330511566b.0
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 17:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708132971; x=1708737771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAJ/TCL2Pal6766f0KyaInMpDcuJB2uMAwQJPixa6Ng=;
        b=fMKndPHrQYLnfgRyjfxXVxpHx3dFr+FKuJP9dyZzRY7FXReBGcLHyrppfbQkJCv3Sj
         EGZdu1lznIqowR3IQOtUfedNMkDRwg5ckU3GRdvKmSdr7/keqfsaI9IVTtpeLTCY27oe
         YSktquvtJt6TgYRKFAF/6W24Vz6v/lUcVv/28O1ptI6vktV8EoefbNKgBykfatEvDN9X
         3l/WiNOuwG87dsZy/n54h9M9BccUbSLRqFV3dhKbrxFK7rYkBeC/4H/BpDqr6tuMmwuC
         QaMqssd8DqCjj09AVSz3x1ZMkhZZgnJt7RgzA4cC2FFunoQW7bUocPwIY92ZeC4/Ht1w
         JEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708132971; x=1708737771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAJ/TCL2Pal6766f0KyaInMpDcuJB2uMAwQJPixa6Ng=;
        b=n8zI+1GVlncwAX2cbyHUW/AnqHmYYdxchoYWpUSatNG9PmR9qHzbv8PaaIP0MVRwBJ
         t3xU5Y/QLkGM3eTsu+ItvvZ5gQxqWuANWLcMfHBje1pEfmlt4iX8PZn6PHiNx1Z2UUDy
         dQOqQboEhyBAVkqepHLexxF47YryRHXPAjX8x0hBxJnVn8CH4lpUravc8B1K4lqNzSEg
         H1vdtCyCj1Lz2JqBtGU2Fs/YgbJHyjD59IW6OfJh7nEk+zDWR7QJg+W8NTXEuSWSJlc3
         jDnKvQbGnMGTCBHCMIIVn/0s/7ph2nT90zE3LUmRdW61pZVGRsfSfTN1mu86GNIMgzI4
         FtYw==
X-Forwarded-Encrypted: i=1; AJvYcCUoa+QZGWLTXmQPCCmGWwWgaOXEMgEN5MXZfUcVf8BZChxm5B7sWtiysiG+VQGmLQIDewbSVkuSjWaB4sfTwM/FmbTS
X-Gm-Message-State: AOJu0YwGS0MQlH2xhJTAEFcIf1dXa2yFY2TSFXab3mk7hcHTBbQKd4kW
	XiWqxdKrvDJ4WMLTzwy9WD18ljjAzCR7tPIVj34qthqJ1qpcDAYsdycRps/gGqTxQk9P6T28kZa
	r9qMjdjwQXZkWGv1D9yjip7qpdPURULyA
X-Google-Smtp-Source: AGHT+IHEOfvOt9Wi5nizyZyZqWE2pT6839EAqTp5N/0gaUuk4ypy5tAS/iiXjtgnsdq2s/JW1HkIRNkxWgKG1cpj1yQ=
X-Received: by 2002:a17:906:3b98:b0:a3d:b61b:cf64 with SMTP id
 u24-20020a1709063b9800b00a3db61bcf64mr3213798ejf.67.1708132970584; Fri, 16
 Feb 2024 17:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL=1hhwreG_W_Ch-B5DXioqjUsfkgjayNZbkCk7uOv3vc=TBSQ@mail.gmail.com>
 <6965c59e-8edd-4d91-81da-3600a61569a3@app.fastmail.com>
In-Reply-To: <6965c59e-8edd-4d91-81da-3600a61569a3@app.fastmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 16 Feb 2024 17:22:39 -0800
Message-ID: <CAPx1GvfVNOeMSJMFgJfGUA9MNBAyuvpwpKfX0ZH0JTJPwuxYnA@mail.gmail.com>
Subject: Re: Question about migrating a repository
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Gabor Urban <urbangabo@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:47=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
> Your repository is fine. There=E2=80=99s nothing that you need to do.

This is correct, but, if you'd like to make your local Git stop
mentioning `origin`
entirely, you can simply run:

    git remote remove origin

which will cause your (new) local Git repository to forget that it got
copied from
somewhere else.

You can shorten the word `remove` to just `rm` (as in the Linux/Unix
"remove file" command).

Chris
