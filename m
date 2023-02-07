Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B951AC61DA4
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 00:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBGAL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 19:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGALz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 19:11:55 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874211160
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 16:11:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z1so13946523plg.6
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 16:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/e/RmdezucG72jVq5Rj88Dpfa823tyaGjOICbcT7M8=;
        b=nhZ92XQ99AauWOrmVppP3qghTKs9TQPCazl7OqEWcsjKPx+mlaoC9Ou5bxJi7gFBaQ
         PCD1AFVLVbpxBMn98I9EGNrHAfZgfZwZpkYVWjj22whcydKSF9oclb3T+T3nP4tow9cv
         I9GCNkHPDoLHfIkmODkF/jnDd7D2i50/NvbbM/p8hwdfMmuXqOHKIc2alUBqnWPXABy4
         frIx9QFoGC2ZyLi+Jq8BOQvwu/3lvefwj+6h235Mw0mW1YjH+dS36WhDkR+uGgdQIMOR
         +lL/S8xKisimXXdn7Jckk8zK/jBmd2Bxe0X0H3MJeeP44ihF3EcyeqelVWANQleZQozd
         hvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/e/RmdezucG72jVq5Rj88Dpfa823tyaGjOICbcT7M8=;
        b=tkrzzK52929mqEH8cSvNTVwjkM06giJMtizyFZyuCQ4WETSZWvZUcPhJ1eW5CayZYi
         b98wVGd69auM7f7ZCeXRzJZI0tDJWxc/CEVFgcl52KwEj7POD8WPjTvX+oQXq2oqXeY+
         rvlpCzWbDaTapUaG0xsAG9za6Yk4VWqgJ5cxiuGtugQ4FFXVdj2dcBNN7olkQQpY868a
         g7Ot/8gr8jQsqjSBE4Onjy9Ix5RfFUlvmUbdBh8w1znS6pX43c0mjNuzcF08sC5w1m4e
         zFLJL4in/jFXbzxHrFuzuM6DoB4+/RR+CK7Z2tlRo6o1LGQ7HpGd6ebtUThLFTpXnYDY
         pjjw==
X-Gm-Message-State: AO0yUKWm606FqgIbgYLRwxO1ftX9KAe+i+8GIOmAdf2wR25wj4hMBvX7
        1M8tA6J4kriom+xvfj5iXUA=
X-Google-Smtp-Source: AK7set8M6uWZn/I0jskuE1REaEOrVGmixjxOnrjra3E6naWggzieU6/0XpFOS/DF59JYYUKv8hSiLw==
X-Received: by 2002:a05:6a20:8e29:b0:bf:997f:354b with SMTP id y41-20020a056a208e2900b000bf997f354bmr1469742pzj.17.1675728710983;
        Mon, 06 Feb 2023 16:11:50 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id i22-20020aa787d6000000b005998a75dbc5sm5400517pfo.2.2023.02.06.16.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 16:11:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] branch: operations on orphan branches
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
        <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Date:   Mon, 06 Feb 2023 16:11:49 -0800
In-Reply-To: <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Tue, 7 Feb 2023 00:01:27 +0100")
Message-ID: <xmqqy1pa1ghm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Avoid some confusing errors operating with orphan branches when
> working with worktrees.
>
> Changes from v2:
>
>  - Renamed "ishead_and_reject_rebase_or_bisect_branch()" to
>    "die_if_branch_is_being_rebased_or_bisected()"
>
>    A proposed name "die_if_branch_is_is_use()" has not been used because
>    it could lead to confusion.  We don't yet support copying or renaming
>    a branch being rebased or bisected, but we do under other uses.

Quite sensible.

>  - Comments added and variables renamed to make more clear the intention and
>    the functioning.

OK.

Will update what has been queued.  Let's see if we get positive
reviews on this round and start merging it down.

Thanks.
