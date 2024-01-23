Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3E66B24
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026572; cv=none; b=StZxX83DMmKpnUxzyZZ7zR4DxivbbUfNG5PKD8CWLu4RkiSvmpw/joxEyp9vxztIGCGAtmvh3H9e7y+ATLbHFqMkEo+72MsQZAy5VYZ7B40Djyw8JQO0V1vZxiHNe8YC0Jq1nHN4U7yZM4yzEqBbbbovEcPDafEBLGU2or9IAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026572; c=relaxed/simple;
	bh=e4JbvCQ1pDrQC1cEEg1IIM7+wK9U7zlZd6wK/1hT4Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVvV0rHOQ9aGyGrGS9mj/c8yMcNQ3HsQmj0H/uI5u7uygnqKjUBIynlMFAv42QRG2syiSRxDijjXmVjRgrewEhYAhZg4h40r5p+If/D5syr09OgtS39mFcmFM6PDcHUBscdZhpnicdfOv6Mx/SwljEY1SFtjPEy4Uj/Lc3plErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/THsDMn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/THsDMn"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so5326882a12.2
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 08:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706026569; x=1706631369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HiTDKIwUGyy4zZCJfP09wkmEEFuzKVBUI3uh9tNh1A=;
        b=P/THsDMn8RC7NFDgi+RVJL+KmKeYI6au+LKfnlQdVfqpYtyMKUYLhXdTosWmUx0OcW
         AgDCCKCj3tSkDZXS0pjSg1zr/eHcaTp7adKjLj/ctoQR+0SzuJek/2E8D0Yo+lpyXiXK
         fY1+4kIVZLE3YZxoZVWMzD68lNKpI4efYJcutbtoThG+rVa4G6Xfn5lxEcKwIn9FdMQy
         vH9wJ76Lp2EezF4pf75VrrlV/oUhRdmDgkEvWkf+X87sMTKq27E1cKIa6znQOeyLYXi4
         wauQwbs+csGm4RJq3SgrF2ENDapmcC4xaBxDfp7inJcAvkgx3DU10f+zmtQ6NHX516yy
         Vlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706026569; x=1706631369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HiTDKIwUGyy4zZCJfP09wkmEEFuzKVBUI3uh9tNh1A=;
        b=d/yMMwhCSuQiKGyCnrs/wj0fFMNYCoX6KkuzdMvjb87+e4wgPkQ+ed+NdTbNzBt4oT
         bLQ5XSQixRAh9+fmbr9RV+gKs8PVeg1Lki+zu9d4KyT9V+9eV2dSH4BG7HTPd0CLUq9v
         gklJOxequJmCNYIsrLfrlsgukHoRDyeGj2VCwV6aMVvseqbPpSzg6HoNRd2YuM44nsGC
         IqQTVyDoNYJmql4oVPV1b/SLppOYDsUHIkyr/nVZ+ger9nsJxC1DDfAnCrt1UNOlptw5
         rDfJnXR2oWjnpoahAL6ZyiMTo6VlxfHPEZzXHlY+gkTXYao7oP939A5rxafqj7vHGLT1
         w/Zg==
X-Gm-Message-State: AOJu0YzdF3XYLR8iBmgdAtNGI4NmO3QhgfomVZUQEoCebNxUmXcPpvbb
	OR+VIxqd63zoP3Lf8vct69R9BkArO1GAee2n9pv6bD6u+SepEW4EIKM27hJi5hs0Cc+JFEw1xjB
	DPbZsd5dSB9UpcNyJyaJQysqoiFUEFU+T
X-Google-Smtp-Source: AGHT+IEsv+7EHqdJUK9OdQitUn0NntZpXRYu5ld8sMkJts4gA5VfBuq+zOE1w3W3Kr/IyZP798MuI1ugVoJOCMRvyCA=
X-Received: by 2002:a17:906:36c2:b0:a30:4618:80a0 with SMTP id
 b2-20020a17090636c200b00a30461880a0mr52847ejc.33.1706026568390; Tue, 23 Jan
 2024 08:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <cover.1704877233.git.ps@pks.im> <1284b70fab6dd85114cb24fc5c7b6c49e35eb135.1704877233.git.ps@pks.im>
In-Reply-To: <1284b70fab6dd85114cb24fc5c7b6c49e35eb135.1704877233.git.ps@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 23 Jan 2024 17:15:56 +0100
Message-ID: <CAP8UFD0yh4k4p7zcM+ZF90oWWTUMoGVpd3ajWWOV5pk++YKerw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] t1302: make tests more robust with new extensions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:02=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> In t1302 we exercise logic around "core.repositoryFormatVersion" and
> extensions. These tests are not particularly robust against extensions
> like the newly introduced "refStorage" extension.

Here also it's not very clear what robust means. Some examples of how
things could fail would perhaps help.

> Refactor the tests to be more robust:
>
>   - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
>     repository format version. This helps to ensure that we only need to
>     update the prereq in a central place when new extensions are added.
>
>   - Use a separate repository to rewrite ".git/config" to test
>     combinations of the repository format version and extensions. This
>     ensures that we don't break the main test repository.
>
>   - Do not rewrite ".git/config" when exercising the "preciousObjects"
>     extension.

It would be nice to talk a bit about the failures that each of the
above changes could prevent.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1302-repo-version.sh | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
> index 179474fa65..7c680c91c4 100755
> --- a/t/t1302-repo-version.sh
> +++ b/t/t1302-repo-version.sh
> @@ -28,7 +28,12 @@ test_expect_success 'setup' '
>  '
>
>  test_expect_success 'gitdir selection on normal repos' '
> -       test_oid version >expect &&
> +       if test_have_prereq DEFAULT_REPO_FORMAT
> +       then
> +               echo 0
> +       else
> +               echo 1
> +       fi >expect &&
>         git config core.repositoryformatversion >actual &&
>         git -C test config core.repositoryformatversion >actual2 &&
>         test_cmp expect actual &&
> @@ -79,8 +84,13 @@ mkconfig () {

Before that hunk there is:

test_expect_success 'setup' '
    test_oid_cache <<-\EOF &&
    version sha1:0
    version sha256:1
    EOF

and it seems to me that the above test_oid_cache call is not needed
anymore, if `test_oid version` is not used anymore.

Otherwise this looks good to me.
