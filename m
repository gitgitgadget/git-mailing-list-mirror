Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2917B508
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014116; cv=none; b=ukiNqaMwXlwDmPUcZQ1WkGtIbX7p6d6aOvad6tZRjzeUZwe3Kn7Rh04MpKVmtjW7/RELS1WL4C25ZHEe2NLWJgYa0rpIRU7hIrWPNW6ENWxb4MuCZ/Kq07BD2Bj7dc0MCw0QBN5sW6vECdKCl3DwyBnRWN7oP2r2vZbECIf2WKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014116; c=relaxed/simple;
	bh=quwNNkCOnRGCa8mVRiCzj5kOlvHJ+PlJalJIh2ZOctI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVlW4sMGss86VHVGGEnCnsXIjMwLrR8yXXtLTjEXyR9NNcDG4eCMXOx+Ve0SCGqnAUBCe+ScjWOBaRDzqWsmENy/ei4w3iVz841YV5Yst3YTahiU5ozWcAIsu5KivSqnwXIiXwAJhUETyY7uGTfoD8B8z7QVvb2+iJKSWl76h/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMsTr4h5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMsTr4h5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6b3afc6cd01so21471357b3.1
        for <git@vger.kernel.org>; Fri, 30 Aug 2024 03:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725014114; x=1725618914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quwNNkCOnRGCa8mVRiCzj5kOlvHJ+PlJalJIh2ZOctI=;
        b=SMsTr4h5+rR3ome8VU2Y0OwOcL67Tjes+a7ltzWRUjrjxY5l2NdsrkTHdzxIoKxEML
         ahBbCoY0FBAbZIyd5KXIH8AzHeWoSxuGy1/ut12WC9KAcIlH+3EpdC4gXqODlEasdZ5l
         +NFSqJtko0b3D9MGxWes3i7X+frrLLsM3IUDshua577QAGf40suQt8oS1lGlAey8eWIE
         wmg11hSZN2XB1kCSj/iDsK3WOmjjTAkhQMboygZoQJGosgoCEy+Cgo+eekKttzGDoxAi
         4CBmFU8ntZ6l0dqs2+orq+zKER50JKIiF1yiajFL4FgUZfSaMFU1dqaVDKoXBKrAoKgO
         zwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725014114; x=1725618914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quwNNkCOnRGCa8mVRiCzj5kOlvHJ+PlJalJIh2ZOctI=;
        b=RDUFIpNhytjWDXdjpbN+/3YoyavmsfLJ2QI0RN8mu1zA1SjIAZM81CcZpl1UAYJzZo
         k0J0s2Gu2frHowYQBTuskZpTUDjlaF2ZanvmvtM//TD1eHb7rytkdM2VESCjKpRbWZ94
         Ea26iEiOqAERTWRMWn+ZIX+vjverBMJnl3oV0VMD2spBS0Tmm6vGkdyYWl1ouaVMkM7U
         qX4K/BdsdQjuNsBXYZV4gT6SXNWsBhNR9DhGF3p4n6OXegNhJ96I//Fx0Oa00YgpeI30
         rL94gZDdoNznoDpHKCYOJbd2Imj3J6B8zCJSdbMYdBjV1jRliAtutkFqFd5hjuoShMPq
         hIKA==
X-Forwarded-Encrypted: i=1; AJvYcCUrfQAl9C3nnVLEYZyNbG8JQivweZSP8a75rmkVYb/BCDsWXwJZNKHrPYLnKxuS61bNWE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpCpTR8mazaKz7Z9sU53cVMw/TDcWacCv+dC5ok3BrD10gkbx
	MEB5b4gt3c65WdczHouAoQZ9PJUZztoVnlgAa9MHiM0vvKT4WMemXeD0CRT7w9d8xQp9FpXzMEI
	w3xnca/I6mfk6oBH5IUorvs9B6o0=
X-Google-Smtp-Source: AGHT+IE6MVyrOpIwb5vfPrCXxb5cBe114tCr83y70sYLeGWJekHbI3KOvyHJ6gNwyfFxl/dueqcWS60ZE1af0mGezF8=
X-Received: by 2002:a05:690c:62c3:b0:6ae:c229:158c with SMTP id
 00721157ae682-6d285637160mr47531067b3.6.1725014114375; Fri, 30 Aug 2024
 03:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
 <CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com>
 <20240829214336.GA440013@coredump.intra.peff.net> <CAChcVukzk=-1JNAoffWQEEv4Ne1FozGEwzGuaUWuiwhoHkcUng@mail.gmail.com>
 <20240830003147.GA450797@coredump.intra.peff.net>
In-Reply-To: <20240830003147.GA450797@coredump.intra.peff.net>
From: Pavel Rappo <pavel.rappo@gmail.com>
Date: Fri, 30 Aug 2024 11:35:03 +0100
Message-ID: <CAChcVu=MSLr7Gaf8nmQdVr=Mm=nXkWEjMd9MNNM3dcr=-1igDA@mail.gmail.com>
Subject: Re: How to turn off rename detection for cherry-pick?
To: Jeff King <peff@peff.net>
Cc: Elijah Newren <newren@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:31=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> <snip>
>
> I've added ort's author to the thread, so hopefully he should have a
> more clueful response.
>

Thanks!

Some time ago I created a gist which might better summarise the issue:
https://gist.github.com/pavelrappo/3b1cd89b6015ab0eade1b11876d563ff
