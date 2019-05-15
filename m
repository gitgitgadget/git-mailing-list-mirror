Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9BD1F4B6
	for <e@80x24.org>; Wed, 15 May 2019 01:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEOBZB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:25:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38474 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEOBZB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:25:01 -0400
Received: by mail-io1-f66.google.com with SMTP id x24so878594ion.5
        for <git@vger.kernel.org>; Tue, 14 May 2019 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMg3Sd0lTyvawp5I1IUh6NVTHG+bFrGxXek8NgAKiLM=;
        b=PSvoVATj6ndUvGbFzLDgfnVY5JoGqg4Rt8bRy9e32P0r307qeeNuYvdP55JCzUIjiM
         v98j5FIlqwoZp29be2SuKjxQL1hUSP/g5Hqsz0PCQrzshQOa0mxVfDkxpBRE/4jb7Kev
         5gBp2XbwbRfkMd8t1dJGQyTFNBA27eMokRYahUTtQekwPlghbQ2dUH9+KswlY3lrlTS8
         +ju0AjH37EmADEE97Zu+6ytWXcANBif/oyK2axpee1g0o32u7GCmAYrXK91TBXhKc4a7
         TnKp0IU+2nhmb/oHKBNkof2OkUMXSDF5F4t2TvcS5ZO1TuK1b5BW2iOZSyU0PvKCS0uC
         Qe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMg3Sd0lTyvawp5I1IUh6NVTHG+bFrGxXek8NgAKiLM=;
        b=LLupOsGKH1Qf9+taerfVakLNsVzW/uNdgbFJrX6FgVrUk1+ooZZvAHyd5iACJ2UYrf
         HTsnWafTrMIZf4HxItZu/zjYadf09u59E13yuihlzFqNiVSIRz8geRM9J838TL2NFwbf
         EiC15C2iLJab57KKNMxLzKcIj5CSE2NrPsU4eUbVOZTaCcAC9IANGCx4H8xZ2luYM3O3
         No9rbJ0m76OVr0JSM+HBzw2Q6yxdTeT8TgTFjKmlILd0XViR2xa/gcdcXbsBowsPPrEl
         yiuyAqSB62Q2a6BsL30CNTlJ8nL28/S7altdYk5d3B3ObNukbfU4AGSbqjMWMI+fd7M0
         y32w==
X-Gm-Message-State: APjAAAU8AdD9oEhLnCf7/NjKfoqZ4Nuri8XCM5PdkZJlZHCeR2sM+7R8
        NDop5Ue52CYXa+Oj/Cgf6J9f1j4blm98/UB7LCk=
X-Google-Smtp-Source: APXvYqwfZhqpaLqK3ikhDz5ejb2lcQ9PVmuZsu0a7w65IGTYDgMqNxrvhWg936nwGhxV+6GuOgeRJY+f1f4hxdygaNg=
X-Received: by 2002:a6b:8e84:: with SMTP id q126mr3514035iod.118.1557883500326;
 Tue, 14 May 2019 18:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190511205711.tdclwrdixaau75zv@dcvr> <20190511223120.GA25224@sigill.intra.peff.net>
 <20190511230204.GA18474@sigill.intra.peff.net> <20190514135455.GA17927@sigill.intra.peff.net>
In-Reply-To: <20190514135455.GA17927@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 May 2019 08:24:34 +0700
Message-ID: <CACsJy8AvsyOz2G1zjRjpKYVZ0DLKj02-v=hXJHS0BRHnxoeWAw@mail.gmail.com>
Subject: Re: [PATCH] get_oid: handle NULL repo->index
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, Antonio Ospite <ao2@ao2.it>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 8:54 PM Jeff King <peff@peff.net> wrote:
> diff --git a/sha1-name.c b/sha1-name.c
> index 775a73d8ad..455e9fb1ea 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1837,7 +1837,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>                 if (flags & GET_OID_RECORD_PATH)
>                         oc->path = xstrdup(cp);
>
> -               if (!repo->index->cache)
> +               if (!repo->index || !repo->index->cache)
>                         repo_read_index(repo);

We could even drop the "if" and call repo_read_index()
unconditionally. If the index is already read, it will be no-op
(forcing a reread has always been discard_index(); read_index();)

Thanks for catching this by the way. I'll need to go through all
the_index conversion to see if I left similar traps like this.
-- 
Duy
