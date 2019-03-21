Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63FB20248
	for <e@80x24.org>; Thu, 21 Mar 2019 01:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfCUBoe (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 21:44:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34441 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfCUBoe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 21:44:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so4879558wrq.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 18:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oXDFAFlibN7HxpMJeYFy3Q0AYki/cQflWUiHv66v9do=;
        b=NgmvnF9xOUI+syWo9ULJIhrlSmDM9njTESzeL339s4MEkmzluswxKo0G8O3jja5kPj
         Fu23+lEsToBtCq5oWSP9pjyUF61b2Cz9yulKhK8woB61auRTMS5J18W78e4JVewdHtLN
         12ztrSksr8QV7AqhnT+QN1wQAg3cl85+Ype8NVoGNOvzeYlT56zGrvqckC2gbAO1o0Y9
         gehdsI/V4T7Jot8KF40SIA+rYUh/BERYNDOYxyqHck8OMkPUFzSRf55ECTSP+2vPtZNd
         tMl5PcsAryal7PmSdho6pnrX2Y9j+/5VR8Oe4Zi0XNsL3HvAbhrx9UxZqE42whFIWf9Y
         dzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oXDFAFlibN7HxpMJeYFy3Q0AYki/cQflWUiHv66v9do=;
        b=uBZV5knQubvyBDjpAOGDzdjY7I7h7KCJ6woZeRzvvLTmY1QGXAZuQdgEj0uTz+9/M7
         fnYVSQd0nBhrfLbiND/PzDcw7bKY8UdlQtkAjOL4f0gr5bpMNR4DX4Sg9fpdV1NXmy9D
         O2qviDc9CVIgvPv5tT/wHWTOW6AHa5qPMtVb68TiRYgz0ANVbrv0+a/URshuTOhjEb7l
         8SQDVSgyMSbxb9hvqMUm/XF8PFVydcZW2ftdJQTBSpyWfJspck39PEMCcixE0wbdSjb5
         M9dfg1eYhpIQJDXiTDNmLCLlWJ4iyz18E/CAcWMGd62XiJjEeo1pH6gF4gNpxaMLZhaa
         BrlQ==
X-Gm-Message-State: APjAAAWjPjQW6v0hBRnnF1LT2QpOLcn+PV/QKHGz+hJSkfWfU/V5I7V9
        k1m+DJC7xKDMGQnPTD6S7RABVg4SboQ=
X-Google-Smtp-Source: APXvYqzKU3RFT1V6/dNAWIr/UXJ+OcM2C3CESrXGzMipsKS+leuHJhCX3ETVyj9kvw2dqeFfEqA2gg==
X-Received: by 2002:a5d:4a4d:: with SMTP id v13mr637838wrs.169.1553132672472;
        Wed, 20 Mar 2019 18:44:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h17sm2542741wrq.93.2019.03.20.18.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 18:44:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 00/11] rebase -i run without forking rebase--interactive
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Date:   Thu, 21 Mar 2019 10:44:31 +0900
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com> (Phillip Wood's
        message of "Tue, 19 Mar 2019 19:03:06 +0000")
Message-ID: <xmqqr2b1t30g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When the builtin rebase starts an interactive rebase it parses the
> options and then repackages them and forks `rebase--interactive`. This
> series refactors rebase--interactive so that interactive rebases can
> be started by the builtin rebase without forking. My motivation was to
> make it easier to debug the sequencer but this should help future
> maintainability.
>
> This series involves some code movement so viewing the diffs with
> --color-moved is recommended.
>
> These patches are based on a merge of master [e902e9bcae ("The second
> batch", 2019-03-11)] and ag/sequencer-reduce-rewriting-todo ed35d18841
> ("rebase--interactive: move transform_todo_file()", 2019-03-05). They
> can be fetched from the tag rebase-i-no-fork/rfc at
> https://github.com/phillipwood/git.git

Exciting.

>
> Phillip Wood (11):
>   sequencer: always discard index after checkout
>   rebase: rename write_basic_state()
>   rebase: use OPT_RERERE_AUTOUPDATE()
>   rebase -i: combine rebase--interactive.c with rebase.c
>   rebase -i: remove duplication
>   rebase -i: use struct commit when parsing options
>   rebase -i: use struct object_id for squash_onto
>   rebase -i: use struct rebase_options to parse args
>   rebase -i: use struct rebase_options in do_interactive_rebase()
>   rebase: use a common action enum
>   rebase -i: run without forking rebase--interactive
>
>  Makefile                      |   1 -
>  builtin/rebase--interactive.c | 377 --------------------
>  builtin/rebase.c              | 625 ++++++++++++++++++++++++++--------
>  parse-options-cb.c            |  34 ++
>  parse-options.h               |   4 +
>  sequencer.c                   |  42 ++-
>  sequencer.h                   |   7 +-
>  7 files changed, 556 insertions(+), 534 deletions(-)
>  delete mode 100644 builtin/rebase--interactive.c
