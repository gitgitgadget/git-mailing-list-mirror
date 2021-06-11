Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D091C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 19:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0161E613C8
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 19:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFKTDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhFKTDu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 15:03:50 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A724C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 12:01:35 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i67so32018414qkc.4
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iL13zahX8cgf19/o4KF/lKOR2mOgcNgvUN6IagWvKC4=;
        b=lR0yyLs3EXT7s/r0RDPj5BnbbZKwxFUQoWjzmrtO69AxtxkQbm1rhbKCkEZMQhTkmO
         ezRw0ckWQIqTHqE8Gq841mfKPZvaF0BBtv43wRYC/02Z5EurVnwH7fHGTSCG8e5p/TU0
         /YB6cFH4Z8OwqgVXI77yfM+iODBAD9dJtT+/DMMR4/j2SIDovYyeCfcTWL4UJY96aP70
         kJmz9qKLiv3pV+DiQtsHhcrMKVe7D8Sjny4/hU8lt/oeA5dtE9ggeywdgWT7EbrOW/Py
         mQ4ZyMpsEpkmGRcFrl2BNDRfbX4TKe25KLcbM1MsyyXSKYaEgQzQAkWvcfKKopOW3zbA
         5j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iL13zahX8cgf19/o4KF/lKOR2mOgcNgvUN6IagWvKC4=;
        b=labkA558nMgjBmUgYVwimAGsFsCVkPujrch5Z9NxbnV8bG6ynRj9AA4qJVTldbvfpQ
         6mHJNqCY/CQGwz8jG8+86To1ZwCCJIx43E476NIVKhTy1Z0vCcQHCd5WhzJpo7OeFy3b
         3pzQ/XuwGJbxEwVC46jP69nNc7tc4rJZZk/hYHEdVY45hsN5gYUP/PGO+SHNuY8UXTmM
         QTFFmJ4vxrT4263LaffXG7Uc+woLTAu02KGua7EmKjvEiUPdOH2EwNPnDrcQiGpNiALI
         q2URJPbnywmdJr+U3njs1WHUYU3hOj3YnIAhJMCjELu15u9aUHgXddVhx16n4VHiDcjX
         SmrQ==
X-Gm-Message-State: AOAM5338yTkjHEsluLqE9fnZtcJoZ8lnt2i9POf79QdpbMbU1Sg1PGNA
        YjzSlbrKUE3d+4NgII3EWh0SIg==
X-Google-Smtp-Source: ABdhPJwro8txmeQatZOwzDNwQTm/yF9Aw7QEAhRWTYJsJeCit9zJf+hPmrQlbZtnQR17+9TLXsMqsA==
X-Received: by 2002:a37:44cc:: with SMTP id r195mr1924361qka.478.1623438094731;
        Fri, 11 Jun 2021 12:01:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e452:10d1:47e7:4140])
        by smtp.gmail.com with ESMTPSA id t187sm4935998qkc.56.2021.06.11.12.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:01:34 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:01:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: Making split commit graphs pick up new options (namely
 --changed-paths)
Message-ID: <YMOzDGOo/HbqzkPa@nand.local>
References: <871r9a2dol.fsf@evledraar.gmail.com>
 <YMJKcHpN/gL5U6KK@nand.local>
 <87mtrx1cdr.fsf@evledraar.gmail.com>
 <YMKzOgOU9lj9Nt0z@nand.local>
 <e85bb66a-d70d-1861-07ef-82a74bcce4d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e85bb66a-d70d-1861-07ef-82a74bcce4d7@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 11, 2021 at 01:47:28PM -0400, Derrick Stolee wrote:
> On 6/10/2021 8:50 PM, Taylor Blau wrote:
> > On Fri, Jun 11, 2021 at 01:56:31AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> So yeah, maybe we can just unlink() them right away, or another way to
> >> handle the race is that load_commit_graph_chain() could just try again
> >> from the beginning in such a case, and presumably picking up the fresh
> >> just-rewritten chain.
> >
> > I'd probably be in favor of the latter.
>
> I want to point out that on Windows we cannot successfully unlink()
> a layer that is currently being read by another Git process. That
> will not affect server scenarios (to the best of my knowledge) but
> is important to many end users.

Right, but isn't this already a problem today? Since the expiration
window is zero we are already effectively trying to unlink all merged
layers immediately:

  - Marking merged commit-graph layers as expired via
    mark_commit_graphs() by setting their mtime to "now", and then

  - Immediately removing all layers which have mtime older than an
    instant later in expire_commit_graphs().

(I almost suggested that a race already exists between multiple writers
that merge multiple layers of the commit-graph, but that race doesn't
exist because the commit-graph chain is written before other layers are
marked and expired.)

In any case, it seems like the return value from unlink() is
deliberately ignored in case another process is holding an expired layer
open when we try to unlink it. So we'll eventually clean up all layers
that don't belong to the commit-graph-chain, but at the granularity of
new writes.

(FWIW, I had to re-read 8d84097f96 (commit-graph: expire commit-graph
files, 2019-06-18) which mentions that a configuration variable would be
introduced to change the expiration window, but we don't have any such
configuration option. It also doesn't make any mention of handling this
problem on Windows, which made me think that the unlink() calls weren't
checking their return values by accident when in fact it was probably on
purpose.)

Thanks,
Taylor
