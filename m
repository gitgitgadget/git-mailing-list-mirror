Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C471F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfBUNXI (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:23:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:52494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725823AbfBUNXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:23:08 -0500
Received: (qmail 20129 invoked by uid 109); 21 Feb 2019 13:23:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 13:23:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12100 invoked by uid 111); 21 Feb 2019 13:23:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 08:23:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 08:23:06 -0500
Date:   Thu, 21 Feb 2019 08:23:06 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Konstantin Kharlamov <hi-angel@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree add: sanitize worktree names
Message-ID: <20190221132306.GD20536@sigill.intra.peff.net>
References: <1550500586.2865.0@yandex.ru>
 <20190221110026.23135-1-pclouds@gmail.com>
 <1550748525.30307.1@yandex.ru>
 <CACsJy8AERM==LunYTszUf1Fb-uHPZLjkSE5x1T=0Ueqsvq3F_A@mail.gmail.com>
 <1550749488.30307.2@yandex.ru>
 <CACsJy8CWH-b18uaRvn-bXdsRbn+6QnJ6GNekqG2khGeJUa8S3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CWH-b18uaRvn-bXdsRbn+6QnJ6GNekqG2khGeJUa8S3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 06:52:05PM +0700, Duy Nguyen wrote:

> > the postfix internally, but why can't it be okay with "name.lock.lock")
> 
> Uh oh I miss this case. I only delete ".lock" once, "name.lock" would
> still be rejected. Thanks for noticing.

Another tricky case is "refs/heads/foo.lock/bar.lock", which would need
both ".lock"s removed. I think your v2 handles this correctly, though
(because it disallows "." entirely).

-Peff
