Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602C4C6E
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997350; cv=none; b=R+n+f1g2OGp6brzkF3HE8ljr19ErB5Q//+9ntlXzFqr+8+mqpHdp7VpqEvJLEvn8DrSdppD3NzbMhSVAh4zMR8t/MNLi/M2GJfV8ISroOGPBihgFYjmMMjbXHjf1jtczE9r4p6pIKpC1EACLSwgpu0+R/jqY1AG+Dnh0NFQXh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997350; c=relaxed/simple;
	bh=AijiBhHQhCVStjueobSl6pnCL+hzPhfOs+t5jyzPfzU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ABHEQFU/GUfU+1p4KfN2qLXf3CejFBZGKETaNBsxL3O8BjncwZJf7bRJmggFMZjS3c7J4wxpvgyYaJyuc2Ixk9+BrUmjWfVYH3Cw880NAzH05uMhggmy+SHil/o4qYfH13G0YL4nDLQKZtdN06lwqmnL4zuh9wWYEeiOAUQYWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxFR7zrv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxFR7zrv"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7d8eb10c06so4308138276.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748997347; x=1749602147; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP9BZf+KqGA9JlTR6Xh+UKwZRE5+dirq6SkxB7F4rhw=;
        b=XxFR7zrv/dyRs7wuOmICKaR5TX6/MY6uwot668IwETVXqrj4iF6d4K3DOpQLbIZzFS
         R8LwdGT/0XK/deWr9kvgZkDrVYZ8/g/zisCoLIT22i9rqEJBdg4bNXECUCE8hJ3ebkuI
         94C8W1olBGY1QaU3WsrJksrUcpXGdr98JUciIBE4hpLv8fe65KcJZzD6E+72uGsSs6fB
         u0Aszk/yYVDxjfyCBrtv9vD9zR9CGwSf0d1v224e5UasSIAejsg2iBmTJ9TBISpj+8Qh
         fW4i0xRO8ayxoHE0RjGSwdEZTH++0w//wF5CbM241C/trRVhcDvn4hk/Chi1SpaFncTd
         ERLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748997347; x=1749602147;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP9BZf+KqGA9JlTR6Xh+UKwZRE5+dirq6SkxB7F4rhw=;
        b=OQi1cMcgqqphCh7IV6b2XD5t8uqbXHg5W55wVcYszaUytvdd037bNrK1nF0E2MqcFV
         R+MtIpYVmzulkcNRfjSCa+aG8MyAz4kbGgFTgE0C9mBak4PQL8RlLddQnm+PBRhaaIJE
         qRk6g3PKD2Amsa3sHslxOfjBeqy5ghWBo0D9teA7aE+mIp7iujoArW4noykL13/D/9yn
         4zxJsfg4u3+3Zte1C31hQchyZCffaMQAix6R/BHxZfwT+oc8UVIgbZydaFFm510JnHoz
         3XOgXDMsRKZmvh3bu1UfexlXaJqgEJh69X6fZF9C00z5FhjVpmOlGZt99Paj19jkqcgr
         yn3w==
X-Gm-Message-State: AOJu0YyRKmf8UTaEUM9cxTswhKEMcDinxldGCIBtBg3wZA+Sqmv7bQKz
	Rj/hovaHCuSkKae1vK9DS8ROgVzrcXf3sIlJ2SPP+p67qinlt1oeFWVU
X-Gm-Gg: ASbGncv6/vo/MpXaUv0ADEs/5YvzIUtZfzDE7Nb7SFCp+t39xmiBi016VXpiYY5Yb22
	/r1dp2C81vf1FJ2lgdohTEm5jVW2qwXPGFxik0ASvFryezhQT6cx2zxNKN4MGeu908TOBALU00k
	D1Qy0zWmPEv176RbLtxvfEV8Um1w5FazYgoGM8g7cLBWX9hUtp1DgDpKw1S4t7uWZ1SLs9YL3Am
	rzRI1992E8bS5M2TMI1xNZ5ovOdcpAfeEYjDgH6FTvtSYiCfxNUcd8EKJKQfwSSrIcvKe+vVeRT
	e48mhvmA8I7kBhDz+x4UvzFvoK/tgtrLMzA+xJshxYvDDfsVJxLCeG5jD2jhwgmEIXxYNFnaohm
	mVjVr
