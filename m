Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FDA19D072
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956371; cv=none; b=VCDjh7nDnsLabes+o5eVNZd+CtrhFcfZsKOP50Ma80OCNVWG8pXg0OPO/89P68GitxM2sMhYnn8IKwxNFo9h39fryXlTdkZlAaOOJ34eL8l4VR90BXL2JTCuu/ApQrmUqf2sAeELHDrAJrqbDN2DAjq12tqE+dvBwDNz9XqHY6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956371; c=relaxed/simple;
	bh=e4k03LpHPfA+3BtA3J86j+qGR+PmtdsSPu8lQwaRXCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aC+XpbMFcUsehV9yikclHeQASncF8KnAIqUber4zO8S41Fcjm9qd4vDN+oOLZYnYf79iUMAcL4Rvq8V4UPhJApu8q440di+oaN4CxEy3zPgD3W3PGM1jYEXWV0BH/THuFlnsFyKGSj7Z/1Gpm7yztUViU/AVX0y7GMos2im/88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6hheIWp; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6hheIWp"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4ba88477ffaso436396137.2
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 11:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738956368; x=1739561168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XCsjR+evxPJCpSSg1Yyq7j8q4jXNfxQzQn5Z/zN/xU=;
        b=L6hheIWpBsD81O6RtNQiX99VkjIkUuIRjEjynyKw478gKiAwJzJD05GJc4JK7ic8Fq
         xFb+sAGIFmgPXDCMCQmPFfhKqzFb7qSZ2OmMx/0VgOwClCNeIb9VPsW3+aGCUEDVG4Bj
         2HE0mlkZa26JPqT1IvtjKP8gRchjNWzL+BY0ybjndm4ZTAatf8nDFh9sLHBj2xA0NQAi
         J4jPiTWFNnS1YHpaecmgPVKP4N0+/T3VGfEsWrSIOM1oauwQiTvHCGD7mjMRhpSudHIC
         yaD8iilVHg9/VOALxNHHVX5S1qa2KPSvBc4q3KfkeS+lm7vjcYg2v5ifh3H4zTz6pgbh
         4ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738956368; x=1739561168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XCsjR+evxPJCpSSg1Yyq7j8q4jXNfxQzQn5Z/zN/xU=;
        b=YThhl30ofQpAoT7xaGuriLVAP/KSrZOmAl5JL5zw5hOtgWRMVFVH68DA14M7Mwrc7A
         ORQu3kntpUxpm8YB5nJn0doMPAsL2O8PMHMO3MMhNbUTfXTxiivcStptnu9j6MPoYqi+
         ZD5kQSVRas4yy5A/YsTjXs1zEhm1EdD6thKjEMe1dAD8IsrOq2qzR3jr0MUO7rKURUFf
         I5z1+fL4vKkSW+bt4QVVKRR5H6dedoLgs/bfS339To1Tu3n97paA59/vGXC0Mh1dnN9P
         4oz5zjxN1B5NUDEMv6OaDgn2sj5QkixW2iIfpHU+xfk2Ut1odHdMFR/LW0MxdbKc0E2X
         XZsg==
X-Gm-Message-State: AOJu0YzRiMs31UOSzEj0csGbE9JStyeLsCnEu4FpTN0OQm0HYBVRqjSz
	fson2XhrxVTf9wgFu4RrPombykLrB/2Z8bJn64H7xC8qesbvbM2AQDsgNnfTZOsXteAew5OaR79
	Dyik56Kmrk2MgKZOBROl3LJqLMEo=
X-Gm-Gg: ASbGnctNVA6qQdGwO+LRf0wj6U8KiLBYRbPeujz14/cYsglbYqOW2u8ZCCL5EkTG1D1
	CpLzOAuSDDTjWYZ13DRpk64vDeepNV9KROytOg2BfpwJF8y6W0Vh6GUIHzHyRHbUXDu3ivWeR
X-Google-Smtp-Source: AGHT+IFgRkEb+rWUPH+zzPiGx9czrsda+Vpq5m0tQa3okt3YFtirgxY/f/2jj4txRNYi5PYsiDPoIxisgtE81zN4qIA=
X-Received: by 2002:a05:6102:f94:b0:4b2:bc6b:c845 with SMTP id
 ada2fe7eead31-4ba85de9dcamr3509224137.6.1738956368420; Fri, 07 Feb 2025
 11:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
 <20250205185246.111447-1-usmanakinyemi202@gmail.com> <20250205185246.111447-7-usmanakinyemi202@gmail.com>
 <xmqqy0ykkqqc.fsf@gitster.g>
