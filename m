Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6906CCE7A8C
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 19:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjIXT7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 15:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjIXT7L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 15:59:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D684FA
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 12:59:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so4660390a12.0
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695585543; x=1696190343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2cdCmpWkM0XQP9NjUL7mefy2yF0F/o7zwDw6/ANCXg=;
        b=jGC+LDeRKpJNg/rDkci+c75iiJwtJgOx0j981fS0RD/Z6i70VjtWuTUoWMm/Xcn9MJ
         pA7H7lpUXSaDnZ1cvHs5x7YfMhd90DqPCsmE/IX9HZsOmPE6d8QaBiyKyrEeVt+NsVnc
         KAP0FJ9WkENOZsKAdkhBeoxgJIH8n1URRMWpA1lPq4uMO18IhDbt+ehfKipNraxSWLsW
         1vcJ+be0kkjPB/swgrtWHolKXEcc4V49FmFOu28t+poPxBBvt3nU7lDOpeTx+xgdcg6L
         EZhh7xh9jeD5gPi2me+iETSOI9DAeJXKbLw8BQU7uk/EpEIxFZa+CRgaSshgTODj0fCc
         fSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695585543; x=1696190343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2cdCmpWkM0XQP9NjUL7mefy2yF0F/o7zwDw6/ANCXg=;
        b=tvXSzpug4sooFyOgaIbnK4dfghWLyPGSGQWFJiSudZSJHSgOXtHlwVytw/UE/fotnp
         0wzsNWAzHaMKl6UCPtzH9IALJT3GN2tyuzT0pLyzYs3fn/6D9lMRZ6xl0ki8yG2FANTH
         vUuOy8sjikVoz5HkJ9Krfo5bHhJWigwbN1r2vkPSa4y3/QNN1HuI7AisUGLkNL851COd
         byuOxZJOVdJ6mraPhX/cYXXl7icbgDmLSv+ZZZ/T/zA5uR/Y89EucU/tLdbJ8tx+Ij37
         fKZRvY6U+ZLF931pSU0y4GhytRTa6nMhzyredOI8ES+CahnDSlD7LOwiPUnGwSdzyj1S
         eCww==
X-Gm-Message-State: AOJu0Yzj9jAGrSaXu9koua4lAXXtlDQfUQHNGyu8gCiPKGcniud2Zhae
        IiPPRvy1lJO/lidC8YPobw0=
X-Google-Smtp-Source: AGHT+IEa9CmHLKbI6KEI+pTsO1te6zF8pk13g0+Q13kKFYtMaEFjQUndQ3OfEBc5CBV92iFYJfoQuw==
X-Received: by 2002:a05:6402:1a42:b0:523:3e27:caa7 with SMTP id bf2-20020a0564021a4200b005233e27caa7mr6665301edb.20.1695585542455;
        Sun, 24 Sep 2023 12:59:02 -0700 (PDT)
Received: from localhost (94-21-23-189.pool.digikabel.hu. [94.21.23.189])
        by smtp.gmail.com with ESMTPSA id d23-20020a056402079700b005231e1780aasm4617084edy.91.2023.09.24.12.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:59:01 -0700 (PDT)
Date:   Sun, 24 Sep 2023 21:59:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2023, #05; Fri, 15)
Message-ID: <20230924195900.GA1156862@szeder.dev>
References: <xmqqmsxmdhdw.fsf@gitster.g>
 <ZQnpIBR4hEbOLCwP@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQnpIBR4hEbOLCwP@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2023 at 02:32:00PM -0400, Taylor Blau wrote:
> > * tb/path-filter-fix (2023-08-30) 15 commits
> >  - bloom: introduce `deinit_bloom_filters()`
> >  - commit-graph: reuse existing Bloom filters where possible
> >  - object.h: fix mis-aligned flag bits table
> >  - commit-graph: drop unnecessary `graph_read_bloom_data_context`
> >  - commit-graph.c: unconditionally load Bloom filters
> >  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
> >  - bloom: prepare to discard incompatible Bloom filters
> >  - bloom: annotate filters with hash version
> >  - commit-graph: new filter ver. that fixes murmur3
> >  - repo-settings: introduce commitgraph.changedPathsVersion
> >  - t4216: test changed path filters with high bit paths
> >  - t/helper/test-read-graph: implement `bloom-filters` mode
> >  - bloom.h: make `load_bloom_filter_from_graph()` public
> >  - t/helper/test-read-graph.c: extract `dump_graph_info()`
> >  - gitformat-commit-graph: describe version 2 of BDAT
> >
> >  The Bloom filter used for path limited history traversal was broken
> >  on systems whose "char" is unsigned; update the implementation and
> >  bump the format version to 2.
> >
> >  Needs more work.
> >  cf. <20230830200218.GA5147@szeder.dev>
> >  source: <cover.1693413637.git.jonathantanmy@google.com>
> 
> I think that Jonathan's most recent round of this is ready to get merged
> up, cf. [3]. The outstanding issue you note in
> <20230830200218.GA5147@szeder.dev> can be addressed separately, I
> believe. To that end, I have a RFC-level patch proposed here [4].

Besides the issue of not reading Bloom filter for root commits, that
message of mine also includes a test demonstrating that handling split
commit graph with layers containing different versions of Bloom
filters is broken.  That test still fails with the current version of
this patch series, i.e. what is currently in seen.  Jonathan provided
a patch that makes that test pass, and also noted that that test did
pass with his original design:

  https://public-inbox.org/git/20230901205616.3572722-1-jonathantanmy@google.com/

I maintain that without test cases thoroughly covering the interaction
of different Bloom filter versions with split commit graphs this
series should not be merged.


> [3]: https://lore.kernel.org/git/xmqqo7io8gmo.fsf@gitster.g/
> [4]: https://lore.kernel.org/git/ZQnmTXUO94%2FQy8mq@nand.local/
> 
> Thanks,
> Taylor
