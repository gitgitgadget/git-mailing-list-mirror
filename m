Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89CC41F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbfIWS7W (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:59:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41918 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733182AbfIWS7P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:59:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so15176165wrw.8
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oD5+hjSNO5iE99+G2wym9QLK6FpjPEYeEdJumX5TTNM=;
        b=QMJ0//gdIF5cnTp1olSOrG/df31Ivr+2X1XPEDWyRcJc0KExIwrH9rR7THhqeEY3+R
         vi1lcA0g0tFoWCEnLTON2ivQvwZhRKJZnE3GL2ABcpZe3Ec6yfKNv4gJu8AUWixiJFff
         Rf3/Hdm306FbrhQj5UhcTPWgx//22ZxXAZZGoqydmTBXecqfBeimjG/h+nWNMD8Dj3+2
         P9tw49pzMmEiowRIEJzJLNXA5KaG3oK4iPL6MXMkRUrcGIcC2SqELqgBkxagVx2Hq2xV
         wIXFfnV88SZmTS2wAEN2AfQuAKuOnpbO/MfM27EpQaBcW9hULAb3582y2evU+773HcwD
         /gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oD5+hjSNO5iE99+G2wym9QLK6FpjPEYeEdJumX5TTNM=;
        b=nnOmiZMU//3kXA0oab19X6I65PVaLaY9V2ULQFKpaLExf6hj15bRXl8X3ecuo/HWzd
         vecssrO2xCNtG6qG3CY9vVDhT9ORqcnQGIlr4BZCTWStF4ZcNkFHB7ncnzTb5sqFQDlU
         8cC3OvRxRvG/Mx/F2c+g3pcPMkoWkhwLP1/009eh0bwLqMXzb2H1AWTYLyY5DNor/qql
         egLgh3DyVb5x6f/Dr9/bNen6swpTdeKtug7OzwyQxPy00AkDXmvc/baWr6kP4oXHut9q
         ZOdAeKpEDTeBU5Arr6I4LgdnujFGNXxvIilcJON6At9cDMyEjKZO3hfjUZXo9MP2GW5u
         UoCg==
X-Gm-Message-State: APjAAAU75PgRQHFUDnQlS2BlvtAOf0cZTEoO0kV3eHcIOT+/1QYmMSuU
        aNdJBVuq1oEAF2SdJxysnQxbDs9o
X-Google-Smtp-Source: APXvYqwS5zh7VyyAlLR3f+bI184wDlszYN+Fo5Bupiy2RMJMN0a6Wcg9QR/b/67hJhrRHZuqzOE0Hw==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr635846wru.89.1569265151443;
        Mon, 23 Sep 2019 11:59:11 -0700 (PDT)
Received: from szeder.dev (x4db53381.dyn.telefonica.de. [77.181.51.129])
        by smtp.gmail.com with ESMTPSA id 189sm25114935wma.6.2019.09.23.11.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:59:10 -0700 (PDT)
Date:   Mon, 23 Sep 2019 20:59:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
Message-ID: <20190923185908.GB2637@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev>
 <20190920181407.GB26402@szeder.dev>
 <20190921095718.GA23203@szeder.dev>
 <a507bbd1-88cf-6668-908e-92978fb77930@web.de>
 <20190922190511.GB10866@szeder.dev>
 <822d19dc-5202-b67f-5c0c-e5c69a679237@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <822d19dc-5202-b67f-5c0c-e5c69a679237@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 08:43:11PM +0200, René Scharfe wrote:
> > It's overall memory usage, the avarage of five runs of:
> >
> >   /usr/bin/time --format='%M' ~/src/git/git name-rev --all
> >
> >> And how much is that in absolute terms?
> >
> > git:     29801 ->  28514
> > linux:  317018 -> 332218
> > gcc:    106462 -> 114140
> > gecko:  315448 -> 344486
> > webkit:  55847 ->  62780
> > llvm:   112867 -> 134384
> 
> I only have the first two handy, and I get numbers like this with
> master:
> 
> git, lots of branches with long names: 3075476
> git, local clone, single branch:       1349016
> linux, single branch:                  1520468
> 
> O_o

I have commit graph present and enabled.  Without that I get approx.
the same memory usage in my linux repo as you did (along with much
longer runtime).

Will have to clarify this in the commit messages that talk about
runtime and memory usage.

