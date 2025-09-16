Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3F032D5AD
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042237; cv=none; b=olkHiqFgNfeKt1mPWZBqzUFfG00jw017N433ac5N6VJRBJgS29jb7wMISrg2x6G4pBxKSTn75BgbtJkxBbWopNL0gmlpjTG7TyIpaAqvpBXm1p+X2LJCPdgOlDPCSn5aG0SNESfTUQPtef1Jfm9W/C/K1QsIOCbEejyRQhUUFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042237; c=relaxed/simple;
	bh=Rbrd6xbAoDf1uKGoKSdXI1jad7s5JUg76qv3Z0PnPwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evAxHkIpo/vi4RKDtw6PseaXNGSOmyBtxd4k84GcplCD4AGqMXl1zYuIkdLU53X1igD0yD46gj91apI0bQga9voPr0NHnBUpnBRdkHZsUhiEDhpyGFSixHQYN9cx+XN6/8WgYexfVymVtRlRqFAto4rg9Ln3WjNy4N+GNjvaKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnlfIimD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnlfIimD"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-627b85e4c0fso118392a12.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758042233; x=1758647033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5W9wstObsTjmQzJMALAp3D/LIOcAqVQPj0UBR/aCB0=;
        b=QnlfIimDD1Wnofm7/XmVBRd5XsZUc/lOCOqns8dllZe+NG9EUSfjWLw9bM+n+lwCxU
         u5+KgphxMZGtpb1JqhPU8/g3raHUsF/S61L2DEqatS0VNs2L26G6londXQSG9pQND+ON
         Tp0517ZHibn5LGhZcjZAzsY8OsaiHBIuQ7jlh6Dv9rCh3DgqKVcnNVUsNJ3sc82heqQp
         jfH6ZG4Xx/+7NCA843K73I196ASxhqQS1fv0CtEOIevdODeBRVG8u7JEA3SvFs5V+Lad
         0xLjGae/JR26ForsGoOESpW6HZCSaIi67oBzAcIzzKyQ0AWta1q7eqXf6UstFbgsyZfm
         0ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042233; x=1758647033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5W9wstObsTjmQzJMALAp3D/LIOcAqVQPj0UBR/aCB0=;
        b=XLHpHhwHpt3EBwV3WuJsiLG0tGHU6+0U5v22vSR0OXR3UB4wAEQOY4bvnzjYMDkwK/
         wI0wafTTTGOv5/GE8K0pZAGYmDbTE+MAmRASTNLv/zmgODSTRKp9u08NypnTCW3ubktV
         AL5LBBoAz3bRo6j86mZxBdmoYShJkefLoZdzCEwYhbkpOTvwsW+0zzNPJdySoRRwDMBS
         JQWXAMACxSoaSLa8MdIEmCvtD+M3c2A1h21n6LpPYXeAL8afKPlJyUij2Oi0gykNRD/l
         HuxRnEvGFKZuTHPWUiMjdq94dsDbqtRtaiez7dvsZZYoXhAO7j5md1zOkcPm+LNVHqvZ
         I9yw==
X-Forwarded-Encrypted: i=1; AJvYcCVoC21IYtBuIZjiztZi6zvY4P53D6OhRiq5PS3Kt0ZETgLl2hjp7DSoie6WeG3Id3tPzg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqyGmQ7sSFw2TUIGfX/gAer7gwxadLDkwsN65zsFD+Jjqht6Lf
	cc099aQMF55Jcsr67ZgScUNwq2un12eKDALoGF24gNyDDVoKWHIv0RE8b3rEP5QRZbbrgGgTx50
	mQ5h0ihiFm59W5vrRz4i8+BilV+jdEjpolZBs
X-Gm-Gg: ASbGnctrQKklz7r3Wqcb7GwQiNycKNsiWar+UjQ+UC+4NmlGEueGCzXN0jo/kZeXH8I
	mCWl5pjhJxW0i0ZzRkuR1mMOkLlNpoCBBm1slbrzXvLokHdHD95++BcaCxHtJ19cpr9EfOXA/9y
	EXfAb/wxOHzEdyaBgBbmf9tRyLqZrwKHFSPHpzFoKOBkpzpF/qzIpdbXbSWtuGrv+FMaWfIDSAp
	w/LnFpycVBhlopL+CNQRPWKgQG+94tPpnwoJNwf6w==
X-Google-Smtp-Source: AGHT+IHtx58V8n5IVVmWW/Yn2e4AnLg4iExZyiv6QgxvhgaziAjZdDajiUytxD5/ukhN5KlAlZDvPrFTFKvDDM+Mgh4=
X-Received: by 2002:a05:6402:e96:b0:62f:4357:53ab with SMTP id
 4fb4d7f45d1cf-62f65f39bddmr2221784a12.13.1758042232633; Tue, 16 Sep 2025
 10:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BEzjk0PLEMjtk-0jQOAag-s_iJkKMbcU+o5vv8BzRVV2A@mail.gmail.com>
 <20250916145032.969133-1-phahn-oss@avm.de>
In-Reply-To: <20250916145032.969133-1-phahn-oss@avm.de>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 16 Sep 2025 13:03:41 -0400
X-Gm-Features: AS18NWAA_HhMThpGPpdGwYiOZnLE43Q-KkhbELZP2OeBevmWLTpwyBGnt787o_I
Message-ID: <CALnO6CAbUNgp6n4kYg1ATCC1mHa7Z2m3d7FZwaYrgtkMLWR3-w@mail.gmail.com>
Subject: Re: --shallow-exclude=ref -> "ambiguous deepen-not" error
To: Philipp Hahn <phahn-oss@avm.de>
Cc: newren@gmail.com, bolide2005@163.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:58=E2=80=AFAM Philipp Hahn <phahn-oss@avm.de> wr=
ote:
>
> Hello Elijah,
>
> On Mon, 24 Feb 2025 at 07:27:55 -0800 Elijah Newren <newren@gmail.com> wr=
ote:
> > On Thu, Feb 20, 2025 at 12:27=E2=80=AFAM bolide2005@163.com <bolide2005=
@163.com> wrote:
> > > Case 2: git clone --shallow-exclude=3D<rev> <repo-url>
> >
> > The documentation was fixed for case 2 in 00e10e07510 ("doc: correct
> > misleading descriptions for --shallow-exclude", 2024-11-04) to point
> > out that this usage is flawed.
>
> I have searched the archive and git repository, but found no explanation,=
 why
> that usage - shallow-exclude by REV - is considered "flawed": I understan=
d,
> that the current implementation does not support this, but is there any
> technical reason why that is not possible or undesirable?
>
>                      A---B---C topic
>                     /
>                D---E---F---G master
>
> I have a use-case for this, where we use GitLab to run some linters on ou=
r
> merge requests (MRs): They examine the commits since the fork-point "E", =
for
> which they need access to the commits + trees + blobs. Some MRs are large=
r,
> some smaller, so there is no fixed maximum depth I can give to `--depth X=
` and
> be sure to have gotten all commits.
> Same for `--shallow-since=3D` as some are dormant for a year and many oth=
er MRs
> by-pass them.

I might have misunderstood, but aren't the commits you're interested
in here the ones named by

    git rev-list master..topic

?

I see a mention of git-clone in the quoted reply, so perhaps you're
trying to avoid cloning too much history. I wonder if a blobless clone
would suffice, which you can then add to once you have the list of
commits produced above? That would fetch more commits than necessary,
but should still be significantly cheaper.

--=20
D. Ben Knoble
