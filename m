Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF91EC01B
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389200; cv=none; b=U5kPVepsZzohNj7Nim/6PuG8lIKOjjF48j0j97792slOdnDS7nOsnMFP4jI3sm0GrEeEk3mcLYC0pku4OCPgLkeDCdwK1kan0ECX1QeWoLguAjBlmJXXmdOuP8TSoHn1eVyv2/ZxNsjdJ0V+Z0/q63rflTBT/BU92//kcU9urAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389200; c=relaxed/simple;
	bh=0XzOBLWzVgUVWP3FIbwyYTZU+o6ixid6KNum/YOMgqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3TRlLJuCcGmvhcd8wCXTiwos9Ow480yXmVZXV/HmzLIWTDc1uy+igyj1SjGWJB4ilquTqiNlJfzohlbSUvI6Kuf4FMn15DBp6PF4LBocZJ9RKX16W0VyY2UxBuhHrdtqwqKL9nquZUF+ACgJLZTCX6KTkPB0G3Mk3Su6R6vjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDx9MxFB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDx9MxFB"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso1215826a12.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756389197; x=1756993997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lo/uw9swHinTDObrJ7eH6au9kOdzrT+EUyPNY1xs5iw=;
        b=DDx9MxFBfa4s+4AUkO/aKU+98krpbguIZ8Vh+8yaXBxzTVHwxy6GlCLhH+VWS0a3vT
         WT2BvSKf9eHNjDetx75S6zfUHe45dzWPMYiPs3gWFL3PXvUKTTpUNDmmg5nzvW0mj6s0
         9XPgKviVxld7z722Ekn2d0fwhTc2QJsBVRw+ErVH/FoB+P6jPYodpTl0ACG3Sbh/upQy
         U9MeDyaJN99BXUET/E/6IrvjtwhXoNSocCmj0tchWo8RCedCqZhLGJboaoCzhy5Viis0
         4U1Icr2M6d/LwW0Iikf90I+eibsdLiEpUAPllyUPbgH51M46uomqA43LoarO3jWoI/78
         cYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756389197; x=1756993997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lo/uw9swHinTDObrJ7eH6au9kOdzrT+EUyPNY1xs5iw=;
        b=K5hirVYoreg+2huBdr050tV410GOllMBh+ZXpGTcxvmjGDB7kEqE4vXKU63KYIMYsS
         qw6KvaTLndA1DJH0kK3bL45mrFSoyfRvdZRsHBQf1YmAVbMsvgZ4pzFhdDcd0IMWVFJJ
         2HejQz+XJukARKF8DbKXSeoaz8ssICEGTIsUWsmIxUYU8YWupl0nHfpL1xbNBSasExRy
         Mbm9u4OsRZtOBt+iZgzsfgqzMNeMbegUYTrb5hu7z5KaYxgWLew3FqrNlbtKoFGVssNy
         8sXdzuC1be1wVsedmFg4wV3TDm+tDH5IzrudecgRsj/ItbueUAFbLwdZqKXYzHL/XGLM
         hruw==
X-Gm-Message-State: AOJu0YwYmbEU6WFmSs5DG8fW/yirX8Vh+PjsrAwfhBZZp4mXGwleTHDn
	SmYQdVYwS3i7ScEDBNVaxErJUkpcHFuM4xs0QG2x6ymtH3JxycDWkAvJn0SGShXkVUid+qB1jMk
	wuZ7tz1YGEW5aDnTnl+SOxgQXYKbDYz+5CgKD
X-Gm-Gg: ASbGncsOqHQO8FbVe+dFJGtAv77jtGf7dWkf4GIulaTqBkaGPmEzWSCL2sKPzKCbnuq
	1AROyGmN0YpEU0VYVwxEIBg5fPP0bh7aGW+ylMly91+5P80nL69ij2QV1KJKG7ydyUHWz99SphH
	SbafC0uHnJ1hSc1HT2lahNeLmCZDkqc1UQl23k+hElPxNeRxVKQiIQF2pNC4iVa7g0DdGZbKEA0
	6ew/rbVZ3YnFDnhbtZ2VedQNOgLKQ7/BBQTqUMXOhuFlYKaxfV8
X-Google-Smtp-Source: AGHT+IGch8ZlhuOcWscBxKmXJ/WxXReZrCRf972KWCKgx7GLqBI/IawsIu9pIgJLwTadWV7pHNYKV7BQlH8mWzUIBzc=
X-Received: by 2002:a05:6402:274c:b0:61c:d7b6:6218 with SMTP id
 4fb4d7f45d1cf-61cd7b663edmr2622635a12.13.1756389197137; Thu, 28 Aug 2025
 06:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com> <2fa98fb5cae78b8872d0b864ee246ba619ef631b.1756240823.git.gitgitgadget@gmail.com>
In-Reply-To: <2fa98fb5cae78b8872d0b864ee246ba619ef631b.1756240823.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 28 Aug 2025 09:53:06 -0400
X-Gm-Features: Ac12FXyAtu_jnPOjL5QdaGuosqs1JA3wOCGgKS9vjWNHv-FTRnMWTmUjZ5kABvQ
Message-ID: <CALnO6CCca2Yp7K16ShqUaZNN_POv106qyXfKq1aJMyXhA+EyCw@mail.gmail.com>
Subject: Re: [PATCH 1/4] doc: git-push: update intro
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:40=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> - Users don't understand what a "ref" is, expand it
[snip]
> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index d1978650d60a..e73b64f61fd0 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -19,12 +19,8 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>
> -Updates remote refs using local refs, while sending objects
> -necessary to complete the given refs.
> -
> -You can make interesting things happen to a repository
> -every time you push into it, by setting up 'hooks' there.  See
> -documentation for linkgit:git-receive-pack[1].
> +Updates one or more branches, tags, or other references in a remote
> +repository from your local repository.

Considering the glossary entry[1] is for "ref", not "reference", what about

(a) linking to the glossary (is this possible?), and/or
(b) saying something like

    Updates one or more branches, tags, or other references (called "refs")=
=E2=80=A6

?

[1]: "git help glossary", or
https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-ref

>
>  When the command line does not specify where to push with the
>  `<repository>` argument, `branch.*.remote` configuration for the
> @@ -44,6 +40,9 @@ corresponding upstream branch, but as a safety measure,=
 the push is
>  aborted if the upstream branch does not have the same name as the
>  local one.
>
> +You can make interesting things happen to a repository
> +every time you push into it, by setting up 'hooks' there.  See
> +documentation for linkgit:git-receive-pack[1].

Seems reasonable to me. Thanks!

--=20
D. Ben Knoble
