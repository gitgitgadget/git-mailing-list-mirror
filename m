Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313591F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439141AbeKWKZf (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 05:25:35 -0500
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107]:42850
        "EHLO p3plsmtpa08-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407880AbeKWKZe (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Nov 2018 05:25:34 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id PydNgPquhvis1PydPgmm9q; Thu, 22 Nov 2018 16:43:48 -0700
Date:   Fri, 23 Nov 2018 01:43:46 +0200
From:   Max Kirillov <max@max630.net>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>, max@max630.net,
        git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181122234346.GF5348@jessie.local>
References: <20181119101535.16538-1-carenas@gmail.com>
 <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net>
 <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
 <20181121224929.GD5348@jessie.local>
 <CAPUEspjeiT=Odc7ENd0Qjeg=8w-+Qh9uGjL+BQXihiK1G1vkjA@mail.gmail.com>
 <20181122063714.GE5348@jessie.local>
 <CAPUEsph7z3nHjJ=idq5v0RPPjWwmGGMsbmPoyUChxUitBPeEBQ@mail.gmail.com>
 <20181122161722.GC28192@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122161722.GC28192@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfGKgPh3NiwSqzGhSpq4z/HVIkt932aMc/w8dAWhTHRo/6cWX+6xEwG+dTDpJzFpgYDXD+OaS1Q1FSSFFMDnnxwUY63BOf7KdaU2CLQzqyXHmhnpCDEEL
 GhVXd/J/YP37MGPX8QqIY+Py1hwXQ5am63l242zm4btFOciCLqnU7QPpUFJYS5seNXKoGtHH498AS523RIi+QHNo/NUmOqalob1jryoPhEEdcsCG6BNH0v/J
 j4z3k4fnTxtXrgCuG6PAiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 11:17:22AM -0500, Jeff King wrote:
> The script I use is at:
> 
>   https://github.com/peff/git/blob/meta/stress
> 
> which you invoke like "/path/to/stress t5562" from the top-level of a
> git.git checkout.  It basically just runs a loop of twice as many
> simultaneous invocations of the test script as you have CPUs, and waits
> for one to fail. The load created by all of the runs tends to flush out
> timing effects after a while.
> 
> It fails for me on t5562 within 30 seconds or so (but note that in this
> particular case it sometimes takes a while to produce the final output
> because invoke-with-content-length misses the expected SIGCLD and sleeps
> the full 60 seconds).

I have observed it caught failure at the very first run.
However I could not fail t again. I tried running up to 20
instances, with 1 or 2 active cores (that's all I have
here), also edited the test to include only push_plain case,
and repeat it several times, to avoid running irrelevant
cases, the failure never happened again.

The first failure was a bit unusual, in the ouput actually
all tests were marked as passed, but it still failed
somehow. Unfortunately, I did not save the output.

I submitted the perl patch

-- 
Max
