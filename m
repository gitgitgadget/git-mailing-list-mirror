Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265121F403
	for <e@80x24.org>; Wed, 20 Jun 2018 12:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeFTMkJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 08:40:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:49456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751166AbeFTMkI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 08:40:08 -0400
Received: (qmail 20493 invoked by uid 109); 20 Jun 2018 12:40:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Jun 2018 12:40:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23894 invoked by uid 111); 20 Jun 2018 12:40:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Jun 2018 08:40:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2018 08:40:06 -0400
Date:   Wed, 20 Jun 2018 08:40:06 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
Subject: Re: t5562: gzip -k is not portable
Message-ID: <20180620124006.GB7932@sigill.intra.peff.net>
References: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
 <xmqqk1quvegh.fsf@gitster-ct.c.googlers.com>
 <CAPig+cT2xkR=LbAJLCdeynGkiPysakbVna61cfrtgO3kKh85+g@mail.gmail.com>
 <117d2657-067a-6fe6-3713-de7a5aa75a11@web.de>
 <20180619205310.GA30710@sigill.intra.peff.net>
 <20180620061306.GA7813@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620061306.GA7813@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 20, 2018 at 08:13:06AM +0200, Torsten Bögershausen wrote:

> Good eyes, thanks.
> The "-f -c" combo works:
> 
> -       gzip -k fetch_body &&
> +       gzip -f -c fetch_body >fetch_body.gz &&
>         test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
> -       gzip -k push_body &&
> +       gzip -f -c push_body >push_body.gz &&

Do we still need "-f"?  With "-c" gzip is only writing to stdout, so we
should not need to force anything.

-Peff
