Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86DEC63798
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50036223AC
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 06:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkRqWg1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgKTGft (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 01:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKTGfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 01:35:48 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C66C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 22:35:48 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id u16so1972225vkb.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 22:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwzP43KgCIlq27NE8p40vALLiU4rnz0BXPcN9Jx0Sdo=;
        b=tkRqWg1tJyZMx2Zvq6HWU+Wktq8Dl+h220UWRDQHQsKhN5xv0YR1cWawEsxTQbLpup
         ZFf0QEJa2A5w3Q7gBST5366SZvwhvGp+AOzfJvsV9xSYc0b4EHJHKQADu+oV+5klAaFD
         VfzzRrG5VpM+oCCrFGSzdUPNRc8kW9dcmf79o2G16cZ+qnNdXhrzKutN1hIKg90xhZNe
         cQNlidIi+pdNG3hAnYxjtvTCrfGpm86HQG+If45kzSR8lXxzBH7bQG41VObZh/nDMBhz
         HpM0PCccR8vjG3rH/3GooSII57OkfwKlWzGiss69WYHoyXgUveNZUDnhsCtwB6xhgw1/
         e2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwzP43KgCIlq27NE8p40vALLiU4rnz0BXPcN9Jx0Sdo=;
        b=s6lI79HYLhRLBQ6skN+C7QhDskYqEILI5DQDh3BA2G1YjZDCFe5WULiDFkiN2pcr1D
         pWutR4TdZd7vu83ThNdtW9oZdNiHc0FUYcowpISy7E22hnV3D+UJeYJliGcSPPFtNOOD
         habTr6QMK/+sGhJfvKmuPEf/gtmi6cZx9eDlgKcwTjHWDViu/KXz1sjp2rbefcU8OwfN
         1x4C/nl10ImQTcMeZoLvN60Ghb4qS41+N+UsjOwduWTPG788DmUypIZfD6YRoQfNL0aN
         7mNBgHiC4EVgAL7FtuQ9sfChve/VPQ6g8XDbBOmHQZNoPsEXfMo0cuCsUHC1vuaj7/NK
         i3Iw==
X-Gm-Message-State: AOAM531iZ6dATgIokJOrkn1tealIfBkxQQuxEzJVTVnCA9rRnT8VjM6e
        EoPhC8bZHJJ24vFkLnFu52bQkyWfwm3BoOhfdWo=
X-Google-Smtp-Source: ABdhPJxfi/XJ9hKVMLxJ+/oUk1vO7Gzrt1rx7UyojuNERGJT9HeU3KGc0FneHIWoy03FwxwN5bmxzIBtH+47rAoHfQU=
X-Received: by 2002:a1f:1b92:: with SMTP id b140mr11232618vkb.7.1605854147219;
 Thu, 19 Nov 2020 22:35:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.796.git.1605801143.gitgitgadget@gmail.com> <28493184b60d3fa46cde346eaae6128bce87c114.1605801143.git.gitgitgadget@gmail.com>
In-Reply-To: <28493184b60d3fa46cde346eaae6128bce87c114.1605801143.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 20 Nov 2020 07:35:34 +0100
Message-ID: <CAN0heSrx6VgV4siQG3V3Bo9d_HKW9HikoTFF34_iZqQxeJkggA@mail.gmail.com>
Subject: Re: [PATCH 4/7] config: add --literal-value option, un-implemented
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 19 Nov 2020 at 16:55, Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +       OPT_BOOL(0, "literal-value", &literal, N_("use literal equality when matching values")),

> +       if (literal && !(actions & ACTION_LITERAL_ALLOWED)) {
> +               error(_("--literal only applies with 'value_regex'"));

s/literal/&-value/

> +               usage_builtin_config();
> +       }


Martin
