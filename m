Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE511F42D
	for <e@80x24.org>; Sat, 19 May 2018 06:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbeESGzt (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 02:55:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43648 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESGzt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 02:55:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id n18-v6so17012142lfh.10
        for <git@vger.kernel.org>; Fri, 18 May 2018 23:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8sZqrwoz8ej4YN2u7cye36eOGbsw3GIgO0LgR5XXS5A=;
        b=MpmAHYun80tCvOGowYnhhVRAW+utX9/rgLplA0Fz3wql2bDw1JBEjN47fNztOAdbaj
         o5biaa8S29FTktqhhuEYE+joddKj8+zF7VuvG61dgPR6k7VeUiu7DFJUFV98jqFg0qkY
         KsK0da2rg6/uWqmdBPXMZFggKwcn4JePrJf3ASfiok7crs0oHRIJpf/TW+0ZlJUEegKD
         elH9BVMpo19mdxn82PjxeOAIQj8Al8npY2/QZ2FAmTEuiVhPU7SSqBPVNIM7Fc35qr8U
         TT3UVjhqP4AtogNtTMe2Q3leD68vymE4Np3mBhVVJ4isvlnTwewJ1ZWtpl6CjYfs8CZf
         Qqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8sZqrwoz8ej4YN2u7cye36eOGbsw3GIgO0LgR5XXS5A=;
        b=ZuIpLRO+B3lGRGFUpyWpUPyKWQ7z1deFR6lA7ZL6eFZD/Hi1xyrrrwp/mVhQHYIOV+
         aEl8PNBQIAx65J1t5GBsbqut3XBTJ2smVQV8wEpV0LD4Aa/GJiuBP+HrmL1nUYYsq3GE
         3fjEPgTLoisErIU2Ey1zXbzyoig7vBjowv5fMmdo6uD/mBTPrepzxpXNqCvqTQkXTAco
         5vabNd7CmVpuD3xzRxGwdmgOyKGz5zffGniIjLP1dsU2KoapjBObGdkBIpbZeIGYNg8G
         qUGA/t6GHWF+ZbutFOLZAgu08C/p0WlvF/NPwI3X/AeKGp1fByNTXI9anPp6CmlmUwgK
         L/Yw==
X-Gm-Message-State: ALKqPwcnX0FjsBvDqjtTTh+r0tpTFWk4Z3tBM1eMGEfys+xIlfwK6PQb
        IUNd8vpYrRcXM0XtymghDWQ=
X-Google-Smtp-Source: AB8JxZp/F7rouEBlL93UzK7EOg3/cQCZ5xT3MB7UGCKJuaGFpUa5Y89rCzNFwaCp1Jjbj+wTYrARew==
X-Received: by 2002:a19:5348:: with SMTP id h69-v6mr23759025lfb.26.1526712947817;
        Fri, 18 May 2018 23:55:47 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f70-v6sm2258505lfi.2.2018.05.18.23.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 23:55:47 -0700 (PDT)
Date:   Sat, 19 May 2018 08:55:45 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, ao2@ao2.it,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 11/11] read_cache: convert most calls to
 repo_read_index_or_die
Message-ID: <20180519065545.GC14755@duynguyen.home>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
 <20180516222118.233868-12-sbeller@google.com>
 <20180516222733.GB60301@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516222733.GB60301@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 03:27:33PM -0700, Brandon Williams wrote:
> Maybe we can kill read_cache() while at it?

I took this out of context. But with the move to repo_* stuff,
eventually these macros around the_index should die. Not today though.
--
Duy
