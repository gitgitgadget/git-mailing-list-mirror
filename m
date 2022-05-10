Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A5C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 18:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348757AbiEJSYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 14:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242474AbiEJSYw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 14:24:52 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A26633E18
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:20:52 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id i186so17712888vsc.9
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8cVwtEhCdihJeODXNysfkPHSbqTpFngQdiAj+F/Ybc=;
        b=fQMYgg3WtfHL/Kjo8j3L3ctoUaacElSTRgd89QTB01gpBHYLmCAsuSrJ/E6OejVtyU
         2gCiicy7W7abH/FAKgipxkEPdp3m+0VrZvLQB34gXuU/eMsnMl28iF/u20CLvumzpNeH
         FMSTUquYAmDMP/J68zBRbURkLfdVqOiPPVMyTaX59kQb663ZH2s7zLoiIMeltjheA4MO
         rCkh8l1jh/Pq1nWTepaP9Uqyw0T2nOSu3EfnTpLDDVGVLDoSJSWMhCJXFn4/MXCwfqQr
         cTaBoKonha1fN9fhblYoiC0SxNvoEZk5xatXWs9vsRPPXbQNGA0EPTcn5Au1DJKE9B78
         wi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8cVwtEhCdihJeODXNysfkPHSbqTpFngQdiAj+F/Ybc=;
        b=NXz+Ps6c3cjh+K6SQB51yDFHFHbnQ516sZo8nZ2/0TZFkWqiSi11e5Y2jkKyGy/hqv
         46MHMV7kCNceDiICUFoxbCQQJ1mZ0JzKlcZLZloUT3w1pfPVKHHx2fFpjqiCCckoEPiH
         Au3sKyckLscgVEg/qXjH00uWFNOYYp6tLjMyrW1ET6E4xa8PDZ1ywKevHq+Aiq7PsXL7
         Y7W6oo9vfP2HSwKLBNVeNxF3mhQB6q9hAM6SmwCfg3FfFiYieIsdnGDOnTozO+oIi+Iz
         lgEIZtKKkIZw00jL9wnLXg/akGLz2eKsIY+lxKunUznRBnxxjxVhLshV1569i7segSe4
         wvyg==
X-Gm-Message-State: AOAM5322urMp3sZH0cVROBBLZ9CANV7m/kpy+f79CNggmB1eWr1ehVTg
        UEGdtMEVavzzvu9QrvRUzKWua83AqaXbk6Yyz6Q=
X-Google-Smtp-Source: ABdhPJzbxNXdWYTbSfsLrFifC51VG6CTOpcsV94Ywd+i+df+tvCRfMSzssejFMIynrkGJ1asHTZNiOk2DPNaEXVOL6w=
X-Received: by 2002:a67:c905:0:b0:32c:69bd:18a3 with SMTP id
 w5-20020a67c905000000b0032c69bd18a3mr12794131vsk.5.1652206851994; Tue, 10 May
 2022 11:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220504104601.136403-1-chriscool@tuxfamily.org> <20220509153834.485871-1-chriscool@tuxfamily.org>
In-Reply-To: <20220509153834.485871-1-chriscool@tuxfamily.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 10 May 2022 11:20:41 -0700
Message-ID: <CAPUEsphA=q10wCsrf3AxR9fXz9HQHt374tDFoWBu++EPNDA-LA@mail.gmail.com>
Subject: Re: [PATCH v3] http: add custom hostname to IP address resolutions
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2022 at 8:38 AM Christian Couder
<christian.couder@gmail.com> wrote:
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index f92c79c132..4a8dbb7eee 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -567,4 +567,11 @@ test_expect_success 'client falls back from v2 to v0 to match server' '
>         grep symref=HEAD:refs/heads/ trace
>  '
>
> +test_expect_success 'passing hostname resolution information works' '
> +       BOGUS_HOST=gitbogusexamplehost.com &&
> +       BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
> +       test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
> +       git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
> +'

Is setting it up as a command line config option the way you expect to
use this, and if so why not make it a full blown command line option
with the previous caveats that were discussed before?

I also think it might be a little confusing (and probably warranted of
an advice message) if git will decide based on a configuration
somewhere in its resolution tree that the IP I am connecting is
different than the one I expect it to use through the system
configured resolution mechanism for such a thing.

I assume that if you want to use this frequently, having that advice
disabled in your global config wouldn't be a hassle, but it might be
useful to know that I am interacting with a potentially different IP
when referring to some host by name in my local repo, maybe because I
forgot to change that setting after some debugging.

I am sure all those folks that forget to edit their /etc/hosts after
they are done with their local site versions might instead use this
and then be happy to be warned about it later.

Carlo
