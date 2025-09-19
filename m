Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F8241664
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305699; cv=none; b=tlp30w2nIXIUtB4C6cw4ADu06JHVoJJd6Sqdicm2Ke856iKQkE9EUrkCfD2zoOv7owiNqFvA8mylFJ1AMHpQIwHiadzsec60GrZtRjyL2Vyq9WavJ5a6lvV38g2MZPrLjVUB8N0wxXZTtjXBtwczyVGyGNmWK5brySl9zgDYMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305699; c=relaxed/simple;
	bh=tQqh4Zi91uFZMgxcc9KEhCPJjLxjv6h59f3EbYgF8SM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r59UBpmkOOsJQw0+gCS2Jmg72dvNi2LQRjL/KfCIyqZ5zfZy1AkfMj0+8yyMCD/4JWuU8QA2U1/okAbcGAyWzlTNRL15Xd/rKKWjlfqGQBW7N509jSi5ccBMTCPeippUCZ2gQ4Qc4rY838tnf40ozpOJfAR5sHtVOej/dXMxpH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dabV98zW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dabV98zW"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-267dff524d1so17690505ad.3
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305697; x=1758910497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQqh4Zi91uFZMgxcc9KEhCPJjLxjv6h59f3EbYgF8SM=;
        b=dabV98zWGDriW6wkjCIjzN0/7KBY88eESavCeFMx7yCmfflsjgGTecaWQA8/XwE4o4
         DGHWuxmIs6jvLK07FQUhF7ikg+03BTlZnhpyvpn909N06AFmcIqi+klAunocfMntULYI
         ByRSLfLduzkBqc9sRJmdzVaPlIIVfjR3LvfMB2mLzaZ1trAXHwjilVRm/MONdjKkik6s
         rivEjhC7ek8gqicm/nzrsa/nL/+BKYDciTGdS/ADbUx9B0eSjupcR5KeXjeirW5CQyPg
         Fq7WSAWUwUfKZVIteNioBtVRWh0VD9l0p5a4vbieuMCgeF2WQ4IdYwZu9cELZfQ2BWn0
         xhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305697; x=1758910497;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tQqh4Zi91uFZMgxcc9KEhCPJjLxjv6h59f3EbYgF8SM=;
        b=uBxfzpupXZpVutBSGCLjedYGUnOXIeUo2J8fpWUCCrIGqhwIzFyAwsEPngkePiNmll
         /gEeGqIEUiegLyynrwJbl36bFQ8eAipWqOtyPisZZSi8o9LMoENkqhZqGusftM8Ckagg
         4sN6VELWFTR5zrOKfacf18OcHku64B6Bv50ewaoYl1iHTzyLKaAK2qpAtKle3OTvaS3o
         CZydIK/lIM3Yf6WQBYDpAh7dgg09CT/42T5l8JALThWo0tWiiVW5QzYAMqZmBjUd8alp
         uEN5xixRbZPq1hrjQWqW7JJQqhYSUfR74mSqmsNaDSeOp2hpqZOJDtqwlvboeh0KvWPD
         /Fyg==
X-Forwarded-Encrypted: i=1; AJvYcCV/2dJl/aY1b9CJK96gFDgKaNgi+zLFfd0dy3zbqEdc6pFNhzwecrtBnGbPHGPi4EO9Jf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNUQIXTgfIXfJTnXP/XiGQ1ozZtC+fW1lzilW58AwVVR+B0W1
	AuZjPZMqczNksolXngl7I5Wc0Tp9EonV1iq5QbZAVEpyMDR3AQWkVKJm
X-Gm-Gg: ASbGncvME2A7Z24+mB7Q7TxbCpMTXV6cBXlX6uMTsmYvg8/HrqMm/oYAV6f/nrn4a5v
	lOeNP+U0atzlXsUE73h6Ps3TZBfFfzvB9l0eyvkUYGtn44wGUc7nlH3uV75A9vP9I7swM4EIag7
	hrtQuzLGnzCaxV7ErlEDu0itArcp4+e3piRxiaAOM8Z8n2KN3SrIp5BzrN54TNMFtq/ZrVJfl5l
	/Evq/aMsGdteOhl6j+fnGO1VPS68mvRukB0RBoxZFvZ/fc7ne4MBmHWJuAj23gq/Q30x00sHBDz
	QmCdco3BY1fEw8a191smtm3Qd91l7Bh2WVjK2DJ5iHffpKeOinaEg5MoFcaLJYZu3Rv44GeeEq/
	ggKJM
X-Google-Smtp-Source: AGHT+IGDyGnBHWnw1ZBceafF3VDpMkmneIVddb4QBSojN7rnCqzJGiMj7f6AvQ7PKiyZeijYHcJMMw==
X-Received: by 2002:a17:902:ccc9:b0:267:d2a9:eabb with SMTP id d9443c01a7336-269ba49b5ffmr55609465ad.25.1758305696896;
        Fri, 19 Sep 2025 11:14:56 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::641b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698035d337sm59903145ad.139.2025.09.19.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:14:56 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: 20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
  ps@pks.im,  Johannes.Schindelin@gmx.de,  ben.knoble@gmail.com,
  cb@256bit.org,  contact@hacktivis.me,  eschwartz@gentoo.org,
  git@vger.kernel.org,  gitster@pobox.com,  me@ttaylorr.com,
  newren@gmail.com,  phillip.wood123@gmail.com,
  pierre-emmanuel.patry@embecosm.com,  sam@gentoo.org,
  sandals@crustytoothpaste.net
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
In-Reply-To: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
References: <4C760AB2-C102-43A3-B0B9-11E248F3FCE0@macos-powerpc.org>
	<CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
Date: Fri, 19 Sep 2025 11:14:54 -0700
Message-ID: <87segiqpgh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Fri, Sep 19, 2025 at 11:36=E2=80=AFAM Sergey Fedorov
> <barracuda@macos-powerpc.org> wrote:
>> This will be a disaster, please consider not making rust mandatory.
>> It will break git for all systems without rust, in effect killing not on=
ly possibility to use GitHub and other git-based services, but also breakin=
g build systems, since many ports =E2=80=93 and package managers =E2=80=93 =
rely on git to fetch sources.
>> As for local version control, git could be replaced with some alternativ=
e (likely inferior, but at least that is not the end).
>> There is no replacement, AFAIK, for build systems and for git-based onli=
ne services.
>>
>> P. S. In case anyone wonders, this is personally relevant for me: I won=
=E2=80=99t be able to continue contributing to open-source anymore (at leas=
t certainly not like in past years) with git being unusable due to broken r=
ust.
>
> The mailing list has had extremely heated debates about this, and
> there are many who would agree and disagree with you. So please try to
> read my comment as a genuine interest in trying to understand your
> situation. I would like to hear why making Rust mandatory would make
> using and contributing to Git insurmountable. We know for sure that
> NonStop currently does not support Rust at all, and that there are
> problems with porting Rust to Gentoo, but I'd like to hear what OSes
> and Architectures you use personally and professionally and why adding
> Rust would be a bad idea. Is it corporate policy? Is it that the Rust
> toolchain doesn't exist for your os/arch? Is it that Rust is a new
> language and isn't as battle tested as C? Something else?
>
> I believe that even "I don't know Rust and don't want to learn it."
> would be a valid comment to add as well. I think the discussion of
> Rust has been so hot because we (the Git community) don't understand
> everyone's situations and how they'll be affected, and what could
> possibly be done to address concerns.

Based on the domain of their email they use MacOS PowerPC. AFAIK LLVM
has not supported it for a long time.

Collin
