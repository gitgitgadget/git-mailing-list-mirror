Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC561674
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026565; cv=none; b=LUnBtsBpR237l5PLeD7CtQEBvy3WjfEhkrwdfWlMY4q3Tu8u6KGDVcp7nS1hLgPucJxDSImQiLaClu2xZWqJjVw5Y1OC7p7V3FX7jwTfsAEB18TO21ZZcNYP77/xTo6r0IsegVKff2nYK1RWwAYZL/MiYjpTpihRxqtifdYUBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026565; c=relaxed/simple;
	bh=jmptYB/xjUysAaYIV+gm8utVqRr/GjGKW01VUDU1AUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHVvBX2Ldi9QyKJEs6cSeGSHe7iRpbmO2zStDGDgs6MJiVBElK74Iroesoyvgnag2EbcaDk7RkOl+A3FNEHxE/mykrDGBhofo78SssNpp3HdM1mgjxX3FFLo8YQwWdrL3UtUkjmDw1p+7LvaYqSrwgXhoRDVg6z2gBsxwQ3/fPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHWhaM6b; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHWhaM6b"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a26fa294e56so450781066b.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 08:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706026562; x=1706631362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UiMBJ6gMVYJ4cCKjQsg6vkWkszW02w9jxTtD6Jd6YY=;
        b=KHWhaM6bZRHptwods1WVI490+TjVZKMmhgEYQXyAmt732atiumiDEmW76kRt3tyDKi
         qgS3tdR6HvahipPM4aAaB5Oi2dXB5wEkULlf1RMXC37O0ou/wQ6cSNE94/WqQJUdpSJd
         qIquaSjLarJmFgrzBfNwNG8luw79YJJc40nC9za0khdq67/EnOMijuHXnOFwCOyHlMF6
         JjsMVHEU1tJmOi35sOAVkY3MSEQ2/Fy3TNsM7Ff2QdygRXMclRGzyOsJl+fFT8n+Zf5t
         0Pi7iqKxrNbaQnq+LCrYlUADieE/RuT1Unbqnps2d0Xca5bOtcVx8iCbJwB4XQc1GhOM
         GX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706026562; x=1706631362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UiMBJ6gMVYJ4cCKjQsg6vkWkszW02w9jxTtD6Jd6YY=;
        b=X5+4d5veDbjTD7kKxIV9Rs1S6/8AWJTZulYnNsAwEX2BT9qL4BixmLxve1G/P6gOH4
         xpoJMPLpTlf6Ghf913IlbugNhTeennVBAsIo/tbXoGJkB016almxac1fyJxYYQb7nXK1
         5JZqU5naxUSECalG75Nk9eoQ3ml1kFw73feKCu1n+NlPMse45bzJ/kfdQHVElCPE5CKl
         J2vY0Hwl2mNnZ9wJrr+6Z8YVMBGer4dCrckWVC1lzAmdjzBqvE5MLvvasZEW6/bJ/UsM
         kHC4Kf+eEL+pChLQGiuP+RXzlxQeWJVH8SiELcIHKrv7Q37iv4eu2ouAYWlmilH8+CMb
         SPxg==
X-Gm-Message-State: AOJu0YwR58XdMDg5t17FV7YrGK+OXCPFAg8nYqHv6Mt50ahvZ/Hm7dXA
	pz7+I8c/ckzkZF64b9PwV2ZVuUHgRRgxXTrCe4vLGyiwN3e8juSx1mSd9Kvhy/qNIY4ZrU35Tip
	BftrSU7bta6pqQI6oXHICNh+xgGU=
X-Google-Smtp-Source: AGHT+IGlH3Z4xthMgHG9wa5/ciqWs0Y81RVCt7ytBBehXfwZsW+g3RrWpTlaLOiA0bZnwrqGy1DcYUe8mRCHQvD8ZbU=
X-Received: by 2002:a17:907:d312:b0:a30:9c52:a3c3 with SMTP id
 vg18-20020a170907d31200b00a309c52a3c3mr78681ejc.107.1706026561385; Tue, 23
 Jan 2024 08:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <cover.1704877233.git.ps@pks.im> <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
