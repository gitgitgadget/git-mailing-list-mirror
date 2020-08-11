Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F18C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 23:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9630B20575
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 23:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI79jLu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgHKXzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHKXzl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 19:55:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7647CC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 16:55:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f12so340235wru.13
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 16:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jdFvqLV/ur0RKkbmJGqD+cIUf8bX4uStV9ePjIhJ4Jw=;
        b=ZI79jLu7GQ1TbzCDHNn3Q+fExlFJOprVEZAWjYUOTdN0rr7xj7N9yQxIP0YyYUrT9d
         /dJ/72XrI2CYbpJIjdCfBHcItlM2Xkw9sL4btyptmrBEkz/yabnAkri7qFsAht4vUmpx
         FyK/vwR14rm9tDCb+hh+03ObmAFbHCqaUYwVtGVJ3PlJbnNwkH/QIXxVUQs7SH1exZsS
         2QSeCdMKb2CGLAErc1Z+lfeQ+fAMFwAv8o8doy+zZ3lpbiEFcBIPaludMXWfrffjMloi
         WNaNcw7Ti84znDurIhdB/+kgNxgS5VZ1J9NO2/9x617rxaPxapwa9yLRvK+/zS0LtQPc
         SI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jdFvqLV/ur0RKkbmJGqD+cIUf8bX4uStV9ePjIhJ4Jw=;
        b=Q7/t4hCN5P6k3OwmkmXlhg3rQTowZ1psV3DWUVyJxG/saT4OCVoE1qsj60ENDzkMCd
         +J2vrA/OM+X81p3jEBhX3hE1tO0faP+9NorjeGxRCevS8vI5OfQ+oxFiAl2fTxFo3ziM
         p3+569cyKACbxadhZGjvYIJLHhFboXR5j8YgFPFA0h1S5TKysejHtyia7AdNqxZmSR3g
         9MHSrl4OLg73Tl11IU0OM6gxGWuuD9rCoM2F0yl+gVKY9J69eV8nawhc6toTvXRv8uS/
         1+Unyzx146jiA+9oPCqTJKKvVIFip8tGj9kwWV1EJva/IunZYALxQo0tJC1aaPh0TJTW
         scgQ==
X-Gm-Message-State: AOAM532CNFkPCCW0LiTl2blkHXbvMwLmgGBsipUtnxFU07YHVNN1S5d0
        48rvRX4ahbv29hYjAcOx3HY=
X-Google-Smtp-Source: ABdhPJzlOGnjsktno3CmvTWu5PwIvl9NTXZ8eJxNrjllcC+RrK7oqGF9IDDCWHb1MZk/NVSVqKtpJA==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr31242450wrg.7.1597190139815;
        Tue, 11 Aug 2020 16:55:39 -0700 (PDT)
Received: from szeder.dev (62-165-238-100.pool.digikabel.hu. [62.165.238.100])
        by smtp.gmail.com with ESMTPSA id 145sm680944wma.20.2020.08.11.16.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 16:55:39 -0700 (PDT)
Date:   Wed, 12 Aug 2020 01:55:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 01/14] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <20200811235537.GC13422@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <e714e54240bb339d1ecebcea157b734abf1c14ef.1597178915.git.me@ttaylorr.com>
 <20200811211830.GS2898@szeder.dev>
 <20200811212118.GA66447@syl.lan>
 <20200811212716.GA13422@szeder.dev>
 <20200811213411.GB66656@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811213411.GB66656@syl.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 05:34:11PM -0400, Taylor Blau wrote:
> On Tue, Aug 11, 2020 at 11:27:16PM +0200, SZEDER Gábor wrote:
> > On Tue, Aug 11, 2020 at 05:21:18PM -0400, Taylor Blau wrote:
> > > On Tue, Aug 11, 2020 at 11:18:30PM +0200, SZEDER Gábor wrote:
> > > > On Tue, Aug 11, 2020 at 04:51:19PM -0400, Taylor Blau wrote:
> > > > > Many places in the code often need a pointer to the commit-graph's
> > > > > 'struct bloom_filter_settings', in which case they often take the value
> > > > > from the top-most commit-graph.
> > > > >
> > > > > In the non-split case, this works as expected. In the split case,
> > > > > however, things get a little tricky. Not all layers in a chain of
> > > > > incremental commit-graphs are required to themselves have Bloom data,
> > > > > and so whether or not some part of the code uses Bloom filters depends
> > > > > entirely on whether or not the top-most level of the commit-graph chain
> > > > > has Bloom filters.
> > > > >
> > > > > This has been the behavior since Bloom filters were introduced, and has
> > > > > been codified into the tests since a759bfa9ee (t4216: add end to end
> > > > > tests for git log with Bloom filters, 2020-04-06). In fact, t4216.130
> > > > > requires that Bloom filters are not used in exactly the case described
> > > > > earlier.
> > > > >
> > > > > There is no reason that this needs to be the case, since it is perfectly
> > > > > valid for commits in an earlier layer to have Bloom filters when commits
> > > > > in a newer layer do not.
> > > > >
> > > > > Since Bloom settings are guaranteed to be the same for any layer in a
> > > > > chain that has Bloom data,
> > > >
> > > > Is it?  Where is that guaranteed?
> > >
> > > There is no mechanism whatsoever to customize these settings that is
> > > exposed to the user (except for the undocumented 'GIT_TEST' environment
> > > variables).
> >
> > Let me rephrase it, then: where is it written in the commit-graph
> > format specification that these must be the same in all layers?
> >
> > Nowhere.
> 
> OK. We can certainly document that this is the case.

IMO we absolutely must document this first; ideally it should have
been carefully considered and documented right from the start.

Some thougths about this:

  https://public-inbox.org/git/20200619140230.GB22200@szeder.dev/

> For this purpose,
> all we really care about is that the graph _has_ Bloom filters anywhere.
> If you wanted to return the exact matching settings, you could also
> provide a commit and return the settings belonging to the graph that
> contains that commit.
> 
> In the case where we don't have a commit, we could use the default
> settings instead.
> 
> I think that we are a little bit dealing with a problem that doesn't
> exist, since we do not document the sole method by which you would
> change these settings. So, maybe we can think more about this, but my
> preference would be to leave this patch alone.

Other implementations can write split commit-graphs with modified path
Bloom filters as well, and at the moment there is nothing in the specs
that tells them not to use different Bloom filter settings in
different layers.

> Maybe Stolee can chime in, too.
> 
> > > > > it is sufficient to traverse the
> > > > > '->base_graph' pointer until either (1) a non-null 'struct
> > > > > bloom_filter_settings *' is found, or (2) until we are at the root of
> > > > > the commit-graph chain.
> > > > >
> > > > > Introduce a 'get_bloom_filter_settings()' function that does just this,
> > > > > and use it instead of purely dereferencing the top-most graph's
> > > > > '->bloom_filter_settings' pointer.
> > > > >
> > > > > While we're at it, add an additional test in t5324 to guard against code
> > > > > in the commit-graph writing machinery that doesn't correctly handle a
> > > > > NULL 'struct bloom_filter *'.
> > > > >
> > > > > Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> > > > > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > > Thanks,
> > > Taylor
> Thanks,
> Taylor
