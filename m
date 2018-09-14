Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6332D1F42B
	for <e@80x24.org>; Fri, 14 Sep 2018 05:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeINKwh (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 06:52:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46793 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeINKwh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 06:52:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so3822782pga.13
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rf4v5dYrGK/AqpRN+I0pB80QrevYCSrug8EiXLqzGSY=;
        b=rrikwy6YiYnDHmJ1aDKyubhzAErOrqhMQFVzqRTx2kEHM2VNVz4eUW7ZLEd7wUhwYs
         s2SqxAmXpH0U45xIUmYudCmme4wqsA7+FC9Uega56QihAGSURT/15WeSdMT3pOmuDTK6
         CZeIXFMQzVefCl9IVKFgw3ECzWodtSV0lO+TpWDBEQuRbu6sOoXawdk2lmI3TLF9mA8J
         gxQWMo4JLSbWBsFhGks0V0xLhmX3564LeWCXiKYUL4JOmk7cEKLUpl308aY1657lNpPQ
         B5p7NEtRtRriH0VzDAnoTLuInLRDkWpykD1owsGljIWq4JQJ8X/xk9GG4opNm7N0V3MC
         Q3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rf4v5dYrGK/AqpRN+I0pB80QrevYCSrug8EiXLqzGSY=;
        b=alKbzq3XBXKCh3kh7ngW3BQO2oR9/AjtCWMjpZi2OYhzfKlzE+59R29rlVj3hgeKgl
         cNdDoBlG6KWkc//QWh2wnSlxrLIQBwWRDbF9jC3V+vKGoh7SVtJrqCUjhpmgSbTiqqk1
         GZJHclmXlsXA+rQ+EJhsG8KtS7onHJK7ST2w4M1QDWo1vZZXDfT/oWB7COc6rEjWsO3a
         HvPFbKESX7aSxoHZM6oAMFShySe8JfXustGufdJHj1gxr0VUUnx6Tytpp6UKCb6BiTxb
         5lX9lWexur5NDjrO4yZRngSdlTygAtfH0G+F56u4UocTS9TROtnjelbebhtOiTWniH6C
         B7aw==
X-Gm-Message-State: APzg51BF3Dy92PRi+A502NcwpzOga/+ZTEG92/PoyPbzXDs9MCJ67bQI
        6dqMd4WbpiLXm6/ZVSzjnM9f6Nb8
X-Google-Smtp-Source: ANB0Vdbp2IZl39kXtSs5gBqFhyeDDtMgdxejqyaW7S22vBipzYM4IfXLr/yzo+rW+K0K6dUXLQMuAA==
X-Received: by 2002:a63:10c:: with SMTP id 12-v6mr9919595pgb.62.1536903588146;
        Thu, 13 Sep 2018 22:39:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f13-v6sm6426527pgs.92.2018.09.13.22.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 22:39:47 -0700 (PDT)
Date:   Thu, 13 Sep 2018 22:39:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 2/3] archive: implement protocol v2 archive command
Message-ID: <20180914053944.GB219147@aiede.svl.corp.google.com>
References: <20180912053519.31085-1-steadmon@google.com>
 <20180912053519.31085-3-steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912053519.31085-3-steadmon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Josh Steadmon wrote:

> This adds a new archive command for protocol v2. The command expects
> arguments in the form "argument X" which are passed unmodified to
> git-upload-archive--writer.
>
> This command works over the file://, Git, and SSH transports. HTTP
> support will be added in a separate patch.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/archive.c        | 45 +++++++++++++++++++++++++++-------------
>  builtin/upload-archive.c | 44 ++++++++++++++++++++++++++++++++++++---
>  t/t5000-tar-tree.sh      |  5 +++++
>  3 files changed, 77 insertions(+), 17 deletions(-)

I like the diffstat. :)

Can this include some docs in Documentation/technical/ as well, to
help other implementors to understand the protocol so they can
interoperate?

Thanks,
Jonathan
