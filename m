Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804FF20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 08:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeLNIgZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 03:36:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33465 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNIgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 03:36:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so2394180pgu.0
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 00:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zn+GZYCpAhUgDOgNIratLU+Dx7hMsgETaY7m2TfdniE=;
        b=hlOi37EpUGDjus2YwDkerqnW7g2NLUtLfwxmZ+3Be3YBSQAnCnnstdU8gBEwqct6zT
         15eLVgONYgXdc09NdPLESWurkSOTRcoMcXpOD9uRx0qXVT6+U/I9ufMI6rgpoq3kC5k3
         D+2uNo2L6SY25L2Ph00lwkrbK5oH+BIGb31qI6J2M/C19B/mVzJ34Q9Q9ZWWJ3l8fc3y
         OqfXg+PX1osSBFhPmWRj2OAUW7b6hLr6a3KSsyaSo8TA87jDerCaF5j9XazorN/nj5gZ
         XxTz/oyJYHL1uFsnTWwEpqnErnXWkf+Vnl3deKL0Jckb3cdjUHiwBHfe0HrLmDnA5K2w
         IYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zn+GZYCpAhUgDOgNIratLU+Dx7hMsgETaY7m2TfdniE=;
        b=Jea5Et8UtrQ8yiAn4ZUrLgvz6EyykVe92xpVWrbBrzD5l+C4HNMsvSDkbtwUjGmuBy
         Hu2s0gYsaMjifP9JfIeNtqQMZcIVSj54JDE5nReWR7/3zcL0cailrqdcn4yJ4DEjBz8h
         sw8OhmMvHHEcmaVokXi/ul5vsgcLNe4/h2rWwIcQ2/AooJJ0/DXfjSqs1fQCMT0oKQkf
         sxB52lfpKNf/LoOwDxFCJk30a3I+O0KEftftFOPgG8Dq2Qr93klBdjzCVzKQmIyZR8mo
         njgg6bTlcRoJ6YeW1uLV/Zgf+aVLETs4+yyFTvnDqNFoQXfuHE1J2SeVIRomflnkZzR0
         LlEQ==
X-Gm-Message-State: AA+aEWbgfO2RtdsWwnRcBK9I7Y70U7l6QDpDRJT1km3Zds8FTvIeHJSf
        omCYIt1DH0Hl7XBlMUOrj+Y=
X-Google-Smtp-Source: AFSGD/UQYIjoLIGj72Zc/S/0m2nIQyyUXxQFRk+ZUB3iN9ktv41P9vhgosY8ZQUxjPQ1cXeZtj+6+A==
X-Received: by 2002:a62:c683:: with SMTP id x3mr1979749pfk.10.1544776584436;
        Fri, 14 Dec 2018 00:36:24 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r130sm9549891pfr.48.2018.12.14.00.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 00:36:23 -0800 (PST)
Date:   Fri, 14 Dec 2018 00:36:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual
 commands
Message-ID: <20181214083621.GA7121@google.com>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <20181211104342.GA7233@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211104342.GA7233@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> In protocol v2, instead of just running "upload-pack", we have a generic
> "serve" loop which runs command requests from the client. What used to
> be "upload-pack" is now generally split into two operations: "ls-refs"
> and "fetch". The latter knows it must respect uploadpack.* config, but
> the former is not actually specific to a fetch operation (we do not yet
> do v2 receive-pack, but eventually we may, and ls-refs would support
> both operations).

I think I'm missing something.  Why wouldn't "ls-refs for push" not pass
the information that it's for push as part of the *body* of the ls-refs
request?

(That's a separate issue from whether we need to have ls-refs for push
at all, as opposed to specifying a policy for the requested ref
updates and getting a list of "have"s without ref names attached.  But
that's a discussion for another day.)

Is there some other more immediate motivation for this patch?  In the
spirit of YAGNI, I would rather understand that motivation instead of
one that in many possible designs would never materialize.

Thanks,
Jonathan
