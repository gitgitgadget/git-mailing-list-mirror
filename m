Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A44202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 22:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbdIVWtu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 18:49:50 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:46930 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbdIVWtt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 18:49:49 -0400
Received: by mail-pg0-f54.google.com with SMTP id i130so1300737pgc.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 15:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yrDlySkNtSv/MG1VFF3qTGl8gUDmNflcg9yotPWdu8k=;
        b=hWbSca8U//LqLM1zi45rNTC8TYdrGvODxNxoGKTcbeSF1h12kzJ/I9nZVoETzK2wH4
         ghCT+9Xowv90Fw/95QeSrTccD8T8YypqfkNIB0Ep5eB30FklUsZuiad/0K3f5J8kEhlM
         WL7sj91QnvvJOc86bHWdbKbaIp8TrbF1zdPFC/8lNHiPkIVY/WmsocXZvLZVlhU7OynK
         aSzWGK1gRwuhFypdeh6uNKWphNKnFgI+BH8K14D7vd0sAU9Co/o9lm6iFyryOWp2YFPG
         FZ9AJJc0rCHFxKBoQDrPNvFT7snSxuLbRBPaMd7EIgypHV+9QqEv+QwUUaifT9jHsBrc
         78Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrDlySkNtSv/MG1VFF3qTGl8gUDmNflcg9yotPWdu8k=;
        b=bE0vEwu2jE/er1SK3I1RHNhwJ7xv8FhwOtbI5EilE6GftqEAzwQhHNbdYkOxb5HgtZ
         omCy4YhJlJVvaM0247N/ZJmzMlm4KPCi266UwwMfp5gngIGdcH7I6Hf6F59lE9oexpBw
         DsvKWa0yaeXFiSxsDv2INeoPebo6kNTy6Mb2Nii+pG12y6ac3epRj8vYQOMyl2f+tv5c
         D+q1BN5dt6DNcytBUXJQIAhRWFtom9fS2o3MqHt+rGCi37mewvuR8rmxHhyuUGR7Er10
         9COxQOFmtj4nOsnlqPHDKfx40oubEEkn+bzgA+yjbP7EaIJuiKZsohubYyBVQ00PRsAi
         VAUg==
X-Gm-Message-State: AHPjjUippxmzy5RbCI+wSD12mtfXRE+X62q/6lffBkXHqXmEVg3dgxxA
        qWBup7TlkqHCwExnnze95jVfEB7cV+M=
X-Google-Smtp-Source: AOwi7QCwNPPbIC1YUHIfUsngJMOD60ZW49h8tsuY/TH+Aw6Ey8CornyxjpKc0BcCdchwmXdUSbebaA==
X-Received: by 10.99.136.73 with SMTP id l70mr528083pgd.185.1506120588790;
        Fri, 22 Sep 2017 15:49:48 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:840f:cadd:b54e:2e8c])
        by smtp.gmail.com with ESMTPSA id x4sm953127pfb.101.2017.09.22.15.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2017 15:49:47 -0700 (PDT)
Date:   Fri, 22 Sep 2017 15:49:46 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: Design and code of partial clones (now, missing commits
 and trees OK)
Message-Id: <20170922154946.5052732a061155a3f81ae2a0@google.com>
In-Reply-To: <af084ada-4607-53e8-c6bb-f5bf13bdc153@jeffhostetler.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
        <e6259d03-e904-8c57-73b0-2434939fba71@jeffhostetler.com>
        <20170921154214.0d2ac45f@twelve2.svl.corp.google.com>
        <af084ada-4607-53e8-c6bb-f5bf13bdc153@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Sep 2017 17:02:11 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> > I was struggling a bit with the terminology, true.
> > 
> > Right now I'm thinking of:
> >   - promisor remote (as you defined)
> >   - promisor packfile (as you defined)
> >   - promisor object is an object known to belong to the promisor (whether
> >     because we have it in a promisor packfile or because it is referenced
> >     by an object in a promisor packfile)
> > 
> > This might eliminate "promise(d)", and thus eliminate the confusion
> > between "promised" and "promisor", but I haven't done an exhaustive
> > search.
> > 
> 
> maybe just call the "promised" ones "missing".

They are not the same, though - "missing" usually just means that the
local repo does not have it, without regard to whether another repo has
it.

> >> I guess it depends on how many missing-objects you expect the client
> >> to have. My concern here is that we're limiting the design to the
> >> "occasional" big file problem, rather than the more general scale
> >> problem.
> > 
> > Do you have a specific situation in mind?
> > 
> 
> I have would like to be able do sparse-enlistments in the Windows
> source tree. (3.5M files at HEAD.)  Most developers only need a small
> feature area (a device driver or file system or whatever) and not the
> whole tree.  A typical Windows developer may have only 30-50K files
> populated.  If we can synchronize on a sparse-checkout spec and use
> that for both the checkout and the clone/fetch, then we can bulk fetch
> the blobs that they'll actually need.  GVFS can hydrate the files as
> they touch them, but I can use this to pre-fetch the needed blobs in
> bulk, rather than faulting and fetching them one-by-one.
> 
> So, my usage may have >95% of the ODB be missing blobs.  Contrast that
> with the occasional large blob / LFS usage where you may have <5% of
> the ODB as large objects (by count of OIDs not disk usage).

I don't think the current design precludes a more intelligent bulk
fetching (e.g. being allowed to specify a "want" tree and several "have"
trees, although we will have to figure out a design for that, including
how to select the "have" trees to inform the server about).

In the meantime, yes, this will be more useful for occasional large blob
repos, and (if/when the hook support is added) a GVFS situation where
the missing objects are available network-topologically close by.
