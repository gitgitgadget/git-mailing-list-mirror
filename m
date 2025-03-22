Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A115B971
	for <git@vger.kernel.org>; Sat, 22 Mar 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742666554; cv=none; b=q9sVOrDiWqvkzgdReH6XIEoM6S72oDZ/h5XYTBesKoKnuvBZq/Byv/po2tzPraQb91oVh7I60C+hU65RyczsnZtE8CnNJ28cd8X6ApWLK5q3Vnm4+xcipgn5zJVc7anSGxRDUZnTZWIvLf09Uv0lpkGPacaoN0Th9jbLab2vjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742666554; c=relaxed/simple;
	bh=DpqqH6otDXqzWGJTHU3nVedM4AaJvganxuByspqglDU=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U77QjEOpogN3w1HhMjkn1xVNlXvDTNBPYT7y5hLlt9qeLxlWqdbn8MXANGXfyi7xYlMUUisaMxbakgfXbl/CLM40gl7QrnmmEvKrwcd6rVKeVH7dS4MqXwVuzwPuzfBJYI3Al8PV4t9iDUqapbDF2SgnxeeIt0W0u5cj47g+5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOn4DTaf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOn4DTaf"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so5153884a12.2
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742666551; x=1743271351; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpqqH6otDXqzWGJTHU3nVedM4AaJvganxuByspqglDU=;
        b=GOn4DTafBYCL64t6zum+3iBA3YAmFZihSx/yPFZ6FQRfsKo2SkguQ210QpW0cL6TGi
         ZgWdyXEFCAzA7snujjVsjyYw7+0lQST02HTMZ/O0P6tXjX8kLpyaZX6+PbFQ4rvzVx9r
         WUx2QGgEF/gTXfnsg9eiYLODOYaO7PSV3M/uvGYypQOh1+Q09h4niAZsaZ3wLPY6H6/f
         wiCmu9jVRvKVm4r0bBQvh8Qxc/81PoMig8r2y2Cti0OOws4VLudXsqYFZcM8bdrHAxFA
         CfjSiqFAixQP+7f2+FkXKBoHpozyetJ+w/bDNtQB6KV51nvdqH5x1H0hl+075bOrRBnu
         6jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742666551; x=1743271351;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpqqH6otDXqzWGJTHU3nVedM4AaJvganxuByspqglDU=;
        b=ANqgEO9wILEoAlRzOtGvstL8OeAVgiq7m6NiI1qFXe5o0dBKEFL2JZH+yYJMHASydT
         tmaGc4gpeyZDY13y/IL4J2rQf4Dx6oj8JC+wscc6TcEAGhvGRslCa68uos937Syt/iT3
         7Yi8IMk4NcP7faHM6pfqPlH1HBxmfeAE/xrWDyCU43x+TYIUGdlAgKm0mF1OIOcsoIsn
         DN1jCdp1Hnl4WCXqtuLsC3lk7lfiI0ydkqnWRbRLHlMzOpyN0ltGmItWyAHjwAt+InAz
         eTnJ21P/x7a9HLYXQR6HpjbnAvQ+gs5cSNWndIlNvtkOJ6vvUTug0Gl/9YJaDO6bk2GT
         nWrA==
X-Forwarded-Encrypted: i=1; AJvYcCWO+iGWI/d41oM0WKYoEo7GdHEwHDk4qHzIA9rFHAwVB0Z5gJj0q3AwPEluE4weL9bqk1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mK/sKBFJYjejbv53p7iYMXbvoFbs8Mvcfr7HqK65aKOKzWIq
	y1lN09JikhxXbT4gUiSQY3wi2wFeced3vwp1KOUSbi/F2d+JdBNdWrT16yE=
X-Gm-Gg: ASbGncvHJHFePE2WhirFDq7D/rrRTf3mIzrkUXD5i6/Svc7AswaHuv7fleODMkwMu7x
	g05x47VWJ8rpqH/w6/Y7W+hfXVRD/gRSWG/YcfPvP23iRY/X6IT/y5Ep2hbadO5iG5JLJ/Ly+Vj
	08u8Neud840wXblg0BP0AqJa4wmoVTm2FpAu8ETWIB4tR2MKrqp7ZHoqoOmVJSBDbcieQ7cMPOH
	pNpb+bebcTrF1nQP02ZM8YjY/zoQnl8ianEbC8vuWwaI/VoKZHStMesyX+zENGAbOF8N/UZ7Nou
	WYZfMFJFHNbguPNqJ/6C2zDHbUF2lmBzOfSZQ4xmYC1kF4DWXAF6s2DgvAkzLZk=
X-Google-Smtp-Source: AGHT+IHPhfXIYqwDOhljV4S06uft92C1XzADAx7aaODPfYBgJ2eTvcoA0WRZqpX/2Jgs4KLh6wAbPw==
X-Received: by 2002:a05:6402:2808:b0:5e5:e090:7b62 with SMTP id 4fb4d7f45d1cf-5ebcd500773mr7793517a12.24.1742666550900;
        Sat, 22 Mar 2025 11:02:30 -0700 (PDT)
Received: from smtpclient.apple ([31.167.7.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf89240sm3449889a12.31.2025.03.22.11.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Mar 2025 11:02:29 -0700 (PDT)
From: Ayman Bagabas <ayman.bagabas@gmail.com>
X-Google-Original-From: Ayman Bagabas <Ayman.Bagabas@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] [RFC] shell: allow overriding built-in commands
In-Reply-To: <CABPp-BH9ia_GRNYx+zRCht3n0V=X-uLq2Zg+QWTWCyJfMkeznA@mail.gmail.com>
Date: Sat, 22 Mar 2025 21:02:17 +0300
Cc: Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A950A71-8847-4F1C-A691-5A9CD461FE6C@gmail.com>
References: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com>
 <CABPp-BH9ia_GRNYx+zRCht3n0V=X-uLq2Zg+QWTWCyJfMkeznA@mail.gmail.com>
To: Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On Mar 22, 2025, at 8:39=E2=80=AFPM, Elijah Newren <newren@gmail.com> =
wrote:
>=20
> On Sat, Mar 22, 2025 at 3:02=E2=80=AFAM Ayman Bagabas via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>=20
>> From: Ayman Bagabas <ayman.bagabas@gmail.com>
>>=20
>> This patch allows overriding built-in commands by placing a script
>> with the same name under git-shell-commands directory.
>>=20
>> This is useful for users who want to extend the built-in commands
>> without replacing the original command binary. For instance, a user
>> wanting to allow only a subset of users to run the git-receive-pack
>> can override the command with a script that checks the user and
>> calls the original command if the user is allowed.
>=20
> Sounds like it'd open a window to generating numerous security
> vulnerabilities, break git's own commands that exec another git
> subprocess (e.g. git-stash), make debugging git bug reports harder,
> and likely break programs that use plumbing commands.

How so? The security implications are the same as any script
defined under git-shell-commands. Git does not handle authentication
nor authorization and it shouldn't do so, and this can allow repository
based authorization to happen using git-shell.

Forgive my limited knowledge about git internals but how would this
break git's own commands that exec another git subprocess and
plumbing commands?

>=20
> I'd rather we didn't.

