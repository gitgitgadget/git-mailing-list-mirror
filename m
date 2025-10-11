Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236F11CAF
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760193324; cv=none; b=CvMykDV++/qi85Me+upryX6iDUas3VrbpOhqw1KQ2/u1AgusZJIcCxUybJbyQePDhGpvGtL+6nC7bvGukqlLuq9fqqRJjhvDfSF2bgZ9yMokVtHNL5UtHzks3vZ07MYIXobcN4ALyWY2dNKK3j8ydhWd0QMjnRLlLzplONInppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760193324; c=relaxed/simple;
	bh=QD70ylzzA6JrQt7mwx3+a9N4tUpRHNjXuT9e3ant20U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GW6BSIFp/DPvroLKi/5layz1ssMT/TaUM+HZGvsR3sq/oAuOH7gbKcKyMz74xvQ2f/T4IOsF8anrKV8+Emex0jiTOAyU6ZqB9JEY4m5yU6NRCa63gUpbUsRxJd1k76Ia1vtuGSp9woE2UkulYnqwOWBMlLFk+RvMDbZWG41JrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLf8V8E9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLf8V8E9"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so539905566b.0
        for <git@vger.kernel.org>; Sat, 11 Oct 2025 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760193321; x=1760798121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQkw7d4l35yyL8O13F8eZXy8tCFT8t7PAVPFHTsB5Qg=;
        b=OLf8V8E9EzbJTL6UxS718CZEkgKEc794n7kDm7gz6r77fqc8V2xfOGKbNlNk2KXTFS
         ub0HYX8oybFtNSuq52sD99YKA3lxQn1lSw2E0iK2Sw7/bPB2DU18lwUG4oavtPo5Ioda
         CGR03bzz7V7Dvh0wB5ZR34W2QhblyL84AmcJPoX8NpNkCxThzZVmMw0y9IqBSQn/Wn+2
         1aUCxDCVOVA2MdDGCC1Eugs4Ib9zw5P3C6mtiQFcTWvjbTexVlUZqkic1eWagZ9GrIZH
         wmwJgrcakqC8NucPi2VCG201HqVdBDhrFOOg56NQSJwj/Gidar3r0InEYXk05dPjky7o
         pyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760193321; x=1760798121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQkw7d4l35yyL8O13F8eZXy8tCFT8t7PAVPFHTsB5Qg=;
        b=DU3yi84+SgwaPuZciUsw2378b8O+IqJfBllLvMGhJThyX4NBx78A2pmK2H6g+mOTWs
         dffxjUJRI5zInu1+eJjMSJmH868tiAaYSAxYWL7j9+UT4lsTXxvC3+HnNvBVUG7M08aX
         8QpkX7/e/u51ReoH9kXlr+BAG7RpwgiQg5gLy8EriqU11E8Czg5CIue6KfkmJ+eEDM1W
         FG/YBhcd1CMppiwfXJRDu7P/eeqmMDQKaJinnaWMEnw7Kw06ctwg7Ncv698aAIbTiAY6
         MnYpqh/yv2imOeHVjMHXqswUbChlDi40C3xiyul2Esk/9eiZYEn2NiPlqhqLw44JTSmq
         VklA==
X-Gm-Message-State: AOJu0YyyPveMgw1XgiwmvIxTrFa0HqU6sQGJKCjDgu7YxNxWrcEaFFmw
	B/6H88AytPhZoqNgACqk+24RfBK0w0P4WH+pSh8HUXGL90su0n0lC1oALyyZh20cNDBKwQw90xS
	qDFMmNcJNLxYLEVMP39xb8dAKLMYmE6w=
X-Gm-Gg: ASbGncunz0wrTUu4Uu373XCXpe/94g5V9jS7CTWxJ90m5vpjA7OdjNpRm7hfBsy4aKP
	cZlhPuLasOL3q/+9q08eQvv4RHfrQgUnbpqbgkHJYFY6aP8/8zMieJQAM6m9stfXOus2zP3c+xq
	cAoHGJD0JPdC5Q5vsssSaPJ3OgNwasy4IreIa6T7oZSYbngz2p/lnFegAM3TQM86pqtRDB3jd17
	nmP15NWlfIcFpJ+BJEW+iv0xt8=
X-Google-Smtp-Source: AGHT+IE0QJ+tH9SdrYyWYJxD2bvP8EYqoP1pSrJ9BcHWm5HYmDQ+VoYyMQnj7XrCuyU+yMWVdQ7W2/uVwgefZxjG3+Q=
X-Received: by 2002:a17:907:2683:b0:b50:52a4:8f9a with SMTP id
 a640c23a62f3a-b50ac7e75f5mr1561333766b.45.1760193320957; Sat, 11 Oct 2025
 07:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqecra71ec.fsf@gitster.g>
In-Reply-To: <xmqqecra71ec.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 11 Oct 2025 10:35:09 -0400
X-Gm-Features: AS18NWBM6cXf_4mtj9diMqH5nNnMIAVYM7eGOb7CUZHU-b718R_9IL3-kCbmY7c
Message-ID: <CALnO6CBEfzeSDRcVOR5chsHUSj1eM7RvTFJOVZ1h0X7Sqbaj=g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2025, #04; Fri, 10)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 8:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> --------------------------------------------------
> [New Topics]
>
> * dk/stash-apply-index (2025-10-06) 1 commit
>  - doc: explain the impact of stash.index on --autostash options
>
>  Doc update.
>
>  Will merge to 'next'.
>  source: <d4a277b6b0695d86636562f4c07efae17f9249f9.1759755379.git.ben.kno=
ble+github@gmail.com>

I think Kristoffer had some feedback about the message=E2=80=94if changes n=
eed
made, my understanding is that happens prior to "next" ?

I'll send a reply there shortly, at any rate.

> * jc/optional-path (2025-09-28) 4 commits
>   (merged to 'next' on 2025-10-08 at a1e8af9952)
>  + parseopt: values of pathname type can be prefixed with :(optional)
>  + config: values of pathname type can be prefixed with :(optional)
>  + t7500: fix GIT_EDITOR shell snippet
>  + t7500: make each piece more independent
>
>  Configuration variables that take a pathname as a value
>  (e.g. blame.ignorerevsfile) can be marked as optional by prefixing
>  ":(optoinal)" before its value.
>
>  Will merge to 'master'.
>  source: <cover.1759094936.git.ben.knoble+github@gmail.com>

As I mentioned in <1D9EE7CD-800B-4B70-8D98-79B0C2FB8DBA@gmail.com>, I
think we might want a slight reroll for some tests and to use the
correct functions in a few places.

With luck I get that done soon, but in the meantime Philip's comments
are clear enough to follow for interested parties.

--=20
D. Ben Knoble
