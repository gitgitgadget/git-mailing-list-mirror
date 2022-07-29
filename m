Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0616BC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiG2V60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiG2V6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:58:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B008722B
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:58:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f3959ba41so50817627b3.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=Psh7GciD8DR+DV0/MDbQOouwqfzEyUtv6CKfZs+JgYk=;
        b=Y0ckZOIT1yFL+QRk3knB4uIQhJ1PyORLoX0qobAT9yuTH1X1/ftFtEsZt2ydwx+X3b
         HHdQMIa3sCYCYb8tzecLx61xZdakDMa3/Fmq0GxtpVxw8n+2DNxHNT487rwNPa16dpdq
         RROZ/aMsmzKjQU+jIDpJfagmhsgsS6u0HbFfr4oFTaex77LxjSH0VdQDYjZ9JH1OhGBG
         Vt+eZQwlnnzJ7HuS+9HScxSTc8eckXJOYl8Nx2EXZtiX4PGLWN58XFRiLy1rVJsijRGk
         Vx/bL+Pvt/xJ79ylC2Ww6uYSZWQjeDk7rp1vd753lrzgi727kPbbWDEjDl6NGG+Ufz0O
         PaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=Psh7GciD8DR+DV0/MDbQOouwqfzEyUtv6CKfZs+JgYk=;
        b=FnVCMBJEDd2gP6mNOU/kDBN30TOMIrnHHzzK0f3VCB/ebrF7vtiXuI6IF1MlM5yG14
         PrAFvRgr6X1zK7o2FMFbcRhDMDpuufifZGueQdrbe1tKWDunWdeYM4AV12JjYCOc0oMP
         dv8tpju4cqe/RcG07+KMgNlR1QiOyfygWbOgtLztv3BnmZPKB3xNE3JZPtkcKTgn09LG
         a7Bl3OhDVsIujZvn4c4N3ukN5qb0vm6LfOg7O4PCVjV3ZnhShK+rorzAqrUbb9jZch/4
         ZeXYSEtL68ol4EE38Rrxg0AhxsYyY0wHxCGnWcsQVHZECCh5mgH9+GiCVEzcWUnI8PUR
         VJTw==
X-Gm-Message-State: ACgBeo1PeK8EPj2HN96TqxjCzfOoUvOSpKWAB9abzD1oNpzJaisaPIqR
        6M4fxjuZZU6mrp2IVaBvx4CuxbxpUDy0xQ==
X-Google-Smtp-Source: AA6agR4JBpv84rQiGmnDrlRcfeG6cWhdkmcwOpEiCCZG/O4uXE6dR17655Br/UNji0feBUTvZ2tv4y+Z1JLI7w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:744a:0:b0:671:7cc9:83b1 with SMTP id
 p71-20020a25744a000000b006717cc983b1mr4019840ybc.18.1659131902270; Fri, 29
 Jul 2022 14:58:22 -0700 (PDT)
Date:   Fri, 29 Jul 2022 14:58:20 -0700
In-Reply-To: <patch-08.20-8188657cdfa-20220728T161116Z-avarab@gmail.com>
Message-Id: <kl6lpmhnr37n.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <patch-08.20-8188657cdfa-20220728T161116Z-avarab@gmail.com>
Subject: Re: [PATCH 08/20] submodule--helper: move "resolve-relative-url-test"
 to a test-tool
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> As its name suggests the "resolve-relative-url-test" has never been
> used outside of the test suite, see 63e95beb085 (submodule: port
> resolve_relative_url from shell to C, 2016-04-15) for its original
> addition.

[...]

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 1f2007e62b7..68e29c904a6 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -22,7 +22,7 @@ relative_path() {
> =20
>  test_submodule_relative_url() {
>  	test_expect_success "test_submodule_relative_url: $1 $2 $3 =3D> $4" "
> -		actual=3D\$(git submodule--helper resolve-relative-url-test '$1' '$2' =
'$3') &&
> +		actual=3D\$(test-tool submodule resolve-relative-url '$1' '$2' '$3') &=
&
>  		test \"\$actual\" =3D '$4'
>  	"
>  }

It seems like this was only ever intended as a regression test when
porting resolve_relative_url from sh -> C. Unless we see a good reason
to "unit test" resolve_relative_url, I'm ok to drop this test too.

> --=20
> 2.37.1.1167.g38fda70d8c4
