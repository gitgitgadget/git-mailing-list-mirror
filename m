Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C43C43333
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82FF2311F
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391742AbhALRDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391729AbhALRDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 12:03:04 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F91C061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:02:24 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id s6so1201843qvn.6
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pXcdDuiuS0rutkUwk71fnGMqxWY4G5EzmmfpZg3Ru24=;
        b=jUrEG0DUx7SLY/E/5nsmqdIJZ1Io3iiQV4Azj1VSRUQMcy6dLHHJRdNjxwt3is41/C
         3RuBNZhsH1qeHKcGi+2Z0CLFkxtjlL3lDh07h6rviCNV2VbrLquvxF5vNW5h3Mv/9A+O
         929NR4RIC3bV06c3A0i6yPfPkrb60e01ki3M1jRYRBAIUerPrxai04us/bP9q/SyPnzw
         J6w+i3m9BswF6gOWxIPRiXFzdcwKY4TcRr+m6DJxSgCmqOnZCWZcZ72q7UhtsGdVmNeR
         pTUFM5+nZVDrqCYtz8ETmBCWgrfl3y6na6B9Hb5tD+OGqtuYF4+wB2HL10B7IRdbuvMV
         TrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pXcdDuiuS0rutkUwk71fnGMqxWY4G5EzmmfpZg3Ru24=;
        b=dgsnrkBPMXLIyE4WPEWTTDrAvGnd+JTEA399cJLLURdZjht7PlZAjKumSj/gpteLGD
         AGncVrGnPjjAxFnK800f1lLDUTnwhl+A2YflOKDHJN8cU+MSsqkDIObh/RfIgAOMCRRz
         mYDUP4NUKRhUMMaitB5J1Xe6NGU/HY7PYfy1Ycctb5nMHjX+Y2nHh/wadFLC9mrv7p2k
         HV4EVbBAcEA6DAwp/gEzoyT63M1YO+nuRHn1P966KcrUTX7I981rBLOHCBSpWQxHretc
         xF3svTO0Tfcu6LuDz3X/xcvkRvWZIKucG7hf/7qaznJA3JJc8zPwYVpUh07T9uFwI593
         fRyw==
X-Gm-Message-State: AOAM532tAp3a8u1+DfM4npg0AmAhh6nTN2FWsj/PtxvziFo3z21nz/1H
        mYA6pEuctruO2Iww+eblPrspN1H+z47jdQ==
X-Google-Smtp-Source: ABdhPJzhYl0W9TB6Vi32HlpEorKkavrs/+7L/VaknVaYfkbf45BBbBzvIfjcG4jL/1HljuVYohmZSQ==
X-Received: by 2002:a05:6214:533:: with SMTP id x19mr20253qvw.20.1610470936765;
        Tue, 12 Jan 2021 09:02:16 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id b15sm1417388qta.75.2021.01.12.09.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:02:10 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:02:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 20/20] pack-revindex.c: avoid direct revindex access in
 'offset_to_pack_pos()'
Message-ID: <X/3WDArP4zrdd0S2@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <eada1ffcfafc3fb57de80626e368672cb8b22318.1610129796.git.me@ttaylorr.com>
 <X/1txTIxV4pYt0Xo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1txTIxV4pYt0Xo@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 04:37:09AM -0500, Jeff King wrote:
> This definitely makes sense in the long run. I could take or leave it as
> a final patch in _this_ series (as opposed to the first patch in a
> subsequent series adding the rev files).
>
> >  	do {
> >  		const unsigned mi = lo + (hi - lo) / 2;
> > -		if (revindex[mi].offset == ofs) {
> > +		off_t got = pack_pos_to_offset(p, mi);
>
>
> They're both constant-time, so performance should be the same big-O. The
> function has extra BUG() checks. I doubt those are measurable in
> practice, though.

Funny enough, I have moved this patch between the two so many times
before submitting this. I tend to agree that I don't think it makes a
difference in which series this patch goes, so I'm just as happy to
leave it where it is and stop thinking about it ;-).

If others have strong feelings, this can be dropped when queuing and
I'll send it along as the first commit in the second series (which will
have to be updated along with this one).

> -Peff

Thanks,
Taylor
