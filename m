Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344A720248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCCRpE (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:45:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:36714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726520AbfCCRpD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:45:03 -0500
Received: (qmail 13806 invoked by uid 109); 3 Mar 2019 17:45:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 17:45:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16645 invoked by uid 111); 3 Mar 2019 17:45:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 12:45:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 12:45:01 -0500
Date:   Sun, 3 Mar 2019 12:45:01 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] tests: introduce --stress-jobs=<N>
Message-ID: <20190303174501.GG23811@sigill.intra.peff.net>
References: <pull.155.git.gitgitgadget@gmail.com>
 <pull.155.v2.git.gitgitgadget@gmail.com>
 <074628c22b2df82280b06db604196f25300e8f87.1551624293.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <074628c22b2df82280b06db604196f25300e8f87.1551624293.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 03, 2019 at 06:44:55AM -0800, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ab7f27ec6a..6e557982a2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -142,10 +142,16 @@ do
>  	--stress)
>  		stress=t ;;
>  	--stress=*)
> +		echo "error: --stress does not accept an argument: '$opt'" >&2
> +		echo "did you mean --stress-jobs=${opt#*=} or --stress-limit=${opt#*=}?" >&2
> +		exit 1

This seems reasonable. I was all set to argue that "--stress-limit" is
much more common than "--stress-jobs", but I see Gábor just made the
opposite argument. So maybe just informing the user is the right thing. :)

-Peff
