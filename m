Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F32C21DB
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349638; cv=none; b=rcUY5SPYz/TqazK7LGPHQtNi4vLr0Jk8mebGCpJDg4WhsCoCGQhS6VoC1zydHSov6Qge0OZKLO/DvZuoMpQGebdN0krvA17nko8LwKcXNIW5G1YmGD0xTN65pFbAMCGRhI37RqgQlZPLwUZ+2c9o6BAvdHjPHqqJjRrdF3FSC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349638; c=relaxed/simple;
	bh=mMa9eMwZykIkojvbk6HHQqGsZFTDfEXxMaXQG3vbUOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ft9f0FVz8Kbd0JrFI1oArz2ktSE14YiN4kIsw6iN65cVVpb7Z1zS3U8KWzWtPrOgTcWwHoyDAnhSlUHhUYk5efGE9l+ns9H00P8IFR4ENQTu5sz/2lCgYmUsOSVC9oV2x+V/M0gMxcZPv0wTV5K7RZdYptiHOClILieogyTgEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOTWJq8z; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOTWJq8z"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-948e1ec34afso94756639f.3
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 09:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764349635; x=1764954435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm0VkEn8PrZgQmrGogct6v+TTJZu8kjl6RgBgTqDAew=;
        b=MOTWJq8zKW7hek35hqk8Ti/DMQX6EZ1+Cd64OKaAmknQWxEITZX/X0Xgaxtob6xJQN
         WhTjhEqm8EsLDATezO6vpDcQ6sjZ7AcVgF5XLa84sC6wjYNm/4T1g1kKuV/eR6tkSXch
         v3ErvCwkE/gSYO03HccgW6pTjX2CAaklHGEVUfbp+c45/ehCF0+EUbuz1rq6M83uooCu
         zGQRuwSjZBN9yNGcfXO+QdOPrzU/ofyMIHKU8WFFmJXDMrobswVKwS7ljh8qd+k3qDIb
         AyNAWJGOP5JUtDmerY1xKrZVmsIDqYpl6bqX5k0Gz+oOyWLJL891FG9taHpf4ZLYqsu0
         J+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764349635; x=1764954435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nm0VkEn8PrZgQmrGogct6v+TTJZu8kjl6RgBgTqDAew=;
        b=XelSYD7XU++IZxZr/VfjuS/k8DOBP6rFS/3xRSXtEm9H0BJ2JddjGNLQN0yfUurtgH
         W8WZ7XpR22VJwc3276ii5H/hQe8rGVERoNbb2hZlwY8vY2CYwyMVEX49qmWn713rTS05
         cP1E5N4LdF9+kj1pDhBm31hNRiqZAVeFZ/E45y4mhnkJiHI8Gb+d+ez2E3sQCOLdLeTu
         G7GvKr0WmfmSKs97HrYg6pMkWOiTIi0Q8SlRmCNz05RAq2eZOmYUUmgB53IdIcpUpWo/
         3lA0ktLAr6MPnZs2pCrdKUmX7CLBLCz09Ws+Di/U2fBE+olbGnkOXyWaHWThTLNewRpi
         jBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWISgazC1XRY/3jyvCFZG/piAzdktd+/qVSpTBp7TucTr7S85Jlbwgmt34kYYgxm9PiNYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ABDzvoN8duVfMCsMQ7gMION+kl19L7/KbPFmVQAx2bVGnKzG
	n6ueTmm6raKV4bilGmLRPGe0Vxj2hoaS7Nv0UgN42D8E0cFQ034JG38dg3GyXb6FT2los4SAQqf
	dBYh8LNp7swMlRQJkUj6+Ky616ZJpzHM=
