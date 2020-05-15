Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9E7C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973F4206D8
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP6tDfL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEOQ36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgEOQ36 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 12:29:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B997C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 09:29:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f13so2913049wmc.5
        for <git@vger.kernel.org>; Fri, 15 May 2020 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tAb7xFumjuOcFg4NHSV8DorYfbZyHN4MRrYXJha+8pI=;
        b=lP6tDfL6UyDyC8bY8eB4XOD90FcLgKQj6BvIWNjTOr9DnC0thIGYyUFM6PbLCGfamZ
         WIngR7Jg9LpLA1V80xph4abkkbG3c4CyPujVpIxv5Zs+QwUn/tArON9LVni0Mm9vkZ74
         hJa0g6nCMqMQ0Cyj9Wd+uIyELSt6QmrkeX2vbnNugHL9GTS+hdDmzNO3AnJt4JTjtQzO
         0xjgWfqucYG61Irgia2XWrZeYOLwsqZYLCpI7iDmry7JUPUwW0o+0dQ6eSGSb4cJYN84
         BdYrS16QMSSvbWbdKK3gWETUNIYK2WXy0bNHZolwvKoS6DpoiRe3YMuSfIgOZcmjYE6t
         ZBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tAb7xFumjuOcFg4NHSV8DorYfbZyHN4MRrYXJha+8pI=;
        b=YlZetAYSrRnJID9gzUb0XBdHjB7O1jQNR4UzRnRIEJGpwwKcixkHEwShEr+Yta0DIT
         O4kKjxR9EIJxn0rm3fY7BlUEhfz8Lu+sA470rmTi32BjJuq/I/gmQd1NnCH1edax6qhf
         mt/7zzPOxH0TXvXLI6/Fjaxsh/q3YJM9qo9ToAaT0MdwHiZoef+QLiZ0JkkeVZDpI2zF
         NBMxrAfdth3gDZ5/SsIg9Z00y3omf6RaEIMXxukh06crq1r1DN73Z/9u+l3PWKeCVqe1
         UwCRembOqKn4xbM5fwDyu/ALatJfbffhVXC/MInXcUZi9yjzTQ/7/k/wxtAfXfGA9Wl0
         nePw==
X-Gm-Message-State: AOAM532d2FOx8oj6+CbiYuzCY6nRjLj6FEzL0GFr6kHVp4t8CGHbHANm
        pJwY78EIOu7ds8Tg/akGGL1TaJq/EJc=
X-Google-Smtp-Source: ABdhPJxPd9BM8zBMc4naKY/KspYuNQy9+JnovU3RtATdDwNq0kb1pgXK+2MvBmPBo0Qti1Anqtgh8g==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr5124374wml.66.1589560196546;
        Fri, 15 May 2020 09:29:56 -0700 (PDT)
Received: from [192.168.1.21] (xdsl-31-164-191-108.adslplus.ch. [31.164.191.108])
        by smtp.gmail.com with ESMTPSA id a15sm4257566wrw.56.2020.05.15.09.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 09:29:55 -0700 (PDT)
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <20200510164424.GA11784@konoha>
 <CAOEXN9yyL8T8kDmpHKTjjaG9tVS1kh34B-=PuH1hRaA7jF_K6A@mail.gmail.com>
 <CAPig+cRX+M5qhCuKtsCpw8ySdW358utNOiMR7dwYwR4S4aMT7A@mail.gmail.com>
From:   Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Message-ID: <037991cd-d6ed-e55a-72ed-f49041460ea2@gmail.com>
Date:   Fri, 15 May 2020 18:29:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRX+M5qhCuKtsCpw8ySdW358utNOiMR7dwYwR4S4aMT7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 11.05.2020 à 00:42, Eric Sunshine a écrit :
> On Sun, May 10, 2020 at 5:53 PM Guillaume Galeazzi
> <guillaume.galeazzi@gmail.com> wrote:
>>> Yes, maybe renaming the flag to `--is-active` would make it a tad bit
>>> simpler?
>> is-active sound more like a question to me but I can change it.
> 
> I'm not a submodule user nor have I been following this discussion,
> but perhaps the name --active-only would be better?
> 

To flow up on that topic, the flag can be `--[no-]active`. It simplify 
code and allow the optional negation. On the source, the variable will 
be renamed active_only.
