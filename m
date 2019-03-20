Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D1D20248
	for <e@80x24.org>; Wed, 20 Mar 2019 20:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfCTUuw (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 16:50:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42074 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTUuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 16:50:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so2762887pfn.9
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9GVu7OzdP+6LkMBaMwZaUXM8pSqEZpCwvc4xAwblHBk=;
        b=FflWNRBSMre/H6QbEKtHC8axSIVIS/ay6V15aI+yTw4M7yF2+dWiIoJ36kZzJvnqq8
         Fj0XFQuC0VgMqd80vM8N4SjG3wb8crHRDD/Ss1dD7YKrAgwmTPdICuoN3KpdoxIsr15R
         YGwddtr51IYobSIH2JGeNwuTOzmZUSVbdW83ruFsB6E2BSx/Zou0M9yv50x671UbJ/s0
         AZ6mtkIWYy88mk82wBE9ZPSm5B0sF5sFbKGUvbuVYnhmlmLiz/0eaLb+k0hQSlO9HQlG
         9uM8qS+pv+agUaMBuS3SJRmGr5gh08ElGJmx3Q7xKvXbvs7ad41G7ytNhbx7ReqjV8vs
         p+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9GVu7OzdP+6LkMBaMwZaUXM8pSqEZpCwvc4xAwblHBk=;
        b=DrZWgc3PjzaEP7knrOZd6ot/X+r49cQt6L2UT2EhgmSfq5NfFJoWPz9EhoYwNAocz5
         pFHX1dgNiEmlLBx2Rzqypv3883wj25AyyGozOpX6mzdMG/kbq2hKcvYvLoUJu70hsoFk
         xoCz6ASdGkuQS25rzdTr0H4JYeKobmMTlL1kgD+jSwEitMKAw6Yq2JB664jO61DvqrZA
         HHxyVuvzJA6I1AUbTmyqsznY4zxrynfVszz4zW+6+QgtzdU+eWp4xKo69W0GUnuGTZBg
         DNeSUhVe1TbWgUchmpLGLZGo5K3ggCpFRQ8X8vlLkgu/WL5BAoUzZERMxhysa5f/5nmz
         eSNA==
X-Gm-Message-State: APjAAAX4W8BJvGCE80YkTnsE4vDVkxAvxmuHAutK0aL89hTJVGl0bKHc
        8Mv8SksUrXobcPN+jXNk7ChhvQ==
X-Google-Smtp-Source: APXvYqy6aXKweRzAKjLT0PSDGUMcBjjHZetJsLirQz5RLvrQghWBhT222DCL3a+HZfPZ+LTonQTHtg==
X-Received: by 2002:a63:43:: with SMTP id 64mr5885pga.64.1553115050021;
        Wed, 20 Mar 2019 13:50:50 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 139sm3735437pfw.98.2019.03.20.13.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:50:48 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:50:42 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/11] rebase -i run without forking
 rebase--interactive
Message-ID: <20190320205042.GH47591@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.03.19 19:03, Phillip Wood wrote:
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

Although I'm not very familiar with the rebase code, this series looks
good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
