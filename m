Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C43C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C2023109
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbhASXBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbhASXBL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:01:11 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6324C061793
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:00:22 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id e15so15031205qte.9
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d6sIwKZE9/su5PDY1fTYUs2/WHnAMM3Gw+1Cqvp/Iqc=;
        b=jBJHTm2odpv4HDroBj2v7UEqA/xZU1Jo3RmJd0SXTJmH0/7YcN8Ak4cGAu9EKQkMxm
         hp4GP+DnBqN3LyNHMlNKN1V0acI3BkM3kOnHiXjguwHVFrlyU/P2G6QSrnKTsQDI7hoM
         iOn/G+F6nV47AUrG4iJSMHv/cPPxU633l+aruRj2yDLv2aDbEXLouYqI+US06d09szTL
         pr9Lir9HcAxzjsxbv3rwcTiaR+sHWjYjeUwwdWMSWj+e0waJj4oCsOiOsMUnYL6pQhca
         HQ9AjB/wasNRM42A5FJJnNfh8C4haoq8HLn+QA05amWKHxmwe6kszBNihFHmiQsZbKvy
         4RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6sIwKZE9/su5PDY1fTYUs2/WHnAMM3Gw+1Cqvp/Iqc=;
        b=KkxVmXaP6L98ErtX9z5eULrmO9CFUV6wFzZ+G0t5k3W67EMDN/Y9+VzRGYuJ9U1Gs9
         BgNdsoxFcRYA1qWOP94yDJEMS3w11A3zJD4UFqiRl5SrjFSuPtyTDOjia5/5vMLmUNK+
         4g23MdjvYmRm4eTJtY8CXlDIw9flPX0bhV/ehe+8dn2O4yDNGVmdejtiUJdwP6b1JHCw
         GBV2mxzdHCO+H1nFgD5TBvUOHFsjeR6nauxvntUvpxkHal3HZq0gWakyaMYdVL9+EnVj
         SzRYoU9BVilaY4DLedZM6KIMDvQS5JDPCsphvSdSk0QpYsgOOHsvRwI6nr01QmgixAOe
         H+FQ==
X-Gm-Message-State: AOAM532s4H73E5HSdpRmKwiZX9dPJLJU17V300qIH6u3891ETDaKQz72
        a4r6rvi6qXCT8sRJyqDr8bEUOGTZXG4Big==
X-Google-Smtp-Source: ABdhPJzsflWQ3P/Nlz70Ut4YZ2wXNC3jPT0+nBenqJ9EEr5MFUCH/y42Ni2hxym/YfHzsW9vA5tPKw==
X-Received: by 2002:ac8:6987:: with SMTP id o7mr6331383qtq.295.1611097222138;
        Tue, 19 Jan 2021 15:00:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id t27sm38335qtb.20.2021.01.19.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:00:21 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:00:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Message-ID: <YAdkg7ZijzfB8eMc@nand.local>
References: <20210119144251.27924-1-jacob@gitlab.com>
 <20210119144251.27924-2-jacob@gitlab.com>
 <YAdjBC7z2eE1Z0uk@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAdjBC7z2eE1Z0uk@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 05:53:56PM -0500, Jeff King wrote:
> Thanks for posting this. I have a vague recollection that we considered
> this either when we did the for-each-ref prefixes, or when we added
> ls-refs prefixes, but I can't seem to find either. At any rate, at
> GitHub we haven't generally found it to be a problem because our
> horrifically-large repos tend to be aggregated alternates repos, not the
> ones people serve upload-pack out of (though I did just time it, and
> some of our largest repos should save a few hundred milliseconds per
> advertisement, which is certainly not nothing).

Great on all counts!

> > This commit also fixes a bug in ls-refs.c that was not triggered
> > before: we were using a strvec set to zero, which is not how you are
> > supposed to initialize a strvec. We now call strvec_init after zeroing.
>
> Good catch. It didn't matter until now because nobody relied on having a
> NULL entry when no prefix had been added (instead, they always iterated
> over prefixes->nr). IMHO that is worth fixing as a separate commit.

Yeah. Even after calling it out as such myself, I promptly forgot it
when preparing the first patch I sent back to Jacob!

I didn't pull it out into its own patch, and rather folded it in to my
2/2. It has a small call-out of its own, but if you'd prefer it by
itself, I'm happy to resubmit it with that change included.

> -Peff

Thanks,
Taylor
