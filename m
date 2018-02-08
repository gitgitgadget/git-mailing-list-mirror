Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39E5E1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 23:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeBHXiX (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 18:38:23 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33208 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeBHXiW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 18:38:22 -0500
Received: by mail-wr0-f195.google.com with SMTP id s5so6485234wra.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 15:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=42K+O3/0yAK73kQNJsF7/wefx/iv2xj42ZYFjD9FGYM=;
        b=gfzQTTaGJ+4y1gk1p8OZ1YlCcqdVZc6fQTGQuiXUaay+Ydqq2S1y/3YSnbhyzyXNnv
         CbzBuryFVaX20IWPNY7tirPnqwXn9ym6o9bJ8E3Dkc6s4jtcW3IgokNfl86XZehOU7SM
         4ocUYBZmba8tFojM3aFRKs1nKyJ0UJbm6wxWw89FQhUQ0lwXPxufQMmrDc/qlhCudv1W
         XY+Gw7/YxI8EzZkZwIYcFkdViLf+6yskxbU+GEWK9rs8FOM4WBdWnl1r0RWyuQqvQTGK
         v4EqJvS3Gm+Y2R3TUDtHisW46zDE1reKPgqCOOFt88QKK68RUTe1vMCoh49O7awmYXxs
         U+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=42K+O3/0yAK73kQNJsF7/wefx/iv2xj42ZYFjD9FGYM=;
        b=TyvzKmTmJGoXlnDzaGD1TW650fceX60siXX+Da1QQ68ebd2PkujOTqa9ZDTRhkzOSX
         uP1vDTf38ukcrtviE0XZjl6h5J+1E0Oj453c4ztjCRdnVWSVEL6AFzHUpalLtnE+bxGk
         nKgvn9IwDRHe8yOT8x/VMq8tg50zrFp3ZFVI1apqiK9F4XdZvooycrVQ5X80xDqoBxlx
         uylF/VlwE367VYQ1PKlqE+p6seWVYqPGBoW7Ujy3+wryJyjQoddbJasVRjlRxISXQdi5
         c0wJ4BMgKOBRuV+jdLq4Lt/SIRAdR4NX6HwRuijiCjhobt5+cGLWq/n3h/RIG8mmcQQJ
         Ekjg==
X-Gm-Message-State: APf1xPABB4Bct8hpK/YeRNau6tazbrfQkyZ0RybNU718gm7T107HWFOi
        qctq8GEuh9x3EOEwWx49Z0Q=
X-Google-Smtp-Source: AH8x226Mhvo0qsU+F9SjkAc6L4Lm2kizsTjxSHpTz4tF0cMuwaPwws0o30W5k7ot+6qsncNuBUPLHg==
X-Received: by 10.223.160.176 with SMTP id m45mr640119wrm.119.1518133100822;
        Thu, 08 Feb 2018 15:38:20 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k37sm1300334wrf.92.2018.02.08.15.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 15:38:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 06/14] commit-graph: implement 'git-commit-graph read'
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-7-git-send-email-dstolee@microsoft.com>
Date:   Thu, 08 Feb 2018 15:38:19 -0800
In-Reply-To: <1518122258-157281-7-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Thu, 8 Feb 2018 15:37:30 -0500")
Message-ID: <xmqqy3k359xw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +'read'::
> +
> +Read a graph file given by the graph-head file and output basic
> +details about the graph file.

"a graph file", assuming that there must be only one in the
specified place?  Or if there are more than one, read all of them?
Or is it an error to have more than one?

    Do not answer questions in a message that is a response to _me_;
    the purpose of a review is not to educate reviewers---it is to
    improve the patch.

> +With `--graph-hash=<hash>` option, consider the graph file
> +graph-<hash>.graph in the pack directory.

I think it is more in line with how plumbing works to just let the
full pathname be specifiable (e.g. learn from how pack-objects takes
"pack-" prefix from the command line, even though in practice names
of all packs you see in any repos start from "pack-").

> +struct commit_graph *load_commit_graph_one(const char *graph_file, const char *pack_dir)

This somehow smells like a screwed up API.  It gets a filename to
read from that is directly passed to git_open().  Why does an
instance of graph has to know and remember the path to the directory
(i.e. pack_dir) that was given when it was constructed?  "I am an
instance that holds commit topology learned from this object
database" is something it might want to know and remember, but "I am
told that I'll eventually be written back to there when I was
created" does not sound like a useful thing to have.

