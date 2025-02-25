Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96C1F60A
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469006; cv=none; b=vBtBJiiXT8sY2WXKaDlVJU3TphFNF+BMQbSQSamhWtqUgAzsw5B1V9X/FBtblz6K141S4+C65OLGoXQEe0CsZhKNizwaFC1pwzhWur6xrD73RyyIFoN5YwoMPaNZCGSMdaREh1/kba4zfAjBeOLvh5hXOHgWwcQ89p2H7PfgLLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469006; c=relaxed/simple;
	bh=nOeSbh60/Me6W30k54bnze940VSTqWoTvCqVX//d2AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXabe1VAVvueFEisgnR61z3eSkf/1jIdlseSkbPcE2FptdmH0cbBzeHE3SiocC/HWxw0mPRYlrzx8WipKhyORxn3qTHOqe+UmxaQnnwGE1GSLhX5ZFxaMLFj3mu5dre6arli/vzaK8d11VDT63+g0Xmo49rCAKYZlLMENQNnt9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7SN1y1N; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7SN1y1N"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3cfc8772469so16654715ab.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 23:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740469004; x=1741073804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQcl2+Mb809REerAQG9lIBCTXKXELhovC3DI5/sYD8Q=;
        b=N7SN1y1NbC/n3vvV4DDkrR+1OqlKKUn46CD8UNYWMnjMC2Pw31m4b1gfa6fvVdlP0I
         ONkeKHmoG4sPCYyhj/zXkvNaXDHiKzzFLmMNqtxWano45hjfgKG5YfySrcTYinkG+WjU
         hRFSABVGiOP3v7y99LrHHYpfWC9VCpdOgMNgoEklvXLMIpaiKNzS+ZJyyhIdj/DlD7cY
         aiHGhJmzhWnNcjaLCpESxJR+8DcS+ioLrrwbqYpqBTt9JYZR1WvYVXgYcT3gpS2ZFIKw
         SvP4Mzi3W6mwWe6rYLmdGxouzWydvSvhBAiMurhKwnGvhNr5xJ6Wus5G17SXFGuiM7Ui
         Si/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740469004; x=1741073804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQcl2+Mb809REerAQG9lIBCTXKXELhovC3DI5/sYD8Q=;
        b=lSZEypdit0KoOhx86gopo/riUPZ/oLpaweeSfPF+9uRBBGIzoMoWQqUNdOANM0mZ7d
         dCTVZQO1cnB2SNdeDJuyZ1FrJemX1W2s097GRCeXU7kBpLx0x6rLU1H+tdmnTva+tZUN
         BuqL4f1Ii7EVgqhuptc9KVN1R6wgU8BeFp2pv2WhawwhrRQgBVEyeqWYTvOIfgdZ9/Yj
         yRfyN2JVa1xh5ZF+3cN8gRMui0OTO/T3RXdDCm6k2SY/EF3pvPpGkCGHQUx+B0oZ8FO+
         QTgK31vX0GUoBmMyvlG9VXtn+e7bOMm5x7WUJgqM0cAw4F9JqMldnxzd3fIkz4VCqsPU
         zyxA==
X-Gm-Message-State: AOJu0Ywh4yHJjySRuymhsw8ZRzDHbRO0yO9FqrGYPB7VqTKmcULq46Q6
	HoEs+B6Pb3cFBHoG1AldmP0WEFXFwOCiwBDipTs38Qq5wju3stcTr9gIEKXEr121f6KLwH+bnQk
	z/RhG3Bku76I5BEi6suDTn5Pdiw4=
X-Gm-Gg: ASbGncvNwSxHaYjDvp3nhJ4V5vjDWZi2i8GKI942mt/q+OsWa/zvnAneLpCQk6+2m35
	X+FBRUGlqHEltAdZNX6oFNbZDQhp8RB/UBL10VO2zoQupc4+WU4jVTJ/I0Y134JcAZElWTGBYSo
	g0Lln201hLNZhQyCaXjVeksH7MJlw/0/V+i3LDrzc=
X-Google-Smtp-Source: AGHT+IFNEEOdx2YMv+9a4BzgFIMxJ5D/Qgz8qHFAUF+rNzz/qsM/atR3zNDxrNnV/jjm2fh7S3pjtYhq1BcTHmazLmo=
X-Received: by 2002:a05:6e02:1a2a:b0:3d2:6768:c4fa with SMTP id
 e9e14a558f8ab-3d2caf0980emr181064045ab.21.1740469004005; Mon, 24 Feb 2025
 23:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210430232537.1131641-1-lukeshu@lukeshu.com> <20250224142744.279643-1-christian.couder@gmail.com>
 <20250224142744.279643-7-christian.couder@gmail.com>
In-Reply-To: <20250224142744.279643-7-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Feb 2025 23:35:00 -0800
X-Gm-Features: AWEUYZk2jNc9QaYUcFr91bYDRVnB7zbclqGkSy0K4ST9BboiQs39FGXKhAM5fZU
Message-ID: <CABPp-BErRqke5DH7c3+u19iw1U5JgWYB=xcUwrE3NObf=EYz1Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] fast-export, fast-import: add support for signed-commits
To: Christian Couder <christian.couder@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Luke Shumaker <lukeshu@lukeshu.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	Luke Shumaker <lukeshu@datawire.io>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:28=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
[...snip...]
> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-=
export.adoc
> index 1b19f17b78..8750dd150b 100644
> --- a/Documentation/git-fast-export.adoc
> +++ b/Documentation/git-fast-export.adoc
> @@ -43,6 +43,17 @@ they will be exported, but you will see a warning.  'v=
erbatim' and
>  transformation affecting tags will be performed, or if you do not
>  care that the resulting tag will have an invalid signature.
>
> +--signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> +       Specify how to handle signed commits.  Behaves exactly as
> +       '--signed-tags', but for commits.

Should this also explicitly call out that the default is abort?  Yes,
I know that...

> ++
> +Earlier versions this command that did not have '--signed-commits'
> +behaved as if '--signed-commits=3Dstrip'.  As an escape hatch for users
> +of tools that call 'git fast-export' but do not yet support
> +'--signed-commits', you may set the environment variable
> +'FAST_EXPORT_SIGNED_COMMITS_NOABORT=3D1' in order to change the default
> +from 'abort' to 'warn-strip'.

...this paragraph implies abort is the default, but I imagine we
eventually drop this paragraph, but
it'd still be useful to have the default called out.

[...snip...]

> @@ -611,6 +615,44 @@ static void anonymize_ident_line(const char **beg, c=
onst char **end)
>         *end =3D out->buf + out->len;
>  }
>
> +/*
> + * find_commit_multiline_header is similar to find_commit_header,
> + * except that it handles multi-line headers, rathar than simply

s/rathar/rather/

[...snip...]
