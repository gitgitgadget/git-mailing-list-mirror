Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72B6A8D6
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525305; cv=none; b=QXIHRa+XZ6kKXfBtpCwRk1LKVfVir3BRDSMeFq1ZLhkk2DUn/tRPFrrnew/WKqJ3arR+/1n/7SEd43ZlrFuGagU+VZI7BqDpYpk0ntSL3yS3p9K9pDng1ZKnkSGh6CcPcojCxq8paqVwf/Q2E4X3Yyk14dwv/pLIaU1KQ1o0VvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525305; c=relaxed/simple;
	bh=I0O2w2bUZJmgpQy+OAGLrAXjY1KPM/4eZEPLWkSaDyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLStr2fGmkxELI3KHrXX1H/z4xDlTwywvtYCNb712VvOKNOuNj1OFZQyHE4yuHE5e3J4Uv7ni0ImTXNUPCTSk17OWxVEBnzrZJRokRtySHdprz9CYQiZ7L4EXLOfiSd5pRM9xdHlp62M4zHu8cV7pvENYgspI5XifLAJxtVz0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiAvKpVm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiAvKpVm"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dc20645871so4262555a12.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 06:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708525303; x=1709130103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0O2w2bUZJmgpQy+OAGLrAXjY1KPM/4eZEPLWkSaDyI=;
        b=PiAvKpVmyYyIt1EBPWErLTJIpGO07OtCqRj8G8rb86xtvtHiNP+qZPpqKtJ9TPjvse
         /Ak+gRcw4KQsc0XoOKT4CNc35/w0p0mfReyfWW527Eu4aSH4kD062y4kVD9tIHd+3WWv
         BASye/lThhIMaJ/3+RjyYDtvfF7R7062smuPOZc/i7RO5+b1wykK1FSnSokgm2HR9lYC
         70lIenmcXEf1kXnj6UVAfXeP4NmPXlJsm7zXNEEok838OvIwwSmfTVMUEUNCQkHKqZNa
         IYOZgdV7c1weRF7LymKWGeQ9gDq4QpDp9w1Ig8GzAlgzTkvIX58rNyHR263hpIv6ro3A
         k4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525303; x=1709130103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0O2w2bUZJmgpQy+OAGLrAXjY1KPM/4eZEPLWkSaDyI=;
        b=VZZP1R8w+/tOK/JvPMADG9WxhnKOMXFovsmrzDn1mFOIRPuM/cgCcQs2BpKClizesZ
         jwPC/GxcHWSrlTMw6SxHwFbCoKTpQuZKc8q7zwyk8/u48RJ2CkoOqx7/8aebMzFqnSRd
         GvIs71SqSMVySx9BuvY4DbJBQrO1wl+BVDgNZbbA1TXpNwy2ZSMVRasynAw1cebLrWRU
         SIX9/aJgB60NYqMlcGQRYoMBDTSMNaQBPRUJXsIfX+o27iI8go2U9q46OG6hdnqJwyFX
         R46Grxi57Ad+LpPkUogA3mT/2Yiu8BwXOIh5EsRSa7Zivb4qqgsUUryv9QxeLFMjMCLj
         g05A==
X-Gm-Message-State: AOJu0Yzdpt6GwB5jSCiztUXDw57ZTeOWtBFrdzgpAxRAGRmX4Cxifyyw
	+efbhiQZqqh78LbcanhKFvG4kethhozaBdHQ5MLjf07KdRif5OyTprroCwGRzw0FI2wxw2fsviJ
	EZShF0ik8ouQaU/8dg22fYXSTGQo=
X-Google-Smtp-Source: AGHT+IFm04H3L+sfIqR7z6QZyTHPjFTrefCSJhUyb4sOwVw3ooBMfi4c82eIpHVBej7DpOOTmNfSd/cyXKJiqfbjGis=
X-Received: by 2002:a17:90a:f992:b0:299:388f:5a29 with SMTP id
 cq18-20020a17090af99200b00299388f5a29mr17666037pjb.24.1708525303193; Wed, 21
 Feb 2024 06:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
 <9c52ea4e-f84e-4c64-977d-14a468236c80@app.fastmail.com>
In-Reply-To: <9c52ea4e-f84e-4c64-977d-14a468236c80@app.fastmail.com>
From: Maarten Ackermans <maarten.ackermans@gmail.com>
Date: Wed, 21 Feb 2024 21:21:31 +0700
Message-ID: <CAB=tB2tgbLjBPvgBQDoNJi7e8+LMzxHSbg6D2jKUSJXPmQFrxA@mail.gmail.com>
Subject: Re: Breaking change with "git log -n" since 2.43
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Whether or not that is Git's definition of a breaking change, the
message of the commit in question acknowledges that the commands in
the "log" family are the oldest in the system:

> The "rev-list" and other commands in the "log" family, being the oldest p=
art of the system, use their own custom argument parsers, and integer value=
s of some options are parsed with atoi(), which allows a non-digit after th=
e number (e.g., "1q") to be silently ignored. As a natural consequence, an =
argument that does not begin with a digit (e.g., "q") silently becomes zero=
, too.

Applications that have been relying on undocumented features and
limits since they were introduced, now face a hard crash: "fatal:
'9007199254740991': not an integer". Regardless of whether this is an
improvement for future implementations, a crash in existing ones is a
suboptimal experience at the least.

On Wed, Feb 21, 2024 at 8:55=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> On Wed, Feb 21, 2024, at 14:32, Maarten Ackermans wrote:
> > Hi all,
> >
> > I would like to report a breaking change with "git log -n" introduced
> > in 2.43 that's causing some trouble:
> > https://github.com/git/git/commit/71a1e94821666909b7b2bd62a36244c601f84=
30e#diff-380c4eac267b5af349ace88c78a2b004a16ed20c2b605c76827981063924bbf9R2=
222
> >
> > To reproduce, the command `git log -n 9007199254740991` fails on
> > 2.43.2, whereas it didn't on 2.42.0. This specific number corresponds
> > to the Number.MAX_SAFE_INTEGER (2^53 - 1) in JavaScript (docs:
> > https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Globa=
l_Objects/Number/MAX_SAFE_INTEGER).
> > The max value that is supported now is a signed 32-bit integer (2^31 -
> > 1).
> >
> > I suppose git simply ignored the extra digits of the number, as the
> > commit message describes.
> >
> > See https://github.com/intuit/auto/issues/2425#issuecomment-1956557071
> > for the impact.
> >
> > Best regards,
> >
> > Maarten Ackermans
>
> I don=E2=80=99t see how this is a breaking change considering the range i=
s not
> documented.
>
> --
> Kristoffer Haugsbakk
>
