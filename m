Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455C21F404
	for <e@80x24.org>; Thu,  1 Mar 2018 14:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031514AbeCAOtp (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 09:49:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:42918 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1031346AbeCAOto (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 09:49:44 -0500
Received: (qmail 4346 invoked by uid 109); 1 Mar 2018 14:49:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Mar 2018 14:49:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17467 invoked by uid 111); 1 Mar 2018 14:50:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Mar 2018 09:50:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2018 09:49:42 -0500
Date:   Thu, 1 Mar 2018 09:49:42 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 07/11] pack-objects: move in_pack out of struct
 object_entry
Message-ID: <20180301144942.GA837@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
 <20180301091052.32267-8-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180301091052.32267-8-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 01, 2018 at 04:10:48PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
> pack. Use an index isntead since the number of packs should be
> relatively small.
> 
> This limits the number of packs we can handle to 256 (still
> unreasonably high for a repo to work well). If you have more than 256
> packs, you'll need an older version of Git to repack first.

I overall like the direction of this series, but I think this one is
just too much. While you definitely shouldn't have a ton of packs, this
leaves the user with no real escape hatch. And 256 isn't actually that
many packs.

-Peff
