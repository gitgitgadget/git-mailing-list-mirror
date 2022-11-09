Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96253C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiKIXGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiKIXGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:06:45 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D396D647D
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:06:44 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id g13-20020a056a000b8d00b0056e28b15757so66737pfj.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 15:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gFaBae7MANpSm2vYW39pX55tQ+hGUE3zv9FDXWwxz8=;
        b=novwCqfMQkNMQTKZ5Wtgg/Y0+wiQ5SlUtuBoamv8IsrZAXAmr9HVsTURGgMtEhpzo8
         Ga4ajenLoDA8VqKeaKxQTvWhKvfmR9//JrkUSmEwiAaV8M2ei3fXmS5/Ns53xbU4RpH9
         rLl+oqp9WFD4onlVveUjP9ilux3DCq4SsvAE43WEXAM4X2FKnfBL71lo3YtgX9G2IJzY
         1Grtg3AMoHOaCrM9fFtfwYQuOz5q33P03CbU0N8IpQcqhThZekxkchlcoli/qd5p1wCO
         DmHaJuUJkHzEYiIgvFTOJD/H9Ns01mHP5rUA3l4wF0syb7L8wN8fM1waE8Y6GUFXT/AZ
         KHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gFaBae7MANpSm2vYW39pX55tQ+hGUE3zv9FDXWwxz8=;
        b=sObN9A3g6TUiK32okKH1RFKRVoRVgV8sVp/Rcoi1R/xC7LwGFMMaxN7jmjR7rMl7Bc
         QP78Duo+igJkCa+kb62ol7xDn7FoKosY4z5lg/44M7byOVR7rnZcWyz+jrJNIRDzsFeC
         yXkAtd/gNXGkOeayTQ+mI0Zfj7MCncptKIyhhXGhDtUxFKVkO+xlX6K2INp3tyRZKohg
         FUNdj3soLD0AfGiGfP9TdWrBdvcLoj0g7QtlmchHf7jmquYN0rNWsjUIe7/Jrug/bQIi
         LXSxovsGglq8sPtSNgSDgq/kc0nhLCfNETKMEyci8RyZrHsmdlyBkZ94/GweiLA2NmP0
         K4dQ==
X-Gm-Message-State: ACrzQf0uqR2zMMkGgPXf2nR6mxiYE8iiVayB5eFo0wPrpcoq7TRMberR
        pYvvknnFtAQbcQR9SaK6mVq40dT7QdWv+A==
X-Google-Smtp-Source: AMsMyM54kZkT71ulDYTJji9x+N6KyMG9F2RUO2ISnk5Rb0xQDGaxR85mPpRlFBFO5MKgsZX7M7qXGU91NsLP7w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7792:b0:182:9404:f226 with SMTP
 id o18-20020a170902779200b001829404f226mr63056415pll.76.1668035204330; Wed,
 09 Nov 2022 15:06:44 -0800 (PST)
Date:   Wed, 09 Nov 2022 15:06:36 -0800
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com> <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
Message-ID: <kl6l5yfn4tj7.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 00/11] Enhance credential helper protocol to include
 auth headers
From:   Glen Choo <chooglen@google.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew!

We covered this series in Review Club. As usual, participants will send
their own feedback on this thread, but you may also find the meeting
notes handy:

  https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit?pli=1#

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Background
> ==========
>
> [...]
>
> Limitations
> ===========
>
> [...]
>
> Goals
> =====
>
> [...]
>
> Design Principles
> =================
>
> [...]

Thanks for the well-written cover letter! I suspect that not many folks
are familiar with the history and workings of credential helpers, the
current state of auth and how credential helper limitations create
challenges for auth.

I've learned a lot reading this, and it makes the motivations of this
series clear :)

> Proposed Changes
> ================
>
>  1. Teach Git to read HTTP response headers, specifically the standard
>     WWW-Authenticate (RFC 7235 Section 4.1) headers.
>
>  2. Teach Git to include extra information about HTTP responses that require
>     authentication when calling credential helpers. Specifically the
>     WWW-Authenticate header information.
>     
>     Because the extra information forms an ordered list, and the existing
>     credential helper I/O format only provides for simple key=value pairs,
>     we introduce a new convention for transmitting an ordered list of
>     values. Key names that are suffixed with a C-style array syntax should
>     have values considered to form an order list, i.e. key[]=value, where
>     the order of the key=value pairs in the stream specifies the order.
>     
>     For the WWW-Authenticate header values we opt to use the key wwwauth[].
>
>  3. Teach Git to specify authentication schemes other than Basic in
>     subsequent HTTP requests based on credential helper responses.
>

From a reading of this section + the subject line, it's not immediately
obvious that 3. also requires extending the credential helper protocol
to include the "authtype" field. IMO it's significant enough to warrant
an explicit call-out.
