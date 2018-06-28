Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6641F516
	for <e@80x24.org>; Thu, 28 Jun 2018 18:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966266AbeF1SFG (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 14:05:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45473 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965570AbeF1SFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 14:05:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id u7-v6so6395717wrn.12
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p5Jhfw1mVSK5eYI1smUpW5XWGGRbSEuEousCADcuDg4=;
        b=EsYHDrU2TKJt2HrUuxEeLec6n+oT90EWBMIGfnu9+26Hi03xEZMvgZ4xIK8EqZweGb
         1dzjvFneqh5ztuSzSihqxvcFKfutYIpAf9K49e9AirzYBfFm2XHVF9pY7grwlfDb4VUE
         hVWMUUR3Cdxbdmxt1qF17K/E5D81c/7GlTXF4J1CDDDfpx7q3DRAn046Yix56o9YEMGe
         K7gDZneDVoDOf9MMRyIv+6DkAbxWJuNjq7w8j91R37jGd+rrXALgG6LtstjAgpdoy4FB
         QkO6RypVJIOJ3YobxUXlaBp2C7dbCBPPWwsu1wVVyjdtEuY2MOkc6Kn6UwQF2qtF7sAN
         MmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p5Jhfw1mVSK5eYI1smUpW5XWGGRbSEuEousCADcuDg4=;
        b=A2pxsCz2Nb7hC8g5MceSzdS9uXmkw/naWnXGMOHpqT93UrjnChuGgteKwrIBNA0gQE
         bzqjrCQ/kh4OigP7WxQ8ZD++Nkrpz1qGqNMTz+3qAKgpxBV7vcwu7gMTYl21B2+PU6kz
         nyfEWzZxgHlxQZ76GBfm1MQ8W0BHs3Utkv2CVT6bc2Zoy7jnSg8rDSYtgWRKpq6SlbGN
         QQ/HJckSyiu+omsD8tkjPxPZcajyNz1op4mlXViUdRHQ45H9VOkkdMn9quWJ7mISy8og
         OVxDRD5yA93pGnETvX1PCSehZGc9Llj8LGvB5njG1ZQT/mW70devNJxw489Mz5hURBEp
         WpRw==
X-Gm-Message-State: APt69E0Ky6lj1C48qZLra1/3SZ2kPAf/YbKxNUaEfoPIWfTAZh6W4usW
        mKnFbBg/FlgiIiaYDuWU+Nk=
X-Google-Smtp-Source: AAOMgpfP53qnAo8xaI88WGwHmxTjX+qGKNzeacPvTMljUtDq6NLPoHUpHHKJpuG8/MY8kXkmz4zWqQ==
X-Received: by 2002:adf:e3c5:: with SMTP id k5-v6mr8581841wrm.94.1530209103260;
        Thu, 28 Jun 2018 11:05:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m10-v6sm6292419wrj.35.2018.06.28.11.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 11:05:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 0/2] rebase -i: rewrite append_todo_help() in C
References: <20180626161643.31152-1-alban.gruin@gmail.com>
        <20180628100411.8092-1-alban.gruin@gmail.com>
Date:   Thu, 28 Jun 2018 11:05:01 -0700
In-Reply-To: <20180628100411.8092-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Thu, 28 Jun 2018 12:04:09 +0200")
Message-ID: <xmqq1scqyegi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This patch rewrites append_todo_help() from shell to C. The C version
> covers a bit more than the old shell version. To achieve that, some
> parameters were added to rebase--helper.
>
> This also introduce a new source file, rebase-interactive.c.
>
> This is part of the effort to rewrite interactive rebase in C.
>
> This is based on next, as of 2018-06-28.

Please do not base new development on 'next'.  You typically do not
require the whole of 'next'; there is *NO* reason why this topic
must wait until say ds/ewah-cleanup topic graduates to 'master', for
example.

You may still depend on just a handful of selected topics that you
build on that are not yet in 'master'.  Identify them and build on
top of the merge of them on top of whatever integration branch you
are aiming for (typically 'master').

And list these topics explicitly, instead of saying 'based on next'.
