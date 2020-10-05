Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51CFC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB232078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA7ICv8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJEIeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEIeo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:34:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0FEC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:34:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so6369140pfd.5
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MEJ0Jl25lE9QMAMbWVTKMIxup+Ibh0tii0X5vGQjYKI=;
        b=FA7ICv8PIao4CUCFO2IxJyGE+eLtyodQoHwx2eipOcxHuZcE/mNGKmHagTKfNsbMey
         aDEtQgvPerS69mPODjkpR42c4vA34gPiQjyzgzJUsU00QjjkIEK92yTDRix5G9Q8ieNr
         QIGu5Hq+L9Zdz5h3ltSGOR41QbpZDQpjHqhwzX7ttC20tyMmWotLk61EjMigyUvBZCBJ
         DNwhkTjTGqOpFjNaRKNWTH8SowY/OhkXJ4RMdThYpKn85/Sfxi4Nulwa1HkopXKOo3u8
         /jC365M6pHMrA+/bGqsNhGCLCQYPExwpVkj8pLUKP0tr+cjXeISgcRhAZ0yb30chN4OE
         8ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MEJ0Jl25lE9QMAMbWVTKMIxup+Ibh0tii0X5vGQjYKI=;
        b=jIYDe5gXES8rOfOvv9oyi2/UwhHhdRsAtHeNy/aauxlmzJ3e2UeGncGUzSo25KMj1z
         QDbX8rBCI1haPU4fSolucfcawThLamytthTFA4Hjx8DLeUT2YolAzaOZ7CtCGXQtrf/w
         1/C8X29WcZgC+Wb0sg02LxOV1faZQzXfTzV0/JKb+E3nwtoqXksfH2redoMiLjvG0ODj
         O5tLykeBgG9gwXJ8e/Labhy4GZl2dlMiY/MSOD1fie3q8kWPjzPU8WOoE917/du37uQ2
         s+EAsy1sAbXvkx2fNcXAz+J7+ZwxXXa7J7WD7bmO9+lBIpuliE5azjumu0QOxAzsUB1M
         WpTQ==
X-Gm-Message-State: AOAM530gEg0y6oi9oe4a1Wm2uUmZzVokX6AJ5zvX3PmH3OYydseMa1ak
        49mi7bx0OCvWnD1xTKyACo8=
X-Google-Smtp-Source: ABdhPJwSAjjYkLuab7i0iQPE19LS4YLdrpnWNBvuh26jXnCDta3zrexu9KfyxxO5RTi+cdx+IKTrmA==
X-Received: by 2002:a05:6a00:16c7:b029:152:54b8:ee32 with SMTP id l7-20020a056a0016c7b029015254b8ee32mr9284180pfc.76.1601886883628;
        Mon, 05 Oct 2020 01:34:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x4sm11481428pfm.86.2020.10.05.01.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:34:43 -0700 (PDT)
Date:   Mon, 5 Oct 2020 01:34:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] t7415: rename to expand scope
Message-ID: <20201005083441.GL1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005071954.GC2291074@coredump.intra.peff.net>
 <20201005075020.GF1166820@google.com>
 <20201005082448.GB2862927@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005082448.GB2862927@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Oct 05, 2020 at 12:50:20AM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>>  rename t/{t7415-submodule-names.sh => t7450-bad-meta-files.sh} (95%)
>>
>> I've never heard of a "meta file" before, but I don't tend to discover
>> test scripts based on their filename anyway. :)  Thanks for updating the
>> test_description.
>
> I couldn't think of a better name for "files that start with .git". I
> almost called it "dot-git", but then I worried about confusion with the
> actual ".git" directory.

t7450-dot-gitfoo-files.sh seems clear to me.

[...]
> In practice, I doubt it matters that much. We don't tend to run the test
> suite serially in order these days anyway, so the notion that finding a
> bug in an early test might save you CPU time or time spent reading error
> messages likely no longer applies.

I see --- the point here is that because it's using e.g. "git clone
--recurse-submodules", we want it to be later than the other clone
tests?

I think I'd like us to move away from having the numbers at all some
day (since collisions are very common), but there's probably not much
to discuss there until one of us comes up with a proposal that still
makes it easy to do things like "skip all git-svn tests". :)

Jonathan
