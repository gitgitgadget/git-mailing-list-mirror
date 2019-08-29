Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979001F461
	for <e@80x24.org>; Thu, 29 Aug 2019 23:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfH2Xs3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 19:48:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34437 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfH2Xs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 19:48:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so3134939wmc.1
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 16:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duBOFMQsctv54D9Q67wR+4osDj8PzCFu/p+w0PU9PS0=;
        b=FaB5Xnsz2wfw1bHMo3Rq84WOvpOZOk8SVeS2AAR/Iw9CG6dpmegPktkAi4S/2Bym6D
         9n9LkuEFcXm8QlMwAyA89q5wpDTyCL2/SrH96VAo4MEMF06N5fs687WKOMwnqOjQ3enL
         3dtn0A3Anxkm9ZZ6DrarpAdGEninODO7JfpqlwVUTIn31FAqdfX+3cnsOHurX9y/poRI
         VzZUCkw6Q3C+udfxq6rLVV9JSCep+tTUjyIj020xS3IRxuh4pdHnwAgUfKuaVJdPzrOn
         UGvORq4ggmOS95DKa26XPmKgkHbdOijiF0kHWLIKmc4Du1nov2VrkPYxdHmgqHOHvLzC
         2WRQ==
X-Gm-Message-State: APjAAAVtFzx5GHgBA8WNxycRKWTgb8X966JefWfNkfRJE7R8kDGT+dov
        nL6lH344mO3wd9uwA2URsWJBCXnTSBj17rPyjUCUsg==
X-Google-Smtp-Source: APXvYqxEX7/2orDz9SnrHURIwa807yPuxNehDk/HtlcUUUoe/kCKXxAj5ILG4fv6/NskXmBBmvRt5UIePFywXUXT9gM=
X-Received: by 2002:a05:600c:2245:: with SMTP id a5mr6919695wmm.53.1567122507444;
 Thu, 29 Aug 2019 16:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190829223811.12072-1-jon@jonsimons.org> <20190829223811.12072-2-jon@jonsimons.org>
 <CAPig+cQDPsXvOYa3HYo_cYeVq4PhJE_2RGw9n+92=t3BA0-yaw@mail.gmail.com> <d8f1b891-4ff7-9815-2405-76e53506027c@jonsimons.org>
In-Reply-To: <d8f1b891-4ff7-9815-2405-76e53506027c@jonsimons.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Aug 2019 19:48:15 -0400
Message-ID: <CAPig+cTUEY9Z7KBqXXcvrjBzRVQJ6pJUi72BrevquN1xfvwZag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] list-objects-filter: only parse sparse OID when 'have_git_dir'
To:     Jon Simons <jon@jonsimons.org>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 7:12 PM Jon Simons <jon@jonsimons.org> wrote:
> On 8/29/19 3:45 PM, Eric Sunshine wrote:
> > On Thu, Aug 29, 2019 at 6:38 PM Jon Simons <jon@jonsimons.org> wrote:
> >> +       test_write_lines /* >sparse-src/all-files &&
> >
> > Hmm, does this work correctly? I would expect the /* to expand to all
> > names at the root of your filesystem, which isn't what you want. You
> > want the literal string "/*", which means you should quote it (with
> > double quotes inside the test body). [...]
>
> Oof, thanks -- yes, this is incorrect.  I will revert this back to
> 'echo'.  I misapplied your initial suggesttion to all three lines.

Curious. Did the test still pass even with the unquoted "/*"? If so,
does that indicate a flaw in the test or somewhere else?