X-Google-Smtp-Source: AGHT+IHIlIuHdqAMU4vxFipXZ3/5jULEnUicsAWJ+9K31yAoUBdyLbIxJIRhsZe5W28BDMoEm8ynRA==
X-Received: by 2002:a05:6902:2c03:b0:e81:4b5a:82a6 with SMTP id 3f1490d57ef6-e8179d9ea59mr832533276.46.1748997347251;
        Tue, 03 Jun 2025 17:35:47 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a6:1600:9ca7:9478:f3c6:e1eb])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e812693b973sm1945356276.42.2025.06.03.17.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 17:35:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 00/12] builtin/maintenance: fix ref lock races when detaching
Date: Tue, 3 Jun 2025 20:35:36 -0400
Message-Id: <BEB56610-BFED-4DF1-A2C1-7BBE812850B7@gmail.com>
References: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


>=20
> Le 3 juin 2025 =C3=A0 10:01, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFHi,
>=20
> this patch series fixes races around locking the "packed-refs" file when
> auto-maintenance decides to repack it. This issue has been reported e.g.
> via [1] and [2].
>=20
> The root cause is that git-gc(1) used to know to detach _after_ having
> repacked references. As such, callers wouldn't continue with their thing
> until we have already packed refs, and thus the race does not exist
> there. git-maintenance(1) didn't have the same split though, so this
> patch series retrofits that logic.
>=20
> The series is structured as follows:
>=20
>  - Patches 1 and 2 do some light refactorings.
>=20
>  - Patches 3 to 5 refactor how we set up the list of tasks to not rely
>    on globals anymore. Instead, we now have a single source of truth
>    for which tasks exactly will be run.
>=20
>  - The remaining patches introduce the split of before/after-detach
>    tasks and wire them up for "pack-refs", "reflog-expire" and "gc"
>    tasks.
>=20
> Changes in v2:
>  - A couple of commit message improvements.
>  - Introduce `die(NULL)` to die with the correct exit code but no error
>    message. This gets rid of some magic numbers.
>  - Introduce an enum to discern the phases before and after detach.
>  - Link to v1: https://lore.kernel.org/r/20250527-b4-pks-maintenance-ref-l=
ock-race-v1-0-e1ceb2dea66e@pks.im
>=20
> Changes in v3:
>  - Rework logic to talk about foreground/background tasks instead of
>    before/after detach.
>  - Link to v2: https://lore.kernel.org/r/20250530-b4-pks-maintenance-ref-l=
ock-race-v2-0-d04e2f93e51f@pks.im
>=20
> Changes in v4:
>  - Some more massaging of commit messages.
>  - Link to v3: https://lore.kernel.org/r/20250602-b4-pks-maintenance-ref-l=
ock-race-v3-0-587d44252dcb@pks.im
>=20
> Thanks!
>=20
> Patrick
>=20
> [1]: <CAJR-fbZ4X1+gN75m2dUvocR6NkowLOZ9F26cjBy8w1qd181OoQ@mail.gmail.com>
> [2]: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>
>=20
> ---
> Patrick Steinhardt (12):
>      builtin/gc: use designated field initializers for maintenance tasks
>      builtin/gc: drop redundant local variable
>      builtin/maintenance: centralize configuration of explicit tasks
>      builtin/maintenance: mark "--task=3D" and "--schedule=3D" as incompat=
ible
>      builtin/maintenance: stop modifying global array of tasks
>      builtin/maintenance: extract function to run tasks
>      builtin/maintenance: fix typedef for function pointers
>      builtin/maintenance: split into foreground and background tasks
>      builtin/maintenance: fix locking race with refs and reflogs tasks
>      usage: allow dying without writing an error message
>      builtin/gc: avoid global state in `gc_before_repack()`
>      builtin/maintenance: fix locking race when handling "gc" task
>=20
> builtin/am.c                |   4 +-
> builtin/checkout.c          |   4 +-
> builtin/fetch.c             |   2 +-
> builtin/gc.c                | 410 +++++++++++++++++++++++++---------------=
----
> builtin/submodule--helper.c |  12 +-
> t/t7900-maintenance.sh      |  19 +-
> usage.c                     |   2 +
> 7 files changed, 263 insertions(+), 190 deletions(-)
>=20
> Range-diff versus v3:
>=20
> 1:  e46a65951b9 =3D  1:  280f13d2895 builtin/gc: use designated field init=
ializers for maintenance tasks
> 2:  73cd67f3e1a =3D  2:  16a017fb819 builtin/gc: drop redundant local vari=
able
> 3:  a02452a6d6f =3D  3:  0ab3344ddb0 builtin/maintenance: centralize confi=
guration of explicit tasks
> 4:  ccd7691e4d5 =3D  4:  69e768cb54e builtin/maintenance: mark "--task=3D"=
 and "--schedule=3D" as incompatible
