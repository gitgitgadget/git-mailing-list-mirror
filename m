Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D4C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 11:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447088AbiDVL0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 07:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447082AbiDVLZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 07:25:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947465622B
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:23:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so15727852ejd.9
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RXewLlznEfrv6A1i+gWu8Qbgfah11V4m/Z1B3h+B2iM=;
        b=OErlU5IIxMKy6qlGnjxCl374tHmNvSKXW8lqXzjuLfNyafEFOvAO8RdUUfS7vpU4QK
         tpjsj3awej/X93WejRBAG0Flx09+MDsZzIJZhfR6tZO9Wy6q0f3T0/1O83dBBrrB7H5P
         FgZsciV54PGAW71t4Ct0k8yDkPFXyEMTFbsob7i3AC+DbCgKGOiWHqa9BAFW6leJHnFs
         HnkdNvJw5CiMbQkn3oNFhDAKwJ7nVjAcywB4TRROYH5VDUcn1v667WtixLtsferSHS4D
         +qXfSrZ8IePaQbZ4qKk+Cveyf6i4ez2NZ/cQuykFa/ewgLVuH1OrSOTmaC+PYWh8OyR6
         oeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RXewLlznEfrv6A1i+gWu8Qbgfah11V4m/Z1B3h+B2iM=;
        b=s5ZRH4SAXlz5saKJRTqyQVO1rvD8IM1yRvcpM+akC8QvTofKFbTISRZHftMG38rHRh
         Ov+MDvwipokLZ+8/s8dKyrUW9MLJX/wanXUDRsskA9g/hCCvUoLwCeqNbixHEcbEY333
         6HDi9aBaAKOMx5jCGiY2dQsynrygXrpFuvDbd6u2iyS5duiBLhxiXqXVUHPCm66rCo0L
         kN3sxbs8wl+b1Z8fmsWdeGplMTgyqAL51iD/hS0jMur43Jq02qy5HD3XYEIPh4SmzDgm
         4QKD7AaAIs0o52FMi9Wdx3KAxarvjQGPvL0yiQ7dA9Ndow3J3pVmUT2B3/3vGa9Llffn
         AYjA==
X-Gm-Message-State: AOAM531b1+aZ6xorGxIKkK/HG1BiP4YbnP+omxa/YTPGvdowvG+6mIXA
        L27UnGgEcvE2bv8GZ7KhCpg=
X-Google-Smtp-Source: ABdhPJyDOummucm656dOFPtwdRKc4T1f/gSvIwsDYAWK4z/tj81egEtqYoPaB642SnFH0yNRkSXovg==
X-Received: by 2002:a17:907:8a23:b0:6f0:14b6:33d9 with SMTP id sc35-20020a1709078a2300b006f014b633d9mr3758554ejc.559.1650626583883;
        Fri, 22 Apr 2022 04:23:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090626c600b006e74ef7f092sm664094ejc.176.2022.04.22.04.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:23:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhrNO-008hc7-Q0;
        Fri, 22 Apr 2022 13:23:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: always confirm by default
Date:   Fri, 22 Apr 2022 13:16:46 +0200
References: <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
 <20220422083629.1404989-1-hi@alyssa.is>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220422083629.1404989-1-hi@alyssa.is>
Message-ID: <220422.86zgkd4b1l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 22 2022, Alyssa Ross wrote:

> [[ Whoops, sent to the list this time! ]]

It is somewhat ironic to have an accidental E-Mail send given the patch
subject :)

> =C3=86var, thanks for encouraging me to send a patch.  At your suggestion,
> I've trawled through the list archives looking for any previous
> discussion of this default, but I didn't find anything.

Glad to see a follow-up to this. Thanks.

>  Documentation/git-send-email.txt |  3 +--
>  git-send-email.perl              |  2 +-
>  t/t9001-send-email.sh            | 14 ++++----------
>  3 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-em=
ail.txt
> index 41cd8cb424..b791d83bb7 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -407,8 +407,7 @@ Administering
>  --
>  +
>  Default is the value of `sendemail.confirm` configuration value; if that
> -is unspecified, default to 'auto' unless any of the suppress options
> -have been specified, in which case default to 'compose'.
> +is unspecified, default to 'always'.
>=20=20
>  --dry-run::
>  	Do everything except actually send the emails.
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5861e99a6e..4aa7d83cdc 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -606,7 +606,7 @@ sub config_regexp {
>  # Set confirm's default value
>  my $confirm_unconfigured =3D !defined $confirm;
>  if ($confirm_unconfigured) {
> -	$confirm =3D scalar %suppress_cc ? 'compose' : 'auto';
> +	$confirm =3D 'always';
>  };


I squinted a bit at this and wonder now that we don't have that ternary
whether we can simplify this a bit.

Isn't this the same now as:

    my $confirm_unconfigured =3D !defined $confirm;
    $confirm ||=3D 'always'; # well, defined-or, but I don't think we care =
here.

But probably not worth obsessing over it... :) I.e. it seems fine as-is.

> -test_expect_success $PREREQ 'No confirm with --suppress-cc' '
> -	test_no_confirm --suppress-cc=3Dsob &&
> +test_expect_success $PREREQ 'No confirm with --confirm=3Dcompose --suppr=
ess-cc' '
> +	test_no_confirm --confirm=3Dcompose --suppress-cc=3Dsob &&
>  	check_no_confirm
>  '
>=20=20
> @@ -1032,16 +1032,10 @@ test_expect_success $PREREQ '--confirm=3Dcompose'=
 '
>  	test_confirm --confirm=3Dcompose --compose
>  '
>=20=20
> -test_expect_success $PREREQ 'confirm by default (due to cc)' '
> +test_expect_success $PREREQ 'confirm by default' '
>  	test_when_finished git config sendemail.confirm never &&
>  	git config --unset sendemail.confirm &&
> -	test_confirm
> -'
> -
> -test_expect_success $PREREQ 'confirm by default (due to --compose)' '
> -	test_when_finished git config sendemail.confirm never &&
> -	git config --unset sendemail.confirm &&
> -	test_confirm --suppress-cc=3Dall --compose
> +	test_confirm --suppress-cc=3Dall
>  '

It looks like we're losing some coverage here (I may be wrong). I.e. yes
we should update tests and descriptions, but for lines that test what we
did with a given command-line before let's turn those into tests that
positively assert what we do now.

I.e. we lost the "--suppress-cc=3Dsob" test (with no other option), and
also "--suppress-cc=3Dall --compose"?
