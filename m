Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D649E1F42D
	for <e@80x24.org>; Thu, 31 May 2018 00:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932593AbeEaAnR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 20:43:17 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38534 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeEaAnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 20:43:16 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so6068123pgf.5
        for <git@vger.kernel.org>; Wed, 30 May 2018 17:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lKxjv51HYz80p8cOyd0YFm2Z/u8SP7vj5N3unDFvi8k=;
        b=dWrPu/kgrF0zxsUvoFfHvteRxXrD5vNEl09S77X+S8agyrqtlovZykKIpx5uQTVVkz
         fgPt63Su9oormsMDuNWgXPmmdf8TVxxgWFg/zYpHMESfJ6+YwsDY3pICKU99mhqcyOTk
         DTSL6xBmw2gWTg4k+R7LjQtCtp82o++SwieAmcuDUDzhZnxwCM3JYWvbGPYGPKHDcPlW
         5MPmWgW1YsnlrQSN2ThLVZmcyjI+ASScWMgezqaMObdBiqMZGYAA3eZVrKvpuaabfEJ9
         PzSwkKvZrIia48m0115Re50UuzSeNU1sMz4J5sFRnWuMpd85Tjk/SZ1ILzU0SSvs4d7G
         cwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lKxjv51HYz80p8cOyd0YFm2Z/u8SP7vj5N3unDFvi8k=;
        b=PI2eOBvqnnjoShpJVAbncbTyxJFNKWAAFsrOjW93SFdBfWiAAzfg6HLkl3pg/I45PG
         BYJaeck1EprZL5AXxS+X/E43rXiixY+t5TgO8RJ8Vm2wLCA5uzZhAhqNXdPI2gh8XUsT
         DUJFz4dRlwzphdAmJm+i0cMoKcctGVJMFXQs4LkNeuBbfYPBh4crYN9aEQGZKSIF1eok
         7Eyi7fuoCg+ci+6WJgw4Nbx/O77eZCR1FrjOY1Anzr+KltvrKrpYgFbuN9i/Fbwxv5wn
         BMEf75ASIIhQp7LkE+NC/nzQrA3jkXiZJUeSNamE967GX7VMBgHnWG34KW5O9Vg4PIyp
         BcZg==
X-Gm-Message-State: ALKqPwdclmacLlYjlnaCGdYCf74hJxGdDkH26rQfbVGyTtl0d4gn30WR
        UWAqRchIeS4KBRNNonmLhx0=
X-Google-Smtp-Source: ADUXVKKb2y80p1k4DnUvExajrdsLxa9z5Mxw56lJAzE70yNyQSyHtA/R4kN06ToYF2PJJkrrmAviFw==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr4796112pfi.100.1527727396134;
        Wed, 30 May 2018 17:43:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e25-v6sm69559877pfn.88.2018.05.30.17.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 17:43:15 -0700 (PDT)
Date:   Wed, 30 May 2018 17:43:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] refspec: consolidate ref-prefix generation logic
Message-ID: <20180531004309.GA36515@aiede.svl.corp.google.com>
References: <20180516225823.235426-1-bmwill@google.com>
 <20180516234822.182663-1-bmwill@google.com>
 <20180516234822.182663-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516234822.182663-2-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> When using protocol v2 a client constructs a list of ref-prefixes which
> are sent across the wire so that the server can do server-side filtering
> of the ref-advertisement.  The logic that does this exists for both
> fetch and push (even though no push support for v2 currently exists yet)
> and is roughly the same so lets consolidate this logic and make it
> general enough that it can be used for both the push and fetch cases.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/fetch.c | 13 +------------
>  refspec.c       | 29 +++++++++++++++++++++++++++++
>  refspec.h       |  4 ++++
>  transport.c     | 21 +--------------------
>  4 files changed, 35 insertions(+), 32 deletions(-)

I assume this is meant to be a refactoring with no functional change.
Alas, it's causing fetch-by-SHA-1 to fail for me:

 $ rm -fr /tmp/r
 $ git init /tmp/r
 Initialized empty Git repository in /tmp/r/.git/
 $ bin-wrappers/git -C /tmp/r -c protocol.version=2 fetch \
	https://kernel.googlesource.com/pub/scm/git/git \
	6373cb598e1a4e0340583ad75d5abba01ff79774
 fatal: no matching remote head

The parent commit succeeds.

Known issue?

Thanks,
Jonathan
