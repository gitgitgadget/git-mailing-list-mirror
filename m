Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9134104C
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492634; cv=none; b=gAnu/BpIMurYNqzagraH1Vt4oJXJCIyYbcUM/QX0uDuBV2zS2ngOOJ3kaS5givlHgA5uFb1Jd9eoELP1lg45BDbi9lARvrTSPqNPUl77r/j9QiPXmg59lmhIyHsRreyO473bXiTpUlG7C2nNQv8VwXbWuG6Y4xbG0tOjkAC7JI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492634; c=relaxed/simple;
	bh=9d69LNUN4helacsy2BIzedUhQmTILLe+KYhOmDlMzAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrIA7+CIs/et0nGwKlG/IXznApC1vWVYbFarX8Gj2ITCquxl84t9LN45uLPEfbg0Sv7g3C9IwmSr4pK+i3RPtkHNJtEAZnSE1WPapC1fPBlgJVy3buc6AiNVgn8Qi7DAzgXzBesUKcZGIKjFwPUJKuykBypbOTMMsfmXYI48WGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzFujfCw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzFujfCw"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59431f57bf6so4981971e87.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 04:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766492631; x=1767097431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nM14fX9ZxefHZGwQeosT38R5dLQcWSZtl3Ohocm1p5c=;
        b=MzFujfCwydQlH/zy82cIpj4TWRNz3foIXlYGzFgLE8lG+w6cKJFPXQg584f2e27VPH
         d/Vah4e2+17LxKRs4NsDJDc2MhZ3MZdafjXIJbuvvN7jaIHU8zSHxRM4B3GVG8vDW4jg
         E+m/96SVMfQwEMl9sd1B423NqJTirob93ymjSQ541V38RXi/VpVrLlIfjFcECk1NTQGJ
         l89F4C8+TQ3/EFE1Z6Oh+m9cC3xBs+Ivd0DDEbGmZTtzztoiqvzOinvTn8xFaN4zCpQR
         StBzWYxgCyxt2g/OqDgbvN31ZQ6SYm+RCmlXZCDRqtisG6F2aoqSXV6erYUdo6OroF3d
         h3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766492631; x=1767097431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nM14fX9ZxefHZGwQeosT38R5dLQcWSZtl3Ohocm1p5c=;
        b=r+K4s47EChtVm7BMTAS9Ndg3ein7sJ2dYpkSikpd6c3Uzu9s2jSlfmdqmkQM69dcXa
         rcHIIUScdkESyT2/5VHmQ3UXw+PpTXje5ceLtXC2lWzAGqzstVIPXZEteIL9rWyEBK5m
         kkbE6dNYL+ZTYcHa4l2XnV38dehYtcBOx7PNiO9KO1ITkeOZ1lWyayTIUtzlgewqbvFp
         Nir6E8i2qALbhwgRTFvdYAl6PYzrr2RFkXS3jSjhpjqjcugKBGs9DWU+HWKwViNG6AEw
         WL7/HZZL/zK9vGQig2GF/S31CIgUoxxB8SHnxDIdyZhKjQip8SZFesTfjwaTRfC87XBe
         biXw==
X-Gm-Message-State: AOJu0Yza4yW8Kg7vY3/ZffJdlE7MpcKErO1UP04yTN+SZBrLq2daCIAf
	pZXbNE/D78Lddhs/0wOyMOJbDaBH2LJNSDdG49IeRsdryPex9gXrN1wZEmaea9KUAKvcU7Ov2Fd
	bVplMJZywDVOgSg5SotpNUL8TsTxP03NZ5PaJ
X-Gm-Gg: AY/fxX7TtfZ856HsDy63BRRhmw5olLUn3CuoY6KKj/de1ur+1GYXaDZg9E4i244xoFD
	lwtqvdImhqpvgmd44cWQtzHOjIRz9DdnV6IH4mjyE93iAe4EbdMnZdhDO6GwaHQ4sN5Y+vtc97x
	Hydd/6G4BuT0xTadJJF9kZzxH8qLcB7ghxGOfHxYuqS0FRSP+PgQ5chix6DNxhwLQy7rLEtEzHO
	PuUhFl+ViS0/cvKjzqPWLX+nGRH9ort/zcrpUXk9AWoKHnRM3Kh9nw9xQsHwr8FYneS8Sk7
X-Google-Smtp-Source: AGHT+IFUDSLG767PKXvBiuFFe02LqKZO+jYaLRQGbqiYaALxPHqyTAZ6OJ4SB0Yzqj7eKtJqe7mLdZSP0qy5fKNs4Fw=
X-Received: by 2002:a05:6512:33d4:b0:598:853e:72f9 with SMTP id
 2adb3069b0e04-59a17d65319mr5336400e87.51.1766492630762; Tue, 23 Dec 2025
 04:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223102422.36853-1-haraldnordgren@gmail.com> <20251223113602.63000-1-haraldnordgren@gmail.com>
In-Reply-To: <20251223113602.63000-1-haraldnordgren@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 23 Dec 2025 04:23:39 -0800
X-Gm-Features: AQt7F2paqNwzsr9G8Fa9tqYvNfKq34b6dY3Llt1CrLb3tS1V2cRZUHYXnTlBoUY
Message-ID: <CAPx1GvfrQNao78WYfadttM=B8iyXKfxYaxTyX5w_MLZt2_bU4w@mail.gmail.com>
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 3:36=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> Once the users runs that suggested command
>
>         git push --set-upstream origin ahead_of_main_status__tmp2
>
> then the 'branch.<name>.merge' and 'branch.<name>.remote' no longer hold =
the reference to "upstream/HEAD".

Right.

And, as Junio noted, to:

>> learn the other, the destination of a push of this branch, would
>> involve poking at remote.pushdefault, branch.<name>.pushRemote,
>> branch.<name>.remote to find out which remote repository it goes,
>> and then remote.<remote>.push to find out where this branch goes,

That is, there are some separate configuration items that can change
where `git push` goes.

Using `git push --set-upstream` sets ones that affect `git pull`, `git stat=
us`,
and `git push`, but it's possible to set ones that affect only `git push`.

That still leaves `git status` with the problem you (Harald) have observed,
so perhaps the path forward is to have `git status` check things like
branch.<name>.pushRemote to see if they exist and differ from
branch.<name>.remote.

Chris
