Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65401F404
	for <e@80x24.org>; Sat,  7 Apr 2018 01:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeDGBAH (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 21:00:07 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:41953 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeDGBAG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 21:00:06 -0400
Received: by mail-pl0-f45.google.com with SMTP id bj1-v6so1623550plb.8
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mt6DEggJjRHBuqiHvzvwWCY7qWH5Kv5zyPTcFqrzUok=;
        b=Q0VGuystCyjPU6ffjYsWjRKVBY0vT0woPV8XGgV6aEwHJSOTRITZ3GinQNu/bKdn5/
         bW5WkVaBF1yeVDUqs6nNJ4ZOdTqwGtQAoypb2prXS0xpOLT6fNppe/64+ncT7oAuYOoz
         olJTqgEBfs6owmF+VrNanr5ar6wvANNchv/QLgu6vJ44SLvntQtRgW9tRWg7qno0DoSR
         j3x7MUcWCY5hmThvCub3+7Gx6TqgrUN9mO2dG08cD455SD1MvwrQ8pqMl5KwSTIdIXmu
         WPX2gJj1Bt4GRAAnkOMlHB+/MnBtL87A5sElrPPWXhqAC+pviG0EGF8yCCMmAmacl5ah
         RtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mt6DEggJjRHBuqiHvzvwWCY7qWH5Kv5zyPTcFqrzUok=;
        b=isNN+JXIvmhrxqdrWJSz3EMxBSqqXRdtNjKeHQNj7UXNsrGwX8T96QrYVZCYtPsLBU
         2lJyEN7HcfKOujfViN8/nzSnBQbcX08rWgIQHzhqATSdHlam1dgGMZPVAQVos9gPxpyQ
         fGbkqsffW+hMl3QXT5V9nXHmXQo2MJrLC1jHqrMIEvaku+6XHKgNofzbSVPOGfCYPdG8
         ebk29jMt4kWktI/qd2SNdZcGONRh1xG364Hu4ZnMbOWszJp2IY5mCMhnwh+1FnlamMxt
         RmTv+ABupKom4aVlKBqejg+OIP9vXErXwHtgKLSIAJZLjKa4KQR8R/DUU0s1WJUygk7G
         qARw==
X-Gm-Message-State: AElRT7ENuYlQQPvn6TcSkwGDIv1lMygCdhN56OpVeWEOLVmsJ5lmEKLh
        9x/fz9eeiJxzt8Q2rQwpocS6kg==
X-Google-Smtp-Source: AIpwx4/pb/oPdeAa5Iam1+VDXmOz83KXNpoWXgxp7JNMweLieL2WVJPk7X/hJrOtrKZWCAXEgX38sA==
X-Received: by 2002:a17:902:8a94:: with SMTP id p20-v6mr29365306plo.94.1523062805660;
        Fri, 06 Apr 2018 18:00:05 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec81:e7e6:a4ca:eef6])
        by smtp.gmail.com with ESMTPSA id n7sm19690645pff.58.2018.04.06.18.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 18:00:04 -0700 (PDT)
Date:   Fri, 6 Apr 2018 18:00:03 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180407010003.GE78042@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522992443.git.me@ttaylorr.com>
 <20180406052907.GD60769@syl.local>
 <CAPig+cSYuWReTFfnN8Wg2VGKcOk5SPHHWpTdW6yks67mkOjY0Q@mail.gmail.com>
 <20180406145517.GB25041@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406145517.GB25041@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 10:55:18AM -0400, Jeff King wrote:
> On Fri, Apr 06, 2018 at 02:14:34AM -0400, Eric Sunshine wrote:
>
> > > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > > @@ -9,13 +9,13 @@ git-config - Get and set repository or global options
> > >  SYNOPSIS
> > >  --------
> > >  [verse]
> > > -'git config' [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
> > > +'git config' [<file-option>] [--type] [--show-origin] [-z|--null] name [value [value_regex]]
> >
> > It's pretty confusing to see bare "--type" like this which makes it
> > seem as if it doesn't take an argument at all. Better would be
> > "[--type=<type>]".
>
> In the interest of brevity, I actually think it could remain "[type]".
> IMHO the synopsis should be giving a summary and does not have to
> mention every detail (as long as it is not _inaccurate_, which I agree
> that "--type" is bordering on).

I think I am OK with the "non-brevity" of "[--type=<type>]", since
"--type" alone does not make sense.

I agree that it would still be fairly clear even if that's the way that
it did end up being typeset, but I prefer the accuracy of its current
state.

That said, I am happy to bend towards any strong feelings about this
topic, but for now I will leave it as-is.


Thanks,
Taylor
