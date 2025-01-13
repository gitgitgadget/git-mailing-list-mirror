Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD11B23ED45
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777693; cv=none; b=RDyAHrytw2haH+Edxttk6WmL2CtzFDpbpORE328XpgNMzaErbZPjjlg7EGRFBafgI8KmmHMARGpDf4fn3E7tK3PKo3UG8lBkMNKdqNUm9zoJk2poVWreFokh62PkUX1ruf0UJd8uvEz6uJlJHChsvVAkvdBXS4NhmSO30kr10KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777693; c=relaxed/simple;
	bh=FDIdmmmE7eRFzTAcj7C+Hv5UQkOh7Yxvxnw8lhBp3SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eAZUzIQl2C9VZmZR1PmblPVHo4BVPBP3S5UrIBnjci9fvtPyltwP0atGrnJ30RThSMzyKvgpIvL8HVpjZ6yrCJvIJfLvYNlDUDrfp4102TUhtY8K+DiOI6ioV016UCBF26aMGNliWcnIQm3OnyvDLfANmsiCdCl76Zf72aBAkXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com; spf=pass smtp.mailfrom=jetbrains.com; dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b=deH1HD0e; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b="deH1HD0e"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so7274238a91.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 06:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps; t=1736777691; x=1737382491; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS4kI4HDbM1pux69WfMpNMnUaSDtz6Z5RjhIVJmH4nU=;
        b=deH1HD0eRhZ3qv1PufSKVnPmKswsLEAhl6bRO2sisJg1n5iVJhHYiSBR9ikQUb576G
         b38Ea43q6vpTochsy6uG2Ga42eRXwa7b6/c5trSnu2/X9jHEaxJlQhKghPXbGWtgJf+g
         lTLqQsH/PzuFcHJ7mPJepWTYQHg02lkxiaxrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736777691; x=1737382491;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS4kI4HDbM1pux69WfMpNMnUaSDtz6Z5RjhIVJmH4nU=;
        b=WRXjniGo5C0J2G1UFUdeoP14Y5s5ven6d+oImvvmvTPkgweFVN+osfImepoEOh0O/W
         9XEjFGv1hu5NX+dODfv2k1kzLPg1q5zHMb92FKMR+4uUL0/SdakCRFOnfTYXDv42ZObz
         7NDanZEmqSpBwkdXFbcAFiXxgLjwzmXbccwgYZe/ZXrfNDguFiiUyx0oXHVCOtOiUh03
         b+K4ATpaFDH5g0xQoytWvjffW+vLau7VZk7XINVpSu0cNlfORNlIsvFxZK89VSiaY+1A
         aZe6hOYpAJVphbGwB0umW34ruHufQWOKThAQkIz5KFyZooxAd31/2Q63LWO6+cfNOyXH
         +Z8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC6sg6MgN02w6h+jXeDyjgB3ZnIjKt5usB/SDGJyBu5AJbUNJyozYcpvwGeUu/G2TTwrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUA3Rv/H58KWSXjFpuHQDojAKIrqDIUZNSa4X6EAFhD3kKpnT2
	i22iUN2X2cZFdkoq8o7uym7qhxVZQHX8/v2iXUIIyXppHoe4bx08ogmoQ/dNbd30Ah5K4f+uJEZ
	CpZBK9xO9s80nQ3q7+xWdGznJSSWdckukkMqhqwkf3gZ7iKPH
X-Gm-Gg: ASbGncvTigRwqzRVAh4RGeUhCHVmqbzdA4LKrbocIHedbGLimqE38YqX4F94gYj0ysu
	POCIWTT3sOPKBzD67gUkP/DWrqrhymCK9vKw=
X-Google-Smtp-Source: AGHT+IFVQLC/Exe6tGi8paMbsOIHM8sx0dyM/K4dCmmLr0qn5Uc2E64SBxdqmdHvdBuRcGjkPLzfgejeaG5rP4Pv86s=
X-Received: by 2002:a17:90b:50c3:b0:2ea:4c8d:c7a2 with SMTP id
 98e67ed59e1d1-2f548f5f6f8mr33492559a91.24.1736777691111; Mon, 13 Jan 2025
 06:14:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM6buW5KSDGHD7txroqVa0TN_Ou_eV-LocMy06cPy0ZGDQmY9A@mail.gmail.com>
 <D6ZXVILR1D36.3W0QVQCVE1P2J@ferdinandy.com> <CAM6buW6NbdZ6wLGP6LWePiA7n0At=jxxqtBEUv0fTY6mOdTmyw@mail.gmail.com>
 <D705W1554XJ9.30SRYLNGNOX4@ferdinandy.com> <CAM6buW77CeuKfr3b4SUbYyFaU1OTvRsYBjPBE05YMzJo36bGdw@mail.gmail.com>
 <D706LPHBPUL4.3LN27T1UG1FI2@ferdinandy.com>
In-Reply-To: <D706LPHBPUL4.3LN27T1UG1FI2@ferdinandy.com>
From: Danila Manturov <danila.manturov@jetbrains.com>
Date: Mon, 13 Jan 2025 15:14:39 +0100
X-Gm-Features: AbW1kvZHq-8uYwO1qlaGl71rT1fkpTz-GGdoRTwdZeRtsU5TYJUtHrsDyVxpZGk
Message-ID: <CAM6buW4UiCs9pFeH0cxxdhLHCSNO9wLVz9_p4Y0u8LaGWy--ng@mail.gmail.com>
Subject: Re: Git 2.48. Changed behavior of the git fetch
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

According to our CI, the first commit where the bug occurs is
5f212684abb66c9604e745a2296af8c4bb99961c

On Sun, Jan 12, 2025 at 3:58=E2=80=AFPM Bence Ferdinandy <bence@ferdinandy.=
com> wrote:
>
>
> On Sun Jan 12, 2025 at 15:27, Danila Manturov <danila.manturov@jetbrains.=
com> wrote:
> > Seems in  the 'git fetch --progress --depth=3D1 --recurse-submodules=3D=
no
> > origin' the ref-spec is missing
>
> Ah, indeed, with the refspec it doesn't get the tags. I'm not sure what's=
 going on there.
