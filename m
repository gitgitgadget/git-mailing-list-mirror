Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4440920248
	for <e@80x24.org>; Wed, 10 Apr 2019 03:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDJDwU (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 23:52:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36854 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDJDwT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 23:52:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so1109434wrd.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 20:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J4HG60cT5XROtw9X7oKfF7ytgk/zXiWyHCfDtYGMZuk=;
        b=LaOWp55cwnsRGbpnbtA+8RdjtQmBd2zHNTK183moorWsIjVp2ilzF/dNchmS6vK+Bt
         TNHonbF2UlNor73mLvGUrMQ58ysQ3e8/Er1uq4rSEwfUJPc15ekdaf7KJQJVZfJrzZvx
         Oq5EJgVJzE9dxfz1JuWJt4ukZSWXMGiwkS5XBQdyyKwn1aJ6cjFBsNt5tbbzjt6qiheO
         /0d/qKHOZEzhUUQnhPHJtSsR49j2cQFb/sjuXr0vtq9JQ8+PkO67jQXGKKZTr8YbF0f8
         T+sshJYACZ7CplZo2OQI6075KVZU9FAQ9G9BHZjQ0JqfqgVSEFCvrPGrshijJxK36cep
         actg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J4HG60cT5XROtw9X7oKfF7ytgk/zXiWyHCfDtYGMZuk=;
        b=BlYxx6XamsIcZogISnazEC37X3DzrOnSi0YTMW6za0gkLmUic1l8B6hCx3cu5cHTFh
         qJeczzClb2QWKGRzWH5NBGrXXi1TJRnroVKtKxenpa7BgJbSXYqNOaCevDTn7ObVbTbT
         vsqD87SzL0Zd2Rzs+k2IHB5FdqhcfiIDdBS1SK0VeeFsHn6n8gzFv0KorZeS+/cIbdiB
         JF65H1TCH449WiDsquQ6qRuw9CakRrDeOpzgX6mx4imQJHeVKeGcBCrv4h98G30eN0Cg
         l3E4f2nY18Rnk+w+qgU1A6chvciZWdskwmqY7C6x5VVvr3IbrR8kvcLc06M7BcCQCUVf
         Fh0A==
X-Gm-Message-State: APjAAAVN/M/HDtvNRqBeJFAkoHn27snGWJd8/XUs/2OFigEWymmUVdoe
        aPjBAjaadSZvcZyMnSJgqks=
X-Google-Smtp-Source: APXvYqz4YudLnALnGrQeeM/Qv8lcLVnGe0r/B4LMqAG3kC8Q9581RyQbFWaBemz6XUjZmd+oK2EQxA==
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr25276787wrw.245.1554868337646;
        Tue, 09 Apr 2019 20:52:17 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 84sm1390033wme.43.2019.04.09.20.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 20:52:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] pack-objects: write objects packed to trace2
References: <20190409214420.90898-1-jonathantanmy@google.com>
Date:   Wed, 10 Apr 2019 12:52:16 +0900
In-Reply-To: <20190409214420.90898-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 9 Apr 2019 14:44:20 -0700")
Message-ID: <xmqqzhoy1pqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is useful when investigating performance of pushes, and other times
> when no progress information is written (because the pack is written to
> stdout).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> We're trying to improve push performance, and it would be nice to be
> able to observe the number of objects sent over each push, both to
> correlate it with time taken (which is already traced) and to notice
> situations when significantly more objects are being sent than needed.

Thanks---I find it a laudable goal, too.
