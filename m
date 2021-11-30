Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFFFC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 00:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhK3AIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 19:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhK3AIL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 19:08:11 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C89C061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:04:53 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z8so9174422ilu.7
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sq43Ybqkq/t10mDQ+5AMHGrByNkZDa/wpbDtuNSxGTQ=;
        b=uAkx9H2HX+PK7vcEPTA543CJ8axE4uikfL0YWC2FiPCXosKtJ3ouwTE8v5KQ8z3zZm
         1dHSoa1JG8VdjWI2eY3A7Pj76M72xa8tsfT+nf4lSC3cfXsHwMev6lFttbbhCJNuXkNG
         WBJUI1iZqFCHbk0cYMiPfAnI1RgbmZnWV+G7BYZTWeNMHoD1njRhqxioOuA0C63SiALh
         jBTpgg+BxiJ2ihayy1QtiJnLV1FVJ8JvPwzMOqtbWAU+gbh1fzfexd7x7nOSb+sANAts
         tGNHGBzzzzGvGf70cGtZaDr6r/ngHsF0+BOYAzzztZNsFz8ZGC+LYwTllfRmos73L51b
         tqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sq43Ybqkq/t10mDQ+5AMHGrByNkZDa/wpbDtuNSxGTQ=;
        b=7dBEoZG8JsgdtBKkyMajZd/5SA/jLNMl09TvPhzoaRMPVKR0yBJFjuIePle1Z4HDlZ
         7F2Hbz87RHvApt2N89SQryP4Nkl3/B20WNHTOzAWg42usYGgIurhGGolp6TIs/yFi6+h
         4Fn06OGp4UVB2vGQ13hWhFY4A2YrEO6FqU1OpxnKx7QNCV+kxmwvIB+wAmKfrQxVYbca
         NQsKKfjcTp3fYsVGen4O6KoxHPWPd4zbaocOICFU/yX6+lxt2pTQtrL2VcPu1n8hFhLA
         mpCn1qCjg1Xrg7fooT+vRzeTYoBDMrbT37EKmQ7N/auArNbh5sZmnwckDKrHagL6qdDs
         XeVA==
X-Gm-Message-State: AOAM533LXnfdh4Vu5qvv9NuCK5POOiwr5Dz7QfxsCeOG/rBi8kfmPogo
        Ai9AIqmTG6Mcb7wjcMogPMotsw==
X-Google-Smtp-Source: ABdhPJxSvygaHyKHy90mncTARJy4+ilBobzKm4hIpVAOtlSPPeK+ieDeehSd6JtpceU1QLRiOI0MPQ==
X-Received: by 2002:a05:6e02:12e2:: with SMTP id l2mr60590327iln.251.1638230692975;
        Mon, 29 Nov 2021 16:04:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q12sm9722888ile.77.2021.11.29.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:04:52 -0800 (PST)
Date:   Mon, 29 Nov 2021 19:04:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/2] Set GIT_TRACE2_EVENT_NESTING in test-lib.sh
Message-ID: <YaVqo476kVKtT1Rg@nand.local>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <YaUegEGxfAf72O9Z@coredump.intra.peff.net>
 <YaUfq88UwWVcb7KG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YaUfq88UwWVcb7KG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 01:44:59PM -0500, Jeff King wrote:
> On Mon, Nov 29, 2021 at 01:40:00PM -0500, Jeff King wrote:
>
> > On Mon, Nov 29, 2021 at 01:47:44PM +0000, Derrick Stolee via GitGitGadget wrote:
> >
> > > As reported by Ævar [1] and diagnosed by Peff in a reply, the default
> > > GIT_TRACE2_EVENT_NESTING is set so low that tests that look for trace2
> > > events can start failing due to an added trace2 region. This can even be
> > > subtle, including the fact that the progress API adds trace2 regions when in
> > > use (which can depend on the verbose output of a test script).
> >
> > I think this is a good change for fixing the immediate problem of the
> > test suite failing.
> >
> > But I have to wonder if this is masking a problem that real users will
> > see. Aren't we silently discarding trace2 output that could be useful to
> > somebody debugging or trying to get performance metrics?
> >
> > I.e., should we be bumping the internal nesting max of 2 to something
> > higher? If that would that cause problems with existing metrics, should
> > we be designing new metrics to avoid nesting?
>
> One thing I should have added to the first paragraph: the patches
> themselves look fine and I'm OK with this as a band-aid in the short
> term.

Yeah, I agree. This test in particular must have bad luck, because I
noticed the same failure in GitHub's fork when merging with 2.33 (but
due to some custom trace2 regions causing us to blow past the limit even
without `-v`).

It might be nice to allow setting 'GIT_TRACE2_EVENT_NESTING=false' or
something similar, but let's deal with that elsewhere.

hanks,
Taylor
