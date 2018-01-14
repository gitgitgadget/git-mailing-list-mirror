Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F17431F406
	for <e@80x24.org>; Sun, 14 Jan 2018 11:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeANLHh (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 06:07:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:43576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751143AbeANLHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 06:07:37 -0500
Received: (qmail 12787 invoked by uid 109); 14 Jan 2018 11:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 14 Jan 2018 11:07:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10966 invoked by uid 111); 14 Jan 2018 11:08:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 14 Jan 2018 06:08:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Jan 2018 06:07:34 -0500
Date:   Sun, 14 Jan 2018 06:07:34 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] travis-ci: build Git during the 'script' phase
Message-ID: <20180114110734.GA13643@sigill.intra.peff.net>
References: <20180108172214.23615-1-szeder.dev@gmail.com>
 <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
 <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>
 <CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com>
 <20180113103255.GA31117@sigill.intra.peff.net>
 <CAM0VKj=QrDr9671uMGKSSZUczB-Soc5mmoijiBsx8t_WkQa6+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=QrDr9671uMGKSSZUczB-Soc5mmoijiBsx8t_WkQa6+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 14, 2018 at 11:37:07AM +0100, SZEDER Gábor wrote:

> > +fold_cmd () {
> > +       local name=$1; shift
> > +       fold "$name"
> > +       "$@"
> > +       local ret=$?
> > +       unfold "$name"
> > +       return $ret
> > +}
> 
> We don't have to fiddle with the return value, because we run (almost
> all of) our build scripts with 'set -e', i.e. if the command fails then
> the script will exit immediately.

Yeah, that's probably enough for our simple scripts, though I have been
bit by "set -e" vagaries before (e.g., calling the function inside a
conditional block).

-Peff
