Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838F41F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbcHARnU (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:43:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:52609 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754677AbcHARnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:43:19 -0400
Received: (qmail 8326 invoked by uid 102); 1 Aug 2016 17:43:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:43:19 -0400
Received: (qmail 15132 invoked by uid 107); 1 Aug 2016 17:43:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:43:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 13:43:16 -0400
Date:	Mon, 1 Aug 2016 13:43:16 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160801174316.4boo4slop77mtry4@sigill.intra.peff.net>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
 <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
 <20160729001618.GA9646@sigill.intra.peff.net>
 <20160729020801.GA14892@x>
 <20160729225800.GA23268@sigill.intra.peff.net>
 <20160730045055.e3t6tpgi6zch4epo@x>
 <20160730054742.iwmr4pavdy5z73rw@sigill.intra.peff.net>
 <xmqqfuqol7dx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuqol7dx.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 10:35:22AM -0700, Junio C Hamano wrote:

> > I do have to admit that after reading through the "format.*" section of
> > git-config(1), there is quite a bit that is configurable in it. So
> > perhaps we do not need to be as careful about behavior changes as I
> > thought.
> 
> I am not sure how the first sentence (which I agree with; a random
> user can have quite a different behaviour configured when the
> command is run without any option) leads to the conclusion in the
> second sentence.  The user can break assumptions made by a tool that
> reads format-patch output by tweaking his config but at least he
> knows that he changed the configuration, i.e. the breakage can be
> explained and attributed to his own action.  The change in the
> default is somewhat different.

I half-agree. Config that causes unpredictable behavior can break
somebody else's script that you are running. If you say "oh, I guess I
shouldn't set that config" and move on with your life, then the config
hasn't really hurt anybody. If you complain to the script author that
their script is broken, and insist that they pass the --no-foo option,
then the script writer does not care much whether it was a config option
or a change of default.

-Peff

PS We also changed the default pager behavior for format-patch recently,
   though I can't actually think of any script regressions that would
   cause, since it only kicks in when output is going to the tty.