> 5:  0e243fd81e6 =3D  5:  295e9e5ee9f builtin/maintenance: stop modifying g=
lobal array of tasks
> 6:  c95bd62823e =3D  6:  d94b0c86622 builtin/maintenance: extract function=
 to run tasks
> 7:  43d28434d8e =3D  7:  0bbba671cd0 builtin/maintenance: fix typedef for f=
unction pointers
> 8:  d5740a5c9d9 =3D  8:  4ce38539bb6 builtin/maintenance: split into foreg=
round and background tasks
> 9:  168eb3a9372 !  9:  28092b9bed1 builtin/maintenance: fix locking race w=
hen packing refs and reflogs
>    @@ Metadata
>     Author: Patrick Steinhardt <ps@pks.im>
>=20
>      ## Commit message ##
>    -    builtin/maintenance: fix locking race when packing refs and reflog=
s
>    +    builtin/maintenance: fix locking race with refs and reflogs tasks
>=20
>         As explained in the preceding commit, git-gc(1) knows to detach on=
ly
>    -    after it has already packed references and reflogs. This is done t=
o
>    -    avoid racing around their respective lockfiles.
>    +    after it has already packed references and expired reflogs. This i=
s done
>    +    to avoid racing around their respective lockfiles.
>=20
>         Adapt git-maintenance(1) accordingly and run the "pack-refs" and
>         "reflog-expire" tasks in the foreground. Note that the "gc" task h=
as the
> 10:  0ff01f6e2aa ! 10:  b8ed080c67d usage: allow dying without writing an e=
rror message
>    @@ Commit message
>         usage: allow dying without writing an error message
>=20
>         Sometimes code wants to die in a situation where it already has wr=
itten
>    -    an error message. To use the same error code as `die()` we have to=
 open
>    -    code the code with a call to `exit(128)` in such cases, which is e=
asy to
>    -    get wrong and leaves magical numbers all over our codebase.
>    +    an error message. To use the same error code as `die()` we have to=
 use
>    +    `exit(128)`, which is easy to get wrong and leaves magic numbers a=
ll
>    +    over our codebase.
>=20
>         Teach `die_message_builtin()` to not print any error when passed a=

>         `NULL` pointer as error string. Like this, such users can now call=

> 11:  93f53000e47 =3D 11:  5b149886263 builtin/gc: avoid global state in `g=
c_before_repack()`
> 12:  01095d1bf88 =3D 12:  9ba01f143b3 builtin/maintenance: fix locking rac=
e when handling "gc" task
>=20
> ---
> base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
> change-id: 20250527-b4-pks-maintenance-ref-lock-race-11ae5d68e06f

Range-diff vs v3 (and v2!) looks good to me; thanks for taking the time!=
