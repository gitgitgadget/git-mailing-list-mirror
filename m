Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221413959D
	for <git@vger.kernel.org>; Tue, 13 May 2025 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170595; cv=none; b=rDvekYrJOdx4Ihjuysk2w7B3DmgW48Bk1FMLhtmgayD9FaCrCfoXCPWDY05iH+KVQ6o5p3uFkPgiZeHaVppdlCiyMtqzaBOYLfJo9jqrKgeDuoN68ANgpmOUwYveZuP9S4W0Vp9Xw3baJ+TGX+F7RBC3h00MZGeg+ThAwJe5HSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170595; c=relaxed/simple;
	bh=66bKVQDN1bUAjO/dMjr0QxGn0Cp+OvEtGdC/oAkUNXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3Ay/go7Vg/yAPSmx9k1805kfzoPUvDaqDM3iupd3kSxBm5YQMghQ1j4iSAtTEpIov/S1GUgiV150gck7kh5ck64Jn7XYRhN3Oa2SOMNyqbnw48f15f02azq8n9RdAgfjncxQAhhgKDNTDAaHai1LxamnsFTOaWNk8iX61susFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqzuUHyC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqzuUHyC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5feb22e7d84so3445843a12.3
        for <git@vger.kernel.org>; Tue, 13 May 2025 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747170591; x=1747775391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEZjgVw1dMXORIV3F8T+b3DlCYRmQykjHvwUqli+g1g=;
        b=IqzuUHyCgKO5mRp7IowMKz9Kh2lYpIoVvQBhxvfXj0rm9kl49EkoKUi6LRanxBU/JS
         Op2Tm5a+VWFvGQ3LaOhR2rKzv8S5tB/U2zDCMcGr1NAbZBXhQ088fS8PSAmSPOmgOQhw
         JXwGUaVrz8bzURad0UUM3wJG/dMjEiJ8C/dnHt4nh6Sk3DHrhtDAqrl4HZ8CE4twIU2k
         X32jPg3UeTJVYed0Mlt0v2wthBUF/zVJzXk072iP7yUzW2R76MKA+lSp8FydqzI67SkF
         JoHexUvqgPheNfYstKNXwHz5ERKyWaZO8BaU/gTVului+P9J+uYoF7XmNTbPwnwk2CKI
         OZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747170591; x=1747775391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEZjgVw1dMXORIV3F8T+b3DlCYRmQykjHvwUqli+g1g=;
        b=SmvZXU3hMn4FVXFssRKK2cAg9sc8FFRFPe8eeqNmKBI+kca3EKoX6cPfJrut0FLfo+
         q8bihUTzL3C/YwJktrsA9LGkljSWtCMgQYN9TFJ8NFEqvviMiMvlxBrhPx7zMKsuNnjI
         8vZ0CAEEyhK3SjNzZrB81z4u/hBukTDy5tts7035ugEFbUG1OwRao/UUSYU05e93MIeh
         UJ+vwcQyRm1K8rQQDvTISWOH7b1rgLeb/3ODYsTnI53Uu6pBxNxPzKB6Apc+FBQueRhx
         VFJuzc2+QfAa0eALu2lY7ijMA84Gj8claAFuoJ0tkC70WcRY4G2H8ymDWxSC+ZLqXN3C
         1f0g==
X-Gm-Message-State: AOJu0YwQWUdcXVSveAn9BIqCwNQFbAyPP/UlVo3B22fq2qhJaf5KICt7
	bITIkLNBh2SFFm+Ngr9r0P3vFBXe1bmF17y4qIM+IK84jfL9MQH6HN+octRIYa1curAynBs4oLG
	fC/ztd7opXRG2rXGmgGGCDXWT4QY=
X-Gm-Gg: ASbGncs1ONor9LfKIQnWh09JJDESg9UuncwkWlswLOWhDOG2Wi3sAWfb/04WB6y+utk
	j8T9e96/CH+t4Hs841LfAYxgXk7s/EW9Sjn/qsSEffSZc19c/e/JCJGgePXTNAOsfe+2TKLd87K
	J9d4aRh4gJ7N5Q32CZmLKJGI7a/qIBKDvbbQZSA4mJVG0F/Cjny3gsW7QNfZxZajlC2YU=
