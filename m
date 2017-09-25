Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269F420A26
	for <e@80x24.org>; Mon, 25 Sep 2017 22:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934600AbdIYWKJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:10:09 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:51783 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934366AbdIYWKI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:10:08 -0400
Received: by mail-pf0-f176.google.com with SMTP id b70so4509371pfl.8
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+N4xvdLEch/tFJjTh7n0nt/70/Jgd81sM16+PH394sc=;
        b=dXqA+PBXc69pKOoedlNEariLqwX+RqZYQ9sO+7jlCpbjfCum4k1GUNXfUDF+hZzM9i
         08CmuiHHozf4J5i6UuSzgA58bl773N06lHGFVJ/+BeZ7ujFBTUTn/b6zEXfZOuic8wYQ
         NA8R+00PdFMJEJ8Gmo8jdIjRwxi0euv5i9srsGId8hHqrfnxuZYbGS/fdWotU/LnviDM
         HHS+rriAk0Wp/dJ24ufl/YEwk3cDBeXclglz8smlZjxs6sYB7JYrKmG28spW1e9eDRqJ
         GZke/8RNPjj/is/XBal4dvIZ0+2TegSsloaDB/fRZy61Nvm+ssMru5xrf4Y6pvZ6gwWX
         weVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+N4xvdLEch/tFJjTh7n0nt/70/Jgd81sM16+PH394sc=;
        b=g4HLLjudrN2nxW+0DfJt8rtvubj0tPmgWc65qjFMmbAIjqBkyH0dEEAvcRUqfiziW5
         yBfju1eBANn4kgDcdCcoqTS1QMexHuqXZNOt2KzXaL03AhQJ/uWKgdL5OyuFzFnQ6zRF
         u2LebyCOJLEs+NP6/cRPsxvT/qsonLDoUIpyaL+gR1EKGelFFoff0nyhChCUN7NKTW3B
         NPlMNy1Ikjg423ZNPxD7qBFTwnZxPNj5UObJXpRiA2CROWdABLoKFXtlZNxfNDYHtD+7
         ZqFYO+yqaM9bBk0dg9eR6dzruLXNZYR1pQ5nXr/wiKupPzmu72g/co1enqWRDm+EFhqd
         MxQw==
X-Gm-Message-State: AHPjjUhqZD7B0LoAn/Q6AZ+d1PA3fizD+W9OprUDw4Z5JMYavIBeXvP9
        jxR8nW+lyJlrDSrMC9ZJIhs=
X-Google-Smtp-Source: AOwi7QDQkX+EUbVIQs3RMBE7772tD+8pT/Ov4rl0kj5kJd88IG336YtnEiSfzahEpYHpnyZ+OMnTcQ==
X-Received: by 10.84.232.8 with SMTP id h8mr8852310plk.62.1506377407522;
        Mon, 25 Sep 2017 15:10:07 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id 207sm13356422pfu.0.2017.09.25.15.10.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 15:10:07 -0700 (PDT)
Date:   Mon, 25 Sep 2017 15:10:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/7] get-tar-commit-id: prefer "!=" for read_in_full()
 error check
Message-ID: <20170925221005.GC27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202947.u6onp66ztliyxjcj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925202947.u6onp66ztliyxjcj@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/get-tar-commit-id.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
