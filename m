Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD241C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 12:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbiBYM07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 07:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiBYM07 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 07:26:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB5A214FBA
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 04:26:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q17so7196333edd.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 04:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ur6/MrKg5uJBgwjDCpRrPMVnCKs3CccQrqP9pNXaf0w=;
        b=PEV0l7yiXlZP3bve8ixSzYUwQv9pc/88Q4z3U6Y9GhJzTP85Z2RRV9sn6nHHo/SZ2N
         wNz/pxM4UVQqS9v88RRKLepQbRWE7f5U0rxvy7lS07gw3gz6XyEATbFLQPPBpHbAtN8a
         Pdr+eeq+gD7FRNCQT855yn5WpstNqOkAT/WM5KOnFBmeKFYNRcIaoGhIcfizbmIP/FYD
         1QopWddyS0pSIl7HjeJ3Er7hRVWqXE5fWt6qce77FuQ8uDzzoWDX53Tw0u7bxJ06rCHB
         Oc42bHzB2xtf8Uhd+Tf/rUjqVj/6VjlPU+WPcqbIkK/Y6Y9tfHfXH6rHwM6n+MlthNMN
         rPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ur6/MrKg5uJBgwjDCpRrPMVnCKs3CccQrqP9pNXaf0w=;
        b=RuR/WWB7gBBOeceoOtXDXnrlKeLdi+6qgpGO39l9kDm5ujWUiOA4WAeUWdn2rXnFtu
         swuCsIuyxZWl31rBaM9/4VTxnKZeVX1xTod3w00tIM0WmnFi9Tk2fnYQPi0erf87fR6s
         2InkcCA0eSYlfiK2EjqZUg5Gd2hEo37d+CFtSwF1XPHUtzl5715doX5gcS+3KEdWs5e4
         1bnNSu/dK9AZq913Kw08zmq31XvZt1BG2Cvy3wG0DK4d4SFKe4LFUMFp04p4mV6EK41k
         KoB3787H5wulxvHetchMMe+2iflD8Q2mTCN39ga6TiK54jcQKv6eVyfJmE+XxBs41VRQ
         uV5g==
X-Gm-Message-State: AOAM531xLTWIiF/K5MQyDjFVGi+Cjm62k6LsezXOgBReiF/X7pDTA3mT
        X1xWJTc3PgtBxT8q0hqPKl2So1+DBUXPvA==
X-Google-Smtp-Source: ABdhPJyqDDSaLrui0GM2VAd6nQmY17x61iTxJXkzCkn+kCbtmLts4be/jPP7F79Tn53AbO5CeaAi2Q==
X-Received: by 2002:a05:6402:5107:b0:412:8530:3ba9 with SMTP id m7-20020a056402510700b0041285303ba9mr6964092edd.264.1645791985160;
        Fri, 25 Feb 2022 04:26:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090606c200b006a728f4a9bcsm957873ejb.148.2022.02.25.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:26:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNZg0-000VlP-7p;
        Fri, 25 Feb 2022 13:26:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH 0/4] In PS1 prompt, make upstream state indicators
 consistent with other state indicators
Date:   Fri, 25 Feb 2022 13:22:59 +0100
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
Message-ID: <220225.86czjb874f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 25 2022, Justin Donnelly via GitGitGadget wrote:

I couldn't find any glaring issues here on a quick review, just a note.

> These patches are about the characters and words that can be configured to
> display in the PS1 prompt after the branch name. I've been unable to find a
> consistent terminology. I refer to them as follows: [short | long] [type]
> state indicator where short is for characters (e.g. ?), long is for words
> (e.g. |SPARSE), and type is the type of indicator (e.g. sparse or upstream).
> I'd be happy to change the commit messages to a different terminology if
> that's preferred.

I think that terminology is correct, in case you haven't seen it
git-for-each-ref(1) talks about the "short" here as "short",
"trackshort" etc.

> There are a few inconsistencies with the PS1 prompt upstream state indicator
> (GIT_PS1_SHOWUPSTREAM).
>
>  * With GIT_PS1_SHOWUPSTREAM="auto", if there are no other short state
>    indicators (e.g. + for staged changes, $ for stashed changes, etc.), the
>    upstream state indicator appears adjacent to the branch name (e.g.
>    (main=)) instead of being separated by SP or GIT_PS1_STATESEPARATOR (e.g.
>    (main =)).
>  * If there are long state indicators (e.g. |SPARSE), a short upstream state
>    indicator (i.e. GIT_PS1_SHOWUPSTREAM="auto") is to the right of the long
>    state indicator (e.g. (main +|SPARSE=)) instead of with the other short
>    state indicators (e.g. (main +=|SPARSE)).

I think it would really help to in each commit message have a
before/after comparison of the relevant PS1 output that's being changed.

I'm not sure how to readthis example. So before we said "main +=|SPARSE"
but now we'll say "main +|SPARSE=", but without sparse we'll say
"main="?

Aren't both of those harder to read than they need to be, shouldn't it
be closer to:

    main= |SPARSE

Or:

    main= |+SPARSE

Or:

    main= +|SPARSE

I can't recall what the "+" there is (if any).

I.e. the "=" refers to the ahead/behind state of "main, it seems odd in
both versions of your example that we're splitting it off from "main"
because we have "SPARSE" too.

But maybe I'm missing something...
