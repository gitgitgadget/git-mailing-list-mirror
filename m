Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF3EC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhLTTQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhLTTQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:16:16 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479BC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:16:16 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y13so42442188edd.13
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=de2E38eS+HWdmtkMjXFEmr8Zujx2EovrvEroFxiYUYI=;
        b=mGBDpSEmlGq5koKH0mpvFFpfcBXtDlgquyy4U6+p8f1XuMytjbYJyKL+Xo9NfCOmKy
         siAkuT4ZG62CJupJ+221+U8/Iv+Frg4npYVbLK88stjtMHXCCYqqvQIlkygTZUAYPFJN
         ZqqKy3sx9lUf9OaoGtkAyM4k+zUgk4i2WDVJ8GWHlGI9/yeJQ0dZjpAJupH99QcrNNcY
         7AmfYGQsghvnKPymgspGrR2rKYGqTpowDZbso44Mmm3779dC/vaiVIFXj6ftI+maiyhn
         N70UJs67WAw7NGCZvgjrptXhzKb/1xvL9BzZOlHw1RuIIKq763XTh0fpvNjdSJm9/qOJ
         bNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=de2E38eS+HWdmtkMjXFEmr8Zujx2EovrvEroFxiYUYI=;
        b=meVutX3l7NnAoC3USG3t79eUYq8aih1strFVQEhzgadks/vcyIu8tDFxzpwXWSC1pd
         PVT0VgY8D9PQhxYNh22bC1J5UCAnW1Y0YPWieNc89HdzpiPAc0LT2oi6wUnT0+ZLOMfZ
         3L8LkNydUuwXALF/PWXeqk1s6XNn1lEDNF549QRDKp6DOKgIRyA4tDQfVqi/YmR+8BSs
         loGf+NycAn0FM1ewJt76o89qgu1CArhF71QxgA7sLd3nWappytwLoKrFw3omuaWYxfi6
         SpnmEeNKuqartb6ZZjUVHpajjaBY+yHl1r5ufrOebGuNfQd/LZEWyrOaOul9aDNVvtxP
         FDsQ==
X-Gm-Message-State: AOAM530MH5sITS9mJOFlQN9cwZ6+T9jo/XLCtQzmx09Gp6GnhJ8F5MJT
        uM6qBYZlEnjIafp6/VLrhgkQO6ZyQjBMIA==
X-Google-Smtp-Source: ABdhPJyJmymJPB2OV185DLJBW5RXF0LiVgjc9D1vD2UoWGWx1cWvAaELSvo9zMb375R5epV4cZ4cLg==
X-Received: by 2002:a17:906:7e07:: with SMTP id e7mr8890715ejr.461.1640027774375;
        Mon, 20 Dec 2021 11:16:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k12sm1165584ejx.119.2021.12.20.11.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 11:16:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzO8r-000XTl-C2;
        Mon, 20 Dec 2021 20:16:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] builtin add -p: fix hunk splitting
Date:   Mon, 20 Dec 2021 20:06:00 +0100
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
 <5d5639c2b0474680850b7adbb7c5ec81d124eb50.1640010777.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <5d5639c2b0474680850b7adbb7c5ec81d124eb50.1640010777.git.gitgitgadget@gmail.com>
Message-ID: <211220.86mtkvt7cy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> To determine whether a hunk can be split a counter is incremented each
> time a context line follows an insertion or deletion. If at the end of
> the hunk the value of this counter is greater than one then the hunk
> can be split into that number of smaller hunks. If the last hunk in a
> file ends with an insertion or deletion then there is no following
> context line and the counter will not be incremented. This case is
> already handled at the end of the loop where counter is incremented if
> the last hunk ended with an insertion or deletion. Unfortunately there
> is no similar check between files (likely because the perl version
> only ever parses one diff at a time). Fix this by checking if the last
> hunk ended with an insertion or deletion when we see the diff header
> of a new file and extend the existing regression test.
>
> Reproted-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  add-patch.c                |  7 ++++++
>  t/t3701-add-interactive.sh | 46 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 8c41cdfe39b..5cea70666e9 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -472,6 +472,13 @@ static int parse_diff(struct add_p_state *s, const s=
truct pathspec *ps)
>  			eol =3D pend;
>=20=20
>  		if (starts_with(p, "diff ")) {
> +			if (marker =3D=3D '-' || marker =3D=3D '+')
> +				/*
> +				 * Last hunk ended in non-context line (i.e. it
> +				 * appended lines to the file, so there are no
> +				 * trailing context lines).
> +				 */
> +				hunk->splittable_into++;

I wondered if factoring out these several "marker =3D=3D '-' || marker =3D=
=3D
'+'" cases in parse_diff() into a "is_plus_minus(marker)" was worth it,
but probably not.

>  			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
>  				   file_diff_alloc);
>  			file_diff =3D s->file_diff + s->file_diff_nr - 1;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 77de0029ba5..94537a6b40a 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -326,7 +326,9 @@ test_expect_success 'correct message when there is no=
thing to do' '
>  test_expect_success 'setup again' '
>  	git reset --hard &&
>  	test_chmod +x file &&
> -	echo content >>file
> +	echo content >>file &&
> +	test_write_lines A B C D>file2 &&

style nit: "cmd args >file2" not "cmd args>file2"

> @@ -373,8 +411,8 @@ test_expect_success 'setup expected' '
>  test_expect_success 'add first line works' '
>  	git commit -am "clear local changes" &&
>  	git apply patch &&
> -	test_write_lines s y y | git add -p file 2>error >raw-output &&
> -	sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
> +	test_write_lines s y y s y n y | git add -p 2>error >raw-output &&
> +	sed -n -e "s/^([1-9]\/[1-9]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
>  	       -e "/^[-+@ \\\\]"/p raw-output >output &&
>  	test_must_be_empty error &&
>  	git diff --cached >diff &&

style/diff nit: maybe worth it to in 1/2 do some version of:

    test_write_lines ... >lines &&
    git ... <lines .. &&
    ...
    sed -n \
    	-e ... \
        -e ... \
        >output

Just to make the diff smaller, i.e. just the "test_write_lines" line
would be modified here.

The changes themselves & this series LGTM.
