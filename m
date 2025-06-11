Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD32C0322
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683909; cv=none; b=g83FjhWVJ/93R0+KHanVlUxNAxqabw8bRzF3z9WQbkEN8H6nos99JDRV+cPMx3f1YXvpnGgHzswWSTUYKWy/s2Cjy6wGrwgBanGOyt5PTeBydf6ufe12/phyBeHEl1RySPpnAZZpaFJ582aDW2CcHMKPhaYbwt45fXxzknnrqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683909; c=relaxed/simple;
	bh=FH7kdqDH3UenuCefuE3ilsRIIVNqXsDM9lPT44w9Sy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ks2/T88B5R26yEHyrWwrtGqlFuGLS9ZVy6ubd7qz0IuA/Qi0pgR9ollPy1WfRW1faVlWPwWpR3qn9INQUmRPzYG7BGKqDwsE0nGOrLtWsteIH1gIrExLy2zAoNRsOoS8Cx0REgDmZooPk24NtRSRiB8MU3iO+pctVy/0fw6UKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxBEe7P7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxBEe7P7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-addda47ebeaso63388466b.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749683906; x=1750288706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH7kdqDH3UenuCefuE3ilsRIIVNqXsDM9lPT44w9Sy0=;
        b=cxBEe7P7ET/MQVrcR1yjRVJxFP/tGg4x8jkJdtc9JJ4HcybEeTqe2k6OabSAhfhEXc
         ypmrD2AE7it7yjGe1CgJwuEEZgRlC/9I7GatP2Cyh7v0c0cXskHz4jzxMzmSBdJdN0wW
         qbJiL7tWStU9UrIzz54A1aHDtkCG0SXGByeh30N1O/3aa9lOy4bdG/1OHuWfYhT0ushW
         iZ4W/7c+icKJNBWS6GI0BZ+6LZV26txCwW0k4buwr4bcnnnpTLVc4jn5cnMp60NY5mUe
         rCsXn0/I8X9wWGslOdRJHx2Q1hHHoWsSe/cIJ6M+YzSqp7HU6vYlgIDsgX9yciz3ABUw
         v9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749683906; x=1750288706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH7kdqDH3UenuCefuE3ilsRIIVNqXsDM9lPT44w9Sy0=;
        b=Zug9L+Rdv+rCUibBPBdTLQGZcqBEt2dpjnKMfVgVyTrvqZEYOmum/ffnGQO8dWwaTw
         wwNRXxxySDV91FvzI0Pqz1BmQq++GjYR3rXxtVai/sV0vIdewq2jQKIfIaz5yWCc4tvN
         tz4F0OjxE8KKUdtKJXXjE7+D17muWMRSAu2EZgdSuMJxkyyxUSsPyf8v5eHn1EoXESql
         gGOr+sQvXsTLFz99qVZG7fLznksP+Jx1w4DlgCATcGAm6TFdObIMdfKwzbEaxp68sJA0
         4omi9OXO5h9qM/hLjAC/w92xlENhxE0avr7D8TAZv+Ph3e+kyBkr18Rn85qhmr1+FHnm
         ZGyw==
X-Gm-Message-State: AOJu0Ywb6tp7aNjGMr6mvcuzQdSTpJHUbSJbhwn2DrVkovL1eAXSj2/r
	wa8ZexyqkW9bbvpAeBgI157+x8r22CRxC1VngOen04+oF+84yMYaDMlrDXuXI2lG+WWnuhH+G94
	Uf/kfglJlwWW9zFGt0u3Pyj4jmx8fQkE=
X-Gm-Gg: ASbGncuU/itt4W7dCK10PiO4sfeZh5odRPM6v6dB0xzPKlnA0aWCCrRgXoHy5ctjEMu
	lTe/HLYg5qVmQ0exsK9Ih2oYYtubWZTFyyfPbrReVcYhdxcMhi7A6cRwfzmvy9vBSm/QjgZGDMU
	XOkZiWahvwYE3n/xZuK3jrnFtLyhQHMBZxMjpv2m2cNSgVPXfVfYdQZy/YGsV4b1FeZkKHjtmBG
	1twgA==
X-Google-Smtp-Source: AGHT+IGfiukWW0QASHSMpFF48y3lbOkVRxTaOowMMg4zsFEobClKoF9MswkokX2GCRUH1fNV5AdKYHnL7ibmwLXeFS4=
X-Received: by 2002:a17:907:3e98:b0:adb:1804:db93 with SMTP id
 a640c23a62f3a-adea3749a7bmr130067466b.49.1749683905695; Wed, 11 Jun 2025
 16:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN0PR01MB95880EAA98466C9AB049BA44B86BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN0PR01MB95880EAA98466C9AB049BA44B86BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 11 Jun 2025 19:18:14 -0400
X-Gm-Features: AX0GCFutk1hZOAavOc4xTlzjBYnnUYJk2lE_JQ2MJI_pF7AutRB4X1ZeLiLHSCY
Message-ID: <CALnO6CA-SvasocZ_tbN2_-DiGCO55W6gyXDjJZqRo5Y3D4JRmg@mail.gmail.com>
Subject: Re: Question: is there a possibility of getting a warning before a
 git push -f
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Le 9 juin 2025 =C3=A0 12:47, Aditya Garg <gargaditya08@live.com> a =C3=A9=
crit :
>
> =EF=BB=BFOne thing I sometimes encounter is that I sometimes git push -f =
and moments later I realise I did it at the wrong time, result being a disa=
ster.

2 effective habits I like:
- Check what I=E2=80=99m pushing first.
- Only force when absolutely needed, and even then default to a
=E2=80=9Cstrict=E2=80=9D version (force-with-lease *and* force-if-includes;=
 I use an
alias =E2=80=9Cpf=E2=80=9D and some config to make it easy, since I do forc=
e-push
regularly in a rebase-heavy workflow).

Expanding a bit:

I have a =E2=80=9Cgit-div=E2=80=9D script that will show me the graph in th=
e way I
like between HEAD and @{push}, or @{upstream} if those are the same
revision [it accepts arbitrary revisions though]. It was mostly
inspired by mjd=E2=80=99s git-vee, and uses lots of annotations (cherry-mar=
k,
left-right, boundary) to give a quick HUD.

https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-div

(=E2=80=9Cgraph=E2=80=9D is an alias for git-log with the graph and oneline=
 options)

I also use(d to) use show-branch a lot, and I have aliases sbu =3D
show-branch HEAD @{upstream} and sbup =3D sbu @{push} that I still use
sometimes.

As I recently told some colleagues, I consider regularly reviewing
where in the commit graph I am equally as important as checking
git-status.

The second bullet is probably self-explanatory, but the basic idea is
to give myself the most protection I can, and only weaken it as
necessary. In fact, I almost never need to remove any of those
=E2=80=9Cstrict=E2=80=9D flags to force-push except when I=E2=80=99m intent=
ionally
force-pushing from a detached HEAD
(https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-G=
usGLA@mail.gmail.com/).


> I was wondering if a little [y/N] warning could be possible before the ri=
sky command gets executed. I saw the code for push superficially and I don'=
t think it's implemented. I think it would be a nice feature though.
