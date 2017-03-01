Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2970E2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 01:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbdCBBKa (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 20:10:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:36870 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753929AbdCBBK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 20:10:28 -0500
Received: (qmail 7875 invoked by uid 109); 1 Mar 2017 19:43:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 19:43:42 +0000
Received: (qmail 7352 invoked by uid 111); 1 Mar 2017 19:43:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 14:43:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Mar 2017 14:43:40 -0500
Date:   Wed, 1 Mar 2017 14:43:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Adrian Dudau <Adrian.Dudau@enea.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] pretty: use fmt_output_email_subject()
Message-ID: <20170301194340.5phhr7lqdqiji277@sigill.intra.peff.net>
References: <1488297556.2955.11.camel@enea.com>
 <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
 <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de>
 <xmqqfuiwhnud.fsf@gitster.mtv.corp.google.com>
 <20170301193210.tgvnjgc2hfaeebqf@sigill.intra.peff.net>
 <CAPc5daUyu_=5GeGqBAG_KvkZFE_0oD6Wa_HhoRQwZ2ANUwOF+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daUyu_=5GeGqBAG_KvkZFE_0oD6Wa_HhoRQwZ2ANUwOF+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 11:38:57AM -0800, Junio C Hamano wrote:

> On Wed, Mar 1, 2017 at 11:32 AM, Jeff King <peff@peff.net> wrote:
> > I would think that future callers would just need to provide a dummy
> > pp->rev. I guess that logic could be pushed down into
> > fmt_output_email_subject(), so that it skips looking at
> > opt->subject_prefix, etc, when "opt" is NULL, and just hits the
> > "Subject:" case arm.
> 
> The "flexibility" I was wondering about is that the current .subject can
> point at any caller-supplied string, not "Subject:".

Ah, I see. I don't think that is a huge loss, as nobody was using it.
And "Subject:" is already hard-coded in the nr/total counting bits,
which are what you'd want to reuse. I think it is fine to punt to the
future. If somebody really wants it later, the right fix is for them to
provide a string that fmt_output_email_subject() would use in place of
"Subject:" when it adds to the strbuf.

-Peff
