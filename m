Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DB221F03
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001284; cv=none; b=gOLOXeCDX/melm8PBHQjv+Fe5wf5yHrMVxpgG0dDlzLKiwKemWo2Mr8uCbqnXAJcPFtLYaH8/I0wbrNQchWjPbHYBY7IvGIT/yiyGwpBjzrPcUmVOfrSf/gtCHspy8seG1hLwh569lZMspecwE4+EWanm+WW6YmXuxubo93xD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001284; c=relaxed/simple;
	bh=jeY8SB1D9w663vfJKcw0aPjllmyNCiUg1FmxhEbqHMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nG+ktJi61p/G4fPCqTRmued+ey5L7D5LGwejrdAg9xi3m4H3C07/vOyhyQh2UbvaT3e/U7loQ0fobIdXMr/D9Q/JBFU2SCxmVklZskVd9NKdB6e7IeqMn3egGarTqMbZK25GgftmXsNICTczMTd2bp49ZJM7AYU+GCs6IxbFGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr7ooOGj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr7ooOGj"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b553412a19bso2279051a12.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 15:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768001282; x=1768606082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeY8SB1D9w663vfJKcw0aPjllmyNCiUg1FmxhEbqHMg=;
        b=Xr7ooOGjI3rKoeidmJ8FCGc+l794Qvbdz/4J9d0E4imLDNz91pNZWf2n3Fd5XY4Vsf
         btEUayHi806c60t8DpbxywAiHF6XMP3nvRYKksTxs7JVMYCyBWLeHlVfiHDHcw9d+1Gx
         i8gBcflU+SG7NX0nnXgSSgZnTjboLZB8Cuuc2ksSTKnU/KHbHUslU+RU/Pckcd+Thyb0
         cggPGmNlaRbPIUSNQ3O1eTHqXaOoH5hwWOqYaDn+NUZkWcgxcUUZAik0UsggtFf2LpPb
         /XtiGwQfPAXz70IOPyXZ2H+Vkzts1VBiJuBIK07GM7mwZvnt5fWYRytnlnYvaPJ5uUNH
         iuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001282; x=1768606082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jeY8SB1D9w663vfJKcw0aPjllmyNCiUg1FmxhEbqHMg=;
        b=H9i30fZcCJlxyOOF8ntd/TSim6ISyBz+I+SwZXjcT+Fdy1RjQuif9W79wW86SEJhe1
         dvlkXoMl/tRXzofXNC3CEmkVjyyFqP2vEz5+MhQcJ2GLIo1A4PtAQXGaxZ6T0IMdk86o
         S08ZqxXKBiLMMi0QU3SKfDlHnTPXophoGqWRfeD6RzlSuSGRpkmNf7QOXLFlYjadgc/c
         wIgQTXEbMfCnRa/JMdlBoVNJHejEmKT9q0QvGYfC6ieS/eqohfIrIcVNR1eiQJIq1kcE
         +YiHk2Q8zEvTkMDGea8WwlsM6znBsSgkYe9Yq8PP882/INAI4H0Mb2CbGD/ryCPMHltL
         dN1w==
X-Gm-Message-State: AOJu0Yy//uGAq/Lmg74w2Qi2n0pL2UuTOQ8ux+u3jF8MCwfDwVmB58d+
	c/pOfbqL33TM9sVwQERVEnR8c6P0zMh/mI9SznTlakt9aoy2xuTCgpEIt5Z50N37vP8fEiPNu1Y
	qDajBqYkEzpAR3F8KR8NI1kdLxfnB2Vef+YxAWho=
X-Gm-Gg: AY/fxX6zUX2xupcJzPL33qTsfDxoAQ9H1mVW5sVm9KxmQjcN8bbcDBY9z7t3AEcunaL
	2UdepmVcn818ZiiG2PHtX6Y/+nAWMfuM4MR+EvSUhi0kosxWx6e2IApj/rqYqlt6YWSi9dzK0HB
	jIKanY9kAdTpF1YZFFOajlVNan6QxL5enyVfpPfJCfcTqevL74SMPWKwjRXD8c/rzzhtpNEUX3H
	KUaDNYbDXZVyqhpZBtEIn3tj+p4pqekvfbQpfFc2+zpot1ijv7QXpujrAH45tdUSDGiDkngtabF
	L/d+BZL9HuY74Gs/tq9uhJJPSdy8Cbj2ZmmuHXXMxF7vu3fND/NcJI6ZhT4WtDe6rfdQ
X-Google-Smtp-Source: AGHT+IFe5d/fKrpUAvjUgp1s4Bt4uq0TVwNQV1iaa0gMKut+3iWxrXx2EbO8rOh8YPJcLmjr9oE8dqQZWwQlIponAgo=
X-Received: by 2002:a17:90b:57f0:b0:341:2b78:61b8 with SMTP id
 98e67ed59e1d1-34f68ca4536mr10259890a91.20.1768001282219; Fri, 09 Jan 2026
 15:28:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
 <CALnO6CDhDFtz5WY2pd8as5nH-URxzfNUfkouQ2Cf6USuRRTrKw@mail.gmail.com> <aWCvdHGDzZC5OLFU@pks.im>
In-Reply-To: <aWCvdHGDzZC5OLFU@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 9 Jan 2026 18:27:51 -0500
X-Gm-Features: AQt7F2ortJ9eBh1VXsC-PHEoiWcISz8TxoaaZ9m8SiYI2fPxKNTFex0j-d-hjOo
Message-ID: <CALnO6CB_XBXKAcCwEJZHotioxcAKNrNO2bZZ0nwoZ0KufVs+mA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Introduce git-history(1) command for easy history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> We only have "reword" for now. In any case, I'll definitely upstream
> more subcommands once the initial version has landed. Probably the
> complete set of commands I was proposing initially: "drop", "split" and
> "reorder". Afterwards I'd also like to have a look at "absorb", but I'll
> also gladly accept any help.

I figured as much. I stumbled onto a version of git-absorb [1] today,
and I have some notes on how I might script such a thing myself using
my "git-touching" [2] script. But my script has a slight bug [3] when
handling staged changes that might make it not quite ready for the
attempt yet. Anyway, some food for thought.

[1]: https://github.com/tummychow/git-absorb
[2]: https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-touchi=
ng
[3]: From my todo list: git: `touching -c` only considers staged
files, not staged lines. So mixed files give the wrong outputs.

--=20
D. Ben Knoble
