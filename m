Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09359C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE7160E94
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbhIHKmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhIHKmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:42:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F84C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 03:41:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mf2so3196985ejb.9
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0NtfGxPPiX1A9xd8mDZqvJXByaH3WOJGtuV8Iif/a7Y=;
        b=N8Tb+nAqHSqO5nCDpQ5FFBzMBnbIUkGL7yioNGvBTW6wyXMeRPWZWYz4+62eHwgv0T
         Nd7lz8njn+g/kX/H/SWeqpd9vqR4Oh5eeyaxOold+8bVii3J+gCINf86dUrWPqDAsxlD
         3wpQW4+Zp1MRb396V0F+4mIZjvAd3n4XEv4XN5Kb43RxsMvv+YCPk4CMSlm7dAenmNA6
         uzqrQvcT15Fvu1ONjEy/NN+Ee4M4nc34KCaannm3me/VYRKovou0Y+a3hf0Tooi3DlZj
         7CoNvUOVvoXdXmAQhD9Ai6Jg/x9xUGSswQVqpC7yadsMmULh8SgiZXeDn+oQsOsPutXj
         88gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0NtfGxPPiX1A9xd8mDZqvJXByaH3WOJGtuV8Iif/a7Y=;
        b=pyWqsibDM7ja0V4UFoFZHHmMBnCbCW9v8/iLVebKt2MviLGhfFP/m9ZWKApj3vACB0
         D6E+vtDvFWR8IftQwnSXKBehUypUNalqg2U3TrB2EH4L4Mk1WAmDHr9FFTFo4CwEmA2T
         C8L6ajO+Er1465zOwdClxEO0HT2iYxrORZOURz8FQfEngfQ8FCaDY1UDJrXXOV6rveSF
         mQO6ErSGv0d3Ix0RLEcbIvyE8zxMrXvu23IlSLE1wARf7lpgljLk6MkshDQq3qA+BUUR
         7l0O6L3zrnRYTr+WFv6zAum96wWtYEkSFuu+UU5ZMMUADcT8xj5h6WlUfR3T/CgyCrTB
         nlBg==
X-Gm-Message-State: AOAM532nQt7XEkeuFJuYHFsFKYIBAMCVGTYasLut9ICUOOBF+kuRYlbF
        E3hbHH4//ANYCu/ozL0zzlU=
X-Google-Smtp-Source: ABdhPJx+SxH3ghc/zPpcraoRdFox6iGbCklYGzqD5U/BBNhC1ShyuX6idHnwjQuErImkSfLKpyjHQw==
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr3314521eje.518.1631097663670;
        Wed, 08 Sep 2021 03:41:03 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n3sm957841eds.79.2021.09.08.03.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:41:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 03/11] t3407: use test_cmp_rev
Date:   Wed, 08 Sep 2021 12:40:00 +0200
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <dfa27d7a8e7e0a9e03e228653ebff639a449ac77.1631094563.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <dfa27d7a8e7e0a9e03e228653ebff639a449ac77.1631094563.git.gitgitgadget@gmail.com>
Message-ID: <87ilzbic3l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Phillip Wood via GitGitGadget wrote:

> @@ -54,9 +54,9 @@ testrebase() {
>  		echo d >> a &&
>  		git add a &&
>  		test_must_fail git rebase --continue &&
> -		test $(git rev-parse HEAD) != $(git rev-parse main) &&
> +		! test_cmp_rev HEAD main &&

Use "test_cmp_rev !", making the shell do the negation is troublesome
for the same reason we don't do it with git command, it potentially
hides segfaults (and that test helper invokes "git", hence the optional
"!" first rgument).
