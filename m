Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048D720248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfCCBfR (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:35:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36058 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfCCBfR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:35:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so1727079wrw.3
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZiM5TZc4TvU9uj5R1h2Np3/F5bDN34PP+FaTXqrRzMU=;
        b=BJB0n6MiyV7li5v94zXLmgeVTKHUzUHKq/T7UMaO16CkgU/g7q03VBtsOC6pXKG0F5
         L3V1U8IK0uX5t9wNdgYhTpaMqdtX/vdo9vgTvDmabKO9pp19y0k7aN3U/8ZSUQDPHKJS
         Hc95TfjYEJu/aV40++tSgW/llgs4Tq0byjTMfzzdoGj6LOcNWJmgQ5NmXfJI/jwarSxS
         DYLX+k6vUoZ820vK3YHwNZuWp9Z9kZNIA78T2NmXgAgiLhVakbpwkksIfSsy9PfN+EOJ
         SQYfKRZY3F3ZgZy38AuUBy6pRNxXNsL8hG0NLtnvQ0IOsdYGYCZAt6lctxkxZ5uquc25
         nJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZiM5TZc4TvU9uj5R1h2Np3/F5bDN34PP+FaTXqrRzMU=;
        b=Jjizkpmcfe2FaNg0ZVlMj49wPcAWw/dmN0Ia7y5lkJ8TxPh08O7HV1FMm+JYwu8pt+
         RzOABoh9sR7xQ+QG3u4uW305Mc2LwLYKMyCHHkrQoOaKrkzWQy26Y32XBsU+YjC/JnDG
         zClY6KBZk6o4HyKZr97Nzj3lJ3KRJAfmpk4C8Y8d2xXxnnFmQg7gX4gVD7vLSX8kiz/a
         4uzyMGtGIc4AEcDMe5Cc57MRU7ywScQ2opEcwFXGYBm81mRePGOkodAZj4wcQ2E/+R0U
         yx8AH8OpPVbYFzOWPa2SVixUNA2ardFnzQaqAsEa6huhUBOvHozes1QP22KsbpDC18G7
         e1QA==
X-Gm-Message-State: APjAAAUkw3vXx3lfY0PpTwlY8EhOqgKQiavwksCaHppLUj+akHv/5k/d
        0XntzTVmOUQ82oGRcolMvlo=
X-Google-Smtp-Source: APXvYqzBWb32/5BiR48AETQvGxtW+RCUvgZX5hBt5NfLiPpfhPsgL6CRWRa/VDtXauX5lmgZY6jIqA==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr8657484wrs.2.1551576916292;
        Sat, 02 Mar 2019 17:35:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o12sm8904477wre.0.2019.03.02.17.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:35:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH 1/4] built-in rebase: no need to check out `onto` twice
References: <pull.153.git.gitgitgadget@gmail.com>
        <2d99429387ba63526efe233bbefe851c5d556fdc.1551367664.git.gitgitgadget@gmail.com>
        <7b1282bf-4b94-5725-00df-2dc63eaa93f0@gmail.com>
        <nycvar.QRO.7.76.6.1903011415220.41@tvgsbejvaqbjf.bet>
        <22878dbe-d9f0-4737-3a49-ece695c2d0c2@gmail.com>
Date:   Sun, 03 Mar 2019 10:35:15 +0900
In-Reply-To: <22878dbe-d9f0-4737-3a49-ece695c2d0c2@gmail.com> (Phillip Wood's
        message of "Fri, 1 Mar 2019 15:00:17 +0000")
Message-ID: <xmqqef7o3fl8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for explaining, it all makes sense to me now

It would be necessary to make sure that it all makes sense to all
future readers.  Are they patches good enough as-is for that, or do
they need some updates before I take a look at them to pick up?
