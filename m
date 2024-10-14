Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA194A1C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 04:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728881132; cv=none; b=L4JzX8nH/0+/nUYzsH9BdZq8dO/tMhhp9vliVezZ9CJ/G5VK4ie5NATAsvnf+dA28JChWgSuoE6/ug3YuEZZ3dCEJJYxri4jZm52HbaG6DwoJDHmD4SX/88PQUcf05+2H69/yMexG5wjrQKFxT2qd3ZS4uwfgO2fzlhkONXPOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728881132; c=relaxed/simple;
	bh=07hrMNUQdYDYIV5DrLfkG9j5llR1NRXQru0xw/HjuQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5iGK0BHe7k5RGgv446S+lkosYLn+CzkrldB/g+yVsKAMipVC5YK4yCsVbcOPqoO2R4YVF2DWLxWikUccAVODWM9smxzEuCamCYgHsRtvBAwSh2AxszIFHPCzQqlMN9Io5EjEaebX6d06y6dmIHQNyvPX7mzkbFzdmA89d9QYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyEVJ832; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyEVJ832"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so2296311a91.1
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728881131; x=1729485931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNXNwYe9HSXhx1+SA+cicU2zzXXVzgPLzP+JHjWGp/E=;
        b=KyEVJ832XbRxobRd0+NWvGj78PLycXmbGzmjskCpA82dCeEgVewt1lmbGMirTyPUR0
         n63ku9qfzWLVO15VVcmxut/3kChmdr8fMxNoYRcgDcG0SQUeem/TrFGeAUrmsykwOWp4
         N2JmeatRvBJ9bKdYBkB7jTcnWV9BNt5EnNpH+0NT0TwoSkyFtXbe2deQTkSDqzD3NPep
         vGk9slTkEKdpa37+9WhxloIQOow4jadRk7L6ddgvAElErT5Pk7mCD+4lRcq+WV9BLQI6
         ESM6auCTt6cdxeIcRpy3nrOxJ63i/+ONKFz/eWWUZxVkObmfqhfHLA1Vd81CHUhQUz6R
         /vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728881131; x=1729485931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNXNwYe9HSXhx1+SA+cicU2zzXXVzgPLzP+JHjWGp/E=;
        b=ouzZXeUXRlU1w3RjWs/rLuK9H3PhQeaVuo2NiZPHwqztSWp8m66TBymqdnq8h99XsA
         wtSQ/3qDvpntG+hcCKPHU8IR0CZ1lKQhpZUPZ/JGNfT24SEr+630lNDYRTcotnt8KvkC
         DnC12oagyjC5E3g4MpoogInSMV/SATpGYLw1X8Ol+y6FiXIxRdvQ7+YZBwDT796bwBb6
         dLInhsPoPxxxg18P4FPcph+/1kxWUTmVuz5hZe8XMH4IFtnVX9wt+zn4zHxzwGZyshNY
         f8WJCh/ffGcifAn8OTVlTtJ63NN9qrurJ2LnhZAt+hpNA/hB5HvTp0Aoi2JVEIJ1yzLY
         sZCg==
X-Forwarded-Encrypted: i=1; AJvYcCUPJ51+pbvbl0sTA36ntkGaYDZBnuoZQIr9ujhTnNU655Zc8O2rLd519pTkp9f4TcY7l5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmN1VH7AQXFdyLaQcHm/L1vthBtG8M8+bglFt5W8FMfQQ49joY
	f0D3hqFdQ8acqTw0WvUbq4Yk2ZW5spSBLfKvOTYe63I/dpWgnVNeiLJ1mFvxt+FYf1kfFglylgX
	nqdziv3GCpTyRaqpbG3zVSCE+L9jAMWNPu1Q=
X-Google-Smtp-Source: AGHT+IF5oqu9WoCIdhGG/3af8T4CN28qM5jFar01TY0EHGgRLOvUH3tEjUINjSbSuPSMwWaW0ccQK2/+r80bcUWqP0w=
X-Received: by 2002:a17:90b:4c43:b0:2e2:f044:caaa with SMTP id
 98e67ed59e1d1-2e31538fb87mr9271320a91.37.1728881130433; Sun, 13 Oct 2024
 21:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
 <a5b1433abfd84cb627efc17f52e0d644ee207bb0.1728538282.git.ps@pks.im> <xmqqcyk7lwa4.fsf@gitster.g>
In-Reply-To: <xmqqcyk7lwa4.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Mon, 14 Oct 2024 10:14:53 +0530
Message-ID: <CAG=Um+3=SQ7bZYvr4BNxWgMBNreQHgfs-0VQwkzBq=HW8Zxf=Q@mail.gmail.com>
Subject: Re: [PATCH v3] builtin/gc: fix crash when running `git maintenance start`
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > +     write_script script/systemctl <<-\EOF &&
> > +     echo "$*" >>../systemctl.log
> > +     EOF
>
> Ah, for the purpose of this test, we _know_ in which directory the
> "systemctl" will be spawned, so this is good enough for us, of
> course.
>
> > +     git init repo &&
> > +     (
> > +             cd repo &&
> > +             sane_unset GIT_TEST_MAINT_SCHEDULER &&
> > +             PATH=3D"$PWD/../script:$PATH" git maintenance start --sch=
eduler=3Dsystemd
>
> I suspect we can use the same idea and add a relative path in $PATH
> for the test, perhaps, even though it is not a good coding
> discipline.  If $PWD, instead of $(pwd), works, it is perfectly OK.
>
> Will queue.  Thanks.

Appreciate for the quick fix, Patrick.

Homebrew upgraded their formulas to 2.47 rather quickly (the next day
after release) =E2=80=94
https://github.com/Homebrew/homebrew-core/commit/0435f258701abd3acb9e2f4cd7=
58cc13aa93997c

Mac users who do a `brew install git` would now install versions with
a broken maintenance command.
Fortunately, `brew` auto-updates the world every time a user installs
anything so it's likely they get to a 2.47.1 in the future,
but that still might be a while away from when they install the
current latest (2.47.0).

I'm not sure if Git has a hotfix workflow, but it might make sense to
prevent more users from getting onto the buggy version
(especially since repo admins usually set up maintenance in the
background and the error might not be evident to users).
