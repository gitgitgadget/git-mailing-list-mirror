Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591D14A4DB
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404060; cv=none; b=iQtT9k2oI6MdoAP1VM2rsFrqx5NeUKenmWr66HIIumkkZEFJEi2+tlbAyJ/e/tVl+MHmupZLtGhxzqfyFmagbe5DXwGxRtX/GrN4YL0/8PsLDYp+tQzZHhd/ZG0ECHYjEGDZacLbDnK4vqMfPn2wTmr+YakQmneb2EY+smeSEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404060; c=relaxed/simple;
	bh=Nz6+5bNEyEW3C9wCW9vt+qpHzmrtcDvXRvm2cR/sdJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0kcmRccGuyXq8DgZLNRIBswnLoH2eG8H2jo4VrJ6af8NHjwQnOKNjSMwBWKeF7wtibSEeI9kcFF1kYqEokxGcZsmnt0tQduLdCQhqNiC9yegL74oGtnUArpnHHvCEZnd40kbpavSEN6fAUSehUwFCJ8oKvLg8BbnA0khouQjLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qej8wYkh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qej8wYkh"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso4054253a12.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757404057; x=1758008857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/3FiZRFAQX/BYbUUQsqEym/wH44JPonL6FYNBlf6sI=;
        b=Qej8wYkhLDqf2NFcfPQx+W/gllknhjuotSoPrM8w/RRSREJyebvDp+sbbTAW79RrmO
         rvR7F8VzOhXQGsNNhGjbTbW6s4JXMUo5pvnmIENO1X3Pj9rhtewWUO6TmlGEok+4sIAg
         ueuLtNa4d7saRJ/+HLVjcH1RBl1jpzX9Qh9Va5bLAg8h9TfjJNxCGTMYaZj1tEJqKrtz
         FGtAR/dCCscFwbDw3xSv9dk14P9m9wFWilwR68TUrCtdA9jwK3k8y7Ax/rBPwPTLf2SV
         +80/D2k973WhEtao8odr52NzjrJxzc8la376lLVd3bpNH45QLADvBVMdlIkKipcCKF24
         hVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404057; x=1758008857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/3FiZRFAQX/BYbUUQsqEym/wH44JPonL6FYNBlf6sI=;
        b=AYFrbIyGhc7Y27++4RG1xzrLm+WZK+a43tSW81S7e+M9BKIJ3FICtbK83VQZhrQZU5
         J40noDO90hVVYaNcHXErAqxXGE4OCfGnvxnpAxEkfMLKwgcj3b7gbAQOxDVmSHXn730U
         zgDszvam3BiKkSl5uHcwz4T+GeA/qfbgTjoMPORN5hwPK2k6Isx9gzTkLp9aMxXiPuod
         P0e1eMHTYBqeRcfiZ4ynE8bUY9foXGTzxL2QpQWIsGsuABs8Xx9/+vaZ/qkueNTFVuRx
         bejTf85i/I0EP8lQLeiE3z8gEPDLw6DIwyycaVEyQuO3fE+LOMomgCuT5E3/qLSamyKx
         pjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjluVjzcLRSxR+/VoJB24JFJ5xbjw8dhCppOkQeCffxw00dq+eB7FvKvp2ohZ+4iORyo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbO75/X+riDwuIxWltrrLZkRcKBfD3IMO4mgsHIvkHy/V/gT5J
	dcTaSiUF/3NuQf7esNdZXsdmLWy+lynlwMUnkw3z2zGeEn/tZxVa2EiTK2/Lmn4U1ZXT2Tijjpu
	aCTXCsJys+PUNm3LJ0TQDNq81DiGNfLE=
X-Gm-Gg: ASbGncsLdcha/DrUTgO+b+nIpaNJzyFetgZyaQsjKceI1P47Q432oFo2tMkV4tyjY4U
	CUpIevxShfv/D3UXW6MbgQ4U3PuKQptKGcDQow9EWTxycRpw6a+t/V9rxIKbttVzx0Z063V90E+
	Rk4TkvYnkoQABmwR0rK67e2ndFGZ7sU3AnM/K84UFUO8mwt9v9un3WdAL+vzKJKexHIvtMcZSzn
	QUTBrBQDpvhMZS42wex4ok/mBgsEZg=
X-Google-Smtp-Source: AGHT+IG99kK2cZ46c9jn0QA08cVxr6wPRTJ+ntVwmmGExcYpQiqLNftQGbTsvlwLwyHANIHFmrQGVbJVk2feQTERYXM=
X-Received: by 2002:a05:6402:24d8:b0:621:7d0a:151d with SMTP id
 4fb4d7f45d1cf-62377f89744mr8233305a12.30.1757404056540; Tue, 09 Sep 2025
 00:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com> <CABPp-BG6A_mwxQheE5ED5HQj7STVtf1_9NhSmjmzRPB7QkdWyg@mail.gmail.com>
In-Reply-To: <CABPp-BG6A_mwxQheE5ED5HQj7STVtf1_9NhSmjmzRPB7QkdWyg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 9 Sep 2025 09:47:24 +0200
X-Gm-Features: AS18NWCnGwW8pOPPFkr9prX0lWjTBYRKdbxX1y2j2vw3m1GYCpK7emxym--LzEI
Message-ID: <CAP8UFD3GU5Xwq7WMihmHtpWc-GjB-guTU6JHG7BdkhxukMihNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] replay: add --update-refs option
To: Elijah Newren <newren@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, 
	John Cai <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:14=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Sun, Sep 7, 2025 at 9:36=E2=80=AFPM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:

> Seems fair...but why not make --update-refs the default and add an
> option for those that just want the update commands?

If this patch series had been sent a few months after `git replay` was
introduced, I would have been fine with this series making `git
replay` update the refs by default while adding an option that only
outputs the commands. Unfortunately `git replay` seems to have been
introduced in v2.44.0 (Feb 22, 2024), so more than 18 months ago. So
even if it is marked as experimental, it's perhaps a bit late to make
such a relatively big change in it?

> > The way it works:
> > - By default, it uses atomic transactions (all refs get updated or none=
 do)
> > - There's a --batch option if you want some updates to succeed even if
> >   others fail
> > - It works with bare repositories, which is important for server operat=
ions
> >   like Gitaly
> > - When it succeeds, it doesn't print anything (just like git update-ref
> >   --stdin)
>
> Seems fair.
>
> > This should help with git replay's goal of being good for server-side
> > operations.
>
> I'm slightly confused by this statement; there's multiple ways to
> interpret it -- various antecedents of "This", questions about whether
> you are saying git replay has one goal or you are just helping with
> one of its goals, and leaves to the reader to guess which part is
> helpful (is it the ergonomics -- why does that matter server-side?  Is
> it the atomicity?  Then why did you also add --batch and --update?  Is
> it something else?)  Perhaps this sentence can be dropped or
> completely rewritten?

The way I understood this sentence is that `git replay` is already
useful on the server side (because it performs all the operations in
memory and doesn't need a work tree), and the new feature added by the
patch series reinforces this because atomic operations are often
better on the server side.

Thanks.
