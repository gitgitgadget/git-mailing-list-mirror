Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB7120248
	for <e@80x24.org>; Sun, 14 Apr 2019 04:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbfDNEfT (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 00:35:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38091 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfDNEfT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 00:35:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so7017852pgl.5
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 21:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQzIXZlU8C9aTpb4anSBqHr6JonJxwNuyYJPdjOWqlw=;
        b=WzbOCuA1cZsTtdz3CffDcg6xgLg2SqTsPajewQN3vjAaE74sRF8imtnySGhbj99VRU
         ZQWggkPFjjfzAgyNbnF+KKBFN12gfm4Hu1YsoVYjM1T5WYPFDFk2G28+nVMt3kmK7ZCn
         6FXCuu/OZIUXsjFRqlw2797EPuVzDroXfw0Dft0i21JerwHR6jrXppSaelLdEnsQhJeI
         0OpI5rRMc8CP6/a3hAvQP0alC8e5xJLIR3n8ulZLAf6ZRd9P1OHBvPSwsnfSxBdIdNtb
         QE9uJY23AfkLwWaK6LR5HRVZ6DbcZvHPQy0LYCWrpEPezL/+c0HSoMwIG5JIpnZnzTKV
         BpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQzIXZlU8C9aTpb4anSBqHr6JonJxwNuyYJPdjOWqlw=;
        b=mwC2HLhii4WeAZ9xqYtMQAP+B9QioDnPbRXJRMAUv/QlErZSDzOM/Cm3x4oAiUXOEB
         xG493ekGBRXDf4dteR6YOdVAQDDHBhqs2pQjLwjmP1QHNv697fo/dgVrlw8qVLTWBbUL
         Q/6SB9gNmwLvvExf7k3ixK6VQsNzAKmME+0LmQx+EDJ0rFjyBMlF7tZnnm8OazYoAmLv
         dctrXAih1mVVyA1uGBx8WShSwKyNNsrhygDc/BBFMI6EHEcIBwtusiQ20BkYV4mqB6fO
         B/8mUhoD3JJeLOTWfszjfbzkwCQDlfomxqAUrYb+Ohx/Kc4u66zPHEJOxSyDIRu1u2nH
         IhzQ==
X-Gm-Message-State: APjAAAV73FpOGP7onUf4vcsF95kDpPbr1vQIQyzIgXD7Kuc8rKS7Z9y2
        PCBJF9k0s1VIJVVKDTbtmuY=
X-Google-Smtp-Source: APXvYqxJCsc4kXTXdk5ebkHEFQGMiVSD47wd3lhMR0jlI8zzf0Iobj2uCmqr4U488ndSd5bsIXhMDw==
X-Received: by 2002:a65:610a:: with SMTP id z10mr16135220pgu.23.1555216518634;
        Sat, 13 Apr 2019 21:35:18 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id m25sm61146219pfa.175.2019.04.13.21.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 21:35:17 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, rohit.ashiwal265@gmail.com
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with write_block_or_die()
Date:   Sun, 14 Apr 2019 10:04:09 +0530
Message-Id: <20190414043409.9547-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413013451.GB2040@sigill.intra.peff.net>
References: <20190413013451.GB2040@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Peff!

On 2019-04-13  1:34 UTC Jeff King <peff@peff.net> wrote:

> What is gzwrite()?
> [...]
> I think it would be less confusing if this just factored out
> write_block_or_die(), which starts as a thin wrapper and then grows the
> gzip parts in the next patch.

You are right, it might appear to someone as a bit confusing, but I feel
like, this is the right commit to put it.

> Is it OK for us to ask about the truthiness of this opaque type? That
> works if it's really a pointer behind the scenes, but it seems like it
> would be equally OK for zlib to declare it as a struct.

It would be perfectly sane on zlib's part to make gzFile a struct, and if
so happens, I'll be there to refactor the code.

Regards
Rohit

