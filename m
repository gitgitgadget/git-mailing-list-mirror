Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2C213EDF
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416102; cv=none; b=QRIo6g3nhFHIkCiQja9Bl5VWpAlYXOqlsqmCOlV9MLd2ozXUwPDg9R/8yz5jclqCF4o7273nLVeLvFUlVvg2rhCUByam6XmsbcKg+yoFRSVGQ3uYcB6M8jLiyukeuR22iWSRzdW9frGf7YKVZJnd0vFXRZzRgsgCEQcmU7mAIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416102; c=relaxed/simple;
	bh=8iS+idRCx39StPUfTLU5MimZziGxM4Yr+MdrzjexD8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iI+BkocxyDI6/oPAXcWto/6x1iUSo97pPIBeWvpeRyQZ044q86BMhZVVdmgMA6IyRThftkXimK6M2+EeqHwtpkI83f5LPHqWisaDlr2Qe5+eEQG/q5P1oiwWtQbNvi1uS+NVvng50RfKSEd2vOHxLjjLZAFqx2SgJQQk/qdxtp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHtXTVGE; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHtXTVGE"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso65548801fa.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728416098; x=1729020898; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKwAyP863110+LooQ77d22W1fWpMbV1LSFaQcqaHu4A=;
        b=QHtXTVGEK/WZq6IOieeHs5HtGFYm53I48pM4kuvkniyBE2QvUr+e/E6k1c/DM6TIMo
         dPDBZzYeQh6k0NKwm6UZPbWtLTO+FlBdk3MiRg+t4xTOK3pcHhUnhhJEYnDXrYd/eb/9
         lWl92y6aX9qprZWz9uTsakxiurcTsJCJqCseRzTE+ltD9vtvFVK3FeSBbLstzFMEs8fk
         +wzFhLs9KTsoCFpvsL3NcoEkexj4gQutE6eo4DY9HwcSSYsDL/ooh+X9oq3VdeoZWYgd
         dtz3u9xJ8Gf/HMVFjDzIqN96K6Y43tBEtVwDsHPryo+qN27/Ss9bgcoXaj20pZyH36Pc
         ViSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728416098; x=1729020898;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKwAyP863110+LooQ77d22W1fWpMbV1LSFaQcqaHu4A=;
        b=DnZUvsHghB7/xagZWz8yVRPi99nd85Vr7k57Sog2fSz6kc46OtZTepgKBqABmhjYH4
         dDTGZ6u1DS/7YNbrGXXeg6TyX9X00B4p7kwd+hbmID6dV0R8JDhv8iMvQo5bL32fWJbm
         r/wEy5Y5Tk8bs4HH54KmLuAWR6jyumpZaiNOVZ/oBoTH8ih7A9idVIGd3tVza9WHKNBA
         PrL45mQPfhd5yCOK0eyCRoREE3L+eYBpyiX1g68pobqb/ioVtPE3bfbl0a5daTfPQfVX
         gnud+oHVecflPiCQa2jyzwwg1GSFgu2xoMsX6OnQkdXNuxC+Ea/V8gWszAg/lW28q2oQ
         GHbg==
X-Forwarded-Encrypted: i=1; AJvYcCXEDgr9EL5T9Exd7IzYwh0vxshlg9pJgQ+YIYf9zxkxVXFDzhCReQo/sRAnyfU46KN7Kgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOj70GNGsyC6B9fcwhTD2Nhja7OiiTUDDkO1FUeR9xJYT4mRgt
	hOS+FZwozmm0igE2PEtZBS+UcWTfFCWifyxtdI0mHEBHBHoitCv7FPJqaCHTjWEuMRL23Tp3Lpw
	YgHP8YSeBx2pGRbeGHmN026ejxzPm
X-Google-Smtp-Source: AGHT+IFOhpNiyJhHR1CHuKaLqVJdS7C/Yo9isROd/VOk5cgF6n2vLnNj/0UKkMdhn4YnOUw2dlXXaEsrSSOaL/kwL7k=
X-Received: by 2002:a05:651c:505:b0:2fa:d9db:7bbe with SMTP id
 38308e7fff4ca-2fb1872ee2fmr1202821fa.16.1728416098052; Tue, 08 Oct 2024
 12:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
 <CABa71BwtEWS79CZwPOa_Nrh1iMrXRo+hyxNBc5F8GsQiwjdapw@mail.gmail.com> <ZwWDd1_76Z6zH4mP@tapette.crustytoothpaste.net>
In-Reply-To: <ZwWDd1_76Z6zH4mP@tapette.crustytoothpaste.net>
From: Spencer Fretwell <spencer.fretwell@gmail.com>
Date: Tue, 8 Oct 2024 13:34:46 -0600
Message-ID: <CABa71By0WYkbNip6-hmcX2jH1GuHWEx=WBTda5=RV9koR-cVFg@mail.gmail.com>
Subject: Re: Verbose Commit Ignore Line Fails via CRLF Line Endings
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Spencer Fretwell <spencer.fretwell@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Brian,

It appears sublime auto-normalizes endings to "whatever occurs most
frequently in the first 32kB". So, I guess it was witnessing the CRLF
from the verbose output and replacing all lines with CRLF. Thanks for
the reminder about --renormalize.

Is there any chance for git to support a CRLF magic ignore line,
particularly considering the variation in standard line ending across
different platforms? I tried autocrlf=3Dinput as well and it sadly
doesn't normalize the commit message file itself. Either way (magic
ignore with CRLF or normalizing line endings in the commit message),
would be appreciated for mixed line ending workflows (especially
considering WSL)

On Tue, Oct 8, 2024 at 1:09=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-10-08 at 18:37:47, Spencer Fretwell wrote:
> > On second glance it might involve having a file being committed that
> > has CRLF endings in it.
> > Committing files with LF only does not produce issue.
> >
> > I suspect git either needs to add support for a magic ignore line
> > ending with a CRLF,
> > or has to sanitize verbose output when that output has CRLF (less ideal=
)
> >
> > Bug originally seen as early as
> > [2018](https://superuser.com/questions/1367811/sometimes-git-includes-t=
he-diff-to-commit-message-when-using-verbose)
>
> Ah, yes, that would probably explain it.  Your editor is seeing some
> lines that are CRLF and assuming that the entire file is CRLF, which it
> should not.  In Vim and Neovim, you can do `setl ff=3Dunix` when loading =
a
> buffer for `git commit` that will force it to always use Unix line
> endings, and there's probably some functionality in Sublime Text that
> lets you force a particular line ending.
>
> What might also help is that if these are intended to be text files, you
> can set a `.gitattributes` file as outlined in the Git FAQ[0]:
>
>   # By default, guess.
>   *     text=3Dauto
>   # Mark all C files as text.
>   *.c   text
>   # Ensure all shell files have LF endings and all batch files have CRLF
>   # endings in the working tree and both have LF in the repo.
>   *.sh text eol=3Dlf
>   *.bat text eol=3Dcrlf
>   # Mark all JPEG files as binary.
>   *.jpg binary
>
> You can customize the file patterns as you see fit.  Once you do that
> and run `git add --renormalize .` (which you should do in the same
> commit as adding your `.gitattributes` file) and then commit, your text
> files will be stored in the repository as LF even though they may have
> CRLF endings in the working tree, and your diff output won't contain
> CRLF.
>
> [0] https://git-scm.com/docs/gitfaq#Documentation/gitfaq.txt#recommended-=
storage-settings
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
