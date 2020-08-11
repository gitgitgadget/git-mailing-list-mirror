Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE8CC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A66C205CB
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYUFvVqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHKV1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHKV1X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:27:23 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0784C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:27:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w17so3114613edt.8
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yVCrWk0E+3fFtSSCH1bX+jOJFhGXsTKpd2759j/1NIY=;
        b=mYUFvVqgvzRSlYfnAENlPLJqnzm3nc5H9UiIeIvQsrlDhD8WgmH8mzFibnE782rWpT
         jHcGv/RoyBaYOl+NQJT0vn50fCQRuqZkLzSuifqdHTtsYW8ky84o/ogKB2nLuZheQGRr
         ap5sMJb6oEulx31hcjOXY88G3oXi+sFZVFgsWYtdWDmN7JK3smzYUws1RKJfcpnE5eyl
         aeHp8RxpNEdSS8w1GBjArXEtrtQn0hGZPZfN7FaM1WeuYvvEfs/1pAaeBkagBZKPC2sM
         HA5MdbdhWQi95mehWBSbITX46lhOiMW/aoZS+f4I+p6xay3zMPi+P9y1hD6teL7D/9AN
         G3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yVCrWk0E+3fFtSSCH1bX+jOJFhGXsTKpd2759j/1NIY=;
        b=JJ5YOf+tKIwTVq8Q04QY92z+a3+EvDaAl0GgUV8qx3NyP1QWr04GiBhg6Gkh6kYiJK
         5OkAeNj/zULpcxecBCDD5uBt1rdHFwWT6vS0Q7m3iIvluWqWbOtcuTvTY6vGOl06VBUT
         dbZK34THb7+LnWxGeX98b+bu2uT0Euzmc9EgaqDxmlU7qIdNzB+gEdBAXJxXBngDuoEm
         tigtEflSw2ZKmERmTq8EQDrwu+Yn7SEjBoRvXjIxBR7QLJMhx4M0vobe87ySKgc1mxg6
         NkR8cx9xPWeoYQRh3wvDVkjCA85s8CHkcqrtF//72oRrdOoe2pMKnCtZCw8Gk3hAP4bT
         VsVA==
X-Gm-Message-State: AOAM531yv3ar+BasJ98hw4Y3/VSS62b7Prn37zE5I0l1q30CSe1ArZJe
        MC1nJtThlhmnplXVhdP5s1k=
X-Google-Smtp-Source: ABdhPJx77l7cOdu9L3vLTdLkTs4l/hOjx4sBkOsjFkz1eHyyRohWIykw067Xe/3xnLV63ym0YSYfyw==
X-Received: by 2002:a05:6402:b67:: with SMTP id cb7mr28008657edb.216.1597181241201;
        Tue, 11 Aug 2020 14:27:21 -0700 (PDT)
Received: from szeder.dev (94-21-37-143.pool.digikabel.hu. [94.21.37.143])
        by smtp.gmail.com with ESMTPSA id r3sm122179ejy.95.2020.08.11.14.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:27:20 -0700 (PDT)
Date:   Tue, 11 Aug 2020 23:27:16 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 01/14] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <20200811212716.GA13422@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <e714e54240bb339d1ecebcea157b734abf1c14ef.1597178915.git.me@ttaylorr.com>
 <20200811211830.GS2898@szeder.dev>
 <20200811212118.GA66447@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811212118.GA66447@syl.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 05:21:18PM -0400, Taylor Blau wrote:
> On Tue, Aug 11, 2020 at 11:18:30PM +0200, SZEDER Gábor wrote:
> > On Tue, Aug 11, 2020 at 04:51:19PM -0400, Taylor Blau wrote:
> > > Many places in the code often need a pointer to the commit-graph's
> > > 'struct bloom_filter_settings', in which case they often take the value
> > > from the top-most commit-graph.
> > >
> > > In the non-split case, this works as expected. In the split case,
> > > however, things get a little tricky. Not all layers in a chain of
> > > incremental commit-graphs are required to themselves have Bloom data,
> > > and so whether or not some part of the code uses Bloom filters depends
> > > entirely on whether or not the top-most level of the commit-graph chain
> > > has Bloom filters.
> > >
> > > This has been the behavior since Bloom filters were introduced, and has
> > > been codified into the tests since a759bfa9ee (t4216: add end to end
> > > tests for git log with Bloom filters, 2020-04-06). In fact, t4216.130
> > > requires that Bloom filters are not used in exactly the case described
> > > earlier.
> > >
> > > There is no reason that this needs to be the case, since it is perfectly
> > > valid for commits in an earlier layer to have Bloom filters when commits
> > > in a newer layer do not.
> > >
> > > Since Bloom settings are guaranteed to be the same for any layer in a
> > > chain that has Bloom data,
> >
> > Is it?  Where is that guaranteed?
> 
> There is no mechanism whatsoever to customize these settings that is
> exposed to the user (except for the undocumented 'GIT_TEST' environment
> variables).

Let me rephrase it, then: where is it written in the commit-graph
format specification that these must be the same in all layers?

Nowhere.

> > > it is sufficient to traverse the
> > > '->base_graph' pointer until either (1) a non-null 'struct
> > > bloom_filter_settings *' is found, or (2) until we are at the root of
> > > the commit-graph chain.
> > >
> > > Introduce a 'get_bloom_filter_settings()' function that does just this,
> > > and use it instead of purely dereferencing the top-most graph's
> > > '->bloom_filter_settings' pointer.
> > >
> > > While we're at it, add an additional test in t5324 to guard against code
> > > in the commit-graph writing machinery that doesn't correctly handle a
> > > NULL 'struct bloom_filter *'.
> > >
> > > Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> > > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Thanks,
> Taylor
