Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C39C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 09:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02F2239EF
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 09:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbhANJAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 04:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbhANJAT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 04:00:19 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18955C061795
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:59:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id by1so665189ejc.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DIDEtFRCvd6XBRJlaPxfDt6fliNKy7OAvy5IGKd/ls0=;
        b=rDSj2towGNUtx5SAm/X6GWw4MiSm8i6oCr8yh8IUeQrFgVhjYh+PwRW0WeyluZ6gqF
         SIAJgHa44uk9Thtq4ljbT8QNGfMdZDGrZiKxJ/42oX7NSCii0gCAQq7pVrY3pSfK3AlI
         VIadAvSae/zog56i7ZkYGJyJAFJwoAtXfCOlsx3EJ8vVopL/CT50O6vDNRSo8ZuI6zqN
         ZX17HiWaBlzZg42C1D30d/8JaSWR+DHq0UYMwyoE0LB+I73lKnqcCu/Xe5i24cE0Exj2
         ykqPKNhBhmvDVI4Mo2yscbEjLBTCMAxbDDgKeTTsJauXG1n8NJRLN3CLUw+mOhZKcSJ4
         hOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=DIDEtFRCvd6XBRJlaPxfDt6fliNKy7OAvy5IGKd/ls0=;
        b=Q9wyrwJzj8ApSdyr9LStVQRy2FnqhIK1P+Q0Cck6jW6mgzHnpTeqhAQ7SzWFLgL/76
         n+Xaix06nhUTYAJx80QL4ju6ejIGfce022MNdXeVvQsABnLk8KL+nvxzU6YVBlGO7gzt
         0gjey3Z0gnIxgU7+77WDEZYF1tXyrGdSaGrQ1HvZ04hE9f4CVUbn36bvyP+3HXMagkRi
         E161agccgTIT8jGxBF/eWfsFodOxGvQIMm0YU0z3NoHrxWTtg5V+FnNljzAjsrDHGZr9
         oDWIAEM75ji1xwYcgYba0XiWP463I4Snmaf1pFthDVNfSwcVctGetgfvOp03BfM89T3F
         PLeg==
X-Gm-Message-State: AOAM531tUNwLsqNxzobrQKIrw3iK/XvettnJnUF4ASYbqL81DwSuU99+
        wTRgfPZdz7N1ewCImUxJNwWz7rfvER+Vqw==
X-Google-Smtp-Source: ABdhPJwEMUsnD5Pyr+0uCf1CYAmVEgeUOfFLOaAappwXmFKmH2zjmX8cEQ0OxAgbP/lvne766t/weA==
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr4603055ejp.185.1610614777709;
        Thu, 14 Jan 2021 00:59:37 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id m7sm1751279eji.118.2021.01.14.00.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 00:59:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 00/22] mailmap: doc + test fixes
References: <20210105130359.21139-1-avarab@gmail.com>
 <20210112201806.13284-1-avarab@gmail.com>
 <xmqqwnwh23a3.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqwnwh23a3.fsf@gitster.c.googlers.com>
Date:   Thu, 14 Jan 2021 09:59:35 +0100
Message-ID: <87zh1b51xk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 12 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Just a "small" addition to v1, now with 21 extra patches. While this
>
> Need reminder on what the v1 iteration was about here.=20=20

Just the 22/22 patch for removing "repo-abbrev".

>> is a large series, it should be relatively easy to read and
>> non-contentious.
>
> I've read this series through and didn't find anything glaringly
> wrong or contentious.  Very cleanly done.

Thanks, I saw you merged it down to "next" already. Should make any
conflicts with other mailmap serieses short-lived.
