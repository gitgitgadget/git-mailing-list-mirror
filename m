Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1BE1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeARWsR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:48:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:48696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932357AbeARWsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:48:16 -0500
Received: (qmail 22281 invoked by uid 109); 18 Jan 2018 22:48:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Jan 2018 22:48:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16189 invoked by uid 111); 18 Jan 2018 22:48:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Jan 2018 17:48:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jan 2018 17:48:14 -0500
Date:   Thu, 18 Jan 2018 17:48:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff: add --compact-summary option to complement
 --stat
Message-ID: <20180118224814.GA8473@sigill.intra.peff.net>
References: <20180113132211.13350-1-pclouds@gmail.com>
 <20180118100546.32251-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180118100546.32251-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 05:05:46PM +0700, Nguyễn Thái Ngọc Duy wrote:

> This is partly inspired by gerrit web interface which shows diffstat
> like this, e.g. with commit 0433d533f1 (notice the "A" column on the
> third line):
> 
>      Documentation/merge-config.txt     |  4 +
>      builtin/merge.c                    |  2 +
>    A t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++
>      t/t7612-merge-verify-signatures.sh | 45 ++++++++++
>    4 files changed, 132 insertions(+)

I like the general concept. Perusing "git log" output, though, it felt
like the summary column was very close to the filenames. What do you
think of putting it after the "|", where it is only close to a number?

Something like the patch below (on top of yours, but it probably needs
tweaked further for graph_width), which gives:

   t/t5573-pull-verify-signatures.sh | A+x  78 ++++++++++++++++++++++++++++

(I know this is a bikeshed, so I'm perfectly willing to take "yuck, I
don't like that as well" as a response).

> The new option --compact-summary implements this with a tweak to support
> mode change, which is shown in --summary too.

One thing I noticed is that --compact-summary by itself does nothing.
Should it imply --stat?

-Peff
