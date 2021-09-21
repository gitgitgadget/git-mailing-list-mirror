Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEFEC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B613610CA
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhIUEq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 00:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhIUEqy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 00:46:54 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB78AC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 21:45:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id d11so17365003ilc.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 21:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EdcPQWIU+FqPCR1iEZVcp3od7o9Yycz8CvzKVzE8CFU=;
        b=xTnMCIgXNkQ1ym5OMrM3qF6ihvHnl29Di0vmnkkZxn38OFf6PPD2zVt9Bu/D4Vtv+O
         nun1a6zsk2opxxpP6r0FOv+kC0gIEviwi1uWMiMt+Rmhd7e72DIA1vjsr6boscfO9rUq
         KI+PBGxhthHuzPcAEBODPsFPjehwg7SbtXsJAGCXBxHNeKQQ0DonkIqUK5BQgKHXeLV1
         RolfavpY7TjJxEfom3mCNwbvXQ3Su7GgVzPqE/8yGoXVE/DS/BtuXnC/wKhVQgPemPLh
         3mhwhWlrW6CXF3y4HEVhXCo8lIm/H/zrWUhDoF0McN65GBQBvDTugttZFP3X6KA4CW5e
         1tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EdcPQWIU+FqPCR1iEZVcp3od7o9Yycz8CvzKVzE8CFU=;
        b=eA/KWndCabppyEaIyJZGoZzJrmRLAAiSjCy76R+DE0Kd0h1aP1b3EaIbgRCger9JLe
         DA/m4bowMeSGJD0TP9tm7ZamuayCkO41ifyBG1+Vad1rzctOnISz6YTE5yKrficNtxox
         7BkRJBaoMIr+OWrB0us4wZIs4W5tAlWrPqTk5SIamBKgxwqFLoLDZ1nICV2ETF35X1nT
         uVTEOUa042+3EnSN6RIs0J+9pormGbPYq2T7Pi74FTlJU+tuOGgSsns6UtJ0HIJ408YL
         YEuVsCQqr/zBQ3j07YZJe6FWrTZdjAPGmMNXTaMOMx4SLRG5LVaQLoLYDOs6RaF0j/zB
         rDvw==
X-Gm-Message-State: AOAM530oUfH0o0odcAwZCWSetBS1jZLkPjk1vWEjIzb0KsKW8hTfBdFw
        JxilGzoDkF/O0DOlDWK4t2pI0RAIC3SVuQ==
X-Google-Smtp-Source: ABdhPJz0G5liTzC0NnbB1AcTAkTwd9DGFX4KwKGXQf7F1ixCkCKAxkyFcRZgbn6K1Q0SSmwxPiTYog==
X-Received: by 2002:a92:c264:: with SMTP id h4mr11859693ild.16.1632199526301;
        Mon, 20 Sep 2021 21:45:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z25sm970133iow.48.2021.09.20.21.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 21:45:26 -0700 (PDT)
Date:   Tue, 21 Sep 2021 00:45:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 2/5] grep: stop modifying buffer in show_line()
Message-ID: <YUljZU5YpclFn56t@nand.local>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlV+RPMHGGfk25d@coredump.intra.peff.net>
 <YUleFU4QrKb28bDz@nand.local>
 <YUlinQ7hPokFLgfm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUlinQ7hPokFLgfm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 12:42:05AM -0400, Jeff King wrote:
> On Tue, Sep 21, 2021 at 12:22:45AM -0400, Taylor Blau wrote:
>
> > On Mon, Sep 20, 2021 at 11:48:09PM -0400, Jeff King wrote:
> > > When showing lines via grep (or looking for funcnames), we call
> > > show_line() on a multi-line buffer. It finds the end of line and marks
> > > it with a NUL. However, we don't need to do so, as the resulting line is
> > > only used along with its "eol" marker:
> > >
> > >  - we pass both to next_match(), which takes care to look at only the
> > >    bytes we specified
> >
> > Thinking aloud, next_match() calls match_next_pattern() which takes eol
> > as non-const and passes it to match_one_pattern(). And that calls
> > strip_timestamp(), which would be non-const, were it not the previous
> > patch. So I think this conversion is safe.
>
> To be a little nit-picky: this move would be OK even without the change
> to strip_timestamp(). The question is whether any of those sub-calls
> actually looks past the "eol" pointer we give it.

Right, I wasn't implying that this move was unsafe without the previous
patch. Just that without the previous patch, we couldn't make
show_line() take a const-pointer to eol.

Thanks,
Taylor
