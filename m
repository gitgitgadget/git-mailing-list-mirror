Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A59A81F597
	for <e@80x24.org>; Fri, 20 Jul 2018 22:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeGTXGh (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 19:06:37 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:46438 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbeGTXGh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 19:06:37 -0400
Received: by mail-yb0-f172.google.com with SMTP id c3-v6so5190145ybi.13
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vrhmHTmLpFI5akraaqpPVzFp0M5iIDoXZ8bNltRmRI=;
        b=moiR53ATIyGd3Gb2Je+gD3AX+iQooiInDCdriU/38wSOlNeLPJPcKaSyZAUn7yxxHQ
         CdtnCohhHzsekU70L36NUDEbSapiXtlz2k8Z1TSNQxIKBvzBjc333NdLUoUQPJaqxYuo
         Xf3NJdgCuY53s8Ru7AjQ1ZxpSJDhWj+dIGZuCQPzlXcGfQIKRkfDhMf0kSygmggaNOAr
         4TzJz2lfsTdneBJLVxkr741p6TIm16bOHjBhUV2Y5MU1o98cCORxmC4tXJxILXYDnBLO
         tT6laJuLp9smIl/pb9j6c722NDmeJHwAZtR7Yv0TAjVKGn37mrevVvWSwH2oYNt8fkVt
         7GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vrhmHTmLpFI5akraaqpPVzFp0M5iIDoXZ8bNltRmRI=;
        b=ADIe5iMakCDNHJW1hhGvOKJb3Fh9UUMmAdXe57udCdk79ptz8himmskV4C2PiW65uF
         yhLpC54S3TH/Z630mMognr6myOhMEMThfoOGLdB6/efxn60HZlSCPE0QQpOvBu/W22ID
         LTxWt7VpuHbpYN7T9wM5YgCR5Og7Yj33mxQfR3gm9QTysiYUh5cLKYRgJndUUhgQ/F/0
         ybgvcxAi+UxWahqGnJJs+tIfT02Cefzb6iZBJMPpYIJVALO/Vf1cm5bgVTADmOmwvTUe
         niXeRHeU+IhJkM7WoXFGmb0Argc2Em4fi3Phy8hqYbJGg9UJLT5/YJfXmu9wOffQ5cXi
         JdmQ==
X-Gm-Message-State: AOUpUlGMP5iqm0JF+6f7WBqqXpWCHgX6KKXg4RsUzYl9nDFT/XPYnVHy
        Sfv8FDCxKP8iVPNXFx6BM5/Shwj8M8CYGVjonVna/nL8nZI=
X-Google-Smtp-Source: AAOMgpceQHHLpL8mXfV0/ZjWBJtIgzWpJPNMQiK8JEqa/cyxpX4oAzUZFVySQCXC5C92j+Hh+jo180g4q2rNwA7OK1Q=
X-Received: by 2002:a25:560b:: with SMTP id k11-v6mr945286ybb.292.1532124981840;
 Fri, 20 Jul 2018 15:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <20180720163227.105950-1-dstolee@microsoft.com>
 <CAGZ79kY28vcs5TN9GtKd439vaTt38Qtwv8Lw0zanDaR1OmsTLg@mail.gmail.com> <833dea7f-b6dd-b3dd-6282-c0a5f939ecca@gmail.com>
In-Reply-To: <833dea7f-b6dd-b3dd-6282-c0a5f939ecca@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jul 2018 15:16:10 -0700
Message-ID: <CAGZ79kb7tWV=cmboA+nsChAUaiC+fVVM-GBCuWfsypC+-wyaVg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> Sure! It's on my fork [1]
>
> [1] https://github.com/derrickstolee/git/tree/reach/refactor
>

Thanks!

> >> * Use single rev-parse commands in test output, and pipe the OIDs through 'sort'

Why do we need to sort them? The order of the answers given by rev-parse
is the same as the input given and we did not need to sort it before, i.e.
the unit under test would not give sorted output but some deterministic(?)
order, which we can replicate as input to rev-parse.
Am I missing the obvious?

> >> * Check output of parse_commit()
> >>
> >> * Update flag documentation in object.h
> >>
> >> * Add tests for commit_contains() including both algorithms.
> >>
> >> * Reduce size of "mixed-mode" commit-graph to ensure we start commit walks
> >>    'above' the graph and then walk into the commits with generation numbers.

Overall I like the series as-is, and have found
no further issues in a quick read.

Thanks,
Stefan
