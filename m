Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE5C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A861077
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbhITPEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbhITPE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:04:28 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF3C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:03:01 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p80so15936813iod.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/jqutGxCbF2wCRJBmX26qNp4tC5x6+nO0HFdTMd9T9E=;
        b=lg160SVDIeoxe0kTxEzvvS4AdJ4r3jDsfqM3CsbuhdNZGfYpZbPTc80dIdWTPgxKoN
         CGrqyb76WzwRahVYX0RzSWLWZjtt3VQsingKZKszekGElFmCyg9J0FoEs7EEWMaBhmJw
         FQbLosKBulBt5OUEcBAiTnZHM5Y64tLzCOKRDdFRg09ME0Rr1/1ZZK+ktc6HrZVVO0Sa
         3Jb/EjCYbpdzkHi/HFN9TzkbiD+0C8N36ffMXm0dkbBlSjWTpjRgVRGT16KurL78+jHF
         gFrIs5MsIpvt1MQrZDCdthm7wPk4hUq5/sk6oHiN0tNJBFfFhVYUGw7+DPa8cROFiTmN
         5WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/jqutGxCbF2wCRJBmX26qNp4tC5x6+nO0HFdTMd9T9E=;
        b=GIF8HnbnPOPPuPtPz0q6SGFLWsaIDLKsIBmAtfWoxzOkiQ3NVaRNr1VEAyYB2zLkcd
         As9oqLQEubeAjKDAZ7E2DL/Jr6Pe3wC3aPHb3R8e69ZoUBI3Q6+kNFnKjTi/nWZIeD1F
         H7YIPFCY4fGmh+Kof6HJwZ98mmZo+YuOjqjWPl1v3lUsCGZQ0ozmBSlsADh3gIQ6GQEY
         qF3WprMQFIiAlwMcyYDFpzo2FAuMRKE50Dtju3XsZ8PX7STihmyq02KgYIDVHDCrI1Lv
         /z6o/XgyuyErseEFUsBvt+Xvro3ZHG9baPAJ2IJIreB2dbVED6oBOGkUcddqtDIAScy8
         KEpg==
X-Gm-Message-State: AOAM530Ux/2kB+0SYvXZj3jE2R5pIBF1KWm0yL14/2CAvZdkNn+U2gpb
        FeQAWIie+wlEXMkmuACBTOvmNw==
X-Google-Smtp-Source: ABdhPJwi4gzpJMZCgBFvD0nz3JuaJB8dkkHFHrlYQB0vs9btENiHZuZcjmQyoyOKni338wgzuZmLpg==
X-Received: by 2002:a5d:9256:: with SMTP id e22mr19166311iol.152.1632150180930;
        Mon, 20 Sep 2021 08:03:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x9sm1077417ilg.76.2021.09.20.08.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:03:00 -0700 (PDT)
Date:   Mon, 20 Sep 2021 11:02:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        szeder.dev@gmail.com, avarab@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH 1/1] builtin/commit-graph.c: don't accept common
 --[no-]progress
Message-ID: <YUiiozypuNk1Qx91@nand.local>
References: <cover.1631980949.git.me@ttaylorr.com>
 <e41e65ddf77c596a7926e75bfc15f21c075d0f03.1631980949.git.me@ttaylorr.com>
 <088241fc-4070-95ea-b5eb-01c7771ee3af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <088241fc-4070-95ea-b5eb-01c7771ee3af@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 08:46:32AM -0400, Derrick Stolee wrote:
> On 9/18/2021 12:02 PM, Taylor Blau wrote:
> > Since we haven't released a version of Git that supports --[no-]progress
> > as a top-level option for `git commit-graph`, let's remove it.
>
> I agree that is the best way to respond right now. Moving it to
> top-level will need more work.

SZEDER posted a patch in [1] which would allow us to define a top-level
`--[no-]progress` option for the commit-graph builtin. (I'm assuming
that you meant the builtin when you said "top-level", and not git
itself).

But see some of his commentary above the patch in [1] about why we may
want to avoid applying something like his patch, in particular:

  In general, even when all subcommands of a git command understand a
  particular --option, that does not mean that it's a good idea to teach
  that option to that git command.  E.g. what if we later add another
  subcommand for which that --option doesn't make any sense?  And from
  the quoted discussion above it seems that teaching 'git commit-graph'
  the '--progress' option was not intentional at all.

This patch has the added advantage that we can always "go back" to
SZEDER's approach and make `--[no-]progress` work as an option to `git
commit-graph`. But doing this buys us some time to make sure that is the
approach we want to take.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20210917211337.GC2118053@szeder.dev/
