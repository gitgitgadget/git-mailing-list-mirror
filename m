Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A0460F4C
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhH3AoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhH3AoY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:44:24 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF3C061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:43:31 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y18so17630543ioc.1
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZqFtN7Bx4mp5QVs0F7ujpN8NQhEzI4VJdjmXq4v4biE=;
        b=BLcyTR2XayLdtqHzB7RRrWPSGsJ5XZHCF4vOzUPk76NOcVzzjlWcRYcb4Jgx8kwfJJ
         3Nber4SAm5qbe8VnbJKmcaZgOigpS2+K8K2DhHZJDBWyXEG3h51K1auxywnDJjCib1hB
         czqLaNWU/dS1EK0orHfd4r2TEWQ8xA00ZdioRPXDnfJhLh11eFNFxc/wJakH/vXf5QLb
         LL4km29kzTZeRh8f9o00Z7DH/wJNHWTpGHNwAmSa+z1ZnPtkhNpwjh4w+6pZ34thhN7s
         ndeDyzyA/smngLgCVaonl4c95VBuqSs69WOLoJhNX5iGG+eikyjX/QsFcD0mPsObkZ6P
         zw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZqFtN7Bx4mp5QVs0F7ujpN8NQhEzI4VJdjmXq4v4biE=;
        b=IwJsyAUIoMF5VA3xdHaZ9BFSVSR8c26kEwGOnD2TXd3+Bld3Gyj/e0EA1pcMCS9McP
         ZSMCVC++e0/MVcf9zT3zZqsQ5HI7vLjFKpFyrYX1oCDYxuLOnaneGhM9NAXvQIIgP3f1
         nzfWWBvkbn+uMlglzidkrsFi+O+0/UJobbVh+poV+4C/UuWvMONOeVzIre1EbSP8XPo8
         ZI6LY6O7Xf+mjvgdAe3BHu5w/hCWqSQnDBJhlqf+DvqQoBXTG6jKgb6CXXpZbGFlzntU
         neJyiFa8hkj7Cr4DFJFNaaY2Pkc/hfaYGnOfMDcZU0xo5YekG+3O3W496mdbxLJSAXJY
         e+SQ==
X-Gm-Message-State: AOAM531pBvsohiPK7Jz7dcznB0VuhF7qdA8VvSeKikvnY9hOZ/Q/dFqI
        3ju68hsqWa1x1zz7Q/0kXZltiHY2+o/6sBQ6
X-Google-Smtp-Source: ABdhPJxiAS1IWXn5wVjxB+m+rqGSbqWM1/f5xphW4iWL3sgsn9qrd41ERTmyitlgOENGQNnYZDTppw==
X-Received: by 2002:a05:6638:1905:: with SMTP id p5mr17929967jal.25.1630284210977;
        Sun, 29 Aug 2021 17:43:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d12sm6994522iow.16.2021.08.29.17.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 17:43:30 -0700 (PDT)
Date:   Sun, 29 Aug 2021 20:43:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YSwpsp/hQsPFnj+I@nand.local>
References: <xmqqr1eimtrp.fsf@gitster.g>
 <YSVjnSDaBXgXvT9W@nand.local>
 <xmqq35qymrcn.fsf@gitster.g>
 <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local>
 <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local>
 <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <xmqqfsur7otx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfsur7otx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 29, 2021 at 05:34:18PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > now or later would affect this series. Even if we just disallow
> > --object-dir pointing at a non-alternate repository, we would still have
> > the issue of having alternate chains which don't all have the same
> > object format.
>
> Exactly.  That is why I feel that it probably needs to be dealt with
> before doing anything else.  The alternate mechanism pulling in an
> object store that uses incompatible hash algo would break not just
> the multi-pack-index but probably the basic object access layer as
> well, which would be more grave problem, no?

Yeah; it does. Maybe I'm holding it wrong (and brian, cc'd, can help
me), but this is an easy way to see the problem:

  git init repo
  git init alternate

  git -C repo commit --allow-empty -m foo
  ( cd repo/.git/objects && pwd ) >alternate/.git/objects/info/alternates
  git -C alternate rev-list --objects --alternate-refs

which will produce:

    $ git rev-list --objects --alternate-refs
    warning: invalid line while parsing alternate refs: <sha256 id>

But I don't know if I quite understand your "probably needs to be dealt
with before doing anything else". I think we can proceed with this
series and deal with the alternate object-format thing separately, no?

Thanks,
Taylor
