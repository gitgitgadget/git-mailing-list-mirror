Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EBF01F609
	for <e@80x24.org>; Fri, 24 May 2019 09:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390074AbfEXJ30 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:29:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39441 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389724AbfEXJ3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:29:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id e2so476187wrv.6
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DrAc2sVgu90k9vJa0AMmv9ckOe5TpWrXOVUKaqzWhAc=;
        b=n+3fth66lyupvKQPdnzOtlUt6cfzW4+nazoINdjTBr4uPl5cvR+2gruHinPrAAR0sF
         c22rXzdq68gfQAAH0ctitN35o24JVKxZxSmr5C3e0/yQfqFn4kQI3XB3SoGVlAjPTujd
         vLu0WGe4F9A1A0hGzd7eUkrYkoDgQqCR86ywrRGUn2jEXv2fN/K64EqJ0Uf18Dry9xRE
         YUnQu5ujkzWqfq0R0pV9nQJcBt+Slt+pwKFMFDv2XfZrUzcvUq0t1yD7IHKsK8Q7bygO
         paKzDWG5ge6XGV/0G61hCGTPY08wasuQ8TW3Hmb8aLa7whcIgzddvHx8NIThaTccMgrD
         W9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DrAc2sVgu90k9vJa0AMmv9ckOe5TpWrXOVUKaqzWhAc=;
        b=gaoHXcRuBhnm4g1HWgpeNFyTtKyxjyPSmR2KhGoEUMc40UvD2xJC221yN1q0L7Z507
         Rh538eGXlz0DFKX+UhFZeq2HptmCmsIUxG2NFvDGXBC4sihiZJCJ6UHnkSfknTC2K56x
         UEDZvYU1kjw1lsz8iBJF94ZDQzEvXZAaVf7YA3UYty7yIJQbf/JYxDxcT/hJbXXiK0Mb
         +hd6f5F8NPyp0jr5L8pS1w3JH5ek3GXffDjoJvCxtVJQm74+9FNdhNbffwmygVBIyG7j
         JBxJhu1wSmgN0mivefHTYR29DyOXQfaMzmUthvpovojS9wvRPyclPYI3Fq3Hbmcmx1IG
         0W4Q==
X-Gm-Message-State: APjAAAWQsPXZRiTC12gJSA1epBJiCWVRD9C0zMA/sgy0OK1GxQi0xv8N
        LuoYhBTSFgpXOlYcr159pWc=
X-Google-Smtp-Source: APXvYqyi8lIwKnG4xSMKBvU5lVVeWvt43NS3wUZTe5ctJ9TGhT2PB1BJyCUVz3orooBszuZCG1ddQQ==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr4528014wrp.67.1558690163984;
        Fri, 24 May 2019 02:29:23 -0700 (PDT)
Received: from szeder.dev (x4db30b59.dyn.telefonica.de. [77.179.11.89])
        by smtp.gmail.com with ESMTPSA id k63sm2536824wmf.35.2019.05.24.02.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:29:23 -0700 (PDT)
Date:   Fri, 24 May 2019 11:29:20 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190524092920.GD951@szeder.dev>
References: <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <20190523113031.GA17448@sigill.intra.peff.net>
 <87tvdlt1jp.fsf@evledraar.gmail.com>
 <20190524072724.GH25694@sigill.intra.peff.net>
 <87r28offs6.fsf@evledraar.gmail.com>
 <20190524082605.GB9082@sigill.intra.peff.net>
 <87pno8fcp8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pno8fcp8.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 11:01:39AM +0200, Ævar Arnfjörð Bjarmason wrote:
> I don't think it's a performance problem to have an old commit-graph
> lying around. But if you turn on the commit-graph, run gc a bunch, then
> turn it off in config we'll have it lying around forever, even if you do
> subsequent gc's.
> 
> So I think we should delete such things on the general principle that
> the end-state of a gc's shouldn't be the accumulation of the values of
> past configuration options if we can help it.
> 
> Maybe that screws over other users who did a "commit-graph write"
> without setting gc.writeCommitGraph, but I think the only sane thing to
> do is to make "gc" fully 'own' such things if its turned on at all.

Note that there is 'core.commitGraph' as well; as long as it's
enabled, no commit-graph files should be deleted.

