Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D50C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiBDNHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiBDNHW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:07:22 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0002C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:07:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w25so13024282edt.7
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=67YLIR297KiKcrU3K2PYA4dOrrtdUTYWDsdkvJAP9fU=;
        b=Z2fhduS1cMJQ+sbJceJKAVJogs1qMvs/rMuwIE6VbeKJKf9Y3cylaR5EcxuIm1/q7K
         cit+0PBcWBKZt40Y5qn4W/Sal35qt4eM1ZmGFMKLFn4jPAXS/DAMbAL7GRsE6MX6ySWS
         1FHortwVxfS/cySGef+OMXc62oHftNVLp8h4JiJBe8u04dOtO0hCg4E0oFs5wxLyqtgv
         I1xoLgKtYJTV0g0tjLjDSyn0o39fJu/INBhxiliX+YNnSh8aYm6gXPKusaMmuqiSYSwS
         9NIUGhg/o1tWzaI2ZIXmGIctZt9gvJAWmJoNJoo3s5sq5T8Vw6W9xIS2h51CwsQxkXKV
         QLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=67YLIR297KiKcrU3K2PYA4dOrrtdUTYWDsdkvJAP9fU=;
        b=iDZd45gBP5R6jJlUSQyqG8V7euzzqm0c4XjI6488unuQ/r9uz1oCaBulSM93h9SJ2N
         aYJTvQ0n61cVvwSSiFm8qFaJNbsxOHAIb0Wp23TSLIzV2QYtpg0JEPLwdPnMtHTxr1w5
         RzG44zCufR00oDNO8iOWMvCxI+GSYLO28svX4QYimgMz6MnGUqY31GqxwFfSGsRjvUs8
         rudWWLmUDrjcbaHgL30/79nZFoGjwtNT24NweR7H05nzmGSVVn9ljnZBRMaDF3SEd0yf
         G7agIAIkiXQPxgOoX1tEQuMLjvxCbCsGUfScCymSpxhURthA+qfVguVFJ7ZCl81rp5WJ
         O9+Q==
X-Gm-Message-State: AOAM531NqXXEj3rqHOYciBLUlZkJmCP4z7/rjQkippRuoEVrHM5bAsbG
        ZgyOvCA/+evv7cVKIiVTMCnfYOf2UlpJ3Q==
X-Google-Smtp-Source: ABdhPJyV6Asjb50af9B6fR2fdHl5PNMyiDeHzTy9Nc92I7E/4jXdvOyMbKIx9Y5+rDEhtlGj70UgHA==
X-Received: by 2002:aa7:de91:: with SMTP id j17mr3032415edv.396.1643980041142;
        Fri, 04 Feb 2022 05:07:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s19sm642208eju.202.2022.02.04.05.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:07:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFyJ6-0065kf-8B;
        Fri, 04 Feb 2022 14:07:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Teng Long <dyronetengb@gmail.com>
Subject: tl/ls-tree-oid-only (was: What's cooking in git.git (Feb 2022, #01;
 Thu, 3))
Date:   Fri, 04 Feb 2022 14:05:06 +0100
References: <xmqqr18jnr2t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr18jnr2t.fsf@gitster.g>
Message-ID: <220204.861r0i3hmf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Junio C Hamano wrote:

> * tl/ls-tree-oid-only (2022-01-13) 9 commits
>  - ls-tree.c: introduce "--format" option
>  - cocci: allow padding with `strbuf_addf()`
>  - ls-tree.c: introduce struct "show_tree_data"
>  - ls-tree.c: support --object-only option for "git-ls-tree"
>  - ls-tree: optimize naming and handling of "return" in show_tree()
>  - ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
>  - ls-tree: use "enum object_type", not {blob,tree,commit}_type
>  - ls-tree: add missing braces to "else" arms
>  - ls-tree: remove commented-out code
>
>  "git ls-tree" learns "--oid-only" option, similar to "--name-only",
>  and more generalized "--format" option.
>
>  Will merge to 'next'?
>  source: <cover.1641978175.git.dyroneteng@gmail.com>

Let's hold off on that. It'll need at least one more iteration, as I
indicated just now in
https://lore.kernel.org/git/220204.865ypu3hqm.gmgdl@evledraar.gmail.com/
(and which the author agrees with).
