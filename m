Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9F91F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 04:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKLEt3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 23:49:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35303 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLEt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 23:49:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so16226734ljg.2
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 20:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0lix+u4hBx/iI4GbuCKSTpGiDzIMH+S7u4IgbGVR8M=;
        b=LSW9wohh9fEFbPyAX4+luMCSrpdny6/tFBlyRQHYJAcPh0lj1dYPu0xVxphaWRTQJK
         1kqBVdKSziT6MGw9I3McRlGZQc+ESNXo3nf42Br+7BCboHWjOHS4Kikg1h68xZ9Ab86u
         aTtmFL0ooLjzZ4+2LuKgN/NLPzq0oyz3I0fl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0lix+u4hBx/iI4GbuCKSTpGiDzIMH+S7u4IgbGVR8M=;
        b=ez2H9agwvXISd2KnvPksDjp6YkogQH8MGw+ufINXbvsxsX9ZPfZzVxiZ1Bk5bWht0A
         Z2XlsPZ8FdPhNEQtylBauZjMJlBVZXOm1Kc5Ym2REdufHtL/jqWW3Wdv5rcfL3EgLb/j
         PI/A0G/x0TaAkhHC6JPvLfdrrJJib0xC3vlLu4eFQWKBma+tG0VAoJStB0oK3uaAjeX8
         znAhGKweE5jdIq0/t7YfWAHeo1YiIQLtsnkz4ii4YGjeCk0BV0QwhD5bvwl9Hw4/54H2
         yHXgO1l/D6TKiKxWDat7yfrBipiw+TD7u0KCStKGUjQp3OPWbOyfgawgtQZnC5gTv5Ic
         kAJA==
X-Gm-Message-State: APjAAAUPeEDnnuICkrZwcKCo9Yq/9SFW3AQ6QqvNJcQxz7qoB6CPzasK
        4+2LJ8GcZOh8TMMfALqA6uHGvyzKbExbZf2ApOBX++liLwBktA==
X-Google-Smtp-Source: APXvYqwgBSZM9jEesUZlO/tqWEtlsygJuS+MNqJ7BAkdMbqS8kl9nN/QdjG+doHrQoqzjOh6FF71M6de/bp8iuHfFPU=
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr16064502ljj.99.1573534163093;
 Mon, 11 Nov 2019 20:49:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <pull.436.v2.git.1573110335.gitgitgadget@gmail.com> <9469beb59937f87647190cf7f56544b8c27e20b6.1573110335.git.gitgitgadget@gmail.com>
 <20191111192526.crllpe3phitneu3p@yadavpratyush.com> <CAPSOpYv0NNihiWF2LL=czoP7N2CGNSkB8SBNTZ65iOZVOBPqbA@mail.gmail.com>
 <a1dd45d5-8dac-e86f-c964-957ff0b8dfb8@iee.email>
In-Reply-To: <a1dd45d5-8dac-e86f-c964-957ff0b8dfb8@iee.email>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Mon, 11 Nov 2019 22:49:11 -0600
Message-ID: <CAPSOpYsbBX3d_oWJHtKHD7b0cXcELF=t-zYNEVpU3sf8qzD4Ew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] git-gui: revert untracked files by deleting them
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 4:59 PM Philip Oakley <philipoakley@iee.email> wrote:
> sounds like "Currying" a function but with the parameters taken in any
> order, though, in a sense, perhaps not generating intermediate functions...

It's like currying if you could pass g(x) = f(x, y) to one block of
code and h(y) = f(x, y) to another block of code, so that each of g
and h are each like curried versions of f that "bake in" one of the
arguments, without having to know which one will get called first. :-)

Jonathan Gilbert
