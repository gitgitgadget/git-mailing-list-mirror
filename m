Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93671C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 09:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379464AbhLCJTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379471AbhLCJTK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 04:19:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424DDC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 01:15:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so8734999edd.9
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 01:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XXAi1CUvbwQlAw9h0yOjxA2aNTQBsyYkf2b//iMbG6g=;
        b=hddKgVPi8Yaralay5GrSy2GQsemqM+XRjPJX/fuArPodF5WpNKFEHgQYsFpIFVB/U6
         G6WsXf2JPjTZOZWlbKA//0Z2DcbLuufeEwiyrs2oKH/hneJtANNMCWEuIfEmo3REcQG+
         ZkIud+VUzvxpYsIQ5ZwRVnsU87M5uV9B/3Cz66T0XLkhHn4jJySuxRx9iq5OcEWZUY2d
         n9ZH0iLYNzVFhDXUMJwkrzmUs8Gyub9egC2aNdcCPQ7IRccWqJsXvk6SsiyGjscwMwVt
         aS3ZkmpXEfATT4fMae16+iuRLJsA4okocBYxLKJG3Thx7XmzzBK17k+UFMBop9KZ3kfa
         8qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XXAi1CUvbwQlAw9h0yOjxA2aNTQBsyYkf2b//iMbG6g=;
        b=uNySymaP28qWSspYgbC2mBZYPfgGyd0VtLV5FewgT9cMkCvlGiv0c5lMlhcbSDGOvy
         ew70drd8abWvVOs/5l87ikdfFPBzw9k+6MV978TR+K4nhez/e16ChNoEGg2oxAsZAxqM
         aKhMwYRi34qyPcSSKUlsbgW7HorIlI6uuJ0HnqPAQBwzj4h7mcurxV26YWMVI46eJHhx
         jiq1uYsaZ68eV8bA1gBAIyD/8Q3xWtqdgFobP9zFspQPEp/jhaEmQNHjbalht3d3wG9k
         e1eu7CZLZ1xxxvCVxU1hgqlSYt+mAfI2K7sfYsbH3FrKHJjk+d3Spo8k0L4UbXGjpCvf
         BXkA==
X-Gm-Message-State: AOAM530h/N8Xyej4ax0/oGvmPs/d35hVaBZSYPqWCLJGgmeNtrlfK23s
        tlacTmvDVmDABG+ZwWuY3uaDeo8KTcI=
X-Google-Smtp-Source: ABdhPJzgxiivVUPtWGo0efLHX+jcyVfJfOkMbU8UkMOwMvHr9AmQyO+57PZnR8NO83B+DsXIliyyCw==
X-Received: by 2002:a17:906:974a:: with SMTP id o10mr21912902ejy.226.1638522944621;
        Fri, 03 Dec 2021 01:15:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p13sm1521815eds.38.2021.12.03.01.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 01:15:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt4fO-0003dQ-8m;
        Fri, 03 Dec 2021 10:15:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for
 `worktree list`
Date:   Fri, 03 Dec 2021 10:13:49 +0100
References: <20211203034420.47447-1-sunshine@sunshineco.com>
 <20211203034420.47447-3-sunshine@sunshineco.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203034420.47447-3-sunshine@sunshineco.com>
Message-ID: <211203.86k0gmt5fl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 02 2021, Eric Sunshine wrote:

> When verbose mode was added to `git worktree list` by 076b444a62
> (worktree: teach `list` verbose mode, 2021-01-27), although the
> documentation was updated to reflect the new functionality, the
> synopsis was overlooked. Correct this minor oversight.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-worktree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 8a7cbdd19c..9e862fbcf7 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
> -'git worktree list' [--porcelain]
> +'git worktree list' [-v | --porcelain]
>  'git worktree lock' [--reason <string>] <worktree>
>  'git worktree move' <worktree> <new-path>
>  'git worktree prune' [-n] [-v] [--expire <expire>]

Looks good!

Aside: I've been thinking of hacking something up to just change all
these "[verse]" bits in the *.txt source to:

    [verse]
    $(git worktree -h)

And then have the doc build process pick that up, run 'git $name -h', do
some light search/replacement (e.g. "$cmd" to "'$cmd'") and build the
docs like that.

Seems far preferrable to dual-maintaining all of these forever.

But in the meantime this small fix is obviously correct.
