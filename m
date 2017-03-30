Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F03C20966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934879AbdC3UGf (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:06:35 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36649 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934850AbdC3UGa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:06:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6so13803260wre.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O/G/rLIvTkFXIdWreSJF7DW9+HZumTf54jfjeqUDOeU=;
        b=H9GZUV1tEWN2lU8G+jZzMmddC0Lhlj5PAXdj6Irwkf39LJ4iugxa/PwF25YS+F42WE
         wVIgZRn4zetrxzOepLf7qulJG4XqsjE825YYBxA5rlBSSoAq+JOvy0tqnCARz6N+m9JL
         hhRKsKZHmplHhYtGucbBwtYxAsZEhpk9AcNhFae4Z3AhLvPb22Nv+ML7K+LnZdkdNX0M
         Pw4XqMqX0zCj+8soqFH4PmFUqZoHG7cokS9vXDH7zW4GZ/eyzXW6h7SYU1gZOfXy9Ita
         u43kAwci3LdyYh/IKL0q60N4pP1GUb6a6KBxaOXSQ1kCWVf8/Elm+V4VRvUBjNLbpEv6
         ZyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O/G/rLIvTkFXIdWreSJF7DW9+HZumTf54jfjeqUDOeU=;
        b=UFjHwleni+eAIN1yDbZVo2Xex3Hvcup6QUghT7q/M8jLEKJ5py8ubFubqVCGM05doC
         JbPpKdUray1gGyrUVj94/W7FP0Nk+xvTGT2FE9QBt+Op9DkEEmhlXmTubGFcVEVJuC5g
         mhCqpkXZjA8ElUlg4htbr6fwG2bFnguOo5Ehtyu6d1Y5ARI36OBAv38S6kgxVg5Qipnd
         yAE10AXE0XGpka1+ACjaz6cCYUGsTdkIQfPJjhFhGGxWeI5OKFhX+qXMTuQB6tiQB/qU
         EkqUIJpuBvdeXPiJ+OmUqiQ5+lDSVLVWwKFZrLFJ3umher4HWQND7hflXyTBPKvlazf2
         h+Zg==
X-Gm-Message-State: AFeK/H2QFTUpr6lUQmRK56YGSTJMn8Kbg0EpklunbEbPksfvTJtRaoE7+mOHNhQG39/5Ig==
X-Received: by 10.223.178.182 with SMTP id g51mr1341521wrd.12.1490904382779;
        Thu, 30 Mar 2017 13:06:22 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id x131sm145728wme.28.2017.03.30.13.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2017 13:06:22 -0700 (PDT)
Date:   Thu, 30 Mar 2017 21:06:48 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background
 thread
Message-ID: <20170330200648.GH27158@hank>
References: <20170328190732.59486-1-git@jeffhostetler.com>
 <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
 <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
 <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/28, Jeff King wrote:
> On Tue, Mar 28, 2017 at 03:50:34PM -0400, Jeff Hostetler wrote:
> 
> > It was a convenient way to isolate, average, and compare
> > read_index() times, but I suppose we could do something
> > like that.
> > 
> > I did confirm that a ls-files does show a slight 0.008
> > second difference on the 58K file Linux tree when toggled
> > on or off.
> 
> Yeah, I agree it helps isolate the change. I'm just not sure we want to
> carry a bunch of function-specific perf-testing code. And one of the
> nice things about testing a real command is that it's...a real command.
> So it's an actual improvement a user might see.
> 
> > But I'm tempted to suggest that we just omit my helper exe
> > and not worry about a test -- since we don't have any test
> > repos large enough to really demonstrate the differences.
> > My concern is that that 0.008 would be lost in the noise
> > of the rest of the test and make for an unreliable result.
> 
> Yeah, I think that would be fine. You _could_ write a t/perf test and
> then use your 400MB monstrosity as GIT_PERF_LARGE_REPO. But given that
> most people don't have such a thing, there's not much value over you
> just showing off the perf improvement in the commit message.

Sorry if this was already discussed, but we already do have a perf
test for the index (p0002), and a corresponding helper program which
just does read_cache() and discard_cache().  Maybe we could re-use
that and add a second test running the same using the new config?

> We could also have a t/perf test that generates a monstrous index and
> shows that it's faster. But frankly, I don't think this is all that
> interesting as a performance regression test. It's not like there's
> something subtle about the performance improvement; we stopped computing
> the SHA-1, and (gasp!) it takes exactly one SHA-1 computation's less
> time.
> 
> So just mentioning the test case and the improvement in the commit
> message is sufficient, IMHO.
> 
> -Peff
