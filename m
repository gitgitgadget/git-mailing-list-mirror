Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5F76044
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226406; cv=none; b=g5EcyuEh0rRGbmfSqQmshg1ScuU7fLBjtesNkkdoXnDr47tisdjPnUZWaCM96oNDHkcRG0zj1NF/7MFcnU6dLVL+WZXVU1EtfzhhXnoy82G+mzuCwD+vmcRx5lwWmuCQPuBI7CmhVHtYxGKJvmALOn0KKXpiRfN1JJp1EjLYdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226406; c=relaxed/simple;
	bh=aNVyeER5dNnxKY0Vkc9mdA/WEAOKlOZnP8Bxshbnt/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OQDAnhCYopiI04M+YJyACI74ByuYh9RwBDuHWchPEotTmU5hFkhF30q2R5TTxzhNPnMIgCrqt8uYHqgXeFGevCiE2wilI339vHzEb948HgCF3d3/7pAKfO8hPF4KUuJog8CiW2j9lTQ6mnK2NezbsGGyeQ+v9nevurX7txa2PWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN8mN5yp; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN8mN5yp"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso837472276.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712226404; x=1712831204; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNVyeER5dNnxKY0Vkc9mdA/WEAOKlOZnP8Bxshbnt/0=;
        b=SN8mN5ypG0I4YQ+4SPQCaWBU2eP2PVNh3eeq+yHsSWDMRXC5pzvYKJ3IjA9LMzwzpZ
         h1nquK9SXowjeV32cjnYpS8CKBXp+8MVV6B1D5PmdChaKDN3wgdAC9gBW0tzEmIs8weI
         6hrweO42Lrvve1mgUlFNsXx9EI8VNUN6A2GrfcpAvOc20UcN/Z7ujLmIynjMXIHe/3EY
         lUAIOXUtzXs0Kk0fjaWTPbwVBeHTP+3c66n4TWJMI1zQAoAwh6W8pzpM0AF09N3QLGkL
         6AchH1eG4OK7zU5IxB1Wm/45Zim9HpA0J5aaOF8zrfdGEwuRXAitYkdeKp/OUserbFc1
         ZX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712226404; x=1712831204;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNVyeER5dNnxKY0Vkc9mdA/WEAOKlOZnP8Bxshbnt/0=;
        b=LjegGLmuj4LAIpR3VaepKHYOkO2AknSZcKmpOqgEgkdb0QwZJEO7vxrrvbFv23IpgM
         zW83es/OF8c2jfNqZcHUPICX5PHzNELKlunk/Uc5r6V6T4TCPw/cszY/1vSHF8VylF+H
         smYw2GwgKwBqM5jOmpsXcdb2u78BWL98vbJj9CgCsFjmgwIG6tbNUr0PmJyKBVr6vtRO
         lYlbhPrtSWUSqQBKGQDxrEIRMgZHIRCUgDpbS4Pue2PC3JiX1dVSdK3gFmFW6QYL26eB
         A1Jq4dkPvFropZlan6m7pqbC5yZz9TfS4fCC736WEn3Me1k+k9teK1XCMJM/QQBk6ZTU
         fxrw==
X-Forwarded-Encrypted: i=1; AJvYcCU/xJmM3/vqXjSn/h0GlOlMHeUWwQEU/gtNsBTOsSeW28e8uZhf4Zqn+xUCKrtK9+W/i5HV1y9IDsiTEdQh1Zilhe3u
X-Gm-Message-State: AOJu0Yz1sW4UpugnuKtjtti9p58O+lJ1Dn5tgvoI1p/nDGWQkS8J7sZB
	fxXUeKLsEwQk1L1VD3GnWNa2Fuy/3NkC1vZNlRF5Th7iPlh4f4bQpc/Rl5+Zl/8oTDR77NZVEKX
	ZRLHatkk4ud/RJJLtRN4OWEubC+o=
X-Google-Smtp-Source: AGHT+IECPUU+8VzIZudtVJtB0nvDAm5xmbcs2BSnnZN95UjUC7f2pxe70iUL5YuXMFTNEaz9E4i34y4tXIWW97VDg48=
X-Received: by 2002:a5b:585:0:b0:ddd:72ab:233e with SMTP id
 l5-20020a5b0585000000b00ddd72ab233emr1836796ybp.54.1712226403761; Thu, 04 Apr
 2024 03:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACArJ22jCTArv=U-XW61P8x6sa0rrXYupQvh_txdSk6vAG7p6Q@mail.gmail.com>
 <20240404100854.5vfozqo7iiyyshoc@carbon>
In-Reply-To: <20240404100854.5vfozqo7iiyyshoc@carbon>
From: Simon Phai <simonphaikm@gmail.com>
Date: Thu, 4 Apr 2024 18:26:31 +0800
Message-ID: <CACArJ23dNONx-Fk5VwZZ+A64aEYW0nhn+X6q50W5hKLN=VbEng@mail.gmail.com>
Subject: Re: Git Server
To: Simon Phai <simonphaikm@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

actually I'm quite new to this but I would like to setup my own git
server so that my fellows can develop our own repository, I find
online there isn't much guide on using windows server to do it.

On Thu, Apr 4, 2024 at 6:08=E2=80=AFPM Konstantin Khomoutov <kostix@bswap.r=
u> wrote:
>
> On Thu, Apr 04, 2024 at 05:54:44PM +0800, Simon Phai wrote:
>
> > I want to host my own git server, may I understand the server OS can
> > it be windows?
>
> Yes.
>
> But note that there exist quite many ways to "host a Git server", so you
> should maybe explore what's already there and specify your requirements m=
ore
> precisely.
>
> In the simplest form (if we forget about just running git-daemon in a con=
sole
> window - providing unprotected R/O access to a given repository), you eit=
her
> set up Git to be accessible via an SSH server or via a web server (IIS wo=
rks).
>
