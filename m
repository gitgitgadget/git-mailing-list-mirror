Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCFA1D88B9
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314674; cv=none; b=NJt0xy3kov9dURDOdXAmEuH3ga2mZgq8bOW8duMwqCy9NWSQQ1XzRfb5JgtOTMDs4oXC4QM2hoP84S8KN3mQEM9pBfQFs7qyz6/pMHAgHRheLQohYLDt3oq13JETd7eWBL2Ea7xKfdihlrGRPXqXhtsVyX745vuYypa4bfgthzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314674; c=relaxed/simple;
	bh=2PN5qAc9ZSf4tO+3CzPmzUlmTQ91JyliKiBFNThVH7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMRi4uRIGcJV/m/ompv7lUVzzNdMd5/9CDWQgNyHWAKnncmgt083gP0RkBoCzP68jX+R92g5eMGGR+yy505BGCCyM+MfLu+yvhSAgpKhsE+7XHeqSwEH0roOg9pnb1JkKMCHAKhKHLKFEwJeDFsOP32BoTUhDfnhIxPyIx8O5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw6NCgC0; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw6NCgC0"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a1f1ef7550so17666355ab.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314672; x=1728919472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7aB40FkRm8NjE3+Di/WICtM0auTYiubqf88LgKWihM=;
        b=Xw6NCgC0PIkBPoa6oYFQbiM1vrfHbWdW9342dv0IrPAFDK/0Dj4Vr+hKE5furDNYeG
         6i0PeDceCLuvESx4J2Gilj9tf8nL8PrlPEFA7L181MCDbGxVqIALYV3LpzKleQDcuBXZ
         ZCklIKulPVg1NBseU1adATouQdZdXbanAS34ucDbwwarc9sFUzHE66bz6qfymdS8KVNs
         6ldzQ+N7qbeTtnzfwqvs+kGXZZNJXPeaAAhj7xOF/+HQBX5c/Emlsj0V6y0PAL/UNSwP
         nIXXA0hcYF7Qf3IBMfgJSyW0tp7ZPBhhYMrTQSKZgbpRchTrw9ueYih8Os0ilplUZ4W8
         Iugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314672; x=1728919472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7aB40FkRm8NjE3+Di/WICtM0auTYiubqf88LgKWihM=;
        b=HM7ngEObG5Ci0nUVSOpoWX43YGAD6bgqlNnzDNj16GiDY+NQ/1ZlEWMkL84SwRSG+5
         QIbXNxMZQ9YC7Rv4IlCzAajMbD2Fyk2C0kSVOg91upWjXgL1ymH3XfqqdgoLdChL1EOq
         RIY6CueacEOQVGYY3QQym+nz//77l7qI0rNiB1eolObfqB7pWJw2kKRy4F5aSDAQB69C
         OjHYYa1LIMQNJQelAWLWM3Sj6FzCf8w8mCQ1gd1DiDj+/MaScvy2GHS5PVMeRsKxe06v
         nitPADsPyHZOTZHPE5qkGDvUCEcCdOwtgGliwe2JspoMVL6Ke8J0V3zG/WnCyArZ+008
         tRNw==
X-Gm-Message-State: AOJu0YyPYyfolB5LgkeEWFnPbmXAR3IOGir1bAC40YUSTeTCCHV8+7Gz
	TINkVQBRWe/fl1SCMBI48JOai6Ito4Rt/CtZiidiaA4wOwY4CJrUbDYpd+K2MR+KBYGRValOszI
	BjgCQbnV4k+YEHIIHBXIeGnO26ZQ=
X-Google-Smtp-Source: AGHT+IGd9LbKHXVyk8nfeHHEB/Y1HRY7IKaATPmAaXgYHnsgAqBhjvI/pZl3ASNVbQDoJIHlFTtvLA5OwNqmH/MGEU4=
X-Received: by 2002:a05:6e02:170b:b0:3a2:91f:497b with SMTP id
 e9e14a558f8ab-3a375b96075mr114353855ab.13.1728314672201; Mon, 07 Oct 2024
 08:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728298931.git.code@khaugsbakk.name> <4057d6386125e51fd934f92abd11c62a9d24a832.1728298931.git.code@khaugsbakk.name>
In-Reply-To: <4057d6386125e51fd934f92abd11c62a9d24a832.1728298931.git.code@khaugsbakk.name>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 7 Oct 2024 08:24:19 -0700
Message-ID: <CABPp-BFG0KQVzu_AT-GwW0rg0Ly3uVY1+M4Sgh5E8Gn9A=5BKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: merge-tree: use || directly
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:11=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Use `||` directly since that is more straightforward than checking the
> last exit status.
>
> Also use `echo` and `exit` since `die` is not defined.

Not defined where?  It's defined in my scripts...  ;-)

Just kidding; this is a good change.

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-merge-tree.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index 10f8ac7f80a..46091da022d 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -211,8 +211,10 @@ linkgit:git-commit-tree[1], linkgit:git-write-tree[1=
],
>  linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
>  used as a part of a series of steps such as:
>
> -       newtree=3D$(git merge-tree --write-tree $branch1 $branch2)
> -       test $? -eq 0 || die "There were conflicts..."
> +       newtree=3D$(git merge-tree --write-tree $branch1 $branch2) || {
> +           echo "There were conflicts..." 1>&2
> +           exit 1
> +       }

Thanks.
