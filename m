Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EED146904
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122891; cv=none; b=ra/EHRG/CfDdckc/X05j2WWW1Vq9F3cCm13IynJUxaY6DcnOa3E2BJEggA10detd8WM+Xu/H1KxdMZqO0Kj2CXDNPlkl8Msy/FuB0bPih2CFK6k3bgKTjTkq4DWs09IwoCRrXN0aSkvFF+7jPHmcIkhk6wT9iGDR+/B3ATMEeSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122891; c=relaxed/simple;
	bh=d+2uzZSjGP/nT6JDvtWkloMNkyNNFfeQNwwH4R30S6s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kvJxwyqCGAHKV1ytXqopTdv9PVpnDHpj4toNrOiTcC4m7z7aE+gSxQDoR773s7VA7uX3EMWdf3JE4Rl1bWJ7bCzLFmScWnQoBmCWUo3ZZBJtSFMvnClGW84Z2h+XovHYnQZSX27P7huBN68u4uPrjudS+MR2QoDMEZ8wjP0fWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ehoab0Yy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ehoab0Yy"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d542680c9cso35023675ad.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 14:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708122890; x=1708727690; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATA6a8GJ7YR1fqHuT3kHF7A0GDHfQT6xo7yTZ4pkKgk=;
        b=Ehoab0YyicOaM+iveZJ2lIY1QRZjBnFxJg/FPWlY+cYDy4UfHZXeiCFpB/aodsvEWy
         4ZJCAYFrxjnFekntmZBQYBuXB59w60G2YvMwdg+sysdEHcDVovz/Zizob9E8dS0gkX8S
         uGOTTacDZobmftkoyWIWTO0SiTlwd8ZQZF/ySFZ2b7woObQnI7ODmx9fwEQuDv38JXuD
         FJtiPme3dGJ768EyLDaOxC9yCDSWGzrD3TMCV6bYm5Dk5C/xrgV2sxwnfUaQ6wnQCt+a
         Ss10gdf3zeitr5SQzE4ayrOn3BF4QpUQO2vvCYN9RQdXqgNPGHpq6xg4lRnggAoAbjrG
         /6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122890; x=1708727690;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATA6a8GJ7YR1fqHuT3kHF7A0GDHfQT6xo7yTZ4pkKgk=;
        b=HrbT0kNzXUZZyWHl1zCXdlzpzc4AMTXycGwKgTM0IZm5xod9LJIE48E4MM6+FXnQGY
         Psd5atBJjCsmeJY9RNfF21GJbORa3Pxrw81Z8bQT2BPhbmXxN98OyUbUBj5Ot9iCyw25
         Rgrw7hP0m7owIqZjWCcXJacsk4dWggpi5XL2RLSSrWH+eDw5CSwyKhSwscfQYn4vc4Dl
         wlkqak+xuxM9KgcgTKhyRhvT+t6gsqB0D1vdlhqwhbuVtGE8JCPpBY82re4SyWt1zAJV
         a+iIYTfvm4X4adKrE2zF0pAnR+yjkBdfl2bOlJc8GQnABxfUEV0GQbQ4eE2I+NL9ME0V
         mZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcExJH5Ki6MmNwBfH98GaxdLFyu3a67+gOWThSdlGNdQogdQrqtZLS2RvElL3ih26PsIDWePBcKYdcnWcFpuof6k6N
X-Gm-Message-State: AOJu0YwQAAFZ3cRp+xhjQtEs4sbCI7NTufivSulRZp1TF6vkaSXod9TM
	U1yy5IfGIJcVHaTdWpiesgEpJNnTW47a4DPYTjQ6q7RhhlTlHNXGdwiKf8V95eIEH/0QTClkJfE
	0sQ==
X-Google-Smtp-Source: AGHT+IHfAwj7HHMpiYThoGGFd9GEkaNweyNhg5wu8TT4GWSz661NrXHDr4Ytvuceb7dlb9AD6WXvoSjyg10=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:610:b0:1da:162b:7a5f with SMTP id
 kg16-20020a170903061000b001da162b7a5fmr114630plb.10.1708122889913; Fri, 16
 Feb 2024 14:34:49 -0800 (PST)
Date: Fri, 16 Feb 2024 14:34:48 -0800
In-Reply-To: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
Message-ID: <owlyeddc82d3.fsf@fine.c.googlers.com>
Subject: Re: [BUG] git commit --trailer --verbose puts trailer below scissors line
From: Linus Arver <linusa@google.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hello,
>
> I've just found a bug in the current master: running
>
> 	git commit --trailer="key: value" --verbose
>
> puts the trailer below the diff, and thus below the scissors
> line (and so it is discarded).
>
> I checked that it works OK in 2.42.1 but not in 2.43.2 so it is not
> a new regression in the 2.44 cycle, but I thought I'd write now in case
> someone spots the culprit commit faster than me.
>
> I'll start a bisection now.
>
> Cheers,
>
> Philippe.

Thank you for the bug report. Looking forward to reviewing it (I am also
interested because I am in the middle of a large cleanup of
trailer.{c,h} [1]).

[1] https://lore.kernel.org/git/owlyplwx87s9.fsf@fine.c.googlers.com/
