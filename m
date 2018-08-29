Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7634E1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeH3CjT (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:39:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35759 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeH3CjT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:39:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so6254271wre.2
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=t05hdvtn9dcoCjLyDWgyGaiIHa+Nb0Ex0B3bXMQzVt0=;
        b=RQDKIDRNV+fcSNkUbe8OAP12HowjYo1mQy0GAliHmPoXU/Yb/9g2ktaLYyDVdEVSUk
         MvLKDZePtwCXI87Ab6S9Nhzcxnxt8bxgvPV2ulK2YUK76WGM0Ss0BN1JJeqrZZ5XVTMB
         tHs5N0H9hcGWV4v3via2jJa+OJT0ED+efKck1LH16Uswxx1iT+zI6ULKtpCN2vU36QKi
         v+FCe4LjFzkdN8odkrPiDpl2hNIskzXfMSszs0qEbiSzUXwcPhoKoWxfZIi2NXS9Yz8P
         6zQM+5yrq+/znQd/iYXdqM2KpE/3gx/828UXWAkyks+ZFP0BfoTcAVDgLBlWUWiP8gPy
         uVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=t05hdvtn9dcoCjLyDWgyGaiIHa+Nb0Ex0B3bXMQzVt0=;
        b=RuIZa4xilyrYvFzm4bXj8cScjfWU5UL8nzjZjFmNMaSmBKrYvZAniuQ11565jiaYz1
         ID3Frd+RYgGPnzDvhogNMAuJLIk20G10ZucLJf+Zk7OCKkZ+0tcOzizMfkEUB7hvwNCI
         iPZ+GMB8kM0rQ3C5MkCpj8CGEqwdnVwQNFwkye1wmiY0D+lbs2/w1BFFR3mZWE3Wz1GP
         0SpSSDuQCw25q7UuvZqwBmFa7hH99CwVBkVy6mMHklv8xyoMWhUYGazGp2mfX6MHNoYx
         UQkF2NvSSvoW7jMukUWmkqjRZ4TLSrnG1a3XC9z4UgKE1d89Kkj1gMafgGT/S8t/wuCa
         wA0w==
X-Gm-Message-State: APzg51Db6RQg1fw7g28FBXSop//zLDMG1/Ut173fOr212vyqnEwlxtYe
        D3u2hsjp5aFuETbyCsLbwMU=
X-Google-Smtp-Source: ANB0VdZxoQXRBC7jUpp5kowPEaeXMvP1Plx1bjOn93ZqUZKYNCYjh6l6QU0p/IEeeQvhbmdTXP2Hxw==
X-Received: by 2002:a5d:4401:: with SMTP id z1-v6mr5997959wrq.227.1535582413861;
        Wed, 29 Aug 2018 15:40:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z184-v6sm482232wmz.0.2018.08.29.15.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 15:40:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] builtin rebase: prepare for builtin rebase -i
References: <pull.23.git.gitgitgadget@gmail.com>
        <pull.23.v2.git.gitgitgadget@gmail.com>
        <5403014be738425e942a9bc1ca2029dd8d2137bb.1535553074.git.gitgitgadget@gmail.com>
Date:   Wed, 29 Aug 2018 15:40:12 -0700
Message-ID: <xmqq5zzs94qb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The builtin rebase and the builtin interactive rebase have been
> developed independently, on purpose: Google Summer of Code rules
> specifically state that students have to work on independent projects,
> they cannot collaborate on the same project.

A much better description, especially without the less relevant "the
reason probably is..." omitted from here.  The author's personal
guess, while adding it does not help understanding what is already
in the above paragraph an iota, is still a fine reading material in
the cover letter 0/1, though.

> One fallout is that the rebase-in-c and rebase-i-in-c patches cause no
> merge conflicts but a royal number of tests in the test suite to fail.
>
> It is easy to explain why: rebase-in-c was developed under the
> assumption that all rebase backends are implemented in Unix shell script
> and can be sourced via `. git-rebase--<backend>`, which is no longer
> true with rebase-i-in-c, where git-rebase--interactive is a hard-linked
> builtin.
>
> This patch fixes that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)


Will replace by doing:

    $ git checkout js/rebase-in-c-5.5-work-with-rebase-i-in-c
    $ git checkout HEAD^
    $ git am -s mbox
    $ git range-diff @{-1}...
    $ git checkout -B @{-1}

    $ git checkout pk/rebase-i-in-c-6-final
    $ git rebase --onto js/rebase-in-c-5.5-work-with-rebase-i-in-c \
          js/rebase-in-c-5.5-work-with-rebase-i-in-c@{1} HEAD^0
    $ git range-diff @{-1}...
    $ git checkout -B @{-1}

to update the two topics and then rebuilding the integration
branches the usual way.  I also need to replace the "other" topic
used in this topic, so the actual procedure would be a bit more
involved than the above, though.

Thanks.
