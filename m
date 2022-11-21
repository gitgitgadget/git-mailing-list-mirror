Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA73C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 18:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKUSSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 13:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUSSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 13:18:14 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD4222A7
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:18:13 -0800 (PST)
Received: (qmail 12309 invoked by uid 109); 21 Nov 2022 18:18:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 18:18:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26049 invoked by uid 111); 21 Nov 2022 18:18:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 13:18:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 13:18:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v2 1/2] git-jump: add an optional argument 'stdout'
Message-ID: <Y3vA5Jc3f84YIoYw@coredump.intra.peff.net>
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
 <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
 <e56858a3eb212dcd0b8f71bdbf8db96f51c5d648.1668907644.git.gitgitgadget@gmail.com>
 <xmqqedtwyi94.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedtwyi94.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 02:43:51PM +0900, Junio C Hamano wrote:

> the command line structure of "git jump" being
> 
>     git jump <mode> [<args>]
> 
> where <mode> is one of 'diff', 'merge', 'grep', it somehow feels
> very strange to insert an optional new word, that is not a dashed
> option, before the <mode>.  "git jump --stdout diff" might be less
> surprising, but I dunno.

FWIW, I had the same reaction: it should be --stdout.

> But I think this is a good idea.  In fact, it almost feels that the
> interface to produce the list of "$file:$line: <blah>" that this
> "stdout" mode gives should have been in the command as the lowest
> level basic primitive, upon which the feature to drive a specific
> editor using such an output file should have been built, and the
> current code is backwards in that sense.  Exposing that lower level
> primitive directly is a welcome addition.

The main reason I didn't start with that primitive is because the
initial outputs were pretty simple and based around "grep -n" output.
But they've gotten a bit more complicated over time, especially the
"diff" one. I agree that just dumping the quickfix list is a good
feature to have.

-Peff
