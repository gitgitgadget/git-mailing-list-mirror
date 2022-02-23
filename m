Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F31BC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 09:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiBWJBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 04:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiBWJBD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 04:01:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0D7CDF5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 01:00:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g20so1187822edw.6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 01:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5Z2WohTsl44jkEatVB58rkSZTLM2XcL1Vh0RC537ekY=;
        b=T2rdRxTfPWjligAYC7k++vl9MlkoWqKii4tnL67c3/2bUstvFUJa3hykc7s5f8IhtM
         CsyJpTOdgDDF6bkHHMTuzkeMW2uyboTS6/CFf1/gvE5EX6acSRcmsxHkeHhUpFO8Wnhl
         sTEnorxTJQjRpfsQIYX7ptwkIXcWAof0Uwg2n+nOyX+iILUi1apCIlwlXKqkuxd9H8o2
         nwJ2+jIE6krYCnoRcEAxIlUjSGv4nOQvL34V5cNLaI22MS8jA8DUXbEH5TFhyUgeLb0z
         lGTgGwVTQxB6sFOpFeqctamIRnP3Dzr5dnbWYzufUAOBHKenVXK2a0rYhfD53rXVaxWx
         euIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5Z2WohTsl44jkEatVB58rkSZTLM2XcL1Vh0RC537ekY=;
        b=DD0aFZZlkjpeIPBKOgs6z2gmCUeIevisLgacI6K/D5O19h55+2aa6k7KsmS2rM8RSL
         OTnZmUZ2yOugUle1iw2IA/BO5kAfUx84c6IfS5rWjuD1UOtx1wgDJ/nJgg88u2Frrfog
         Jl1vCK6ESIaqfobwoYAXqfwKGo8iLovZcd6IANvgwO0yOTgFjQBYJTwgR6XDJyvfoTLP
         PSqDtil6cTdiLVcICpvRA5wiGKeYDIla7Br9YujsJHq4IALiOlogGMyoGHSz3A+AoUhF
         +svXCY7hZp+WeUY2Mej1STne4PKq7ISkGd9ILngr89vhjtj2NAeotjn/9B2qqNZXLJGM
         6jXA==
X-Gm-Message-State: AOAM532MIGER46XETvjv6rSds5oGUSvrPl5XfOaN3FkvznQ++kY5G40E
        /7HzGf9nEHq3Wlt4VFL+b+QB+JDMSV0=
X-Google-Smtp-Source: ABdhPJyc7kvvFnu3HcfWkw1UtRSHLUZs3WCxRUqUXcR2xU5XVIAjou21unoXtRK+sAfBpr+e4j7DdQ==
X-Received: by 2002:a05:6402:170e:b0:40b:657:ac3f with SMTP id y14-20020a056402170e00b0040b0657ac3fmr29985462edu.354.1645606833590;
        Wed, 23 Feb 2022 01:00:33 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g7sm7942141edt.69.2022.02.23.01.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:00:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMnVg-006D1W-F8;
        Wed, 23 Feb 2022 10:00:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite
 --updatref behavior
Date:   Wed, 23 Feb 2022 09:54:47 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
Message-ID: <220223.864k4q6jpr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> There is missing test coverage to ensure that the resulting reflogs
> after a git stash drop has had its old oid rewritten if applicable, and
> if the refs/stash has been updated if applicable.

This test looks good, and if 3/3 is applied and either of the flags
you're passing is omitted they'll fail, so we know we have the missing
coverage here.

> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t3903-stash.sh | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index b149e2af441..ec9cc5646d6 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -185,10 +185,33 @@ test_expect_success 'drop middle stash by index' '
>  	test 1 =3D $(git show HEAD:file)
>  '
>=20=20
> +test_expect_success 'drop stash reflog updates refs/stash' '
> +	git reset --hard &&
> +	git rev-parse refs/stash >expect &&
> +	echo 9 >file &&
> +	git stash &&
> +	git stash drop stash@{0} &&
> +	git rev-parse refs/stash >actual &&
> +	test_cmp expect actual
> +'

This one will be portable to the reftable backend.

> +test_expect_success 'drop stash reflog updates refs/stash with rewrite' '

But as I noted in <220222.86fsob88h7.gmgdl@evledraar.gmail.com> (but it
was easy to miss) this test will need to depend on REFFILES. So just
changing this line to:

    test_expect_success REFFILES 'drop stash[...]'

> +	git reset --hard &&
> +	echo 9 >file &&
> +	git stash &&
> +	oid=3D"$(git rev-parse stash@{0})" &&
> +	git stash drop stash@{1} &&
> +	cut -d" " -f1-2 .git/logs/refs/stash >actual &&
> +	cat >expect <<-EOF &&
> +	$(test_oid zero) $oid
> +	EOF
> +	test_cmp expect actual
> +'

Then:

>  test_expect_success 'stash pop' '
>  	git reset --hard &&
>  	git stash pop &&
> -	test 3 =3D $(cat file) &&
> +	test 9 =3D $(cat file) &&
>  	test 1 =3D $(git show :file) &&
>  	test 1 =3D $(git show HEAD:file) &&
>  	test 0 =3D $(git stash list | wc -l)

This test was already a bit broken in needing the preceding tests, but
it will break now if REFFILES isn't true, which you can reproduce
e.g. with:

    ./t3903-stash.sh --run=3D1-16,18-50 -vixd

Perhaps the least sucky solution to that is:

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ec9cc5646d6..1d11c9bda20 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -205,13 +205,19 @@ test_expect_success 'drop stash reflog updates refs/s=
tash with rewrite' '
 	cat >expect <<-EOF &&
 	$(test_oid zero) $oid
 	EOF
-	test_cmp expect actual
+	test_cmp expect actual &&
+	>dropped-stash
 '
=20
 test_expect_success 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
-	test 9 =3D $(cat file) &&
+	if test -e dropped-stash
+	then
+		test 9 =3D $(cat file)
+	else
+		test 3 =3D $(cat file)
+	fi &&
 	test 1 =3D $(git show :file) &&
 	test 1 =3D $(git show HEAD:file) &&
 	test 0 =3D $(git stash list | wc -l)
