Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408E19BBA
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823854; cv=none; b=LnVRtn7x098j56u4UJV+1vILNJZ8WNaYtzOEUci+LwBwjWNQ+C7FDDci9/RrrTslPmh5YHfg5OOP2+QVWRXzuJz1DrA7u8+5bcoIWQeandqRclO+tfj2fJkYHBSBHMbjjgdmOxnEcwLSdw6NZxSarlLQF0RXB/F4PAjMDvuFJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823854; c=relaxed/simple;
	bh=OoX1UOsQ+5EmF1PZz2FWdOAvEqu8WNPOnZn935q7OFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0C8QkqJ9+BuVB/0tBdaqy0WvE5u+1gtDXSwsS9puHbj1F4it5rMIGu0TdjmXkM9tZNaYyvvsTijlgNkp3lr3KJ1cquC5RIXe9MGsr/EvW20HWZ3ZdibFdpeYlwdAeQmA+XVDvlle5HDqFRb+TTINQcEQ2cJQj0VsUhyaoXbwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6K7VihP; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6K7VihP"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-866fbf798baso41234241.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 22:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738823851; x=1739428651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y8zViUIt0FGjVdkp84DD3QZxUwIAi1llRStQfH3q5k=;
        b=K6K7VihPxnP0qLfFzWO97aAnExYrRCwRiGQ7lYHJ/OpC5GK53KDLnuDb9qZq/G6bMI
         2keKKbwfVS/fCsZmatbQbuoAHj8x49BXuYMwYpXs8NXNhnYMF7NeTHnq7vM/OK0lnQcU
         D8ZQ9yRtNoBmZZqqZD4qjPJaeuOMZlKAkekaE4TSPCFMUzRzLlS01wwHxDUdhv54EAfu
         sudbfePnWDbiOV2jys/F7A/kDk0wzo5JAZ8NtKkaCU2Qj/PeQhZz663hrnutfu5DTPye
         LKcHSMv9Z28x0ZKv0zLkNdJLxGNUMyAW+X9ABSCcvbBl/3P7Co7TwmEpBp81N6bD92AJ
         5myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738823851; x=1739428651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y8zViUIt0FGjVdkp84DD3QZxUwIAi1llRStQfH3q5k=;
        b=lzoRNPRv7B184CbhQ0UclsPaDFD1KbLhIwF4XzhH0Z2NeKfmBzI9ovtayTiWUAvKD5
         eDfi1n1Cp/NFiU+qhoSARIB/CYaU1d2DXz3p4daWEvwz4O2h2zgx3RNGyRRmDZ9+bVRy
         gpaDVlPT/ZZkrj4xHb6CeT3xQXDDl+QeMcPdooj+F7CaCUb5DmU09EIHCfpKzvfCifkg
         rpVp27mtFcoWTAp8E9eJu4Bb2590N7wBWh/P+Kxf7n8SpADdgz4gtHkuxAcaUdi87UTu
         rf57FO4gq0l00MjHuGepF4l5NhIpJB+O18wviyZY02DuyIJJN5etwuJzLswbCQ7apcm3
         5/ag==
X-Gm-Message-State: AOJu0YwSlXVk81PImAmsyEw+M3yz0x1diOUiMGymZ15Bnn4EWexHiqXN
	Tw1kztU+PMwpL3J7R4VnAb4VCzozZrcjOgOc3tyRsQQ+q+UWoJ71uGShEYMKhc4QCg83rprix7u
	5XHK3oAXh14GVcwO2mD8/qj655hQ=
X-Gm-Gg: ASbGnctWUMHOMIgkKRfOhdX6jw471GuGvNuGx0OrZh+xF/5DE4QKA1lJg3PXB6CLVQN
	3ykSzvpG52RLFdddOcmwdj4zo4HAGNhLgtGJhetOlbipuUEK8gkxg0nd3CiL+VyePVeDzdgI5
X-Google-Smtp-Source: AGHT+IGV71BrVSUVBzRULlK2Pt6KpF7YBi4BQnrvcjW1l9/+bRE+RB/uC+NL31el3KVvGdiF3SOhV1YZ2erxsOToXwo=
X-Received: by 2002:a05:6102:292c:b0:4b2:77df:4664 with SMTP id
 ada2fe7eead31-4ba46dab15cmr3782035137.1.1738823851187; Wed, 05 Feb 2025
 22:37:31 -0800 (PST)
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
Date: Thu, 6 Feb 2025 12:07:20 +0530
X-Gm-Features: AWEUYZkkt2wiHFRP3Srtx7cJX8lyzJmK5Woq7-prJHKKcRflR6EYpKljS-YNSdA
Message-ID: <CAPSxiM9Yejt+Cgu_ekuQwhduf=JEmS1s+T+nc--SvNQqkQE82g@mail.gmail.com>
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
>
> After all, GIT_USER_AGENT let's you hide not just the OS part but
> any other things from the user-agent string already.
Hi Junio,

The conclusion now is that we should not add any config option since
the GIT_USER_AGENT could actually allow the user to hide whatever
info they do not want to share ?
>
> I notice that unlike user_agent() vs user_agent_sanitized(), you
> only have a single function for os_info(), which I think is a good
> design.  But if we were to go that route, shouldn't we call the
> function os_info(), not os_info_sanitized()?  The idea behind a
> single function is that you cannot obtain unsanitized version of
> os_info() out of the system at all, so what _sanitized() returns
> would be what os_info() without _sanitized suffix would return to
> the caller anyway.
Yeah, we can change it to os_info, if in the future someone needs
the os information in some way, they could use the get_uname_info.

Thanks.
>
> Thanks.
