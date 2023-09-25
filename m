Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D952CE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 12:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjIYMZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 08:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjIYMZo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 08:25:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AB6115
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 05:25:36 -0700 (PDT)
Received: (qmail 5099 invoked by uid 109); 25 Sep 2023 12:25:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Sep 2023 12:25:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12857 invoked by uid 111); 25 Sep 2023 12:25:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Sep 2023 08:25:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Sep 2023 08:25:35 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] Add a GitHub workflow to submit builds to
 Coverity Scan
Message-ID: <20230925122535.GB2118273@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 11:50:56AM +0000, Johannes Schindelin via GitGitGadget wrote:

> Changes since v1:
> 
>  * After verifying that cURL's --fail option does what we need in Coverity's
>    context, I switched to using that in every curl invocation.
>  * Adjusted quoting (the ${{ ... }} constructs do not require double quotes
>    because they are interpolated before the script is run).
>  * Touched up a few commit messages, based on the feedback I received.
>  * Addressed an actionlint [https://rhysd.github.io/actionlint/] warning.

Thanks, this looks fine to me.

The only other comment is the same one I made for Taylor's version: that
COVERITY_SCAN_EMAIL could probably be a "var" and not a "secret". Though
the main advantage there (besides it being a little easier for the user
to edit in the web UI) is that it could be used in the jobs.*.if context
(to skip the job in unconfigured repos). But since your "if" uses a
default-disallow when ENABLE_COVERITY_SCAN_FOR_BRANCHES is not set, it
is not that important to check COVERITY_SCAN_EMAIL.

-Peff