In-Reply-To: <xmqqy0ykkqqc.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 8 Feb 2025 00:55:57 +0530
X-Gm-Features: AWEUYZmNJ52vNozjwasYUZxjlbsfIKijmxahud5rM9CEUnvuIZUNYzGXDcY2fvU
Message-ID: <CAPSxiM_TUyZqrKEaDBz6AXBg3hamPOaVvY5RryUUMUE7RDU1cg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] agent: advertise OS name via agent capability
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Johannes.Schindelin@gmx.de, johncai86@gmail.com, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im, rsbecker@nexbridge.com, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 3:18=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > As some issues that can happen with a Git client can be operating syste=
m
> > specific, it can be useful for a server to know which OS a client is
> > using. In the same way it can be useful for a client to know which OS
> > a server is using.
> >
> > Our current agent capability is in the form of "package/version" (e.g.,
> > "git/1.8.3.1"). Let's extend it to include the operating system name (o=
s)
> > i.e in the form "package/version os" (e.g., "git/1.8.3.1 Linux").
> >
> > Including OS details in the agent capability simplifies implementation,
> > maintains backward compatibility, avoids introducing a new capability,
> > encourages adoption across Git-compatible software, and enhances
> > debugging by providing complete environment information without affecti=
ng
> > functionality.
>
> I obviously agree with the benefits enumerated in the above
> paragraph.  The simpler, the better.
>
> I however wonder ...
>
> > Add the `transfer.advertiseOSInfo` config option to address privacy
> > concerns. It defaults to `true` and can be changed to `false`.
>
> ... if this configuration knob is at the right granularity.
>
> For privacy concious folks, I would imagine that the distinction
> between "git/1.8.3.1" vs "git/2.48.1" would be something they do not
> want to reveal equally as, if not more than, which Operating System
> they are on.  Such a privacy concious user may already be using
> GIT_USER_AGENT environment variable to squelch it already, anyway.
>
> If we were to give them an improvement in the area for privacy
> features, I would think it would be to add a configuration variable
> to turn the agent off, instead of having to leave GIT_USER_AGENT
> environment variable set in the environment of their processes.
>
> On the other hand, for the rest of us who think "git/1.8.3.1 Linux"
> is not too much of a secret, we do not need a knob to configure it
> between "git/1.8.3.1" and "git/1.8.3.1 Linux".
>
> So, while I view some parts of the series would have been a good
> exercise to use various features (like config subsystem) from our
> API, I prefer if we kept the end-user interface not overly
> customizable (iow, without a config-knob, we do not need to add a
> code to inspect the new configuration variable).
Hi Junio,

Yeah, I believe appending the (os) to the agent might attract the attention
of some set of privacy conscious users who might not really be worried
about the agent when it was just a string like "git/1.8.3.1". While
GIT_USER_AGENT
can be used to suppress it, I believe having a dedicated config option to
completely disable the agent is a more user-friendly and persistent approac=
h
than relying solely on environment variables.
Requiring users to manually set GIT_USER_AGENT (since it cannot be empty)
can feel cumbersome, making a config option a cleaner and more
intuitive alternative.
Additionally, having a config option would provide a consistent
mechanism in case
similar privacy-related features are introduced in the future.

This is me convincing you that having a config option to disable the
agent is more user friendly than having only the environment variable for
users who do not want to share anything at all.

What do you think ? Or maybe there is strong reason for having the
GIT_USER_AGENT in the first place and not having a config to disable
the agent capability?

We could also wait for input from other community members.

Thanks,
Usman

>
> After all, GIT_USER_AGENT let's you hide not just the OS part but
> any other things from the user-agent string already.
>
> I notice that unlike user_agent() vs user_agent_sanitized(), you
> only have a single function for os_info(), which I think is a good
> design.  But if we were to go that route, shouldn't we call the
> function os_info(), not os_info_sanitized()?  The idea behind a
> single function is that you cannot obtain unsanitized version of
> os_info() out of the system at all, so what _sanitized() returns
> would be what os_info() without _sanitized suffix would return to
> the caller anyway.
>
> Thanks.
