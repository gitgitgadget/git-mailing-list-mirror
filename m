Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F6D20C32
	for <e@80x24.org>; Thu,  7 Dec 2017 00:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdLGAWh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:22:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:50388 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751610AbdLGAWh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:22:37 -0500
Received: (qmail 318 invoked by uid 109); 7 Dec 2017 00:22:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Dec 2017 00:22:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16284 invoked by uid 111); 7 Dec 2017 00:22:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 06 Dec 2017 19:22:57 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Dec 2017 19:22:35 -0500
Date:   Wed, 6 Dec 2017 19:22:35 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git commit file completion recently broke
Message-ID: <20171207002234.GA21003@sigill.intra.peff.net>
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
 <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 06, 2017 at 04:01:51PM -0800, Jacob Keller wrote:

> I think I narrowed this down to "git diff-index --name-only --relative
> HEAD" producing a list of files *not* relative to the current
> directory.

Hmm, my guess would have been something funny in the setup code
forgetting our original prefix.

But nope, it looks like the culprit is f7923a5ece (diff: use
skip_to_optional_val(), 2017-12-04), which switched over parsing of
"--relative".

-Peff