X-Google-Smtp-Source: AGHT+IE8u1WsemCVzhaB0p1sWohGjZpXSjJPW8QKS1sMWmWf18tNF5O0vnKWHMNU47WLyW+TbkcIA/LI8qHef9TMDNs=
X-Received: by 2002:a05:6402:40c5:b0:5fa:abfb:35a7 with SMTP id
 4fb4d7f45d1cf-5ff988a61e1mr564065a12.13.1747170590983; Tue, 13 May 2025
 14:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCM5JY25NVPgyYRP@chrisdown.name>
In-Reply-To: <aCM5JY25NVPgyYRP@chrisdown.name>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 13 May 2025 17:09:40 -0400
X-Gm-Features: AX0GCFsCJgRpHjUQf9jpioJkjU8gwzIDzNmZWfdNW8Uwa7upLTBM2z7j5xEs518
Message-ID: <CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
To: Chris Down <chris@chrisdown.name>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 8:21=E2=80=AFAM Chris Down <chris@chrisdown.name> w=
rote:
>
> Introduce a new `commit.signoff` config variable that mirrors the
> behavior of the -s/--signoff flag.
>
> We already have prior art in format-patch with `format.signoff`; this
> brings parity for those who don=E2=80=99t use a patch-based workflow but =
still
> rely on signoffs.
>
> Right now people who have to do this regularly often alias commit to
> `commit --signoff` in their shell, which is less than ideal -- this
> config option avoids having to do that.

It would probably be nice to say why this makes sense in light of
previously-raised objections, too [1].

[1]: https://lore.kernel.org/git/xmqqo6x4p6z2.fsf@gitster.g/

>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  Documentation/signoff-option.adoc         |  4 ++++
>  builtin/commit.c                          |  4 ++++
>  t/t7500-commit-template-squash-signoff.sh | 10 ++++++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/Documentation/signoff-option.adoc b/Documentation/signoff-op=
tion.adoc
> index cddfb225d1..0055874e84 100644
> --- a/Documentation/signoff-option.adoc
> +++ b/Documentation/signoff-option.adoc
> @@ -13,6 +13,10 @@ endif::git-commit[]
>         Linux kernel and Git projects.)  Consult the documentation or
>         leadership of the project to which you're contributing to
>         understand how the signoffs are used in that project.
> +ifdef::git-commit[]
> +       The `commit.signoff` configuration variable may also be used to i=
mply
> +       `--signoff`.
> +endif::git-commit[]
>  +
>  The `--no-signoff` option can be used to countermand an earlier `--signo=
ff`
>  option on the command line.
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 66bd91fd52..da98895438 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1670,6 +1670,10 @@ static int git_commit_config(const char *k, const =
char *v,
>                                                                &is_bool);
>                 return 0;
>         }
> +       if (!strcmp(k, "commit.signoff")) {
> +               signoff =3D git_config_bool(k, v);
> +               return 0;
> +       }
>
>         return git_status_config(k, v, ctx, s);
>  }
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-t=
emplate-squash-signoff.sh
> index 4dca8d97a7..03c20dcb1d 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -181,6 +181,16 @@ test_expect_success '--signoff' '
>         test_cmp expect output
>  '
>
> +test_expect_success 'config commit.signoff implies signoff' '
> +       git config commit.signoff true &&

This should use test_config, I think. Otherwise, the config will stick
around if the test fails. You /could/ use test_when_finished, but
test_config sets that up for you.

> +       echo "871119" >> bar &&
> +       git add bar &&
> +       echo "zort" | git commit -F - bar &&
> +       git cat-file commit HEAD | sed "1,/^\$/d" > output &&
> +       test_cmp expect output &&

Took me a bit to realize (since it doesn't show in the context);
"expect" is setup outside the previous signoff test and then (re)used
here. Reasonable, but we now have commit_msg_is in this test script.
Perhaps worth a quick refactor patch preceding this one to make it use
that function? Probably not required, though?

> +       git config --unset commit.signoff
> +'
> +
>  test_expect_success 'commit message from file (1)' '
>         mkdir subdir &&
>         echo "Log in top directory" >log &&
> --
> 2.49.0
>
>


--=20
D. Ben Knoble