X-Gm-Gg: ASbGncsraqhpjBqOL5FES6WWfmQ1UxGK18lH2Mf+E44hF6ykpXUaII5VuMHShWeVOrE
	GRfr6UxNBfkNeHrCo0xz8PB9R4ifNEWkqATiLjZZQKEVgSoHoWd06k0r5TA1kIoDC/C76TpnQB9
	I7hSBOGOiiO79nKMTO8PKV1V9AyYG1gYzEgh2jEfqdtCbaUj55Ks959KoxU1ielrrqiqzO5Nwkj
	CCPKfsgDQL/A4WGZfE2cCvx3PnLD4NkxzlruC/+u4Esqa4boOeq+CLnwSdTPiwcpPbHWWkAfUZg
	vJWwqcY7XAEHOu7MCqcKuOdb70YQ
X-Google-Smtp-Source: AGHT+IEunAC3Jiy5V+hP/u5IOKsATb5uWQvaoduWMiwZdCrGVZTeTDcY5IVIwMFH/Xw/DO7vljq0KU+dBT6QSgIoi+o=
X-Received: by 2002:a05:6638:29b6:b0:5ab:c42b:fb9f with SMTP id
 8926c6da1cb9f-5b999696f60mr11383048173.19.1764349635208; Fri, 28 Nov 2025
 09:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de> <27fef9e1-bf26-48af-b3df-35948937c891@gmail.com>
 <xmqqcy54mro6.fsf@gitster.g> <fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
 <CABPp-BFsDJVtR6RV8KugCW2vmbD1=rTOKLp2jeawRfuPUEsNEA@mail.gmail.com>
 <c930d6df-5dc4-401f-a9a1-eb2f00b2e837@gmail.com> <xmqq7bvajesl.fsf@gitster.g>
In-Reply-To: <xmqq7bvajesl.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 28 Nov 2025 09:07:04 -0800
X-Gm-Features: AWmQ_bmKmlWUtX58fOjNXPqTcSRWpr7w_oCyIdNe-wOctCWJhy2d7lmA4LZP_W0
Message-ID: <CABPp-BF48AF9qoP_pUs1X=sUV-_G5BpsxnG6AEhQYkJkE_TBjA@mail.gmail.com>
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
To: Junio C Hamano <gitster@pobox.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org, 
	christian.couder@gmail.com, ps@pks.im, phillip.wood123@gmail.com, 
	phillip.wood@dunelm.org.uk, karthik.188@gmail.com, code@khaugsbakk.name, 
	rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 8:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
> > Agreed. I will keep the current submission focused on basic --revert
> > functionality. Supporting --no-walk for disconnected commits (benefitin=
g
> > both --advance and --revert) would make a nice follow-up series.
>
> If we want to have a useful support for disconnected set of commits,
> "--no-walk" is not the way to go, I would say.
>
> Imagine "among the 7-patch topic merged, the second commit (i.e.,
> topic~5) and the final 3 (i.e., topic~3..topic) need to go".  You'd
> want to be able to say (without going into details of the syntax)
>
>     revert topic~5 topic~3..topic
>
> The setup_revisions() parser is still the right thing to use to
> parse the command line arguments and pick out "topic~5" and
> "topic~3..topic", but instead of letting prepare_revision_walk()
> turn them into a single contiguous set of revisions, you'd need to
> check revs->cmdline->rev[] and
>
>  (1) treat singleton as its own disconnected island that require no
>      walking,
>
>  (2) treat A..B as a range and independently walk them, and
>
>  (3) dedup the result from cmdline->rev[] elements into a set of
>      commits that are potentially disconnected.
>
> I agree 100% that this topic should not attempt to deal with a
> disconnected set of commits.  That can and should be done as a
> separate series.

How does one distinguish the "topic~5" in the range "topic~5
topic~3..topic" from
  * the topic~5 in "^topic~7 topic~5"
  * the "topic1" and "topic2" in "^$OLD_COMMIT --ancestry-path topic1 topic=
2"
?
I kind of think we still need some kind of flag (possibly implied by
default for --advance and --revert but not for --onto?), though I
agree it'd need to be a new one rather than --no-walk for your example
to work.

And if one can do this, should this flag also be added to other
commands, so that e.g. `git log <someflag> topic~5 topic~3..topic"
would also show the commits in topic~3..topic plus topic~5?
