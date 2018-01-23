Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F8F1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeAWAMR (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:12:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:53920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751128AbeAWAMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:12:16 -0500
Received: (qmail 11896 invoked by uid 109); 23 Jan 2018 00:12:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 00:12:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12705 invoked by uid 111); 23 Jan 2018 00:12:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Jan 2018 19:12:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2018 19:12:14 -0500
Date:   Mon, 22 Jan 2018 19:12:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] format-patch: set diffstat width to 70 instead of
 default 80
Message-ID: <20180123001214.GC26357@sigill.intra.peff.net>
References: <20180122123154.8301-1-pclouds@gmail.com>
 <20180122235202.GA26357@sigill.intra.peff.net>
 <87po61h1to.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87po61h1to.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 01:10:43AM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Mon, Jan 22 2018, Jeff King jotted:
> 
> > On Mon, Jan 22, 2018 at 07:31:54PM +0700, Nguyễn Thái Ngọc Duy wrote:
> >> +	opts.diffopt.stat_width = 70;
> >>
> >>  	diff_setup_done(&opts);
> >
> > I wondered how this should interact with any config, but I don't think
> > you can actually configure the stat-width. You _can_ configure
> > diff.statgraphwidth, though, which seems like a funny inconsistency.
> 
> Isn't the numeric argument to --stat (this works with/without this
> patch):
> 
>     $ git format-patch -10 --stdout --stat=30 -- t|grep -m 5 ' | '
>      ...submodule-update.sh | 1 +
>      ...ule-update.sh | 14 ++++++
>      ...-addresses.sh | 27 ---
>      t/t9000/test.pl  | 67 ------
>      ...send-email.sh | 19 ++++++
>     $ git format-patch -10 --stdout --stat=90 -- t|grep -m 5 ' | '
>      t/lib-submodule-update.sh | 1 +
>      t/lib-submodule-update.sh | 14 ++++++++++++++
>      t/t9000-addresses.sh | 27 -------------------------
>      t/t9000/test.pl      | 67 --------------------------------------------------------------
>      t/t9001-send-email.sh | 19 +++++++++++++++++++

Yeah, I meant by actual on-disk config. I didn't actually look at the
patch closely, but I assumed that "format-patch --stat=90" would still
override this (if not, then I think that would be a bug).

-Peff
