Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1504DC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5A96113B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhINRWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINRWS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:22:18 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E127C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:21:01 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b10so18143114ioq.9
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ogTkgCR8TQLdSWV5bZgicW0tjHbs8EFISPaAGZpXpRY=;
        b=YAIbakGj1afa5Cdh1Kmq3lJaFMymxGKGgO8WWKgZOINXK969vCXouGfSudF2SNRUx6
         uOsA7zR0RG+j8esxF0lHrRuQG7TKPoyHEzhkfzcDfJTftbNPKzssx78XqEegPnygw63b
         j71031hOvINgv77ypOERBYm8Hm/MunVJedhEATbPB1uhZSAEmWT28rm5CqwpfisHHUh4
         maKshRUZuhv/TlYrjYGco5ZSZmdCD5hJa6d5l1k+WCOon7PL7joQWAUhyt3r9PxziTBD
         Nr2Q5d/4aPcP7KtbymnB0R/Oaevt4PnVIgWue2xI7v3oyyEhNCpgYbXy/0PXAYxlJq8y
         5aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ogTkgCR8TQLdSWV5bZgicW0tjHbs8EFISPaAGZpXpRY=;
        b=r7KdlbKZaZu7InEa4jZ/5G9da5404yJuZ1SXxUUYzgpHgr7GvmugePv3OmoKFaWUOH
         Cn24QadHPYpk3yt+PNbDUiTRike1L4CzLLUYv+8lzCLIi+RC/MhwAxNrK0kI1MLeQbNV
         HzeAnBXkv0OFfWRI/KDWwJInzXKM3NM4AYrkG2WwmvbP24yaO3oR0U3XIJ3fD952D/Jq
         y3O1PtLM7sfUK9TgeEhYkAIXv19stnsuTl1yIhexsgNNxykRikrG8ogiDp0374cMlB8M
         Gk35UAK2BHKvr2J+kBwqfIWpiXn5QoaBVfOjWo3mUxpccPvJqji+pomu//5ulPFHhzBM
         jPrA==
X-Gm-Message-State: AOAM531IvxzNfkdZsKMM2HkT22UOlhMqdkKtzZltaeFsMPq50Mgg11B/
        Qal6Ti4bvQ6ySWzDrg5RATVPTg==
X-Google-Smtp-Source: ABdhPJzpnBU7sSpW21Du+EFaHJhkoUz1JwCFZZ+NAFqrcXXIX16wsjCTxnAfrDaqFedfIgiFdmKL5g==
X-Received: by 2002:a6b:ce17:: with SMTP id p23mr14660563iob.90.1631640060924;
        Tue, 14 Sep 2021 10:21:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g8sm6905798ild.31.2021.09.14.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:21:00 -0700 (PDT)
Date:   Tue, 14 Sep 2021 13:21:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 8/9] serve: reject bogus v2 "command=ls-refs=foo"
Message-ID: <YUDZ/HZAti2OVVX6@nand.local>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDBsdTeX8myV1vY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDBsdTeX8myV1vY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 11:37:21AM -0400, Jeff King wrote:
> This isn't really hurting anything, but the request does violate the
> spec. Let's tighten it up to prevent any surprising behavior.

Yeah. I seriously doubt that anybody is relying on this obviously broken
behavior, and it's definitely a spec violation. So I have no trouble
rejecting 'command=ls-refs=foo' over the wire.

Thanks,
Taylor
