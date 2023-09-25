Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F3CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 12:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjIYMRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 08:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjIYMRS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 08:17:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCB0B8
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 05:17:11 -0700 (PDT)
Received: (qmail 5036 invoked by uid 109); 25 Sep 2023 12:17:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Sep 2023 12:17:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12798 invoked by uid 111); 25 Sep 2023 12:17:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Sep 2023 08:17:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Sep 2023 08:17:10 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/6] coverity: detect and report when the token or
 project is incorrect
Message-ID: <20230925121710.GA2118273@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <458bc2ea91faf88a3e1d21945f12f314d1a7b78e.1695379323.git.gitgitgadget@gmail.com>
 <20230923070735.GC1471672@coredump.intra.peff.net>
 <f1c818a8-5b18-58f5-ec42-45eb8ad3e00b@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1c818a8-5b18-58f5-ec42-45eb8ad3e00b@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 01:52:56PM +0200, Johannes Schindelin wrote:

> > > Let's detect that scenario and provide a helpful error message instead
> > > of trying to go forward with an empty string instead of the correct MD5.
> >
> > Ah. :) I think using "curl --fail" is probably a simpler solution here.
> 
> Apart from the unintuitive error message. I myself was puzzled and
> struggled quite a few times until I realized that it was not the token
> that was incorrect, but the project name.
> 
> To help people with a similar mental capacity to my own, I would therefore
> really want to keep this here patch.
> 
> As a compromise, I will switch to using `--fail` and then looking at the
> exit code (with 22 indicating authentication issues).

Oh, I do not at all mind de-mystifying the error message for the user. I
mostly meant that using --fail would be better than scraping the http
code from the header file. Though as you note, I guess we have to
interpret the exit code in this case anyway, so it is not that much of a
simplification.

-Peff
