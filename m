Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14671F404
	for <e@80x24.org>; Mon, 16 Apr 2018 23:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeDPXFU (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 19:05:20 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:41589 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeDPXFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 19:05:19 -0400
Received: by mail-wr0-f171.google.com with SMTP id v24so13291289wra.8
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2079rSrSpzHyZeoL0t8GKH6u13ZobvZJXl4ffzoochI=;
        b=cPVj2uBmLEN3YJaKlsQ8ra/XTO7hMHb9IwM9JCENfaHHLAYRpmUOb7Dfw7GEnc2iv5
         ooOATxopEdCq0t40zmRjx55K4d77UD90sf+FMgfCIoeSyGuLRdNkQ+v6DMErhkt7ELer
         o2ZjkkRwmFVNQd2IFBC0/k1+2WHOUPQSW8ATqFfzcZEO8SM8gDvE1OO+gVw2wNWKjKHO
         7MEXZqhRkXm7xS/kwN2M5Gy3EkFOkh7b8HmdMZeOaMs7jMZ9IyZTYltiDew0G/JzhCws
         4VfK1Q1x2vtLIpXjI1gxuidOwpjHBqKOtkLcAawAjNFBdj2fUGxvgPb0hlokiK8N6UZT
         cL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2079rSrSpzHyZeoL0t8GKH6u13ZobvZJXl4ffzoochI=;
        b=ksJ1X4vweBxXXNbXmJScPjIrD9Oflk6h38osrEQa+JIGRY8oVLoq15ul2r78pSofhi
         uJDUDhIsEQ7jP4D7SgYxthpOGDFnVlETeLTpMRVf5qtTj0hrYtDttdH/06+Lw336Te0S
         kgPNgo9xDpnufy54EtqTqu/RQjInO1ckMmvLIVqKU9pcF+Rkb7Ero+68u2mBMSAhM4I9
         JQZwcWfFGSKGcum0IO/4iMzJSAtJLsoddVvY0Tk6SL1gxrovvxtzQdMyUWyWQOrH9IvS
         UEJoH1ftQeAXIRbbxW0Zg0IjmvBgAErPu311YIG3yXhkSMpYKC4Hj61UyoH1e7Fkz/vW
         orlQ==
X-Gm-Message-State: ALQs6tA1G3s0IuGfAKR469ABanzOfCLatz8Ln7ZB1BiEluaOUEnH0H1G
        9N97BDJn3iG9c2SFWc5s2Ys=
X-Google-Smtp-Source: AIpwx4/hHcUqQOHC9nZLR9As04klwrGJJGiUlxWDtj/QsxzrmQeWCX1mmDNvRiTkhSB5xlgjngphhQ==
X-Received: by 10.28.8.212 with SMTP id 203mr106507wmi.9.1523919917397;
        Mon, 16 Apr 2018 16:05:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i138sm754427wmf.22.2018.04.16.16.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 16:05:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Vogt <mvo@ubuntu.com>
Cc:     git@vger.kernel.org, sbeller@google.com, avarab@gmail.com
Subject: Re: [PATCH] show: add --follow-symlinks option for <rev>:<path>
References: <87fu3yg6od.fsf@evledraar.gmail.com>
        <20180416093625.15752-1-mvo@ubuntu.com>
        <20180416093625.15752-2-mvo@ubuntu.com>
Date:   Tue, 17 Apr 2018 08:05:16 +0900
In-Reply-To: <20180416093625.15752-2-mvo@ubuntu.com> (Michael Vogt's message
        of "Mon, 16 Apr 2018 11:36:25 +0200")
Message-ID: <xmqqin8qwy4z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Vogt <mvo@ubuntu.com> writes:

> Add a --follow-symlinks option that'll resolve symlinks to their
> targets when the target is of the form <rev>:<path>.

This not only affects "show" but all in the "log" family of
commands, because the change is made to revision.[ch] that is shared
by them.  I doubt that is desirable.

I offhand do not think of any command other than "show", to which
this feature makes any sense [*1*].  And I certainly do not mind if
the feature is limited to "show" and nothing else for that reason.

But I do mind the implementation that seeps through to other
commands (because "log_init_finish()" is shared with commands in the
family other than "show", and because "struct rev_info" is shared
across all the commands in the "log" famil) and not limited to
"show", which is a sign of typical end-user confusion waiting to
happen.

Thanks.


[Footnote]

For example, "git log" is affected by this patch but I am not sure
what it even means that we can ask this question:

	$ git log -p --follow-symlinks -- RelNotes

Can we see how each update to Documentation/RelNotes/2.17.0.txt as
well as change of RelNotes symlink from 2.17.0.txt to 2.18.0.txt in
the patch form?  If that were the case, it might make some sense to
allow the feature to be triggered by "git log" like your change to
builtin/log.c did, but I somehow do not think that is what your
patch does.

