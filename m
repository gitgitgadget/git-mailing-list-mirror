Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187CD2D130C
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966128; cv=none; b=ZLh8+moCZSxcMQPl8y2IHOsEAp6FLTJH25T24sR/VeW6Ae2/d6yeYCVPTWHUKjuHQPS23OcB2iEzASaP1Foed5mobg82YDpVrlAAfYY+aoESnFjBVfRUghLF5RnJnrVaWr0XnfAxIlwIkmyZB1OFPcz1yDfioygQkrvCFNpy5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966128; c=relaxed/simple;
	bh=YHXEiJKqmfz8OTk6rMY68KsnU4UPOzuajkg3afBSxik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv6MOFGobi6NoCGGbc46xlxHKgXoF+kR5D0/97KeTaTNtiLwNbkFuubC2G9eMctQU7xgEN6SWBPvHqCbY/dCeOcx/HC6AyK1XNl57Txk/ADk1tLtrRWhL0GEOwX95W1n44SHnuUl7rK/pZRUNkeA+hxv9ZHSp47JgHZbKw5u0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsw+zWvk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsw+zWvk"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso673671a12.2
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762966126; x=1763570926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xU8q7MblhALQM2wuKXIsIYbhbzL1nkTBIs5pMUdK+s=;
        b=Vsw+zWvklHcBucERXBAus5+EraCenBgpxy3Uo3afnx5imMQn1/DbGJC4Pwk1GgoLZX
         2HXDdSpIitPnrUsqtTBRaK/zGNVowbH1L+21yxkFte+5u7Xgg4mB/nu5xcHnbepvDu71
         LD4ipe5z8xOC/NV0+/KMFk4PzJfPrdcG66scaylGX2CNl/N6TDyIJxak0OONHtMmrm1m
         d1NhKaBBrWYdPJuQrvfP5RqATdrcdX9tlQc+qyysMih6CTtxNcVc54EfOlx/3mD82JZC
         hUwKQWB6550vFOkxLTjBTRefiafFL9L9ntgwWMU+Hr3ds/RWPZb0rtiBCbdIcgXU8UGB
         wrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966126; x=1763570926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xU8q7MblhALQM2wuKXIsIYbhbzL1nkTBIs5pMUdK+s=;
        b=D8cg2B0Hy6lzh4/UmhIhGxEbGW9MB3CqQtdsGpmq0nKAGScgd3rVHZWvVuYhIpZOPs
         6LBHrCjKeymPdHQuwp4Rl++Or0Zj6Xwr+wxCoaJ0gC/qWLe2JV11XRf+YbVNqMk5wmiL
         HI0bs9GaUM408wRegStgJtg/1LcxODJnw+XvYFBi0ZWBpAcEcDTDv8NJERE2Nt0eOGeu
         doozaGsJcEc7zWgG6IncqXo0HIy/22ulDAwQPN8ZVIsrvW09SodEqEU/CKqZLMZAlHVj
         mV24nM4+kT/21fihoP0dqPVWTBWNSnz2l/6i3R1jWWzmhJt7xUUkH+W+0gJ+3/8t/JJe
         eRrA==
X-Forwarded-Encrypted: i=1; AJvYcCV9h/46643X6Lw1Btml0lQdEi1s3FQuEvd/2r6hcJL4pZjE2mMpeNnVjaJ8cIKB/aOzSLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1SdySDvgZAunKrYdV4XVY7zthW3iAQEZr37GPjATNgb2kSam
	Sgb4ydJSGUCmhi70tgzPJiZlNc4qDblxm4n5ksuE2vhvww93QQYvB5Wq8yiwPYXO/os+jk2e6ai
	pS4dvQwYQAx1xK5G/O7TwNP1sro54Vap6okJATzCU+m0B
X-Gm-Gg: ASbGncvqP1PhgDVdc/a7U18ieJSZXArqqjPHW1pL0g/RPxR0ICoI+ns4S1Gt68kA4OP
	9p/sw5LLxaBkr/dXCI5g/H01QjALfGQkLl8oKcrhvTAWWV6HoiSF5YW6S0KUiNHNE8P6fYooF11
	uhmCWESi2wtL/nPcD0f/iLnhPzNZyEKwa+CSOplaEVaf8S0Cy00aOgOUkDxeqoVBV5udSf6Gcz8
	vo0FqF/Enqy3y/iA62gLVY1re7LubAX9URjOL12pFBXYsO7g0cPOowBd0he73QLVdFLVNqx4C4n
	N7m8gsUzC51U0VbZnkGhrUA=
X-Google-Smtp-Source: AGHT+IHGYHEJKVbdNXxLf5mE23x9aVqgJZ0utOxnHQYnwz8IEa55HmSVoVjBllepvrqX4MpOQdTL9arhRqrzShYd8y8=
X-Received: by 2002:a17:903:283:b0:298:2239:afc5 with SMTP id
 d9443c01a7336-2984ede4dedmr52454525ad.61.1762966126369; Wed, 12 Nov 2025
 08:48:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net> <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
 <20251111191508.GA1907007@coredump.intra.peff.net> <xmqqh5v0wcif.fsf@gitster.g>
 <20251111213339.GA4053071@coredump.intra.peff.net> <xmqqwm3wut8i.fsf@gitster.g>
In-Reply-To: <xmqqwm3wut8i.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 13 Nov 2025 00:48:32 +0800
X-Gm-Features: AWmQ_bkq5LDFTmxFGuOtAog4Kvnxmjb0LFragYGX3E4TJnL52ZaXh4JNZMMHeEg
Message-ID: <CAOLTT8QH_+4R4cqQf91giPxOE9H67bWZfcjA7sTeMbn5p1PnSg@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	phillip.wood@dunelm.org.uk, 
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 05:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Jeff King <peff@peff.net> writes:
>
> > I just mean being able to do:
> >
> >   git commit --amend --author=3D'Foo Bar <foo@example.com>' --committer=
-is-author
> >
> > instead of:
> >
> >   git commit --amend --author=3D'Foo Bar <foo@example.com>' --committer=
=3D'Foo Bar <foo@example.com>'
>
> Ah, I see.  Like
>
>     git -c user.name=3D'Foo Bar' -c user.email=3Dfoo@example.com commit -=
-amend
>

You still need:

git -c user.name =3D'Foo Bar' -c user.email=3Dfoo@example.com commit
--amend --author

It's hard to remember and not symmetric enough.

> Makes me wonder if we want user.ident that covers them both ;-)
