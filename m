Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3582BCCA47F
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 01:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiGMBZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 21:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiGMBZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 21:25:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47482B1857
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:25:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id os14so17333521ejb.4
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zZZbhhGLcFB/6cKM+CQXc0TBXLQMvRH5PasZ7+VemhI=;
        b=Q9o+kNe2tW9IIn87bCXD/6cjYWRWG8cJ2GKOcItyyAZoJpWLV3OjQTb2DlH7bBjDE0
         +ZlNdCBHoIeQVdDhLqmRK0Cm27LGy7+N+V3IWw0ngEea6zv2PC6IOArVe1AuItw/4LRg
         +OIfUEGilV7kIY+xjn6+ZTxHuwsR/LW7g23kDpxO99fkdltmp0jO3oEhbi+9N5TTpKWk
         ZhK0AqwseagclDqZWNgEhTqJy0Ctit4MUyVYEfjjhgHo5ISUTI7JL0a/GRiwKd+5eNHG
         6DMkUmlsFaitVp96+kHp4JDdkBwhfAfsMO7Md9VtwWequmMuTy8lAJIWH1lAgJRsVimn
         yMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zZZbhhGLcFB/6cKM+CQXc0TBXLQMvRH5PasZ7+VemhI=;
        b=sUHYhbm3rVHsMX6qTSeGIcOLfCVenEJESqyzi/QddUNh9sAaURm4LALMSiNVTYuNo6
         MKyuCGB/dgaCwnGaSsHWjNN5AaSbbWOpMee13DyK/FgWq+B+T4THUfj8FGvJ4zO+Kwui
         IgKJ/LuunOzUtbUqlqytvZzX5W2IQ5EfRFEZqmlOQzy2hhMWAy3XTnmBW8r+6tRZfKKP
         JpGN2BSXd9OWeO2LfaKq3fRD2mPqVKCH80uK4thUCYFOi0QK2IAH7J58o73wnPyaGa4Z
         RWpy929mAH9dqgavx64lS+sLvBKPCV77Z4qFYqEokItvLUEZJWYrAOIb8sSfYqEgleSz
         iPqw==
X-Gm-Message-State: AJIora8MfhRu3Q62kLl4iWfjeBVwdPnSJU6WLykFzbdlctLLO0b76ohr
        TcGXy54+H8lFi3T+Kn/3mSXg0Q2m7m//kg==
X-Google-Smtp-Source: AGRyM1sO3yyluvKut9yq6NMHdxWSgv7fp0ktD+3qXDjU8020tGUwYm9GpQPgul8Fd7Yv3WVyqU5tDg==
X-Received: by 2002:a17:907:2e02:b0:72b:7f58:34a7 with SMTP id ig2-20020a1709072e0200b0072b7f5834a7mr929394ejc.525.1657675535432;
        Tue, 12 Jul 2022 18:25:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kx23-20020a170907775700b0072af12590fesm4294409ejc.207.2022.07.12.18.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:25:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBR8A-001cmP-38;
        Wed, 13 Jul 2022 03:25:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de, johncai86@gmail.com
Subject: Re: [PATCH v4 1/4] revision: improve commit_rewrite_person()
Date:   Wed, 13 Jul 2022 03:25:24 +0200
References: <20220709154149.165524-1-siddharthasthana31@gmail.com>
 <20220712160634.213956-1-siddharthasthana31@gmail.com>
 <20220712160634.213956-2-siddharthasthana31@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220712160634.213956-2-siddharthasthana31@gmail.com>
Message-ID: <220713.86mtdd4xdd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 12 2022, Siddharth Asthana wrote:

> -static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
> +/*
> + * Returns the difference between the new and old length of the ident line.
> + */
> +static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)

All tests pass with this as size_t, instead of size_t. Let's use that
here instead?
