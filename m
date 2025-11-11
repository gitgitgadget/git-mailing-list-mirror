Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F0261B77
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867199; cv=none; b=rHvmmZ+3TcROv7ylUHDHqcyL3b/TPLcfr0ptuuIx9AkA8hIdTugz/bUfJtfn2ZEEn25dNry6Xasyox3zgLaEGJzJvs7DaSJ1n+c+RinnMNeIsn7u27D3HxVExBsgKrT9ZyZMgSHLGLnrPga1jo2tDEQ3MXWhN/u47JsX/iacCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867199; c=relaxed/simple;
	bh=o3HMdSlFvNjZl2E/Q4vmy+W/lyaRaHlnRxJ5/Nkbegc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjZ4I9lQp+Sof0QKMrsCMwTpJ/EV1deQ3HQXWTYzQO9N//uJa0nRL0jwIQYQZqgtG2De37hTEVSbdap3DeKXcTpWZ5KdLL//puwVeZ5AUVQ5MC1ZAMRVyZjXtn8iUEl/v5u7nPSaDMvLAb74FsEbi5y9GmEx5fnMMYrb+RUYSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8QeGIb+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8QeGIb+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso8216569a12.2
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762867196; x=1763471996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXI1F/EIfxjjHGDL0uZOVZQBaCCGv4joAjuxV5byrIQ=;
        b=Y8QeGIb+bhP9MNGuj6r7Xp9+v65tMk34o9RmG3G1jRdy3u5JHxchqPEqsNLe8FmN/5
         ae/7lXM9c4QaFZ2atp71Jhs674bqEmnMA5FIpg5/Qempd06BUMUMfu+hAsgedH1DFQGP
         IT1eoMaNKMp5WGEVqPyLvkwHIh8Mn6DCPxh03qP8M9e8LnVqkB6rGx/QGAaDZ6Opo6hH
         90/Cl1NcB2WCRBB8EGDYzgZJBua2cLVF467pMIbhvopF08R5p9e5ieXBGuYlElThGpDG
         bvDLyhdIvTMgua+GZ7Sz/4Tn4J8ZrtDDAL2Ic0HJknzCPCkJSowOsWxhLITff7cFXhsG
         cw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867196; x=1763471996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXI1F/EIfxjjHGDL0uZOVZQBaCCGv4joAjuxV5byrIQ=;
        b=sWU0aU6bRBsAQDaJsLIVvjXgjjpiIulyGrNbzXZ3kerATNVfp57BluhRJu0ovJgkOh
         cqS5gqQKc8cHnq+TyzwNV64CwLjffTFlnhyyQGPmbrOk75bGaAnTofnpNxHnUhmXUEut
         8bkzSYInG3OJBNaKFw32bbIHjO2pHx9zkqyAcjzbC+YqMFsVoVAk1TqjcB1/xcXUyzDJ
         U5Q8J4EGqln1/FgGhXaDpcp5rAliR/FTlRvLYS67dbcR7B6Ij1oClJeKP+3mBv1sJgwt
         9PXf132aahkfqZy0dDDsqSXsFSrz5YtLFK62zDTCXBdKDfiXE2DMYFyBBz/bd32H33ZP
         AtAg==
X-Forwarded-Encrypted: i=1; AJvYcCVmF5EofV6xeg3UcnCerfUm9uiUFRKW399ngAMzG/SDhjeHygwNvOzBkaxcTJQNHAMuvaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2b80+Zimmoq/gGgwYUujfZ0xppbRcrVW2qVKzXf07EFhzoi1l
	6EEg+KDP1diiBIMNoTFy7NiaK5WxRI9LjXEY6aCIZjhIttqHRvLAmLpDF+Wcr4Q9j9owKdqYPgO
	CzbGFQS/mRGKNNYnS5NkfNywIgZAdzO4=
X-Gm-Gg: ASbGncvizRlGSR4O06xLwXdX4kGJcb5e4zkdhvYEsUfFA+VUSpBHsxgwwFdDFuq9BIG
	8c6fTk4dTYAhsRyyxq2JX3cySP/Ek4b8ipmrKx1YG0RByV1OKf7FxadTiy/wRF8UmZwbOT1WOfi
	2OPJi4bb7nJU4HE77lkzETUEfo7/nbaUhqhilcti1hlzVZj5PrXPjUmgpybxnppdtD24cbfyl2S
	0DBGpENctKO4gUPJ/4/l7AY5fNptfVu1Gw0eAobKY98ZOVWd54ejlss
X-Google-Smtp-Source: AGHT+IHqfbOTZ+W8Z9Pad9UR2qYnz1mZ5O9Rz2/1hLPoqwBGhbxoNUep0dm0uhBcbeWI6Eux4ZvNacrotQeVmDgeB/A=
X-Received: by 2002:a05:6402:35d4:b0:640:be20:fc7b with SMTP id
 4fb4d7f45d1cf-6415e80a82cmr9693378a12.31.1762867195658; Tue, 11 Nov 2025
 05:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <aRGvVwRcsJA9CD9c@pks.im> <xmqq7bvx3i0u.fsf@gitster.g>
In-Reply-To: <xmqq7bvx3i0u.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Tue, 11 Nov 2025 21:19:44 +0800
X-Gm-Features: AWmQ_bmuCjUL1JKr9YkHNr3M94WfZ512_qlvlFXBsbk5JMNYILEjtSoL7wy-njE
Message-ID: <CAOLTT8RSvOoQyXeB6bxf68iX8_ptnsWALHhT8ztCYiR7ifue-Q@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=BA=8C 01:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Sun, Nov 09, 2025 at 10:22:54AM +0000, ZheNing Hu via GitGitGadget w=
rote:
> >> From: ZheNing Hu <adlternative@gmail.com>
> >>
> >> Add --committer option to git-commit, allowing users to override the
> >> committer identity similar to how --author works. This provides a more
> >> convenient alternative to setting GIT_COMMITTER_* environment variable=
s.
> >
> > Yeah, I can see how that's useful.
>
> Well, I don't.  Naming somebody other than yourself as the author
> may be something that is needed from time to time by human users,
> but lying about the committer who made commits?  Our tradition is to
> give long rope to let users hang themselves, but we already have the
> environment variable override specifically designed for scripted uses,
> where there may be very legit uses of recording arbitrary committer
> identity that has nothing to do with the identity the current user
> who is running the Git processes usually uses.  I do not think it is
> a "useful" change to make it more it ergonomic to perform certain
> operations that we may not want to encourage.
>
> So I dunno.
>

I understand your concern about not wanting to encourage users
to misrepresent their committer identity. However, I'd like to point out
that if someone truly wants to "lie" about the committer identity, there's
nothing stopping them today. They can already do this through multiple
methods.

My primary motivation for this patch is not to make it easier to
falsify identity,
but rather to help legitimate users who work across different repositories
with different identities. These users occasionally need to fix accidentall=
y
misconfigured committer information, and the current methods
(setting environment variables or editing config files) can be cumbersome
for this use case.

You can see from [1] how many people have struggled with modifying
commits committer.

>

[1]: https://stackoverflow.com/questions/750172/how-do-i-change-the-author-=
and-committer-name-email-for-multiple-commits?page=3D1&tab=3Dscoredesc#tab-=
top
