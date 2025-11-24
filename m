Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB152FB0A0
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977814; cv=none; b=ZP9LXIaFYrijOvFsD6Q1txzKKz+N5iD4fTs6I63asQYhBvY+BLZ5zEJIZSBEublsEn1FkBiLFnTWs5rxrCeG7+eO13R2BdcoYHIqxtPtfluPCNSU6gs1JudyGe8kEo3AmeIMXrzQcV6Fxdzh2ePIqeidZtHD0EhSYgQRUqmarQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977814; c=relaxed/simple;
	bh=62mWIAUhEL/uw3Ew2shUOfLz3FScmxgabi5fBeF4XYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXhDzd+ejOujkyKuaNorn0UcO71vqExbXvFmWyy9Gb7nYcDPYAs0liMg414+rdPy+cvWcQloEy9XXimr8AlwClfVb++35Ot3y4NKNVCEPooSmz84DZE79yVYHDTn5ft5bBGBufDNPLv0/Pjks1tWv5zepGQPKztXGYIf2kwY93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIiHLw70; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIiHLw70"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a3a4d3d53so30229071fa.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 01:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763977811; x=1764582611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62mWIAUhEL/uw3Ew2shUOfLz3FScmxgabi5fBeF4XYA=;
        b=SIiHLw70dEIAWuAtau+OSZO5wdoUIx8OCgBzvoWmOY5xIsbOtkG/zP/ow/2aR8VyNd
         mB2l6wclqLq912EGodhhM6wPsymwVQQn3E6sGxrr9a8+NW5H/adiSnyUtjF7eJrvjX36
         idUOLPWqMAAKnSpniKVouBvvz7Ij8K6K/7shZhdFBTmBQdXR7hYoZkh0gNIOfdolkQsi
         GHnrK3aj5+9dpSuq9spLdm9fLYNd5aUuok+1Qi+s1KN9fmyWjdGjKnWGAdOy48AI/TL4
         DSpFywEsZy+6is/VpNcXKjRyejE4ZrQasjjPN9/822OfuooHYEaJwYzaXdYbDkwnUozF
         lqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763977811; x=1764582611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62mWIAUhEL/uw3Ew2shUOfLz3FScmxgabi5fBeF4XYA=;
        b=sl69I4vtCkpzyvGVcbuxpthUklxPLv2hYG10WJHf0PA6oIYlHcr5KGSGYCPll1lvi3
         OjYd9/n8Li7QXWgsuVTh2fX42DbzwegQf/uFQoWlnznZNkewal77iGm55ocd/Px6cQ7X
         c3HpAAFu6d0/MrXdjqKqfutk/O2iYYf4aNqcLg+oUo+fkMBMvNF0UPEEZKHaJpPCq2Ud
         +p73cMXtz6sroHPzFQ3Rax4UX5G6opv6nVXZgPGkSvvGxsiXLT4RJRQI2oK8iJtSRwrD
         sN6YERsqeAcJPchvqH+AFVoFC0nyfhVJA+hQIfs8lBejetnGe5q0FHK1GQvvGPOz6cpX
         +Pgw==
X-Forwarded-Encrypted: i=1; AJvYcCVO4cQx/oaLUmlYwDpDEU+Sin1DnJrIep2oBtQOoQnrYMkgZhAnZ7zPWko2dx5k/u2kxVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNC0jKi3uO48rv6rRUR0WQWgC2f2OMj418k2mKMyBoTBk4A4Yj
	482cWMTwsTnMSDrVP+twXpX/nwuwD7zbFfmEDqa4xsRAlzjBKZdizwq3tMfqKV55SsBWGbiMiSe
	dIk5c/jYsF2iUyWWZHsX1+DGXHQG3nVw=
X-Gm-Gg: ASbGncuWz9gV35ZJA6CrWaqKN6PNqmd1XXW+Y/LddtJK3BcnQUm+PDgrjYaAyfSknZ3
	jVADyhNZEw2iAFenLkkBxM4mTGkz6yXv+O8q5Fl0Vzim5kUvNyu7fEoFwwUNJJ8lftyvs2K91ip
	iAqd8FhJs6pw6jNT/PGXVwHiLuOmmYOjWEFvS/XcNcGaaKh+ZRn/AmA4fArVxzzxDuup6GZFoYO
	ODE5Noszx4Are/Gc1hOWIDSIbggKU05/TG3ssUu/u3hzY9LWN3MplEYc5AUReG0pbOTCm9m
X-Google-Smtp-Source: AGHT+IFEA65fcqIRBA7qXI+W9xPwanBEeGXEVj2INdCbuhYxwGSiJMo/rr2kiE/Vsthnc2/YpiF6KpUdNj17Tmr/74Q=
X-Received: by 2002:a05:651c:4187:b0:37b:9615:e43a with SMTP id
 38308e7fff4ca-37cd91aab19mr24878981fa.1.1763977810324; Mon, 24 Nov 2025
 01:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DEGR5XSM0EVG.27IMOKOK1O98Y@gmail.com> <9aa7cfdb-fc50-4ceb-936c-2ed441c462a3@kdbg.org>
In-Reply-To: <9aa7cfdb-fc50-4ceb-936c-2ed441c462a3@kdbg.org>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 24 Nov 2025 01:49:58 -0800
X-Gm-Features: AWmQ_blqId8Rr0Kdi7nwCDw-jhKkpARNlKfzXgqXhC6_dMS4zSGHuWh8I27rdk0
Message-ID: <CAPx1GvcXkXMpWgOyMWdfHXGEDJQY4wJrJV0p7LHBMeQFPMDHnQ@mail.gmail.com>
Subject: Re: Filter smudge for secret restoration: no disk access?
To: Johannes Sixt <j6t@kdbg.org>
Cc: Kache Hit <kache.hit@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 1:01=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
> The filter can inspect the file name it receives via the %f token (note:
> the *name* of the file, not the file itself) to draw additional hints
> how to process the data, but it still has to read stdin and write to stdo=
ut.

It can, of course, also read and/or write anything else on disk.

When and how this is actually useful is another matter entirely.

For sanity purposes, if no other reasons, it might be wise to store a
"file with secrets" under a file with a name such that it is **never**
controlled by Git (i.e., always listed in a .gitignore or equivalent,
or outside the working tree entirely), and to store instead, in Git, a
"template file with secrets that are replaced". That way, the secrets
either exist on disk (and are secret because Git is blind to them), or
do not exist at all (and are therefore secret to Git). The template
file controls the template and nothing else; the secret-data file has
both secrets and, perhaps, data that are extracted from the
Git-controlled file as well.

In this manner, a "to-be-smudged" file named foo.template might
control some external-to-Git manipulation of an invisible-to-Gt file
named foo.secret, and no clean filter would be required at all, though
one could inspect and strip secrets accidentally copied into a
foo.template.

Chris
