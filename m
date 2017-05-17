Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25119201A7
	for <e@80x24.org>; Wed, 17 May 2017 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbdEQRAx (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 13:00:53 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33456 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbdEQQ70 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 12:59:26 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so10334652pfh.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VGfT5FeV2bKhnkMx7PT54ZRfqAthfmhpTxxHkkpB7Iw=;
        b=rMfNpSvKEpCsV/CILnn1P77Zl2WtJ5grGpkIoyh90LAe5iGT+9wAoxMZRVDS7KXyFN
         mrRRDigcIgzzYa3bw0LdboJAymjERd8e8p4mnchxlo9xCfEwG3YB1dVHZBsZuxj7juO/
         eJVuWKNbK0IF8SKhjOBttyD5Dm9mdLOGBv+hfn9/iNQ5dtiazVuE/YlbQ9NPfRwp/zgr
         4RenfLLyKofT8m2KzcVDKWU4X+tOOvO8fSOOOSNLaZRyE3/8OYk8Ec4DTYe5gouuQFCd
         xoptaJkNGQPWgKs52C7x2G0DeetEB6TRA4KQfx08aXeptXjrC4N33/qnwX4pEuLRNdS+
         kStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VGfT5FeV2bKhnkMx7PT54ZRfqAthfmhpTxxHkkpB7Iw=;
        b=aOPAUz6iMeIshIyw8F9ZHruFw0/By6kD7iyVYpgjvSaCNJll5kE/Lro0hXEgl+PK/e
         hCao3Ps/5rig0Wb2Cy35eDpQNX+9HqIv1216ub10fTVSz4g7YScpKmT7NeLxQy5msMP4
         J6Y8pE/4jVE7xZlz3PpO9QTAaOO5aOpmOyY8ztnJdpLpq+FzfobgnPMPDSYQWX73cYII
         PD7RDB2dBEmZ0sNkHe6DKlFtIsFFaAulCsh4qVg1xWzZELU34QQsTLzniTDeDSccAW3C
         /9t6IW1eHH5OlyX2TtBsV6QeL8FI1l87fjXAYcDUoD/yhGUYVlDv/ugRaIFG1fwzB2E+
         AO0Q==
X-Gm-Message-State: AODbwcCJG+Trq4hcqfVh5CN0khjzDeIPcn0qrbAnnVeLKscNC38vwXFR
        3mbaMqjqV8d/5K5Dw7/AXlI8t1k7RqqN
X-Received: by 10.99.188.9 with SMTP id q9mr4856334pge.178.1495040365468; Wed,
 17 May 2017 09:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 09:59:24 -0700 (PDT)
In-Reply-To: <17922578c2fbec4c0b8040cb37f432f913218489.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu> <17922578c2fbec4c0b8040cb37f432f913218489.1495014840.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 09:59:24 -0700
Message-ID: <CAGZ79kYspKC=NZDp8q46KO2pGBfsAfK8A=2PRDb2O1swOLf6MQ@mail.gmail.com>
Subject: Re: [PATCH 06/23] refs: use `size_t` indexes when iterating over ref
 transaction updates
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

Now this would want to have some selling words for it?
I do not see an advantage of this patch as-is.

I mean technically we don't need a sign, so we use that extra bit
to be able to process transactions up to twice the size. But I doubt
that is the real reason. I'll read on, maybe a later patch will explain
why we do this here.

Stefan
