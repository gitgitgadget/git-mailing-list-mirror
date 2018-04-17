Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BA11F404
	for <e@80x24.org>; Tue, 17 Apr 2018 02:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeDQCPJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 22:15:09 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:45440 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeDQCPI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 22:15:08 -0400
Received: by mail-wr0-f180.google.com with SMTP id u11so31027126wri.12
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 19:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QjfFY/OgIV2Gq1iaCR8mujssWmLmAVBwpISbG6CnAFc=;
        b=nSnrMdsXXYGpIYUMe2kq1ZOxgo/rlxpizkWDRFIgFvnantzHJQqimEIkA5pnJSF15i
         nP0IV3giKCoxlkqwINZEB50DBSk6IO+6LM3HSiEdGwuj7lu2UFI4/NgGJ1C0bN19Gi6d
         epOi8zKurfV9SY7WQDTa/lsVFd9dznBvtS5G/ipf/6ZxKUYunqMimA+SSmShWCywv5rG
         t3Xb118KH4gb5CRm5jFkMruTteFWPfVYGVIOYTqKxQY+roGdKC8J48bgqVa1jfW5SjU0
         PPwyjWFXozEmpGTXG0nKwSY9dwFZcg/ZLDQ8z8zC8bb6515Ih6rStsf1hbgfc+6wbYnq
         WEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QjfFY/OgIV2Gq1iaCR8mujssWmLmAVBwpISbG6CnAFc=;
        b=nAOL0rVJHzyxJyj5BWbUCTvfOPxMkpPnk7LbDvE/dStDctNuFti+Py0+/gI3bHOkCO
         FTbdiorwT+V67TuBGHmdD4qtI0WoJoe32nF6YVOaC5gQnb5c48cXkBaPk6oOc0Rlxlc6
         YPoj9b1pXIJTJKbpQD1uQJsQZJ+oZZkMy8X1Ve6mxO62Tcc9uM3xJ5M+xj4oNXwzU2/U
         6MKcmB1n4LYeBCHmfySq/M45YKkEUmabMBRRRgzFkHgj/XY4TVmRQtfm/hv3UECoeHWk
         NX018BQhfoKpGI5VBKPfTBVAEb2dJKyyAZlh6J6KKhll5IRQswAnH1UuVewQCA5u+FxC
         D1gw==
X-Gm-Message-State: ALQs6tCnLT73r0pFjulg2BMnSrAxo3hcwRKjEmP1Hctjgru7DVmhUkb7
        nwjRejGW906ohjxMaHURD3A=
X-Google-Smtp-Source: AIpwx48LgT+MdM/lfKz3I+zVOwzf/gwOZ0/R5STLQMSfibj/VLcyD8218owPHMe2J59PYe5QRJqmkQ==
X-Received: by 10.28.184.76 with SMTP id i73mr375699wmf.114.1523931306954;
        Mon, 16 Apr 2018 19:15:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 4sm5652800wrz.58.2018.04.16.19.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 19:15:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, tiago@gitlab.com,
        christian.couder@gmail.com, sbeller@google.com
Subject: Re: [PATCH v3] bisect: create 'bisect_flags' parameter in find_bisection()
References: <20180415085841.1269-1-haraldnordgren@gmail.com>
        <20180415134925.6203-1-haraldnordgren@gmail.com>
Date:   Tue, 17 Apr 2018 11:15:04 +0900
In-Reply-To: <20180415134925.6203-1-haraldnordgren@gmail.com> (Harald
        Nordgren's message of "Sun, 15 Apr 2018 15:49:25 +0200")
Message-ID: <xmqq1sfewpcn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Make it possible to implement bisecting only on first parents or on
> merge commits by passing flags to find_bisection(), instead of just
> a 'find_all' boolean.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>
> Notes:
>     Updating commit message

Looks like a reasonable preparatory step *if* we want to later be
able to pass other options down the same callchain.  It would be
nice to have the second step that this praparatory step is meant to
help as a follow-up (or 2/2 of a two-patch series, where this one is
1/2) not in too distant future.
