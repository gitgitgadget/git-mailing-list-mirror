Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB32C0015E
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 00:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjG0ARZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 20:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjG0ARX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 20:17:23 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF11AD
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 17:17:22 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-583d63ca1e9so4178097b3.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 17:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690417042; x=1691021842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEy62s/r4DLactdBXf5y8rw1nOmsdLND0FlqvG51VuQ=;
        b=njMdhdqqlFIa0jUJmuoaiQRlp/1ppTxEvqiRGyA+0qHhAxuqbC9lQ56WtEIYZ+aWMP
         CcHeQHdIM162JBdvzWekGv07bPD97T0mE3XbXuA65MkF3NFWpSPFwsf6xhk4izlo1od9
         CL+bbEv1m1p98xcuDvRsk2KlRwMOg7C2fNwq6jpamMu7E/qcTnBRxU4JVA0EJHiQiSVU
         mLBAbM98UWdAhEMumUH/pqWVyHttOaiGU6cGwYlW3iChuA6MFEpE6SUjQa509amKadyF
         FiQ+vcP6mHHMyD9TqvscqOonlWrMA3pDvSW/azsZsmKkt27dWVm5rsowDraUs7w+hljY
         smug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690417042; x=1691021842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEy62s/r4DLactdBXf5y8rw1nOmsdLND0FlqvG51VuQ=;
        b=bl+EaNlsVDlUlcWS2odHtTtoYIzT1q6nXDh5Ok95dUaE1GI8fawyl4MI/6/3aRPOyY
         mFvtAF9TXQp4T6XywIieNNaEgIi4ikLeaZylrZme/jT2JspusJaca54MMPg80TOWvi8D
         PKrUSd5tOk7/e0lMn4EP2u8zaaldsbQw26cPJZYXgteZCntM5VzbZjGTW7lhFvqZDGnz
         oSML/QJ+MOJMf7xSkBPfrSUtaOiP1PqPH/sXSVhOdJq3zX+HjCWi4+ge66+td75mCd9X
         DS9ohk8dMma9bbKNwCZXLtVCBCXK74ypSkUAqJkqVtveXl5b/WlyB4XgE8+QrMbxMatO
         Cc5A==
X-Gm-Message-State: ABy/qLYiXGNMtcWHbeLA/5yTGmXiy5D4WGSgHmZYhgH9p+t36cBlFLCv
        yGE1dQp7mCmcHz7303Q7ZjDb5g==
X-Google-Smtp-Source: APBJJlFwlRtB2H40iZaQ5SzM8jzElfVv1KgfJSvgp6DhXuGNHWrGqB5wozHo2vAUGF1qGhiSHC3GTA==
X-Received: by 2002:a81:7c46:0:b0:583:f658:5dd with SMTP id x67-20020a817c46000000b00583f65805ddmr3534586ywc.40.1690417041953;
        Wed, 26 Jul 2023 17:17:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h123-20020a0df781000000b00583f8f41cb8sm114301ywf.63.2023.07.26.17.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 17:17:21 -0700 (PDT)
Date:   Wed, 26 Jul 2023 20:17:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
Message-ID: <ZMG3kEO0BzKPaG75@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1689889382.git.jonathantanmy@google.com>
 <xmqq8rb2csr1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rb2csr1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2023 at 01:39:14PM -0700, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > Jonathan Tan (4):
> >   gitformat-commit-graph: describe version 2 of BDAT
> >   t4216: test changed path filters with high bit paths
> >   repo-settings: introduce commitgraph.changedPathsVersion
> >   commit-graph: new filter ver. that fixes murmur3
> >
> > Taylor Blau (3):
> >   t/helper/test-read-graph.c: extract `dump_graph_info()`
> >   bloom.h: make `load_bloom_filter_from_graph()` public
> >   t/helper/test-read-graph: implement `bloom-filters` mode
>
> After a week, nobody seems to have found anything worth saying about
> these patches.  Does the design, especially the migration story, now
> look sensible to everybody?  I was contemplating to mark the topic
> for 'next' after reading them myself once more.

Sorry for not getting to this sooner. I didn't notice anything during my
review, but I think there may be a bug here.

Suppose that we have an existing commit-graph with v1 Bloom filters. If
we then try to rewrite that commit-graph using v2 Bloom filters, we
*should* attempt to recompute the filter from scratch. But AFAICT, that
isn't what happens.

Here's my test setup:

    test_expect_success 'test' '
      test_commit base &&
      git repack -d &&

      git -c commitGraph.changedPathVersion=1 commit-graph write --changed-paths &&
      debug git -c commitGraph.changedPathVersion=2 commit-graph write --changed-paths
    '

if you attach a debugger to the second process, and break inside of
get_or_compute_bloom_filter() when compute_if_not_present is set, you'll
see that Git will pass along the existing *v1* Bloom filter, and then
write its contents to the new commit-graph:

    (gdb) b get_or_compute_bloom_filter if compute_if_not_present
    Breakpoint 1 at 0x14340f: file bloom.c, line 260.
    (gdb) r
    Starting program: /home/ttaylorr/src/git/git -c commitGraph.changedPathVersion=2 commit-graph write --changed-paths
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

    Breakpoint 1, get_or_compute_bloom_filter (r=0x5555559bdc80 <the_repo>, c=0x5555559c8ef0,
        compute_if_not_present=1, settings=0x5555559c6950, computed=0x7fffffffd854) at bloom.c:260
    260		if (computed)
    (gdb) until 271
    get_or_compute_bloom_filter (r=0x5555559bdc80 <the_repo>, c=0x5555559c8ef0, compute_if_not_present=1,
        settings=0x5555559c6950, computed=0x7fffffffd854) at bloom.c:271
    271				load_bloom_filter_from_graph(r->objects->commit_graph,
    (gdb) p *filter
    $2 = {data = 0x0, len = 0}
    (gdb) n
    275		if (filter->data && filter->len)
    (gdb) p *filter
    $3 = {data = 0x7ffff7fc24a8 "\210\210\322a\267\234\214s}\004J\265\313\201\241\032e\312\034", len = 2}

If I'm parsing this all correctly, Git used the v1 filter corresponding
to that commit, and did not recompute a new one.

I think that this could lead to incorrect results if you use this to
masquerade a v1 Bloom filter as a v2 one. Since they use different
implementations (one correct, one not) of murmur3, that opens us up to
false negatives, at which point all bets are off.

So I think we want to be more careful about when we load the existing
Bloom data or not. I think we probably want to load it in all cases, but
only read it when we have compatible Bloom settings. That should stop us
from exhibiting this kind of bug, but it also gives us a handle on
existing Bloom data if we wanted to copy forward existing results where
we can.

If all of this tracks, I think that there is a gap in our test coverage
that didn't catch this earlier.

Thanks,
Taylor
