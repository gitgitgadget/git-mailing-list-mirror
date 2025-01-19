Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAFB7DA82
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737319168; cv=none; b=nccLxK3ruLYiQIj0cV00AAaPfEWl2Jp3Lql2S+MoYCxvb3YED3nNA2fJYU4uh3O224cpOhlx3hza51AfdlWg+kIljvSOkgzQpnX4IMi5nZ3oEAqWInCVCfb15B3KJDqmA1t+XWa/cS6StXo3ftnWKaXDCdp7a4EotKTTGHbi5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737319168; c=relaxed/simple;
	bh=Wd1DF2epVjOPJTw+beQSlwmGOpDqWtcqsAib4wZ5Yd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=m8s+DV4QxMr/2t1ygTisytUuj6JoGuVMkAWXAzU6JSHmjuDAflKFDCvNdo0/ZwEJQklHmktwEz2mKWAWnk+/ASMYGc0dBvsauJYBRcmCe58I+OPQluzrMJKLVSXJcls5VbWMfC6UOozCFqpuCwy0ykRpN1RPjLfENOn5laQ+cgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ7NnbZB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ7NnbZB"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso784457366b.3
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 12:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737319165; x=1737923965; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NW41rYTC10uLpy+iGcA64mmb8oxi6rsPji6xf96Q4KY=;
        b=cQ7NnbZBCz7iwKsxpB+mt1pZLrD97tEdFR/laHgcyf9TBYHkc6ff5bW8eHPWf052p9
         kdDK3Wwrm1oStR3Gd7ZzrLOv6ECwvwyGiEOLBOJEVuXjwEJmmrRln5AcuyPNg8aBw3vO
         akCoXpU7lRpk7qkWiZ3k4cktyOIMbEIWGTYoO4ujT4z2z3H3IdM92lDOtQORuhUNG8In
         XCKXZg8wsDs5iGUivEUS5y8ZS9inmCrMqkZy1NLt8tXvBeE9sDbYnprZ4lRy8F4RLp31
         Mk/6TgLgMxi6X1xTYh/SOx+7J1KAfNYEQM6XuqqCYgTw/hvKnz7YVmeDWXnEN7cX7Nkd
         utwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737319165; x=1737923965;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NW41rYTC10uLpy+iGcA64mmb8oxi6rsPji6xf96Q4KY=;
        b=SVTjOFElfzI26k4O/FXEhhKRk6Cv4CmnGHJmmsf2m56OSKjcw4XcYtoOi6nJB7vHuy
         MUGX3Sw4z8nE2Kjqaoarj9Ux7tTdwb+AzSdgVfsC8hcD1bfUW0gvU1gGOdoh9W7nktnL
         sZsKpIhBFjzsanS3ZGAI7Jzvte2PbVg8Vy948+fFA8owZumbh2fDa+krUEse51AcIjDM
         bjMCLKP0YnoWWhfibSKGa3GyTzyot1q9GAtgz5Exec4B7pur8haq7cxExCcrRrVxVHuO
         o+Zg4vPhvJT4SaWE2r8qP672DLuGNmC5ibXd+T39qqDY7Y/9NchrWbefg8EvW4epE48y
         vbcg==
X-Forwarded-Encrypted: i=1; AJvYcCWuZ5JZl1iuVRQB20sfpiADFPkPiHMVmP9S18ziKfOQkCfAzDv379gjEOD8EkotyoK00rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuUpfXHCEd4vBgo1uORzdE/2YoXDfGS4dwCbQN6L76oyLBpi6
	4XGBWGyJcHWCkhd1/eFlVPOzkgf43jLHba3CIwKAD3TCxteCUHms4kux+KqQXnt/X/DS1yLkWl1
	72bo2EsC7nmD012Eo27vBeIGCwRo=
X-Gm-Gg: ASbGncs/6W3QgRXrrbQSKnvvtGSWb6cHdtMYdpVcILMZ0MzpArxxAWXAOwpj3w60LMw
	tsu5obOJhFBqEdhX1F1uBGTHH5ea+9naOMRPFyvotiTbXTFAYhwQuCg==
X-Google-Smtp-Source: AGHT+IGc7/jPmqjRJE9iO85btMNHdH+ecz3oSqabNWpaUCT4TPOYT+LUKtUP3f3wenuk8WwPp9I5YxXhX+HeRJQMiIA=
X-Received: by 2002:a17:907:9802:b0:aae:8491:bab5 with SMTP id
 a640c23a62f3a-ab38b30e1admr871532766b.26.1737319165053; Sun, 19 Jan 2025
 12:39:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAODtcdcTjquNUBaTWKzyy54J5NoH7WO+9uMzJ+wWRDf0Na3OPA@mail.gmail.com>
 <Z40mlmfnUOXI2ghd@tapette.crustytoothpaste.net> <CAODtcdf-+QpPpB5R-hLkKWKacwM=N3=XRDs-tK60W9WzUJu7xw@mail.gmail.com>
In-Reply-To: <CAODtcdf-+QpPpB5R-hLkKWKacwM=N3=XRDs-tK60W9WzUJu7xw@mail.gmail.com>
From: Al Grant <bigal.nz@gmail.com>
Date: Mon, 20 Jan 2025 09:39:13 +1300
X-Gm-Features: AbW1kvaKnpoawH-0H1QCkQ3k8lmZfrZLaaoF6_KsRXf15byK_e4RDlzMKx_BNf0
Message-ID: <CAODtcdfS+TVmrwohtHFUXRZRwC1WmF5ENpZLVoZTyJgA--SC-Q@mail.gmail.com>
Subject: Re: Rebase
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Al Grant <bigal.nz@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yes. But I'm keen to understand how to deal with a merge conflict.

My IDE is VSCode and when I run the merge I get this image:

https://imgur.com/a/vynTxaj

Which highlights this code:

255: <<<<<<< HEAD
256:        samples = signal.convolve(samples, [1]*189, 'same')/189
257:
258:        #for testing - log to file
259:        #self.f.write(samples.astype(np.float32).tobytes())
260:
261:=======
262:        samples = signal.convolve(samples, [1] * 10, "same") / 189
263:
264:        # for testing - log to file
265:        # self.f.write(samples.astype(np.float32).tobytes())
266:
267:>>>>>>> 1f893dc (Make project runnable on Linux)

Now I would assume that samples = .... from ln 256 abd 262 are the
differences between MAIN and FEATURE?

But when I search main (at least I think its main - my IDE doesnt tell
me mid rebase process) for ` samples = signal.convolve(samples,
[1]*189, 'same')/189` AND `samples = signal.convolve(samples, [1] *
10, "same") / 189` - those lines do not exists anywhere in MAIN???

So what is going on????

Al
