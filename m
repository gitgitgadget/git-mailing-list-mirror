Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011A1624C3
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740626813; cv=none; b=WM6jUyIC1wa9pndt718rzvs/YB311sxLDLbuSHWEzYm2nE8l8D6RrEl12LGbfjkLf3ZY5lW21z8t7s83WNUL0Bmp4zxNdSzrV1l6P2XDNJh3mrJyeNSytvlVRta08icBCuMx6rn+Otal49X8JJBV70Tv3wlszjSiVfxe2TalB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740626813; c=relaxed/simple;
	bh=PnKryQO7fJl5C/g1i6BdevQF3fE8VMw2W73XpUiDXEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhAO6j/cETAW0cL+V6AOzBgYqgcso2MaIbLRenKMAvMWvwyyN81aS5+MrH9inS156URP6dUTMBTVuQrYgzplQs0fgr2uxhpBBev37azBJU27UyjHPvt0nX97y8ThHOUV7qyAdiznhCbUAqDL4Hoxjx9gkEqn+zmDIR3wOYX/lEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3vUiKNz; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3vUiKNz"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8560dea3ceeso13502639f.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 19:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740626811; x=1741231611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImzYN/7S6ULgh8EDwD8wC4DXO/re/woy0yEa9E594Ig=;
        b=A3vUiKNzhuQLmcTRpsrQ/T17Ypih5T62AJpMclG5h87P7aLxtGRT3QbdlqcuPDwkqz
         P6Q6b9iMThNvgOiqBIqb35oYVxu/QAqN+S4UZg1WsdeVrtKJxEaZpAc8jezgqs3Zu3/p
         x9ftU+udpI3avMP0x8zCYkxkHp4MDMKYqjionbRmQUdSkjCL10vMZDCOKKi++X9GmFnL
         DVORZK+seHebjuryoBHuECrdaZI5koMRct6Rpg5SJRAdryg/Npi6QdMM+i06bnJxzPB2
         Mhw615e7wze18Hk8Q3usZ3U0HqVTPofHSjK0f0qwLpx2OOHL7PUf1q3ALX8OBIO4p8TS
         bZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740626811; x=1741231611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImzYN/7S6ULgh8EDwD8wC4DXO/re/woy0yEa9E594Ig=;
        b=Jbw6/Au8amULDtm6lgUlHm/xoSFI+X3LAeCqJmXCZQq1y+hpgswtQ1QGvReb5pi7Cw
         Aebw6VXEjTeuaCwSiRCSz2Nv51V1wnqcBxR1R4ogyjR9Cz25rs2m0XShHvVkB+aqrVwZ
         8AaQWgddB0Xmfe0/LfDsUtQR8ucXHfDl+2fYzEDGKUNIPbhrP0+7PuWqP9PUGYK4H7Fm
         KHMJgVfhuGAYjC7LIhhFlTWJHjGRY85xq0XvFRnWrWJvW5ez9YVeBrbyZIq77eA1uzk8
         nY0qONO963hXXzmdufRkh/beyR99C40SqC2S0dMd5HgL6cTI5Yc1yilmvonBSidabuOD
         mFYw==
X-Gm-Message-State: AOJu0YwwEoDhiKCPQqmUAOz8TlX857jidHwml/mlTpfu6CyQTrkcpzpe
	YE9CtnirqH8imbQaDN8NEyKtY247s+9DanJWb9j/G7njwutxNwUWZsawCrbbzutNEpjO8CxDiek
	+0A1D6U4mV0yjvezL3CNoRjRkmE9Hpw==
X-Gm-Gg: ASbGnctRmcT0B4rj3KtJMZV8Fkz51k1VGvyvhcstH/6PshMW6RvyJUPPKP7S/rhEytQ
	cFwxrHszSlt8AUquf0jw7o9lKBMG9zJki2nlxm+5Tk5PaRhrmPgRj7sKISdix7BppmVY941Lccm
	y4ngfmU0bCflLMu8snkZFewocMpulYwodVKyFiG2k0
X-Google-Smtp-Source: AGHT+IF0Tn28mpwWcfZYTCn+mHfOfPKYyxnUEKqobAfFsPO/VzKn7HUTN4kL2QV7n7XD/CGD0ZBOnw1pEFntZCeMY94=
X-Received: by 2002:a05:6602:2dc3:b0:855:7837:ab12 with SMTP id
 ca18e2360f4ac-857acc6402fmr556215039f.3.1740626810915; Wed, 26 Feb 2025
 19:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227014406.20527-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20250227014406.20527-1-lucasseikioshiro@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Feb 2025 19:26:39 -0800
X-Gm-Features: AQ5f1JqUgzi1qbT7gVZve16S3uUlMbG3_MDqOXkqHptQzuzjqcRYmuKZWypQM_s
Message-ID: <CABPp-BGA530spgVtsU2UO7GyVXL2x=R_80n02pMiPCVA+1SgBg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4] merge-strategies.adoc: detail submodule merge
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 5:44=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
> Submodule merges are, in general, similar to other merges based on oid
> three-way-merge. When a conflict happens, however, Git has two special
> cases (introduced in 68d03e4a6e44) on handling the conflict before
> yielding it to the user. From the merge-ort and merge-recursive sources:
>
> - "Case #1: a is contained in b or vice versa": both strategies try to
> perform a fast-forward in the submodules if the commit referred by the
> conflicted submodule is descendant of another;
>
> - "Case #2: There are one or more merges that contain a and b in the
> submodule.  If there is only one, then present it as a suggestion to the
> user, but leave it marked unmerged so the user needs to confirm the
> resolution."
>
> Add a small paragraph on merge-strategies.adoc describing this behavior.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>
> Just removing an extra blank line from v3.
>
> Documentation/merge-strategies.adoc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-st=
rategies.adoc
> index 5fc54ec060..c8d81bcda6 100644
> --- a/Documentation/merge-strategies.adoc
> +++ b/Documentation/merge-strategies.adoc
> @@ -22,6 +22,13 @@ ort::
>         was written as a replacement for the previous default
>         algorithm, `recursive`.
>  +
> +In the case where the path is a submodule, if the submodule commit used =
on
> +one side of the merge is a descendant of the submodule commit used on th=
e
> +other side of the merge, Git attempts to fast-forward to the
> +descendant. Otherwise, Git will treat this case as a conflict, suggestin=
g
> +as a resolution a submodule commit that is descendant of the conflicting
> +ones, if one exists.
> ++
>  The 'ort' strategy can take the following options:
>
>  ours;;
> @@ -96,6 +103,9 @@ recursive::
>         the default strategy for resolving two heads from Git v0.99.9k
>         until v2.33.0.
>  +
> +For a path that is a submodule, the same caution as 'ort' applies to thi=
s
> +strategy.
> ++
>  The 'recursive' strategy takes the same options as 'ort'.  However,
>  there are three additional options that 'ort' ignores (not documented
>  above) that are potentially useful with the 'recursive' strategy:
> --
> 2.39.5 (Apple Git-154)

Looks good to me; thanks!
