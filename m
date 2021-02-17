Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34467C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF6B64E63
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhBQXo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhBQXo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 18:44:57 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2FC061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 15:44:16 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id b14so507702qkk.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 15:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lQq2khjwWHhNGf0F8ZuTf4QpHMihBDR70xyqAPP90X8=;
        b=BPQwmHwzCxrsvSo7Q+785KAo2lpKIKaTzMgR7CT1agxE3hE43xIlc+/2Lpoqun9+pA
         NQj9uItr2wVwGsb7uILxH19tkTsGWX+8KoNCi6HvtPvb9Wvn7PMH3aRJNQYbxN1pldwX
         ptVl2CocXp/qJF/v+rSmi4qTZQrw7R5za1tzXyKdE4kUlzJ8QFyDBs+aPrMXsK7gaIPt
         l3pPE9aIL1gR4vGjE+eUHZU714KIJw5R7bPAyo0sIa2Nzc+E4sOIa/nov2yIk2TlX754
         9MvADfNrcV3ilbdfkLPyKhDuxHS0uPEwYBko4pmGIYJdBzWSEqH81M11MwT0oS+OLlA4
         61bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQq2khjwWHhNGf0F8ZuTf4QpHMihBDR70xyqAPP90X8=;
        b=ZcPOUH7s6K2oA+uBGFhy7YDSqSsA+hLi1Ww2AV5wj5E0hyu9orV+eQ3SF8mbZTu4QZ
         xPX/TChIPj4t2QthkMixjp1SqHWsEf+vS5gP+jWes32VbhetUe7+XF1gLIj3/mp392pm
         viw2kDccYNUOCp0sv0SL645U+vBezprNxf7uIehlHhpYlMlbAgzJFHwzHpb5ORMXdQdf
         SniQFd+1Ea6KJ0CVmYF2bDdnxWS9xVDJy+dM8E28SLRdEZR0JB9coWzh6HFxRSYla4cU
         3pOMUNp9vyNTp5C53OA7+j6SDUHgjaa7Ij3F1wm+WA43cUguZI51sGkxNODizf5Kxq96
         JGZg==
X-Gm-Message-State: AOAM533zLCPfNnnRVF5fDVlWGF4mxL9R7Y0WPbi7F4CL4+68DdoZwKeZ
        Z53kBeE6VIYkvDodqyyS6GgPhVt65Ewz1XBu
X-Google-Smtp-Source: ABdhPJxrjQ9wfPQLu62Y2SGVTga3mxzpuSKDZQBSmDAQCli8Xp7hSDrH6hiMm0WlUKuuoNroLLjCmg==
X-Received: by 2002:a37:456:: with SMTP id 83mr1703932qke.462.1613605456128;
        Wed, 17 Feb 2021 15:44:16 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1f29:6ff9:b466:8c60])
        by smtp.gmail.com with ESMTPSA id d75sm2877951qke.23.2021.02.17.15.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 15:44:15 -0800 (PST)
Date:   Wed, 17 Feb 2021 18:44:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/2] rev-list --disk-usage example docs
Message-ID: <YC2qTedr8agOpQxy@nand.local>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
 <xmqqh7mkycno.fsf@gitster.c.googlers.com>
 <YCOu70m5SKU7L4CS@coredump.intra.peff.net>
 <xmqq1rdn51gz.fsf@gitster.c.googlers.com>
 <YCREYmBsnv2wgvXZ@coredump.intra.peff.net>
 <YCRpBCNJ2yNTbc2i@nand.local>
 <YCUOSmnsJ4LLPFgK@coredump.intra.peff.net>
 <875z2ydd4l.fsf@evledraar.gmail.com>
 <YC2nOxPP3SAY2g1I@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC2nOxPP3SAY2g1I@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 06:31:07PM -0500, Jeff King wrote:
> It's already big and scary enough that I prefer starting an EXAMPLES
> section. :)

The patches you sent below are great. I think that it's easy to nitpick
and say "oh, you should have added this or that example, too", but I
think you gave a great set of starting examples.

I'd be happy to see this merged so that others can add more examples on
top.

> By the way, there's one other finishing touch we might consider:
> enabling --use-bitmap-index automatically when bitmaps are present, for
> requests that produce the identical answer (so _not_ a regular
> traversal, because the output order and presence of pathnames are
> different there). I'd prefer to do that as a separate series, though,
> since there are multiple arguments that might benefit (like --count).

This would be really neat. I look forward to it.

Thanks,
Taylor
