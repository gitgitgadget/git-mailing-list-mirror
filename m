Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01710C04AA5
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 22:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiHXWLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 18:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHXWLk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 18:11:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DDB7CB61
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:11:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id g8so12987321plq.11
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=cOhzATTo/1vQjhUWjZ+qolYqcUwfKQm8yhNRO+xyq7c=;
        b=gmMKVXkCpipFXUbJ67AecEjm7no6XkXDklvhLdu39c2lnVy7yMuzynvgM8/o4gQ6o6
         uC8fx8iknq7q4mSwUMy2sroulUfK6peyd736ig7K57Tsiax5UJiLc/2OQgnEa97Cf4wi
         U0pE/K87qcgPBzqdCOgABD0H1sY29fww4s2MJ5098Fvt4vphf9izdCgycILnR1jGFl3c
         qNhnBSKP6wtL3Hl11WB4ek2NcThJD83InGybeosBVttXZQJGip1W0/G7irxiW/ncYra7
         neczf/cQP5kh4pwAIaLRvfCqstO1CfUKbtw2SO8njinDohqL+7ZmzuGYmgMYJ/r55xuj
         0DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=cOhzATTo/1vQjhUWjZ+qolYqcUwfKQm8yhNRO+xyq7c=;
        b=RTsm8LcsfCwpVxfcHeAP752sduONm/S8UVhcncmQ2IjcPo7oUVmL6teTnKIVCIkCeM
         pSc9wEZWX9EHB9Jo4AsEY60LQ0/BO12VKEczJU2TzW68QBMbfCGttTFxE7tGI2cX/w8y
         JhOLZG0E4OUjbBB+Fz+s0HpOVpngYl+ajP9wUS6epd2xqaqxTQ4nOZ1QCQx2/sw0tUSr
         4pbuY9EbkQ7evop3wQ+PkewqY4yXxJyf8buYXlERRhSJ0YMB13wWR1owrEUG4J+jiA9r
         BTCX9rZufc7IF93l1RBLWEai7043BWNG5R9UKDS5Ktn4q3djw15Xov69EPoryUtCVwfA
         tXPg==
X-Gm-Message-State: ACgBeo2sR5KJCjF1yH+E+A6SXEpiqUu1qH+Sby6ggfXnB9AR0EG525m6
        mRuRTJLhw9DBi2Rc9iKXuG0=
X-Google-Smtp-Source: AA6agR4NZssutALj9WoRmeTBqG8I3geNCTbgvTaziHxjf8EV/GZ4Pj4EQNIVA6GlE/rcIg1qOnDBUw==
X-Received: by 2002:a17:90a:db95:b0:1fa:c02b:5e34 with SMTP id h21-20020a17090adb9500b001fac02b5e34mr1158052pjv.159.1661379097303;
        Wed, 24 Aug 2022 15:11:37 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r18-20020aa79ed2000000b0052d4cb47339sm13526906pfq.151.2022.08.24.15.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:11:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/4] built-in add -p: support diff-so-fancy better
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 15:11:36 -0700
In-Reply-To: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 24 Aug 2022 21:21:47
        +0000")
Message-ID: <xmqq35dl5m1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Philippe Blain reported in
> https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
> that there is a problem when running the built-in version of git add -p with
> diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
> The symptom is this:
>
>     error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'
>
>
> This patch series addresses that and should fix
> https://github.com/so-fancy/diff-so-fancy/issues/437
>
> Changes since v1:
>
>  * Added a commit to ignore dirty submodules just like the Perl version
>    does.

Thanks, all.  Will queue, but it may miss this afternoon's
integration I am preparing right now for pushing out.

