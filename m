Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF0347FF1
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140053; cv=none; b=QSu0YV47Rz0TyxcRkQc0mw1ewm+cPkLng9yT6PfDO1ZT3eyL/dGXcLhPcuHExucDfGkzoXElQAiWbHzzcYNxLG3zrTil0DDP5hQN7FwtG2HetfRljinOX1NC4W8YVycrhgteA3UsYQBX+UDzWg0LIeJeSKw0hCWn2hpN+0ziPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140053; c=relaxed/simple;
	bh=eaNtcFZ3QLaYDwvLNqujc32U12MWWN51zmQCynVxhBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbHi09+Q8r3sA0HfWuJA+UAtYIZhkRTc4gtmLV/sLoI8blIY85jLFOllbQawtg/QEG4EyK+067ILflmuTt7YVOk1jHylz8rlCTNCMh9Y82pj9qVnQ0hTe7+zcJH32E7cFpqd0m8CzE3j/5Z7Z/OriYD/WQ3EvM4qzORmnnYFOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9Q06bT/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Q06bT/"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so848906466b.2
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761140050; x=1761744850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaNtcFZ3QLaYDwvLNqujc32U12MWWN51zmQCynVxhBY=;
        b=L9Q06bT/IidMuEpfPmFGEeR8cmWu4RmIDNLtxrPU6B3UscIz6MKtuA0djIgCjOBGJc
         dkJAF7/TzacnRfxvoY0B1NTcWGD1wSO2XawRy+55tctB7eDW9JX4tyRgjNWN+S3TK9VP
         jbDfAVcLqSYg8CMZrbUsoCar0eQiiqJRGUgMJq+3utsPpahDtLrIb3NvSrTRht/UBflF
         YJnMQFigtGc5NQZQtazLlnOB7FPU4yhmbc96hjO8tzZFrqv4D25kPR1fu/sOEqgJ/hFc
         j6xvdZnCxQWvTLa2/VFWhUsOPDl1j/KaVaTRUjd581D3S9oWE2pUNcD9cUv/4unHhhz2
         /opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140050; x=1761744850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaNtcFZ3QLaYDwvLNqujc32U12MWWN51zmQCynVxhBY=;
        b=g4rgS5dLJjxZL/wM09j062dCZWnlLyPLiKky03LcCC0D0a3/h7VF9s6H0ba/Oq/tUn
         WBoa4LKmgTmDn62f259N3VMDvlj6URHHmPNzF2tx7qXuYvcq1FRMdahllNTm6caxKmk2
         wdxuWN1FHQ8MqprHx/FktI6atCcMHzwLN7HNTBCT5XXA7BR+nLeeRisldhwL1444WHDM
         mBJSYTncGoOmVlrbxV1a+hQexqv3SAvs83XhiLWrq8gHhAG6+yh/uAwrbElQ5CsgLFdo
         vq8bsXL0QeSZ8SE6U6yDWsLl2GL3k/lZP9O1kdkztSlBiZydLPFXLmFEyEboVRhabNCt
         XATw==
X-Gm-Message-State: AOJu0YykKpci+ZdXKH+VgZikCaYd8wGEHE3bc69kLumH9fHkKzeWHq4j
	wLQnQXPu/KU5SDu3VSXR6QXGokx1IYzrljCj6Op+ffO7q9jSDEVbAYP04QYG2J/dTpmUPXOfgTD
	L9HFG0tavCvmusuEnlm7hrsQWhfiAMKJYguUR
X-Gm-Gg: ASbGnctRVmu438uoNybgUcTH4TKR6Olo4kXBs0rc1kAeWhkDwTABZ0QOkQfdKwK3qvm
	CcJVcQ3Az8CmvWR6xwb9QkAXigSBON0IbU/Bp+qwhEvalwmA2ncpWkBbJ+xg4L33mXtcN1J6qu5
	bD1BTEGf8KngRfcxQRH0aaY1R5fOpFMXz4FxOJoF9hkSmSNttmSV9CtfxzIuI2a1NpQTMAtnlPz
	6iyHWcGX0e+Ms5logy0nYFdnf9ZHGWVaC8v3GnzFj9kt7xf9uAdSkPewq8rXTbHnpZR/yw=
X-Google-Smtp-Source: AGHT+IG+vlXNT6jZsakCUrq2uoAoTq/oRCeRhTjwKjWiG1bX/JBcF6xvCGzwIjPfckMsRnpMCwLzNhCv0iVymN2AKw4=
X-Received: by 2002:a17:906:c107:b0:b3e:babd:f257 with SMTP id
 a640c23a62f3a-b647403a530mr2435358166b.10.1761140049759; Wed, 22 Oct 2025
 06:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qfk3kkkQIl1s1WTDnWwPOPKxTGHX9wBAj6zycrehEuyR8Zc43JjAe58dOFZFUTvaxCvUJ6MfEC_v9wfYpT95l70ZJUP_iusET00lBy1Ipio=@proton.me>
In-Reply-To: <qfk3kkkQIl1s1WTDnWwPOPKxTGHX9wBAj6zycrehEuyR8Zc43JjAe58dOFZFUTvaxCvUJ6MfEC_v9wfYpT95l70ZJUP_iusET00lBy1Ipio=@proton.me>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 22 Oct 2025 15:33:57 +0200
X-Gm-Features: AS18NWCNj3bkxtaYmWknOlcNqu7NnP5bbU5QGpoO1SSITfmeikzesKn_egDT1hk
Message-ID: <CAP8UFD2u=wyDyuD8BDugJGXV8NEPmwFB5NaUsGH6JQ5Qr1f68w@mail.gmail.com>
Subject: Re: [Outreachy] - Introduction from Songiso Cooper Lyambai
To: keita <rudykeita@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Songiso,

On Wed, Oct 22, 2025 at 3:19=E2=80=AFPM keita <rudykeita@proton.me> wrote:
>
> Hello Git Mentors(Christian Couder, Usman Akinyemi),
>
> My name is Songiso and I am reaching out as an applicant for
> the current Outreachy internship round.
> I am eager to contribute to the core project. My primary coding experienc=
e is in C and Python. I am also
> familiar with Shell, and I am comfortable setting up the Git source
> code and building/testing it locally.

Thanks for your interest in contributing to Git.

Please read through the following documentation if you haven't already:

[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/
[3]: https://git-scm.com/docs/MyFirstContribution
[4]: https://git.github.io/Hacking-Git/

Best,
Christian.
