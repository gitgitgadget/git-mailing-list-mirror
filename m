Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2B720248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfCCRHD (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:07:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:36566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726423AbfCCRHA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:07:00 -0500
Received: (qmail 13342 invoked by uid 109); 3 Mar 2019 17:07:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 17:07:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16400 invoked by uid 111); 3 Mar 2019 17:07:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 12:07:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 12:06:58 -0500
Date:   Sun, 3 Mar 2019 12:06:58 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190303170658.GA23811@sigill.intra.peff.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-1-tmz@pobox.com>
 <20190301183017.GB30847@sigill.intra.peff.net>
 <20190301221551.GD31362@zaya.teonanacatl.net>
 <xmqqef7q6pm1.fsf@gitster-ct.c.googlers.com>
 <20190302024011.GF31362@zaya.teonanacatl.net>
 <20190302040704.GN19739@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190302040704.GN19739@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 02, 2019 at 05:07:04AM +0100, SZEDER Gábor wrote:

> The completion script used to cache the list of porcelain commands,
> but then Duy came along and removed it in 3301d36b29 (completion: add
> and use --list-cmds=alias, 2018-05-20).
> [...]

Thanks for this summary.

Just for the record, as the person who suggested that we should respect
repo config here, I don't personally care all that much either way. I do
not plan to use the feature myself, but it was just what I would have
expected to happen. So I can live with it either way.

That said, it seems like if we were to go back to caching, we'd need to
handle directory changes in order for aliases (which already do respect
repo config) to be correct anyway. So it doesn't seem like this is
introducing any burden that was not there already.

-Peff
