Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A14C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 10:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02470611F0
	for <git@archiver.kernel.org>; Mon,  3 May 2021 10:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhECKNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 06:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhECKNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 06:13:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB1EC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 03:12:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r9so7044263ejj.3
        for <git@vger.kernel.org>; Mon, 03 May 2021 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+xXE4bCOSIqYzt9Xs9//JoidCDYZP3MglnX8q3dlT/g=;
        b=Y/hW/Yu1WQfkCBCUaV9oz6C00Ol3MMZPHOeC38iObMrB915wpEVC2q+z20EoM4Wi+p
         jLr+0Bzxxe/zFkEVpGFFBWYzgcBwsvkDo0by5x9O9gvZ80YRFyrTMSRAwN0Sg9G6ZopZ
         4IRujc9NvBj01iIpxOurS453ueQzY32rO/t9aqWrZ8kc43wHsUP/cLinu/lg4EETwh2i
         JURWB/1gm6wbfHghiTqnBL2KPYYj2GWpPkNr1mWhU1FoAqJ7g1d3vPVegqRWXZo63J2z
         L7LQ/iHzhS4wHKI9LvDyTF+5yVSUYn/HKcrcnZSEivaXzJZz0c5bXQFvabaOdx49k3c0
         Tncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+xXE4bCOSIqYzt9Xs9//JoidCDYZP3MglnX8q3dlT/g=;
        b=VtI3iXdYsUbWHNYrJbsAKZVuzBa19XFpko/85FkSzEF98OVnqdQbc4MNvkUpeePCzx
         xGx9qNTwQa88KmIOpHFvQEHKiTqHfdU1hw4JNm1i1EKIx5WanYzlBb7ECyHyjefZWhbn
         G/Ey5hT0TUed2Ux7D+NKtptqM8wROHip0PZgVeFcF43bsqQDI2UlURB1u4112kyxvATz
         6tvp+wgX21ziH3EOG+UH88JfeJK85tRk/Hz2pb/RRAxuXe4QvLCqpfyzozIMDPSp0TjL
         DzFCjsyQRRLd+IxetM4Uzx/Swt02r839DK/nKmI3KEPHXLp63n9F3onRzlOErwqbZduN
         Wc4w==
X-Gm-Message-State: AOAM533PKYJ6wPhtcSJnnOc97VQT6EL2uWx+7ljB5fbttdfXDsC3JdwJ
        AIJ1OV6HJexSCR2mksMi3V+7j0XNUNk=
X-Google-Smtp-Source: ABdhPJwgZ2grk6HRTmQgfR21hBiTlzRwM3iH6AfcZiQKnOmzRuPqwbvnaX2dwvkroyGPhdHgt8PNnA==
X-Received: by 2002:a17:906:49d3:: with SMTP id w19mr16276914ejv.116.1620036775495;
        Mon, 03 May 2021 03:12:55 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g22sm10940146ejz.46.2021.05.03.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 03:12:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/9] t7450: test verify_path() handling of gitmodules
Date:   Mon, 03 May 2021 12:12:32 +0200
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI124aZ1dbY5O67J@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YI124aZ1dbY5O67J@coredump.intra.peff.net>
Message-ID: <871raoxh09.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 01 2021, Jeff King wrote:

> +test_expect_success 'refuse to load symlinked .gitmodules into index' '
> +	test_must_fail git -C symlink read-tree $tree 2>err &&
> +	test_i18ngrep "invalid path.*gitmodules" err &&
> +	git -C symlink ls-files >out &&
> +	test_must_be_empty out
> +'
> +

In 1/9 a test_i18ngrep is removed, but here's a new one.
