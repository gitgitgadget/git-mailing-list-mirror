Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4198EC47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CF1613BA
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhEZSxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhEZSxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 14:53:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE9C061756
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:51:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id z12so4126496ejw.0
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=S9hiH7nGMp9Ky9jsvOhRr6mKzIZu5u2svehHAKtoclg=;
        b=LoTjVkyjp2EsgHI1ucYoDofXR7wPHVRzewaAZNmtEieLKKYYxtM/fPLuNwmLjAXGGc
         9jHEfjV3pOsyZQzTXnwjgX2n5ssIfPeb3lr8r5KMUAMfo32gXyDwH31Lc2aAfnvMW+ck
         sz8DZuI38ZbcqMSav0qsxi+S8Pbi6NXSr637/07w/AmVrDAozopFB//k10oMBBv5DRcz
         UyANyZs+UuqNkshN3CWmY/8KKKLp+iPjZTXdl+fJ5Xh3NZWwHyFtEF3sSBKzeC7g9Ori
         Mu1rXiwUTqvapSJB5r6IJBH1o4Cnx+ljY98o09f7mIaTrwsY9xhXMIGgVsNwAd8efVwy
         +Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=S9hiH7nGMp9Ky9jsvOhRr6mKzIZu5u2svehHAKtoclg=;
        b=Txve2oxgA5Ft+KCMpd2p++p1HoWCUeHumiZt+euxLyWicv1tt7hEnIPD00TEi4gvth
         j2MyLS3PCvXugwlvYhaEdal7X7zNZbGcTUhpXlw3HAFPdRm/TGy99Ru090UWcmbp+ilT
         rSRSCcVFA+hrHtM/mubhAQJtfQfiXUkMhABRMbeVVhGwacZXqnMG1+NVbNf9fYomEeD8
         bVShGjVht+fItaFTlWKvyjGAnkENkJ53AZJ93pMs5x+CzipGaLFnKNa0K9t2bHlqlmRz
         0oKF6lOLkvTHcPPuiLPcMLpzyFB87BtbIdc0zNgbivUM0KbldSk/f28WmitNCbY9U3sP
         CvZg==
X-Gm-Message-State: AOAM533meK3NQRtlxDp5/SNYou8OpjrALPoQS4K0CgNkSNMSdhBp6En0
        19tTOCs/ZFpHdxxZUv1R2MI=
X-Google-Smtp-Source: ABdhPJx0rqRwAuWMS6YNc4jBjrrYgevDQCnJdGfWHX1FMhWDOtixzSbaSR1tHZOrqaElRMO19+UFOQ==
X-Received: by 2002:a17:906:3016:: with SMTP id 22mr34578216ejz.28.1622055108920;
        Wed, 26 May 2021 11:51:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q18sm12729006edd.3.2021.05.26.11.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 11:51:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Runaway sed memory use in test on older sed+glibc (was "Re: [PATCH
 v6 1/3] test: add helper functions for git-bundle")
Date:   Wed, 26 May 2021 20:49:24 +0200
References: <xmqq1rer8cbz.fsf@gitster.c.googlers.com>
 <20210112022703.1884-2-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210112022703.1884-2-worldhello.net@gmail.com>
Message-ID: <87bl8xmipo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 11 2021, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Move git-bundle related functions from t5510 to a library, and this lib
> will be shared with a new testcase t6020 which finds a known breakage of
> "git-bundle".
> [...]
> +
> +# Format the output of git commands to make a user-friendly and stable
> +# text.  We can easily prepare the expect text without having to worry
> +# about future changes of the commit ID and spaces of the output.
> +make_user_friendly_and_stable_output () {
> +	sed \
> +		-e "s/${A%${A#???????}}[0-9a-f]*/<COMMIT-A>/g" \
> +		-e "s/${B%${B#???????}}[0-9a-f]*/<COMMIT-B>/g" \
> +		-e "s/${C%${C#???????}}[0-9a-f]*/<COMMIT-C>/g" \
> +		-e "s/${D%${D#???????}}[0-9a-f]*/<COMMIT-D>/g" \
> +		-e "s/${E%${E#???????}}[0-9a-f]*/<COMMIT-E>/g" \
> +		-e "s/${F%${F#???????}}[0-9a-f]*/<COMMIT-F>/g" \
> +		-e "s/${G%${G#???????}}[0-9a-f]*/<COMMIT-G>/g" \
> +		-e "s/${H%${H#???????}}[0-9a-f]*/<COMMIT-H>/g" \
> +		-e "s/${I%${I#???????}}[0-9a-f]*/<COMMIT-I>/g" \
> +		-e "s/${J%${J#???????}}[0-9a-f]*/<COMMIT-J>/g" \
> +		-e "s/${K%${K#???????}}[0-9a-f]*/<COMMIT-K>/g" \
> +		-e "s/${L%${L#???????}}[0-9a-f]*/<COMMIT-L>/g" \
> +		-e "s/${M%${M#???????}}[0-9a-f]*/<COMMIT-M>/g" \
> +		-e "s/${N%${N#???????}}[0-9a-f]*/<COMMIT-N>/g" \
> +		-e "s/${O%${O#???????}}[0-9a-f]*/<COMMIT-O>/g" \
> +		-e "s/${P%${P#???????}}[0-9a-f]*/<COMMIT-P>/g" \
> +		-e "s/${TAG1%${TAG1#???????}}[0-9a-f]*/<TAG-1>/g" \
> +		-e "s/${TAG2%${TAG2#???????}}[0-9a-f]*/<TAG-2>/g" \
> +		-e "s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g" \
> +		-e "s/ *\$//"
> +}

On one of the gcc farm boxes, a i386 box (gcc45) this fails because sed
gets killed after >500MB of memory use (I was just eyeballing it in
htop) on the "reate bundle from special rev: main^!" test. This with GNU
sed 4.2.2.

I suspect this regex pattern creates some runaway behavior in sed that's
since been fixed (or maybe it's the glibc regex engine?). The glibc is
2.19-18+deb8u10:
    
    + git bundle list-heads special-rev.bdl
    + make_user_friendly_and_stable_output
    + sed -e s/[0-9a-f]*/<COMMIT-A>/g -e s/[0-9a-f]*/<COMMIT-B>/g -e s/[0-9a-f]*/<COMMIT-C>/g -e s/[0-9a-f]*/<COMMIT-D>/g -e s/[0-9a-f]*/<COMMIT-E>/g -e s/[0-9a-f]*/<COMMIT-F>/g -e s/[0-9a-f]*/<COMMIT-G>/g -e s/[0-9a-f]*/<COMMIT-H>/g -e s/[0-9a-f]*/<COMMIT-I>/g -e s/[0-9a-f]*/<COMMIT-J>/g -e s/[0-9a-f]*/<COMMIT-K>/g -e s/[0-9a-f]*/<COMMIT-L>/g -e s/[0-9a-f]*/<COMMIT-M>/g -e s/[0-9a-f]*/<COMMIT-N>/g -e s/[0-9a-f]*/<COMMIT-O>/g -e s/[0-9a-f]*/<COMMIT-P>/g -e s/[0-9a-f]*/<TAG-1>/g -e s/[0-9a-f]*/<TAG-2>/g -e s/[0-9a-f]*/<TAG-3>/g -e s/ *$//
    sed: couldn't re-allocate memory
