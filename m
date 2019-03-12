Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89592202BB
	for <e@80x24.org>; Tue, 12 Mar 2019 12:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCLMFx (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 08:05:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:47122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725873AbfCLMFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 08:05:52 -0400
Received: (qmail 27800 invoked by uid 109); 12 Mar 2019 12:05:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Mar 2019 12:05:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31828 invoked by uid 111); 12 Mar 2019 12:06:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Mar 2019 08:06:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2019 08:05:50 -0400
Date:   Tue, 12 Mar 2019 08:05:50 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] repack: enable bitmaps by default on bare repos
Message-ID: <20190312120550.GA7020@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190312104954.GA2023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 06:49:54AM -0400, Jeff King wrote:

> I'm not sure what we're trying to accomplish with this unpacking,
> though. Running "git repack -ad" should generate bitmaps whether the
> objects were already in a single pack or not. So I think this test can
> just be:
> 
>   git clone --bare . bare.git &&
>   git -C bare.git repack -ad &&
>   bitmap=$(ls objects/pack/*.bitmap)
>   test_path_is_file "$bitmap"

Of course that should be "bare.git/objects/pack/*.bitmap" in the third
line, since we skipped the "cd" entirely.

-Peff
