Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7812E62D9
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868574; cv=none; b=XgUE2wcmWbkacUv6Yhwneg2Z1cCJZvA3SM8GXlimbktDyQN2XxH84IlEpBOV7XThKhqou8g9ANJxuPQXQ6fM8iIp1WJTTbk/GN0XTKBR2FFc9ll5Fx+GKK5+9+n7SA25zBA+3JURh2Fu+yDA6scLkBkjaoX+8Q3FGFDmLLF3tDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868574; c=relaxed/simple;
	bh=oc5B9VfAORiYQfifoMq2z+nf1n/Iegd7bRzWf1k8l/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHpHofSg9QUAK8DYkQdUgAu7Klq/gkwMK27TnI07S6hOU074nJQEVKtgyZ0tYYzq3bpFjPG31x0w8p/TUUuPbUJ63EIDwxZseGkmkcqs8A9gGIccgncXp4e+cJ/z5qkaGiwJSH4/pNqyxuaYZfWdTPmXyuORrWUkJA6hgk7CRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQDD4aS3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQDD4aS3"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so700625366b.3
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868571; x=1763473371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKtNhxjsmWDzq6CwlgwmbkFZzt5qmsJ0BT7YmL6PHEU=;
        b=CQDD4aS3L2dIkHYktW2fAYzUG4t+bkXvuf6zMRthh81ybM5FtuntDnAMMVJwmw0TI/
         Kvwhqh79StuKvXLt2YranU8kdWv6h3o56Nkby0NBlY3JwfjxREDhSxuc+MgRv5dikXVM
         QXPEsyUxKpvP/w4Lqmby356eRJ11iHYhARbPBpecx96b8VmI8AG6lQWy6A6WWM6WwqAX
         AKk9AMUVWvBD/YkAuYYiCQKuBLCbjdhoaF4eaHmbKdc4Jy/JzJkbEk/6NsKQV2Tj36u6
         kOG7w/YsXXHcrupfGzhQxUmqW2gO+VpEiytDsZ/In5d/O7BSK3m3j/8K1J+k4h8mX1Za
         vxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868571; x=1763473371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKtNhxjsmWDzq6CwlgwmbkFZzt5qmsJ0BT7YmL6PHEU=;
        b=iUNFc7uaj4RTF/UaLN/SHptdc4oQ4TGBdcha4d9xnZGVjTSljUpIXxmiTAWO9WEOCv
         i6OrzvdfKeK/C/I1Bo+KezurdKa+lu4fKoPbRBoR1gpif+DOdDIHHRwzt6n+MfCaOE5o
         uIfycHvnDIdIhVlq/qg5o2wf5UXshUI2foPtJxcVmWKtRt2jTND0gkisXfBx3yirC5ba
         0oMXDMXC+xs9C3aXRZ8tmoZABRlEU/NejncnRG+to/mImzkF5/6GEQt68AUT0AElGGdm
         mxQSRw7AfpyhCAEwKuQLFJyWvGrOQ4SPsdN4hQhHngqo14gaYUChvzcAFCGXGJYo59VG
         vJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXppkkp/KRmOJDpn/QNN82RmaiAUrFz57WR6hu257y0fCchPmcKdZ09DMXsi3YrYwQcKSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLaFxh5rHbsajqMCwx3WY3ynCy7Qd14BNEzaq+cBHYFsFmDHb
	pPmuB9pkDmG/J8aVpBvb3sQytIzJoFI3Unx0/N+Mj4SdLjcQmdzIN6Zp0XTktS8RSc3n/H6ACLN
	SDbYo5AsP8/iBRYOjYFeRJ/LVidF2LEQ=
X-Gm-Gg: ASbGncsFpLgT7CEVN4B5xRltS8PLHnEasd7ZuesVr+TmOpv5m39FPM7ctff47EKU/HH
	LHO8rZQV/Wc6qS6KuzR2v+ETvTiF/uQnynpylGnRwD9KSssncoXYIqekPn6bY+Lzur+RZFpVnHy
	97VAb0sNPOt/9/yxnUt4/2PNVWy2Qeq5QpSvhQuVE/paIilrqB/pz36jijiNkcEypve7AkMCkhy
	AYFM6AMp6sHUaBokCFMvvEhGEKgHWf7m8H0e1I6jJbyxRLVL4k47fkG3dmfsI3o9FkNegkou7cJ
	VZRTz+G4gCiE
X-Google-Smtp-Source: AGHT+IEKf+yFvqZkBDU+KG6TwnBgzT/BwBr0nMyRgxMB7RgJghHWNbTeqdFgKqIVyZ+CiLURyRySNkxz5RGiTAPrk10=
X-Received: by 2002:a17:907:7b96:b0:b40:fba8:4491 with SMTP id
 a640c23a62f3a-b72e0310d6fmr1405077666b.17.1762868570507; Tue, 11 Nov 2025
 05:42:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net>
In-Reply-To: <20251110201136.GB127132@coredump.intra.peff.net>
From: ZheNing Hu <adlternative@gmail.com>
Date: Tue, 11 Nov 2025 21:42:38 +0800
X-Gm-Features: AWmQ_bkbE6UsFLKHQAcPdABZ61SWy6mHi3jjTk0h2bYL2JcdacQVtFPDbOjvtTw
Message-ID: <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, phillip.wood@dunelm.org.uk, 
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> =E4=BA=8E2025=E5=B9=B411=E6=9C=8811=E6=97=A5=E5=
=91=A8=E4=BA=8C 04:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 10, 2025 at 06:01:57PM +0000, brian m. carlson wrote:
>
> > On 2025-11-10 at 16:50:04, Phillip Wood wrote:
> > > On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
> > > > From: ZheNing Hu <adlternative@gmail.com>
> > > >
> > > >      This patch introduces the --committer option to git-commit, pr=
oviding:
> > > >       1. Consistency with the existing --author option
> > > >       2. A more convenient alternative to environment variables
> > > >       3. Better support for automated workflows and scripts
> > > >       4. Improved user experience when managing multiple identities
> > >
> > > What's the use case for the same person committing under different
> > > identities? We already have a config mechanism to set different ident=
ities
> > > for different repositories but I'm struggling to see why someone woul=
d want
> > > to create commits under multiple identities in a single repository. F=
or
> > > scripts it easy enough to set the relevant environment variables if a=
 tool
> > > wants to create commits under its own identity.
> >
> > Someone who works on the same project under both their personal and
> > corporate identities.  For instance, me working on the Git project.
> >
> > Some open source projects also require a CLA and you have to use a
> > particular address to match the one that's listed on the CLA.  For
> > example, Google requires an address with a Google account, so in the
> > hypothetical state where I was going to contribute to one of their
> > projects, I'd need to use a different committer identity with my Gmail
> > address.
> >
> > I've also kept business logs in Git when I had a small business and I
> > might well need to log approving a profit distribution (with my
> > corporate address) and log accepting a profit distribution (with my
> > personal address).  Those would need separate digital signatures from m=
y
> > two different email addresses.
>
> Is a "--committer" option the best solution there, though? I'd think
> you'd want to set user.* in the repo-level .git/config (or using a
> dir-specific include) would be less error-prone.
>
> That doesn't help for using two identities for the same repo, but in my
> experience it is easier to use two separate repositories for that to
> match the organization of the work (even if you may sometimes fetch
> between them).
>
> I'm not totally opposed to the new flag, and in general I'd defer to
> people who say they find a new feature useful. I'm just having a hard
> time imagining a scenario where it's the best option.
>

Sometimes it's because I forgot to configure the repository-level git user
config and started development first. Only when I tried to correct the
committer did I feel the pain.

> -Peff