In-Reply-To: <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 23 Jan 2024 17:15:48 +0100
Message-ID: <CAP8UFD0p-OqYuTrB5m2uq7BRFko887bKszOLtP5peP-A79g=BA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] t1300: make tests more robust with non-default ref backends
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> The t1300 test suite exercises the git-config(1) tool. To do so we
> overwrite ".git/config" to contain custom contents.

Here "we" means "tests in t1300" I guess.

> While this is easy
> enough to do, it may create problems when using a non-default repository
> format because we also overwrite the repository format version as well
> as any potential extensions.

But I am not sure that "we" in the above sentence is also "tests in
t1300". I think overwriting the repo format version and potential
extensions is done by other tests, right? Anyway it would be nice to
clarify this.

> With the upcoming "reftable" ref backend
> the result is that we may try to access refs via the "files" backend
> even though the repository has been initialized with the "reftable"
> backend.

Not sure here also what "we" is. When could refs be accessed via the
"files" backend even though the repo was initialized with the
"reftable" backend? Does this mean that some of the tests in t1300 try
to access refs via the "files" backend while we may want to run all
the tests using the reftable backend?

> Refactor tests which access the refdb to be more robust by using their
> own separate repositories, which allows us to be more careful and not
> discard required extensions.

Not sure what exactly is discarding extensions. Also robust is not
very clear. It would be better to give at least an example of how
things could fail.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1300-config.sh | 74 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 26 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index f4e2752134..53c3d65823 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1099,13 +1099,18 @@ test_expect_success SYMLINKS 'symlink to nonexist=
ent configuration' '
>  '
>
>  test_expect_success 'check split_cmdline return' "
> -       git config alias.split-cmdline-fix 'echo \"' &&
> -       test_must_fail git split-cmdline-fix &&
> -       echo foo > foo &&
> -       git add foo &&
> -       git commit -m 'initial commit' &&
> -       git config branch.main.mergeoptions 'echo \"' &&
> -       test_must_fail git merge main
> +       test_when_finished 'rm -rf repo' &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               git config alias.split-cmdline-fix 'echo \"' &&
> +               test_must_fail git split-cmdline-fix &&
> +               echo foo >foo &&
> +               git add foo &&
> +               git commit -m 'initial commit' &&
> +               git config branch.main.mergeoptions 'echo \"' &&
> +               test_must_fail git merge main
> +       )
>  "

Maybe, while at it, this test could be modernized to use single quotes
around the test code like:

test_expect_success 'check split_cmdline return' '
...
'

or is using double quotes still Ok?

>  test_expect_success 'git -c "key=3Dvalue" support' '
> @@ -1157,10 +1162,16 @@ test_expect_success 'git -c works with aliases of=
 builtins' '
>  '
>
>  test_expect_success 'aliases can be CamelCased' '
> -       test_config alias.CamelCased "rev-parse HEAD" &&
> -       git CamelCased >out &&
> -       git rev-parse HEAD >expect &&
> -       test_cmp expect out
> +       test_when_finished "rm -rf repo" &&
> +       git init repo &&
> +       (
> +               cd repo &&
> +               test_commit A &&
> +               git config alias.CamelCased "rev-parse HEAD" &&
> +               git CamelCased >out &&
> +               git rev-parse HEAD >expect &&
> +               test_cmp expect out
> +       )
>  '

Here single quotes are used for example.

>  test_expect_success 'git -c does not split values on equals' '
> @@ -2009,11 +2020,11 @@ test_expect_success '--show-origin getting a sing=
le key' '
>  '
>
>  test_expect_success 'set up custom config file' '
> -       CUSTOM_CONFIG_FILE=3D"custom.conf" &&
> -       cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
> +       cat >"custom.conf" <<-\EOF &&
>         [user]
>                 custom =3D true
>         EOF
> +       CUSTOM_CONFIG_FILE=3D"$(test-tool path-utils real_path custom.con=
f)"
>  '

This looks like a test modernization, but maybe it's part of making
the tests more robust. Anyway it might be a good idea to either talk a
bit about that in the commit message or to move it to a preparatory
commit if it's a modernization and other modernizations could be made
in that preparatory commit.

Otherwise this patch looks good to me.
